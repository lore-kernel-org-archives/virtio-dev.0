Return-Path: virtio-dev-return-5464-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29FEA985D01
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 03:50:04 +0000 (UTC)
Date: Tue, 19 Feb 2019 22:49:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190219224753-mutt-send-email-mst@kernel.org>
References: <20190131023617.23007-1-stefanha@redhat.com>
 <20190131023617.23007-2-stefanha@redhat.com>
 <20190130231152-mutt-send-email-mst@kernel.org>
 <51483aeb-9409-3a90-8da6-369fa4d34488@siemens.com>
 <20190218140420.GG12256@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218140420.GG12256@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] virtio-blk: document data[] size
 constraints
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio-dev@lists.oasis-open.org, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 18, 2019 at 02:04:20PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 18, 2019 at 08:22:00AM +0100, Jan Kiszka wrote:
> > On 31.01.19 05:14, Michael S. Tsirkin wrote:
> > > On Thu, Jan 31, 2019 at 10:36:14AM +0800, Stefan Hajnoczi wrote:
> > > > The struct virtio_blk_req->data[] field is a multiple of 512 bytes long
> > > > for read and write requests.  Flush requests don't use data[] at all.
> > > > 
> > > > The new discard and write zeroes requests being introduced in VIRTIO 1.1
> > > > put struct virtio_blk_discard_write_zeroes elements into data[], so it
> > > > must be a multiple of the struct size.
> > > > 
> > > > The uint8_t data[][512] pseudo-code makes it look like discard and write
> > > > zeroes requests must pad to 512 bytes.  This wastes memory since struct
> > > > virtio_blk_discard_write_data is only 16 bytes long.
> > > > 
> > > > Furthermore, all known implementations wishing to take advantage of this
> > > > upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
> > > > virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-blk
> > > > driver, and the SPDK vhost-user-blk device backend).
> > > > 
> > > > This patch documents the data[] size constraints clearly in the driver
> > > > normative section.  This is clearer than the current pseudo-code.
> > > > 
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >   content.tex | 14 +++++++++++++-
> > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index 836ee52..b185bb0 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3941,7 +3941,7 @@ struct virtio_blk_req {
> > > >           le32 type;
> > > >           le32 reserved;
> > > >           le64 sector;
> > > > -        u8 data[][512];
> > > > +        u8 data[];
> > > >           u8 status;
> > > >   };
> > > > @@ -3971,6 +3971,11 @@ The \field{sector} number indicates the offset (multiplied by 512) where
> > > >   the read or write is to occur. This field is unused and set to 0 for
> > > >   commands other than read or write.
> > > > +VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
> > > > +read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
> > > > +requests write the contents of \field{data} to the block device (in multiples
> > > > +of 512 bytes).
> > > > +
> > > >   The \field{data} used for discard or write zeroes command is described
> > > >   by one or more virtio_blk_discard_write_zeroes structs. \field{sector}
> > > >   indicates the starting offset (in 512-byte units) of the segment, while
> > > > @@ -3997,6 +4002,13 @@ A driver SHOULD accept the VIRTIO_BLK_F_RO feature if offered.
> > > >   A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
> > > >   A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
> > > > +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
> > > > +and VIRTIO_BLK_T_OUT requests.
> > > > +
> > > > +The length of \field{data} MUST be a multiple of the size of struct
> > > > +virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> > > > +VIRTIO_BLK_T_WRITE_ZEROES requests.
> > > > +
> > > 
> 
> I'm not the original spec author.  Feel free to correct me if this is
> wrong:
> 
> > > So a single request can discard/write multiple ranges?
> > > It might be a good idea to make this explicit.
> > > Also is this capability useful/used?
> 
> The multiple segments feature was included because the underlying
> storage might support it.  Currently we don't expect much use but future
> hardware may rely on it more heavily (e.g. for performance).
> 
> > > And what's the value of status
> > > in case some of the requests fail?
> 
> A failure for any segment causes the entire request to fail with no
> information about which segments completed or failed.

And what's the status?

> > What happened with this comment? I don't see a follow-up nor a resolution
> > elsewhere, just the opening of issue #32 for voting. Please clarify.
> 
> With #32 applied the spec says:
> 
> "max_discard_seg can be read to determine the [...] maximum number of discard segments for the block driver to use"
> 
> and
> 
> "The length of \field{data} MUST be a multiple of the size of struct
> virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
> VIRTIO_BLK_T_WRITE_ZEROES requests."
> 
> This is not very explicit but it means multiple struct
> virtio_blk_discard_write_zeroes can be included in a request, up to
> max_discard_seg.
> 
> I think two things are appropriate:
> 1. A driver normative statement saying up to
>    max_discard_seg/max_write_zeroes_seg structs may be included in a
>    request
> 2. A general description that says DISCARD/WRITE_ZEROES requests may
>    have more than 1 "segment" (struct virtio_blk_discard_write_zeroes)
> 
> Does that sound good?
> 
> Stefan

Also pls include explanation about failure mode.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

