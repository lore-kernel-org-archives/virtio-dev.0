Return-Path: virtio-dev-return-3992-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 275345818EFD
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 10:07:13 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Fri, 27 Apr 2018 10:06:58 -0700
Message-Id: <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH net-next v9 2/4] net: Introduce generic failover module
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This provides a generic interface for paravirtual drivers to listen
for netdev register/unregister/link change events from pci ethernet
devices with the same MAC and takeover their datapath. The notifier and
event handling code is based on the existing netvsc implementation.

It exposes 2 sets of interfaces to the paravirtual drivers.
1. For paravirtual drivers like virtio_net that use 3 netdev model, the
   the failover module provides interfaces to create/destroy additional
   master netdev and all the slave events are managed internally.
        net_failover_create()
        net_failover_destroy()
   A failover netdev is created that acts a master device and controls 2
   slave devices. The original virtio_net netdev is registered as 'standby'
   netdev and a passthru/vf device with the same MAC gets registered as
   'primary' netdev. Both 'standby' and 'primary' netdevs are associated
   with the same 'pci' device.  The user accesses the network interface via
   'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
   default for transmits when it is available with link up and running.
2. For existing netvsc driver that uses 2 netdev model, no master netdev
   is created. The paravirtual driver registers each instance of netvsc
   as a 'failover' netdev  along with a set of ops to manage the slave
   events. There is no 'standby' netdev in this model. A passthru/vf device
   with the same MAC gets registered as 'primary' netdev.
        net_failover_register()
        net_failover_unregister()

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h  |  16 +
 include/net/net_failover.h |  62 ++++
 net/Kconfig                |  10 +
 net/core/Makefile          |   1 +
 net/core/net_failover.c    | 892 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 981 insertions(+)
 create mode 100644 include/net/net_failover.h
 create mode 100644 net/core/net_failover.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 14e0777ffcfb..b04dbf7dcf1b 100644
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
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
new file mode 100644
index 000000000000..d852f17fb2af
--- /dev/null
+++ b/include/net/net_failover.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Intel Corporation. */
+
+#ifndef _NET_FAILOVER_H
+#define _NET_FAILOVER_H
+
+#include <linux/netdevice.h>
+
+struct net_failover_ops {
+	int (*slave_register)(struct net_device *slave_dev,
+			      struct net_device *failover_dev);
+	int (*slave_unregister)(struct net_device *slave_dev,
+				struct net_device *failover_dev);
+	int (*slave_link_change)(struct net_device *slave_dev,
+				 struct net_device *failover_dev);
+};
+
+struct net_failover {
+	struct list_head list;
+	struct net_device __rcu *failover_dev;
+	struct net_failover_ops __rcu *ops;
+};
+
+/* failover state */
+struct net_failover_info {
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
+/* Paravirtual drivers supporting 3-netdev model can use these 2 interfaces to
+ * create and destroy a failover device.
+ */
+int net_failover_create(struct net_device *standby_dev,
+			struct net_failover **pfailover);
+void net_failover_destroy(struct net_failover *failover);
+
+/* Paravirtual drivers supporting 2-netdev model can use these 2 interfaces to
+ * register and unregister a failover device.
+ */
+int net_failover_register(struct net_device *standby_dev,
+			  struct net_failover_ops *ops,
+			  struct net_failover **pfailover);
+void net_failover_unregister(struct net_failover *failover);
+
+int net_failover_slave_unregister(struct net_device *slave_dev);
+
+#endif /* _NET_FAILOVER_H */
diff --git a/net/Kconfig b/net/Kconfig
index 6fa1a4493b8c..ebbc9b70418d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -426,6 +426,16 @@ config MAY_USE_DEVLINK
 config PAGE_POOL
        bool
 
+config NET_FAILOVER
+	tristate "Failover interface"
+	default m
+	help
+	  This provides a generic interface for paravirtual drivers to listen
+	  for netdev register/unregister/link change events from pci ethernet
+	  devices with the same MAC and takeover their datapath. This also
+	  enables live migration of a VM with direct attached VF by failing
+	  over to the paravirtual datapath when the VF is unplugged.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/core/Makefile b/net/core/Makefile
index 7080417f8bc8..283ed9b0e581 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
+obj-$(CONFIG_NET_FAILOVER) += net_failover.o
diff --git a/net/core/net_failover.c b/net/core/net_failover.c
new file mode 100644
index 000000000000..ac164be17563
--- /dev/null
+++ b/net/core/net_failover.c
@@ -0,0 +1,892 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Intel Corporation. */
+
+/* A common module to handle registrations and notifications for paravirtual
+ * drivers to enable accelerated datapath and support VF live migration.
+ *
+ * The notifier and event handling code is based on netvsc driver and failover
+ * netdev management routines are based on bond/team driver.
+ *
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
+#include <net/net_failover.h>
+
+static LIST_HEAD(net_failover_list);
+static DEFINE_SPINLOCK(net_failover_lock);
+
+static int net_failover_open(struct net_device *dev)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+	int err;
+
+	netif_carrier_off(dev);
+	netif_tx_wake_all_queues(dev);
+
+	primary_dev = rtnl_dereference(nfo_info->primary_dev);
+	if (primary_dev) {
+		err = dev_open(primary_dev);
+		if (err)
+			goto err_primary_open;
+	}
+
+	standby_dev = rtnl_dereference(nfo_info->standby_dev);
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
+static int net_failover_close(struct net_device *dev)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	netif_tx_disable(dev);
+
+	slave_dev = rtnl_dereference(nfo_info->primary_dev);
+	if (slave_dev)
+		dev_close(slave_dev);
+
+	slave_dev = rtnl_dereference(nfo_info->standby_dev);
+	if (slave_dev)
+		dev_close(slave_dev);
+
+	return 0;
+}
+
+static netdev_tx_t net_failover_drop_xmit(struct sk_buff *skb,
+					  struct net_device *dev)
+{
+	atomic_long_inc(&dev->tx_dropped);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static bool net_failover_xmit_ready(struct net_device *dev)
+{
+	return netif_running(dev) && netif_carrier_ok(dev);
+}
+
+static netdev_tx_t net_failover_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *xmit_dev;
+
+	/* Try xmit via primary netdev followed by standby netdev */
+	xmit_dev = rcu_dereference_bh(nfo_info->primary_dev);
+	if (!xmit_dev || !net_failover_xmit_ready(xmit_dev)) {
+		xmit_dev = rcu_dereference_bh(nfo_info->standby_dev);
+		if (!xmit_dev || !net_failover_xmit_ready(xmit_dev))
+			return net_failover_drop_xmit(skb, dev);
+	}
+
+	skb->dev = xmit_dev;
+	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
+
+	return dev_queue_xmit(skb);
+}
+
+static u16 net_failover_select_queue(struct net_device *dev,
+				     struct sk_buff *skb, void *accel_priv,
+				     select_queue_fallback_t fallback)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *primary_dev;
+	u16 txq;
+
+	rcu_read_lock();
+	primary_dev = rcu_dereference(nfo_info->primary_dev);
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
+ * that some drivers can provide 32bit values only.
+ */
+static void net_failover_fold_stats(struct rtnl_link_stats64 *_res,
+				    const struct rtnl_link_stats64 *_new,
+				    const struct rtnl_link_stats64 *_old)
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
+static void net_failover_get_stats(struct net_device *dev,
+				   struct rtnl_link_stats64 *stats)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	const struct rtnl_link_stats64 *new;
+	struct rtnl_link_stats64 temp;
+	struct net_device *slave_dev;
+
+	spin_lock(&nfo_info->stats_lock);
+	memcpy(stats, &nfo_info->failover_stats, sizeof(*stats));
+
+	rcu_read_lock();
+
+	slave_dev = rcu_dereference(nfo_info->primary_dev);
+	if (slave_dev) {
+		new = dev_get_stats(slave_dev, &temp);
+		net_failover_fold_stats(stats, new, &nfo_info->primary_stats);
+		memcpy(&nfo_info->primary_stats, new, sizeof(*new));
+	}
+
+	slave_dev = rcu_dereference(nfo_info->standby_dev);
+	if (slave_dev) {
+		new = dev_get_stats(slave_dev, &temp);
+		net_failover_fold_stats(stats, new, &nfo_info->standby_stats);
+		memcpy(&nfo_info->standby_stats, new, sizeof(*new));
+	}
+
+	rcu_read_unlock();
+
+	memcpy(&nfo_info->failover_stats, stats, sizeof(*stats));
+	spin_unlock(&nfo_info->stats_lock);
+}
+
+static int net_failover_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+	int ret = 0;
+
+	primary_dev = rcu_dereference(nfo_info->primary_dev);
+	if (primary_dev) {
+		ret = dev_set_mtu(primary_dev, new_mtu);
+		if (ret)
+			return ret;
+	}
+
+	standby_dev = rcu_dereference(nfo_info->standby_dev);
+	if (standby_dev) {
+		ret = dev_set_mtu(standby_dev, new_mtu);
+		if (ret) {
+			dev_set_mtu(primary_dev, dev->mtu);
+			return ret;
+		}
+	}
+
+	dev->mtu = new_mtu;
+
+	return 0;
+}
+
+static void net_failover_set_rx_mode(struct net_device *dev)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	rcu_read_lock();
+
+	slave_dev = rcu_dereference(nfo_info->primary_dev);
+	if (slave_dev) {
+		dev_uc_sync_multiple(slave_dev, dev);
+		dev_mc_sync_multiple(slave_dev, dev);
+	}
+
+	slave_dev = rcu_dereference(nfo_info->standby_dev);
+	if (slave_dev) {
+		dev_uc_sync_multiple(slave_dev, dev);
+		dev_mc_sync_multiple(slave_dev, dev);
+	}
+
+	rcu_read_unlock();
+}
+
+static int net_failover_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
+					u16 vid)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+	int ret = 0;
+
+	primary_dev = rcu_dereference(nfo_info->primary_dev);
+	if (primary_dev) {
+		ret = vlan_vid_add(primary_dev, proto, vid);
+		if (ret)
+			return ret;
+	}
+
+	standby_dev = rcu_dereference(nfo_info->standby_dev);
+	if (standby_dev) {
+		ret = vlan_vid_add(standby_dev, proto, vid);
+		if (ret)
+			vlan_vid_del(primary_dev, proto, vid);
+	}
+
+	return ret;
+}
+
+static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
+					 u16 vid)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	slave_dev = rcu_dereference(nfo_info->primary_dev);
+	if (slave_dev)
+		vlan_vid_del(slave_dev, proto, vid);
+
+	slave_dev = rcu_dereference(nfo_info->standby_dev);
+	if (slave_dev)
+		vlan_vid_del(slave_dev, proto, vid);
+
+	return 0;
+}
+
+static const struct net_device_ops failover_dev_ops = {
+	.ndo_open		= net_failover_open,
+	.ndo_stop		= net_failover_close,
+	.ndo_start_xmit		= net_failover_start_xmit,
+	.ndo_select_queue	= net_failover_select_queue,
+	.ndo_get_stats64	= net_failover_get_stats,
+	.ndo_change_mtu		= net_failover_change_mtu,
+	.ndo_set_rx_mode	= net_failover_set_rx_mode,
+	.ndo_vlan_rx_add_vid	= net_failover_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_features_check	= passthru_features_check,
+};
+
+#define FAILOVER_NAME "failover"
+#define FAILOVER_VERSION "0.1"
+
+static void nfo_ethtool_get_drvinfo(struct net_device *dev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	strlcpy(drvinfo->driver, FAILOVER_NAME, sizeof(drvinfo->driver));
+	strlcpy(drvinfo->version, FAILOVER_VERSION, sizeof(drvinfo->version));
+}
+
+static int nfo_ethtool_get_link_ksettings(struct net_device *dev,
+					  struct ethtool_link_ksettings *cmd)
+{
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *slave_dev;
+
+	slave_dev = rtnl_dereference(nfo_info->primary_dev);
+	if (!slave_dev || !net_failover_xmit_ready(slave_dev)) {
+		slave_dev = rtnl_dereference(nfo_info->standby_dev);
+		if (!slave_dev || !net_failover_xmit_ready(slave_dev)) {
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
+
+static const struct ethtool_ops failover_ethtool_ops = {
+	.get_drvinfo            = nfo_ethtool_get_drvinfo,
+	.get_link               = ethtool_op_get_link,
+	.get_link_ksettings     = nfo_ethtool_get_link_ksettings,
+};
+
+static struct net_device *net_failover_get_bymac(u8 *mac,
+						 struct net_failover_ops **ops)
+{
+	struct net_device *failover_dev;
+	struct net_failover *failover;
+
+	spin_lock(&net_failover_lock);
+	list_for_each_entry(failover, &net_failover_list, list) {
+		failover_dev = rtnl_dereference(failover->failover_dev);
+		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
+			*ops = rtnl_dereference(failover->ops);
+			spin_unlock(&net_failover_lock);
+			return failover_dev;
+		}
+	}
+	spin_unlock(&net_failover_lock);
+	return NULL;
+}
+
+/* Called when slave dev is injecting data into network stack.
+ * Change the associated network device from lower dev to virtio.
+ * note: already called with rcu_read_lock
+ */
+static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
+
+	skb->dev = ndev;
+
+	return RX_HANDLER_ANOTHER;
+}
+
+#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
+				 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
+
+static void net_failover_compute_features(struct net_device *dev)
+{
+	u32 vlan_features = FAILOVER_VLAN_FEATURES & NETIF_F_ALL_FOR_ALL;
+	netdev_features_t enc_features  = FAILOVER_ENC_FEATURES;
+	unsigned short max_hard_header_len = ETH_HLEN;
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
+					IFF_XMIT_DST_RELEASE_PERM;
+	struct net_failover_info *nfo_info = netdev_priv(dev);
+	struct net_device *primary_dev, *standby_dev;
+
+	primary_dev = rcu_dereference(nfo_info->primary_dev);
+	if (primary_dev) {
+		vlan_features =
+			netdev_increment_features(vlan_features,
+						  primary_dev->vlan_features,
+						  FAILOVER_VLAN_FEATURES);
+		enc_features =
+			netdev_increment_features(enc_features,
+						  primary_dev->hw_enc_features,
+						  FAILOVER_ENC_FEATURES);
+
+		dst_release_flag &= primary_dev->priv_flags;
+		if (primary_dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = primary_dev->hard_header_len;
+	}
+
+	standby_dev = rcu_dereference(nfo_info->standby_dev);
+	if (standby_dev) {
+		vlan_features =
+			netdev_increment_features(vlan_features,
+						  standby_dev->vlan_features,
+						  FAILOVER_VLAN_FEATURES);
+		enc_features =
+			netdev_increment_features(enc_features,
+						  standby_dev->hw_enc_features,
+						  FAILOVER_ENC_FEATURES);
+
+		dst_release_flag &= standby_dev->priv_flags;
+		if (standby_dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = standby_dev->hard_header_len;
+	}
+
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
+	dev->hard_header_len = max_hard_header_len;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if (dst_release_flag == (IFF_XMIT_DST_RELEASE |
+				 IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	netdev_change_features(dev);
+}
+
+static int net_failover_slave_register(struct net_device *slave_dev)
+{
+	struct net_failover_info *nfo_info;
+	struct net_failover_ops *nfo_ops;
+	struct net_device *failover_dev;
+	bool slave_is_standby;
+	u32 orig_mtu;
+	int err;
+
+	ASSERT_RTNL();
+
+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
+	if (!failover_dev)
+		goto done;
+
+	if (failover_dev->type != slave_dev->type)
+		goto done;
+
+	if (nfo_ops && nfo_ops->slave_register)
+		return nfo_ops->slave_register(slave_dev, failover_dev);
+
+	nfo_info = netdev_priv(failover_dev);
+	slave_is_standby = (slave_dev->dev.parent == failover_dev->dev.parent);
+	if (slave_is_standby ? rtnl_dereference(nfo_info->standby_dev) :
+			rtnl_dereference(nfo_info->primary_dev)) {
+		netdev_err(failover_dev, "%s attempting to register as slave dev when %s already present\n",
+			   slave_dev->name,
+			   slave_is_standby ? "standby" : "primary");
+		goto done;
+	}
+
+	/* We want to allow only a direct attached VF device as a primary
+	 * netdev. As there is no easy way to check for a VF device, restrict
+	 * this to a pci device.
+	 */
+	if (!slave_is_standby && (!slave_dev->dev.parent ||
+				  !dev_is_pci(slave_dev->dev.parent)))
+		goto done;
+
+	if (failover_dev->features & NETIF_F_VLAN_CHALLENGED &&
+	    vlan_uses_dev(failover_dev)) {
+		netdev_err(failover_dev, "Device %s is VLAN challenged and failover device has VLAN set up\n",
+			   failover_dev->name);
+		goto done;
+	}
+
+	/* Align MTU of slave with failover dev */
+	orig_mtu = slave_dev->mtu;
+	err = dev_set_mtu(slave_dev, failover_dev->mtu);
+	if (err) {
+		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
+			   slave_dev->name, failover_dev->mtu);
+		goto done;
+	}
+
+	dev_hold(slave_dev);
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
+	netif_addr_lock_bh(failover_dev);
+	dev_uc_sync_multiple(slave_dev, failover_dev);
+	dev_uc_sync_multiple(slave_dev, failover_dev);
+	netif_addr_unlock_bh(failover_dev);
+
+	err = vlan_vids_add_by_dev(slave_dev, failover_dev);
+	if (err) {
+		netdev_err(failover_dev, "Failed to add vlan ids to device %s err:%d\n",
+			   slave_dev->name, err);
+		goto err_vlan_add;
+	}
+
+	err = netdev_rx_handler_register(slave_dev, net_failover_handle_frame,
+					 failover_dev);
+	if (err) {
+		netdev_err(slave_dev, "can not register failover rx handler (err = %d)\n",
+			   err);
+		goto err_handler_register;
+	}
+
+	err = netdev_upper_dev_link(slave_dev, failover_dev, NULL);
+	if (err) {
+		netdev_err(slave_dev, "can not set failover device %s (err = %d)\n",
+			   failover_dev->name, err);
+		goto err_upper_link;
+	}
+
+	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
+
+	if (slave_is_standby) {
+		rcu_assign_pointer(nfo_info->standby_dev, slave_dev);
+		dev_get_stats(nfo_info->standby_dev, &nfo_info->standby_stats);
+	} else {
+		rcu_assign_pointer(nfo_info->primary_dev, slave_dev);
+		dev_get_stats(nfo_info->primary_dev, &nfo_info->primary_stats);
+		failover_dev->min_mtu = slave_dev->min_mtu;
+		failover_dev->max_mtu = slave_dev->max_mtu;
+	}
+
+	net_failover_compute_features(failover_dev);
+
+	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
+
+	netdev_info(failover_dev, "failover %s slave:%s registered\n",
+		    slave_is_standby ? "standby" : "primary", slave_dev->name);
+
+	goto done;
+
+err_upper_link:
+	netdev_rx_handler_unregister(slave_dev);
+err_handler_register:
+	vlan_vids_del_by_dev(slave_dev, failover_dev);
+err_vlan_add:
+	dev_uc_unsync(slave_dev, failover_dev);
+	dev_mc_unsync(slave_dev, failover_dev);
+	dev_close(slave_dev);
+err_dev_open:
+	dev_put(slave_dev);
+	dev_set_mtu(slave_dev, orig_mtu);
+done:
+	return NOTIFY_DONE;
+}
+
+int net_failover_slave_unregister(struct net_device *slave_dev)
+{
+	struct net_device *standby_dev, *primary_dev;
+	struct net_failover_info *nfo_info;
+	struct net_failover_ops *nfo_ops;
+	struct net_device *failover_dev;
+	bool slave_is_standby;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
+	if (!failover_dev)
+		goto done;
+
+	if (nfo_ops && nfo_ops->slave_unregister)
+		return nfo_ops->slave_unregister(slave_dev, failover_dev);
+
+	nfo_info = netdev_priv(failover_dev);
+	primary_dev = rtnl_dereference(nfo_info->primary_dev);
+	standby_dev = rtnl_dereference(nfo_info->standby_dev);
+
+	if (slave_dev != primary_dev && slave_dev != standby_dev)
+		goto done;
+
+	slave_is_standby = (slave_dev->dev.parent == failover_dev->dev.parent);
+
+	netdev_rx_handler_unregister(slave_dev);
+	netdev_upper_dev_unlink(slave_dev, failover_dev);
+	vlan_vids_del_by_dev(slave_dev, failover_dev);
+	dev_uc_unsync(slave_dev, failover_dev);
+	dev_mc_unsync(slave_dev, failover_dev);
+	dev_close(slave_dev);
+	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
+
+	nfo_info = netdev_priv(failover_dev);
+	net_failover_get_stats(failover_dev, &nfo_info->failover_stats);
+
+	if (slave_is_standby) {
+		RCU_INIT_POINTER(nfo_info->standby_dev, NULL);
+	} else {
+		RCU_INIT_POINTER(nfo_info->primary_dev, NULL);
+		if (standby_dev) {
+			failover_dev->min_mtu = standby_dev->min_mtu;
+			failover_dev->max_mtu = standby_dev->max_mtu;
+		}
+	}
+
+	dev_put(slave_dev);
+
+	net_failover_compute_features(failover_dev);
+
+	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
+		    slave_is_standby ? "standby" : "primary", slave_dev->name);
+
+done:
+	return NOTIFY_DONE;
+}
+EXPORT_SYMBOL_GPL(net_failover_slave_unregister);
+
+static int net_failover_slave_link_change(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev, *primary_dev, *standby_dev;
+	struct net_failover_info *nfo_info;
+	struct net_failover_ops *nfo_ops;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
+	if (!failover_dev)
+		goto done;
+
+	if (nfo_ops && nfo_ops->slave_link_change)
+		return nfo_ops->slave_link_change(slave_dev, failover_dev);
+
+	if (!netif_running(failover_dev))
+		return 0;
+
+	nfo_info = netdev_priv(failover_dev);
+
+	primary_dev = rtnl_dereference(nfo_info->primary_dev);
+	standby_dev = rtnl_dereference(nfo_info->standby_dev);
+
+	if (slave_dev != primary_dev && slave_dev != standby_dev)
+		goto done;
+
+	if ((primary_dev && net_failover_xmit_ready(primary_dev)) ||
+	    (standby_dev && net_failover_xmit_ready(standby_dev))) {
+		netif_carrier_on(failover_dev);
+		netif_tx_wake_all_queues(failover_dev);
+	} else {
+		net_failover_get_stats(failover_dev, &nfo_info->failover_stats);
+		netif_carrier_off(failover_dev);
+		netif_tx_stop_all_queues(failover_dev);
+	}
+
+done:
+	return NOTIFY_DONE;
+}
+
+static int
+net_failover_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+
+	/* Skip parent events */
+	if (netif_is_failover(event_dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		return net_failover_slave_register(event_dev);
+	case NETDEV_UNREGISTER:
+		return net_failover_slave_unregister(event_dev);
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		return net_failover_slave_link_change(event_dev);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block net_failover_notifier = {
+	.notifier_call = net_failover_event,
+};
+
+static void nfo_register_existing_slave(struct net_device *failover_dev)
+{
+	struct net *net = dev_net(failover_dev);
+	struct net_device *dev;
+
+	rtnl_lock();
+	for_each_netdev(net, dev) {
+		if (netif_is_failover(dev))
+			continue;
+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
+			net_failover_slave_register(dev);
+	}
+	rtnl_unlock();
+}
+
+int net_failover_register(struct net_device *dev, struct net_failover_ops *ops,
+			  struct net_failover **pfailover)
+{
+	struct net_failover *failover;
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
+	spin_lock(&net_failover_lock);
+	list_add_tail(&failover->list, &net_failover_list);
+	spin_unlock(&net_failover_lock);
+
+	netdev_info(dev, "failover master:%s registered\n", dev->name);
+
+	nfo_register_existing_slave(dev);
+
+	*pfailover = failover;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(net_failover_register);
+
+void net_failover_unregister(struct net_failover *failover)
+{
+	struct net_device *failover_dev;
+
+	failover_dev = rcu_dereference(failover->failover_dev);
+
+	netdev_info(failover_dev, "failover master:%s unregistered\n",
+		    failover_dev->name);
+
+	failover_dev->priv_flags &= ~IFF_FAILOVER;
+	dev_put(failover_dev);
+
+	spin_lock(&net_failover_lock);
+	list_del(&failover->list);
+	spin_unlock(&net_failover_lock);
+
+	kfree(failover);
+}
+EXPORT_SYMBOL_GPL(net_failover_unregister);
+
+int net_failover_create(struct net_device *standby_dev,
+			struct net_failover **pfailover)
+{
+	struct device *dev = standby_dev->dev.parent;
+	struct net_device *failover_dev;
+	int err;
+
+	/* Alloc at least 2 queues, for now we are going with 16 assuming
+	 * that VF devices being enslaved won't have too many queues.
+	 */
+	failover_dev = alloc_etherdev_mq(sizeof(struct net_failover_info), 16);
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
+	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_CTAG_RX |
+				    NETIF_F_HW_VLAN_CTAG_FILTER;
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
+	err = net_failover_register(failover_dev, NULL, pfailover);
+	if (err < 0)
+		goto err_failover_register;
+
+	return 0;
+
+err_failover_register:
+	unregister_netdev(failover_dev);
+err_register_netdev:
+	free_netdev(failover_dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(net_failover_create);
+
+void net_failover_destroy(struct net_failover *failover)
+{
+	struct net_failover_info *nfo_info;
+	struct net_device *failover_dev;
+	struct net_device *slave_dev;
+
+	if (!failover)
+		return;
+
+	failover_dev = rcu_dereference(failover->failover_dev);
+	nfo_info = netdev_priv(failover_dev);
+
+	netif_device_detach(failover_dev);
+
+	rtnl_lock();
+
+	slave_dev = rtnl_dereference(nfo_info->primary_dev);
+	if (slave_dev)
+		net_failover_slave_unregister(slave_dev);
+
+	slave_dev = rtnl_dereference(nfo_info->standby_dev);
+	if (slave_dev)
+		net_failover_slave_unregister(slave_dev);
+
+	net_failover_unregister(failover);
+
+	unregister_netdevice(failover_dev);
+
+	rtnl_unlock();
+
+	free_netdev(failover_dev);
+}
+EXPORT_SYMBOL_GPL(net_failover_destroy);
+
+static __init int
+net_failover_init(void)
+{
+	register_netdevice_notifier(&net_failover_notifier);
+
+	return 0;
+}
+module_init(net_failover_init);
+
+static __exit
+void net_failover_exit(void)
+{
+	unregister_netdevice_notifier(&net_failover_notifier);
+}
+module_exit(net_failover_exit);
+
+MODULE_DESCRIPTION("Failover infrastructure/interface for Paravirtual drivers");
+MODULE_LICENSE("GPL v2");
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

