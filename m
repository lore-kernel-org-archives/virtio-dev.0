Return-Path: virtio-dev-return-3830-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E11D1CB80F3
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Apr 2018 08:14:59 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 12 Apr 2018 23:12:31 +0800
Message-Id: <20180412151232.17506-6-tiwei.bie@intel.com>
In-Reply-To: <20180412151232.17506-1-tiwei.bie@intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v3 5/6] vhost: allow backends to filter memory sections
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com
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
index 9cea2c8c51..791e0a4763 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1622,6 +1622,16 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
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
 VhostUserState *vhost_user_init(void)
 {
     VhostUserState *user = g_new0(struct VhostUserState, 1);
@@ -1663,4 +1673,5 @@ const VhostOps user_ops = {
         .vhost_set_config = vhost_user_set_config,
         .vhost_crypto_create_session = vhost_user_crypto_create_session,
         .vhost_crypto_close_session = vhost_user_crypto_close_session,
+        .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f51bf573d5..a939a38d97 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -382,7 +382,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     return r;
 }
 
-static bool vhost_section(MemoryRegionSection *section)
+static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
     bool result;
     bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
@@ -395,6 +395,11 @@ static bool vhost_section(MemoryRegionSection *section)
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
@@ -628,7 +633,7 @@ static void vhost_region_addnop(MemoryListener *listener,
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
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

