Return-Path: virtio-dev-return-3732-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9474C58191B0
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Apr 2018 14:08:34 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  5 Apr 2018 14:08:20 -0700
Message-Id: <1522962503-3963-2-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v5 1/4] virtio_net: Introduce VIRTIO_NET_F_BACKUP feature bit
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a backup for another device with the same MAC address.

VIRTIO_NET_F_BACKUP is defined as bit 62 as it is a device feature bit.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/virtio_net.c        | 2 +-
 include/uapi/linux/virtio_net.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7b187ec7411e..befb5944f3fd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2962,7 +2962,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 5de6ed37695b..c7c35fd1a5ed 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_BACKUP	  62	/* Act as backup for another device
+					 * with the same MAC.
+					 */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

