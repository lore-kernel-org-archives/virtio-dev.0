Return-Path: virtio-dev-return-4182-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E81F358191D4
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 May 2018 04:04:38 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 25 May 2018 19:04:39 +0800
Message-Id: <20180525110441.7185-4-tiwei.bie@intel.com>
In-Reply-To: <20180525110441.7185-1-tiwei.bie@intel.com>
References: <20180525110441.7185-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2 3/5] vhost-user: support registering external host notifiers
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
With this feature negotiated, vhost-user backend can register
memory region based host notifiers. And it will allow the guest
driver in the VM to notify the hardware accelerator at the
vhost-user backend directly.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt    |  33 +++++++++
 hw/virtio/vhost-user.c         | 123 +++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user.h |   8 +++
 3 files changed, 164 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 534caab18a..9e57b36b20 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -132,6 +132,16 @@ Depending on the request type, payload can be:
    Payload: Size bytes array holding the contents of the virtio
        device's configuration space
 
+ * Vring area description
+   -----------------------
+   | u64 | size | offset |
+   -----------------------
+
+   u64: a 64-bit integer contains vring index and flags
+   Size: a 64-bit size of this area
+   Offset: a 64-bit offset of this area from the start of the
+       supplied file descriptor
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -146,6 +156,7 @@ typedef struct VhostUserMsg {
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
+        VhostUserVringArea area;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -380,6 +391,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
 #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
+#define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  10
 
 Master message types
 --------------------
@@ -777,6 +789,27 @@ Slave message types
      the VHOST_USER_NEED_REPLY flag, master must respond with zero when
      operation is successfully completed, or non-zero otherwise.
 
+ * VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG
+
+      Id: 3
+      Equivalent ioctl: N/A
+      Slave payload: vring area description
+      Master payload: N/A
+
+      Sets host notifier for a specified queue. The queue index is contained
+      in the u64 field of the vring area description. The host notifier is
+      described by the file descriptor (typically it's a VFIO device fd) which
+      is passed as ancillary data and the size (which is mmap size and should
+      be the same as host page size) and offset (which is mmap offset) carried
+      in the vring area description. QEMU can mmap the file descriptor based
+      on the size and offset to get a memory range. Registering a host notifier
+      means mapping this memory range to the VM as the specified queue's notify
+      MMIO region. Slave sends this request to tell QEMU to de-register the
+      existing notifier if any and register the new notifier if the request is
+      sent with a file descriptor.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
+      protocol feature has been successfully negotiated.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 5f72ed68da..259a841af9 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -13,6 +13,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-net.h"
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
@@ -48,6 +49,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
     VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 10,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -92,6 +94,7 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_NONE = 0,
     VHOST_USER_SLAVE_IOTLB_MSG = 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
+    VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -136,6 +139,12 @@ static VhostUserConfig c __attribute__ ((unused));
                                    + sizeof(c.size) \
                                    + sizeof(c.flags))
 
+typedef struct VhostUserVringArea {
+    uint64_t u64;
+    uint64_t size;
+    uint64_t offset;
+} VhostUserVringArea;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -157,6 +166,7 @@ typedef union {
         struct vhost_iotlb_msg iotlb;
         VhostUserConfig config;
         VhostUserCryptoSession session;
+        VhostUserVringArea area;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -638,9 +648,37 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring);
 }
 
+static void vhost_user_host_notifier_restore(struct vhost_dev *dev,
+                                             int queue_idx)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserHostNotifier *n = &u->user->notifier[queue_idx];
+    VirtIODevice *vdev = dev->vdev;
+
+    if (n->addr && !n->set) {
+        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, true);
+        n->set = true;
+    }
+}
+
+static void vhost_user_host_notifier_remove(struct vhost_dev *dev,
+                                            int queue_idx)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserHostNotifier *n = &u->user->notifier[queue_idx];
+    VirtIODevice *vdev = dev->vdev;
+
+    if (n->addr && n->set) {
+        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, false);
+        n->set = false;
+    }
+}
+
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
+    vhost_user_host_notifier_restore(dev, ring->index);
+
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
 }
 
@@ -674,6 +712,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.state),
     };
 
+    vhost_user_host_notifier_remove(dev, ring->index);
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         return -1;
     }
@@ -847,6 +887,76 @@ static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)
     return ret;
 }
 
+static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
+                                                       VhostUserVringArea *area,
+                                                       int fd)
+{
+    int queue_idx = area->u64 & VHOST_USER_VRING_IDX_MASK;
+    size_t page_size = qemu_real_host_page_size;
+    struct vhost_user *u = dev->opaque;
+    VhostUserState *user = u->user;
+    VirtIODevice *vdev = dev->vdev;
+    VhostUserHostNotifier *n;
+    int ret = 0;
+    void *addr;
+    char *name;
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
+        vdev == NULL || queue_idx >= virtio_get_num_queues(vdev)) {
+        ret = -1;
+        goto out;
+    }
+
+    n = &user->notifier[queue_idx];
+
+    if (n->addr) {
+        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, false);
+        object_unparent(OBJECT(&n->mr));
+        munmap(n->addr, page_size);
+        n->addr = NULL;
+    }
+
+    if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
+        goto out;
+    }
+
+    /* Sanity check. */
+    if (area->size != page_size) {
+        ret = -1;
+        goto out;
+    }
+
+    addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+                fd, area->offset);
+    if (addr == MAP_FAILED) {
+        ret = -1;
+        goto out;
+    }
+
+    name = g_strdup_printf("vhost-user/host-notifier@%p mmaps[%d]",
+                           user, queue_idx);
+    memory_region_init_ram_device_ptr(&n->mr, OBJECT(vdev), name,
+                                      page_size, addr);
+    g_free(name);
+
+    if (virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, true)) {
+        munmap(addr, page_size);
+        ret = -1;
+        goto out;
+    }
+
+    n->addr = addr;
+    n->set = true;
+
+out:
+    /* Always close the fd. */
+    if (fd != -1) {
+        close(fd);
+    }
+    return ret;
+}
+
 static void slave_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
@@ -913,6 +1023,10 @@ static void slave_read(void *opaque)
     case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
         ret = vhost_user_slave_handle_config_change(dev);
         break;
+    case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
+        ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
+                                                          fd);
+        break;
     default:
         error_report("Received unexpected msg type.");
         if (fd != -1) {
@@ -1641,6 +1755,15 @@ VhostUserState *vhost_user_init(void)
 
 void vhost_user_cleanup(VhostUserState *user)
 {
+    int i;
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        if (user->notifier[i].addr) {
+            object_unparent(OBJECT(&user->notifier[i].mr));
+            munmap(user->notifier[i].addr, qemu_real_host_page_size);
+            user->notifier[i].addr = NULL;
+        }
+    }
 }
 
 const VhostOps user_ops = {
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index eb8bc0d90d..fd660393a0 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -9,9 +9,17 @@
 #define HW_VIRTIO_VHOST_USER_H
 
 #include "chardev/char-fe.h"
+#include "hw/virtio/virtio.h"
+
+typedef struct VhostUserHostNotifier {
+    MemoryRegion mr;
+    void *addr;
+    bool set;
+} VhostUserHostNotifier;
 
 typedef struct VhostUserState {
     CharBackend *chr;
+    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
 } VhostUserState;
 
 VhostUserState *vhost_user_init(void);
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

