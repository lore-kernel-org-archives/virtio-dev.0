Return-Path: virtio-dev-return-6250-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04994986005
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 08:24:06 +0000 (UTC)
MIME-Version: 1.0
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <20190923085637.bsaevedklweijgya@sirius.home.kraxel.org> <CAAFQd5Ba-REZU9=rdm3J6NRqqeAUFdCV7SJ_WdO2BHyKNBN7TQ@mail.gmail.com>
 <20191014121914.lyptm3gdmekvcu6v@sirius.home.kraxel.org> <CAAFQd5CaxYoXQ6z4pmdTG3FDN8ccEk3sHMnSkoNwL2==hk6znQ@mail.gmail.com>
 <20191017074416.wrndxdwntynqmpm4@sirius.home.kraxel.org>
In-Reply-To: <20191017074416.wrndxdwntynqmpm4@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 17 Oct 2019 17:23:49 +0900
Message-ID: <CAAFQd5Dh-VE2v=uX1bqKywwELxrH1a9wsRAine2=AVe3gQFt4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 17, 2019 at 4:44 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Also note that the guest manages the address space, so the host can't
> > > simply allocate guest page addresses.
> >
> > Is this really true? I'm not an expert in this area, but on a bare
> > metal system it's the hardware or firmware that sets up the various
> > physical address allocations on a hardware level and most of the time
> > most of the addresses are already pre-assigned in hardware (like the
> > DRAM base, various IOMEM spaces, etc.).
>
> Yes, the firmware does it.  Same in a VM, ovmf or seabios (which runs
> inside the guest) typically does it.  And sometimes the linux kernel
> too.
>
> > I think that means that we could have a reserved region that could be
> > used by the host for dynamic memory hot-plug-like operation. The
> > reference to memory hot-plug here is fully intentional, we could even
> > use this feature of Linux to get struct pages for such memory if we
> > really wanted.
>
> We try to avoid such quirks whenever possible.  Negotiating such things
> between qemu and firmware can be done if really needed (and actually is
> done for memory hotplug support), but it's an extra interface which
> needs maintenance.
>
> > > Mapping host virtio-gpu resources
> > > into guest address space is planned, it'll most likely use a pci memory
> > > bar to reserve some address space.  The host can map resources into that
> > > pci bar, on guest request.
> >
> > Sounds like a viable option too. Do you have a pointer to some
> > description on how this would work on both host and guest side?
>
> Some early code:
>   https://git.kraxel.org/cgit/qemu/log/?h=sirius/virtio-gpu-memory-v2
>   https://git.kraxel.org/cgit/linux/log/?h=drm-virtio-memory-v2
>
> Branches have other stuff too, look for "hostmem" commits.
>
> Not much code yet beyond creating a pci bar on the host and detecting
> presence in the guest.
>
> On the host side qemu would create subregions inside the hostmem memory
> region for the resources.
>
> Oh the guest side we can ioremap stuff, like vram.
>
> > > Hmm, well, pci memory bars are *not* backed by pages.  Maybe we can use
> > > Documentation/driver-api/pci/p2pdma.rst though.  With that we might be
> > > able to lookup buffers using device and dma address, without explicitly
> > > creating some identifier.  Not investigated yet in detail.
> >
> > Not backed by pages as in "struct page", but those are still regular
> > pages of the physical address space.
>
> Well, maybe not.  Host gem object could live in device memory, and if we
> map them into the guest ...

That's an interesting scenario, but in that case would we still want
to map it into the guest? I think in such case may need to have some
shadow buffer in regular RAM and that's already implemented in
virtio-gpu.

>
> > That said, currently the sg_table interface is only able to describe
> > physical memory using struct page pointers.  It's been a long standing
> > limitation affecting even bare metal systems, so perhaps it's just the
> > right time to make them possible to use some other identifiers, like
> > PFNs?
>
> I doubt you can handle pci memory bars like regular ram when it comes to
> dma and iommu support.  There is a reason we have p2pdma in the first
> place ...

The thing is that such bars would be actually backed by regular host
RAM. Do we really need the complexity of real PCI bar handling for
that?

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

