Return-Path: <virtio-dev-return-9025-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B4FA9862D3
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 01:28:34 +0000 (UTC)
MIME-Version: 1.0
References: <20220112055755.41011-1-jasowang@redhat.com> <Yd6xAbl9TGjU72Ng@stefanha-x1.localdomain>
In-Reply-To: <Yd6xAbl9TGjU72Ng@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jan 2022 09:28:19 +0800
Message-ID: <CACGkMEsSVPnZNHXtNCkCNTMhXHfgNssimWjCdZ_Mfi2TNjPBJA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 12, 2022 at 6:44 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series tries to add PASID support for virtio-pci to allow the
> > virtqueue to use PASID TLP prefix for PCI transactions. This will be
> > useful for future work like, queue assignment, virtqueue
> > virtualization and presenting multiple vDPA devices with a single PCI
> > device.
> >
> > Since we're short of the space for the PCI capabilities, the PCI
> > extended capability for virtio structure is introduced that allows the
> > PASID configuration structure to use.
> >
> > A prototype is implemented with emulated virtio-pci device in [1]. A
> > test driver is implemented in [2].
> >
> > Please review.
>
> I don't know the security model for PASIDs. My guess is that PASIDs can
> be bruteforced so we must trust the driver (it can assign PASIDs to
> virtqueue groups) and we must prevent untrusted applications from
> setting PASIDs on virtqueues. Is that correct?

Yes, and the kernel can choose to hide PASID even for the trusted
application by using token or other intermediate layers.

Thanks

>
> Thanks,
> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

