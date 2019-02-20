Return-Path: virtio-dev-return-5465-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBBC1985D01
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 06:25:46 +0000 (UTC)
Date: Wed, 20 Feb 2019 07:25:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190220062539.toctrkhk67iyzwnk@sirius.home.kraxel.org>
References: <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
 <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > That might simlify pass-through of v4l2 host devices, but isn't
> > necessarily the best choice long-term.

> Right, but if we're not emulating at the v4l2 api level, then it starts
> looking a lot
> like the proposed virtio-hostmem; there's a common pattern of
> direct access to host memory

Typically camera hardware can DMA the image data to any place in memory,
including guest ram.  There is no need to expose host memory to the
guest for that.  The normal virtio workflow with guest-allocated buffers
will work just fine.

> In addition, we'd like to do things in a way
> that allows virtual drivers/devices to be defined in a manner that doesn't
> require the guest kernel to be updated.

Hmm.  I'm wondering whenever you just need a different virtio transport.
Very simliar to virtio-pci, but instead of using all guest ram (modulo
iommu quirks) as address space use a pci memory bar as address space.
virtio rings would live there, all buffers would live there, addresses
passed around would be offsets into that pci bar.  Then your userspace
driver can just mmap() that pci bar and handle (almost?) everything on
its own.  Maybe a little stub driver in the kernel is needed for ring
notifications.

> For us, maintaining and upgrading guest kernels in response to tweaks to
> virtual devices
> is much more work than modifying a userspace shared library driver that
> communicates to some virtio driver.

Well, one of the design goals of virtio is that such an upgrade is not
required.  Capabilities of device and driver are negotiated using
feature flags, which removes the need for lockstep updates of guest and
host.

> Thus far, it's suggested that socket or
> network devices
> be used for this, because they are general guest/host communication,
> but they don't have the portability or performance characteristics we want.

For high-bandwidth fully agree.

For low-bandwidth (like the sensors discussed elsewhere in the thread) I
think running some protocol (mqtt, something json-based, ...) over
virtio-serial or virtio-vsock isn't too bad.

But creating virtio-sensors makes sense too.

> > Alternatively emulate something existing, USB Video Class device for
> > example.
> 
> Using usb or faking some other transport generally also involves being
> coupled to that set of kernel code in the guest, which introduces
> complexity and overhead.  Exposing RAM can be a more flexible
> abstraction.

Well, you get guest drivers for free and all existing software will run
just fine out-of-the-box.

Which is the reason why there is no virtio-usb for example.  xhci has a
hardware design which can be emulated without much overhead, so the
performance benefit of virtio-usb over xhci would be pretty close to
zero.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

