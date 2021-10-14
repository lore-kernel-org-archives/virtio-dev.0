Return-Path: <kevin.tian@intel.com>
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [virtio-dev] [PATCH v2] virtio-iommu: Rework the bypass feature
Date: Thu, 14 Oct 2021 02:05:30 +0000
Message-ID: <BN9PR11MB543342D98352576A35B433D08CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211011150916.38120-1-jean-philippe@linaro.org>
 <BN9PR11MB5433D2DC0C4959183142A42E8CB79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YWa+qK32mogp1iWd@myrica>
In-Reply-To: <YWa+qK32mogp1iWd@myrica>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, October 13, 2021 7:11 PM
>=20
> >
> > >
> > > * Generally the firmware won't have an IOMMU driver and will need to
> be
> > >   started in bypass mode, so the bootloader and kernel can be loaded
> > >   from storage endpoint.
> >
> > How does the firmware know whether storage load is allowed w/o looking
> > at the bypass info in virtio-iommu?
>=20
> Either the firmware can't drive virtio-iommu, and must be booted in
> bypass, or it can and then it sets/clears bypass. That's why we're going
> to default qemu to boot-bypass [1], because in general the firmware won't
> support anything else. An admin that has more knowledge in the software
> stack, and knows that the firmware is able to drive the IOMMU, can then
> disable boot-bypass for more security.
>=20
> [1] https://lore.kernel.org/qemu-devel/20210930185050.262759-1-jean-
> philippe@linaro.org/

ok. Earlier I was thinking how the firmware w/o IOMMU driver knows=20
the fact when boot-bypass is disabled inadvertently and then directly=20
throws out warning to the user. But looks this is an egg-chicken problem.
possibly the user will have to do some diagnostic upon such condition
to figure out the reason.

>=20
> >
> > >
> > >   For more security, the firmware could implement a minimal virtio-
> iommu
> > >   driver that reuses existing virtio support and only touches the con=
fig
> > >   space. It could enable PCI bus mastering in bridges only for the
> > >   endpoints that need it, enable global IOMMU bypass by flipping a bi=
t,
> >
> > then untrusted devices can do DMA after global bypass is enabled?
>=20
> Not necessarily, I think firmware could configure PCI switch ports
> upstream of untrusted devices, by keeping Bus Master Enable disabled in
> their config space which will block Memory and I/O Requests.

guest firmware only manages virtual switch ports. Physically they are
supposed to be already enabled in the process of device passthrough.=20
Given a device is untrusted, it may ignore Bus Master Enable bit=20
inadvertently or deliberately to issue DMA. I feel concept-wise it's
not good for the firmware to open this window when boot-bypass is
disabled...

>=20
> > suppose
> > here just needs attach storage device to a normal domain, leaving other
> > devices still blocked from doing DMA
>=20
> Yes that's the safest route, but also more complicated to implement.
> If firmware can setup the PCI topology as above, its virtio-iommu driver
> just needs to poke the config space for feature negotiation and enabling
> bypass, no need to setup virtqueues.

I see the value of this simplified approach. But if it cannot isolate=20
untrusted devices then we may have to follow the complicated route

>=20
>=20
> [...]
> > >  Detach an endpoint from a domain. When this request completes, the
> > > -endpoint cannot access any mapping from that domain anymore. If
> feature
> > > -VIRTIO_IOMMU_F_BYPASS has been negotiated, then once this request
> > > -completes all accesses from the endpoint are allowed and translated =
by
> the
> > > -IOMMU using the identity function.
> > > +endpoint cannot access any mapping from that domain anymore.
> >
> > Related to my earlier question, what about global bypass is enabled? If
> > domain attach is allowed in that configuration, then above statement
> > is not accurate.
>=20
> The statement only refers to domain mappings, so when global bypass is
> enabled, after detach the endpoint can access everything. Eric also
> commented on this, I could add:
>=20
> =09However the endpoint may then be in bypass mode and access the
> =09guest-physical address space.
>=20
> So the reader can refer to the definition of bypass mode and see what
> happens to unattached endpoints.
>=20

sounds good.

Thanks
Kevin

