Return-Path: <virtio-dev-return-9153-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 845D198642F
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jan 2022 15:27:00 +0000 (UTC)
Date: Mon, 24 Jan 2022 15:26:35 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <Ye7FK6BLPSNLunPv@myrica>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <YeFFr4w+k2ObxgWB@myrica>
 <20220119184940-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220119184940-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 06:53:17PM -0500, Michael S. Tsirkin wrote:
> > I think we should be explicit about this particular case because someon=
e
> > implementing this extension might get it wrong. MSIs should not have a
> > PASID because IOMMUs don't support it:
> >=20
> > * VT-d treats Requests-with-PASID to the special range 0xfeexxxxx as
> >   normal DMA (3.14 Handling Requests to Interrupt Address Range)
> > * AMD IOMMU reports an error for MSIs with PASID (2.2.7.7 PCIe=C2=AE TL=
P PASID
> >   Prefix).
>=20
> Ouch. I didn't realize. Really weird, of the "what were they thinking"
> variety. The natural thing would be to have PASID=3D=3DVM and scope
> both DMA and MSI within PASID. I guess that is precluded on these
> platforms then.
>=20

I think the problem is mainly that MSIs appear as normal memory writes
requests. If PCI had given them a special type, IOMMU/IRQ remapping
hardware could route them more easily, but as is they only have the
transaction's address to work with. So vendors made different choices for
supporting MSIs with their IRQ remapping hardware. Intel and AMD define
reserved address ranges 0xfeexxxxx, where any memory transaction is
treated as MSI.

This is fine when the kernel is in charge of allocating the I/O address
space for DMA, it just needs to make sure IOVAs are not allocated within
the address region reserved for MSIs. But it's more complicated with SVA.

One of the use of PASID is assigning a partition of device (here a group
of virtqueues) to a process. With this approach (SVA) the PASID accesses
the process' page tables, so the virtual address space is shared between
CPU and IOMMU, IOVA=3D=3DVA. How would we deal with MSIs in this case, if t=
hey
had a PASID?  On x86, if the IOMMU performed IRQ remapping instead of
address translation, on a memory write with PASID to address 0xfeexxxxx,
the process couldn't use any address in that range for DMA. The process
would need to filter addresses returned by malloc() and treat some of them
as non-DMA'able, which defeats the purpose of SVA. To avoid having to do
this Intel treats all DMA with PASID as normal memory access, and the
process can't accidentally trigger MSIs by using the wrong address. I
think AMD behaves the same way but am not entirely sure - the wording in
one part of the spec (2.2.7.7) seems to imply that PASID access to the MSI
range would trigger an IOMMU error report, in which case the range would
need carving out anyway.

> > * Arm requires creating mappings to the MSI controller in the SMMU. Thi=
s
> >   has implications for SVA where the PASID accesses the whole process
> >   address space: if MSI transactions have a PASID prefix, that requires
> >   mapping the MSI controller into the process address space on Arm, whi=
ch
> >   isn't convenient.
>=20
> I'd like to understand this part a bit better. Can you explain?
> We are talking about the IOMMU address space right?
> What is wrong with mapping the MSI controller there?
> Isn't convenient in what sense?

On Arm the IRQ remapping device is separate from the IOMMU, so there is no
special address range as far as the IOMMU is concerned. An MSI goes
through IOMMU address translation like any other memory write, the IOVA
gets translated into a PA that corresponds to the doorbell (MMIO) address
of the IRQ remapping device. The IOVA of the MSI is chosen by the OS and
can have any value. Now if MSIs had a PASID, then the IOMMU would
translate MSI addresses with the page tables corresponding to that PASID,
which with SVA correspond to the process page tables. So the kernel would
need to create a mapping inside the process' address space, to the PA of
the IRQ remapping device. That's the part that is inconvenient (would not
be a security issue because accesses to the doorbell from CPUs are ignored
according to Arm's platform spec, but it would certainly be awkward to set
up).

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

