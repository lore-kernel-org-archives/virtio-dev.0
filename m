Return-Path: virtio-dev-return-6204-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1983398406C
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Oct 2019 15:09:35 +0000 (UTC)
From: Dmitry Morozov <dmitry.morozov@opensynergy.com>
Date: Mon, 7 Oct 2019 17:09:27 +0200
Message-ID: <4037801.MZecyecTDs@os-lin-dmo>
In-Reply-To: <CAAFQd5DZbJfEZco_fXj+jPusmj1WaMQnai2kvbuv=ZSXAz93hw@mail.gmail.com>
References: <20190919093404.182015-1-keiichiw@chromium.org> <2489202.SRFmCUqmCE@os-lin-dmo> <CAAFQd5DZbJfEZco_fXj+jPusmj1WaMQnai2kvbuv=ZSXAz93hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode device specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, stevensd@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Tomasz,

On Montag, 7. Oktober 2019 16:14:13 CEST Tomasz Figa wrote:
> Hi Dmitry,
> 
> On Mon, Oct 7, 2019 at 11:01 PM Dmitry Morozov
> 
> <dmitry.morozov@opensynergy.com> wrote:
> > Hello,
> > 
> > We at OpenSynergy are also working on an abstract paravirtualized video
> > streaming device that operates input and/or output data buffers and can be
> > used as a generic video decoder/encoder/input/output device.
> > 
> > We would be glad to share our thoughts and contribute to the discussion.
> > Please see some comments regarding buffer allocation inline.
> > 
> > Best regards,
> > Dmitry.
> > 
> > On Samstag, 5. Oktober 2019 08:08:12 CEST Tomasz Figa wrote:
> > > Hi Gerd,
> > > 
> > > On Mon, Sep 23, 2019 at 5:56 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >   Hi,
> > > >   
> > > > > Our prototype implementation uses [4], which allows the virtio-vdec
> > > > > device to use buffers allocated by virtio-gpu device.
> > > > > 
> > > > > [4] https://lkml.org/lkml/2019/9/12/157
> > > 
> > > First of all, thanks for taking a look at this RFC and for valuable
> > > feedback. Sorry for the late reply.
> > > 
> > > For reference, Keiichi is working with me and David Stevens on
> > > accelerated video support for virtual machines and integration with
> > > other virtual devices, like virtio-gpu for rendering or our
> > > currently-downstream virtio-wayland for display (I believe there is
> > > ongoing work to solve this problem in upstream too).
> > > 
> > > > Well.  I think before even discussing the protocol details we need a
> > > > reasonable plan for buffer handling.  I think using virtio-gpu buffers
> > > > should be an optional optimization and not a requirement.  Also the
> > > > motivation for that should be clear (Let the host decoder write
> > > > directly
> > > > to virtio-gpu resources, to display video without copying around the
> > > > decoded framebuffers from one device to another).
> > > 
> > > Just to make sure we're on the same page, what would the buffers come
> > > from if we don't use this optimization?
> > > 
> > > I can imagine a setup like this;
> > > 
> > >  1) host device allocates host memory appropriate for usage with host
> > > 
> > > video decoder,
> > > 
> > >  2) guest driver allocates arbitrary guest pages for storage
> > > 
> > > accessible to the guest software,
> > > 
> > >  3) guest userspace writes input for the decoder to guest pages,
> > >  4) guest driver passes the list of pages for the input and output
> > > 
> > > buffers to the host device
> > > 
> > >  5) host device copies data from input guest pages to host buffer
> > >  6) host device runs the decoding
> > >  7) host device copies decoded frame to output guest pages
> > >  8) guest userspace can access decoded frame from those pages; back to 3
> > > 
> > > Is that something you have in mind?
> > 
> > While GPU side allocations can be useful (especially in case of decoder),
> > it could be more practical to stick to driver side allocations. This is
> > also due to the fact that paravirtualized encoders and cameras are not
> > necessarily require a GPU device.
> > 
> > Also, the v4l2 framework already features convenient helpers for CMA and
> > SG
> > allocations. The buffers can be used in the same manner as in virtio-gpu:
> > buffers are first attached to an already allocated buffer/resource
> > descriptor and then are made available for processing by the device using
> > a dedicated command from the driver.
> 
> First of all, thanks a lot for your input. This is a relatively new
> area of virtualization and we definitely need to collect various
> possible perspectives in the discussion.
> 
> From Chrome OS point of view, there are several aspects for which the
> guest side allocation doesn't really work well:
> 1) host-side hardware has a lot of specific low level allocation
> requirements, like alignments, paddings, address space limitations and
> so on, which is not something that can be (easily) taught to the guest
> OS,
I couldn't agree more. There are some changes by Greg to add support for 
querying GPU buffer metadata. Probably those changes could be integrated with 
'a framework for cross-device buffer sharing' (something that Greg mentioned 
earlier in the thread and that would totally make sense).

> 2) allocation system is designed to be centralized, like Android
> gralloc, because there is almost never a case when a buffer is to be
> used only with 1 specific device. 99% of the cases are pipelines like
> decoder -> GPU/display, camera -> encoder + GPU/display, GPU ->
> encoder and so on, which means that allocations need to take into
> account multiple hardware constraints.
> 3) protected content decoding: the memory for decoded video frames
> must not be accessible to the guest at all
This looks like a valid use case. Would it also be possible for instance to 
allocate mem from a secure ION heap on the guest and then to provide the sgt 
to the device? We don't necessarily need to map that sgt for guest access.

Best regards,
Dmitry.

> 
> That said, the common desktop Linux model bases on allocating from the
> producer device (which is why videobuf2 has allocation capability) and
> we definitely need to consider this model, even if we just think about
> Linux V4L2 compliance. That's why I'm suggesting the unified memory
> handling based on guest physical addresses, which would handle both
> guest-allocated and host-allocated memory.
> 
> Best regards,
> Tomasz
> 
> > > > Referencing virtio-gpu buffers needs a better plan than just re-using
> > > > virtio-gpu resource handles.  The handles are device-specific.  What
> > > > if
> > > > there are multiple virtio-gpu devices present in the guest?
> > > > 
> > > > I think we need a framework for cross-device buffer sharing.  One
> > > > possible option would be to have some kind of buffer registry, where
> > > > buffers can be registered for cross-device sharing and get a unique
> > > > id (a uuid maybe?).  Drivers would typically register buffers on
> > > > dma-buf export.
> > > 
> > > This approach could possibly let us handle this transparently to
> > > importers, which would work for guest kernel subsystems that rely on
> > > the ability to handle buffers like native memory (e.g. having a
> > > sgtable or DMA address) for them.
> > > 
> > > How about allocating guest physical addresses for memory corresponding
> > > to those buffers? On the virtio-gpu example, that could work like
> > > 
> > > this:
> > >  - by default a virtio-gpu buffer has only a resource handle,
> > >  - VIRTIO_GPU_RESOURCE_EXPORT command could be called to have the
> > > 
> > > virtio-gpu device export the buffer to a host framework (inside the
> > > VMM) that would allocate guest page addresses for it, which the
> > > command would return in a response to the guest,
> > > 
> > >  - virtio-gpu driver could then create a regular DMA-buf object for
> > > 
> > > such memory, because it's just backed by pages (even though they may
> > > not be accessible to the guest; just like in the case of TrustZone
> > > memory protection on bare metal systems),
> > > 
> > >  - any consumer would be able to handle such buffer like a regular
> > > 
> > > guest memory, passing low-level scatter-gather tables to the host as
> > > buffer descriptors - this would nicely integrate with the basic case
> > > without buffer sharing, as described above.
> > > 
> > > Another interesting side effect of the above approach would be the
> > > ease of integration with virtio-iommu. If the virtio master device is
> > > put behind a virtio-iommu, the guest page addresses become the input
> > > to iommu page tables and IOVA addresses go to the host via the virtio
> > > master device protocol, inside the low-level scatter-gather tables.
> > > 
> > > What do you think?
> > > 
> > > Best regards,
> > > Tomasz
> > > 
> > > > Another option would be to pass around both buffer handle and buffer
> > > > owner, i.e. instead of "u32 handle" have something like this:
> > > > 
> > > > struct buffer_reference {
> > > > 
> > > >         enum device_type; /* pci, virtio-mmio, ... */
> > > >         union device_address {
> > > >         
> > > >                 struct pci_address pci_addr;
> > > >                 u64 virtio_mmio_addr;
> > > >                 [ ... ]
> > > >         
> > > >         };
> > > >         u64 device_buffer_handle; /* device-specific, virtio-gpu could
> > > >         use
> > > >         resource ids here */>
> > > > 
> > > > };
> > > > 
> > > > cheers,
> > > > 
> > > >   Gerd
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 

Dmitry Morozov
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:    +49 30 60 98 54 0 - 910
Fax:      +49 30 60 98 54 0 - 99



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

