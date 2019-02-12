Return-Path: virtio-dev-return-5412-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26B5A985D23
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 18:22:59 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:22:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212125701-mutt-send-email-mst@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 07:56:58AM -0800, Frank Yang wrote:
> Stepping back to standardization and portability concerns, it is also not
> necessarily desirable to use general pipes to do what we want, because ev=
en
> though that device exists and is part of the spec already, that results in
> _de-facto_ non-portability.

That's not different from e.g. TCP.

> If we had some kind of spec to enumerate such
> 'user-defined' devices, at least we can have _de-jure_ non-portability; an
> enumerated device doesn't work as advertised.

I am not sure distinguishing between different types of non portability
will be in scope for virtio. Actually having devices that are portable
would be.

...

> Note that virtio-serial/virtio-vsock is not considered because they do not
> standardize the set of devices that operate on top of them, but in practi=
ce,
> are often used for fully general devices.=A0 Spec-wise, this is not a gre=
at
> situation because we would still have potentially non portable device
> implementations where there is no standard mechanism to determine whether=
 or
> not things are portable.

Well it's easy to add an enumeration on top of sockets, and several well
known solutions exist. There's an advantage to just reusing these.

>=A0virtio-user provides a device enumeration mechanism
> to better control this.

We'll have to see what it all looks like. For virtio pci transport it's
important that you can reason about the device at a basic level based on
it's PCI ID, and that is quite fundamental.

Maybe what you are looking for is a new virtio transport then?


> In addition, for performance considerations in applications such as graph=
ics
> and media, virtio-serial/virtio-vsock have the overhead of sending actual
> traffic through the virtqueue, while an approach based on shared memory c=
an
> result in having fewer copies and virtqueue messages.=A0 virtio-serial is=
 also
> limited in being specialized for console forwarding and having a cap on t=
he
> number of clients.=A0 virtio-vsock is also not optimal in its choice of s=
ockets
> API for transport; shared memory cannot be used, arbitrary strings can be
> passed without an designation of the device/driver being run de-facto, an=
d the
> guest must have additional machinery to handle socket APIs.=A0 In additio=
n, on
> the host, sockets are only dependable on Linux, with less predictable beh=
avior
> from Windows/macOS regarding Unix sockets.=A0 Waiting for socket traffic =
on the
> host also requires a poll() loop, which is suboptimal for latency.=A0 With
> virtio-user, only the bare set of standard driver calls
> (open/close/ioctl/mmap/read) is needed, and RAM is a more universal trans=
port
> abstraction.=A0 We also explicitly spec out callbacks on host that are tr=
iggered
> by virtqueue messages, which results in lower latency and makes it easy to
> dispatch to a particular device implementation without polling.

open/close/mmap/read seem to make sense. ioctl gives one pause.

Given open/close this begins to look a bit like virtio-fs.
Have you looked at that?


--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

