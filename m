Return-Path: virtio-dev-return-5275-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4806985B7E
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 22:30:04 +0000 (UTC)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 17:29:40 -0500
Message-Id: <1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH v3 1/5] virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

This feature bit can be used by a hypervisor to indicate to the virtio_net
device that it can act as a standby for another device with the same MAC
address.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 385b1a0..411f8fb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
+                      false),
     DEFINE_PROP_END_OF_LIST(),
 };
 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

