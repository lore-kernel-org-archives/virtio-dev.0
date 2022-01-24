Return-Path: <virtio-dev-return-9156-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 283AB98647A
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jan 2022 22:15:42 +0000 (UTC)
Date: Mon, 24 Jan 2022 17:15:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220124170534-mutt-send-email-mst@kernel.org>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <YeFFr4w+k2ObxgWB@myrica>
 <20220119184940-mutt-send-email-mst@kernel.org>
 <Ye7FK6BLPSNLunPv@myrica>
MIME-Version: 1.0
In-Reply-To: <Ye7FK6BLPSNLunPv@myrica>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 24, 2022 at 03:26:35PM +0000, Jean-Philippe Brucker wrote:
> On Wed, Jan 19, 2022 at 06:53:17PM -0500, Michael S. Tsirkin wrote:
> > > I think we should be explicit about this particular case because some=
one
> > > implementing this extension might get it wrong. MSIs should not have =
a
> > > PASID because IOMMUs don't support it:
> > >=20
> > > * VT-d treats Requests-with-PASID to the special range 0xfeexxxxx as
> > >   normal DMA (3.14 Handling Requests to Interrupt Address Range)
> > > * AMD IOMMU reports an error for MSIs with PASID (2.2.7.7 PCIe=AE TLP=
 PASID
> > >   Prefix).
> >=20
> > Ouch. I didn't realize. Really weird, of the "what were they thinking"
> > variety. The natural thing would be to have PASID=3D=3DVM and scope
> > both DMA and MSI within PASID. I guess that is precluded on these
> > platforms then.
> >=20
>=20
> I think the problem is mainly that MSIs appear as normal memory writes
> requests. If PCI had given them a special type, IOMMU/IRQ remapping
> hardware could route them more easily, but as is they only have the
> transaction's address to work with. So vendors made different choices for
> supporting MSIs with their IRQ remapping hardware. Intel and AMD define
> reserved address ranges 0xfeexxxxx, where any memory transaction is
> treated as MSI.
>=20
> This is fine when the kernel is in charge of allocating the I/O address
> space for DMA, it just needs to make sure IOVAs are not allocated within
> the address region reserved for MSIs. But it's more complicated with SVA.
>=20
> One of the use of PASID is assigning a partition of device (here a group
> of virtqueues) to a process. With this approach (SVA) the PASID accesses
> the process' page tables, so the virtual address space is shared between
> CPU and IOMMU, IOVA=3D=3DVA. How would we deal with MSIs in this case, if=
 they
> had a PASID?

Basically what I would do is what ARM has done ;)


>  On x86, if the IOMMU performed IRQ remapping instead of
> address translation, on a memory write with PASID to address 0xfeexxxxx,
> the process couldn't use any address in that range for DMA. The process
> would need to filter addresses returned by malloc() and treat some of the=
m
> as non-DMA'able, which defeats the purpose of SVA. To avoid having to do
> this Intel treats all DMA with PASID as normal memory access, and the
> process can't accidentally trigger MSIs by using the wrong address. I
> think AMD behaves the same way but am not entirely sure - the wording in
> one part of the spec (2.2.7.7) seems to imply that PASID access to the MS=
I
> range would trigger an IOMMU error report, in which case the range would
> need carving out anyway.
>=20
> > > * Arm requires creating mappings to the MSI controller in the SMMU. T=
his
> > >   has implications for SVA where the PASID accesses the whole process
> > >   address space: if MSI transactions have a PASID prefix, that requir=
es
> > >   mapping the MSI controller into the process address space on Arm, w=
hich
> > >   isn't convenient.
> >=20
> > I'd like to understand this part a bit better. Can you explain?
> > We are talking about the IOMMU address space right?
> > What is wrong with mapping the MSI controller there?
> > Isn't convenient in what sense?
>=20
> On Arm the IRQ remapping device is separate from the IOMMU, so there is n=
o
> special address range as far as the IOMMU is concerned. An MSI goes
> through IOMMU address translation like any other memory write, the IOVA
> gets translated into a PA that corresponds to the doorbell (MMIO) address
> of the IRQ remapping device. The IOVA of the MSI is chosen by the OS and
> can have any value. Now if MSIs had a PASID, then the IOMMU would
> translate MSI addresses with the page tables corresponding to that PASID,
> which with SVA correspond to the process page tables. So the kernel would
> need to create a mapping inside the process' address space, to the PA of
> the IRQ remapping device. That's the part that is inconvenient (would not
> be a security issue because accesses to the doorbell from CPUs are ignore=
d
> according to Arm's platform spec, but it would certainly be awkward to se=
t
> up).
>=20
> Thanks,
> Jean

The way I'd do it, is probably by an mmap call. Nothing too tricky about
that. Gives you a VA or it can get a VA with MMAP_FIXED if process
wants to allocate a range. And for a VM, we just naturally use
the regular doorbell address.

In fact, as you describe it it seems that we do have a similar problem
on AMD, we need to preclude VAs in the MSI range somehow. so I guess 2
vendors out of 3 need to carve up the process address range.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

