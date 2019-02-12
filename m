Return-Path: virtio-dev-return-5417-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3E7B985D47
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 19:15:23 +0000 (UTC)
Date: Tue, 12 Feb 2019 14:15:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212140706-mutt-send-email-mst@kernel.org>
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212125701-mutt-send-email-mst@kernel.org>
 <CAEkmjvX6YMBVBT6mg3XzQ7_FcMoaDKmxQX_Qr0uiG=X5L8OGCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvX6YMBVBT6mg3XzQ7_FcMoaDKmxQX_Qr0uiG=X5L8OGCA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 11:01:21AM -0800, Frank Yang wrote:
>=20
>=20
>=20
> On Tue, Feb 12, 2019 at 10:22 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>=20
>     On Tue, Feb 12, 2019 at 07:56:58AM -0800, Frank Yang wrote:
>     > Stepping back to standardization and portability concerns, it is al=
so not
>     > necessarily desirable to use general pipes to do what we want, beca=
use
>     even
>     > though that device exists and is part of the spec already, that res=
ults
>     in
>     > _de-facto_ non-portability.
>=20
>     That's not different from e.g. TCP.
>=20
>     > If we had some kind of spec to enumerate such
>     > 'user-defined' devices, at least we can have _de-jure_ non-portabil=
ity;
>     an
>     > enumerated device doesn't work as advertised.
>=20
>     I am not sure distinguishing between different types of non portabili=
ty
>     will be in scope for virtio. Actually having devices that are portable
>     would be.
>=20
>=20
> The device itself is portable; the user-defined drivers that run on them =
will
> work or not depending on
> negotiating device IDs.
>=20
>     ...=A0
>=20
>     > Note that virtio-serial/virtio-vsock is not considered because they=
 do
>     not
>     > standardize the set of devices that operate on top of them, but in
>     practice,
>     > are often used for fully general devices.=A0 Spec-wise, this is not=
 a great
>     > situation because we would still have potentially non portable devi=
ce
>     > implementations where there is no standard mechanism to determine w=
hether
>     or
>     > not things are portable.
>=20
>     Well it's easy to add an enumeration on top of sockets, and several w=
ell
>     known solutions exist. There's an advantage to just reusing these.=A0=
=A0
>=20
>=20
> Sure, but there are many unique features/desirable properties of having t=
he
> virtio meta device
> because (as explained in the spec) there are limitations to network/socket
> based communication.
> =A0
>=20
>     >=A0virtio-user provides a device enumeration mechanism
>     > to better control this.
>=20
>     We'll have to see what it all looks like. For virtio pci transport it=
's
>     important that you can reason about the device at a basic level based=
 on
>     it's PCI ID, and that is quite fundamental.
>=20
>=20
> The spec contains more details; basically the device itself is always por=
table,
> and there is a configuration protocol
> to negotiate whether a particular use of the device is available. This is
> similar to PCI,
> but with more defined ways to operate the device in terms of callbacks in
> shared libraries on the host.
> =A0
>=20
>     Maybe what you are looking for is a new virtio transport then?
>=20
>=20
> =A0
> Perhaps, something like virtio host memory transport? But
> at the same time, it needs to interact with shared memory which is best s=
et as
> a PCI device.
> Can we mix transport types? In any case, the analog of "PCI ID"'s here (t=
he
> vendor/device/version numbers)
> are meaningful, with the contract being that the user of the device needs=
 to
> match on vendor/device id and
> negotiate on version number.

Virtio is fundamentally using feature bits not versions.
It's been pretty successful in maintaining compatiblity
across a wide range of hypervisor/guest revisions.


> Wha are the advantages of defining a new virtio transport type?
> it would be something that has the IDs, and be able to handle resolving o=
ffsets
> to
> physical addresses to host memory addresses,
> in addition to dispatching to callbacks on the host.
> But it would be effectively equivalent to having a new virtio device type=
 with
> device ID enumeration, right?

Under virtio PCI Device IDs are all defined in virtio spec.
If you want your own ID scheme you want an alternative transport.
But now what you describe looks kind of like vhost pci to me.


>=20
>=20
>     > In addition, for performance considerations in applications such as
>     graphics
>     > and media, virtio-serial/virtio-vsock have the overhead of sending =
actual
>     > traffic through the virtqueue, while an approach based on shared me=
mory
>     can
>     > result in having fewer copies and virtqueue messages.=A0 virtio-ser=
ial is
>     also
>     > limited in being specialized for console forwarding and having a ca=
p on
>     the
>     > number of clients.=A0 virtio-vsock is also not optimal in its choic=
e of
>     sockets
>     > API for transport; shared memory cannot be used, arbitrary strings =
can be
>     > passed without an designation of the device/driver being run de-fac=
to,
>     and the
>     > guest must have additional machinery to handle socket APIs.=A0 In a=
ddition,
>     on
>     > the host, sockets are only dependable on Linux, with less predictab=
le
>     behavior
>     > from Windows/macOS regarding Unix sockets.=A0 Waiting for socket tr=
affic on
>     the
>     > host also requires a poll() loop, which is suboptimal for latency.=
=A0 With
>     > virtio-user, only the bare set of standard driver calls
>     > (open/close/ioctl/mmap/read) is needed, and RAM is a more universal
>     transport
>     > abstraction.=A0 We also explicitly spec out callbacks on host that =
are
>     triggered
>     > by virtqueue messages, which results in lower latency and makes it =
easy
>     to
>     > dispatch to a particular device implementation without polling.
>=20
>     open/close/mmap/read seem to make sense. ioctl gives one pause.
>=20
>=20
> ioctl would be to send ping messages, but I'm not fixated on that choice.=
 write
> () is also a possibility to send ping messages; I preferred ioctl() becau=
se it
> should be clear that it's a control message not a data message.

Yes if ioctls supported are white-listed and not blindly passed through
(e.g. send a ping message), then it does not matter.


>=20
>     Given open/close this begins to look a bit like virtio-fs.
>     Have you looked at that?
>=20
>=20
> =A0
> That's an interesting possibility since virtio-fs maps host pointers as w=
ell,
> which fits our use cases.
> Another alternative is to add the features unique about virtio-user to
> virtio-fs:
> device enumeration, memory sharing operations, operation in terms of call=
backs
> on the host.
> However, it doesn't seem like a good fit due to being specialized to file=
system
> operations.

Well everything is a file :)

>=20
>=20
>     --
>     MST
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

