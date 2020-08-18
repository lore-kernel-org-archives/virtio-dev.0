Return-Path: virtio-dev-return-7673-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2013E983D92
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Aug 2020 06:00:07 +0000 (UTC)
Date: Tue, 18 Aug 2020 07:59:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200818055949.6si4jzuubba5dx5u@sirius.home.kraxel.org>
References: <20200818013744.3327271-1-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200818013744.3327271-1-stevensd@chromium.org>
Subject: [virtio-dev] Re: [PATCH v6 0/3] Support virtio cross-device resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 18, 2020 at 10:37:41AM +0900, David Stevens wrote:
> This patchset implements the current proposal for virtio cross-device
> resource sharing [1]. It will be used to import virtio resources into
> the virtio-video driver currently under discussion [2]. The patch
> under consideration to add support in the virtio-video driver is [3].
> It uses the APIs from v3 of this series, but the changes to update it
> are relatively minor.
> 
> This patchset adds a new flavor of dma-bufs that supports querying the
> underlying virtio object UUID, as well as adding support for exporting
> resources from virtgpu.
> 
> [1] https://markmail.org/thread/2ypjt5cfeu3m6lxu
> [2] https://markmail.org/thread/p5d3k566srtdtute
> [3] https://markmail.org/thread/j4xlqaaim266qpks
> 
> v5 -> v6 changes:
>  - Fix >80 character comment

Hmm, checkpatch still complains, full log below.

IIRC "dim checkpatch" runs scripts/checkpatch.pl with --strict
so it is a bit more picky ...

The FILE_PATH_CHANGES isn't a problem given that the new file
is covered by existing wildcard.

take care,
  Gerd

---------------------------------------------------------------
+ dim checkpatch drm-misc-next..drm-qemu-next drm-misc
ee194dc222ae virtio: add dma-buf support for exported objects
-:29: WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#29: 
new file mode 100644

-:65: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#65: FILE: include/linux/virtio_dma_buf.h:32:
+struct dma_buf *virtio_dma_buf_export(

-:112: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#112: FILE: drivers/virtio/virtio_dma_buf.c:19:
+struct dma_buf *virtio_dma_buf_export(

-:115: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#115: FILE: drivers/virtio/virtio_dma_buf.c:22:
+	const struct virtio_dma_buf_ops *virtio_ops = container_of(

-:119: CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the previous line
#119: FILE: drivers/virtio/virtio_dma_buf.c:26:
+	if (!exp_info->ops
+		|| exp_info->ops->attach != &virtio_dma_buf_attach

-:120: CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the previous line
#120: FILE: drivers/virtio/virtio_dma_buf.c:27:
+		|| exp_info->ops->attach != &virtio_dma_buf_attach
+		|| !virtio_ops->get_uuid) {

-:135: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#135: FILE: drivers/virtio/virtio_dma_buf.c:42:
+	const struct virtio_dma_buf_ops *ops = container_of(

-:167: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#167: FILE: drivers/virtio/virtio_dma_buf.c:74:
+	const struct virtio_dma_buf_ops *ops = container_of(

total: 0 errors, 1 warnings, 7 checks, 144 lines checked
76c9c2abbe6b virtio-gpu: add VIRTIO_GPU_F_RESOURCE_UUID feature
9c3f3edd1cc4 (HEAD -> drm-qemu-next, kraxel.org/drm-qemu-next) drm/virtio: Support virtgpu exported resources
-:53: CHECK:UNCOMMENTED_DEFINITION: spinlock_t definition without comment
#53: FILE: drivers/gpu/drm/virtio/virtgpu_drv.h:222:
+	spinlock_t resource_export_lock;

-:250: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
#250: FILE: drivers/gpu/drm/virtio/virtgpu_vq.c:1118:
+	uint32_t resp_type = le32_to_cpu(resp->hdr.type);

-:256: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#256: FILE: drivers/gpu/drm/virtio/virtgpu_vq.c:1124:
+	if (resp_type == VIRTIO_GPU_RESP_OK_RESOURCE_UUID &&
+			obj->uuid_state == UUID_INITIALIZING) {

-:286: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#286: FILE: drivers/gpu/drm/virtio/virtgpu_vq.c:1154:
+	cmd_p = virtio_gpu_alloc_cmd_resp(vgdev,
+		virtio_gpu_cmd_resource_uuid_cb, &vbuf, sizeof(*cmd_p),

total: 0 errors, 0 warnings, 4 checks, 250 lines checked
+ exit 1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

