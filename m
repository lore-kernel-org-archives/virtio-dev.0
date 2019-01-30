Return-Path: virtio-dev-return-5353-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE9DF985F23
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Jan 2019 17:01:16 +0000 (UTC)
Date: Wed, 30 Jan 2019 12:01:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190130115017-mutt-send-email-mst@kernel.org>
References: <20190130085718.15931-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130085718.15931-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document data[] size constraints
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 30, 2019 at 04:57:18PM +0800, Stefan Hajnoczi wrote:
> The struct virtio_blk_req->data[] field is a multiple of 512 bytes long
> for read and write requests.  Flush requests don't use data[] at all.
> 
> The new discard and write zeroes requests being introduced in VIRTIO 1.1
> put struct virtio_blk_discard_write_zeroes elements into data[], so it
> must be a multiple of the struct size.
> 
> The uint8_t data[][512] pseudo-code makes it look like discard and write
> zeroes requests must pad to 512 bytes.  This wastes memory since struct
> virtio_blk_discard_write_data is only 16 bytes long.
> 
> Furthermore, all known implementations wishing to take advantage of this
> upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
> virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-blk
> driver, and the SPDK vhost-user-blk device backend).
> 
> This patch documents the data[] size constraints clearly in the driver
> normative section.  This is clearer than the current pseudo-code.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Changpeng Liu <changpeng.liu@intel.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Yes I don't see how we can require 512 bytes there.
Looks good, thanks!
As a reminder next step is github issue, sending Fixes: tag and
asking for a vote.
I also noticed a couple of minor defects listed below.
Would you mind taking a look and handling them?


> ---
>  content.tex | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index 836ee52..b185bb0 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3941,7 +3941,7 @@ struct virtio_blk_req {
>          le32 type;
>          le32 reserved;
>          le64 sector;
> -        u8 data[][512];
> +        u8 data[];
>          u8 status;
>  };
>  
> @@ -3971,6 +3971,11 @@ The \field{sector} number indicates the offset (multiplied by 512) where
>  the read or write is to occur. This field is unused and set to 0 for
>  commands other than read or write.
>  
> +VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
> +read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
> +requests write the contents of \field{data} to the block device (in multiples
> +of 512 bytes).
> +
>  The \field{data} used for discard or write zeroes command is described
>  by one or more virtio_blk_discard_write_zeroes structs.

One has to go quite far to find the definition of
virtio_blk_discard_write_zeroes.

1. how about moving

struct virtio_blk_discard_write_zeroes {
       le64 sector;
       le32 num_sectors;
       struct {
               le32 unmap:1;
               le32 reserved:31;
       } flags;
};

right here where it's referred to?

Because it says on top:

	Each request is of form:

and that does not refer to  virtio_blk_discard_write_zeroes at all.


> \field{sector}
>  indicates the starting offset (in 512-byte units) of the segment, while
> @@ -3997,6 +4002,13 @@ A driver SHOULD accept the VIRTIO_BLK_F_RO feature if offered.
>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
>  
> +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
> +and VIRTIO_BLK_T_OUT requests.
> +
> +The length of \field{data} MUST be a multiple of the size of struct
> +virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> +VIRTIO_BLK_T_WRITE_ZEROES requests.
> +
>  If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the driver MAY
>  switch to writethrough or writeback mode by writing respectively 0 and
>  1 to the \field{writeback} field.  After writing a 0 to \field{writeback},

2.  For unmap it says:

	\field{unmap} is only used for write zeroes command.

and that's all. But what does it do? One can poke at normative
statements and figure it out but it would be better to
actually say it:
E.g.

	\field{unmap} is only used for write zeroes command.
	It allows the device to discard the specified
	range as if discard has been sent, provided
	that following reads return zeroes.

3. Normative statements say DISCARD in upper case for some reason,
which is inconsistent with rest of usage. Either discard or
VIRTIO_BLK_T_DISCARD should be used.

> -- 
> 2.20.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

