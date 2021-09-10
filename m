Return-Path: <virtio-dev-return-8659-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FD88986502
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Sep 2021 19:33:34 +0000 (UTC)
MIME-Version: 1.0
References: <20210909013717.861-1-gurchetansingh@chromium.org> <20210909013717.861-10-gurchetansingh@chromium.org>
In-Reply-To: <20210909013717.861-10-gurchetansingh@chromium.org>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 10 Sep 2021 12:33:21 -0700
Message-ID: <CAPaKu7RB0hHTW9_WoOvp1X1Wz8L65ptSsJXKcPu22Rm9NKjAFQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v1 09/12] drm/virtio: implement context init:
 allocate an array of fence contexts
Content-Type: text/plain; charset="UTF-8"
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 8, 2021 at 6:37 PM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
> We don't want fences from different 3D contexts (virgl, gfxstream,
> venus) to be on the same timeline.  With explicit context creation,
> we can specify the number of ring each context wants.
>
> Execbuffer can specify which ring to use.
>
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Acked-by: Lingfeng Yang <lfy@google.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 34 ++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index a5142d60c2fa..cca9ab505deb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -56,6 +56,7 @@
>  #define STATE_ERR 2
>
>  #define MAX_CAPSET_ID 63
> +#define MAX_RINGS 64
>
>  struct virtio_gpu_object_params {
>         unsigned long size;
> @@ -263,6 +264,8 @@ struct virtio_gpu_fpriv {
>         uint32_t ctx_id;
>         uint32_t context_init;
>         bool context_created;
> +       uint32_t num_rings;
> +       uint64_t base_fence_ctx;
>         struct mutex context_lock;
>  };
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index f51f3393a194..262f79210283 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -99,6 +99,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         int in_fence_fd = exbuf->fence_fd;
>         int out_fence_fd = -1;
>         void *buf;
> +       uint64_t fence_ctx;
> +       uint32_t ring_idx;
> +
> +       fence_ctx = vgdev->fence_drv.context;
> +       ring_idx = 0;
>
>         if (vgdev->has_virgl_3d == false)
>                 return -ENOSYS;
> @@ -106,6 +111,17 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
>                 return -EINVAL;
>
> +       if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
> +               if (exbuf->ring_idx >= vfpriv->num_rings)
> +                       return -EINVAL;
> +
> +               if (!vfpriv->base_fence_ctx)
> +                       return -EINVAL;
> +
> +               fence_ctx = vfpriv->base_fence_ctx;
> +               ring_idx = exbuf->ring_idx;
> +       }
> +
>         exbuf->fence_fd = -1;
>
>         virtio_gpu_create_context(dev, file);
> @@ -173,7 +189,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                         goto out_memdup;
>         }
>
> -       out_fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
> +       out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
>         if(!out_fence) {
>                 ret = -ENOMEM;
>                 goto out_unresv;
> @@ -691,7 +707,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
>                 return -EINVAL;
>
>         /* Number of unique parameters supported at this time. */
> -       if (num_params > 1)
> +       if (num_params > 2)
>                 return -EINVAL;
>
>         ctx_set_params = memdup_user(u64_to_user_ptr(args->ctx_set_params),
> @@ -731,6 +747,20 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
>
>                         vfpriv->context_init |= value;
>                         break;
> +               case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
> +                       if (vfpriv->base_fence_ctx) {
> +                               ret = -EINVAL;
> +                               goto out_unlock;
> +                       }
> +
> +                       if (value > MAX_RINGS) {
> +                               ret = -EINVAL;
> +                               goto out_unlock;
> +                       }
> +
> +                       vfpriv->base_fence_ctx = dma_fence_context_alloc(value);
With multiple fence contexts, we should do something about implicit fencing.

The classic example is Mesa and X server.  When both use virgl and the
global fence context, no dma_fence_wait is fine.  But when Mesa uses
venus and the ring fence context, dma_fence_wait should be inserted.


> +                       vfpriv->num_rings = value;
> +                       break;
>                 default:
>                         ret = -EINVAL;
>                         goto out_unlock;
> --
> 2.33.0.153.gba50c8fa24-goog
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

