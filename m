Return-Path: virtio-dev-return-3355-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E690458191C6
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 12:08:46 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  1 Mar 2018 12:08:43 -0800
Message-Id: <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, jiri@resnulli.us, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch enables virtio_net to switch over to a VF datapath when a VF
netdev is present with the same MAC address. It allows live migration
of a VM with a direct attached VF without the need to setup a bond/team
between a VF and virtio net device in the guest.

The hypervisor needs to enable only one datapath at any time so that
packets don't get looped back to the VM over the other datapath. When a VF
is plugged, the virtio datapath link state can be marked as down. The
hypervisor needs to unplug the VF device from the guest on the source host
and reset the MAC filter of the VF to initiate failover of datapath to
virtio before starting the migration. After the migration is completed,
the destination hypervisor sets the MAC filter on the VF and plugs it back
to the guest to switch over to VF datapath.

When BACKUP feature is enabled, an additional netdev(bypass netdev) is
created that acts as a master device and tracks the state of the 2 lower
netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
passthru device with the same MAC is registered as 'active' netdev.

This patch is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/virtio_net.c | 683 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 682 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bcd13fe906ca..f2860d86c952 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -30,6 +30,8 @@
 #include <linux/cpu.h>
 #include <linux/average.h>
 #include <linux/filter.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
 #include <net/route.h>
 #include <net/xdp.h>
 
@@ -206,6 +208,9 @@ struct virtnet_info {
 	u32 speed;
 
 	unsigned long guest_offloads;
+
+	/* upper netdev created when BACKUP feature enabled */
+	struct net_device *bypass_netdev;
 };
 
 struct padded_vnet_hdr {
@@ -2236,6 +2241,22 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
+				      size_t len)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int ret;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_BACKUP))
+		return -EOPNOTSUPP;
+
+	ret = snprintf(buf, len, "_bkup");
+	if (ret >= len)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -2253,6 +2274,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
 	.ndo_xdp_flush		= virtnet_xdp_flush,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -2647,6 +2669,653 @@ static int virtnet_validate(struct virtio_device *vdev)
 	return 0;
 }
 
+/* START of functions supporting VIRTIO_NET_F_BACKUP feature.
+ * When BACKUP feature is enabled, an additional netdev(bypass netdev)
+ * is created that acts as a master device and tracks the state of the
+ * 2 lower netdevs. The original virtio_net netdev is registered as
+ * 'backup' netdev and a passthru device with the same MAC is registered
+ * as 'active' netdev.
+ */
+
+/* bypass state maintained when BACKUP feature is enabled */
+struct virtnet_bypass_info {
+	/* passthru netdev with same MAC */
+	struct net_device __rcu *active_netdev;
+
+	/* virtio_net netdev */
+	struct net_device __rcu *backup_netdev;
+
+	/* active netdev stats */
+	struct rtnl_link_stats64 active_stats;
+
+	/* backup netdev stats */
+	struct rtnl_link_stats64 backup_stats;
+
+	/* aggregated stats */
+	struct rtnl_link_stats64 bypass_stats;
+
+	/* spinlock while updating stats */
+	spinlock_t stats_lock;
+};
+
+static void virtnet_bypass_child_open(struct net_device *dev,
+				      struct net_device *child_netdev)
+{
+	int err = dev_open(child_netdev);
+
+	if (err)
+		netdev_warn(dev, "unable to open slave: %s: %d\n",
+			    child_netdev->name, err);
+}
+
+static int virtnet_bypass_open(struct net_device *dev)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *child_netdev;
+
+	netif_carrier_off(dev);
+	netif_tx_wake_all_queues(dev);
+
+	child_netdev = rtnl_dereference(vbi->active_netdev);
+	if (child_netdev)
+		virtnet_bypass_child_open(dev, child_netdev);
+
+	child_netdev = rtnl_dereference(vbi->backup_netdev);
+	if (child_netdev)
+		virtnet_bypass_child_open(dev, child_netdev);
+
+	return 0;
+}
+
+static int virtnet_bypass_close(struct net_device *dev)
+{
+	struct virtnet_bypass_info *vi = netdev_priv(dev);
+	struct net_device *child_netdev;
+
+	netif_tx_disable(dev);
+
+	child_netdev = rtnl_dereference(vi->active_netdev);
+	if (child_netdev)
+		dev_close(child_netdev);
+
+	child_netdev = rtnl_dereference(vi->backup_netdev);
+	if (child_netdev)
+		dev_close(child_netdev);
+
+	return 0;
+}
+
+static netdev_tx_t virtnet_bypass_drop_xmit(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	atomic_long_inc(&dev->tx_dropped);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static bool virtnet_bypass_xmit_ready(struct net_device *dev)
+{
+	return netif_running(dev) && netif_carrier_ok(dev);
+}
+
+static netdev_tx_t virtnet_bypass_start_xmit(struct sk_buff *skb,
+					     struct net_device *dev)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *xmit_dev;
+
+	/* Try xmit via active netdev followed by backup netdev */
+	xmit_dev = rcu_dereference_bh(vbi->active_netdev);
+	if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev)) {
+		xmit_dev = rcu_dereference_bh(vbi->backup_netdev);
+		if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev))
+			return virtnet_bypass_drop_xmit(skb, dev);
+	}
+
+	skb->dev = xmit_dev;
+	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
+
+	return dev_queue_xmit(skb);
+}
+
+static u16 virtnet_bypass_select_queue(struct net_device *dev,
+				       struct sk_buff *skb, void *accel_priv,
+				       select_queue_fallback_t fallback)
+{
+	/* This helper function exists to help dev_pick_tx get the correct
+	 * destination queue.  Using a helper function skips a call to
+	 * skb_tx_hash and will put the skbs in the queue we expect on their
+	 * way down to the bonding driver.
+	 */
+	u16 txq = skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
+
+	/* Save the original txq to restore before passing to the driver */
+	qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
+
+	if (unlikely(txq >= dev->real_num_tx_queues)) {
+		do {
+			txq -= dev->real_num_tx_queues;
+		} while (txq >= dev->real_num_tx_queues);
+	}
+
+	return txq;
+}
+
+/* fold stats, assuming all rtnl_link_stats64 fields are u64, but
+ * that some drivers can provide 32bit values only.
+ */
+static void virtnet_bypass_fold_stats(struct rtnl_link_stats64 *_res,
+				      const struct rtnl_link_stats64 *_new,
+				      const struct rtnl_link_stats64 *_old)
+{
+	const u64 *new = (const u64 *)_new;
+	const u64 *old = (const u64 *)_old;
+	u64 *res = (u64 *)_res;
+	int i;
+
+	for (i = 0; i < sizeof(*_res) / sizeof(u64); i++) {
+		u64 nv = new[i];
+		u64 ov = old[i];
+		s64 delta = nv - ov;
+
+		/* detects if this particular field is 32bit only */
+		if (((nv | ov) >> 32) == 0)
+			delta = (s64)(s32)((u32)nv - (u32)ov);
+
+		/* filter anomalies, some drivers reset their stats
+		 * at down/up events.
+		 */
+		if (delta > 0)
+			res[i] += delta;
+	}
+}
+
+static void virtnet_bypass_get_stats(struct net_device *dev,
+				     struct rtnl_link_stats64 *stats)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	const struct rtnl_link_stats64 *new;
+	struct rtnl_link_stats64 temp;
+	struct net_device *child_netdev;
+
+	spin_lock(&vbi->stats_lock);
+	memcpy(stats, &vbi->bypass_stats, sizeof(*stats));
+
+	rcu_read_lock();
+
+	child_netdev = rcu_dereference(vbi->active_netdev);
+	if (child_netdev) {
+		new = dev_get_stats(child_netdev, &temp);
+		virtnet_bypass_fold_stats(stats, new, &vbi->active_stats);
+		memcpy(&vbi->active_stats, new, sizeof(*new));
+	}
+
+	child_netdev = rcu_dereference(vbi->backup_netdev);
+	if (child_netdev) {
+		new = dev_get_stats(child_netdev, &temp);
+		virtnet_bypass_fold_stats(stats, new, &vbi->backup_stats);
+		memcpy(&vbi->backup_stats, new, sizeof(*new));
+	}
+
+	rcu_read_unlock();
+
+	memcpy(&vbi->bypass_stats, stats, sizeof(*stats));
+	spin_unlock(&vbi->stats_lock);
+}
+
+static int virtnet_bypass_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *child_netdev;
+	int ret = 0;
+
+	child_netdev = rcu_dereference(vbi->active_netdev);
+	if (child_netdev) {
+		ret = dev_set_mtu(child_netdev, new_mtu);
+		if (ret)
+			return ret;
+	}
+
+	child_netdev = rcu_dereference(vbi->backup_netdev);
+	if (child_netdev) {
+		ret = dev_set_mtu(child_netdev, new_mtu);
+		if (ret)
+			netdev_err(child_netdev,
+				   "Unexpected failure to set mtu to %d\n",
+				   new_mtu);
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static void virtnet_bypass_set_rx_mode(struct net_device *dev)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *child_netdev;
+
+	rcu_read_lock();
+
+	child_netdev = rcu_dereference(vbi->active_netdev);
+	if (child_netdev) {
+		dev_uc_sync_multiple(child_netdev, dev);
+		dev_mc_sync_multiple(child_netdev, dev);
+	}
+
+	child_netdev = rcu_dereference(vbi->backup_netdev);
+	if (child_netdev) {
+		dev_uc_sync_multiple(child_netdev, dev);
+		dev_mc_sync_multiple(child_netdev, dev);
+	}
+
+	rcu_read_unlock();
+}
+
+static const struct net_device_ops virtnet_bypass_netdev_ops = {
+	.ndo_open		= virtnet_bypass_open,
+	.ndo_stop		= virtnet_bypass_close,
+	.ndo_start_xmit		= virtnet_bypass_start_xmit,
+	.ndo_select_queue	= virtnet_bypass_select_queue,
+	.ndo_get_stats64	= virtnet_bypass_get_stats,
+	.ndo_change_mtu		= virtnet_bypass_change_mtu,
+	.ndo_set_rx_mode	= virtnet_bypass_set_rx_mode,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_features_check	= passthru_features_check,
+};
+
+static int
+virtnet_bypass_ethtool_get_link_ksettings(struct net_device *dev,
+					  struct ethtool_link_ksettings *cmd)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *child_netdev;
+
+	child_netdev = rtnl_dereference(vbi->active_netdev);
+	if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
+		child_netdev = rtnl_dereference(vbi->backup_netdev);
+		if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
+			cmd->base.duplex = DUPLEX_UNKNOWN;
+			cmd->base.port = PORT_OTHER;
+			cmd->base.speed = SPEED_UNKNOWN;
+
+			return 0;
+		}
+	}
+
+	return __ethtool_get_link_ksettings(child_netdev, cmd);
+}
+
+#define BYPASS_DRV_NAME "virtnet_bypass"
+#define BYPASS_DRV_VERSION "0.1"
+
+static void virtnet_bypass_ethtool_get_drvinfo(struct net_device *dev,
+					       struct ethtool_drvinfo *drvinfo)
+{
+	strlcpy(drvinfo->driver, BYPASS_DRV_NAME, sizeof(drvinfo->driver));
+	strlcpy(drvinfo->version, BYPASS_DRV_VERSION, sizeof(drvinfo->version));
+}
+
+static const struct ethtool_ops virtnet_bypass_ethtool_ops = {
+	.get_drvinfo            = virtnet_bypass_ethtool_get_drvinfo,
+	.get_link               = ethtool_op_get_link,
+	.get_link_ksettings     = virtnet_bypass_ethtool_get_link_ksettings,
+};
+
+static struct net_device *get_virtnet_bypass_bymac(struct net *net,
+						   const u8 *mac)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+
+	for_each_netdev(net, dev) {
+		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
+			continue;       /* not a virtnet_bypass device */
+
+		if (ether_addr_equal(mac, dev->perm_addr))
+			return dev;
+	}
+
+	return NULL;
+}
+
+static struct net_device *
+get_virtnet_bypass_byref(struct net_device *child_netdev)
+{
+	struct net *net = dev_net(child_netdev);
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+
+	for_each_netdev(net, dev) {
+		struct virtnet_bypass_info *vbi;
+
+		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
+			continue;       /* not a virtnet_bypass device */
+
+		vbi = netdev_priv(dev);
+
+		if ((rtnl_dereference(vbi->active_netdev) == child_netdev) ||
+		    (rtnl_dereference(vbi->backup_netdev) == child_netdev))
+			return dev;	/* a match */
+	}
+
+	return NULL;
+}
+
+/* Called when child dev is injecting data into network stack.
+ * Change the associated network device from lower dev to virtio.
+ * note: already called with rcu_read_lock
+ */
+static rx_handler_result_t virtnet_bypass_handle_frame(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
+
+	skb->dev = ndev;
+
+	return RX_HANDLER_ANOTHER;
+}
+
+static int virtnet_bypass_register_child(struct net_device *child_netdev)
+{
+	struct virtnet_bypass_info *vbi;
+	struct net_device *dev;
+	bool backup;
+	int ret;
+
+	if (child_netdev->addr_len != ETH_ALEN)
+		return NOTIFY_DONE;
+
+	/* We will use the MAC address to locate the virtnet_bypass netdev
+	 * to associate with the child netdev. If we don't find a matching
+	 * bypass netdev, move on.
+	 */
+	dev = get_virtnet_bypass_bymac(dev_net(child_netdev),
+				       child_netdev->perm_addr);
+	if (!dev)
+		return NOTIFY_DONE;
+
+	vbi = netdev_priv(dev);
+	backup = (child_netdev->dev.parent == dev->dev.parent);
+	if (backup ? rtnl_dereference(vbi->backup_netdev) :
+			rtnl_dereference(vbi->active_netdev)) {
+		netdev_info(dev,
+			    "%s attempting to join bypass dev when %s already present\n",
+			    child_netdev->name, backup ? "backup" : "active");
+		return NOTIFY_DONE;
+	}
+
+	/* Avoid non pci devices as active netdev */
+	if (!backup && (!child_netdev->dev.parent ||
+			!dev_is_pci(child_netdev->dev.parent)))
+		return NOTIFY_DONE;
+
+	ret = netdev_rx_handler_register(child_netdev,
+					 virtnet_bypass_handle_frame, dev);
+	if (ret != 0) {
+		netdev_err(child_netdev,
+			   "can not register bypass receive handler (err = %d)\n",
+			   ret);
+		goto rx_handler_failed;
+	}
+
+	ret = netdev_upper_dev_link(child_netdev, dev, NULL);
+	if (ret != 0) {
+		netdev_err(child_netdev,
+			   "can not set master device %s (err = %d)\n",
+			   dev->name, ret);
+		goto upper_link_failed;
+	}
+
+	child_netdev->flags |= IFF_SLAVE;
+
+	if (netif_running(dev)) {
+		ret = dev_open(child_netdev);
+		if (ret && (ret != -EBUSY)) {
+			netdev_err(dev, "Opening child %s failed ret:%d\n",
+				   child_netdev->name, ret);
+			goto err_interface_up;
+		}
+	}
+
+	/* Align MTU of child with master */
+	ret = dev_set_mtu(child_netdev, dev->mtu);
+	if (ret) {
+		netdev_err(dev,
+			   "unable to change mtu of %s to %u register failed\n",
+			   child_netdev->name, dev->mtu);
+		goto err_set_mtu;
+	}
+
+	call_netdevice_notifiers(NETDEV_JOIN, child_netdev);
+
+	netdev_info(dev, "registering %s\n", child_netdev->name);
+
+	dev_hold(child_netdev);
+	if (backup) {
+		rcu_assign_pointer(vbi->backup_netdev, child_netdev);
+		dev_get_stats(vbi->backup_netdev, &vbi->backup_stats);
+	} else {
+		rcu_assign_pointer(vbi->active_netdev, child_netdev);
+		dev_get_stats(vbi->active_netdev, &vbi->active_stats);
+		dev->min_mtu = child_netdev->min_mtu;
+		dev->max_mtu = child_netdev->max_mtu;
+	}
+
+	return NOTIFY_OK;
+
+err_set_mtu:
+	dev_close(child_netdev);
+err_interface_up:
+	netdev_upper_dev_unlink(child_netdev, dev);
+	child_netdev->flags &= ~IFF_SLAVE;
+upper_link_failed:
+	netdev_rx_handler_unregister(child_netdev);
+rx_handler_failed:
+	return NOTIFY_DONE;
+}
+
+static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
+{
+	struct virtnet_bypass_info *vbi;
+	struct net_device *dev, *backup;
+
+	dev = get_virtnet_bypass_byref(child_netdev);
+	if (!dev)
+		return NOTIFY_DONE;
+
+	vbi = netdev_priv(dev);
+
+	netdev_info(dev, "unregistering %s\n", child_netdev->name);
+
+	netdev_rx_handler_unregister(child_netdev);
+	netdev_upper_dev_unlink(child_netdev, dev);
+	child_netdev->flags &= ~IFF_SLAVE;
+
+	if (child_netdev->dev.parent == dev->dev.parent) {
+		RCU_INIT_POINTER(vbi->backup_netdev, NULL);
+	} else {
+		RCU_INIT_POINTER(vbi->active_netdev, NULL);
+		backup = rtnl_dereference(vbi->backup_netdev);
+		if (backup) {
+			dev->min_mtu = backup->min_mtu;
+			dev->max_mtu = backup->max_mtu;
+		}
+	}
+
+	dev_put(child_netdev);
+
+	return NOTIFY_OK;
+}
+
+static int virtnet_bypass_update_link(struct net_device *child_netdev)
+{
+	struct net_device *dev, *active, *backup;
+	struct virtnet_bypass_info *vbi;
+
+	dev = get_virtnet_bypass_byref(child_netdev);
+	if (!dev || !netif_running(dev))
+		return NOTIFY_DONE;
+
+	vbi = netdev_priv(dev);
+
+	active = rtnl_dereference(vbi->active_netdev);
+	backup = rtnl_dereference(vbi->backup_netdev);
+
+	if ((active && virtnet_bypass_xmit_ready(active)) ||
+	    (backup && virtnet_bypass_xmit_ready(backup))) {
+		netif_carrier_on(dev);
+		netif_tx_wake_all_queues(dev);
+	} else {
+		netif_carrier_off(dev);
+		netif_tx_stop_all_queues(dev);
+	}
+
+	return NOTIFY_OK;
+}
+
+static int virtnet_bypass_event(struct notifier_block *this,
+				unsigned long event, void *ptr)
+{
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+
+	/* Skip our own events */
+	if (event_dev->netdev_ops == &virtnet_bypass_netdev_ops)
+		return NOTIFY_DONE;
+
+	/* Avoid non-Ethernet type devices */
+	if (event_dev->type != ARPHRD_ETHER)
+		return NOTIFY_DONE;
+
+	/* Avoid Vlan dev with same MAC registering as child dev */
+	if (is_vlan_dev(event_dev))
+		return NOTIFY_DONE;
+
+	/* Avoid Bonding master dev with same MAC registering as child dev */
+	if ((event_dev->priv_flags & IFF_BONDING) &&
+	    (event_dev->flags & IFF_MASTER))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		return virtnet_bypass_register_child(event_dev);
+	case NETDEV_UNREGISTER:
+		return virtnet_bypass_unregister_child(event_dev);
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		return virtnet_bypass_update_link(event_dev);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block virtnet_bypass_notifier = {
+	.notifier_call = virtnet_bypass_event,
+};
+
+static int virtnet_bypass_create(struct virtnet_info *vi)
+{
+	struct net_device *backup_netdev = vi->dev;
+	struct device *dev = &vi->vdev->dev;
+	struct net_device *bypass_netdev;
+	int res;
+
+	/* Alloc at least 2 queues, for now we are going with 16 assuming
+	 * that most devices being bonded won't have too many queues.
+	 */
+	bypass_netdev = alloc_etherdev_mq(sizeof(struct virtnet_bypass_info),
+					  16);
+	if (!bypass_netdev) {
+		dev_err(dev, "Unable to allocate bypass_netdev!\n");
+		return -ENOMEM;
+	}
+
+	dev_net_set(bypass_netdev, dev_net(backup_netdev));
+	SET_NETDEV_DEV(bypass_netdev, dev);
+
+	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
+	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;
+
+	/* Initialize the device options */
+	bypass_netdev->flags |= IFF_MASTER;
+	bypass_netdev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT |
+				     IFF_NO_QUEUE;
+	bypass_netdev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
+				       IFF_TX_SKB_SHARING);
+
+	/* don't acquire bypass netdev's netif_tx_lock when transmitting */
+	bypass_netdev->features |= NETIF_F_LLTX;
+
+	/* Don't allow bypass devices to change network namespaces. */
+	bypass_netdev->features |= NETIF_F_NETNS_LOCAL;
+
+	bypass_netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
+				     NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |
+				     NETIF_F_HIGHDMA | NETIF_F_LRO;
+
+	bypass_netdev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
+	bypass_netdev->features |= bypass_netdev->hw_features;
+
+	/* For now treat bypass netdev as VLAN challenged since we
+	 * cannot assume VLAN functionality with a VF
+	 */
+	bypass_netdev->features |= NETIF_F_VLAN_CHALLENGED;
+
+	memcpy(bypass_netdev->dev_addr, backup_netdev->dev_addr,
+	       bypass_netdev->addr_len);
+
+	bypass_netdev->min_mtu = backup_netdev->min_mtu;
+	bypass_netdev->max_mtu = backup_netdev->max_mtu;
+
+	res = register_netdev(bypass_netdev);
+	if (res < 0) {
+		dev_err(dev, "Unable to register bypass_netdev!\n");
+		free_netdev(bypass_netdev);
+		return res;
+	}
+
+	netif_carrier_off(bypass_netdev);
+
+	vi->bypass_netdev = bypass_netdev;
+
+	return 0;
+}
+
+static void virtnet_bypass_destroy(struct virtnet_info *vi)
+{
+	struct net_device *bypass_netdev = vi->bypass_netdev;
+	struct virtnet_bypass_info *vbi;
+	struct net_device *child_netdev;
+
+	/* no device found, nothing to free */
+	if (!bypass_netdev)
+		return;
+
+	vbi = netdev_priv(bypass_netdev);
+
+	netif_device_detach(bypass_netdev);
+
+	rtnl_lock();
+
+	child_netdev = rtnl_dereference(vbi->active_netdev);
+	if (child_netdev)
+		virtnet_bypass_unregister_child(child_netdev);
+
+	child_netdev = rtnl_dereference(vbi->backup_netdev);
+	if (child_netdev)
+		virtnet_bypass_unregister_child(child_netdev);
+
+	unregister_netdevice(bypass_netdev);
+
+	rtnl_unlock();
+
+	free_netdev(bypass_netdev);
+}
+
+/* END of functions supporting VIRTIO_NET_F_BACKUP feature. */
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -2797,10 +3466,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtnet_init_settings(dev);
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_BACKUP)) {
+		if (virtnet_bypass_create(vi) != 0)
+			goto free_vqs;
+	}
+
 	err = register_netdev(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
-		goto free_vqs;
+		goto free_bypass;
 	}
 
 	virtio_device_ready(vdev);
@@ -2837,6 +3511,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vi->vdev->config->reset(vdev);
 
 	unregister_netdev(dev);
+free_bypass:
+	virtnet_bypass_destroy(vi);
 free_vqs:
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
@@ -2871,6 +3547,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	unregister_netdev(vi->dev);
 
+	virtnet_bypass_destroy(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
@@ -2968,6 +3646,8 @@ static __init int virtio_net_driver_init(void)
         ret = register_virtio_driver(&virtio_net_driver);
 	if (ret)
 		goto err_virtio;
+
+	register_netdevice_notifier(&virtnet_bypass_notifier);
 	return 0;
 err_virtio:
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
@@ -2980,6 +3660,7 @@ module_init(virtio_net_driver_init);
 
 static __exit void virtio_net_driver_exit(void)
 {
+	unregister_netdevice_notifier(&virtnet_bypass_notifier);
 	unregister_virtio_driver(&virtio_net_driver);
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 	cpuhp_remove_multi_state(virtionet_online);
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

