Return-Path: virtio-dev-return-4814-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA48B985C93
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Sep 2018 23:50:54 +0000 (UTC)
MIME-Version: 1.0
References: <20180829122026.27012-1-kraxel@redhat.com> <20180829122026.27012-3-kraxel@redhat.com>
In-Reply-To: <20180829122026.27012-3-kraxel@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 4 Sep 2018 09:50:42 +1000
Message-ID: <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org, Dave Airlie <airlied@linux.ie>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

For the series,

Reviewed-by: Dave Airlie <airlied@redhat.com>
On Wed, 29 Aug 2018 at 22:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use the dma mapping api and properly add iommu mappings for
> objects, unless virtio is in iommu quirk mode.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 46 +++++++++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index cbbff01077..ec9a38f995 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -57,6 +57,7 @@ struct virtio_gpu_object {
>         uint32_t hw_res_handle;
>
>         struct sg_table *pages;
> +       uint32_t mapped;
>         void *vmap;
>         bool dumb;
>         struct ttm_place                placement_code;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index af24e91267..bf631d32d4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -424,7 +424,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>  }
>
>  static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
> -                                                 uint32_t resource_id)
> +                                                 uint32_t resource_id,
> +                                                 struct virtio_gpu_fence **fence)
>  {
>         struct virtio_gpu_resource_detach_backing *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
> @@ -435,7 +436,7 @@ static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgde
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING);
>         cmd_p->resource_id = cpu_to_le32(resource_id);
>
> -       virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +       virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
>  }
>
>  void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
> @@ -848,9 +849,10 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>                              uint32_t resource_id,
>                              struct virtio_gpu_fence **fence)
>  {
> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
>         struct virtio_gpu_mem_entry *ents;
>         struct scatterlist *sg;
> -       int si;
> +       int si, nents;
>
>         if (!obj->pages) {
>                 int ret;
> @@ -860,23 +862,33 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>                         return ret;
>         }
>
> +       if (use_dma_api) {
> +               obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> +                                        obj->pages->sgl, obj->pages->nents,
> +                                        DMA_TO_DEVICE);
> +               nents = obj->mapped;
> +       } else {
> +               nents = obj->pages->nents;
> +       }
> +
>         /* gets freed when the ring has consumed it */
> -       ents = kmalloc_array(obj->pages->nents,
> -                            sizeof(struct virtio_gpu_mem_entry),
> +       ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
>                              GFP_KERNEL);
>         if (!ents) {
>                 DRM_ERROR("failed to allocate ent list\n");
>                 return -ENOMEM;
>         }
>
> -       for_each_sg(obj->pages->sgl, sg, obj->pages->nents, si) {
> -               ents[si].addr = cpu_to_le64(sg_phys(sg));
> +       for_each_sg(obj->pages->sgl, sg, nents, si) {
> +               ents[si].addr = cpu_to_le64(use_dma_api
> +                                           ? sg_dma_address(sg)
> +                                           : sg_phys(sg));
>                 ents[si].length = cpu_to_le32(sg->length);
>                 ents[si].padding = 0;
>         }
>
>         virtio_gpu_cmd_resource_attach_backing(vgdev, resource_id,
> -                                              ents, obj->pages->nents,
> +                                              ents, nents,
>                                                fence);
>         obj->hw_res_handle = resource_id;
>         return 0;
> @@ -885,7 +897,23 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>  void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
>                               struct virtio_gpu_object *obj)
>  {
> -       virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle);
> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +       struct virtio_gpu_fence *fence;
> +
> +       if (use_dma_api && obj->mapped) {
> +               /* detach backing and wait for the host process it ... */
> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, &fence);
> +               dma_fence_wait(&fence->f, true);
> +               dma_fence_put(&fence->f);
> +
> +               /* ... then tear down iommu mappings */
> +               dma_unmap_sg(vgdev->vdev->dev.parent,
> +                            obj->pages->sgl, obj->mapped,
> +                            DMA_TO_DEVICE);
> +               obj->mapped = 0;
> +       } else {
> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, NULL);
> +       }
>  }
>
>  void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
> --
> 2.9.3
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

