Return-Path: virtio-dev-return-3734-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ABEA58191B2
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Apr 2018 14:08:36 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  5 Apr 2018 14:08:22 -0700
Message-Id: <1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF datapath when available
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
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
---
 drivers/net/Kconfig      |   1 +
 drivers/net/virtio_net.c | 612 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 612 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 891846655000..9e2cf61fd1c1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -331,6 +331,7 @@ config VETH
 config VIRTIO_NET
 	tristate "Virtio network driver"
 	depends on VIRTIO
+	depends on MAY_USE_BYPASS
 	---help---
 	  This is the virtual network driver for virtio.  It can be used with
 	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index befb5944f3fd..86b2f8f2947d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -30,8 +30,11 @@
 #include <linux/cpu.h>
 #include <linux/average.h>
 #include <linux/filter.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
 #include <net/route.h>
 #include <net/xdp.h>
+#include <net/bypass.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -206,6 +209,9 @@ struct virtnet_info {
 	u32 speed;
 
 	unsigned long guest_offloads;
+
+	/* upper netdev created when BACKUP feature enabled */
+	struct net_device __rcu *bypass_netdev;
 };
 
 struct padded_vnet_hdr {
@@ -2275,6 +2281,22 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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
@@ -2292,6 +2314,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
 	.ndo_xdp_flush		= virtnet_xdp_flush,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -2689,6 +2712,576 @@ static int virtnet_validate(struct virtio_device *vdev)
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
+static int virtnet_bypass_open(struct net_device *dev)
+{
+	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct net_device *active_netdev, *backup_netdev;
+	int err;
+
+	netif_carrier_off(dev);
+	netif_tx_wake_all_queues(dev);
+
+	active_netdev = rtnl_dereference(vbi->active_netdev);
+	if (active_netdev) {
+		err = dev_open(active_netdev);
+		if (err)
+			goto err_active_open;
+	}
+
+	backup_netdev = rtnl_dereference(vbi->backup_netdev);
+	if (backup_netdev) {
+		err = dev_open(backup_netdev);
+		if (err)
+			goto err_backup_open;
+	}
+
+	return 0;
+
+err_backup_open:
+	dev_close(active_netdev);
+err_active_open:
+	netif_tx_disable(dev);
+	return err;
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
+	struct net_device *active_netdev, *backup_netdev;
+	int ret = 0;
+
+	active_netdev = rcu_dereference(vbi->active_netdev);
+	if (active_netdev) {
+		ret = dev_set_mtu(active_netdev, new_mtu);
+		if (ret)
+			return ret;
+	}
+
+	backup_netdev = rcu_dereference(vbi->backup_netdev);
+	if (backup_netdev) {
+		ret = dev_set_mtu(backup_netdev, new_mtu);
+		if (ret) {
+			dev_set_mtu(active_netdev, dev->mtu);
+			return ret;
+		}
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
+static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
+				     struct net_device *child_netdev)
+{
+	struct virtnet_bypass_info *vbi;
+	bool backup;
+
+	vbi = netdev_priv(bypass_netdev);
+	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
+	if (backup ? rtnl_dereference(vbi->backup_netdev) :
+			rtnl_dereference(vbi->active_netdev)) {
+		netdev_info(bypass_netdev,
+			    "%s attempting to join bypass dev when %s already present\n",
+			    child_netdev->name, backup ? "backup" : "active");
+		return -EEXIST;
+	}
+
+	dev_hold(child_netdev);
+
+	if (backup) {
+		rcu_assign_pointer(vbi->backup_netdev, child_netdev);
+		dev_get_stats(vbi->backup_netdev, &vbi->backup_stats);
+	} else {
+		rcu_assign_pointer(vbi->active_netdev, child_netdev);
+		dev_get_stats(vbi->active_netdev, &vbi->active_stats);
+		bypass_netdev->min_mtu = child_netdev->min_mtu;
+		bypass_netdev->max_mtu = child_netdev->max_mtu;
+	}
+
+	netdev_info(bypass_netdev, "child:%s joined\n", child_netdev->name);
+
+	return 0;
+}
+
+static int virtnet_bypass_register_child(struct net_device *bypass_netdev,
+					 struct net_device *child_netdev)
+{
+	struct virtnet_bypass_info *vbi;
+	bool backup;
+
+	vbi = netdev_priv(bypass_netdev);
+	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
+	if (backup ? rtnl_dereference(vbi->backup_netdev) :
+			rtnl_dereference(vbi->active_netdev)) {
+		netdev_info(bypass_netdev,
+			    "%s attempting to register bypass dev when %s already present\n",
+			    child_netdev->name, backup ? "backup" : "active");
+		return -EEXIST;
+	}
+
+	/* Avoid non pci devices as active netdev */
+	if (!backup && (!child_netdev->dev.parent ||
+			!dev_is_pci(child_netdev->dev.parent)))
+		return -EINVAL;
+
+	netdev_info(bypass_netdev, "child:%s registered\n", child_netdev->name);
+
+	return 0;
+}
+
+static int virtnet_bypass_release_child(struct net_device *bypass_netdev,
+					struct net_device *child_netdev)
+{
+	struct net_device *backup_netdev, *active_netdev;
+	struct virtnet_bypass_info *vbi;
+
+	vbi = netdev_priv(bypass_netdev);
+	active_netdev = rtnl_dereference(vbi->active_netdev);
+	backup_netdev = rtnl_dereference(vbi->backup_netdev);
+
+	if (child_netdev != active_netdev && child_netdev != backup_netdev)
+		return -EINVAL;
+
+	netdev_info(bypass_netdev, "child:%s released\n", child_netdev->name);
+
+	return 0;
+}
+
+static int virtnet_bypass_unregister_child(struct net_device *bypass_netdev,
+					   struct net_device *child_netdev)
+{
+	struct net_device *backup_netdev, *active_netdev;
+	struct virtnet_bypass_info *vbi;
+
+	vbi = netdev_priv(bypass_netdev);
+	active_netdev = rtnl_dereference(vbi->active_netdev);
+	backup_netdev = rtnl_dereference(vbi->backup_netdev);
+
+	if (child_netdev != active_netdev && child_netdev != backup_netdev)
+		return -EINVAL;
+
+	if (child_netdev == backup_netdev) {
+		RCU_INIT_POINTER(vbi->backup_netdev, NULL);
+	} else {
+		RCU_INIT_POINTER(vbi->active_netdev, NULL);
+		if (backup_netdev) {
+			bypass_netdev->min_mtu = backup_netdev->min_mtu;
+			bypass_netdev->max_mtu = backup_netdev->max_mtu;
+		}
+	}
+
+	dev_put(child_netdev);
+
+	netdev_info(bypass_netdev, "child:%s unregistered\n",
+		    child_netdev->name);
+
+	return 0;
+}
+
+static int virtnet_bypass_update_link(struct net_device *bypass_netdev,
+				      struct net_device *child_netdev)
+{
+	struct net_device *active_netdev, *backup_netdev;
+	struct virtnet_bypass_info *vbi;
+
+	if (!netif_running(bypass_netdev))
+		return 0;
+
+	vbi = netdev_priv(bypass_netdev);
+
+	active_netdev = rtnl_dereference(vbi->active_netdev);
+	backup_netdev = rtnl_dereference(vbi->backup_netdev);
+
+	if (child_netdev != active_netdev && child_netdev != backup_netdev)
+		return -EINVAL;
+
+	if ((active_netdev && virtnet_bypass_xmit_ready(active_netdev)) ||
+	    (backup_netdev && virtnet_bypass_xmit_ready(backup_netdev))) {
+		netif_carrier_on(bypass_netdev);
+		netif_tx_wake_all_queues(bypass_netdev);
+	} else {
+		netif_carrier_off(bypass_netdev);
+		netif_tx_stop_all_queues(bypass_netdev);
+	}
+
+	return 0;
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
+static const struct bypass_ops virtnet_bypass_ops = {
+	.register_child		= virtnet_bypass_register_child,
+	.join_child		= virtnet_bypass_join_child,
+	.unregister_child	= virtnet_bypass_unregister_child,
+	.release_child		= virtnet_bypass_release_child,
+	.update_link		= virtnet_bypass_update_link,
+	.handle_frame		= virtnet_bypass_handle_frame,
+};
+
+static struct bypass *virtnet_bypass;
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
+	bypass_netdev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
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
+		goto err_register_netdev;
+	}
+
+	netif_carrier_off(bypass_netdev);
+
+	res = bypass_register_instance(virtnet_bypass, bypass_netdev);
+	if (res < 0)
+		goto err_bypass;
+
+	rcu_assign_pointer(vi->bypass_netdev, bypass_netdev);
+
+	return 0;
+
+err_bypass:
+	unregister_netdev(bypass_netdev);
+err_register_netdev:
+	free_netdev(bypass_netdev);
+
+	return res;
+}
+
+static void virtnet_bypass_destroy(struct virtnet_info *vi)
+{
+	struct net_device *bypass_netdev;
+	struct virtnet_bypass_info *vbi;
+	struct net_device *child_netdev;
+
+	bypass_netdev = rcu_dereference(vi->bypass_netdev);
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
+		bypass_unregister_child(child_netdev);
+
+	child_netdev = rtnl_dereference(vbi->backup_netdev);
+	if (child_netdev)
+		bypass_unregister_child(child_netdev);
+
+	unregister_netdevice(bypass_netdev);
+
+	bypass_unregister_instance(virtnet_bypass, bypass_netdev);
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
@@ -2839,10 +3432,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -2879,6 +3477,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vi->vdev->config->reset(vdev);
 
 	unregister_netdev(dev);
+free_bypass:
+	virtnet_bypass_destroy(vi);
 free_vqs:
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
@@ -2913,6 +3513,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	unregister_netdev(vi->dev);
 
+	virtnet_bypass_destroy(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
@@ -2996,6 +3598,11 @@ static __init int virtio_net_driver_init(void)
 {
 	int ret;
 
+	virtnet_bypass = bypass_register_driver(&virtnet_bypass_ops,
+						&virtnet_bypass_netdev_ops);
+	if (!virtnet_bypass)
+		return -ENOMEM;
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "virtio/net:online",
 				      virtnet_cpu_online,
 				      virtnet_cpu_down_prep);
@@ -3010,12 +3617,14 @@ static __init int virtio_net_driver_init(void)
         ret = register_virtio_driver(&virtio_net_driver);
 	if (ret)
 		goto err_virtio;
+
 	return 0;
 err_virtio:
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 err_dead:
 	cpuhp_remove_multi_state(virtionet_online);
 out:
+	bypass_unregister_driver(virtnet_bypass);
 	return ret;
 }
 module_init(virtio_net_driver_init);
@@ -3025,6 +3634,7 @@ static __exit void virtio_net_driver_exit(void)
 	unregister_virtio_driver(&virtio_net_driver);
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 	cpuhp_remove_multi_state(virtionet_online);
+	bypass_unregister_driver(virtnet_bypass);
 }
 module_exit(virtio_net_driver_exit);
 
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

