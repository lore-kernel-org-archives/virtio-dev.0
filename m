Return-Path: virtio-dev-return-5479-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 207049860B9
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 07:30:05 +0000 (UTC)
Date: Thu, 21 Feb 2019 08:29:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221072950.tcii5np5dsk4wvyd@sirius.home.kraxel.org>
References: <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org>
 <CAEkmjvVA_pxL7FyR4p+u5LH4JfBNOFgAJf-B3573OM58pAD7+A@mail.gmail.com>
 <20190220070213.3uetjgzzlf5qojan@sirius.home.kraxel.org>
 <CAEkmjvWEBfd1=JCkavhwdtEUSiP-Vy+RfLcLQLgaRXS+dN9PYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvWEBfd1=JCkavhwdtEUSiP-Vy+RfLcLQLgaRXS+dN9PYw@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > For communication between guest processes within the same VM I don't
> > really see a need to involve the hypervisor ...
> >
> Right, once the host memory is set up we can rely on purely guest side stuff
> map sub-regions of it.

Or just use guest ram ...

> > > Yes, also, other devices of the same VM.
> >
> > So why involve the hypervisor here?  The guest can handle that on its
> > own.  Passing an image data buffer from the usb webcam to the intel gpu
> > for display (on bare metal) isn't fundamentally different from passing a
> > buffer from virtio-camera to virtio-gpu (in a VM).  Linux guests will
> > use dma-bufs for that, other OSes probably something else.
> 
> That's true that it can be handled purely in the guest layers,
> if there is an existing interface in the guest
> to pass the proposed host memory id's / offsets / sizes
> between them.

Note:  I think using a pci memory bar (aka host memory mapped into the
guest) as backing storage for dma-bufs isn't going to work.

> However, for the proposed host memory sharing spec,
> would there be a standard way to share the host memory across
> different virtio devices without relying on Linux dmabufs?

I think with the current draft for each device (virtio-fs, virtio-gpu,
...) has its own device-specific memory, and there is no mechanism to
exchange buffers between devices.

Stefan?

I'm also not convinced that explicitly avoiding dmabufs is a good idea
here.  That would put virtio into its own universe and sharing buffers
with non-virtio devices will not work.  Think about a intel vgpu as
display device, or a usb camera attached to the guest using usb
pass-through.

Experience shows that using virtualization-specific features /
optimizations / short-cuts often turns out to have drawbacks in the long
run, even if it looked like a good idea initially.  Just look at the
mess we had with virtio-pci dma after iommu emulation landed in qemu.
And this is only one example, we have more of this ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

