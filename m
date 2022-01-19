Return-Path: <virtio-dev-return-9144-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE95F9861AD
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jan 2022 23:53:25 +0000 (UTC)
Date: Wed, 19 Jan 2022 18:53:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220119184940-mutt-send-email-mst@kernel.org>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <YeFFr4w+k2ObxgWB@myrica>
MIME-Version: 1.0
In-Reply-To: <YeFFr4w+k2ObxgWB@myrica>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14, 2022 at 09:43:11AM +0000, Jean-Philippe Brucker wrote:
> Hi Jason,
>=20
> On Thu, Jan 13, 2022 at 09:24:16AM +0800, Jason Wang wrote:
> > The device MUST use PASID TLP prefix for all memory transactions
> > initiated by the virtqueue that belong to a virtqueue group ...
> >=20
> > > vring reads/writes and data buffer reads/writes come
> > > to mind. Virtqueue MSI-X messages are probably not included? Anything
> > > else?
> >=20
> > According to the PCIe spec and the semantic, the PASID TLP prefix
> > should be used for
> >=20
> > Memory Requests (including AtomicOp Requests) with Untranslated Address=
es.
> > Address Translation Requests, ATS Invalidation Messages, Page Request
> > Messages, and PRG Response Messages
> >=20
> > So we probably don't need to differentiate MSI-X messages with DMA
> > here. That's why I think a general "memory transaction" should be
> > sufficient here. If you don't agree, I can clarify it as what PCIe
> > spec did.
>=20
> I think we should be explicit about this particular case because someone
> implementing this extension might get it wrong. MSIs should not have a
> PASID because IOMMUs don't support it:
>=20
> * VT-d treats Requests-with-PASID to the special range 0xfeexxxxx as
>   normal DMA (3.14 Handling Requests to Interrupt Address Range)
> * AMD IOMMU reports an error for MSIs with PASID (2.2.7.7 PCIe=AE TLP PAS=
ID
>   Prefix).

Ouch. I didn't realize. Really weird, of the "what were they thinking"
variety. The natural thing would be to have PASID=3D=3DVM and scope
both DMA and MSI within PASID. I guess that is precluded on these
platforms then.

> * Arm requires creating mappings to the MSI controller in the SMMU. This
>   has implications for SVA where the PASID accesses the whole process
>   address space: if MSI transactions have a PASID prefix, that requires
>   mapping the MSI controller into the process address space on Arm, which
>   isn't convenient.

I'd like to understand this part a bit better. Can you explain?
We are talking about the IOMMU address space right?
What is wrong with mapping the MSI controller there?
Isn't convenient in what sense?

>=20
> Thanks,
> Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

