Return-Path: virtio-dev-return-4184-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 66CBE58191AB
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 May 2018 04:04:37 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 25 May 2018 19:04:37 +0800
Message-Id: <20180525110441.7185-2-tiwei.bie@intel.com>
In-Reply-To: <20180525110441.7185-1-tiwei.bie@intel.com>
References: <20180525110441.7185-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2 1/5] vhost: allow backends to filter memory sections
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces a vhost op for vhost backends to allow
them to filter the memory sections that they can handle.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/vhost-user.c            | 11 +++++++++++
 hw/virtio/vhost.c                 |  9 +++++++--
 include/hw/virtio/vhost-backend.h |  4 ++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ca554d4ff1..da0756effe 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1620,6 +1620,16 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
     return 0;
 }
 
+static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
+                                          MemoryRegionSection *section)
+{
+    bool result;
+
+    result = memory_region_get_fd(section->mr) >= 0;
+
+    return result;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -1650,4 +1660,5 @@ const VhostOps user_ops = {
         .vhost_set_config = vhost_user_set_config,
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
+        .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b08290036d..624ade9682 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -386,7 +386,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     return r;
 }
 
-static bool vhost_section(MemoryRegionSection *section)
+static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
     bool result;
     bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
@@ -399,6 +399,11 @@ static bool vhost_section(MemoryRegionSection *section)
      */
     result &= !log_dirty;
 
+    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
+        result &=
+            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
+    }
+
     trace_vhost_section(section->mr->name, result);
     return result;
 }
@@ -632,7 +637,7 @@ static void vhost_region_addnop(MemoryListener *listener,
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
 
-    if (!vhost_section(section)) {
+    if (!vhost_section(dev, section)) {
         return;
     }
     vhost_region_add_section(dev, section);
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 5dac61f9ea..81283ec50f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -101,6 +101,9 @@ typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
 typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
                                              uint64_t session_id);
 
+typedef bool (*vhost_backend_mem_section_filter_op)(struct vhost_dev *dev,
+                                                MemoryRegionSection *section);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -138,6 +141,7 @@ typedef struct VhostOps {
     vhost_set_config_op vhost_set_config;
     vhost_crypto_create_session_op vhost_crypto_create_session;
     vhost_crypto_close_session_op vhost_crypto_close_session;
+    vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

