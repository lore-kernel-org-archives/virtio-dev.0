Return-Path: virtio-dev-return-5474-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 192B7985D74
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 15:32:14 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org> <CAEkmjvVA_pxL7FyR4p+u5LH4JfBNOFgAJf-B3573OM58pAD7+A@mail.gmail.com>
 <20190220070213.3uetjgzzlf5qojan@sirius.home.kraxel.org>
In-Reply-To: <20190220070213.3uetjgzzlf5qojan@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Wed, 20 Feb 2019 07:32:01 -0800
Message-ID: <CAEkmjvWEBfd1=JCkavhwdtEUSiP-Vy+RfLcLQLgaRXS+dN9PYw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d56df40582550f8b"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000d56df40582550f8b
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 19, 2019 at 11:02 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> > > > In general though, this means that the ideal usage of host pointers
> would
> > > > be to set a few regions up front for certain purposes, then share
> that
> > > out
> > > > amongst other device contexts. This also facilitates sharing the
> memory
> > > > between guest processes, which is useful for implementing things like
> > > > compositors.
> > >
> > > Guest processes in the same VM or in different VMs?
> > >
> >
> >
> > The guest processes are in the same VM.
> > Are you also considering the usage in different VMs?
>
> No, I'm just asking whenever that is important to you.
>
> For communication between guest processes within the same VM I don't
> really see a need to involve the hypervisor ...
>
>
Right, once the host memory is set up we can rely on purely guest side stuff
map sub-regions of it.


> > > This also features heavily for our "virtio userspace" thing.
> > > > Since this is a common pattern, should this sharing concept be
> > > standardized
> > > > somehow? I.e., should there be a standard way to send
> Shmid/offset/size
> > > to
> > > > other devices, or have that be a standard struct in the hypervisor?
> > >
> > > Same question: other devices of the same VM?
> > >
> >
> > Yes, also, other devices of the same VM.
>
> So why involve the hypervisor here?  The guest can handle that on its
> own.  Passing an image data buffer from the usb webcam to the intel gpu
> for display (on bare metal) isn't fundamentally different from passing a
> buffer from virtio-camera to virtio-gpu (in a VM).  Linux guests will
> use dma-bufs for that, other OSes probably something else.
>

That's true that it can be handled purely in the guest layers,
if there is an existing interface in the guest
to pass the proposed host memory id's / offsets / sizes
between them.

However, for the proposed host memory sharing spec,
would there be a standard way to share the host memory across
different virtio devices without relying on Linux dmabufs?


> cheers,
>   Gerd
>
>

--000000000000d56df40582550f8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 19, 2019 at 11:02 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; &g=
t; &gt; In general though, this means that the ideal usage of host pointers=
 would<br>
&gt; &gt; &gt; be to set a few regions up front for certain purposes, then =
share that<br>
&gt; &gt; out<br>
&gt; &gt; &gt; amongst other device contexts. This also facilitates sharing=
 the memory<br>
&gt; &gt; &gt; between guest processes, which is useful for implementing th=
ings like<br>
&gt; &gt; &gt; compositors.<br>
&gt; &gt;<br>
&gt; &gt; Guest processes in the same VM or in different VMs?<br>
&gt; &gt;<br>
&gt; <br>
&gt; <br>
&gt; The guest processes are in the same VM.<br>
&gt; Are you also considering the usage in different VMs?<br>
<br>
No, I&#39;m just asking whenever that is important to you.<br>
<br>
For communication between guest processes within the same VM I don&#39;t<br=
>
really see a need to involve the hypervisor ...<br>
<br></blockquote><div>=C2=A0</div><div>Right, once the host memory is set u=
p we can rely on purely guest side stuff</div><div>map sub-regions of it.</=
div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; &gt; This also features heavily for our &quot;virtio userspace&quot; t=
hing.<br>
&gt; &gt; &gt; Since this is a common pattern, should this sharing concept =
be<br>
&gt; &gt; standardized<br>
&gt; &gt; &gt; somehow? I.e., should there be a standard way to send Shmid/=
offset/size<br>
&gt; &gt; to<br>
&gt; &gt; &gt; other devices, or have that be a standard struct in the hype=
rvisor?<br>
&gt; &gt;<br>
&gt; &gt; Same question: other devices of the same VM?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, also, other devices of the same VM.<br>
<br>
So why involve the hypervisor here?=C2=A0 The guest can handle that on its<=
br>
own.=C2=A0 Passing an image data buffer from the usb webcam to the intel gp=
u<br>
for display (on bare metal) isn&#39;t fundamentally different from passing =
a<br>
buffer from virtio-camera to virtio-gpu (in a VM).=C2=A0 Linux guests will<=
br>
use dma-bufs for that, other OSes probably something else.<br></blockquote>=
<div><br></div><div>That&#39;s true that it can be handled purely in the gu=
est layers,</div><div>if there is an existing interface in the guest</div><=
div>to pass the proposed host memory id&#39;s / offsets / sizes</div><div>b=
etween them.</div><div><br></div><div>However, for the proposed host memory=
 sharing spec,</div><div>would there be a standard way to share the host me=
mory across</div><div>different virtio devices without relying on Linux dma=
bufs?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--000000000000d56df40582550f8b--
