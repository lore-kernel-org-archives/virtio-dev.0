Return-Path: virtio-dev-return-3534-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D35495818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 14:45:24 -0700 (PDT)
Date: Tue, 13 Mar 2018 23:45:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520977432-187679-4-git-send-email-mst@redhat.com>
References: <1520977432-187679-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520977432-187679-1-git-send-email-mst@redhat.com>
Subject: [virtio-dev] [PULL 03/22] virtio-net: add linkspeed and duplex settings to
 virtio-net
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Baron <jbaron@akamai.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jason Baron <jbaron@akamai.com>

Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
this requires custom ethtool commands for virtio-net by default.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Linkspeed and duplex settings can be set as:
'-device virtio-net,speed=10000,duplex=full'

where speed is [0...INT_MAX], and duplex is ["half"|"full"].

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h |  3 +++
 hw/net/virtio-net.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ab06f93..67ad38c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,6 +26,7 @@
 #include "qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "standard-headers/linux/ethtool.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -61,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
+     .end = endof(struct virtio_net_config, duplex)},
     {}
 };
 
@@ -89,6 +92,8 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
+    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
+    netcfg.duplex = n->net_conf.duplex;
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -1941,6 +1946,25 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->net_conf.duplex_str) {
+        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_HALF;
+        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_FULL;
+        } else {
+            error_setg(errp, "'duplex' must be 'half' or 'full'");
+        }
+        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    } else {
+        n->net_conf.duplex = DUPLEX_UNKNOWN;
+    }
+
+    if (n->net_conf.speed < SPEED_UNKNOWN) {
+        error_setg(errp, "'speed' must be between 0 and INT_MAX");
+    } else if (n->net_conf.speed >= 0) {
+        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2161,6 +2185,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
                      true),
+    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
+    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

