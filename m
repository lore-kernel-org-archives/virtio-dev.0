Return-Path: virtio-dev-return-2539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D957B1CB8078
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2017 20:47:54 -0700 (PDT)
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Wed, 13 Sep 2017 03:47:50 +0000
Message-ID: <AM5PR0401MB25455D83B3C3361FEC0464F29A6E0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <072f5a14-baae-57a9-9c5b-b93163c67075@redhat.com>
In-Reply-To: <072f5a14-baae-57a9-9c5b-b93163c67075@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [RFC] virtio-iommu version 0.4
To: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Tuesday, September 12, 2017 10:43 PM
> To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>;
> iommu@lists.linux-foundation.org; kvm@vger.kernel.org;
> virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.or=
g
> Cc: will.deacon@arm.com; robin.murphy@arm.com;
> lorenzo.pieralisi@arm.com; mst@redhat.com; jasowang@redhat.com;
> marc.zyngier@arm.com; eric.auger.pro@gmail.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>; peterx@redhat.com; kevin.tian@intel.com
> Subject: Re: [RFC] virtio-iommu version 0.4
>=20
> Hi jean,
>=20
> On 04/08/2017 20:19, Jean-Philippe Brucker wrote:
> > This is the continuation of my proposal for virtio-iommu, the para-
> > virtualized IOMMU. Here is a summary of the changes since last time [1]=
:
> >
> > * The virtio-iommu document now resembles an actual specification. It i=
s
> >   split into a formal description of the virtio device, and implementat=
ion
> >   notes. Please find sources and binaries at [2].
> >
> > * Added a probe request to describe to the guest different properties t=
hat
> >   do not fit in firmware or in the virtio config space. This is a
> >   necessary stepping stone for extending the virtio-iommu.
> >
> > * There is a working Qemu prototype [3], thanks to Eric Auger and Bhara=
t
> >   Bhushan.
> >
> > You can find the Linux driver and kvmtool device at [4] and [5]. I
> > plan to rework driver and kvmtool device slightly before sending the
> > patches.
> >
> > To understand the virtio-iommu, I advise to first read introduction
> > and motivation, then skim through implementation notes and finally
> > look at the device specification.
> >
> > I wasn't sure how to organize the review. For those who prefer to
> > comment inline, I attached v0.4 of device-operations.tex and
> > topology.tex+MSI.tex to this thread. They are the biggest chunks of
> > the document. But LaTeX isn't very pleasant to read, so you can simply
> > send a list of comments in relation to section numbers and a few words =
of
> context, we'll manage.
> >
> > ---
> > Version numbers 0.1-0.4 are arbitrary. I'm hoping they allow to
> > compare more easily differences since the RFC (see [6]), but haven't
> > been made public so far. This is the first public posting since
> > initial proposal [1], and the following describes all changes.
> >
> > ## v0.1 ##
> >
> > Content is the same as the RFC, but formatted to LaTeX. 'make'
> > generates one PDF and one HTML document.
> >
> > ## v0.2 ##
> >
> > Add introductions, improve topology example and firmware description
> > based on feedback and a number of useful discussions.
> >
> > ## v0.3 ##
> >
> > Add normative sections (MUST, SHOULD, etc). Clarify some things,
> > tighten the device and driver behaviour. Unmap semantics are
> > consolidated; they are now closer to VFIO Type1 v2 semantics.
> >
> > ## v0.4 ##
> >
> > Introduce PROBE requests. They provide per-endpoint information to the
> > driver that couldn't be described otherwise.
> >
> > For the moment, they allow to handle MSIs on x86 virtual platforms
> > (see 3.2). To do that we communicate reserved IOVA regions, that will
> > also be useful for describing regions that cannot be mapped for a
> > given endpoint, for instance addresses that correspond to a PCI bridge
> window.
> >
> > Introducing such a large framework for this tiny feature may seem
> > overkill, but it is needed for future extensions of the virtio-iommu
> > and I believe it really is worth the effort.
>=20
> 2.6.7
> - As I am currently integrating v0.4 in QEMU here are some other comments=
:
> At the moment struct virtio_iommu_req_probe flags is missing in your
> header. As such I understood the ACK protocol was not implemented by the
> driver in your branch.
> - VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK is
> VIRTIO_IOMMU_T_MASK in your header too.
> 2.6.8.2:
> - I am really confused about what the device should report as resv region=
s
> depending on the PE nature (VFIO or not VFIO)
>=20
> In other iommu drivers, the resv regions are populated by the iommu drive=
r
> through its get_resv_regions callback. They are usually composed of an
> iommu specific MSI region (mapped or bypassed) and non IOMMU specific
> (device specific) reserved regions:
> iommu_dma_get_resv_regions(). In the case of virtio-iommu driver, those
> are the guest reserved regions.
>=20
> First in the current virtio-iommu driver I don't see the
> iommu_dma_get_resv_regions call. Do you agree that the virtio-iommu
> driver should compute the non IOMMU specific MSI regions. ie. this is not
> the responsability of the virtio-iommu device.
>=20
> Then why is it more the job of the device to return the guest iommu speci=
fic
> region rather than the driver itself?
>=20
> Then I understand this is the responsability of the virtio-iommu device t=
o
> gather information about the host resv regions in case of VFIO EP.
> Typically the host PCIe host bridge windows cannot be used for IOVA.
> Also the host MSI reserved IOVA window cannot be used. Do you agree.
>=20
> I really think the spec should clarify what exact resv regions the device=
 should
> return in case of VFIO device and non VFIO device.

My understanding is that reserved regions are 1) Host reserved regions ( Th=
is is applicable for VFIO) 2) Guest MSI reserved region (This is applicable=
 for emulated devices as well)
Does this make sense to have reserved regions per address-space/domain?

Thanks
-Bharat

>=20
> Thanks
>=20
> Eric
>=20
> >
> > ## Future ##
> >
> > Other extensions are in preparation. I won't detail them here because
> > v0.4 already is a lot to digest, but in short, building on top of PROBE=
:
> >
> > * First, since the IOMMU is paravirtualized, the device can expose some
> >   properties of the physical topology to the guest, and let it allocate
> >   resources more efficiently. For example, when the virtio-iommu manage=
s
> >   both physical and emulated endpoints, with different underlying
> IOMMUs,
> >   we now have a way to describe multiple page and block granularities,
> >   instead of forcing the guest to use the most restricted one for all
> >   endpoints. This will most likely be in v0.5.
> >
> > * Then on top of that, a major improvement will describe hardware
> >   acceleration features available to the guest. There is what I call "P=
age
> >   Table Handover" (or simply, from the host POV, "Nested"), the ability
> >   for the guest to manipulate its own page tables instead of sending
> >   MAP/UNMAP requests to the host. This, along with IO Page Fault
> >   reporting, will also permit SVM virtualization on different platforms=
.
> >
> > Thanks,
> > Jean
> >
> > [1] http://www.spinics.net/lists/kvm/msg147990.html
> > [2] git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
> >     http://www.linux-arm.org/git?p=3Dvirtio-
> iommu.git;a=3Dblob;f=3Ddist/v0.4/virtio-iommu-v0.4.pdf
> >     I reiterate the disclaimers: don't use this document as a reference=
,
> >     it's a draft. It's also not an OASIS document yet. It may be riddle=
d
> >     with mistakes. As this is a working draft, it is unstable and I do =
not
> >     guarantee backward compatibility of future versions.
> > [3] https://lists.gnu.org/archive/html/qemu-arm/2017-08/msg00004.html
> > [4] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.4
> >     Warning: UAPI headers have changed! They didn't follow the spec,
> >     please update. (Use branch v0.1, that has the old headers, for the
> >     Qemu prototype [3])
> > [5] git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.4
> >     Warning: command-line has changed! Use --viommu vfio[,opts] and
> >     --viommu virtio[,opts] to instantiate a device.
> > [6]
> > http://www.linux-arm.org/git?p=3Dvirtio-iommu.git;a=3Dtree;f=3Ddist/dif=
fs
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

