Return-Path: virtio-dev-return-5460-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E512C9812AE
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 15:54:17 +0000 (UTC)
MIME-Version: 1.0
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAOGAQepzNSZ5c+tB+e-sYRzQMag2Pr+H0ToJhtd-4mLubY9xeA@mail.gmail.com>
 <20190212112547.GC2715@work-vm> <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org> <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm> <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
In-Reply-To: <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 19 Feb 2019 07:54:04 -0800
Message-ID: <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d069980582414095"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000d069980582414095
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 18, 2019 at 11:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > As another example, consider camera / video playback. I've heard that the
> > way to approach this
> > is to build v4l2 and build a virtio-v4l2 layer underneath.
>
> That would be one option, yes.  virtio-v4l2 is a pretty bad name though,
> I'd name it virtio-camera or virtio-media (if you want both capture and
> playback) and you don't have to mimic the v4l2 api at virtio level.
>

I think a big thing that's different about our context is that,
there are issues when running on non-Linux hosts, non-QEMU hypervisors or
non-Linux kernels that isn't commonly encountered
in the virtio community.

I agree that using v4l2 API itself would bake in all sorts of design
decisions
that might not be the best idea for a given host-side codec or camera
library.


> That might simlify pass-through of v4l2 host devices, but isn't
> necessarily the best choice long-term.
>
>
Right, but if we're not emulating at the v4l2 api level, then it starts
looking a lot
like the proposed virtio-hostmem; there's a common pattern of
direct access to host memory and a message to notify either guest or host
that there is something interesting to do with the host memory,
that we'd like to capture with the proposed spec.

In addition, we'd like to do things in a way
that allows virtual drivers/devices to be defined in a manner that doesn't
require the guest kernel to be updated.

For us, maintaining and upgrading guest kernels in response to tweaks to
virtual devices
is much more work than modifying a userspace shared library driver that
communicates to some virtio driver. Thus far, it's suggested that socket or
network devices
be used for this, because they are general guest/host communication,
but they don't have the portability or performance characteristics we want.
We'd want to benefit from being able to run reliably on hosts other than
Linux (which makes Unix sockets riskier),
with RAM being the underlying buffer storage.

 Alternatively emulate something existing, USB Video Class device for
> example.
>

Using usb or faking some other transport generally also involves being
coupled
to that set of kernel code in the guest, which introduces complexity and
overhead.
Exposing RAM can be a more flexible abstraction.


> > However, this would mean either assuming v4l2 on host which is not
> > portable to non-Linux, or requiring additional translation layers
> > between v4l2 in the guest and $library on the host.
>
> Well, sure, you need to wire up the host side somehow anyway.  Emulate
> something virtual, feed the guest camera with image data from the host
> camera, ...
>
>
Right, but we also don't want to couple the implementations together.
As specified in the example, the implementation of how the guest camera and
host camera work together
is defined in areas away from the guest kernel.
As long as there are no conflicting device ID's in the configuration space,
we can also tell when a particular usage is supported.

> With the proposed spec, a more general 'codec' device can be
> > implemented, tested on actual programs on multiple guests/hosts
> > easily, and then, if it makes sense, "promoted" to a new
> > "virtio-codec" device type.
>
> I fail to see how a more general device avoids host-specific code (to
> talk to the host camera, for example).
>
>
Agreed, no, it doesn't; but it facilitates the possibility of the same
host-specific code
to be defined in a different library from QEMU or whatever VMM is being
used.

To update driver/device functionality, ideally we want to ship two small
shared libraries,
one to guest userspace and one to plug in to the host VMM.


> cheers,
>   Gerd
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000d069980582414095
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 18, 2019 at 11:54 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =
Hi,<br>
<br>
&gt; As another example, consider camera / video playback. I&#39;ve heard t=
hat the<br>
&gt; way to approach this<br>
&gt; is to build v4l2 and build a virtio-v4l2 layer underneath.<br>
<br>
That would be one option, yes.=C2=A0 virtio-v4l2 is a pretty bad name thoug=
h,<br>
I&#39;d name it virtio-camera or virtio-media (if you want both capture and=
<br>
playback) and you don&#39;t have to mimic the v4l2 api at virtio level.<br>=
</blockquote><div><br></div><div>I think a big thing that&#39;s different a=
bout our context is that,</div><div>there are issues when running on non-Li=
nux hosts, non-QEMU hypervisors or non-Linux kernels that isn&#39;t commonl=
y encountered</div><div>in the virtio community.</div><div><br></div><div>I=
 agree that using v4l2 API itself would bake in all sorts of design decisio=
ns</div><div>that might not be the best idea for a given host-side codec or=
 camera library.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
That might simlify pass-through of v4l2 host devices, but isn&#39;t<br>
necessarily the best choice long-term.<br>
<br></blockquote><div>=C2=A0</div><div>Right, but if we&#39;re not emulatin=
g at the v4l2 api level, then it starts looking a lot</div><div>like the pr=
oposed virtio-hostmem; there&#39;s a common pattern of</div><div>direct acc=
ess to host memory and a message to notify either guest or host</div><div>t=
hat there is something interesting to do with the host memory,</div><div>th=
at we&#39;d like to capture with the proposed spec.</div><div><br></div><di=
v>In addition, we&#39;d like to do things in a way</div><div>that allows vi=
rtual drivers/devices to be defined in a manner that doesn&#39;t</div><div>=
require the guest kernel to be updated.</div><div><br></div><div>For us, ma=
intaining and upgrading guest kernels in response to tweaks to virtual devi=
ces</div><div>is much more work than modifying a userspace shared library d=
river that</div><div>communicates to some virtio driver. Thus far, it&#39;s=
 suggested that socket or network devices</div><div>be used for this, becau=
se they are general guest/host communication,</div><div>but they don&#39;t =
have the portability or performance characteristics we want.</div><div>We&#=
39;d want to benefit from being able to run reliably on hosts other than Li=
nux (which makes Unix sockets riskier),</div><div>with RAM being the underl=
ying buffer storage.</div><div><br></div><div></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">=C2=A0Alternatively emulate something existing, =
USB Video Class device for<br>
example.=C2=A0<br></blockquote><div><br></div><div>Using usb or faking some=
 other transport generally also involves being coupled</div><div>to that se=
t of kernel code in the guest, which introduces complexity and overhead.</d=
iv><div>Exposing RAM can be a more flexible abstraction.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; However, this would mean either assuming v4l2 on host which is not<br>
&gt; portable to non-Linux, or requiring additional translation layers<br>
&gt; between v4l2 in the guest and $library on the host.<br>
<br>
Well, sure, you need to wire up the host side somehow anyway.=C2=A0 Emulate=
<br>
something virtual, feed the guest camera with image data from the host<br>
camera, ...<br>
<br></blockquote><div><br></div><div>Right, but we also don&#39;t want to c=
ouple the implementations together.</div><div>As specified in the example, =
the implementation of how the guest camera and host camera work together</d=
iv><div>is defined in areas away from the guest kernel.</div><div>As long a=
s there are no conflicting device ID&#39;s in the configuration space,</div=
><div>we can also tell when a particular usage is supported.</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; With the proposed spec, a more general &#39;codec&#39; device can be<b=
r>
&gt; implemented, tested on actual programs on multiple guests/hosts<br>
&gt; easily, and then, if it makes sense, &quot;promoted&quot; to a new<br>
&gt; &quot;virtio-codec&quot; device type.<br>
<br>
I fail to see how a more general device avoids host-specific code (to<br>
talk to the host camera, for example).<br>
<br></blockquote><div>=C2=A0</div><div>Agreed, no, it doesn&#39;t; but it f=
acilitates the possibility of the same host-specific code</div><div>to be d=
efined in a different library from QEMU or whatever VMM is being used.</div=
><div><br></div><div>To update driver/device functionality, ideally we want=
 to ship two small shared libraries,</div><div>one to guest userspace and o=
ne to plug in to the host VMM.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
cheers,<br>
=C2=A0 Gerd<br>
<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div></div>

--000000000000d069980582414095--
