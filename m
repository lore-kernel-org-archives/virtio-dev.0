Return-Path: virtio-dev-return-2907-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F7C958191C4
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 21:17:35 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  4 Jan 2018 00:16:45 -0500
Message-Id: <045deae35c270264b14550fd41bd14f5b75e76e9.1515042044.git.jbaron@akamai.com>
In-Reply-To: <cover.1515041373.git.jbaron@akamai.com>
References: <cover.1515041373.git.jbaron@akamai.com>
References: <cover.1515041373.git.jbaron@akamai.com>
Subject: [virtio-dev] [PATCH v3 3/3] qemu: add linkspeed and duplex settings to virtio-net
To: mst@redhat.com, davem@davemloft.net
Cc: jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
this requires custom ethtool commands for virtio-net by default.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Linkspeed and duplex settings can be set as:
'-device virtio-net,speed=10000,duplex=full'

where speed is [-1...INT_MAX], and duplex is ["half"|"full"].

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/virtio-net.c                         | 35 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h              |  3 +++
 include/standard-headers/linux/virtio_net.h | 13 +++++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index adc20df..eec8422 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -40,6 +40,12 @@
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
 #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
 
+/* duplex and speed */
+#define DUPLEX_UNKNOWN          0xff
+#define DUPLEX_HALF             0x00
+#define DUPLEX_FULL             0x01
+#define SPEED_UNKNOWN           -1
+
 /*
  * Calculate the number of bytes up to and including the given 'field' of
  * 'container'.
@@ -61,6 +67,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
+     .end = endof(struct virtio_net_config, duplex)},
     {}
 };
 
@@ -89,6 +97,14 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
+    if (n->status & VIRTIO_NET_S_LINK_UP) {
+        virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
+        netcfg.duplex = n->net_conf.duplex;
+    } else {
+        virtio_stl_p(vdev, &netcfg.speed, SPEED_UNKNOWN);
+        netcfg.duplex = DUPLEX_UNKNOWN;
+    }
+
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -1941,6 +1957,23 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    if (n->net_conf.duplex_str) {
+        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_HALF;
+        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_FULL;
+        } else {
+            error_setg(errp, "'duplex' must be 'half' or 'full'");
+        }
+    } else {
+        n->net_conf.duplex = DUPLEX_UNKNOWN;
+    }
+    if (n->net_conf.speed < SPEED_UNKNOWN) {
+            error_setg(errp, "'speed' must be between -1 (SPEED_UNKOWN) and "
+                       "INT_MAX");
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2160,6 +2193,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
                      true),
+    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
+    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index e7634c9..02484dc 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,9 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    int32_t speed;
+    char *duplex_str;
+    uint8_t duplex;
 } virtio_net_conf;
 
 /* Maximum packet size we can receive from tap device: header + 64k */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 30ff249..17c8531 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,8 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
+
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
 #endif /* VIRTIO_NET_NO_LEGACY */
@@ -76,6 +78,17 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+	/*
+	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
+	 * Any other value stands for unknown.
+	 */
+	uint32_t speed;
+	/*
+	 * 0x00 - half duplex
+	 * 0x01 - full duplex
+	 * Any other value stands for unknown.
+	 */
+	uint8_t duplex;
 } QEMU_PACKED;
 
 /*

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

