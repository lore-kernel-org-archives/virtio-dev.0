Return-Path: virtio-dev-return-3731-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 73B0B58191D5
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Apr 2018 14:08:26 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  5 Apr 2018 14:08:23 -0700
Message-Id: <1522962503-3963-5-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v5 4/4] netvsc: refactor notifier/event handling code to use the bypass framework
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

Use the registration/notification framework supported by the generic
bypass infrastructure.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/hyperv/Kconfig      |   1 +
 drivers/net/hyperv/netvsc_drv.c | 219 ++++++++++++----------------------------
 2 files changed, 63 insertions(+), 157 deletions(-)

diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index 936968d23559..cc3a721baa18 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -1,5 +1,6 @@
 config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
+	depends on MAY_USE_BYPASS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ecc84954c511..b53a2be99bd2 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -43,6 +43,7 @@
 #include <net/pkt_sched.h>
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
+#include <net/bypass.h>
 
 #include "hyperv_net.h"
 
@@ -1763,46 +1764,6 @@ static void netvsc_link_change(struct work_struct *w)
 	rtnl_unlock();
 }
 
-static struct net_device *get_netvsc_bymac(const u8 *mac)
-{
-	struct net_device *dev;
-
-	ASSERT_RTNL();
-
-	for_each_netdev(&init_net, dev) {
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
-
-		if (ether_addr_equal(mac, dev->perm_addr))
-			return dev;
-	}
-
-	return NULL;
-}
-
-static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)
-{
-	struct net_device *dev;
-
-	ASSERT_RTNL();
-
-	for_each_netdev(&init_net, dev) {
-		struct net_device_context *net_device_ctx;
-
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
-
-		net_device_ctx = netdev_priv(dev);
-		if (!rtnl_dereference(net_device_ctx->nvdev))
-			continue;	/* device is removed */
-
-		if (rtnl_dereference(net_device_ctx->vf_netdev) == vf_netdev)
-			return dev;	/* a match */
-	}
-
-	return NULL;
-}
-
 /* Called when VF is injecting data into network stack.
  * Change the associated network device from VF to netvsc.
  * note: already called with rcu_read_lock
@@ -1825,43 +1786,19 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_ANOTHER;
 }
 
-static int netvsc_vf_join(struct net_device *vf_netdev,
-			  struct net_device *ndev)
+static int netvsc_vf_join(struct net_device *ndev,
+			  struct net_device *vf_netdev)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
-	int ret;
-
-	ret = netdev_rx_handler_register(vf_netdev,
-					 netvsc_vf_handle_frame, ndev);
-	if (ret != 0) {
-		netdev_err(vf_netdev,
-			   "can not register netvsc VF receive handler (err = %d)\n",
-			   ret);
-		goto rx_handler_failed;
-	}
-
-	ret = netdev_upper_dev_link(vf_netdev, ndev, NULL);
-	if (ret != 0) {
-		netdev_err(vf_netdev,
-			   "can not set master device %s (err = %d)\n",
-			   ndev->name, ret);
-		goto upper_link_failed;
-	}
-
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
 
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
-	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
-
 	netdev_info(vf_netdev, "joined to %s\n", ndev->name);
-	return 0;
 
-upper_link_failed:
-	netdev_rx_handler_unregister(vf_netdev);
-rx_handler_failed:
-	return ret;
+	dev_hold(vf_netdev);
+	rcu_assign_pointer(ndev_ctx->vf_netdev, vf_netdev);
+
+	return 0;
 }
 
 static void __netvsc_vf_setup(struct net_device *ndev,
@@ -1914,85 +1851,84 @@ static void netvsc_vf_setup(struct work_struct *w)
 	rtnl_unlock();
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *ndev,
+			      struct net_device *vf_netdev)
 {
-	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
 
-	if (vf_netdev->addr_len != ETH_ALEN)
-		return NOTIFY_DONE;
-
-	/*
-	 * We will use the MAC address to locate the synthetic interface to
-	 * associate with the VF interface. If we don't find a matching
-	 * synthetic interface, move on.
-	 */
-	ndev = get_netvsc_bymac(vf_netdev->perm_addr);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
 	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
-		return NOTIFY_DONE;
-
-	if (netvsc_vf_join(vf_netdev, ndev) != 0)
-		return NOTIFY_DONE;
+		return -EEXIST;
 
 	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
 
-	dev_hold(vf_netdev);
-	rcu_assign_pointer(net_device_ctx->vf_netdev, vf_netdev);
-	return NOTIFY_OK;
+	return 0;
 }
 
 /* VF up/down change detected, schedule to change data path */
-static int netvsc_vf_changed(struct net_device *vf_netdev)
+static int netvsc_vf_changed(struct net_device *ndev,
+			     struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
-	struct net_device *ndev;
 	bool vf_is_up = netif_running(vf_netdev);
 
-	ndev = get_netvsc_byref(vf_netdev);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
 	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
 	if (!netvsc_dev)
-		return NOTIFY_DONE;
+		return -EINVAL;
 
 	netvsc_switch_datapath(ndev, vf_is_up);
 	netdev_info(ndev, "Data path switched %s VF: %s\n",
 		    vf_is_up ? "to" : "from", vf_netdev->name);
 
-	return NOTIFY_OK;
+	return 0;
 }
 
-static int netvsc_unregister_vf(struct net_device *vf_netdev)
+static int netvsc_release_vf(struct net_device *ndev,
+			     struct net_device *vf_netdev)
 {
-	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
 
-	ndev = get_netvsc_byref(vf_netdev);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
+	if (vf_netdev != rtnl_dereference(net_device_ctx->vf_netdev))
+		return -EINVAL;
+
 	cancel_delayed_work_sync(&net_device_ctx->vf_takeover);
 
+	return 0;
+}
+
+static int netvsc_unregister_vf(struct net_device *ndev,
+				struct net_device *vf_netdev)
+{
+	struct net_device_context *net_device_ctx;
+
+	net_device_ctx = netdev_priv(ndev);
+	if (vf_netdev != rtnl_dereference(net_device_ctx->vf_netdev))
+		return -EINVAL;
+
 	netdev_info(ndev, "VF unregistering: %s\n", vf_netdev->name);
 
-	netdev_rx_handler_unregister(vf_netdev);
-	netdev_upper_dev_unlink(vf_netdev, ndev);
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
 
-	return NOTIFY_OK;
+	return 0;
 }
 
+static const struct bypass_ops netvsc_bypass_ops = {
+	.register_child		= netvsc_register_vf,
+	.join_child		= netvsc_vf_join,
+	.unregister_child	= netvsc_unregister_vf,
+	.release_child		= netvsc_release_vf,
+	.update_link		= netvsc_vf_changed,
+	.handle_frame		= netvsc_vf_handle_frame,
+};
+
+static struct bypass *netvsc_bypass;
+
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -2082,8 +2018,14 @@ static int netvsc_probe(struct hv_device *dev,
 		goto register_failed;
 	}
 
+	ret = bypass_register_instance(netvsc_bypass, net);
+	if (ret != 0)
+		goto err_bypass;
+
 	return ret;
 
+err_bypass:
+	unregister_netdev(net);
 register_failed:
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
@@ -2124,13 +2066,15 @@ static int netvsc_remove(struct hv_device *dev)
 	rtnl_lock();
 	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
 	if (vf_netdev)
-		netvsc_unregister_vf(vf_netdev);
+		bypass_unregister_child(vf_netdev);
 
 	if (nvdev)
 		rndis_filter_device_remove(dev, nvdev);
 
 	unregister_netdevice(net);
 
+	bypass_unregister_instance(netvsc_bypass, net);
+
 	rtnl_unlock();
 	rcu_read_unlock();
 
@@ -2157,61 +2101,21 @@ static struct  hv_driver netvsc_drv = {
 	.remove = netvsc_remove,
 };
 
-/*
- * On Hyper-V, every VF interface is matched with a corresponding
- * synthetic interface. The synthetic interface is presented first
- * to the guest. When the corresponding VF instance is registered,
- * we will take care of switching the data path.
- */
-static int netvsc_netdev_event(struct notifier_block *this,
-			       unsigned long event, void *ptr)
-{
-	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
-
-	/* Skip our own events */
-	if (event_dev->netdev_ops == &device_ops)
-		return NOTIFY_DONE;
-
-	/* Avoid non-Ethernet type devices */
-	if (event_dev->type != ARPHRD_ETHER)
-		return NOTIFY_DONE;
-
-	/* Avoid Vlan dev with same MAC registering as VF */
-	if (is_vlan_dev(event_dev))
-		return NOTIFY_DONE;
-
-	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
-	case NETDEV_UNREGISTER:
-		return netvsc_unregister_vf(event_dev);
-	case NETDEV_UP:
-	case NETDEV_DOWN:
-		return netvsc_vf_changed(event_dev);
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static struct notifier_block netvsc_netdev_notifier = {
-	.notifier_call = netvsc_netdev_event,
-};
-
 static void __exit netvsc_drv_exit(void)
 {
-	unregister_netdevice_notifier(&netvsc_netdev_notifier);
 	vmbus_driver_unregister(&netvsc_drv);
+	bypass_unregister_driver(netvsc_bypass);
 }
 
 static int __init netvsc_drv_init(void)
 {
 	int ret;
 
+	netvsc_bypass = bypass_register_driver(&netvsc_bypass_ops,
+					       &device_ops);
+	if (!netvsc_bypass)
+		return -ENOMEM;
+
 	if (ring_size < RING_SIZE_MIN) {
 		ring_size = RING_SIZE_MIN;
 		pr_info("Increased ring_size to %u (min allowed)\n",
@@ -2221,10 +2125,11 @@ static int __init netvsc_drv_init(void)
 	netvsc_ring_reciprocal = reciprocal_value(netvsc_ring_bytes);
 
 	ret = vmbus_driver_register(&netvsc_drv);
-	if (ret)
+	if (ret) {
+		bypass_unregister_driver(netvsc_bypass);
 		return ret;
+	}
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
 }
 
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

