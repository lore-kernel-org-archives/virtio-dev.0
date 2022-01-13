Return-Path: <virtio-dev-return-9029-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB7B89864E5
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 10:40:25 +0000 (UTC)
Date: Thu, 13 Jan 2022 05:40:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220113053923-mutt-send-email-mst@kernel.org>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <Yd6xAbl9TGjU72Ng@stefanha-x1.localdomain>
 <CACGkMEsSVPnZNHXtNCkCNTMhXHfgNssimWjCdZ_Mfi2TNjPBJA@mail.gmail.com>
 <YeAAxCYT3I7Z/SmW@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YeAAxCYT3I7Z/SmW@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 13, 2022 at 10:36:52AM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 13, 2022 at 09:28:19AM +0800, Jason Wang wrote:
> > On Wed, Jan 12, 2022 at 6:44 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> > > > Hi All:
> > > >
> > > > This series tries to add PASID support for virtio-pci to allow the
> > > > virtqueue to use PASID TLP prefix for PCI transactions. This will be
> > > > useful for future work like, queue assignment, virtqueue
> > > > virtualization and presenting multiple vDPA devices with a single PCI
> > > > device.
> > > >
> > > > Since we're short of the space for the PCI capabilities, the PCI
> > > > extended capability for virtio structure is introduced that allows the
> > > > PASID configuration structure to use.
> > > >
> > > > A prototype is implemented with emulated virtio-pci device in [1]. A
> > > > test driver is implemented in [2].
> > > >
> > > > Please review.
> > >
> > > I don't know the security model for PASIDs. My guess is that PASIDs can
> > > be bruteforced so we must trust the driver (it can assign PASIDs to
> > > virtqueue groups) and we must prevent untrusted applications from
> > > setting PASIDs on virtqueues. Is that correct?
> > 
> > Yes, and the kernel can choose to hide PASID even for the trusted
> > application by using token or other intermediate layers.
> 
> It would be good to describe the security model from a virtio-pci
> perspective so driver implementors don't accidentally expose trusted
> interfaces to untrusted applications. It's obvious to someone who
> already understands and has thought through all of this, but not obvious
> to someone who is implementing a driver for the first time or someone
> who is modifying the VIRTIO specification and doesn't know/care about
> PASIDs.
> 
> Stefan


Can't hurt to have a security considerations chapter.
We should talk there about ACCESS_PLATFORM which has security implications
too.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

