Return-Path: virtio-dev-return-5381-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97058986026
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Feb 2019 14:47:01 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm> <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
 <20190206070350.vaonutyqljccuh5y@sirius.home.kraxel.org> <CAEkmjvUHzSx-Vr2O4MWDN4Cmqe-+dm9N6hbxg7gLu-SUUo6u6Q@mail.gmail.com>
 <20190208075703.GK16257@stefanha-x1.localdomain>
In-Reply-To: <20190208075703.GK16257@stefanha-x1.localdomain>
From: Frank Yang <lfy@google.com>
Date: Fri, 8 Feb 2019 06:46:49 -0800
Message-ID: <CAEkmjvVbmY3jzN-JZ0G_zzT0pn-Z8nQ6GVPr0LwxrU+P0fdtoQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000928bb0581630845"
Subject: Re: [virtio-dev] Memory sharing device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Roman Kiryanov <rkir@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000000928bb0581630845
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 7, 2019 at 11:57 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, Feb 06, 2019 at 07:09:36AM -0800, Frank Yang wrote:
> > I've looked at virtio-vsock and it seems general, but requires Unix
> > sockets, which is not going to work for us on Windows and not going to
> work
> > as expected on macOS (most likely). Is there anything that is similar to
> > and as portable as goldfish pipe which is more like a raw virtqueue? This
> > would then work on memory in the same process, with callbacks registered
> to
> > trigger upon transmission.
>
> virtio-vsock is independent of UNIX domain sockets.  I'm not sure what
> you mean here.
>
> I think Linaro implemented virtio-vsock inside QEMU for the Android
> emulator but I'm not sure how far they got.  Today virtio-vsock relies
> on a Linux host machine because the vhost_vsock.ko driver is used to
> integrate into the host network stack.  The Linaro implementation moved
> that into QEMU userspace (with the drawback that socket(AF_VSOCK) no
> longer works on the host and you need to talk to QEMU instead).
>
>
Thanks for the info! Since we prefer to keep things as canonical as
possible (and thus not mess with existing infrastructure; benefit being
that we can use any upstream QEMU / Linux kernel), it doesn't solve our
vsock issue. We'd also like to decouple the concept of dynamically defined
drivers/devices from the transport. Finally, when host memory is
introduced, it's also possible to be faster than a raw virtqueue for all
data. I'll send out a spec.



> Stefan
>

--0000000000000928bb0581630845
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 7, 2019 at 11:57 PM Stefa=
n Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Wed, Feb 06, 2019 at 07:09:36AM -0800, Frank Yang wrote:<br>
&gt; I&#39;ve looked at virtio-vsock and it seems general, but requires Uni=
x<br>
&gt; sockets, which is not going to work for us on Windows and not going to=
 work<br>
&gt; as expected on macOS (most likely). Is there anything that is similar =
to<br>
&gt; and as portable as goldfish pipe which is more like a raw virtqueue? T=
his<br>
&gt; would then work on memory in the same process, with callbacks register=
ed to<br>
&gt; trigger upon transmission.<br>
<br>
virtio-vsock is independent of UNIX domain sockets.=C2=A0 I&#39;m not sure =
what<br>
you mean here.<br>
<br>
I think Linaro implemented virtio-vsock inside QEMU for the Android<br>
emulator but I&#39;m not sure how far they got.=C2=A0 Today virtio-vsock re=
lies<br>
on a Linux host machine because the vhost_vsock.ko driver is used to<br>
integrate into the host network stack.=C2=A0 The Linaro implementation move=
d<br>
that into QEMU userspace (with the drawback that socket(AF_VSOCK) no<br>
longer works on the host and you need to talk to QEMU instead).<br>
<br></blockquote><div><br></div><div>Thanks for the info! Since we prefer t=
o keep things as canonical as possible (and thus not mess with existing inf=
rastructure; benefit being that we can use any upstream QEMU / Linux kernel=
), it doesn&#39;t solve our vsock issue. We&#39;d also like to decouple the=
 concept of dynamically defined drivers/devices from the transport. Finally=
, when host memory is introduced, it&#39;s also possible to be faster than =
a raw virtqueue for all data. I&#39;ll send out a spec.</div><div><br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Stefan<br>
</blockquote></div></div>

--0000000000000928bb0581630845--
