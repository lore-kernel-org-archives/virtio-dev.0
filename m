Return-Path: <jean-philippe@linaro.org>
Date: Wed, 13 Oct 2021 12:10:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [virtio-dev] [PATCH v2] virtio-iommu: Rework the bypass feature
Message-ID: <YWa+qK32mogp1iWd@myrica>
References: <20211011150916.38120-1-jean-philippe@linaro.org>
 <BN9PR11MB5433D2DC0C4959183142A42E8CB79@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433D2DC0C4959183142A42E8CB79@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 13, 2021 at 08:37:51AM +0000, Tian, Kevin wrote:
> > * The ability for an hypervisor to start the device in bypass mode. The
> >   wording for VIRTIO_IOMMU_F_BYPASS is not clear enough to allow it at
> >   the moment.
> 
> unclear because it's worded around driver negotiation thus the behavior
> is undefined before the driver is loaded?

Yes exactly. The spec doesn't spell out what the behavior is before
feature negotiation, even though the straightforward interpretation is
that DMA doesn't bypass (which prevents an hypervisor from implementing
boot-bypass at the moment).


> > 
> > * The ability for a guest to set individual endpoints in bypass mode
> >   when bypass is globally disabled. An OS should have the ability to
> >   allow only endpoints it trusts to bypass the IOMMU, while keeping DMA
> >   disabled for endpoints it isn't even aware of. At the moment this can
> >   only be emulated by creating identity mappings.
> 
> Is driver required to first disable global bypass before it can attach
> endpoints to normal domains?

No

> 
> > 
> > The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a 'bypass' config field
> > that allows to enable and disable bypass globally. It also adds a new
> > flag for the ATTACH request.
> > 
> > * The hypervisor can start the VM with bypass enabled or, if it knows
> >   that the software stack supports it, disabled. The 'bypass' config
> >   fields resets to 0 or 1.
> 
> is sticky and unchanged by reset
> 
> > 
> > * Generally the firmware won't have an IOMMU driver and will need to be
> >   started in bypass mode, so the bootloader and kernel can be loaded
> >   from storage endpoint.
> 
> How does the firmware know whether storage load is allowed w/o looking
> at the bypass info in virtio-iommu? 

Either the firmware can't drive virtio-iommu, and must be booted in
bypass, or it can and then it sets/clears bypass. That's why we're going
to default qemu to boot-bypass [1], because in general the firmware won't
support anything else. An admin that has more knowledge in the software
stack, and knows that the firmware is able to drive the IOMMU, can then
disable boot-bypass for more security.

[1] https://lore.kernel.org/qemu-devel/20210930185050.262759-1-jean-philippe@linaro.org/

> 
> > 
> >   For more security, the firmware could implement a minimal virtio-iommu
> >   driver that reuses existing virtio support and only touches the config
> >   space. It could enable PCI bus mastering in bridges only for the
> >   endpoints that need it, enable global IOMMU bypass by flipping a bit,
> 
> then untrusted devices can do DMA after global bypass is enabled?

Not necessarily, I think firmware could configure PCI switch ports
upstream of untrusted devices, by keeping Bus Master Enable disabled in
their config space which will block Memory and I/O Requests.

> suppose
> here just needs attach storage device to a normal domain, leaving other
> devices still blocked from doing DMA

Yes that's the safest route, but also more complicated to implement.
If firmware can setup the PCI topology as above, its virtio-iommu driver
just needs to poke the config space for feature negotiation and enabling
bypass, no need to setup virtqueues.

> 
> >   then tear everything down before handing control over to the OS. This
> >   prevents vulnerability windows where a malicious endpoint reprograms
> >   the IOMMU while the OS is configuring it [1].

[...]
> > +An endpoint is in bypass mode if:
> > +\begin{itemize}
> > +  \item the VIRTIO_IOMMU_F_BYPASS_CONFIG feature is offered and:
> > +    \begin{itemize}
> > +      \item config field \field{bypass} is 1 and the endpoint is not
> > +        attached to a domain, or
> > +      \item the endpoint is attached to a domain with
> > +        VIRTIO_IOMMU_ATTACH_F_BYPASS.
> 
> should we mention that BYPASS_CONFIG effect doesn't depend on
> negotiation?

That's the distinction between "offered" vs "negotiated", but I can say it
explicitly


[...]
> >  Detach an endpoint from a domain. When this request completes, the
> > -endpoint cannot access any mapping from that domain anymore. If feature
> > -VIRTIO_IOMMU_F_BYPASS has been negotiated, then once this request
> > -completes all accesses from the endpoint are allowed and translated by the
> > -IOMMU using the identity function.
> > +endpoint cannot access any mapping from that domain anymore.
> 
> Related to my earlier question, what about global bypass is enabled? If
> domain attach is allowed in that configuration, then above statement
> is not accurate.

The statement only refers to domain mappings, so when global bypass is
enabled, after detach the endpoint can access everything. Eric also
commented on this, I could add:

	However the endpoint may then be in bypass mode and access the
	guest-physical address space.

So the reader can refer to the definition of bypass mode and see what
happens to unattached endpoints.

Thanks,
Jean

