Return-Path: <virtio-dev-return-9057-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 509A39862D3
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jan 2022 05:58:05 +0000 (UTC)
MIME-Version: 1.0
References: <20220112055755.41011-1-jasowang@redhat.com> <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain> <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <YeFFr4w+k2ObxgWB@myrica>
In-Reply-To: <YeFFr4w+k2ObxgWB@myrica>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jan 2022 13:57:47 +0800
Message-ID: <CACGkMEs_82HexdCw2G8S_L60s1Cu6seZ6n_sGcEUUNnic4NoYA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14, 2022 at 5:43 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Hi Jason,
>
> On Thu, Jan 13, 2022 at 09:24:16AM +0800, Jason Wang wrote:
> > The device MUST use PASID TLP prefix for all memory transactions
> > initiated by the virtqueue that belong to a virtqueue group ...
> >
> > > vring reads/writes and data buffer reads/writes come
> > > to mind. Virtqueue MSI-X messages are probably not included? Anything
> > > else?
> >
> > According to the PCIe spec and the semantic, the PASID TLP prefix
> > should be used for
> >
> > Memory Requests (including AtomicOp Requests) with Untranslated Address=
es.
> > Address Translation Requests, ATS Invalidation Messages, Page Request
> > Messages, and PRG Response Messages
> >
> > So we probably don't need to differentiate MSI-X messages with DMA
> > here. That's why I think a general "memory transaction" should be
> > sufficient here. If you don't agree, I can clarify it as what PCIe
> > spec did.
>
> I think we should be explicit about this particular case because someone
> implementing this extension might get it wrong. MSIs should not have a
> PASID because IOMMUs don't support it:

Good point, using PASID for MSI may break the assumption of SVA where
the VA is overlapped with the interrupt address range which is similar
to what you mention for SMMU below.

>
> * VT-d treats Requests-with-PASID to the special range 0xfeexxxxx as
>   normal DMA (3.14 Handling Requests to Interrupt Address Range)
> * AMD IOMMU reports an error for MSIs with PASID (2.2.7.7 PCIe=C2=AE TLP =
PASID
>   Prefix).
> * Arm requires creating mappings to the MSI controller in the SMMU. This
>   has implications for SVA where the PASID accesses the whole process
>   address space: if MSI transactions have a PASID prefix, that requires
>   mapping the MSI controller into the process address space on Arm, which
>   isn't convenient.

How about something like:

"
Except for the MSI transactions, the device MUST use PASID TLP prefix
for the following memory transactions initiated by the virtqueue that
belong to a virtqueue group if a valid PASID is assigned and PASID is
enabled in the PASID extended capability:

\begin{itemize}
\item Memory Requests (including AtomicOp Requests) with Untranslated
  Addresses
\item Address Translation Requests
\item Page Request Messages
\end{itemize}

The device MUST NOT use PASID TLP prefix for the MSI memory
transactions.

Thanks

>
> Thanks,
> Jean
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

