Return-Path: virtio-dev-return-6846-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68318985CD2
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 12:15:45 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Mon,  2 Mar 2020 21:15:22 +0900
Message-Id: <20200302121524.7543-3-stevensd@chromium.org>
In-Reply-To: <20200302121524.7543-1-stevensd@chromium.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 2/4] drm/prime: add support for virtio exported objects
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This change exposes dma-buf's get_uuid callback to PRIME drivers.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 27 +++++++++++++++++++++++++++
 include/drm/drm_drv.h       | 15 +++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 86d9b0e45c8c..fc6e932a4fa6 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -779,6 +779,30 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struc=
t vm_area_struct *vma)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
=20
+#ifdef CONFIG_VIRTIO
+/**
+ * drm_gem_dmabuf_get_uuid - dma_buf get_uuid implementation for GEM
+ * @dma_buf: buffer to query
+ * @uuid: uuid outparam
+ *
+ * Queries the buffer's virtio UUID. This can be used as the
+ * &dma_buf_ops.get_uuid callback. Calls into &drm_driver.gem_prime_get_uu=
id.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_gem_dmabuf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid)
+{
+=09struct drm_gem_object *obj =3D dma_buf->priv;
+=09struct drm_device *dev =3D obj->dev;
+
+=09if (!dev->driver->gem_prime_get_uuid)
+=09=09return -ENODEV;
+
+=09return dev->driver->gem_prime_get_uuid(obj, uuid);
+}
+EXPORT_SYMBOL(drm_gem_dmabuf_get_uuid);
+#endif
+
 static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D  {
 =09.cache_sgt_mapping =3D true,
 =09.attach =3D drm_gem_map_attach,
@@ -789,6 +813,9 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_op=
s =3D  {
 =09.mmap =3D drm_gem_dmabuf_mmap,
 =09.vmap =3D drm_gem_dmabuf_vmap,
 =09.vunmap =3D drm_gem_dmabuf_vunmap,
+#ifdef CONFIG_VIRTIO
+=09.get_uuid =3D drm_gem_dmabuf_get_uuid,
+#endif
 };
=20
 /**
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 77685ed7aa65..3cbe9aa6b44a 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -32,6 +32,10 @@
=20
 #include <drm/drm_device.h>
=20
+#ifdef CONFIG_VIRTIO
+#include <linux/uuid.h>
+#endif
+
 struct drm_file;
 struct drm_gem_object;
 struct drm_master;
@@ -639,6 +643,17 @@ struct drm_driver {
 =09int (*gem_prime_mmap)(struct drm_gem_object *obj,
 =09=09=09=09struct vm_area_struct *vma);
=20
+#ifdef CONFIG_VIRTIO
+=09/**
+=09 * @gem_prime_get_uuid
+=09 *
+=09 * get_uuid hook for GEM drivers. Retrieves the virtio uuid of the
+=09 * given GEM buffer.
+=09 */
+=09int (*gem_prime_get_uuid)(struct drm_gem_object *obj,
+=09=09=09=09  uuid_t *uuid);
+#endif
+
 =09/**
 =09 * @dumb_create:
 =09 *
--=20
2.25.0.265.gbab2e86ba0-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

