Return-Path: <virtio-dev-return-9045-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22657986507
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 09:43:37 +0000 (UTC)
Date: Fri, 14 Jan 2022 09:43:11 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <YeFFr4w+k2ObxgWB@myrica>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jason,

On Thu, Jan 13, 2022 at 09:24:16AM +0800, Jason Wang wrote:
> The device MUST use PASID TLP prefix for all memory transactions
> initiated by the virtqueue that belong to a virtqueue group ...
>=20
> > vring reads/writes and data buffer reads/writes come
> > to mind. Virtqueue MSI-X messages are probably not included? Anything
> > else?
>=20
> According to the PCIe spec and the semantic, the PASID TLP prefix
> should be used for
>=20
> Memory Requests (including AtomicOp Requests) with Untranslated Addresses=
.
> Address Translation Requests, ATS Invalidation Messages, Page Request
> Messages, and PRG Response Messages
>=20
> So we probably don't need to differentiate MSI-X messages with DMA
> here. That's why I think a general "memory transaction" should be
> sufficient here. If you don't agree, I can clarify it as what PCIe
> spec did.

I think we should be explicit about this particular case because someone
implementing this extension might get it wrong. MSIs should not have a
PASID because IOMMUs don't support it:

* VT-d treats Requests-with-PASID to the special range 0xfeexxxxx as
  normal DMA (3.14 Handling Requests to Interrupt Address Range)
* AMD IOMMU reports an error for MSIs with PASID (2.2.7.7 PCIe=C2=AE TLP PA=
SID
  Prefix).
* Arm requires creating mappings to the MSI controller in the SMMU. This
  has implications for SVA where the PASID accesses the whole process
  address space: if MSI transactions have a PASID prefix, that requires
  mapping the MSI controller into the process address space on Arm, which
  isn't convenient.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

