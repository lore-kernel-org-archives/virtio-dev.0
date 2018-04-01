Return-Path: virtio-dev-return-3692-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D49DE58191D8
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Apr 2018 02:33:40 -0700 (PDT)
From: Si-Wei Liu <si-wei.liu@oracle.com>
Date: Sun,  1 Apr 2018 05:13:10 -0400
Message-Id: <1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] [RFC PATCH 3/3] virtio_net: make lower netdevs for virtio_bypass hidden
To: mst@redhat.com, jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

We should move virtio_bypass to a 1-upper-with-2-hidden-lower
driver model for greater compatibility with regard to preserving
userpsace API and ABI.

On the other hand, technically virtio_bypass should make stricter
check before automatically enslaving the corresponding virtual
function or passthrough device. It's more reasonable to pair
virtio_bypass instance with a VF or passthrough device 1:1,
rather than rely on searching for a random non-virtio netdev with
exact same MAC address. One possible way of doing it is to bind
virtio_bypass explicitly to a guest pci device by specifying
its <bus> and <slot>:<function> location. Changing BACKUP feature
to take these configs into account, such that verifying target
device for auto-enslavement no longer relies on the MAC address.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/net/virtio_net.c        | 159 ++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |   2 +
 2 files changed, 148 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f850cf6..c54a5bd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -77,6 +77,8 @@ struct virtnet_stats {
 	u64 rx_packets;
 };
 
+static struct workqueue_struct *virtnet_bypass_wq;
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -196,6 +198,13 @@ struct padded_vnet_hdr {
 	char padding[4];
 };
 
+struct virtnet_bypass_task {
+	struct work_struct	work;
+	unsigned long		event; 
+	struct net_device	*child_netdev;
+	struct net_device	*bypass_netdev;
+};
+
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -2557,6 +2566,11 @@ struct virtnet_bypass_info {
 
 	/* spinlock while updating stats */
 	spinlock_t stats_lock;
+
+	int bus;
+	int slot;
+	int function;
+
 };
 
 static void virtnet_bypass_child_open(struct net_device *dev,
@@ -2822,10 +2836,13 @@ static void virtnet_bypass_ethtool_get_drvinfo(struct net_device *dev,
 	.get_link_ksettings     = virtnet_bypass_ethtool_get_link_ksettings,
 };
 
-static struct net_device *get_virtnet_bypass_bymac(struct net *net,
-						   const u8 *mac)
+static struct net_device *
+get_virtnet_bypass_bymac(struct net_device *child_netdev)
 {
+	struct net *net = dev_net(child_netdev);
 	struct net_device *dev;
+	struct virtnet_bypass_info *vbi;
+	int devfn;
 
 	ASSERT_RTNL();
 
@@ -2833,7 +2850,29 @@ static struct net_device *get_virtnet_bypass_bymac(struct net *net,
 		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
 			continue;       /* not a virtnet_bypass device */
 
-		if (ether_addr_equal(mac, dev->perm_addr))
+		if (!ether_addr_equal(child_netdev->dev_addr, dev->perm_addr))
+			continue;       /* not matching MAC address */
+
+		if (!child_netdev->dev.parent)
+			continue;
+
+		/* Is child_netdev a backup netdev ? */
+		if (child_netdev->dev.parent == dev->dev.parent)
+			return dev;
+
+		/* Avoid non pci devices as active netdev */
+		if (!dev_is_pci(child_netdev->dev.parent))
+			continue;
+
+		vbi = netdev_priv(dev);
+		devfn = PCI_DEVFN(vbi->slot, vbi->function);
+
+		netdev_info(dev, "bus %d slot %d func %d",
+			    vbi->bus, vbi->slot, vbi->function);
+
+		/* Need to match <bus>:<slot>.<function> */
+		if (pci_get_bus_and_slot(vbi->bus, devfn) ==
+		    to_pci_dev(child_netdev->dev.parent))
 			return dev;
 	}
 
@@ -2878,10 +2917,61 @@ static rx_handler_result_t virtnet_bypass_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_ANOTHER;
 }
 
+static int virtnet_bypass_pregetname_child(struct net_device *child_netdev)
+{
+	struct net_device *dev;
+
+	if (child_netdev->addr_len != ETH_ALEN)
+		return NOTIFY_DONE;
+
+	/* We will use the MAC address to locate the virtnet_bypass netdev
+	 * to associate with the child netdev. If we don't find a matching
+	 * bypass netdev, move on.
+	 */
+	dev = get_virtnet_bypass_bymac(child_netdev);
+	if (!dev)
+		return NOTIFY_DONE;
+
+	if (child_netdev->dev.parent &&
+	    child_netdev->dev.parent != dev->dev.parent);
+		netdev_set_hidden(child_netdev);
+
+	return NOTIFY_OK;
+}
+
+static void virtnet_bypass_task_fn(struct work_struct *work)
+{
+	struct virtnet_bypass_task *task;
+	struct net_device *child_netdev;
+	int rc;
+
+	task = container_of(work, struct virtnet_bypass_task, work);
+	child_netdev = task->child_netdev;
+
+	switch (task->event) {
+	case NETDEV_REGISTER:
+		rc = hide_netdevice(child_netdev);
+		if (rc)
+			netdev_err(child_netdev,
+				   "hide netdev %s failed with error %#x",
+				   child_netdev->name, rc);
+
+		break;
+	case NETDEV_UNREGISTER:
+		unhide_netdevice(child_netdev);
+		break;
+	default:
+		break;
+	}
+	dev_put(child_netdev);
+	kfree(task);
+}
+
 static int virtnet_bypass_register_child(struct net_device *child_netdev)
 {
 	struct virtnet_bypass_info *vbi;
 	struct net_device *dev;
+	struct virtnet_bypass_task *task;
 	bool backup;
 	int ret;
 
@@ -2892,25 +2982,34 @@ static int virtnet_bypass_register_child(struct net_device *child_netdev)
 	 * to associate with the child netdev. If we don't find a matching
 	 * bypass netdev, move on.
 	 */
-	dev = get_virtnet_bypass_bymac(dev_net(child_netdev),
-				       child_netdev->perm_addr);
+	dev = get_virtnet_bypass_bymac(child_netdev);
 	if (!dev)
 		return NOTIFY_DONE;
 
 	vbi = netdev_priv(dev);
 	backup = (child_netdev->dev.parent == dev->dev.parent);
 	if (backup ? rtnl_dereference(vbi->backup_netdev) :
-			rtnl_dereference(vbi->active_netdev)) {
+		     rtnl_dereference(vbi->active_netdev)) {
 		netdev_info(dev,
 			    "%s attempting to join bypass dev when %s already present\n",
 			    child_netdev->name, backup ? "backup" : "active");
 		return NOTIFY_DONE;
 	}
 
-	/* Avoid non pci devices as active netdev */
-	if (!backup && (!child_netdev->dev.parent ||
-			!dev_is_pci(child_netdev->dev.parent)))
-		return NOTIFY_DONE;
+	/* Verify <bus>:<slot>.<function> info */
+	if (!backup && !(child_netdev->priv_flags & IFF_HIDDEN)) {
+		task = kzalloc(sizeof(*task), GFP_ATOMIC);
+		if (!task)
+			return NOTIFY_DONE;
+		task->event = NETDEV_REGISTER;
+		task->bypass_netdev = dev;
+		task->child_netdev = child_netdev;
+		INIT_WORK(&task->work, virtnet_bypass_task_fn);
+		queue_work(virtnet_bypass_wq, &task->work);
+		dev_hold(child_netdev);
+
+		return NOTIFY_OK;
+	}
 
 	ret = netdev_rx_handler_register(child_netdev,
 					 virtnet_bypass_handle_frame, dev);
@@ -2981,6 +3080,7 @@ static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
 {
 	struct virtnet_bypass_info *vbi;
 	struct net_device *dev, *backup;
+	struct virtnet_bypass_task *task;
 
 	dev = get_virtnet_bypass_byref(child_netdev);
 	if (!dev)
@@ -3003,6 +3103,16 @@ static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
 			dev->min_mtu = backup->min_mtu;
 			dev->max_mtu = backup->max_mtu;
 		}
+
+		task = kzalloc(sizeof(*task), GFP_ATOMIC);
+		if (task) {
+			task->event = NETDEV_UNREGISTER;
+			task->bypass_netdev = dev;
+			task->child_netdev = child_netdev;
+			INIT_WORK(&task->work, virtnet_bypass_task_fn);
+			queue_work(virtnet_bypass_wq, &task->work);
+			dev_hold(child_netdev);
+		}
 	}
 
 	dev_put(child_netdev);
@@ -3059,6 +3169,8 @@ static int virtnet_bypass_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_PRE_GETNAME:
+		return virtnet_bypass_pregetname_child(event_dev);
 	case NETDEV_REGISTER:
 		return virtnet_bypass_register_child(event_dev);
 	case NETDEV_UNREGISTER:
@@ -3076,11 +3188,12 @@ static int virtnet_bypass_event(struct notifier_block *this,
 	.notifier_call = virtnet_bypass_event,
 };
 
-static int virtnet_bypass_create(struct virtnet_info *vi)
+static int virtnet_bypass_create(struct virtnet_info *vi, int bsf)
 {
 	struct net_device *backup_netdev = vi->dev;
 	struct device *dev = &vi->vdev->dev;
 	struct net_device *bypass_netdev;
+	struct virtnet_bypass_info *vbi;
 	int res;
 
 	/* Alloc at least 2 queues, for now we are going with 16 assuming
@@ -3095,6 +3208,11 @@ static int virtnet_bypass_create(struct virtnet_info *vi)
 
 	dev_net_set(bypass_netdev, dev_net(backup_netdev));
 	SET_NETDEV_DEV(bypass_netdev, dev);
+	vbi = netdev_priv(bypass_netdev);
+
+	vbi->bus = (bsf >> 8) & 0xFF;
+	vbi->slot = (bsf >> 3) & 0x1F;
+	vbi->function = bsf & 0x7;
 
 	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
 	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;
@@ -3183,7 +3301,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	struct net_device *dev;
 	struct virtnet_info *vi;
 	u16 max_queue_pairs;
-	int mtu;
+	int mtu, bsf;
 
 	/* Find if host supports multiqueue virtio_net device */
 	err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
@@ -3339,8 +3457,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 	virtnet_init_settings(dev);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_BACKUP)) {
-		if (virtnet_bypass_create(vi) != 0)
+		bsf = virtio_cread16(vdev,
+				     offsetof(struct virtio_net_config,
+					      bsf2backup));
+		if (virtnet_bypass_create(vi, bsf) != 0)
 			goto free_vqs;
+		netdev_set_hidden(dev); 
 	}
 
 	err = register_netdev(dev);
@@ -3384,6 +3506,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	unregister_netdev(dev);
 free_bypass:
 	virtnet_bypass_destroy(vi);
+
 free_vqs:
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
@@ -3517,6 +3640,12 @@ static __init int virtio_net_driver_init(void)
 	if (ret)
 		goto err_dead;
 
+	virtnet_bypass_wq = create_singlethread_workqueue("virtio_bypass");
+	if (!virtnet_bypass_wq) {
+		ret = -ENOMEM;
+		goto err_wq;
+	}
+
         ret = register_virtio_driver(&virtio_net_driver);
 	if (ret)
 		goto err_virtio;
@@ -3524,6 +3653,8 @@ static __init int virtio_net_driver_init(void)
 	register_netdevice_notifier(&virtnet_bypass_notifier);
 	return 0;
 err_virtio:
+	destroy_workqueue(virtnet_bypass_wq);
+err_wq:
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 err_dead:
 	cpuhp_remove_multi_state(virtionet_online);
@@ -3535,6 +3666,8 @@ static __init int virtio_net_driver_init(void)
 static __exit void virtio_net_driver_exit(void)
 {
 	unregister_netdevice_notifier(&virtnet_bypass_notifier);
+	if (virtnet_bypass_wq)
+		destroy_workqueue(virtnet_bypass_wq);
 	unregister_virtio_driver(&virtio_net_driver);
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
 	cpuhp_remove_multi_state(virtionet_online);
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index aa40664..0827b7e 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -80,6 +80,8 @@ struct virtio_net_config {
 	__u16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	__u16 mtu;
+	/* Device at bus:slot.function backed up by virtio_net */
+	__u16 bsf2backup;
 } __attribute__((packed));
 
 /*
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

