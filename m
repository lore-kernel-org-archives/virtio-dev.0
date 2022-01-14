Return-Path: <virtio-dev-return-9042-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CD6E986507
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 02:55:57 +0000 (UTC)
MIME-Version: 1.0
References: <20220112055755.41011-1-jasowang@redhat.com> <20220113101726-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220113101726-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jan 2022 10:55:38 +0800
Message-ID: <CACGkMEs5P9sK0qF26-Cz7F0ky944jd8XbhLKZ6tLnm96C1HErg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 13, 2022 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series tries to add PASID support for virtio-pci to allow the
> > virtqueue to use PASID TLP prefix for PCI transactions. This will be
> > useful for future work like, queue assignment, virtqueue
> > virtualization and presenting multiple vDPA devices with a single PCI
> > device.
>
>
> Try this:
>
> echo "ab virito virtio" >> ~/.vimrc
>
> and your subjects will be perfect from now on.

Sure. (Using emacs so I've added the virtio to the customized dict of
flyspell :))

Thanks

>
>
> > Since we're short of the space for the PCI capabilities, the PCI
> > extended capability for virtio structure is introduced that allows the
> > PASID configuration structure to use.
> >
> > A prototype is implemented with emulated virtio-pci device in [1]. A
> > test driver is implemented in [2].
> >
> > Please review.
> >
> > Thanks
> >
> > [1] https://github.com/jasowang/qemu.git virtio-pasid
> > [2] https://github.com/jasowang/linux.git virtio-pasid
> >
> > Jason Wang (2):
> >   virtio-pci: introduce virtio structure PCI Extended Capability
> >   virtio-pci: add PASID configuration extended capability
> >
> >  content.tex | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 244 insertions(+)
> >
> > --
> > 2.32.0 (Apple Git-132)
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

