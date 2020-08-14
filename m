Return-Path: virtio-dev-return-7656-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D6AB985E2F
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:41:14 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:54 -0700
Message-Id: <20200814024000.2485-19-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 18/24] drm/virtio: implement blob resources: hypercall interface
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This implements the blob hypercall interface.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 15 +++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 65 ++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 61f57b04525b..fe9bb95a408b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -35,6 +35,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
@@ -382,6 +383,20 @@ int virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev=
,
 void virtio_gpu_cmd_unmap(struct virtio_gpu_device *vgdev,
 =09=09=09  struct virtio_gpu_object *bo);
=20
+void
+virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo,
+=09=09=09=09    struct virtio_gpu_object_params *params,
+=09=09=09=09    struct virtio_gpu_mem_entry *ents,
+=09=09=09=09    uint32_t nents);
+void
+virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
+=09=09=09=09uint32_t scanout_id,
+=09=09=09=09struct virtio_gpu_object *bo,
+=09=09=09=09struct drm_framebuffer *fb,
+=09=09=09=09uint32_t width, uint32_t height,
+=09=09=09=09uint32_t x, uint32_t y);
+
 /* virtgpu_display.c */
 void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 09db56c69424..de4356a183d2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1228,3 +1228,68 @@ void virtio_gpu_cmd_unmap(struct virtio_gpu_device *=
vgdev,
=20
 =09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
+
+void
+virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
+=09=09=09=09    struct virtio_gpu_object *bo,
+=09=09=09=09    struct virtio_gpu_object_params *params,
+=09=09=09=09    struct virtio_gpu_mem_entry *ents,
+=09=09=09=09    uint32_t nents)
+{
+=09struct virtio_gpu_resource_create_blob *cmd_p;
+=09struct virtio_gpu_vbuffer *vbuf;
+
+=09cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB);
+=09cmd_p->hdr.ctx_id =3D cpu_to_le32(params->ctx_id);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+=09cmd_p->blob_mem =3D cpu_to_le32(params->blob_mem);
+=09cmd_p->blob_flags =3D cpu_to_le32(params->blob_flags);
+=09cmd_p->blob_id =3D cpu_to_le64(params->blob_id);
+=09cmd_p->size =3D cpu_to_le64(params->size);
+=09cmd_p->nr_entries =3D cpu_to_le32(nents);
+
+=09vbuf->data_buf =3D ents;
+=09vbuf->data_size =3D sizeof(*ents) * nents;
+
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+=09bo->created =3D true;
+}
+
+void virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
+=09=09=09=09     uint32_t scanout_id,
+=09=09=09=09     struct virtio_gpu_object *bo,
+=09=09=09=09     struct drm_framebuffer *fb,
+=09=09=09=09     uint32_t width, uint32_t height,
+=09=09=09=09     uint32_t x, uint32_t y)
+{
+=09uint32_t i;
+=09struct virtio_gpu_set_scanout_blob *cmd_p;
+=09struct virtio_gpu_vbuffer *vbuf;
+=09uint32_t format =3D virtio_gpu_translate_format(fb->format->format);
+
+=09cmd_p =3D virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
+=09memset(cmd_p, 0, sizeof(*cmd_p));
+
+=09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_SET_SCANOUT_BLOB);
+=09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
+=09cmd_p->scanout_id =3D cpu_to_le32(scanout_id);
+
+=09cmd_p->format =3D cpu_to_le32(format);
+=09cmd_p->width  =3D cpu_to_le32(fb->width);
+=09cmd_p->height =3D cpu_to_le32(fb->height);
+
+=09for (i =3D 0; i < 4; i++) {
+=09=09cmd_p->strides[i] =3D cpu_to_le32(fb->pitches[i]);
+=09=09cmd_p->offsets[i] =3D cpu_to_le64(fb->offsets[i]);
+=09}
+
+=09cmd_p->r.width =3D cpu_to_le32(width);
+=09cmd_p->r.height =3D cpu_to_le32(height);
+=09cmd_p->r.x =3D cpu_to_le32(x);
+=09cmd_p->r.y =3D cpu_to_le32(y);
+
+=09virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+}
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

