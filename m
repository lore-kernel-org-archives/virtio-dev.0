Return-Path: virtio-dev-return-6916-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AD3F985FD9
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 11:20:24 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 11 Mar 2020 20:20:01 +0900
Message-Id: <20200311112004.47138-2-stevensd@chromium.org>
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This change adds a new dma-buf operation that allows dma-bufs to be used
by virtio drivers to share exported objects. The new operation allows
the importing driver to query the exporting driver for the UUID which
identifies the underlying exported object.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 12 ++++++++++++
 include/linux/dma-buf.h   | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d4097856c86b..fa5210ba6aaa 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1158,6 +1158,18 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, void *va=
ddr)
 }
 EXPORT_SYMBOL_GPL(dma_buf_vunmap);
=20
+int dma_buf_get_uuid(struct dma_buf *dmabuf, uuid_t *uuid)
+{
+=09if (WARN_ON(!dmabuf) || !uuid)
+=09=09return -EINVAL;
+
+=09if (!dmabuf->ops->get_uuid)
+=09=09return -ENODEV;
+
+=09return dmabuf->ops->get_uuid(dmabuf, uuid);
+}
+EXPORT_SYMBOL_GPL(dma_buf_get_uuid);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index abf5459a5b9d..00758523597d 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -251,6 +251,21 @@ struct dma_buf_ops {
=20
 =09void *(*vmap)(struct dma_buf *);
 =09void (*vunmap)(struct dma_buf *, void *vaddr);
+
+=09/**
+=09 * @get_uuid
+=09 *
+=09 * This is called by dma_buf_get_uuid to get the UUID which identifies
+=09 * the buffer to virtio devices.
+=09 *
+=09 * This callback is optional.
+=09 *
+=09 * Returns:
+=09 *
+=09 * 0 on success or a negative error code on failure. On success uuid
+=09 * will be populated with the buffer's UUID.
+=09 */
+=09int (*get_uuid)(struct dma_buf *dmabuf, uuid_t *uuid);
 };
=20
 /**
@@ -444,4 +459,7 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struc=
t *,
 =09=09 unsigned long);
 void *dma_buf_vmap(struct dma_buf *);
 void dma_buf_vunmap(struct dma_buf *, void *vaddr);
+
+int dma_buf_get_uuid(struct dma_buf *dmabuf, uuid_t *uuid);
+
 #endif /* __DMA_BUF_H__ */
--=20
2.25.1.481.gfbce0eb801-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

