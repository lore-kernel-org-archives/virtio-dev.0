Return-Path: virtio-dev-return-5409-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B87D985D18
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 17:20:32 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
In-Reply-To: <20190212164626.GG2715@work-vm>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 09:20:18 -0800
Message-ID: <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005b0e570581b5a4f0"
Subject: Re: [virtio-dev] Memory sharing device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000005b0e570581b5a4f0
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 8:46 AM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Frank Yang (lfy@google.com) wrote:
> > Thanks Roman for the reply. Yes, we need sensors, sound, codecs, etc. as
> > well.
> >
> > For general string passing, yes, perhaps virtio-vsock can be used.
> However,
> > I have some concerns about virtio-serial and virtio-vsock (mentioned
> > elsewhere in the thread in rely to Stefan's similar comments) around
> socket
> > API specialization.
> >
> > Stepping back to standardization and portability concerns, it is also not
> > necessarily desirable to use general pipes to do what we want, because
> even
> > though that device exists and is part of the spec already, that results
> in
> > _de-facto_ non-portability. If we had some kind of spec to enumerate such
> > 'user-defined' devices, at least we can have _de-jure_ non-portability;
> an
> > enumerated device doesn't work as advertised.
> >
> > virtio-gpu: we have concerns around its specialization to virgl and
> > de-facto gallium-based protocol, while we tend to favor API forwarding
> due
> > to its debuggability and flexibility. We may use virtio-gpu in the future
> > if/when it provides that general "send api data" capability.]
> >
> > In any case, I now have a very rough version of the spec in mind
> (attached
> > as a patch and as a pdf).
>
> Some thoughts (and remember I'm fairly new to virtio):
>

Thanks for the feedback! These are good points.


>
>   a) Please don't call it virito-user - we have vhost-user as one of the
> implementations of virtio and that would just get confusing (especially
> when we have a vhost-user-user implementation)
>
>
Ok, the name isn't really important to me. virto-meta perhaps?


>   b) Your ping and event queues confuse me - they seem to be
> reimplementing exactly what virtio-queues already are; aren't virtio
> queues already lumps of shared memory with a 'kick' mechanism to wake up
> the other end when something interesting happens?
>
> Right, it does expose that aspect of virtqueues, but there is a unique
part; it adds on a device-specific component
(the instance handle and metadata) to dispatch to and trigger the
device-specific callback when it comes on the host.
I wonder if there's a way to define just the instance
handle/metadata/callback parts, with other virtqueue stuff being standard.



>   c) I think you actually have two separate types of devices that
> should be treated differently;
>      1) your high bandwidth gpu/codec
>      2) Low bandwidth batteries/sensors
>

Yeah, perhaps there's some way to have general virtio devices for different
bandwidth levels.
Note that latency can also be an important consideration; while sensors
don't send much data per second,
the time of their arrival can matter a lot. Sensors themselves can "ping"
at 10^2 Hz or even higher.

  I can imagine you having a total of two device definitions and drivers
> for (1) and (2).
>
  (2) feels like it's pretty similar to a socket/pipe/serial - but it
> needs a way to enumerate the sensors you have, their ranges etc and a
> defined format for transmitting the data.  I'm not sure if it's possible
> to take one of the existing socket/pipe/serial things and layer on top
> of it.  (is there any HID like standard for sensors like that?)
>
> I'm not sure about there being an existing standard
(and it's possible to send different kinds of sensor / battery signals;
i.e., a fake source for testing purposes, raw sensor output from the actual
hardware,
and an integrated virtual sensor that passes through derived pose
information.
There's a similar breakdown when one is considering other devices such as
battery and camera.)
Though I have reservations about using actual sockets/pipes to communicate,
for compatibility and latency reasons.

As another example, consider camera / video playback. I've heard that the
way to approach this
is to build v4l2 and build a virtio-v4l2 layer underneath. However, this
would mean either assuming v4l2 on host
which is not portable to non-Linux, or requiring additional translation
layers between v4l2 in the guest and
$library on the host. With the proposed spec, a more general 'codec' device
can be implemented,
tested on actual programs on multiple guests/hosts easily, and then, if it
makes sense,
"promoted" to a new "virtio-codec" device type.

I think there's a central tension here that is process-related and is
similar to the reasons userspace drivers are a thing in Linux;
There's a set of existing guests/hosts that use virtio on some sort of
development schedule that
doesn't match the pace of development in kernels supporting virtio / the
virtio spec itself.
In Virtio, we have a centralized definition of drivers and devices that is
set in the middle layers
between chrome on top of VMMs and guest userspace: the guest kernel and
core VMM code.
When developing for programs such as the Android Emulator,
we aim most of our changes at the guest userspace and the chrome on top of
the VMM,
but it can often involve new forms of guest/host communication.

It's possible that what's being proposed also serves as a kind of L2 cache
(in the form of such a virtio meta device) to deal with changes
in third-party programs like the Android Emulator with servicing the cache
miss being standardization out of the meta device and into an existing
concrete virtio device type.
Seen from this perspective, it can be beneficial process-wise as a way to
pull in more new devices / standardize at a faster rate, that would
otherwise not have been visible.


>   Perhaps for (1) for your GPU stuff, maybe a single virtio device
> would work, with a small number of shared memory arenas but multiple
> virtio queues; each (set of) queues would represent a subdevice (say
> a bunch of queues for the GPU another bunch for the CODEC etc).


Well, if one device definition works well with both bandwidth regimes and
has better latency properties,
I like having the one definition better.

Along these lines, I would also be open to not putting up a new standard,
and revising virtio-vsock to incorporate all the unique parts of the
features proposed:
dropping socket API requirement from guest/host,
device enumeration, operation via ping+shared memory,
and callback-based operation with device definitions in the shared
libraries.

The way we're approaching GPU, with the workloads we tend to run
(just UI drawing, or in 3d apps, not too many draw calls per second /
limited by host GPU doing work),
still having one virtqueue seems fine as it's only used for kick
(API call parameters themselves would also live in shared memory),
though there are probably workloads that benefit from having one virtqueue
per "instance".


>
Dave
>
> > The part of the intro in there that is relevant to the current thread:
> >
> > """
> > Note that virtio-serial/virtio-vsock is not considered because they do
> not
> > standardize the set of devices that operate on top of them, but in
> practice,
> > are often used for fully general devices.  Spec-wise, this is not a great
> > situation because we would still have potentially non portable device
> > implementations where there is no standard mechanism to determine
> whether or
> > not things are portable.  virtio-user provides a device enumeration
> > mechanism
> > to better control this.
> >
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
> > sockets
> > API for transport; shared memory cannot be used, arbitrary strings can be
> > passed without an designation of the device/driver being run de-facto,
> and
> > the
> > guest must have additional machinery to handle socket APIs.  In
> addition, on
> > the host, sockets are only dependable on Linux, with less predictable
> > behavior
> > from Windows/macOS regarding Unix sockets.  Waiting for socket traffic on
> > the
> > host also requires a poll() loop, which is suboptimal for latency.  With
> > virtio-user, only the bare set of standard driver calls
> > (open/close/ioctl/mmap/read) is needed, and RAM is a more universal
> > transport
> > abstraction.  We also explicitly spec out callbacks on host that are
> > triggered
> > by virtqueue messages, which results in lower latency and makes it easy
> to
> > dispatch to a particular device implementation without polling.
> >
> > """
> >
> > On Tue, Feb 12, 2019 at 6:03 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> > > On Tue, Feb 12, 2019 at 02:47:41PM +0100, Cornelia Huck wrote:
> > > > On Tue, 12 Feb 2019 11:25:47 +0000
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > >
> > > > > * Roman Kiryanov (rkir@google.com) wrote:
> > > > > > > > Our long term goal is to have as few kernel drivers as
> possible
> > > and to move
> > > > > > > > "drivers" into userspace. If we go with the virtqueues, is
> there
> > > > > > > > general a purpose
> > > > > > > > device/driver to talk between our host and guest to support
> > > custom hardware
> > > > > > > > (with own blobs)?
> > > > > > >
> > > > > > > The challenge is to answer the following question:
> > > > > > > how to do this without losing the benefits of standartization?
> > > > > >
> > > > > > We looked into UIO and it still requires some kernel driver to
> tell
> > > > > > where the device is, it also has limitations on sharing a device
> > > > > > between processes. The benefit of standardization could be in
> > > avoiding
> > > > > > everybody writing their own UIO drivers for virtual devices.
> > > > > >
> > > > > > Our emulator uses a battery, sound, accelerometer and more. We
> need
> > > to
> > > > > > support all of this. I looked into the spec, "5 Device types",
> and
> > > > > > seems "battery" is not there. We can invent our own drivers but
> we
> > > see
> > > > > > having one flexible driver is a better idea.
> > > > >
> > > > > Can you group these devices together at all in their requirements?
> > > > > For example, battery and accelerometers (to me) sound like
> > > low-bandwidth
> > > > > 'sensors' with a set of key,value pairs that update occasionally
> > > > > and a limited (no?) amount of control from the VM->host.
> > > > > A 'virtio-values' device that carried a string list of keys that it
> > > > > supported might make sense and be enough for at least two of your
> > > > > device types.
> > > >
> > > > Maybe not a 'virtio-values' device -- but a 'virtio-sensors' device
> > > > looks focused enough without being too inflexible. It can easily
> > > > advertise its type (battery, etc.) and therefore avoid the mismatch
> > > > problem that a too loosely defined device would be susceptible to.
> > >
> > > Isn't virtio-vsock/vhost-vsock a good fit for this kind of general
> > > string passing? People seem to use it exactly for this.
> > >
> > > > > > Yes, I realize that a guest could think it is using the same
> device
> > > as
> > > > > > the host advertised (because strings matched) while it is not. We
> > > > > > control both the host and the guest and we can live with this.
> > > >
> > > > The problem is that this is not true for the general case if you
> have a
> > > > standardized device type. It must be possible in theory to switch to
> an
> > > > alternative implementation of the device or the driver, as long as
> they
> > > > conform to the spec. I think a more concretely specified device type
> > > > (like the suggested virtio-values or virtio-sensors) is needed for
> that.
> > > >
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail:
> virtio-dev-help@lists.oasis-open.org
> > >
>
>
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

--0000000000005b0e570581b5a4f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 8:46 AM Dr. D=
avid Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com">dgilbert@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">* Frank Yang (<a href=3D"mailto:lfy@google.com" target=3D"_blank">lfy@=
google.com</a>) wrote:<br>
&gt; Thanks Roman for the reply. Yes, we need sensors, sound, codecs, etc. =
as<br>
&gt; well.<br>
&gt; <br>
&gt; For general string passing, yes, perhaps virtio-vsock can be used. How=
ever,<br>
&gt; I have some concerns about virtio-serial and virtio-vsock (mentioned<b=
r>
&gt; elsewhere in the thread in rely to Stefan&#39;s similar comments) arou=
nd socket<br>
&gt; API specialization.<br>
&gt; <br>
&gt; Stepping back to standardization and portability concerns, it is also =
not<br>
&gt; necessarily desirable to use general pipes to do what we want, because=
 even<br>
&gt; though that device exists and is part of the spec already, that result=
s in<br>
&gt; _de-facto_ non-portability. If we had some kind of spec to enumerate s=
uch<br>
&gt; &#39;user-defined&#39; devices, at least we can have _de-jure_ non-por=
tability; an<br>
&gt; enumerated device doesn&#39;t work as advertised.<br>
&gt; <br>
&gt; virtio-gpu: we have concerns around its specialization to virgl and<br=
>
&gt; de-facto gallium-based protocol, while we tend to favor API forwarding=
 due<br>
&gt; to its debuggability and flexibility. We may use virtio-gpu in the fut=
ure<br>
&gt; if/when it provides that general &quot;send api data&quot; capability.=
]<br>
&gt; <br>
&gt; In any case, I now have a very rough version of the spec in mind (atta=
ched<br>
&gt; as a patch and as a pdf).<br>
<br>
Some thoughts (and remember I&#39;m fairly new to virtio):<br></blockquote>=
<div><br></div><div>Thanks for the feedback! These are good points.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 a) Please don&#39;t call it virito-user - we have vhost-user as one =
of the<br>
implementations of virtio and that would just get confusing (especially<br>
when we have a vhost-user-user implementation)<br>
<br></blockquote><div>=C2=A0</div><div>Ok, the name isn&#39;t really import=
ant to me. virto-meta perhaps?<br>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
=C2=A0 b) Your ping and event queues confuse me - they seem to be<br>
reimplementing exactly what virtio-queues already are; aren&#39;t virtio<br=
>
queues already lumps of shared memory with a &#39;kick&#39; mechanism to wa=
ke up<br>
the other end when something interesting happens?<br>
<br></blockquote><div>Right, it does expose that aspect of virtqueues, but =
there is a unique part; it adds on a device-specific component</div><div>(t=
he instance handle and metadata) to dispatch to and trigger the device-spec=
ific callback when it comes on the host.</div><div>I wonder if there&#39;s =
a way to define just the instance handle/metadata/callback parts, with othe=
r virtqueue stuff being standard.</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 c) I think you actually have two separate types of devices that<br>
should be treated differently;<br>
=C2=A0 =C2=A0 =C2=A01) your high bandwidth gpu/codec<br>
=C2=A0 =C2=A0 =C2=A02) Low bandwidth batteries/sensors=C2=A0<br></blockquot=
e><div>=C2=A0</div><div>Yeah, perhaps there&#39;s some way to have general =
virtio devices for different bandwidth levels.</div><div>Note that latency =
can also be an important consideration; while sensors don&#39;t send much d=
ata per second,</div><div>the time of their arrival can matter a lot. Senso=
rs themselves can &quot;ping&quot; at 10^2 Hz or even higher.</div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 I can imagine you having a total of two device definitions and drive=
rs<br>
for (1) and (2).=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 (2) feels like it&#39;s pretty similar to a socket/pipe/serial - but=
 it<br>
needs a way to enumerate the sensors you have, their ranges etc and a<br>
defined format for transmitting the data.=C2=A0 I&#39;m not sure if it&#39;=
s possible<br>
to take one of the existing socket/pipe/serial things and layer on top<br>
of it.=C2=A0 (is there any HID like standard for sensors like that?)<br>
<br></blockquote><div>I&#39;m not sure about there being an existing standa=
rd</div><div>(and it&#39;s possible to send different kinds of sensor / bat=
tery signals;</div><div>i.e., a fake source for testing purposes, raw senso=
r output from the actual hardware,</div><div>and an integrated virtual sens=
or that passes through derived pose information.</div><div>There&#39;s a si=
milar breakdown when one is considering other devices such as battery and c=
amera.)</div><div>Though I have reservations about using actual sockets/pip=
es to communicate,</div><div>for compatibility and latency reasons.</div><d=
iv><br></div><div>As another example, consider camera / video playback. I&#=
39;ve heard that the way to approach this</div><div>is to build v4l2 and bu=
ild a virtio-v4l2 layer underneath. However, this would mean either assumin=
g v4l2 on host</div><div>which is not portable to non-Linux, or requiring a=
dditional translation layers between v4l2 in the guest and</div><div>$libra=
ry on the host. With the proposed spec, a more general &#39;codec&#39; devi=
ce can be implemented,</div><div>tested on actual programs on multiple gues=
ts/hosts easily, and then, if it makes sense,</div><div>&quot;promoted&quot=
; to a new &quot;virtio-codec&quot; device type.</div><div><br></div><div>I=
 think there&#39;s a central tension here that is process-related and is si=
milar to the reasons userspace drivers are a thing in Linux;</div><div>Ther=
e&#39;s a set of existing guests/hosts that use virtio on some sort of deve=
lopment schedule that</div><div>doesn&#39;t match the pace of development i=
n kernels supporting virtio / the virtio spec itself.</div><div>In Virtio, =
we have a centralized definition of drivers and devices that is set in the =
middle layers</div><div>between chrome on top of VMMs and guest userspace: =
the guest kernel and core VMM code.</div><div>When developing for programs =
such as the Android Emulator,</div><div>we aim most of our changes at the g=
uest userspace and the chrome on top of the VMM,</div><div>but it can often=
 involve new forms of guest/host communication.</div><div><br></div><div>It=
&#39;s possible that what&#39;s being proposed also serves as a kind of L2 =
cache (in the form of such a virtio meta device) to deal with changes</div>=
<div>in third-party programs like the Android Emulator with servicing the c=
ache miss being standardization out of the meta device and into an existing=
 concrete virtio device type.</div><div>Seen from this perspective, it can =
be beneficial process-wise as a way to pull in more new devices / standardi=
ze at a faster rate, that would otherwise not have been visible.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 Perhaps for (1) for your GPU stuff, maybe a single virtio device<br>
would work, with a small number of shared memory arenas but multiple<br>
virtio queues; each (set of) queues would represent a subdevice (say<br>
a bunch of queues for the GPU another bunch for the CODEC etc).</blockquote=
><div><br></div><div>Well, if one device definition works well with both ba=
ndwidth regimes and has better latency properties,</div><div>I like having =
the one definition better.</div><div><br></div><div>Along these lines, I wo=
uld also be open to not putting up a new standard,</div><div>and revising v=
irtio-vsock to incorporate all the unique parts of the features proposed:</=
div><div>dropping socket API requirement from guest/host,</div><div>device =
enumeration, operation via ping+shared memory,</div><div>and callback-based=
 operation with device definitions in the shared libraries.</div><div><br><=
/div><div>The way we&#39;re approaching GPU, with the workloads we tend to =
run</div><div>(just UI drawing, or in 3d apps, not too many draw calls per =
second / limited by host GPU doing work),</div><div>still having one virtqu=
eue seems fine as it&#39;s only used for kick</div><div>(API call parameter=
s themselves would also live in shared memory),</div><div>though there are =
probably workloads that benefit from having one virtqueue per &quot;instanc=
e&quot;.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
Dave<br>
<br>
&gt; The part of the intro in there that is relevant to the current thread:=
<br>
&gt; <br>
&gt; &quot;&quot;&quot;<br>
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
&gt; not things are portable.=C2=A0 virtio-user provides a device enumerati=
on<br>
&gt; mechanism<br>
&gt; to better control this.<br>
&gt; <br>
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
e of<br>
&gt; sockets<br>
&gt; API for transport; shared memory cannot be used, arbitrary strings can=
 be<br>
&gt; passed without an designation of the device/driver being run de-facto,=
 and<br>
&gt; the<br>
&gt; guest must have additional machinery to handle socket APIs.=C2=A0 In a=
ddition, on<br>
&gt; the host, sockets are only dependable on Linux, with less predictable<=
br>
&gt; behavior<br>
&gt; from Windows/macOS regarding Unix sockets.=C2=A0 Waiting for socket tr=
affic on<br>
&gt; the<br>
&gt; host also requires a poll() loop, which is suboptimal for latency.=C2=
=A0 With<br>
&gt; virtio-user, only the bare set of standard driver calls<br>
&gt; (open/close/ioctl/mmap/read) is needed, and RAM is a more universal<br=
>
&gt; transport<br>
&gt; abstraction.=C2=A0 We also explicitly spec out callbacks on host that =
are<br>
&gt; triggered<br>
&gt; by virtqueue messages, which results in lower latency and makes it eas=
y to<br>
&gt; dispatch to a particular device implementation without polling.<br>
&gt; <br>
&gt; &quot;&quot;&quot;<br>
&gt; <br>
&gt; On Tue, Feb 12, 2019 at 6:03 AM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, Feb 12, 2019 at 02:47:41PM +0100, Cornelia Huck wrote:<br=
>
&gt; &gt; &gt; On Tue, 12 Feb 2019 11:25:47 +0000<br>
&gt; &gt; &gt; &quot;Dr. David Alan Gilbert&quot; &lt;<a href=3D"mailto:dgi=
lbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; * Roman Kiryanov (<a href=3D"mailto:rkir@google.com" ta=
rget=3D"_blank">rkir@google.com</a>) wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Our long term goal is to have as few ker=
nel drivers as possible<br>
&gt; &gt; and to move<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &quot;drivers&quot; into userspace. If w=
e go with the virtqueues, is there<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; general a purpose<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; device/driver to talk between our host a=
nd guest to support<br>
&gt; &gt; custom hardware<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; (with own blobs)?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; The challenge is to answer the following ques=
tion:<br>
&gt; &gt; &gt; &gt; &gt; &gt; how to do this without losing the benefits of=
 standartization?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; We looked into UIO and it still requires some kern=
el driver to tell<br>
&gt; &gt; &gt; &gt; &gt; where the device is, it also has limitations on sh=
aring a device<br>
&gt; &gt; &gt; &gt; &gt; between processes. The benefit of standardization =
could be in<br>
&gt; &gt; avoiding<br>
&gt; &gt; &gt; &gt; &gt; everybody writing their own UIO drivers for virtua=
l devices.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Our emulator uses a battery, sound, accelerometer =
and more. We need<br>
&gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; support all of this. I looked into the spec, &quot=
;5 Device types&quot;, and<br>
&gt; &gt; &gt; &gt; &gt; seems &quot;battery&quot; is not there. We can inv=
ent our own drivers but we<br>
&gt; &gt; see<br>
&gt; &gt; &gt; &gt; &gt; having one flexible driver is a better idea.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Can you group these devices together at all in their re=
quirements?<br>
&gt; &gt; &gt; &gt; For example, battery and accelerometers (to me) sound l=
ike<br>
&gt; &gt; low-bandwidth<br>
&gt; &gt; &gt; &gt; &#39;sensors&#39; with a set of key,value pairs that up=
date occasionally<br>
&gt; &gt; &gt; &gt; and a limited (no?) amount of control from the VM-&gt;h=
ost.<br>
&gt; &gt; &gt; &gt; A &#39;virtio-values&#39; device that carried a string =
list of keys that it<br>
&gt; &gt; &gt; &gt; supported might make sense and be enough for at least t=
wo of your<br>
&gt; &gt; &gt; &gt; device types.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Maybe not a &#39;virtio-values&#39; device -- but a &#39;vir=
tio-sensors&#39; device<br>
&gt; &gt; &gt; looks focused enough without being too inflexible. It can ea=
sily<br>
&gt; &gt; &gt; advertise its type (battery, etc.) and therefore avoid the m=
ismatch<br>
&gt; &gt; &gt; problem that a too loosely defined device would be susceptib=
le to.<br>
&gt; &gt;<br>
&gt; &gt; Isn&#39;t virtio-vsock/vhost-vsock a good fit for this kind of ge=
neral<br>
&gt; &gt; string passing? People seem to use it exactly for this.<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Yes, I realize that a guest could think it is usin=
g the same device<br>
&gt; &gt; as<br>
&gt; &gt; &gt; &gt; &gt; the host advertised (because strings matched) whil=
e it is not. We<br>
&gt; &gt; &gt; &gt; &gt; control both the host and the guest and we can liv=
e with this.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The problem is that this is not true for the general case if=
 you have a<br>
&gt; &gt; &gt; standardized device type. It must be possible in theory to s=
witch to an<br>
&gt; &gt; &gt; alternative implementation of the device or the driver, as l=
ong as they<br>
&gt; &gt; &gt; conform to the spec. I think a more concretely specified dev=
ice type<br>
&gt; &gt; &gt; (like the suggested virtio-values or virtio-sensors) is need=
ed for that.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ------------------------------------------------------------=
---------<br>
&gt; &gt; &gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubsc=
ribe@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.o=
asis-open.org</a><br>
&gt; &gt; &gt; For additional commands, e-mail: <a href=3D"mailto:virtio-de=
v-help@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-=
open.org</a><br>
&gt; &gt;<br>
<br>
<br>
<br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
</blockquote></div></div>

--0000000000005b0e570581b5a4f0--
