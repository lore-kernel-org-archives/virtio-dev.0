Return-Path: virtio-dev-return-7758-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DC05985ED7
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Sep 2020 21:11:28 +0000 (UTC)
MIME-Version: 1.0
References: <20200902210847.2689-1-gurchetansingh@chromium.org> <20200902210847.2689-23-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-23-gurchetansingh@chromium.org>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 3 Sep 2020 14:11:15 -0700
Message-ID: <CAPaKu7Riurr-+O8Kdi=e2+ivG=P2L1CKGtu8cXGpSjnC34pYPw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 22/23] drm/virtio: implement blob resources: resource
 create blob ioctl
Content-Type: text/plain; charset="UTF-8"
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, sebastien.boeuf@intel.com, Gerd Hoffmann <kraxel@redhat.com>, vgoyal@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 2, 2020 at 2:09 PM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
> From: Gerd Hoffmann <kraxel@redhat.com>
>
> Implement resource create blob as specified.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Co-developed-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 136 ++++++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_object.c |   5 +-
>  drivers/gpu/drm/virtio/virtgpu_vram.c   |   2 +
>  4 files changed, 144 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 6162865c162df..d2ea199dbdb90 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -257,8 +257,8 @@ struct virtio_gpu_fpriv {
>         struct mutex context_lock;
>  };
>
> -/* virtgpu_ioctl.c */
> -#define DRM_VIRTIO_NUM_IOCTLS 10
> +/* virtio_ioctl.c */
> +#define DRM_VIRTIO_NUM_IOCTLS 11
>  extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
>  void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file);
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 7dbe24248a200..442cbca59c8a5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -34,6 +34,10 @@
>
>  #include "virtgpu_drv.h"
>
> +#define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
> +                                   VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +
>  void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
>  {
>         struct virtio_gpu_device *vgdev = dev->dev_private;
> @@ -520,6 +524,134 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>         return 0;
>  }
>
> +static int verify_blob(struct virtio_gpu_device *vgdev,
> +                      struct virtio_gpu_fpriv *vfpriv,
> +                      struct virtio_gpu_object_params *params,
> +                      struct drm_virtgpu_resource_create_blob *rc_blob,
> +                      bool *guest_blob, bool *host3d_blob)
> +{
> +       if (!vgdev->has_resource_blob)
> +               return -EINVAL;
> +
> +       if ((rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK) ||
> +           !rc_blob->blob_flags)
> +               return -EINVAL;
> +
> +       if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
> +               if (!vgdev->has_resource_assign_uuid)
> +                       return -EINVAL;
> +       }
> +
> +       switch (rc_blob->blob_mem) {
> +       case VIRTGPU_BLOB_MEM_GUEST:
> +               *guest_blob = true;
> +               break;
> +       case VIRTGPU_BLOB_MEM_HOST3D_GUEST:
> +               *guest_blob = true;
> +               fallthrough;
> +       case VIRTGPU_BLOB_MEM_HOST3D:
> +               *host3d_blob = true;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (*host3d_blob) {
> +               if (!vgdev->has_virgl_3d)
> +                       return -EINVAL;
> +
> +               /* Must be dword aligned. */
> +               if (rc_blob->cmd_size % 4 != 0)
> +                       return -EINVAL;
> +
> +               params->ctx_id = vfpriv->ctx_id;
> +               params->blob_id = rc_blob->blob_id;
> +       } else {
> +               if (rc_blob->blob_id != 0)
> +                       return -EINVAL;
> +
> +               if (rc_blob->cmd_size != 0)
> +                       return -EINVAL;
> +       }
> +
> +       params->blob_mem = rc_blob->blob_mem;
> +       params->size = rc_blob->size;
> +       params->blob = true;
> +       params->blob_flags = rc_blob->blob_flags;
> +       return 0;
> +}
> +
> +static int virtio_gpu_resource_create_blob(struct drm_device *dev,
> +                                          void *data, struct drm_file *file)
> +{
> +       int ret = 0;
> +       uint32_t handle = 0;
> +       bool guest_blob = false;
> +       bool host3d_blob = false;
> +       struct drm_gem_object *obj;
> +       struct virtio_gpu_object *bo;
> +       struct virtio_gpu_object_params params = { 0 };
> +       struct virtio_gpu_device *vgdev = dev->dev_private;
> +       struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> +       struct drm_virtgpu_resource_create_blob *rc_blob = data;
> +
> +       if (verify_blob(vgdev, vfpriv, &params, rc_blob,
> +                       &guest_blob, &host3d_blob))
> +               return -EINVAL;
> +
> +       if (vgdev->has_virgl_3d)
> +               virtio_gpu_create_context(dev, file);
> +
> +       if (rc_blob->cmd_size) {
> +               void *buf;
> +
> +               buf = memdup_user(u64_to_user_ptr(rc_blob->cmd),
> +                                 rc_blob->cmd_size);
> +
> +               if (IS_ERR(buf))
> +                       return PTR_ERR(buf);
> +
> +               virtio_gpu_cmd_submit(vgdev, buf, rc_blob->cmd_size,
> +                                     vfpriv->ctx_id, NULL, NULL);
> +       }
> +
> +       if (guest_blob)
> +               ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
> +       else if (!guest_blob && host3d_blob)
> +               ret = virtio_gpu_vram_create(vgdev, &params, &bo);
When cmd_size != 0, a host blob has been allocated.  Will it be leaked
if virtio_gpu_{object,vram}_create fails?


> +       else
> +               return -EINVAL;
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       bo->guest_blob = guest_blob;
> +       bo->host3d_blob = host3d_blob;
> +       bo->blob_mem = rc_blob->blob_mem;
> +       bo->blob_flags = rc_blob->blob_flags;
> +
> +       obj = &bo->base.base;
> +       if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
> +               ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
> +               if (ret) {
> +                       drm_gem_object_release(obj);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = drm_gem_handle_create(file, obj, &handle);
> +       if (ret) {
> +               drm_gem_object_release(obj);
> +               return ret;
> +       }
> +       drm_gem_object_put(obj);
> +
> +       rc_blob->res_handle = bo->hw_res_handle;
> +       rc_blob->bo_handle = handle;
> +
> +       return 0;
> +}
> +
>  struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
>         DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
>                           DRM_RENDER_ALLOW),
> @@ -552,4 +684,8 @@ struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
>                           DRM_RENDER_ALLOW),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE_BLOB,
> +                         virtio_gpu_resource_create_blob,
> +                         DRM_RENDER_ALLOW),
>  };
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index cef79455257df..258b4eeae7c2c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -244,7 +244,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 return ret;
>         }
>
> -       if (params->virgl) {
> +       if (params->blob) {
> +               virtio_gpu_cmd_resource_create_blob(vgdev, bo, params,
> +                                                   ents, nents);
> +       } else if (params->virgl) {
>                 virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
>                                                   objs, fence);
>                 virtio_gpu_object_attach(vgdev, bo, ents, nents);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
> index 087945fcd230f..23c21bc4d01e2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -149,6 +149,8 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
>                 return ret;
>         }
>
> +       virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
> +                                           0);
>         if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
>                 ret = virtio_gpu_vram_map(&vram->base);
>                 if (ret) {
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

