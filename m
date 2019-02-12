Return-Path: virtio-dev-return-5419-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0F92985E09
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 20:15:59 +0000 (UTC)
MIME-Version: 1.0
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212125701-mutt-send-email-mst@kernel.org> <CAEkmjvX6YMBVBT6mg3XzQ7_FcMoaDKmxQX_Qr0uiG=X5L8OGCA@mail.gmail.com>
 <20190212140706-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212140706-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 12:15:45 -0800
Message-ID: <CAEkmjvVW03jYgSH_VDD3KErT2L24mhnb25LaR+ZPKr+N=iVeUw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d5b1bc0581b817c3"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000d5b1bc0581b817c3
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 11:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 11:01:21AM -0800, Frank Yang wrote:
> >
> >
> >
> > On Tue, Feb 12, 2019 at 10:22 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Tue, Feb 12, 2019 at 07:56:58AM -0800, Frank Yang wrote:
> >     > Stepping back to standardization and portability concerns, it is
> also not
> >     > necessarily desirable to use general pipes to do what we want,
> because
> >     even
> >     > though that device exists and is part of the spec already, that
> results
> >     in
> >     > _de-facto_ non-portability.
> >
> >     That's not different from e.g. TCP.
> >
> >     > If we had some kind of spec to enumerate such
> >     > 'user-defined' devices, at least we can have _de-jure_
> non-portability;
> >     an
> >     > enumerated device doesn't work as advertised.
> >
> >     I am not sure distinguishing between different types of non
> portability
> >     will be in scope for virtio. Actually having devices that are
> portable
> >     would be.
> >
> >
> > The device itself is portable; the user-defined drivers that run on them
> will
> > work or not depending on
> > negotiating device IDs.
> >
> >     ...
> >
> >     > Note that virtio-serial/virtio-vsock is not considered because
> they do
> >     not
> >     > standardize the set of devices that operate on top of them, but in
> >     practice,
> >     > are often used for fully general devices.  Spec-wise, this is not
> a great
> >     > situation because we would still have potentially non portable
> device
> >     > implementations where there is no standard mechanism to determine
> whether
> >     or
> >     > not things are portable.
> >
> >     Well it's easy to add an enumeration on top of sockets, and several
> well
> >     known solutions exist. There's an advantage to just reusing these.
> >
> >
> > Sure, but there are many unique features/desirable properties of having
> the
> > virtio meta device
> > because (as explained in the spec) there are limitations to
> network/socket
> > based communication.
> >
> >
> >     > virtio-user provides a device enumeration mechanism
> >     > to better control this.
> >
> >     We'll have to see what it all looks like. For virtio pci transport
> it's
> >     important that you can reason about the device at a basic level
> based on
> >     it's PCI ID, and that is quite fundamental.
> >
> >
> > The spec contains more details; basically the device itself is always
> portable,
> > and there is a configuration protocol
> > to negotiate whether a particular use of the device is available. This is
> > similar to PCI,
> > but with more defined ways to operate the device in terms of callbacks in
> > shared libraries on the host.
> >
> >
> >     Maybe what you are looking for is a new virtio transport then?
> >
> >
> >
> > Perhaps, something like virtio host memory transport? But
> > at the same time, it needs to interact with shared memory which is best
> set as
> > a PCI device.
> > Can we mix transport types? In any case, the analog of "PCI ID"'s here
> (the
> > vendor/device/version numbers)
> > are meaningful, with the contract being that the user of the device
> needs to
> > match on vendor/device id and
> > negotiate on version number.
>
> Virtio is fundamentally using feature bits not versions.
> It's been pretty successful in maintaining compatiblity
> across a wide range of hypervisor/guest revisions.
>

The proposed device should be compatible with all hypervisor/guest
revisions as is,
without feature bits.


> > Wha are the advantages of defining a new virtio transport type?
> > it would be something that has the IDs, and be able to handle resolving
> offsets
> > to
> > physical addresses to host memory addresses,
> > in addition to dispatching to callbacks on the host.
> > But it would be effectively equivalent to having a new virtio device
> type with
> > device ID enumeration, right?
>
> Under virtio PCI Device IDs are all defined in virtio spec.
> If you want your own ID scheme you want an alternative transport.
> But now what you describe looks kind of like vhost pci to me.
>
> Yet, vhost is still not a good fit, due to reliance on sockets/network
functionality.
It looks like we want to build something that has aspects in common with
other virtio devices,
but there is no combination of existing virtio devices that works.

   - the locality of virtio-fs, but not specialized to fuse
   - the device id enumeration from virtio pci, but not in the pci id space
   - the general communication of virtio-vsock, but not specialized to
   sockets and allowing host memory-based transport

So, I still think it should be a new device (or transport if that works
better).


> >
> >
> >     > In addition, for performance considerations in applications such as
> >     graphics
> >     > and media, virtio-serial/virtio-vsock have the overhead of sending
> actual
> >     > traffic through the virtqueue, while an approach based on shared
> memory
> >     can
> >     > result in having fewer copies and virtqueue messages.
> virtio-serial is
> >     also
> >     > limited in being specialized for console forwarding and having a
> cap on
> >     the
> >     > number of clients.  virtio-vsock is also not optimal in its choice
> of
> >     sockets
> >     > API for transport; shared memory cannot be used, arbitrary strings
> can be
> >     > passed without an designation of the device/driver being run
> de-facto,
> >     and the
> >     > guest must have additional machinery to handle socket APIs.  In
> addition,
> >     on
> >     > the host, sockets are only dependable on Linux, with less
> predictable
> >     behavior
> >     > from Windows/macOS regarding Unix sockets.  Waiting for socket
> traffic on
> >     the
> >     > host also requires a poll() loop, which is suboptimal for
> latency.  With
> >     > virtio-user, only the bare set of standard driver calls
> >     > (open/close/ioctl/mmap/read) is needed, and RAM is a more universal
> >     transport
> >     > abstraction.  We also explicitly spec out callbacks on host that
> are
> >     triggered
> >     > by virtqueue messages, which results in lower latency and makes it
> easy
> >     to
> >     > dispatch to a particular device implementation without polling.
> >
> >     open/close/mmap/read seem to make sense. ioctl gives one pause.
> >
> >
> > ioctl would be to send ping messages, but I'm not fixated on that
> choice. write
> > () is also a possibility to send ping messages; I preferred ioctl()
> because it
> > should be clear that it's a control message not a data message.
>
> Yes if ioctls supported are white-listed and not blindly passed through
> (e.g. send a ping message), then it does not matter.
>
>
There would be one whitelisted ioctl: IOCTL_PING, with struct close to what
is specified in the proposed spec,
with the instance handle field populated by the kernel.


>
> >
> >     Given open/close this begins to look a bit like virtio-fs.
> >     Have you looked at that?
> >
> >
> >
> > That's an interesting possibility since virtio-fs maps host pointers as
> well,
> > which fits our use cases.
> > Another alternative is to add the features unique about virtio-user to
> > virtio-fs:
> > device enumeration, memory sharing operations, operation in terms of
> callbacks
> > on the host.
> > However, it doesn't seem like a good fit due to being specialized to
> filesystem
> > operations.
>
> Well everything is a file :)
>
> Not according to virtio-fs; it specializes in fuse support in the guest
kernel.
However, it would work for me if the unique features about virtio-user were
added to it,
and dropping the requirement to use fuse.

> >
> >
> >     --
> >     MST
> >
>

--000000000000d5b1bc0581b817c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 11:15 AM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, =
Feb 12, 2019 at 11:01:21AM -0800, Frank Yang wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Tue, Feb 12, 2019 at 10:22 AM Michael S. Tsirkin &lt;<a href=3D"mai=
lto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Feb 12, 2019 at 07:56:58AM -0800, Frank Yan=
g wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Stepping back to standardization and portabili=
ty concerns, it is also not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; necessarily desirable to use general pipes to =
do what we want, because<br>
&gt;=C2=A0 =C2=A0 =C2=A0even<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; though that device exists and is part of the s=
pec already, that results<br>
&gt;=C2=A0 =C2=A0 =C2=A0in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; _de-facto_ non-portability.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0That&#39;s not different from e.g. TCP.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; If we had some kind of spec to enumerate such<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &#39;user-defined&#39; devices, at least we ca=
n have _de-jure_ non-portability;<br>
&gt;=C2=A0 =C2=A0 =C2=A0an<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; enumerated device doesn&#39;t work as advertis=
ed.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I am not sure distinguishing between different type=
s of non portability<br>
&gt;=C2=A0 =C2=A0 =C2=A0will be in scope for virtio. Actually having device=
s that are portable<br>
&gt;=C2=A0 =C2=A0 =C2=A0would be.<br>
&gt; <br>
&gt; <br>
&gt; The device itself is portable; the user-defined drivers that run on th=
em will<br>
&gt; work or not depending on<br>
&gt; negotiating device IDs.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0...=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Note that virtio-serial/virtio-vsock is not co=
nsidered because they do<br>
&gt;=C2=A0 =C2=A0 =C2=A0not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; standardize the set of devices that operate on=
 top of them, but in<br>
&gt;=C2=A0 =C2=A0 =C2=A0practice,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; are often used for fully general devices.=C2=
=A0 Spec-wise, this is not a great<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; situation because we would still have potentia=
lly non portable device<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; implementations where there is no standard mec=
hanism to determine whether<br>
&gt;=C2=A0 =C2=A0 =C2=A0or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; not things are portable.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Well it&#39;s easy to add an enumeration on top of =
sockets, and several well<br>
&gt;=C2=A0 =C2=A0 =C2=A0known solutions exist. There&#39;s an advantage to =
just reusing these.=C2=A0=C2=A0<br>
&gt; <br>
&gt; <br>
&gt; Sure, but there are many unique features/desirable properties of havin=
g the<br>
&gt; virtio meta device<br>
&gt; because (as explained in the spec) there are limitations to network/so=
cket<br>
&gt; based communication.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0virtio-user provides a device enumeration=
 mechanism<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to better control this.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We&#39;ll have to see what it all looks like. For v=
irtio pci transport it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0important that you can reason about the device at a=
 basic level based on<br>
&gt;=C2=A0 =C2=A0 =C2=A0it&#39;s PCI ID, and that is quite fundamental.<br>
&gt; <br>
&gt; <br>
&gt; The spec contains more details; basically the device itself is always =
portable,<br>
&gt; and there is a configuration protocol<br>
&gt; to negotiate whether a particular use of the device is available. This=
 is<br>
&gt; similar to PCI,<br>
&gt; but with more defined ways to operate the device in terms of callbacks=
 in<br>
&gt; shared libraries on the host.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Maybe what you are looking for is a new virtio tran=
sport then?<br>
&gt; <br>
&gt; <br>
&gt; =C2=A0<br>
&gt; Perhaps, something like virtio host memory transport? But<br>
&gt; at the same time, it needs to interact with shared memory which is bes=
t set as<br>
&gt; a PCI device.<br>
&gt; Can we mix transport types? In any case, the analog of &quot;PCI ID&qu=
ot;&#39;s here (the<br>
&gt; vendor/device/version numbers)<br>
&gt; are meaningful, with the contract being that the user of the device ne=
eds to<br>
&gt; match on vendor/device id and<br>
&gt; negotiate on version number.<br>
<br>
Virtio is fundamentally using feature bits not versions.<br>
It&#39;s been pretty successful in maintaining compatiblity<br>
across a wide range of hypervisor/guest revisions.=C2=A0<br></blockquote><d=
iv><br></div><div>The proposed device should be compatible with all hypervi=
sor/guest revisions as is,</div><div>without feature bits.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Wha are the advantages of defining a new virtio transport type?<br>
&gt; it would be something that has the IDs, and be able to handle resolvin=
g offsets<br>
&gt; to<br>
&gt; physical addresses to host memory addresses,<br>
&gt; in addition to dispatching to callbacks on the host.<br>
&gt; But it would be effectively equivalent to having a new virtio device t=
ype with<br>
&gt; device ID enumeration, right?<br>
<br>
Under virtio PCI Device IDs are all defined in virtio spec.<br>
If you want your own ID scheme you want an alternative transport.<br>
But now what you describe looks kind of like vhost pci to me.<br>
<br></blockquote><div>Yet, vhost is still not a good fit, due to reliance o=
n sockets/network functionality.</div><div>It looks like we want to build s=
omething that has aspects in common with other virtio devices,</div><div>bu=
t there is no combination of existing virtio devices that works.</div><div>=
<ul><li>the locality of virtio-fs, but not specialized to fuse</li><li>the =
device id enumeration from virtio pci, but not in the pci id space</li><li>=
the general communication of virtio-vsock, but not specialized to sockets a=
nd allowing host memory-based transport</li></ul>So, I still think it shoul=
d be a new device (or transport if that works better).</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; In addition, for performance considerations in=
 applications such as<br>
&gt;=C2=A0 =C2=A0 =C2=A0graphics<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and media, virtio-serial/virtio-vsock have the=
 overhead of sending actual<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; traffic through the virtqueue, while an approa=
ch based on shared memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0can<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; result in having fewer copies and virtqueue me=
ssages.=C2=A0 virtio-serial is<br>
&gt;=C2=A0 =C2=A0 =C2=A0also<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; limited in being specialized for console forwa=
rding and having a cap on<br>
&gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; number of clients.=C2=A0 virtio-vsock is also =
not optimal in its choice of<br>
&gt;=C2=A0 =C2=A0 =C2=A0sockets<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; API for transport; shared memory cannot be use=
d, arbitrary strings can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; passed without an designation of the device/dr=
iver being run de-facto,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; guest must have additional machinery to handle=
 socket APIs.=C2=A0 In addition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0on<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; the host, sockets are only dependable on Linux=
, with less predictable<br>
&gt;=C2=A0 =C2=A0 =C2=A0behavior<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; from Windows/macOS regarding Unix sockets.=C2=
=A0 Waiting for socket traffic on<br>
&gt;=C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; host also requires a poll() loop, which is sub=
optimal for latency.=C2=A0 With<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; virtio-user, only the bare set of standard dri=
ver calls<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; (open/close/ioctl/mmap/read) is needed, and RA=
M is a more universal<br>
&gt;=C2=A0 =C2=A0 =C2=A0transport<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; abstraction.=C2=A0 We also explicitly spec out=
 callbacks on host that are<br>
&gt;=C2=A0 =C2=A0 =C2=A0triggered<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; by virtqueue messages, which results in lower =
latency and makes it easy<br>
&gt;=C2=A0 =C2=A0 =C2=A0to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; dispatch to a particular device implementation=
 without polling.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0open/close/mmap/read seem to make sense. ioctl give=
s one pause.<br>
&gt; <br>
&gt; <br>
&gt; ioctl would be to send ping messages, but I&#39;m not fixated on that =
choice. write<br>
&gt; () is also a possibility to send ping messages; I preferred ioctl() be=
cause it<br>
&gt; should be clear that it&#39;s a control message not a data message.<br=
>
<br>
Yes if ioctls supported are white-listed and not blindly passed through<br>
(e.g. send a ping message), then it does not matter.<br>
<br></blockquote><div><br></div><div>There would be one whitelisted ioctl: =
IOCTL_PING, with struct close to what is specified in the proposed spec,</d=
iv><div>with the instance handle field populated by the kernel.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Given open/close this begins to look a bit like vir=
tio-fs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Have you looked at that?<br>
&gt; <br>
&gt; <br>
&gt; =C2=A0<br>
&gt; That&#39;s an interesting possibility since virtio-fs maps host pointe=
rs as well,<br>
&gt; which fits our use cases.<br>
&gt; Another alternative is to add the features unique about virtio-user to=
<br>
&gt; virtio-fs:<br>
&gt; device enumeration, memory sharing operations, operation in terms of c=
allbacks<br>
&gt; on the host.<br>
&gt; However, it doesn&#39;t seem like a good fit due to being specialized =
to filesystem<br>
&gt; operations.<br>
<br>
Well everything is a file :)<br>
<br></blockquote><div>Not according to virtio-fs; it specializes in fuse su=
pport in the guest kernel.</div><div>However, it would work for me if the u=
nique features about virtio-user were added to it,</div><div>and dropping t=
he requirement to use fuse.</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0MST<br>
&gt; <br>
</blockquote></div></div>

--000000000000d5b1bc0581b817c3--
