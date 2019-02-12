Return-Path: virtio-dev-return-5407-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC696985D18
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 16:46:45 +0000 (UTC)
Date: Tue, 12 Feb 2019 16:46:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190212164626.GG2715@work-vm>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Frank Yang (lfy@google.com) wrote:
> Thanks Roman for the reply. Yes, we need sensors, sound, codecs, etc. as
> well.
> 
> For general string passing, yes, perhaps virtio-vsock can be used. However,
> I have some concerns about virtio-serial and virtio-vsock (mentioned
> elsewhere in the thread in rely to Stefan's similar comments) around socket
> API specialization.
> 
> Stepping back to standardization and portability concerns, it is also not
> necessarily desirable to use general pipes to do what we want, because even
> though that device exists and is part of the spec already, that results in
> _de-facto_ non-portability. If we had some kind of spec to enumerate such
> 'user-defined' devices, at least we can have _de-jure_ non-portability; an
> enumerated device doesn't work as advertised.
> 
> virtio-gpu: we have concerns around its specialization to virgl and
> de-facto gallium-based protocol, while we tend to favor API forwarding due
> to its debuggability and flexibility. We may use virtio-gpu in the future
> if/when it provides that general "send api data" capability.]
> 
> In any case, I now have a very rough version of the spec in mind (attached
> as a patch and as a pdf).

Some thoughts (and remember I'm fairly new to virtio):

  a) Please don't call it virito-user - we have vhost-user as one of the
implementations of virtio and that would just get confusing (especially
when we have a vhost-user-user implementation)

  b) Your ping and event queues confuse me - they seem to be
reimplementing exactly what virtio-queues already are; aren't virtio
queues already lumps of shared memory with a 'kick' mechanism to wake up
the other end when something interesting happens?

  c) I think you actually have two separate types of devices that
should be treated differently;
     1) your high bandwidth gpu/codec
     2) Low bandwidth batteries/sensors


  I can imagine you having a total of two device definitions and drivers
for (1) and (2).

  (2) feels like it's pretty similar to a socket/pipe/serial - but it
needs a way to enumerate the sensors you have, their ranges etc and a
defined format for transmitting the data.  I'm not sure if it's possible
to take one of the existing socket/pipe/serial things and layer on top
of it.  (is there any HID like standard for sensors like that?)

  Perhaps for (1) for your GPU stuff, maybe a single virtio device
would work, with a small number of shared memory arenas but multiple
virtio queues; each (set of) queues would represent a subdevice (say
a bunch of queues for the GPU another bunch for the CODEC etc).

Dave

> The part of the intro in there that is relevant to the current thread:
> 
> """
> Note that virtio-serial/virtio-vsock is not considered because they do not
> standardize the set of devices that operate on top of them, but in practice,
> are often used for fully general devices.  Spec-wise, this is not a great
> situation because we would still have potentially non portable device
> implementations where there is no standard mechanism to determine whether or
> not things are portable.  virtio-user provides a device enumeration
> mechanism
> to better control this.
> 
> In addition, for performance considerations in applications such as graphics
> and media, virtio-serial/virtio-vsock have the overhead of sending actual
> traffic through the virtqueue, while an approach based on shared memory can
> result in having fewer copies and virtqueue messages.  virtio-serial is also
> limited in being specialized for console forwarding and having a cap on the
> number of clients.  virtio-vsock is also not optimal in its choice of
> sockets
> API for transport; shared memory cannot be used, arbitrary strings can be
> passed without an designation of the device/driver being run de-facto, and
> the
> guest must have additional machinery to handle socket APIs.  In addition, on
> the host, sockets are only dependable on Linux, with less predictable
> behavior
> from Windows/macOS regarding Unix sockets.  Waiting for socket traffic on
> the
> host also requires a poll() loop, which is suboptimal for latency.  With
> virtio-user, only the bare set of standard driver calls
> (open/close/ioctl/mmap/read) is needed, and RAM is a more universal
> transport
> abstraction.  We also explicitly spec out callbacks on host that are
> triggered
> by virtqueue messages, which results in lower latency and makes it easy to
> dispatch to a particular device implementation without polling.
> 
> """
> 
> On Tue, Feb 12, 2019 at 6:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > On Tue, Feb 12, 2019 at 02:47:41PM +0100, Cornelia Huck wrote:
> > > On Tue, 12 Feb 2019 11:25:47 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >
> > > > * Roman Kiryanov (rkir@google.com) wrote:
> > > > > > > Our long term goal is to have as few kernel drivers as possible
> > and to move
> > > > > > > "drivers" into userspace. If we go with the virtqueues, is there
> > > > > > > general a purpose
> > > > > > > device/driver to talk between our host and guest to support
> > custom hardware
> > > > > > > (with own blobs)?
> > > > > >
> > > > > > The challenge is to answer the following question:
> > > > > > how to do this without losing the benefits of standartization?
> > > > >
> > > > > We looked into UIO and it still requires some kernel driver to tell
> > > > > where the device is, it also has limitations on sharing a device
> > > > > between processes. The benefit of standardization could be in
> > avoiding
> > > > > everybody writing their own UIO drivers for virtual devices.
> > > > >
> > > > > Our emulator uses a battery, sound, accelerometer and more. We need
> > to
> > > > > support all of this. I looked into the spec, "5 Device types", and
> > > > > seems "battery" is not there. We can invent our own drivers but we
> > see
> > > > > having one flexible driver is a better idea.
> > > >
> > > > Can you group these devices together at all in their requirements?
> > > > For example, battery and accelerometers (to me) sound like
> > low-bandwidth
> > > > 'sensors' with a set of key,value pairs that update occasionally
> > > > and a limited (no?) amount of control from the VM->host.
> > > > A 'virtio-values' device that carried a string list of keys that it
> > > > supported might make sense and be enough for at least two of your
> > > > device types.
> > >
> > > Maybe not a 'virtio-values' device -- but a 'virtio-sensors' device
> > > looks focused enough without being too inflexible. It can easily
> > > advertise its type (battery, etc.) and therefore avoid the mismatch
> > > problem that a too loosely defined device would be susceptible to.
> >
> > Isn't virtio-vsock/vhost-vsock a good fit for this kind of general
> > string passing? People seem to use it exactly for this.
> >
> > > > > Yes, I realize that a guest could think it is using the same device
> > as
> > > > > the host advertised (because strings matched) while it is not. We
> > > > > control both the host and the guest and we can live with this.
> > >
> > > The problem is that this is not true for the general case if you have a
> > > standardized device type. It must be possible in theory to switch to an
> > > alternative implementation of the device or the driver, as long as they
> > > conform to the spec. I think a more concretely specified device type
> > > (like the suggested virtio-values or virtio-sensors) is needed for that.
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

