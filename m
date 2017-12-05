Return-Path: virtio-dev-return-2739-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A5BF581815E
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 19:49:40 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:10 +0800
Message-Id: <1512444796-30615-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 1/7] vhost-user: share the vhost-user protocol related structures
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Put the vhost-user protocol related data structures to vhost-user.h,
so that they can be used in other implementations (e.g. a slave
implementation).

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-user.c         | 100 +-------------------------------------
 include/hw/virtio/vhost-user.h | 106 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 99 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..e512f5a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
@@ -23,105 +24,6 @@
 #include <sys/un.h>
 #include <linux/vhost.h>
 
-#define VHOST_MEMORY_MAX_NREGIONS    8
-#define VHOST_USER_F_PROTOCOL_FEATURES 30
-
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ = 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
-    VHOST_USER_PROTOCOL_F_RARP = 2,
-    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
-    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
-    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
-    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
-
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
-#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
-
-typedef enum VhostUserRequest {
-    VHOST_USER_NONE = 0,
-    VHOST_USER_GET_FEATURES = 1,
-    VHOST_USER_SET_FEATURES = 2,
-    VHOST_USER_SET_OWNER = 3,
-    VHOST_USER_RESET_OWNER = 4,
-    VHOST_USER_SET_MEM_TABLE = 5,
-    VHOST_USER_SET_LOG_BASE = 6,
-    VHOST_USER_SET_LOG_FD = 7,
-    VHOST_USER_SET_VRING_NUM = 8,
-    VHOST_USER_SET_VRING_ADDR = 9,
-    VHOST_USER_SET_VRING_BASE = 10,
-    VHOST_USER_GET_VRING_BASE = 11,
-    VHOST_USER_SET_VRING_KICK = 12,
-    VHOST_USER_SET_VRING_CALL = 13,
-    VHOST_USER_SET_VRING_ERR = 14,
-    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
-    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
-    VHOST_USER_GET_QUEUE_NUM = 17,
-    VHOST_USER_SET_VRING_ENABLE = 18,
-    VHOST_USER_SEND_RARP = 19,
-    VHOST_USER_NET_SET_MTU = 20,
-    VHOST_USER_SET_SLAVE_REQ_FD = 21,
-    VHOST_USER_IOTLB_MSG = 22,
-    VHOST_USER_SET_VRING_ENDIAN = 23,
-    VHOST_USER_MAX
-} VhostUserRequest;
-
-typedef enum VhostUserSlaveRequest {
-    VHOST_USER_SLAVE_NONE = 0,
-    VHOST_USER_SLAVE_IOTLB_MSG = 1,
-    VHOST_USER_SLAVE_MAX
-}  VhostUserSlaveRequest;
-
-typedef struct VhostUserMemoryRegion {
-    uint64_t guest_phys_addr;
-    uint64_t memory_size;
-    uint64_t userspace_addr;
-    uint64_t mmap_offset;
-} VhostUserMemoryRegion;
-
-typedef struct VhostUserMemory {
-    uint32_t nregions;
-    uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
-} VhostUserMemory;
-
-typedef struct VhostUserLog {
-    uint64_t mmap_size;
-    uint64_t mmap_offset;
-} VhostUserLog;
-
-typedef struct VhostUserMsg {
-    VhostUserRequest request;
-
-#define VHOST_USER_VERSION_MASK     (0x3)
-#define VHOST_USER_REPLY_MASK       (0x1<<2)
-#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
-    uint32_t flags;
-    uint32_t size; /* the following payload size */
-    union {
-#define VHOST_USER_VRING_IDX_MASK   (0xff)
-#define VHOST_USER_VRING_NOFD_MASK  (0x1<<8)
-        uint64_t u64;
-        struct vhost_vring_state state;
-        struct vhost_vring_addr addr;
-        VhostUserMemory memory;
-        VhostUserLog log;
-        struct vhost_iotlb_msg iotlb;
-    } payload;
-} QEMU_PACKED VhostUserMsg;
-
-static VhostUserMsg m __attribute__ ((unused));
-#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
-                            + sizeof(m.flags) \
-                            + sizeof(m.size))
-
-#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
-
-/* The version of the protocol we support */
-#define VHOST_USER_VERSION    (0x1)
-
 struct vhost_user {
     CharBackend *chr;
     int slave_fd;
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
new file mode 100644
index 0000000..d76e9ad
--- /dev/null
+++ b/include/hw/virtio/vhost-user.h
@@ -0,0 +1,106 @@
+#ifndef VHOST_USER_H
+#define VHOST_USER_H
+
+#include <linux/vhost.h>
+
+#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
+#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
+
+typedef enum VhostUserRequest {
+    VHOST_USER_NONE = 0,
+    VHOST_USER_GET_FEATURES = 1,
+    VHOST_USER_SET_FEATURES = 2,
+    VHOST_USER_SET_OWNER = 3,
+    VHOST_USER_RESET_OWNER = 4,
+    VHOST_USER_SET_MEM_TABLE = 5,
+    VHOST_USER_SET_LOG_BASE = 6,
+    VHOST_USER_SET_LOG_FD = 7,
+    VHOST_USER_SET_VRING_NUM = 8,
+    VHOST_USER_SET_VRING_ADDR = 9,
+    VHOST_USER_SET_VRING_BASE = 10,
+    VHOST_USER_GET_VRING_BASE = 11,
+    VHOST_USER_SET_VRING_KICK = 12,
+    VHOST_USER_SET_VRING_CALL = 13,
+    VHOST_USER_SET_VRING_ERR = 14,
+    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
+    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
+    VHOST_USER_GET_QUEUE_NUM = 17,
+    VHOST_USER_SET_VRING_ENABLE = 18,
+    VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_NET_SET_MTU = 20,
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
+
+typedef struct VhostUserMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    uint64_t mmap_offset;
+} VhostUserMemoryRegion;
+
+typedef struct VhostUserMemory {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+} VhostUserMemory;
+
+typedef struct VhostUserLog {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+} VhostUserLog;
+
+typedef struct VhostUserMsg {
+    VhostUserRequest request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1 << 2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
+    uint32_t flags;
+    /* The following payload size */
+    uint32_t size;
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserLog log;
+        struct vhost_iotlb_msg iotlb;
+    } payload;
+} QEMU_PACKED VhostUserMsg;
+
+static VhostUserMsg m __attribute__ ((unused));
+#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
+                            + sizeof(m.flags) \
+                            + sizeof(m.size))
+
+#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
+
+/* The version of the protocol we support */
+#define VHOST_USER_VERSION    (0x1)
+
+#endif
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

