Return-Path: <virtio-dev-return-9633-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CC21986315
	for <virtio-dev@lists.oasis-open.org>; Sun, 26 Jun 2022 06:43:35 +0000 (UTC)
Date: Sun, 26 Jun 2022 02:43:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220626022121-mutt-send-email-mst@kernel.org>
References: <bcfa29cc-72bc-a2ef-0f7b-a882cada66b0@demindiro.com>
 <d6a014d1-e56e-6631-e0cd-cf51c1865a67@demindiro.com>
MIME-Version: 1.0
In-Reply-To: <d6a014d1-e56e-6631-e0cd-cf51c1865a67@demindiro.com>
Subject: Re: [virtio-dev] virtio-gpu: Clarification regarding
 VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hoppenbrouwers <virtio-oasis@demindiro.com>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Jun 25, 2022 at 03:45:46PM +0200, David Hoppenbrouwers wrote:
> Hello,
> 
> I believe there is a bug in QEMU's implementation of
> VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D. However it is not clear to me what
> the correct behaviour should be.
> 
> The specification says the driver must "allocate a framebuffer from
> guest ram, and attach it as backing storage to the resource just
> created". To me this implies that the size of the backing storage must
> match the size of the resource.
> 
> Consequently I intuitively expect that to update a rectangle R in the
> resource the same rectangle must be updated in the backing store, i.e:
> 
>      +--------------------+    +--------------------+
>      |                    |    |                    |
>      |        Host        |    |       Backing      |
>      |      Resource      |    |       Storage      |
>      |   +-----+          |    |   +-----+          |
>      |   |     |          |    |   |     |          |
>      |   |  R  |          |    |   |  R  |          |
>      |   |     |          |    |   |     |          |
>      |   +-----+          |    |   +-----+          |
>      +--------------------+    +--------------------+
> 
> However, QEMU actually starts drawing from the upper-left corner of the
> backing storage:
> 
>      +--------------------+    +-----+--------------+
>      |                    |    |     |              |
>      |        Host        |    |  R  | Backing      |
>      |      Resource      |    |     | Storage      |
>      |   +-----+          |    +-----+              |
>      |   |     |          |    |                    |
>      |   |  R  |          |    |                    |
>      |   |     |          |    |                    |
>      |   +-----+          |    |                    |
>      +--------------------+    +--------------------+
> 
> Reading the specification again I realized it does not explicitly
> mandate that the size of the backing storage must match the size of the
> resource. But if that were the case I would expect QEMU to behave like this:
> 
>      +--------------------+    +--------------------+
>      |                    |    |      R     +-------+
>      |        Host        |    +------------+       |
>      |      Resource      |    |                    |
>      |   +-----+          |    |       Backing      |
>      |   |     |          |    |       Storage      |
>      |   |  R  |          |    |                    |
>      |   |     |          |    |                    |
>      |   +-----+          |    |                    |
>      +--------------------+    +--------------------+
> 
> The relevant code in QEMU is in virtio_gpu_transfer_to_host_2d:
> 
>      format = pixman_image_get_format(res->image);
>      bpp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>      stride = pixman_image_get_stride(res->image);
> 
>      if (t2d.offset || t2d.r.x || t2d.r.y ||
>          t2d.r.width != pixman_image_get_width(res->image)) {
>          void *img_data = pixman_image_get_data(res->image);
>          for (h = 0; h < t2d.r.height; h++) {
>              src_offset = t2d.offset + stride * h;
>              dst_offset = (t2d.r.y + h) * stride + (t2d.r.x * bpp);
> 
>              iov_to_buf(res->iov, res->iov_cnt, src_offset,
>                         (uint8_t *)img_data
>                         + dst_offset, t2d.r.width * bpp);
> 
> I would expect src_offset to either be
> 
>      src_offset = dst_offset;
> 
> if the backing storage's size is supposed to match the resource's size.
> If not, I'd expect src_offset to be
> 
>      src_offset = t2d.offset + t2d.r.width * h;
> 
> 
> My question boils down to:
> 
> - Is QEMU's implementation correct?
>    - If yes, what is the motivation behind it? Especially, what is the
> purpose of the explicit offset?
>    - If not, what is the expected behaviour?
> 
> 
> With kind regards,
> David Hoppenbrouwers

+cc Gerd.

> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

