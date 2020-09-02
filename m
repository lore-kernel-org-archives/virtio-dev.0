Return-Path: virtio-dev-return-7749-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F2B6985EF2
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:33 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:40 -0700
Message-Id: <20200902210847.2689-17-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 16/23] drm/virtio: implement blob resources: implement vram object
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gerd Hoffmann <kraxel@redhat.com>

A virtio-gpu vram object is based on range-based allocation.
No guest shmemfs backing, so we call drm_gem_private_object_init.

This is for host memory without any guest backing (atleast initially).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/Makefile          |   2 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  20 ++-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  26 +++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 ++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  12 ++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  66 +++++++++
 drivers/gpu/drm/virtio/virtgpu_vram.c    | 162 +++++++++++++++++++++++
 7 files changed, 293 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_vram.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makef=
ile
index 92aa2b3d349d9..b99fa4a73b68e 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the drm device driver.  This driver provides support for th=
e
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
=20
-virtio-gpu-y :=3D virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o \
+virtio-gpu-y :=3D virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o=
 \
 =09virtgpu_display.o virtgpu_vq.o \
 =09virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
 =09virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/vir=
tio/virtgpu_debugfs.c
index a2cdd267914ac..f336a8fa66667 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -42,7 +42,7 @@ static void virtio_add_int(struct seq_file *m, const char=
 *name,
=20
 static int virtio_gpu_features(struct seq_file *m, void *data)
 {
-=09struct drm_info_node *node =3D (struct drm_info_node *) m->private;
+=09struct drm_info_node *node =3D (struct drm_info_node *)m->private;
 =09struct virtio_gpu_device *vgdev =3D node->minor->dev->dev_private;
=20
 =09virtio_add_bool(m, "virgl", vgdev->has_virgl_3d);
@@ -72,9 +72,27 @@ virtio_gpu_debugfs_irq_info(struct seq_file *m, void *da=
ta)
 =09return 0;
 }
=20
+static int
+virtio_gpu_debugfs_host_visible_mm(struct seq_file *m, void *data)
+{
+=09struct drm_info_node *node =3D (struct drm_info_node *)m->private;
+=09struct virtio_gpu_device *vgdev =3D node->minor->dev->dev_private;
+=09struct drm_printer p;
+
+=09if (!vgdev->has_host_visible) {
+=09=09seq_puts(m, "Host allocations not visible to guest\n");
+=09=09return 0;
+=09}
+
+=09p =3D drm_seq_file_printer(m);
+=09drm_mm_print(&vgdev->host_visible_mm, &p);
+=09return 0;
+}
+
 static struct drm_info_list virtio_gpu_debugfs_list[] =3D {
 =09{ "virtio-gpu-features", virtio_gpu_features },
 =09{ "virtio-gpu-irq-fence", virtio_gpu_debugfs_irq_info, 0, NULL },
+=09{ "virtio-gpu-host-visible-mm", virtio_gpu_debugfs_host_visible_mm },
 };
=20
 #define VIRTIO_GPU_DEBUGFS_ENTRIES ARRAY_SIZE(virtio_gpu_debugfs_list)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 6d8c624515cd5..c3094f54598f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -99,9 +99,19 @@ struct virtio_gpu_object_shmem {
 =09uint32_t mapped;
 };
=20
+struct virtio_gpu_object_vram {
+=09struct virtio_gpu_object base;
+=09uint32_t map_state;
+=09uint32_t map_info;
+=09struct drm_mm_node vram_node;
+};
+
 #define to_virtio_gpu_shmem(virtio_gpu_object) \
 =09container_of((virtio_gpu_object), struct virtio_gpu_object_shmem, base)
=20
+#define to_virtio_gpu_vram(virtio_gpu_object) \
+=09container_of((virtio_gpu_object), struct virtio_gpu_object_vram, base)
+
 struct virtio_gpu_object_array {
 =09struct ww_acquire_ctx ticket;
 =09struct list_head next;
@@ -222,6 +232,7 @@ struct virtio_gpu_device {
 =09bool has_resource_blob;
 =09bool has_host_visible;
 =09struct virtio_shm_region host_visible_region;
+=09struct drm_mm host_visible_mm;
=20
 =09struct work_struct config_changed_work;
=20
@@ -233,8 +244,10 @@ struct virtio_gpu_device {
 =09uint32_t num_capsets;
 =09struct list_head cap_cache;
=20
-=09/* protects resource state when exporting */
+=09/* protects uuid state when exporting */
 =09spinlock_t resource_export_lock;
+=09/* protects map state and host_visible_mm */
+=09spinlock_t host_visible_lock;
 };
=20
 struct virtio_gpu_fpriv {
@@ -365,6 +378,12 @@ int
 virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 =09=09=09=09    struct virtio_gpu_object_array *objs);
=20
+int virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev,
+=09=09       struct virtio_gpu_object_array *objs, uint64_t offset);
+
+void virtio_gpu_cmd_unmap(struct virtio_gpu_device *vgdev,
+=09=09=09  struct virtio_gpu_object *bo);
+
 /* virtgpu_display.c */
 void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
@@ -411,4 +430,9 @@ struct drm_gem_object *virtgpu_gem_prime_import_sg_tabl=
e(
 /* virtgpu_debugfs.c */
 void virtio_gpu_debugfs_init(struct drm_minor *minor);
=20
+/* virtgpu_vram.c */
+bool virtio_gpu_is_vram(struct virtio_gpu_object *bo);
+int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
+=09=09=09   struct virtio_gpu_object_params *params,
+=09=09=09   struct virtio_gpu_object **bo_ptr);
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 97b6e4fb945a7..7771a6b5852ea 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -121,6 +121,7 @@ int virtio_gpu_init(struct drm_device *dev)
=20
 =09spin_lock_init(&vgdev->display_info_lock);
 =09spin_lock_init(&vgdev->resource_export_lock);
+=09spin_lock_init(&vgdev->host_visible_lock);
 =09ida_init(&vgdev->ctx_id_ida);
 =09ida_init(&vgdev->resource_ida);
 =09init_waitqueue_head(&vgdev->resp_wq);
@@ -169,6 +170,9 @@ int virtio_gpu_init(struct drm_device *dev)
 =09=09=09 (unsigned long)vgdev->host_visible_region.addr,
 =09=09=09 (unsigned long)vgdev->host_visible_region.len);
 =09=09vgdev->has_host_visible =3D true;
+=09=09drm_mm_init(&vgdev->host_visible_mm,
+=09=09=09    (unsigned long)vgdev->host_visible_region.addr,
+=09=09=09    (unsigned long)vgdev->host_visible_region.len);
 =09}
=20
 =09DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible\n",
@@ -258,6 +262,10 @@ void virtio_gpu_release(struct drm_device *dev)
 =09virtio_gpu_modeset_fini(vgdev);
 =09virtio_gpu_free_vbufs(vgdev);
 =09virtio_gpu_cleanup_cap_cache(vgdev);
+
+=09if (vgdev->has_host_visible)
+=09=09drm_mm_takedown(&vgdev->host_visible_mm);
+
 =09kfree(vgdev->capsets);
=20
 =09if (vgdev->has_host_visible) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index f7064c1c23fd9..cef79455257df 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -83,6 +83,18 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object =
*bo)
 =09=09}
=20
 =09=09drm_gem_shmem_free_object(&bo->base.base);
+=09} else if (virtio_gpu_is_vram(bo)) {
+=09=09struct virtio_gpu_object_vram *vram =3D to_virtio_gpu_vram(bo);
+
+=09=09spin_lock(&vgdev->host_visible_lock);
+=09=09if (drm_mm_node_allocated(&vram->vram_node))
+=09=09=09drm_mm_remove_node(&vram->vram_node);
+
+=09=09spin_unlock(&vgdev->host_visible_lock);
+
+=09=09drm_gem_free_mmap_offset(&vram->base.base.base);
+=09=09drm_gem_object_release(&vram->base.base.base);
+=09=09kfree(vram);
 =09}
 }
=20
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index deae7687eec3c..15f9d0d9aa25c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1166,3 +1166,69 @@ virtio_gpu_cmd_resource_assign_uuid(struct virtio_gp=
u_device *vgdev,
 =09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 =09return 0;
 }
+
+static void virtio_gpu_cmd_resource_map_cb(struct virtio_gpu_device *vgdev=
,
+=09=09=09=09=09   struct virtio_gpu_vbuffer *vbuf)
+{
+=09struct virtio_gpu_object *bo =3D
+=09=09gem_to_virtio_gpu_obj(vbuf->objs->objs[0]);
+=09struct virtio_gpu_resp_map_info *resp =3D
+=09=09(struct virtio_gpu_resp_map_info *)vbuf->resp_buf;
+=09struct virtio_gpu_object_vram *vram =3D to_virtio_gpu_vram(bo);
+=09uint32_t resp_type =3D le32_to_cpu(resp->hdr.type);
+
+=09spin_lock(&vgdev->host_visible_lock);
+
+=09if (resp_type =3D=3D VIRTIO_GPU_RESP_OK_MAP_INFO) {
+=09=09vram->map_info =3D resp->map_info;
+=09=09vram->map_state =3D STATE_OK;
+=09} else {
+=09=09vram->map_state =3D STATE_ERR;
+=09}
+
+=09spin_unlock(&vgdev->host_visible_lock);
+=09wake_up_all(&vgdev->resp_wq);
+}
+
+int virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev,
+=09=09       struct virtio_gpu_object_array *objs, uint64_t offset)
+{
+=09struct virtio_gpu_resource_map_blob *cmd_p;
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(objs->objs[0]);
+=09struct virtio_gpu_vbuffer *vbuf;
+=09struct virtio_gpu_resp_map_info *resp_buf;
+
+=09resp_buf =3D kzalloc(sizeof(*resp_buf), GFP_KERNEL);
+=09if (!resp_buf) {
+=09=09virtio_gpu_array_put_free(objs);
+=09=09return -ENOMEM;
+=09}
+
+=09cmd_p =3D virtio_gpu_alloc_cmd_resp
+=09=09(vgdev, virtio_gpu_cmd_resource_map_cb, &vbuf, sizeof(*cmd_p),
+=09=09 sizeof(struct virtio_gpu_resp_map_info), resp_buf);
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+=09cmd_p->offset =3D cpu_to_le64(offset);
+=09vbuf->objs =3D objs;
+
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+=09return 0;
+}
+
+void virtio_gpu_cmd_unmap(struct virtio_gpu_device *vgdev,
+=09=09=09  struct virtio_gpu_object *bo)
+{
+=09struct virtio_gpu_resource_unmap_blob *cmd_p;
+=09struct virtio_gpu_vbuffer *vbuf;
+
+=09cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio=
/virtgpu_vram.c
new file mode 100644
index 0000000000000..087945fcd230f
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "virtgpu_drv.h"
+
+static void virtio_gpu_vram_free(struct drm_gem_object *obj)
+{
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
+=09struct virtio_gpu_object_vram *vram =3D to_virtio_gpu_vram(bo);
+=09bool unmap;
+
+=09if (bo->created) {
+=09=09spin_lock(&vgdev->host_visible_lock);
+=09=09unmap =3D drm_mm_node_allocated(&vram->vram_node);
+=09=09spin_unlock(&vgdev->host_visible_lock);
+
+=09=09if (unmap)
+=09=09=09virtio_gpu_cmd_unmap(vgdev, bo);
+
+=09=09virtio_gpu_cmd_unref_resource(vgdev, bo);
+=09=09virtio_gpu_notify(vgdev);
+=09=09return;
+=09}
+}
+
+static const struct vm_operations_struct virtio_gpu_vram_vm_ops =3D {
+=09.open =3D drm_gem_vm_open,
+=09.close =3D drm_gem_vm_close,
+};
+
+static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
+=09=09=09=09struct vm_area_struct *vma)
+{
+=09int ret;
+=09struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
+=09struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
+=09struct virtio_gpu_object_vram *vram =3D to_virtio_gpu_vram(bo);
+=09unsigned long vm_size =3D vma->vm_end - vma->vm_start;
+
+=09if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
+=09=09return -EINVAL;
+
+=09wait_event(vgdev->resp_wq, vram->map_state !=3D STATE_INITIALIZING);
+=09if (vram->map_state !=3D STATE_OK)
+=09=09return -EINVAL;
+
+=09vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);
+=09vma->vm_flags |=3D VM_MIXEDMAP | VM_DONTEXPAND;
+=09vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
+=09vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
+=09vma->vm_ops =3D &virtio_gpu_vram_vm_ops;
+
+=09if (vram->map_info =3D=3D VIRTIO_GPU_MAP_CACHE_WC)
+=09=09vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
+=09else if (vram->map_info =3D=3D VIRTIO_GPU_MAP_CACHE_UNCACHED)
+=09=09vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
+
+=09/* Partial mappings of GEM buffers don't happen much in practice. */
+=09if (vm_size !=3D vram->vram_node.size)
+=09=09return -EINVAL;
+
+=09ret =3D io_remap_pfn_range(vma, vma->vm_start,
+=09=09=09=09 vram->vram_node.start >> PAGE_SHIFT,
+=09=09=09=09 vm_size, vma->vm_page_prot);
+=09return ret;
+}
+
+static const struct drm_gem_object_funcs virtio_gpu_vram_funcs =3D {
+=09.open =3D virtio_gpu_gem_object_open,
+=09.close =3D virtio_gpu_gem_object_close,
+=09.free =3D virtio_gpu_vram_free,
+=09.mmap =3D virtio_gpu_vram_mmap,
+};
+
+bool virtio_gpu_is_vram(struct virtio_gpu_object *bo)
+{
+=09return bo->base.base.funcs =3D=3D &virtio_gpu_vram_funcs;
+}
+
+static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
+{
+=09int ret;
+=09uint64_t offset;
+=09struct virtio_gpu_object_array *objs;
+=09struct virtio_gpu_device *vgdev =3D bo->base.base.dev->dev_private;
+=09struct virtio_gpu_object_vram *vram =3D to_virtio_gpu_vram(bo);
+
+=09if (!vgdev->has_host_visible)
+=09=09return -EINVAL;
+
+=09spin_lock(&vgdev->host_visible_lock);
+=09ret =3D drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
+=09=09=09=09 bo->base.base.size);
+=09spin_unlock(&vgdev->host_visible_lock);
+
+=09if (ret)
+=09=09return ret;
+
+=09objs =3D virtio_gpu_array_alloc(1);
+=09if (!objs) {
+=09=09ret =3D -ENOMEM;
+=09=09goto err_remove_node;
+=09}
+
+=09virtio_gpu_array_add_obj(objs, &bo->base.base);
+=09/*TODO: Add an error checking helper function in drm_mm.h */
+=09offset =3D vram->vram_node.start - vgdev->host_visible_region.addr;
+
+=09ret =3D virtio_gpu_cmd_map(vgdev, objs, offset);
+=09if (ret) {
+=09=09virtio_gpu_array_put_free(objs);
+=09=09goto err_remove_node;
+=09}
+
+=09return 0;
+
+err_remove_node:
+=09spin_lock(&vgdev->host_visible_lock);
+=09drm_mm_remove_node(&vram->vram_node);
+=09spin_unlock(&vgdev->host_visible_lock);
+=09return ret;
+}
+
+int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
+=09=09=09   struct virtio_gpu_object_params *params,
+=09=09=09   struct virtio_gpu_object **bo_ptr)
+{
+=09struct drm_gem_object *obj;
+=09struct virtio_gpu_object_vram *vram;
+=09int ret;
+
+=09vram =3D kzalloc(sizeof(*vram), GFP_KERNEL);
+=09if (!vram)
+=09=09return -ENOMEM;
+
+=09obj =3D &vram->base.base.base;
+=09obj->funcs =3D &virtio_gpu_vram_funcs;
+=09drm_gem_private_object_init(vgdev->ddev, obj, params->size);
+
+=09/* Create fake offset */
+=09ret =3D drm_gem_create_mmap_offset(obj);
+=09if (ret) {
+=09=09kfree(vram);
+=09=09return ret;
+=09}
+
+=09ret =3D virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
+=09if (ret) {
+=09=09kfree(vram);
+=09=09return ret;
+=09}
+
+=09if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
+=09=09ret =3D virtio_gpu_vram_map(&vram->base);
+=09=09if (ret) {
+=09=09=09virtio_gpu_vram_free(obj);
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09*bo_ptr =3D &vram->base;
+=09return 0;
+}
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

