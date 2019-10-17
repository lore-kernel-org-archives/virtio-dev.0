Return-Path: virtio-dev-return-6245-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84582986005
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 06:58:31 +0000 (UTC)
MIME-Version: 1.0
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <20190923085637.bsaevedklweijgya@sirius.home.kraxel.org> <CAAFQd5Ba-REZU9=rdm3J6NRqqeAUFdCV7SJ_WdO2BHyKNBN7TQ@mail.gmail.com>
 <20191014121914.lyptm3gdmekvcu6v@sirius.home.kraxel.org>
In-Reply-To: <20191014121914.lyptm3gdmekvcu6v@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 17 Oct 2019 15:58:16 +0900
Message-ID: <CAAFQd5CaxYoXQ6z4pmdTG3FDN8ccEk3sHMnSkoNwL2==hk6znQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 14, 2019 at 9:19 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > Well.  I think before even discussing the protocol details we need a
> > > reasonable plan for buffer handling.  I think using virtio-gpu buffers
> > > should be an optional optimization and not a requirement.  Also the
> > > motivation for that should be clear (Let the host decoder write directly
> > > to virtio-gpu resources, to display video without copying around the
> > > decoded framebuffers from one device to another).
> >
> > Just to make sure we're on the same page, what would the buffers come
> > from if we don't use this optimization?
> >
> > I can imagine a setup like this;
> >  1) host device allocates host memory appropriate for usage with host
> > video decoder,
> >  2) guest driver allocates arbitrary guest pages for storage
> > accessible to the guest software,
> >  3) guest userspace writes input for the decoder to guest pages,
> >  4) guest driver passes the list of pages for the input and output
> > buffers to the host device
> >  5) host device copies data from input guest pages to host buffer
> >  6) host device runs the decoding
> >  7) host device copies decoded frame to output guest pages
> >  8) guest userspace can access decoded frame from those pages; back to 3
> >
> > Is that something you have in mind?
>
> I don't have any specific workflow in mind.
>
> If you want display the decoded video frames you want use dma-bufs shared
> by video decoder and gpu, right?  So the userspace application (video
> player probably) would create the buffers using one of the drivers,
> export them as dma-buf, then import them into the other driver.  Just
> like you would do on physical hardware.  So, when using virtio-gpu
> buffers:
>
>   (1) guest app creates buffers using virtio-gpu.
>   (2) guest app exports virtio-gpu buffers buffers as dma-buf.
>   (3) guest app imports the dma-bufs into virtio-vdec.
>   (4) guest app asks the virtio-vdec driver to write the decoded
>       frames into the dma-bufs.
>   (5) guest app asks the virtio-gpu driver to display the decoded
>       frame.
>
> The guest video decoder driver passes the dma-buf pages to the host, and
> it is the host driver's job to fill the buffer.  How this is done
> exactly might depend on hardware capabilities (whenever a host-allocated
> bounce buffer is needed or whenever the hardware can decode directly to
> the dma-buf passed by the guest driver) and is an implementation detail.
>
> Now, with cross-device sharing added the virtio-gpu would attach some
> kind of identifier to the dma-buf, virtio-vdec could fetch the
> identifier and pass it to the host too, and the host virtio-vdec device
> can use the identifier to get a host dma-buf handle for the (virtio-gpu)
> buffer.  Ask the host video decoder driver to import the host dma-buf.
> If it all worked fine it can ask the host hardware to decode directly to
> the host virtio-gpu resource.
>

Agreed.

> > > Referencing virtio-gpu buffers needs a better plan than just re-using
> > > virtio-gpu resource handles.  The handles are device-specific.  What if
> > > there are multiple virtio-gpu devices present in the guest?
> > >
> > > I think we need a framework for cross-device buffer sharing.  One
> > > possible option would be to have some kind of buffer registry, where
> > > buffers can be registered for cross-device sharing and get a unique
> > > id (a uuid maybe?).  Drivers would typically register buffers on
> > > dma-buf export.
> >
> > This approach could possibly let us handle this transparently to
> > importers, which would work for guest kernel subsystems that rely on
> > the ability to handle buffers like native memory (e.g. having a
> > sgtable or DMA address) for them.
> >
> > How about allocating guest physical addresses for memory corresponding
> > to those buffers? On the virtio-gpu example, that could work like
> > this:
> >  - by default a virtio-gpu buffer has only a resource handle,
> >  - VIRTIO_GPU_RESOURCE_EXPORT command could be called to have the
> > virtio-gpu device export the buffer to a host framework (inside the
> > VMM) that would allocate guest page addresses for it, which the
> > command would return in a response to the guest,
>
> Hmm, the cross-device buffer sharing framework I have in mind would
> basically be a buffer registry.  virtio-gpu would create buffers as
> usual, create a identifier somehow (details to be hashed out), attach
> the identifier to the dma-buf so it can be used as outlined above.
>
> Also note that the guest manages the address space, so the host can't
> simply allocate guest page addresses.

Is this really true? I'm not an expert in this area, but on a bare
metal system it's the hardware or firmware that sets up the various
physical address allocations on a hardware level and most of the time
most of the addresses are already pre-assigned in hardware (like the
DRAM base, various IOMEM spaces, etc.).

I think that means that we could have a reserved region that could be
used by the host for dynamic memory hot-plug-like operation. The
reference to memory hot-plug here is fully intentional, we could even
use this feature of Linux to get struct pages for such memory if we
really wanted.

> Mapping host virtio-gpu resources
> into guest address space is planned, it'll most likely use a pci memory
> bar to reserve some address space.  The host can map resources into that
> pci bar, on guest request.

Sounds like a viable option too. Do you have a pointer to some
description on how this would work on both host and guest side?

>
> >  - virtio-gpu driver could then create a regular DMA-buf object for
> > such memory, because it's just backed by pages (even though they may
> > not be accessible to the guest; just like in the case of TrustZone
> > memory protection on bare metal systems),
>
> Hmm, well, pci memory bars are *not* backed by pages.  Maybe we can use
> Documentation/driver-api/pci/p2pdma.rst though.  With that we might be
> able to lookup buffers using device and dma address, without explicitly
> creating some identifier.  Not investigated yet in detail.

Not backed by pages as in "struct page", but those are still regular
pages of the physical address space. That said, currently the sg_table
interface is only able to describe physical memory using struct page
pointers. It's been a long standing limitation affecting even bare
metal systems, so perhaps it's just the right time to make them
possible to use some other identifiers, like PFNs? There is at least
one more free bit in the page_link field, which could mean that the
field contains a PFN instead of a struct page pointer.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

