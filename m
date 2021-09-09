Return-Path: <virtio-dev-return-8656-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D77FE9864E2
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Sep 2021 01:37:35 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  8 Sep 2021 18:37:16 -0700
Message-Id: <20210909013717.861-12-gurchetansingh@chromium.org>
In-Reply-To: <20210909013717.861-1-gurchetansingh@chromium.org>
References: <20210909013717.861-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v1 11/12] drm/virtio: implement context init: add virtio_gpu_fence_event
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Similar to DRM_VMW_EVENT_FENCE_SIGNALED.  Sends a pollable event
to the DRM file descriptor when a fence on a specific ring is
signaled.

One difference is the event is not exposed via the UAPI -- this is
because host responses are on a shared memory buffer of type
BLOB_MEM_GUEST [this is the common way to receive responses with
virtgpu].  As such, there is no context specific read(..)
implementation either -- just a poll(..) implementation.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Nicholas Verne <nverne@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   | 43 +++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 +++++
 drivers/gpu/drm/virtio/virtgpu_fence.c | 10 ++++++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 ++++++++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/=
virtgpu_drv.c
index 9d963f1fda8f..749db18dcfa2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -29,6 +29,8 @@
 #include <linux/module.h>
 #include <linux/console.h>
 #include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
=20
 #include <drm/drm.h>
 #include <drm/drm_aperture.h>
@@ -155,6 +157,35 @@ static void virtio_gpu_config_changed(struct virtio_de=
vice *vdev)
 =09schedule_work(&vgdev->config_changed_work);
 }
=20
+static __poll_t virtio_gpu_poll(struct file *filp,
+=09=09=09=09struct poll_table_struct *wait)
+{
+=09struct drm_file *drm_file =3D filp->private_data;
+=09struct virtio_gpu_fpriv *vfpriv =3D drm_file->driver_priv;
+=09struct drm_device *dev =3D drm_file->minor->dev;
+=09struct drm_pending_event *e =3D NULL;
+=09__poll_t mask =3D 0;
+
+=09if (!vfpriv->ring_idx_mask)
+=09=09return drm_poll(filp, wait);
+
+=09poll_wait(filp, &drm_file->event_wait, wait);
+
+=09if (!list_empty(&drm_file->event_list)) {
+=09=09spin_lock_irq(&dev->event_lock);
+=09=09e =3D list_first_entry(&drm_file->event_list,
+=09=09=09=09     struct drm_pending_event, link);
+=09=09drm_file->event_space +=3D e->event->length;
+=09=09list_del(&e->link);
+=09=09spin_unlock_irq(&dev->event_lock);
+
+=09=09kfree(e);
+=09=09mask |=3D EPOLLIN | EPOLLRDNORM;
+=09}
+
+=09return mask;
+}
+
 static struct virtio_device_id id_table[] =3D {
 =09{ VIRTIO_ID_GPU, VIRTIO_DEV_ANY_ID },
 =09{ 0 },
@@ -194,7 +225,17 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_AUTHOR("Alon Levy");
=20
-DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
+static const struct file_operations virtio_gpu_driver_fops =3D {
+=09.owner          =3D THIS_MODULE,
+=09.open           =3D drm_open,
+=09.release        =3D drm_release,
+=09.unlocked_ioctl =3D drm_ioctl,
+=09.compat_ioctl   =3D drm_compat_ioctl,
+=09.poll           =3D virtio_gpu_poll,
+=09.read           =3D drm_read,
+=09.llseek         =3D noop_llseek,
+=09.mmap           =3D drm_gem_mmap
+};
=20
 static const struct drm_driver driver =3D {
 =09.driver_features =3D DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIV=
ER_ATOMIC,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index cb60d52c2bd1..e0265fe74aa5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -138,11 +138,18 @@ struct virtio_gpu_fence_driver {
 =09spinlock_t       lock;
 };
=20
+#define VIRTGPU_EVENT_FENCE_SIGNALED_INTERNAL 0x10000000
+struct virtio_gpu_fence_event {
+=09struct drm_pending_event base;
+=09struct drm_event event;
+};
+
 struct virtio_gpu_fence {
 =09struct dma_fence f;
 =09uint32_t ring_idx;
 =09uint64_t fence_id;
 =09bool emit_fence_info;
+=09struct virtio_gpu_fence_event *e;
 =09struct virtio_gpu_fence_driver *drv;
 =09struct list_head node;
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virti=
o/virtgpu_fence.c
index 98a00c1e654d..f28357dbde35 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -152,11 +152,21 @@ void virtio_gpu_fence_event_process(struct virtio_gpu=
_device *vgdev,
 =09=09=09=09continue;
=20
 =09=09=09dma_fence_signal_locked(&curr->f);
+=09=09=09if (curr->e) {
+=09=09=09=09drm_send_event(vgdev->ddev, &curr->e->base);
+=09=09=09=09curr->e =3D NULL;
+=09=09=09}
+
 =09=09=09list_del(&curr->node);
 =09=09=09dma_fence_put(&curr->f);
 =09=09}
=20
 =09=09dma_fence_signal_locked(&signaled->f);
+=09=09if (signaled->e) {
+=09=09=09drm_send_event(vgdev->ddev, &signaled->e->base);
+=09=09=09signaled->e =3D NULL;
+=09=09}
+
 =09=09list_del(&signaled->node);
 =09=09dma_fence_put(&signaled->f);
 =09=09break;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index be7b22a03884..fdaa7f3d9eeb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -38,6 +38,36 @@
 =09=09=09=09    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
 =09=09=09=09    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
=20
+static int virtio_gpu_fence_event_create(struct drm_device *dev,
+=09=09=09=09=09 struct drm_file *file,
+=09=09=09=09=09 struct virtio_gpu_fence *fence,
+=09=09=09=09=09 uint32_t ring_idx)
+{
+=09struct virtio_gpu_fpriv *vfpriv =3D file->driver_priv;
+=09struct virtio_gpu_fence_event *e =3D NULL;
+=09int ret;
+
+=09if (!(vfpriv->ring_idx_mask & (1 << ring_idx)))
+=09=09return 0;
+
+=09e =3D kzalloc(sizeof(*e), GFP_KERNEL);
+=09if (!e)
+=09=09return -ENOMEM;
+
+=09e->event.type =3D VIRTGPU_EVENT_FENCE_SIGNALED_INTERNAL;
+=09e->event.length =3D sizeof(e->event);
+
+=09ret =3D drm_event_reserve_init(dev, file, &e->base, &e->event);
+=09if (ret)
+=09=09goto free;
+
+=09fence->e =3D e;
+=09return 0;
+free:
+=09kfree(e);
+=09return ret;
+}
+
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgd=
ev,
 =09=09=09=09=09     struct virtio_gpu_fpriv *vfpriv)
@@ -195,6 +225,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_devi=
ce *dev, void *data,
 =09=09goto out_unresv;
 =09}
=20
+=09ret =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+=09if (ret)
+=09=09goto out_unresv;
+
 =09if (out_fence_fd >=3D 0) {
 =09=09sync_file =3D sync_file_create(&out_fence->f);
 =09=09if (!sync_file) {
--=20
2.33.0.153.gba50c8fa24-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

