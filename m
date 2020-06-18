Return-Path: virtio-dev-return-7482-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79096985F02
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 15:29:16 +0000 (UTC)
Date: Thu, 18 Jun 2020 11:29:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200618112833-mutt-send-email-mst@kernel.org>
References: <87a7194kgt.fsf@linaro.org>
 <28614897-bfb7-b36c-6698-6c6942a87399@siemens.com>
 <20200618132958.GB2013520@stefanha-x1.localdomain>
 <2fe9e849-a93d-e3b0-30b9-0d7bef723813@siemens.com>
 <20200618105104-mutt-send-email-mst@kernel.org>
 <87cb818e-f9a5-67ff-8b78-94568e8b4e66@siemens.com>
 <20200618110218-mutt-send-email-mst@kernel.org>
 <91f501fc-b31c-f0e4-3f4d-b6f6d0181780@siemens.com>
MIME-Version: 1.0
In-Reply-To: <91f501fc-b31c-f0e4-3f4d-b6f6d0181780@siemens.com>
Subject: Re: [virtio-dev] Re: Constraining where a guest may allocate virtio
 accessible resources
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Azzedine Touzni <atouzni@qti.qualcomm.com>, =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Soni, Trilok" <tsoni@quicinc.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 18, 2020 at 05:22:40PM +0200, Jan Kiszka wrote:
> On 18.06.20 17:05, Michael S. Tsirkin wrote:
> > On Thu, Jun 18, 2020 at 04:58:40PM +0200, Jan Kiszka wrote:
> >>>>>>> Option 5 - Additional Device
> >>>>>>> ============================
> >>>>>>>
> >>>>>>> The final approach would be to tie the allocation of virtqueues to
> >>>>>>> memory regions as defined by additional devices. For example the
> >>>>>>> proposed IVSHMEMv2 spec offers the ability for the hypervisor to present
> >>>>>>> a fixed non-mappable region of the address space. Other proposals like
> >>>>>>> virtio-mem allow for hot plugging of "physical" memory into the guest
> >>>>>>> (conveniently treatable as separate shareable memory objects for QEMU
> >>>>>>> ;-).
> >>>>>>>
> >>>>>>
> >>>>>> I think you forgot one approach: virtual IOMMU. That is the advanced
> >>>>>> form of the grant table approach. The backend still "sees" the full
> >>>>>> address space of the frontend, but it will not be able to access all of
> >>>>>> it and there might even be a translation going on. Well, like IOMMUs work.
> >>>>>>
> >>>>>> However, this implies dynamics that are under guest control, namely of
> >>>>>> the frontend guest. And such dynamics can be counterproductive for
> >>>>>> certain scenarios. That's where this static windows of shared memory
> >>>>>> came up.
> >>>>>
> >>>>> Yes, I think IOMMU interfaces are worth investigating more too. IOMMUs
> >>>>> are now widely implemented in Linux and virtualization software. That
> >>>>> means guest modifications aren't necessary and unmodified guest
> >>>>> applications will run.
> >>>>>
> >>>>> Applications that need the best performance can use a static mapping
> >>>>> while applications that want the strongest isolation can map/unmap DMA
> >>>>> buffers dynamically.
> >>>>
> >>>> I do not see yet that you can model with an IOMMU a static, not guest
> >>>> controlled window.
> >>>
> >>> Well basically the IOMMU will have as part of the
> >>> topology description and range of addresses devices behind it
> >>> are allowed to access. What's the problem with that?
> >>>
> >>
> >> I didn't look at the detail of the vIOMMU from that perspective, but our
> >> requirement would be that it would just statically communicate to the
> >> guest where DMA windows are, rather than allowing the guest to configure
> >> that (which is the normal usage of an IOMMU).
> > 
> > Right, I got that - IOMMUs aren't necessarily fully configurable though.
> > E.g. some IOMMUs are restricted in the # of bits they can address.
> > 
> > 
> >> In addition, it would only address the memory transfer topic. We would
> >> still be left with the current issue of virtio that the hypervisor's
> >> device model needs to understand all supported device types.
> >>
> >> Jan
> > 
> > I'd expect the DMA API would try to paper over that likely using
> > bounce buffering. If you want to avoid copies, that's a harder
> > problem generally.
> > 
> 
> Here I was referring to the permutations of the control path in a device
> model when switching from, say, a storage to a network virtio device.
> With PCI and MMIO (didn't check Channel I/O, but that's not portable
> anyway), you need to patch the "first-level" hypervisor when you want to
> add a brand-new virtio-sound device and the hypervisor is not yet aware
> of it. For minimized setups, I would prefer to only reconfigure it and
> just add a new backend service app or VM. Naturally, that model also
> shrinks the logic the core hypervisor needs to provide for virtio.
> 
> Jan

Hmm that went woosh over my head a bit, sorry.
If it's important for this discussion, a diagram might help.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

