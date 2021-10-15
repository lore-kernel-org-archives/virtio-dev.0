Return-Path: <jean-philippe@linaro.org>
Date: Fri, 15 Oct 2021 12:07:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [virtio-dev] [PATCH v2] virtio-iommu: Rework the bypass feature
Message-ID: <YWlg8yaeVTjZpvYT@myrica>
References: <20211011150916.38120-1-jean-philippe@linaro.org>
 <BN9PR11MB5433D2DC0C4959183142A42E8CB79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YWa+qK32mogp1iWd@myrica>
 <BN9PR11MB543342D98352576A35B433D08CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB543342D98352576A35B433D08CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 14, 2021 at 02:05:30AM +0000, Tian, Kevin wrote:
> > > >   For more security, the firmware could implement a minimal virtio-
> > iommu
> > > >   driver that reuses existing virtio support and only touches the config
> > > >   space. It could enable PCI bus mastering in bridges only for the
> > > >   endpoints that need it, enable global IOMMU bypass by flipping a bit,
> > >
> > > then untrusted devices can do DMA after global bypass is enabled?
> > 
> > Not necessarily, I think firmware could configure PCI switch ports
> > upstream of untrusted devices, by keeping Bus Master Enable disabled in
> > their config space which will block Memory and I/O Requests.
> 
> guest firmware only manages virtual switch ports. Physically they are
> supposed to be already enabled in the process of device passthrough. 

Right I was considering virtual devices and virtual switches. For physical
devices, the switch emulation would need to disable the IOMMU mappings
when bus mastering is disabled in the switch. In either case, though, it's
probably more complexity than hypervisors are willing to put in. QEMU
seems to ignore Bus Master Enable on root ports, for example.

> Given a device is untrusted, it may ignore Bus Master Enable bit 
> inadvertently or deliberately to issue DMA. I feel concept-wise it's
> not good for the firmware to open this window when boot-bypass is
> disabled...
> 
> > 
> > > suppose
> > > here just needs attach storage device to a normal domain, leaving other
> > > devices still blocked from doing DMA
> > 
> > Yes that's the safest route, but also more complicated to implement.
> > If firmware can setup the PCI topology as above, its virtio-iommu driver
> > just needs to poke the config space for feature negotiation and enabling
> > bypass, no need to setup virtqueues.
> 
> I see the value of this simplified approach. But if it cannot isolate 
> untrusted devices then we may have to follow the complicated route

Agreed

Thanks,
Jean

