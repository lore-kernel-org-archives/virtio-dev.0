Return-Path: virtio-dev-return-4105-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 157B958191B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 May 2018 19:06:27 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Mon, 21 May 2018 19:06:21 -0700
Message-Id: <1526954781-35359-6-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH net-next v11 5/5] virtio_net: Extend virtio to use VF datapath when available
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch enables virtio_net to switch over to a VF datapath when STANDBY
feature is enabled and a VF netdev is present with the same MAC address.
It allows live migration of a VM with a direct attached VF without the need
to setup a bond/team between a VF and virtio net device in the guest.

It uses the API that is exported by the net_failover driver to create and
and destroy a master failover netdev. When STANDBY feature is enabled, an
additional netdev(failover netdev) is created that acts as a master device
and tracks the state of the 2 lower netdevs. The original virtio_net netdev
is marked as 'standby' netdev and a passthru device with the same MAC is
registered as 'primary' netdev.

The hypervisor needs to unplug the VF device from the guest on the source
host and reset the MAC filter of the VF to initiate failover of datapath
to virtio before starting the migration. After the migration is completed,
the destination hypervisor sets the MAC filter on the VF and plugs it back
to the guest to switch over to VF datapath.

This patch is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/networking/net_failover.rst | 90 +++++++++++++++++++++++++++++++
 drivers/net/Kconfig                       |  1 +
 drivers/net/virtio_net.c                  | 38 ++++++++++++-
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_failover.rst b/Documentation/networking/net_failover.rst
index 6764c3b1eec8..3ad8376f8fa7 100644
--- a/Documentation/networking/net_failover.rst
+++ b/Documentation/networking/net_failover.rst
@@ -24,3 +24,93 @@ This can be used by paravirtual drivers to enable an alternate low latency
 datapath. It also enables hypervisor controlled live migration of a VM with
 direct attached VF by failing over to the paravirtual datapath when the VF
 is unplugged.
+
+virtio-net accelerated datapath: STANDBY mode
+=============================================
+
+net_failover enables hypervisor controlled accelerated datapath to virtio-net
+enabled VMs in a transparent manner with no/minimal guest userspace chanages.
+
+To support this, the hypervisor needs to enable VIRTIO_NET_F_STANDBY
+feature on the virtio-net interface and assign the same MAC address to both
+virtio-net and VF interfaces.
+
+Here is an example XML snippet that shows such configuration.
+
+ <interface type='network'>
+   <mac address='52:54:00:00:12:53'/>
+   <source network='enp66s0f0_br'/>
+   <target dev='tap01'/>
+   <model type='virtio'/>
+   <driver name='vhost' queues='4'/>
+   <link state='down'/>
+   <address type='pci' domain='0x0000' bus='0x00' slot='0x0a' function='0x0'/>
+ </interface>
+ <interface type='hostdev' managed='yes'>
+   <mac address='52:54:00:00:12:53'/>
+   <source>
+     <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
+   </source>
+   <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
+ </interface>
+
+Booting a VM with the above configuration will result in the following 3
+netdevs created in the VM.
+
+4: ens10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
+    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+    inet 192.168.12.53/24 brd 192.168.12.255 scope global dynamic ens10
+       valid_lft 42482sec preferred_lft 42482sec
+    inet6 fe80::97d8:db2:8c10:b6d6/64 scope link
+       valid_lft forever preferred_lft forever
+5: ens10nsby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ens10 state UP group default qlen 1000
+    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+7: ens11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master ens10 state UP group default qlen 1000
+    link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
+
+ens10 is the 'failover' master netdev, ens10nsby and ens11 are the slave
+'standby' and 'primary' netdevs respectively.
+
+Live Migration of a VM with SR-IOV VF & virtio-net in STANDBY mode
+==================================================================
+
+net_failover also enables hypervisor controlled live migration to be supported
+with VMs that have direct attached SR-IOV VF devices by automatic failover to
+the paravirtual datapath when the VF is unplugged.
+
+Here is a sample script that shows the steps to initiate live migration on
+the source hypervisor.
+
+# cat vf_xml
+<interface type='hostdev' managed='yes'>
+  <mac address='52:54:00:00:12:53'/>
+  <source>
+    <address type='pci' domain='0x0000' bus='0x42' slot='0x02' function='0x5'/>
+  </source>
+  <address type='pci' domain='0x0000' bus='0x00' slot='0x0b' function='0x0'/>
+</interface>
+
+# Source Hypervisor
+#!/bin/bash
+
+DOMAIN=fedora27-tap01
+PF=enp66s0f0
+VF_NUM=5
+TAP_IF=tap01
+VF_XML=
+
+MAC=52:54:00:00:12:53
+ZERO_MAC=00:00:00:00:00:00
+
+virsh domif-setlink $DOMAIN $TAP_IF up
+bridge fdb del $MAC dev $PF master
+virsh detach-device $DOMAIN $VF_XML
+ip link set $PF vf $VF_NUM mac $ZERO_MAC
+
+virsh migrate --live $DOMAIN qemu+ssh://$REMOTE_HOST/system
+
+# Destination Hypervisor
+#!/bin/bash
+
+virsh attach-device $DOMAIN $VF_XML
+virsh domif-setlink $DOMAIN $TAP_IF down
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1cf29c5ed510..148bcf1b4bf9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,7 @@ config VETH
 config VIRTIO_NET
 	tristate "Virtio network driver"
 	depends on VIRTIO
+	select NET_FAILOVER
 	---help---
 	  This is the virtual network driver for virtio.  It can be used with
 	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 213fddc70fd0..370828c3d114 100644
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
+#include <net/net_failover.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -210,6 +213,9 @@ struct virtnet_info {
 	u32 speed;
 
 	unsigned long guest_offloads;
+
+	/* failover when STANDBY feature enabled */
+	struct failover *failover;
 };
 
 struct padded_vnet_hdr {
@@ -1523,6 +1529,9 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 	struct sockaddr *addr;
 	struct scatterlist sg;
 
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
+		return -EOPNOTSUPP;
+
 	addr = kmemdup(p, sizeof(*addr), GFP_KERNEL);
 	if (!addr)
 		return -ENOMEM;
@@ -2306,6 +2315,22 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
+				      size_t len)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int ret;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
+		return -EOPNOTSUPP;
+
+	ret = snprintf(buf, len, "sby");
+	if (ret >= len)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -2323,6 +2348,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
 	.ndo_xdp_flush		= virtnet_xdp_flush,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -2876,10 +2902,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtnet_init_settings(dev);
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
+		vi->failover = net_failover_create(vi->dev);
+		if (IS_ERR(vi->failover))
+			goto free_vqs;
+	}
+
 	err = register_netdev(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
-		goto free_vqs;
+		goto free_failover;
 	}
 
 	virtio_device_ready(vdev);
@@ -2916,6 +2948,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vi->vdev->config->reset(vdev);
 
 	unregister_netdev(dev);
+free_failover:
+	net_failover_destroy(vi->failover);
 free_vqs:
 	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
@@ -2950,6 +2984,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	unregister_netdev(vi->dev);
 
+	net_failover_destroy(vi->failover);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

