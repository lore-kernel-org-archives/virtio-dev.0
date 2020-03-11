Return-Path: virtio-dev-return-6917-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C76DE985FE4
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 11:20:29 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 11 Mar 2020 20:20:02 +0900
Message-Id: <20200311112004.47138-3-stevensd@chromium.org>
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 2/4] drm/prime: add support for virtio exported objects
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This change exposes dma-buf's get_uuid callback to PRIME drivers.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 23 +++++++++++++++++++++++
 include/drm/drm_drv.h       | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 86d9b0e45c8c..50fed8497d3c 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -779,6 +779,28 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struc=
t vm_area_struct *vma)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
=20
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
+
 static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =3D  {
 =09.cache_sgt_mapping =3D true,
 =09.attach =3D drm_gem_map_attach,
@@ -789,6 +811,7 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_op=
s =3D  {
 =09.mmap =3D drm_gem_dmabuf_mmap,
 =09.vmap =3D drm_gem_dmabuf_vmap,
 =09.vunmap =3D drm_gem_dmabuf_vunmap,
+=09.get_uuid =3D drm_gem_dmabuf_get_uuid,
 };
=20
 /**
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 77685ed7aa65..61e3ff341844 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -29,6 +29,7 @@
=20
 #include <linux/list.h>
 #include <linux/irqreturn.h>
+#include <linux/uuid.h>
=20
 #include <drm/drm_device.h>
=20
@@ -639,6 +640,15 @@ struct drm_driver {
 =09int (*gem_prime_mmap)(struct drm_gem_object *obj,
 =09=09=09=09struct vm_area_struct *vma);
=20
+=09/**
+=09 * @gem_prime_get_uuid
+=09 *
+=09 * get_uuid hook for GEM drivers. Retrieves the virtio uuid of the
+=09 * given GEM buffer.
+=09 */
+=09int (*gem_prime_get_uuid)(struct drm_gem_object *obj,
+=09=09=09=09  uuid_t *uuid);
+
 =09/**
 =09 * @dumb_create:
 =09 *
--=20
2.25.1.481.gfbce0eb801-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

