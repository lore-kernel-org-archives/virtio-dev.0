Return-Path: virtio-dev-return-3793-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F1CA1CB80ED
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 12:00:02 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue, 10 Apr 2018 11:59:49 -0700
Message-Id: <1523386790-12396-4-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v6 3/4] virtio_net: Extend virtio to use VF datapath when available
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

It uses the generic bypass framework that provides 2 functions to create
and destroy a master bypass netdev. When BACKUP feature is enabled, an
additional netdev(bypass netdev) is created that acts as a master device
and tracks the state of the 2 lower netdevs. The original virtio_net netdev
is marked as 'backup' netdev and a passthru device with the same MAC is
registered as 'active' netdev.

This patch is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/virtio_net.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

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
index befb5944f3fd..99aa52d5ac9b 100644
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
+	/* bypass_master created when BACKUP feature enabled */
+	struct bypass_master *bypass_master;
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
@@ -2839,10 +2862,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtnet_init_settings(dev);
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_BACKUP)) {
+		err = bypass_master_create(vi->dev, &vi->bypass_master);
+		if (err)
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
@@ -2879,6 +2908,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vi->vdev->config->reset(vdev);
 
 	unregister_netdev(dev);
+free_bypass:
+	bypass_master_destroy(vi->bypass_master);
 free_vqs:
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
@@ -2913,6 +2944,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	unregister_netdev(vi->dev);
 
+	bypass_master_destroy(vi->bypass_master);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
@@ -3010,6 +3043,7 @@ static __init int virtio_net_driver_init(void)
         ret = register_virtio_driver(&virtio_net_driver);
 	if (ret)
 		goto err_virtio;
+
 	return 0;
 err_virtio:
 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

