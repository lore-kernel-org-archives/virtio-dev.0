Return-Path: virtio-dev-return-5415-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D201C985D40
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 19:01:35 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212125701-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212125701-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 11:01:21 -0800
Message-ID: <CAEkmjvX6YMBVBT6mg3XzQ7_FcMoaDKmxQX_Qr0uiG=X5L8OGCA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c7f9520581b70df9"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000c7f9520581b70df9
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 10:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 07:56:58AM -0800, Frank Yang wrote:
> > Stepping back to standardization and portability concerns, it is also not
> > necessarily desirable to use general pipes to do what we want, because
> even
> > though that device exists and is part of the spec already, that results
> in
> > _de-facto_ non-portability.
>
> That's not different from e.g. TCP.
>
> > If we had some kind of spec to enumerate such
> > 'user-defined' devices, at least we can have _de-jure_ non-portability;
> an
> > enumerated device doesn't work as advertised.
>
> I am not sure distinguishing between different types of non portability
> will be in scope for virtio. Actually having devices that are portable
> would be.
>
> The device itself is portable; the user-defined drivers that run on them
will work or not depending on
negotiating device IDs.

> ...
>
> Note that virtio-serial/virtio-vsock is not considered because they do not
> > standardize the set of devices that operate on top of them, but in
> practice,
> > are often used for fully general devices.  Spec-wise, this is not a great
> > situation because we would still have potentially non portable device
> > implementations where there is no standard mechanism to determine
> whether or
> > not things are portable.
>
> Well it's easy to add an enumeration on top of sockets, and several well
> known solutions exist. There's an advantage to just reusing these.


Sure, but there are many unique features/desirable properties of having the
virtio meta device
because (as explained in the spec) there are limitations to network/socket
based communication.


> > virtio-user provides a device enumeration mechanism
> > to better control this.
>
> We'll have to see what it all looks like. For virtio pci transport it's
> important that you can reason about the device at a basic level based on
> it's PCI ID, and that is quite fundamental.
>
> The spec contains more details; basically the device itself is always
portable, and there is a configuration protocol
to negotiate whether a particular use of the device is available. This is
similar to PCI,
but with more defined ways to operate the device in terms of callbacks in
shared libraries on the host.


> Maybe what you are looking for is a new virtio transport then?
>
>
Perhaps, something like virtio host memory transport? But
at the same time, it needs to interact with shared memory which is best set
as a PCI device.
Can we mix transport types? In any case, the analog of "PCI ID"'s here (the
vendor/device/version numbers)
are meaningful, with the contract being that the user of the device needs
to match on vendor/device id and
negotiate on version number.

Wha are the advantages of defining a new virtio transport type?
it would be something that has the IDs, and be able to handle resolving
offsets to
physical addresses to host memory addresses,
in addition to dispatching to callbacks on the host.
But it would be effectively equivalent to having a new virtio device type
with device ID enumeration, right?


> > In addition, for performance considerations in applications such as
> graphics
> > and media, virtio-serial/virtio-vsock have the overhead of sending actual
> > traffic through the virtqueue, while an approach based on shared memory
> can
> > result in having fewer copies and virtqueue messages.  virtio-serial is
> also
> > limited in being specialized for console forwarding and having a cap on
> the
> > number of clients.  virtio-vsock is also not optimal in its choice of
> sockets
> > API for transport; shared memory cannot be used, arbitrary strings can be
> > passed without an designation of the device/driver being run de-facto,
> and the
> > guest must have additional machinery to handle socket APIs.  In
> addition, on
> > the host, sockets are only dependable on Linux, with less predictable
> behavior
> > from Windows/macOS regarding Unix sockets.  Waiting for socket traffic
> on the
> > host also requires a poll() loop, which is suboptimal for latency.  With
> > virtio-user, only the bare set of standard driver calls
> > (open/close/ioctl/mmap/read) is needed, and RAM is a more universal
> transport
> > abstraction.  We also explicitly spec out callbacks on host that are
> triggered
> > by virtqueue messages, which results in lower latency and makes it easy
> to
> > dispatch to a particular device implementation without polling.
>
> open/close/mmap/read seem to make sense. ioctl gives one pause.
>
> ioctl would be to send ping messages, but I'm not fixated on that choice.
write() is also a possibility to send ping messages; I preferred ioctl()
because it should be clear that it's a control message not a data message.


> Given open/close this begins to look a bit like virtio-fs.
> Have you looked at that?
>
>
That's an interesting possibility since virtio-fs maps host pointers as
well, which fits our use cases.
Another alternative is to add the features unique about virtio-user to
virtio-fs:
device enumeration, memory sharing operations, operation in terms of
callbacks on the host.
However, it doesn't seem like a good fit due to being specialized to
filesystem operations.


> --
> MST
>

--000000000000c7f9520581b70df9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Feb 12, 2019 at 10:22 AM Michael S. Tsirkin &lt;<a href=3D"m=
ailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Feb 12, 2019 =
at 07:56:58AM -0800, Frank Yang wrote:<br>
&gt; Stepping back to standardization and portability concerns, it is also =
not<br>
&gt; necessarily desirable to use general pipes to do what we want, because=
 even<br>
&gt; though that device exists and is part of the spec already, that result=
s in<br>
&gt; _de-facto_ non-portability.<br>
<br>
That&#39;s not different from e.g. TCP.<br>
<br>
&gt; If we had some kind of spec to enumerate such<br>
&gt; &#39;user-defined&#39; devices, at least we can have _de-jure_ non-por=
tability; an<br>
&gt; enumerated device doesn&#39;t work as advertised.<br>
<br>
I am not sure distinguishing between different types of non portability<br>
will be in scope for virtio. Actually having devices that are portable<br>
would be.<br>
<br></blockquote><div>The device itself is portable; the user-defined drive=
rs that run on them will work or not depending on</div><div>negotiating dev=
ice IDs.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
...=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt; Note that virtio-serial/virtio-vsock is not considered because they do=
 not<br>
&gt; standardize the set of devices that operate on top of them, but in pra=
ctice,<br>
&gt; are often used for fully general devices.=C2=A0 Spec-wise, this is not=
 a great<br>
&gt; situation because we would still have potentially non portable device<=
br>
&gt; implementations where there is no standard mechanism to determine whet=
her or<br>
&gt; not things are portable.<br>
<br>
Well it&#39;s easy to add an enumeration on top of sockets, and several wel=
l<br>
known solutions exist. There&#39;s an advantage to just reusing these.=C2=
=A0=C2=A0</blockquote><div><br></div><div>Sure, but there are many unique f=
eatures/desirable properties of having the virtio meta device</div><div>bec=
ause (as explained in the spec) there are limitations to network/socket bas=
ed communication.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt;=C2=A0virtio-user provides a device enumeration mechanism<br>
&gt; to better control this.<br>
<br>
We&#39;ll have to see what it all looks like. For virtio pci transport it&#=
39;s<br>
important that you can reason about the device at a basic level based on<br=
>
it&#39;s PCI ID, and that is quite fundamental.<br>
<br></blockquote><div>The spec contains more details; basically the device =
itself is always portable, and there is a configuration protocol</div><div>=
to negotiate whether a particular use of the device is available. This is s=
imilar to PCI,</div><div>but with more defined ways to operate the device i=
n terms of callbacks in shared libraries on the host.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
Maybe what you are looking for is a new virtio transport then?<br>
<br></blockquote><div>=C2=A0</div><div>Perhaps, something like virtio host =
memory transport? But</div><div>at the same time, it needs to interact with=
 shared memory which is best set as a PCI device.</div><div>Can we mix tran=
sport types? In any case, the analog of &quot;PCI ID&quot;&#39;s here (the =
vendor/device/version numbers)</div><div>are meaningful, with the contract =
being that the user of the device needs to match on vendor/device id and</d=
iv><div>negotiate on version number.</div><div><br></div><div>Wha are the a=
dvantages of defining a new virtio transport type?</div><div>it would be so=
mething that has the IDs, and be able to handle resolving offsets to</div><=
div>physical addresses to host memory addresses,</div><div>in addition to d=
ispatching to callbacks on the host.</div><div>But it would be effectively =
equivalent to having a new virtio device type with device ID enumeration, r=
ight?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; In addition, for performance considerations in applications such as gr=
aphics<br>
&gt; and media, virtio-serial/virtio-vsock have the overhead of sending act=
ual<br>
&gt; traffic through the virtqueue, while an approach based on shared memor=
y can<br>
&gt; result in having fewer copies and virtqueue messages.=C2=A0 virtio-ser=
ial is also<br>
&gt; limited in being specialized for console forwarding and having a cap o=
n the<br>
&gt; number of clients.=C2=A0 virtio-vsock is also not optimal in its choic=
e of sockets<br>
&gt; API for transport; shared memory cannot be used, arbitrary strings can=
 be<br>
&gt; passed without an designation of the device/driver being run de-facto,=
 and the<br>
&gt; guest must have additional machinery to handle socket APIs.=C2=A0 In a=
ddition, on<br>
&gt; the host, sockets are only dependable on Linux, with less predictable =
behavior<br>
&gt; from Windows/macOS regarding Unix sockets.=C2=A0 Waiting for socket tr=
affic on the<br>
&gt; host also requires a poll() loop, which is suboptimal for latency.=C2=
=A0 With<br>
&gt; virtio-user, only the bare set of standard driver calls<br>
&gt; (open/close/ioctl/mmap/read) is needed, and RAM is a more universal tr=
ansport<br>
&gt; abstraction.=C2=A0 We also explicitly spec out callbacks on host that =
are triggered<br>
&gt; by virtqueue messages, which results in lower latency and makes it eas=
y to<br>
&gt; dispatch to a particular device implementation without polling.<br>
<br>
open/close/mmap/read seem to make sense. ioctl gives one pause.<br>
<br></blockquote><div>ioctl would be to send ping messages, but I&#39;m not=
 fixated on that choice. write() is also a possibility to send ping message=
s; I preferred ioctl() because it should be clear that it&#39;s a control m=
essage not a data message.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
Given open/close this begins to look a bit like virtio-fs.<br>
Have you looked at that?<br>
<br></blockquote><div>=C2=A0</div><div>That&#39;s an interesting possibilit=
y since virtio-fs maps host pointers as well, which fits our use cases.</di=
v><div>Another alternative is to add the features unique about virtio-user =
to virtio-fs:</div><div>device enumeration, memory sharing operations, oper=
ation in terms of callbacks on the host.</div><div>However, it doesn&#39;t =
seem like a good fit due to being specialized to filesystem operations.</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
MST<br>
</blockquote></div></div>
</div>

--000000000000c7f9520581b70df9--
