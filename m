Return-Path: virtio-dev-return-3231-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1837F5818097
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2018 10:11:26 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Fri, 16 Feb 2018 10:11:22 -0800
Message-Id: <1518804682-16881-4-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH v3 3/3] virtio_net: Enable alternate datapath without creating an additional netdev
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch addresses the issues that were seen with the 3 netdev model by
avoiding the creation of an additional netdev. Instead the bypass state
information is tracked in the original netdev and a different set of
ndo_ops and ethtool_ops are used when BACKUP feature is enabled.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com> 
---
 drivers/net/virtio_net.c | 283 +++++++++++++++++------------------------------
 1 file changed, 101 insertions(+), 182 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 14679806c1b1..c85b2949f151 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -154,7 +154,7 @@ struct virtnet_bypass_info {
 	struct net_device __rcu *active_netdev;
 
 	/* virtio_net netdev */
-	struct net_device __rcu *backup_netdev;
+	struct net_device *backup_netdev;
 
 	/* active netdev stats */
 	struct rtnl_link_stats64 active_stats;
@@ -229,8 +229,8 @@ struct virtnet_info {
 
 	unsigned long guest_offloads;
 
-	/* upper netdev created when BACKUP feature enabled */
-	struct net_device *bypass_netdev;
+	/* bypass state maintained when BACKUP feature is enabled */
+	struct virtnet_bypass_info *vbi;
 };
 
 struct padded_vnet_hdr {
@@ -2285,6 +2285,22 @@ static bool virtnet_bypass_xmit_ready(struct net_device *dev)
 	return netif_running(dev) && netif_carrier_ok(dev);
 }
 
+static bool virtnet_bypass_active_ready(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
+	struct net_device *active;
+
+	if (!vbi)
+		return false;
+
+	active = rcu_dereference(vbi->active_netdev);
+	if (!active || !virtnet_bypass_xmit_ready(active))
+		return false;
+
+	return true;
+}
+
 static void virtnet_config_changed_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2312,7 +2328,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
 		virtnet_update_settings(vi);
 		netif_carrier_on(vi->dev);
 		netif_tx_wake_all_queues(vi->dev);
-	} else {
+	} else if (!virtnet_bypass_active_ready(vi->dev)) {
 		netif_carrier_off(vi->dev);
 		netif_tx_stop_all_queues(vi->dev);
 	}
@@ -2501,7 +2517,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	if (vi->has_cvq) {
 		vi->cvq = vqs[total_vqs - 1];
-		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN) &&
+		    !virtio_has_feature(vi->vdev, VIRTIO_NET_F_BACKUP))
 			vi->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	}
 
@@ -2690,62 +2707,54 @@ virtnet_bypass_child_open(struct net_device *dev,
 
 static int virtnet_bypass_open(struct net_device *dev)
 {
-	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *child_netdev;
-
-	netif_carrier_off(dev);
-	netif_tx_wake_all_queues(dev);
+	int err;
 
 	child_netdev = rtnl_dereference(vbi->active_netdev);
 	if (child_netdev)
 		virtnet_bypass_child_open(dev, child_netdev);
 
-	child_netdev = rtnl_dereference(vbi->backup_netdev);
-	if (child_netdev)
-		virtnet_bypass_child_open(dev, child_netdev);
+	err = virtnet_open(dev);
+	if (err < 0) {
+		dev_close(child_netdev);
+		return err;
+	}
 
 	return 0;
 }
 
 static int virtnet_bypass_close(struct net_device *dev)
 {
-	struct virtnet_bypass_info *vi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *child_netdev;
 
-	netif_tx_disable(dev);
+	virtnet_close(dev);
 
-	child_netdev = rtnl_dereference(vi->active_netdev);
-	if (child_netdev)
-		dev_close(child_netdev);
+	if (!vbi)
+		goto done;
 
-	child_netdev = rtnl_dereference(vi->backup_netdev);
+	child_netdev = rtnl_dereference(vbi->active_netdev);
 	if (child_netdev)
 		dev_close(child_netdev);
 
+done:
 	return 0;
 }
 
-static netdev_tx_t
-virtnet_bypass_drop_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	atomic_long_inc(&dev->tx_dropped);
-	dev_kfree_skb_any(skb);
-	return NETDEV_TX_OK;
-}
-
 static netdev_tx_t
 virtnet_bypass_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *xmit_dev;
 
 	/* Try xmit via active netdev followed by backup netdev */
 	xmit_dev = rcu_dereference_bh(vbi->active_netdev);
-	if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev)) {
-		xmit_dev = rcu_dereference_bh(vbi->backup_netdev);
-		if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev))
-			return virtnet_bypass_drop_xmit(skb, dev);
-	}
+	if (!xmit_dev || !virtnet_bypass_xmit_ready(xmit_dev))
+		return start_xmit(skb, dev);
 
 	skb->dev = xmit_dev;
 	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
@@ -2810,7 +2819,8 @@ static void
 virtnet_bypass_get_stats(struct net_device *dev,
 			 struct rtnl_link_stats64 *stats)
 {
-	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	const struct rtnl_link_stats64 *new;
 	struct rtnl_link_stats64 temp;
 	struct net_device *child_netdev;
@@ -2827,12 +2837,10 @@ virtnet_bypass_get_stats(struct net_device *dev,
 		memcpy(&vbi->active_stats, new, sizeof(*new));
 	}
 
-	child_netdev = rcu_dereference(vbi->backup_netdev);
-	if (child_netdev) {
-		new = dev_get_stats(child_netdev, &temp);
-		virtnet_bypass_fold_stats(stats, new, &vbi->backup_stats);
-		memcpy(&vbi->backup_stats, new, sizeof(*new));
-	}
+	memset(&temp, 0, sizeof(temp));
+	virtnet_stats(vbi->backup_netdev, &temp);
+	virtnet_bypass_fold_stats(stats, &temp, &vbi->backup_stats);
+	memcpy(&vbi->backup_stats, &temp, sizeof(temp));
 
 	rcu_read_unlock();
 
@@ -2842,7 +2850,8 @@ virtnet_bypass_get_stats(struct net_device *dev,
 
 static int virtnet_bypass_change_mtu(struct net_device *dev, int new_mtu)
 {
-	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *child_netdev;
 	int ret = 0;
 
@@ -2853,15 +2862,6 @@ static int virtnet_bypass_change_mtu(struct net_device *dev, int new_mtu)
 			return ret;
 	}
 
-	child_netdev = rcu_dereference(vbi->backup_netdev);
-	if (child_netdev) {
-		ret = dev_set_mtu(child_netdev, new_mtu);
-		if (ret)
-			netdev_err(child_netdev,
-				   "Unexpected failure to set mtu to %d\n",
-				   new_mtu);
-	}
-
 	dev->mtu = new_mtu;
 	return 0;
 }
@@ -2881,20 +2881,13 @@ static int
 virtnet_bypass_ethtool_get_link_ksettings(struct net_device *dev,
 					  struct ethtool_link_ksettings *cmd)
 {
-	struct virtnet_bypass_info *vbi = netdev_priv(dev);
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *child_netdev;
 
 	child_netdev = rtnl_dereference(vbi->active_netdev);
-	if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
-		child_netdev = rtnl_dereference(vbi->backup_netdev);
-		if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
-			cmd->base.duplex = DUPLEX_UNKNOWN;
-			cmd->base.port = PORT_OTHER;
-			cmd->base.speed = SPEED_UNKNOWN;
-
-			return 0;
-		}
-	}
+	if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev))
+		return virtnet_get_link_ksettings(dev, cmd);
 
 	return __ethtool_get_link_ksettings(child_netdev, cmd);
 }
@@ -2944,14 +2937,15 @@ get_virtnet_bypass_byref(struct net_device *child_netdev)
 
 	for_each_netdev(net, dev) {
 		struct virtnet_bypass_info *vbi;
+		struct virtnet_info *vi;
 
 		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
 			continue;       /* not a virtnet_bypass device */
 
-		vbi = netdev_priv(dev);
+		vi = netdev_priv(dev);
+		vbi = vi->vbi;
 
-		if ((rtnl_dereference(vbi->active_netdev) == child_netdev) ||
-		    (rtnl_dereference(vbi->backup_netdev) == child_netdev))
+		if (rtnl_dereference(vbi->active_netdev) == child_netdev)
 			return dev;	/* a match */
 	}
 
@@ -2974,9 +2968,9 @@ static rx_handler_result_t virtnet_bypass_handle_frame(struct sk_buff **pskb)
 
 static int virtnet_bypass_register_child(struct net_device *child_netdev)
 {
+	struct net_device *dev, *active;
 	struct virtnet_bypass_info *vbi;
-	struct net_device *dev;
-	bool backup;
+	struct virtnet_info *vi;
 	int ret;
 
 	if (child_netdev->addr_len != ETH_ALEN)
@@ -2991,14 +2985,14 @@ static int virtnet_bypass_register_child(struct net_device *child_netdev)
 	if (!dev)
 		return NOTIFY_DONE;
 
-	vbi = netdev_priv(dev);
-	backup = (child_netdev->dev.parent == dev->dev.parent);
-	if (backup ? rtnl_dereference(vbi->backup_netdev) :
-			rtnl_dereference(vbi->active_netdev)) {
+	vi = netdev_priv(dev);
+	vbi = vi->vbi;
+
+	active = rtnl_dereference(vbi->active_netdev);
+	if (active) {
 		netdev_info(dev,
 		  "%s attempting to join bypass dev when %s already present\n",
-			child_netdev->name,
-			backup ? "backup" : "active");
+		  child_netdev->name, active->name);
 		return NOTIFY_DONE;
 	}
 
@@ -3030,7 +3024,7 @@ static int virtnet_bypass_register_child(struct net_device *child_netdev)
 		}
 	}
 
-	/* Align MTU of child with master */
+	/* Align MTU of child with virtio */
 	ret = dev_set_mtu(child_netdev, dev->mtu);
 	if (ret) {
 		netdev_err(dev,
@@ -3044,15 +3038,10 @@ static int virtnet_bypass_register_child(struct net_device *child_netdev)
 	netdev_info(dev, "registering %s\n", child_netdev->name);
 
 	dev_hold(child_netdev);
-	if (backup) {
-		rcu_assign_pointer(vbi->backup_netdev, child_netdev);
-		dev_get_stats(vbi->backup_netdev, &vbi->backup_stats);
-	} else {
-		rcu_assign_pointer(vbi->active_netdev, child_netdev);
-		dev_get_stats(vbi->active_netdev, &vbi->active_stats);
-		dev->min_mtu = child_netdev->min_mtu;
-		dev->max_mtu = child_netdev->max_mtu;
-	}
+	rcu_assign_pointer(vbi->active_netdev, child_netdev);
+	dev_get_stats(vbi->active_netdev, &vbi->active_stats);
+	dev->min_mtu = child_netdev->min_mtu;
+	dev->max_mtu = child_netdev->max_mtu;
 
 	return NOTIFY_OK;
 
@@ -3070,13 +3059,15 @@ static int virtnet_bypass_register_child(struct net_device *child_netdev)
 static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
 {
 	struct virtnet_bypass_info *vbi;
-	struct net_device *dev, *backup;
+	struct virtnet_info *vi;
+	struct net_device *dev;
 
 	dev = get_virtnet_bypass_byref(child_netdev);
 	if (!dev)
 		return NOTIFY_DONE;
 
-	vbi = netdev_priv(dev);
+	vi = netdev_priv(dev);
+	vbi = vi->vbi;
 
 	netdev_info(dev, "unregistering %s\n", child_netdev->name);
 
@@ -3084,41 +3075,35 @@ static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
 	netdev_upper_dev_unlink(child_netdev, dev);
 	child_netdev->flags &= ~IFF_SLAVE;
 
-	if (child_netdev->dev.parent == dev->dev.parent) {
-		RCU_INIT_POINTER(vbi->backup_netdev, NULL);
-	} else {
-		RCU_INIT_POINTER(vbi->active_netdev, NULL);
-		backup = rtnl_dereference(vbi->backup_netdev);
-		if (backup) {
-			dev->min_mtu = backup->min_mtu;
-			dev->max_mtu = backup->max_mtu;
-		}
-	}
+	RCU_INIT_POINTER(vbi->active_netdev, NULL);
+	dev->min_mtu = MIN_MTU;
+	dev->max_mtu = MAX_MTU;
 
 	dev_put(child_netdev);
 
+	if (!(vi->status & VIRTIO_NET_S_LINK_UP)) {
+		netif_carrier_off(dev);
+		netif_tx_stop_all_queues(dev);
+	}
+
 	return NOTIFY_OK;
 }
 
 static int virtnet_bypass_update_link(struct net_device *child_netdev)
 {
-	struct net_device *dev, *active, *backup;
-	struct virtnet_bypass_info *vbi;
+	struct virtnet_info *vi;
+	struct net_device *dev;
 
 	dev = get_virtnet_bypass_byref(child_netdev);
-	if (!dev || !netif_running(dev))
+	if (!dev)
 		return NOTIFY_DONE;
 
-	vbi = netdev_priv(dev);
-
-	active = rtnl_dereference(vbi->active_netdev);
-	backup = rtnl_dereference(vbi->backup_netdev);
+	vi = netdev_priv(dev);
 
-	if ((active && virtnet_bypass_xmit_ready(active)) ||
-	    (backup && virtnet_bypass_xmit_ready(backup))) {
+	if (virtnet_bypass_xmit_ready(child_netdev)) {
 		netif_carrier_on(dev);
 		netif_tx_wake_all_queues(dev);
-	} else {
+	} else if (!(vi->status & VIRTIO_NET_S_LINK_UP)) {
 		netif_carrier_off(dev);
 		netif_tx_stop_all_queues(dev);
 	}
@@ -3169,107 +3154,41 @@ static struct notifier_block virtnet_bypass_notifier = {
 
 static int virtnet_bypass_create(struct virtnet_info *vi)
 {
-	struct net_device *backup_netdev = vi->dev;
-	struct device *dev = &vi->vdev->dev;
-	struct net_device *bypass_netdev;
-	int res;
+	struct net_device *dev = vi->dev;
+	struct virtnet_bypass_info *vbi;
 
-	/* Alloc at least 2 queues, for now we are going with 16 assuming
-	 * that most devices being bonded won't have too many queues.
-	 */
-	bypass_netdev = alloc_etherdev_mq(sizeof(struct virtnet_bypass_info),
-					  16);
-	if (!bypass_netdev) {
-		dev_err(dev, "Unable to allocate bypass_netdev!\n");
+	vbi = kzalloc(sizeof(*vbi), GFP_KERNEL);
+	if (!vbi)
 		return -ENOMEM;
-	}
-
-	dev_net_set(bypass_netdev, dev_net(backup_netdev));
-	SET_NETDEV_DEV(bypass_netdev, dev);
-
-	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
-	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;
-
-	/* Initialize the device options */
-	bypass_netdev->flags |= IFF_MASTER;
-	bypass_netdev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT |
-				     IFF_NO_QUEUE;
-	bypass_netdev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
-				       IFF_TX_SKB_SHARING);
-
-	/* don't acquire bypass netdev's netif_tx_lock when transmitting */
-	bypass_netdev->features |= NETIF_F_LLTX;
-
-	/* Don't allow bypass devices to change network namespaces. */
-	bypass_netdev->features |= NETIF_F_NETNS_LOCAL;
-
-	bypass_netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
-				     NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |
-				     NETIF_F_HIGHDMA | NETIF_F_LRO;
-
-	bypass_netdev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
-	bypass_netdev->features |= bypass_netdev->hw_features;
-
-	/* For now treat bypass netdev as VLAN challenged since we
-	 * cannot assume VLAN functionality with a VF
-	 */
-	bypass_netdev->features |= NETIF_F_VLAN_CHALLENGED;
-
-	memcpy(bypass_netdev->dev_addr, backup_netdev->dev_addr,
-	       bypass_netdev->addr_len);
 
-	bypass_netdev->min_mtu = backup_netdev->min_mtu;
-	bypass_netdev->max_mtu = backup_netdev->max_mtu;
+	dev->netdev_ops = &virtnet_bypass_netdev_ops;
+	dev->ethtool_ops = &virtnet_bypass_ethtool_ops;
 
-	res = register_netdev(bypass_netdev);
-	if (res < 0) {
-		dev_err(dev, "Unable to register bypass_netdev!\n");
-		free_netdev(bypass_netdev);
-		return res;
-	}
-
-	netif_carrier_off(bypass_netdev);
-
-	vi->bypass_netdev = bypass_netdev;
-
-	/* Change the name of the backup interface to vbkup0
-	 * we may need to revisit naming later but this gets it out
-	 * of the way for now.
-	 */
-	strcpy(backup_netdev->name, "vbkup%d");
+	vbi->backup_netdev = dev;
+	virtnet_stats(vbi->backup_netdev, &vbi->backup_stats);
+	vi->vbi = vbi;
 
 	return 0;
 }
 
 static void virtnet_bypass_destroy(struct virtnet_info *vi)
 {
-	struct net_device *bypass_netdev = vi->bypass_netdev;
-	struct virtnet_bypass_info *vbi;
+	struct virtnet_bypass_info *vbi = vi->vbi;
 	struct net_device *child_netdev;
 
-	/* no device found, nothing to free */
-	if (!bypass_netdev)
+	if (!vbi)
 		return;
 
-	vbi = netdev_priv(bypass_netdev);
-
-	netif_device_detach(bypass_netdev);
-
 	rtnl_lock();
 
 	child_netdev = rtnl_dereference(vbi->active_netdev);
 	if (child_netdev)
 		virtnet_bypass_unregister_child(child_netdev);
 
-	child_netdev = rtnl_dereference(vbi->backup_netdev);
-	if (child_netdev)
-		virtnet_bypass_unregister_child(child_netdev);
-
-	unregister_netdevice(bypass_netdev);
-
 	rtnl_unlock();
 
-	free_netdev(bypass_netdev);
+	kfree(vbi);
+	vi->vbi = NULL;
 }
 
 static int virtnet_probe(struct virtio_device *vdev)
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

