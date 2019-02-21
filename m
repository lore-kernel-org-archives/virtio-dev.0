Return-Path: virtio-dev-return-5477-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C92B29860B7
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 06:44:43 +0000 (UTC)
Date: Thu, 21 Feb 2019 07:44:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221064436.ohxad2gonr2akadm@sirius.home.kraxel.org>
References: <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
 <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
 <20190220062539.toctrkhk67iyzwnk@sirius.home.kraxel.org>
 <CAEkmjvU5tc8tYpbynigVSGqTh5_SyhoMVEAu3Z1wo6vaGBBbVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvU5tc8tYpbynigVSGqTh5_SyhoMVEAu3Z1wo6vaGBBbVg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > Hmm.  I'm wondering whenever you just need a different virtio transport.
> > Very simliar to virtio-pci, but instead of using all guest ram (modulo
> > iommu quirks) as address space use a pci memory bar as address space.
> > virtio rings would live there, all buffers would live there, addresses
> > passed around would be offsets into that pci bar.  Then your userspace
> > driver can just mmap() that pci bar and handle (almost?) everything on
> > its own.  Maybe a little stub driver in the kernel is needed for ring
> > notifications.
> >
> >
> Yeah, that's (almost?) exactly what we want to do / we're doing already
> pretty much
> with the memory sharing scheme we're using currently.
> 
> Defining it as a transport would also require definition of another virtio
> device type
> that the userspace drivers talk to, right?

Yes, you still need to define (for example) virtio-sensors.

> As a transport/device pair, would it break down as, the transport ends up
> restricting what kinds of addresses can be referred to in the ring messages
> (in the pci memory bar),
> then the device provides the userspace drivers with
> implementation of mmap() + memory allocation/sharing ops and notification?

I'd expect the userspace driver would just mmap the whole pci bar, then
manage it without the kernel's help.

> > > Using usb or faking some other transport generally also involves being
> > > coupled to that set of kernel code in the guest, which introduces
> > > complexity and overhead.  Exposing RAM can be a more flexible
> > > abstraction.
> >
> > Well, you get guest drivers for free and all existing software will run
> > just fine out-of-the-box.
> >
> > Which is the reason why there is no virtio-usb for example.  xhci has a
> > hardware design which can be emulated without much overhead, so the
> > performance benefit of virtio-usb over xhci would be pretty close to
> > zero.
> >
> >
> That's pretty interesting; from a brief glance at xhci, it looks like what
> you're proposing
> is that since there usb passthrough already with xhci,
> and xhci has something that looks like a virtqueue,
> perhaps we can create our own USB driver on the host,
> then pass it through.
> 
> It does make things more inconvenient for users though since they would
> have to install
> usb drivers out of nowhere. Wonder if a usb forwarder virtual device exists
> that can talk to some shared library on the host for the xhci queue, though
> that might be considered an unsafe plugin.

Well, we have virtual emulated devices (hw/usb/dev-*.c in source tree).
You could add a virtual camera device here ...

Alternatively qemu can pass through anything libusb can talk to
(typically physical devices, but IIRC you can also create virtual ones
with the kernel's usb gadget drivers).

Direct access to the xhci queues/rings isn't available, this is
abstracted away by the qemu usb subsystem.  The virtual usb devices
emulation drivers get a iov pointing to the buffers in guest memory for
a given usb transfer request, no matter whenever uhci, ehci or xhci is
used.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

