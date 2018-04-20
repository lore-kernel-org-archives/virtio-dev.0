Return-Path: virtio-dev-return-3903-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A545E58191A9
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 18:42:16 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 19 Apr 2018 18:42:02 -0700
Message-Id: <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH v7 net-next 2/4] net: Introduce generic failover module
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

This provides a generic interface for paravirtual drivers to listen
for netdev register/unregister/link change events from pci ethernet
devices with the same MAC and takeover their datapath. The notifier and
event handling code is based on the existing netvsc implementation.

It exposes 2 sets of interfaces to the paravirtual drivers.
1. existing netvsc driver that uses 2 netdev model. In this model, no
master netdev is created. The paravirtual driver registers each instance
of netvsc as a 'failover' instance  along with a set of ops to manage the
slave events.
     failover_register()
     failover_unregister()
2. new virtio_net based solution that uses 3 netdev model. In this model,
the failover module provides interfaces to create/destroy additional master
netdev and all the slave events are managed internally.
      failover_create()
      failover_destroy()
These functions call failover_register()/failover_unregister() with the
master netdev created by the failover module.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h |  16 +
 include/net/failover.h    |  96 ++++++
 net/Kconfig               |  18 +
 net/core/Makefile         |   1 +
 net/core/failover.c       | 844 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 975 insertions(+)
 create mode 100644 include/net/failover.h
 create mode 100644 net/core/failover.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf44503ea81a..ed535b6724e1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1401,6 +1401,8 @@ struct net_device_ops {
  *	entity (i.e. the master device for bridged veth)
  * @IFF_MACSEC: device is a MACsec device
  * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
+ * @IFF_FAILOVER: device is a failover master device
+ * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1430,6 +1432,8 @@ enum netdev_priv_flags {
 	IFF_PHONY_HEADROOM		= 1<<24,
 	IFF_MACSEC			= 1<<25,
 	IFF_NO_RX_HANDLER		= 1<<26,
+	IFF_FAILOVER			= 1<<27,
+	IFF_FAILOVER_SLAVE		= 1<<28,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1458,6 +1462,8 @@ enum netdev_priv_flags {
 #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
 #define IFF_MACSEC			IFF_MACSEC
 #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
+#define IFF_FAILOVER			IFF_FAILOVER
+#define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
 
 /**
  *	struct net_device - The DEVICE structure.
@@ -4308,6 +4314,16 @@ static inline bool netif_is_rxfh_configured(const struct net_device *dev)
 	return dev->priv_flags & IFF_RXFH_CONFIGURED;
 }
 
+static inline bool netif_is_failover(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_FAILOVER;
+}
+
+static inline bool netif_is_failover_slave(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_FAILOVER_SLAVE;
+}
+
 /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xmit() */
 static inline void netif_keep_dst(struct net_device *dev)
 {
diff --git a/include/net/failover.h b/include/net/failover.h
new file mode 100644
index 000000000000..0b8601043d90
--- /dev/null
+++ b/include/net/failover.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Intel Corporation. */
+
+#ifndef _NET_FAILOVER_H
+#define _NET_FAILOVER_H
+
+#include <linux/netdevice.h>
+
+struct failover_ops {
+	int (*slave_pre_register)(struct net_device *slave_dev,
+				  struct net_device *failover_dev);
+	int (*slave_join)(struct net_device *slave_dev,
+			  struct net_device *failover_dev);
+	int (*slave_pre_unregister)(struct net_device *slave_dev,
+				    struct net_device *failover_dev);
+	int (*slave_release)(struct net_device *slave_dev,
+			     struct net_device *failover_dev);
+	int (*slave_link_change)(struct net_device *slave_dev,
+				 struct net_device *failover_dev);
+	rx_handler_result_t (*handle_frame)(struct sk_buff **pskb);
+};
+
+struct failover {
+	struct list_head list;
+	struct net_device __rcu *failover_dev;
+	struct failover_ops __rcu *ops;
+};
+
+/* failover state */
+struct failover_info {
+	/* primary netdev with same MAC */
+	struct net_device __rcu *primary_dev;
+
+	/* standby netdev */
+	struct net_device __rcu *standby_dev;
+
+	/* primary netdev stats */
+	struct rtnl_link_stats64 primary_stats;
+
+	/* standby netdev stats */
+	struct rtnl_link_stats64 standby_stats;
+
+	/* aggregated stats */
+	struct rtnl_link_stats64 failover_stats;
+
+	/* spinlock while updating stats */
+	spinlock_t stats_lock;
+};
+
+#if IS_ENABLED(CONFIG_NET_FAILOVER)
+
+int failover_create(struct net_device *standby_dev,
+		    struct failover **pfailover);
+void failover_destroy(struct failover *failover);
+
+int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
+		      struct failover **pfailover);
+void failover_unregister(struct failover *failover);
+
+int failover_slave_unregister(struct net_device *slave_dev);
+
+#else
+
+static inline
+int failover_create(struct net_device *standby_dev,
+		    struct failover **pfailover);
+{
+	return 0;
+}
+
+static inline
+void failover_destroy(struct failover *failover)
+{
+}
+
+static inline
+int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
+		      struct pfailover **pfailover);
+{
+	return 0;
+}
+
+static inline
+void failover_unregister(struct failover *failover)
+{
+}
+
+static inline
+int failover_slave_unregister(struct net_device *slave_dev)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* _NET_FAILOVER_H */
diff --git a/net/Kconfig b/net/Kconfig
index 0428f12c25c2..388b99dfee10 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -423,6 +423,24 @@ config MAY_USE_DEVLINK
 	  on MAY_USE_DEVLINK to ensure they do not cause link errors when
 	  devlink is a loadable module and the driver using it is built-in.
 
+config NET_FAILOVER
+	tristate "Failover interface"
+	help
+	  This provides a generic interface for paravirtual drivers to listen
+	  for netdev register/unregister/link change events from pci ethernet
+	  devices with the same MAC and takeover their datapath. This also
+	  enables live migration of a VM with direct attached VF by failing
+	  over to the paravirtual datapath when the VF is unplugged.
+
+config MAY_USE_FAILOVER
+	tristate
+	default m if NET_FAILOVER=m
+	default y if NET_FAILOVER=y || NET_FAILOVER=n
+	help
+	  Drivers using the failover infrastructure should have a dependency
+	  on MAY_USE_FAILOVER to ensure they do not cause link errors when
+	  failover is a loadable module and the driver using it is built-in.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/core/Makefile b/net/core/Makefile
index 6dbbba8c57ae..cef17518bb7d 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
+obj-$(CONFIG_NET_FAILOVER) += failover.o
diff --git a/net/core/failover.c b/net/core/failover.c
new file mode 100644
index 000000000000..7bee762cb737
--- /dev/null
+++ b/net/core/failover.c
@@ -0,0 +1,844 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Intel Corporation. */
+
+/* A common module to handle registrations and notifications for paravirtual
+ * drivers to enable accelerated datapath and support VF live migration.
+ *
+ * The notifier and event handling code is based on netvsc driver.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/netpoll.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+#include <linux/pci.h>
+#include <net/sch_generic.h>
+#include <uapi/linux/if_arp.h>
+#include <net/failover.h>
+
+static LIST_HEAD(failover_list);
+static DEFINE_SPINLOCK(failover_lock);
+
+static int failover_slave_pre_register(struct net_device *slave_dev,
+				       struct net_device *failover_dev,
+				       struct failover_ops *failover_ops)
+{
+	struct failover_info *finfo;
+	bool standby;
+
+	if (failover_ops) {
+		if (!failover_ops->slave_pre_register)
+			return -EINVAL;
+
+		return failover_ops->slave_pre_register(slave_dev,
+							failover_dev);
+	}
+
+	finfo = netdev_priv(failover_dev);
+	standby = (slave_dev->dev.parent == failover_dev->dev.parent);
+	if (standby ? rtnl_dereference(finfo->standby_dev) :
+			rtnl_dereference(finfo->primary_dev)) {
+		netdev_err(failover_dev, "%s attempting to register as slave dev when %s already present\n",
+			   slave_dev->name, standby ? "standby" : "primary");
+		return -EEXIST;
+	}
+
+	/* Avoid non pci devices as primary netdev */
+	if (!standby && (!slave_dev->dev.parent ||
+			 !dev_is_pci(slave_dev->dev.parent)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int failover_slave_join(struct net_device *slave_dev,
+			       struct net_device *failover_dev,
+			       struct failover_ops *failover_ops)
+{
+	struct failover_info *finfo;
+	int err, orig_mtu;
+	bool standby;
+
+	if (failover_ops) {
+		if (!failover_ops->slave_join)
+			return -EINVAL;
+
+		return failover_ops->slave_join(slave_dev, failover_dev);
+	}
+
+	if (netif_running(failover_dev)) {
+		err = dev_open(slave_dev);
+		if (err && (err != -EBUSY)) {
+			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
+				   slave_dev->name, err);
+			goto err_dev_open;
+		}
+	}
+
+	/* Align MTU of slave with failover dev */
+	orig_mtu = slave_dev->mtu;
+	err = dev_set_mtu(slave_dev, failover_dev->mtu);
+	if (err) {
+		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
+			   slave_dev->name, failover_dev->mtu);
+		goto err_set_mtu;
+	}
+
+	finfo = netdev_priv(failover_dev);
+	standby = (slave_dev->dev.parent == failover_dev->dev.parent);
+
+	dev_hold(slave_dev);
+
+	if (standby) {
+		rcu_assign_pointer(finfo->standby_dev, slave_dev);
+		dev_get_stats(finfo->standby_dev, &finfo->standby_stats);
+	} else {
+		rcu_assign_pointer(finfo->primary_dev, slave_dev);
+		dev_get_stats(finfo->primary_dev, &finfo->primary_stats);
+		failover_dev->min_mtu = slave_dev->min_mtu;
+		failover_dev->max_mtu = slave_dev->max_mtu;
+	}
+
+	netdev_info(failover_dev, "failover slave:%s joined\n",
+		    slave_dev->name);
+
+	return 0;
+
+err_set_mtu:
+	dev_close(slave_dev);
+err_dev_open:
+	return err;
+}
+
+/* Called when slave dev is injecting data into network stack.
+ * Change the associated network device from lower dev to virtio.
+ * note: already called with rcu_read_lock
+ */
+static rx_handler_result_t failover_handle_frame(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
+
+	skb->dev = ndev;
+
+	return RX_HANDLER_ANOTHER;
+}
+
+static struct net_device *failover_get_bymac(u8 *mac, struct failover_ops **ops)
+{
+	struct net_device *failover_dev;
+	struct failover *failover;
+
+	spin_lock(&failover_lock);
+	list_for_each_entry(failover, &failover_list, list) {
+		failover_dev = rtnl_dereference(failover->failover_dev);
+		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
+			*ops = rtnl_dereference(failover->ops);
+			spin_unlock(&failover_lock);
+			return failover_dev;
+		}
+	}
+	spin_unlock(&failover_lock);
+	return NULL;
+}
+
+static int failover_slave_register(struct net_device *slave_dev)
+{
+	struct failover_ops *failover_ops;
+	struct net_device *failover_dev;
+	int ret;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &failover_ops);
+	if (!failover_dev)
+		goto done;
+
+	ret = failover_slave_pre_register(slave_dev, failover_dev,
+					  failover_ops);
+	if (ret)
+		goto done;
+
+	ret = netdev_rx_handler_register(slave_dev, failover_ops ?
+					 failover_ops->handle_frame :
+					 failover_handle_frame, failover_dev);
+	if (ret) {
+		netdev_err(slave_dev, "can not register failover rx handler (err = %d)\n",
+			   ret);
+		goto done;
+	}
+
+	ret = netdev_upper_dev_link(slave_dev, failover_dev, NULL);
+	if (ret) {
+		netdev_err(slave_dev, "can not set failover device %s (err = %d)\n",
+			   failover_dev->name, ret);
+		goto upper_link_failed;
+	}
+
+	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
+
+	ret = failover_slave_join(slave_dev, failover_dev, failover_ops);
+	if (ret)
+		goto err_join;
+
+	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
+
+	netdev_info(failover_dev, "failover slave:%s registered\n",
+		    slave_dev->name);
+
+	goto done;
+
+err_join:
+	netdev_upper_dev_unlink(slave_dev, failover_dev);
+	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
+upper_link_failed:
+	netdev_rx_handler_unregister(slave_dev);
+done:
+	return NOTIFY_DONE;
+}
+
+static int failover_slave_pre_unregister(struct net_device *slave_dev,
+					 struct net_device *failover_dev,
+					 struct failover_ops *failover_ops)
+{
+	struct net_device *standby_dev, *primary_dev;
+	struct failover_info *finfo;
+
+	if (failover_ops) {
+		if (!failover_ops->slave_pre_unregister)
+			return -EINVAL;
+
+		return failover_ops->slave_pre_unregister(slave_dev,
+							  failover_dev);
+	}
+
+	finfo = netdev_priv(failover_dev);
+	primary_dev = rtnl_dereference(finfo->primary_dev);
+	standby_dev = rtnl_dereference(finfo->standby_dev);
+
+	if (slave_dev != primary_dev && slave_dev != standby_dev)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int failover_slave_release(struct net_device *slave_dev,
+				  struct net_device *failover_dev,
+				  struct failover_ops *failover_ops)
+{
+	struct net_device *standby_dev, *primary_dev;
+	struct failover_info *finfo;
+
+	if (failover_ops) {
+		if (!failover_ops->slave_release)
+			return -EINVAL;
+
+		return failover_ops->slave_release(slave_dev, failover_dev);
+	}
+
+	finfo = netdev_priv(failover_dev);
+	primary_dev = rtnl_dereference(finfo->primary_dev);
+	standby_dev = rtnl_dereference(finfo->standby_dev);
+
+	if (slave_dev == standby_dev) {
+		RCU_INIT_POINTER(finfo->standby_dev, NULL);
+	} else {
+		RCU_INIT_POINTER(finfo->primary_dev, NULL);
+		if (standby_dev) {
+			failover_dev->min_mtu = standby_dev->min_mtu;
+			failover_dev->max_mtu = standby_dev->max_mtu;
+		}
+	}
+
+	dev_put(slave_dev);
+
+	netdev_info(failover_dev, "failover slave:%s released\n",
+		    slave_dev->name);
+
+	return 0;
+}
+
+int failover_slave_unregister(struct net_device *slave_dev)
+{
+	struct failover_ops *failover_ops;
+	struct net_device *failover_dev;
+	int ret;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &failover_ops);
+	if (!failover_dev)
+		goto done;
+
+	ret = failover_slave_pre_unregister(slave_dev, failover_dev,
+					    failover_ops);
+	if (ret)
+		goto done;
+
+	netdev_rx_handler_unregister(slave_dev);
+	netdev_upper_dev_unlink(slave_dev, failover_dev);
+	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
+
+	failover_slave_release(slave_dev, failover_dev, failover_ops);
+
+	netdev_info(failover_dev, "failover slave:%s unregistered\n",
+		    slave_dev->name);
+
+done:
+	return NOTIFY_DONE;
+}
+EXPORT_SYMBOL_GPL(failover_slave_unregister);
+
+static bool failover_xmit_ready(struct net_device *dev)
+{
+	return netif_running(dev) && netif_carrier_ok(dev);
+}
+
+static int failover_slave_link_change(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev, *primary_dev, *standby_dev;
+	struct failover_ops *failover_ops;
+	struct failover_info *finfo;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &failover_ops);
+	if (!failover_dev)
+		goto done;
+
+	if (failover_ops) {
+		if (!failover_ops->slave_link_change)
+			goto done;
+
+		return failover_ops->slave_link_change(slave_dev, failover_dev);
+	}
+
+	if (!netif_running(failover_dev))
+		return 0;
+
+	finfo = netdev_priv(failover_dev);
+
+	primary_dev = rtnl_dereference(finfo->primary_dev);
+	standby_dev = rtnl_dereference(finfo->standby_dev);
+
+	if (slave_dev != primary_dev && slave_dev != standby_dev)
+		goto done;
+
+	if ((primary_dev && failover_xmit_ready(primary_dev)) ||
+	    (standby_dev && failover_xmit_ready(standby_dev))) {
+		netif_carrier_on(failover_dev);
+		netif_tx_wake_all_queues(failover_dev);
+	} else {
+		netif_carrier_off(failover_dev);
+		netif_tx_stop_all_queues(failover_dev);
+	}
+
+done:
+	return NOTIFY_DONE;
+}
+
+static bool failover_validate_event_dev(struct net_device *dev)
+{
+	/* Skip parent events */
+	if (netif_is_failover(dev))
+		return false;
+
+	/* Avoid non-Ethernet type devices */
+	if (dev->type != ARPHRD_ETHER)
+		return false;
+
+	return true;
+}
+
+static int
+failover_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+
+	if (!failover_validate_event_dev(event_dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		return failover_slave_register(event_dev);
+	case NETDEV_UNREGISTER:
+		return failover_slave_unregister(event_dev);
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		return failover_slave_link_change(event_dev);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block failover_notifier = {
+	.notifier_call = failover_event,
+};
+
+static int failover_open(struct net_device *dev)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+	int err;
+
+	netif_carrier_off(dev);
+	netif_tx_wake_all_queues(dev);
+
+	primary_dev = rtnl_dereference(finfo->primary_dev);
+	if (primary_dev) {
+		err = dev_open(primary_dev);
+		if (err)
+			goto err_primary_open;
+	}
+
+	standby_dev = rtnl_dereference(finfo->standby_dev);
+	if (standby_dev) {
+		err = dev_open(standby_dev);
+		if (err)
+			goto err_standby_open;
+	}
+
+	return 0;
+
+err_standby_open:
+	dev_close(primary_dev);
+err_primary_open:
+	netif_tx_disable(dev);
+	return err;
+}
+
+static int failover_close(struct net_device *dev)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	netif_tx_disable(dev);
+
+	slave_dev = rtnl_dereference(finfo->primary_dev);
+	if (slave_dev)
+		dev_close(slave_dev);
+
+	slave_dev = rtnl_dereference(finfo->standby_dev);
+	if (slave_dev)
+		dev_close(slave_dev);
+
+	return 0;
+}
+
+static netdev_tx_t failover_drop_xmit(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	atomic_long_inc(&dev->tx_dropped);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t failover_start_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *xmit_dev;
+
+	/* Try xmit via primary netdev followed by standby netdev */
+	xmit_dev = rcu_dereference_bh(finfo->primary_dev);
+	if (!xmit_dev || !failover_xmit_ready(xmit_dev)) {
+		xmit_dev = rcu_dereference_bh(finfo->standby_dev);
+		if (!xmit_dev || !failover_xmit_ready(xmit_dev))
+			return failover_drop_xmit(skb, dev);
+	}
+
+	skb->dev = xmit_dev;
+	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
+
+	return dev_queue_xmit(skb);
+}
+
+static u16 failover_select_queue(struct net_device *dev, struct sk_buff *skb,
+				 void *accel_priv,
+				 select_queue_fallback_t fallback)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *primary_dev;
+	u16 txq;
+
+	rcu_read_lock();
+	primary_dev = rcu_dereference(finfo->primary_dev);
+	if (primary_dev) {
+		const struct net_device_ops *ops = primary_dev->netdev_ops;
+
+		if (ops->ndo_select_queue)
+			txq = ops->ndo_select_queue(primary_dev, skb,
+						    accel_priv, fallback);
+		else
+			txq = fallback(primary_dev, skb);
+
+		qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
+
+		return txq;
+	}
+
+	txq = skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
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
+ * that some drivers can provide 32finfot values only.
+ */
+static void failover_fold_stats(struct rtnl_link_stats64 *_res,
+				const struct rtnl_link_stats64 *_new,
+				const struct rtnl_link_stats64 *_old)
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
+static void failover_get_stats(struct net_device *dev,
+			       struct rtnl_link_stats64 *stats)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	const struct rtnl_link_stats64 *new;
+	struct rtnl_link_stats64 temp;
+	struct net_device *slave_dev;
+
+	spin_lock(&finfo->stats_lock);
+	memcpy(stats, &finfo->failover_stats, sizeof(*stats));
+
+	rcu_read_lock();
+
+	slave_dev = rcu_dereference(finfo->primary_dev);
+	if (slave_dev) {
+		new = dev_get_stats(slave_dev, &temp);
+		failover_fold_stats(stats, new, &finfo->primary_stats);
+		memcpy(&finfo->primary_stats, new, sizeof(*new));
+	}
+
+	slave_dev = rcu_dereference(finfo->standby_dev);
+	if (slave_dev) {
+		new = dev_get_stats(slave_dev, &temp);
+		failover_fold_stats(stats, new, &finfo->standby_stats);
+		memcpy(&finfo->standby_stats, new, sizeof(*new));
+	}
+
+	rcu_read_unlock();
+
+	memcpy(&finfo->failover_stats, stats, sizeof(*stats));
+	spin_unlock(&finfo->stats_lock);
+}
+
+static int failover_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+	int ret = 0;
+
+	primary_dev = rcu_dereference(finfo->primary_dev);
+	if (primary_dev) {
+		ret = dev_set_mtu(primary_dev, new_mtu);
+		if (ret)
+			return ret;
+	}
+
+	standby_dev = rcu_dereference(finfo->standby_dev);
+	if (standby_dev) {
+		ret = dev_set_mtu(standby_dev, new_mtu);
+		if (ret) {
+			dev_set_mtu(primary_dev, dev->mtu);
+			return ret;
+		}
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static void failover_set_rx_mode(struct net_device *dev)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	rcu_read_lock();
+
+	slave_dev = rcu_dereference(finfo->primary_dev);
+	if (slave_dev) {
+		dev_uc_sync_multiple(slave_dev, dev);
+		dev_mc_sync_multiple(slave_dev, dev);
+	}
+
+	slave_dev = rcu_dereference(finfo->standby_dev);
+	if (slave_dev) {
+		dev_uc_sync_multiple(slave_dev, dev);
+		dev_mc_sync_multiple(slave_dev, dev);
+	}
+
+	rcu_read_unlock();
+}
+
+static const struct net_device_ops failover_dev_ops = {
+	.ndo_open		= failover_open,
+	.ndo_stop		= failover_close,
+	.ndo_start_xmit		= failover_start_xmit,
+	.ndo_select_queue	= failover_select_queue,
+	.ndo_get_stats64	= failover_get_stats,
+	.ndo_change_mtu		= failover_change_mtu,
+	.ndo_set_rx_mode	= failover_set_rx_mode,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_features_check	= passthru_features_check,
+};
+
+#define FAILOVER_NAME "failover"
+#define FAILOVER_VERSION "0.1"
+
+static void failover_ethtool_get_drvinfo(struct net_device *dev,
+					 struct ethtool_drvinfo *drvinfo)
+{
+	strlcpy(drvinfo->driver, FAILOVER_NAME, sizeof(drvinfo->driver));
+	strlcpy(drvinfo->version, FAILOVER_VERSION, sizeof(drvinfo->version));
+}
+
+int failover_ethtool_get_link_ksettings(struct net_device *dev,
+					struct ethtool_link_ksettings *cmd)
+{
+	struct failover_info *finfo = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	slave_dev = rtnl_dereference(finfo->primary_dev);
+	if (!slave_dev || !failover_xmit_ready(slave_dev)) {
+		slave_dev = rtnl_dereference(finfo->standby_dev);
+		if (!slave_dev || !failover_xmit_ready(slave_dev)) {
+			cmd->base.duplex = DUPLEX_UNKNOWN;
+			cmd->base.port = PORT_OTHER;
+			cmd->base.speed = SPEED_UNKNOWN;
+
+			return 0;
+		}
+	}
+
+	return __ethtool_get_link_ksettings(slave_dev, cmd);
+}
+EXPORT_SYMBOL_GPL(failover_ethtool_get_link_ksettings);
+
+static const struct ethtool_ops failover_ethtool_ops = {
+	.get_drvinfo            = failover_ethtool_get_drvinfo,
+	.get_link               = ethtool_op_get_link,
+	.get_link_ksettings     = failover_ethtool_get_link_ksettings,
+};
+
+static void failover_register_existing_slave(struct net_device *failover_dev)
+{
+	struct net *net = dev_net(failover_dev);
+	struct net_device *dev;
+
+	rtnl_lock();
+	for_each_netdev(net, dev) {
+		if (dev == failover_dev)
+			continue;
+		if (!failover_validate_event_dev(dev))
+			continue;
+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
+			failover_slave_register(dev);
+	}
+	rtnl_unlock();
+}
+
+int failover_register(struct net_device *dev, struct failover_ops *ops,
+		      struct failover **pfailover)
+{
+	struct failover *failover;
+
+	failover = kzalloc(sizeof(*failover), GFP_KERNEL);
+	if (!failover)
+		return -ENOMEM;
+
+	rcu_assign_pointer(failover->ops, ops);
+	dev_hold(dev);
+	dev->priv_flags |= IFF_FAILOVER;
+	rcu_assign_pointer(failover->failover_dev, dev);
+
+	spin_lock(&failover_lock);
+	list_add_tail(&failover->list, &failover_list);
+	spin_unlock(&failover_lock);
+
+	failover_register_existing_slave(dev);
+
+	*pfailover = failover;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(failover_register);
+
+void failover_unregister(struct failover *failover)
+{
+	struct net_device *failover_dev;
+
+	failover_dev = rcu_dereference(failover->failover_dev);
+
+	failover_dev->priv_flags &= ~IFF_FAILOVER;
+	dev_put(failover_dev);
+
+	spin_lock(&failover_lock);
+	list_del(&failover->list);
+	spin_unlock(&failover_lock);
+
+	kfree(failover);
+}
+EXPORT_SYMBOL_GPL(failover_unregister);
+
+int failover_create(struct net_device *standby_dev, struct failover **pfailover)
+{
+	struct device *dev = standby_dev->dev.parent;
+	struct net_device *failover_dev;
+	int err;
+
+	/* Alloc at least 2 queues, for now we are going with 16 assuming
+	 * that most devices being bonded won't have too many queues.
+	 */
+	failover_dev = alloc_etherdev_mq(sizeof(struct failover_info), 16);
+	if (!failover_dev) {
+		dev_err(dev, "Unable to allocate failover_netdev!\n");
+		return -ENOMEM;
+	}
+
+	dev_net_set(failover_dev, dev_net(standby_dev));
+	SET_NETDEV_DEV(failover_dev, dev);
+
+	failover_dev->netdev_ops = &failover_dev_ops;
+	failover_dev->ethtool_ops = &failover_ethtool_ops;
+
+	/* Initialize the device options */
+	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
+	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
+				       IFF_TX_SKB_SHARING);
+
+	/* don't acquire failover netdev's netif_tx_lock when transmitting */
+	failover_dev->features |= NETIF_F_LLTX;
+
+	/* Don't allow failover devices to change network namespaces. */
+	failover_dev->features |= NETIF_F_NETNS_LOCAL;
+
+	failover_dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
+				    NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |
+				    NETIF_F_HIGHDMA | NETIF_F_LRO;
+
+	failover_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
+	failover_dev->features |= failover_dev->hw_features;
+
+	memcpy(failover_dev->dev_addr, standby_dev->dev_addr,
+	       failover_dev->addr_len);
+
+	failover_dev->min_mtu = standby_dev->min_mtu;
+	failover_dev->max_mtu = standby_dev->max_mtu;
+
+	err = register_netdev(failover_dev);
+	if (err < 0) {
+		dev_err(dev, "Unable to register failover_dev!\n");
+		goto err_register_netdev;
+	}
+
+	netif_carrier_off(failover_dev);
+
+	err = failover_register(failover_dev, NULL, pfailover);
+	if (err < 0)
+		goto err_failover;
+
+	return 0;
+
+err_failover:
+	unregister_netdev(failover_dev);
+err_register_netdev:
+	free_netdev(failover_dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(failover_create);
+
+void failover_destroy(struct failover *failover)
+{
+	struct net_device *failover_dev;
+	struct net_device *slave_dev;
+	struct failover_info *finfo;
+
+	if (!failover)
+		return;
+
+	failover_dev = rcu_dereference(failover->failover_dev);
+	finfo = netdev_priv(failover_dev);
+
+	netif_device_detach(failover_dev);
+
+	rtnl_lock();
+
+	slave_dev = rtnl_dereference(finfo->primary_dev);
+	if (slave_dev)
+		failover_slave_unregister(slave_dev);
+
+	slave_dev = rtnl_dereference(finfo->standby_dev);
+	if (slave_dev)
+		failover_slave_unregister(slave_dev);
+
+	failover_unregister(failover);
+
+	unregister_netdevice(failover_dev);
+
+	rtnl_unlock();
+
+	free_netdev(failover_dev);
+}
+EXPORT_SYMBOL_GPL(failover_destroy);
+
+static __init int
+failover_init(void)
+{
+	register_netdevice_notifier(&failover_notifier);
+
+	return 0;
+}
+module_init(failover_init);
+
+static __exit
+void failover_exit(void)
+{
+	unregister_netdevice_notifier(&failover_notifier);
+}
+module_exit(failover_exit);
+
+MODULE_DESCRIPTION("Failover infrastructure/interface for Paravirtual drivers");
+MODULE_LICENSE("GPL v2");
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

