Return-Path: virtio-dev-return-2961-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8810B1CB807A
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jan 2018 21:58:51 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 11 Jan 2018 21:58:40 -0800
Message-Id: <1515736720-39368-4-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH 1/1] qemu: Introduce VIRTIO_NET_F_BACKUP feature bit to virtio_net
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a backup for another device with the same MAC address.
    
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cd63659140..fa47e723b9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2193,6 +2193,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("backup", VirtIONet, host_features,
+                    VIRTIO_NET_F_BACKUP, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 17c8531a22..6afca6dcaf 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_BACKUP	  62   /* Act as backup for another device
+					* with the same MAC.
+					*/
 #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

