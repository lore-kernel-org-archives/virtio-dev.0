Return-Path: virtio-dev-return-5406-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08BB0985D18
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 16:17:26 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm> <20190212082555-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212082555-mutt-send-email-mst@kernel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 12 Feb 2019 08:17:13 -0800
Message-ID: <CAEkmjvX=qMWNr2v-fELh5VFRhfFHcjQpmYPUMSTT6QNFfmLqbQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bd43870581b4c22c"
Subject: Re: [virtio-dev] Memory sharing device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000bd43870581b4c22c
Content-Type: text/plain; charset="UTF-8"

In implementing a complete graphics system, shared memory objects may
transcend device boundaries.

Consider for example, Android and gralloc. The media codec versus the GPU
rendering are commonly considered as separate devices, but they work better
if operating on a common shared memory type (gralloc buffers).

On Tue, Feb 12, 2019 at 5:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 01:16:39PM +0000, Dr. David Alan Gilbert wrote:
> > > somehow? I.e., should there be a standard way to send
> Shmid/offset/size to
> > > other devices, or have that be a standard struct in the hypervisor?
> >
> > That I don't know how to do - because then you need a way to
> > associate different devices.
> >
> > Dave
>
> We could come up with a way maybe but why? Are there so many devices?
>
> --
> MST
>

--000000000000bd43870581b4c22c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In implementing a complete graphics system, shared memory =
objects may transcend device boundaries.<div><br></div><div>Consider for ex=
ample, Android and gralloc. The media codec versus the GPU rendering are co=
mmonly considered as separate devices, but they work better if operating on=
 a common shared memory type (gralloc buffers).</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019=
 at 5:27 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Tue, Feb 12, 2019 at 01:16:39PM +0000, Dr. David Alan Gilbert wr=
ote:<br>
&gt; &gt; somehow? I.e., should there be a standard way to send Shmid/offse=
t/size to<br>
&gt; &gt; other devices, or have that be a standard struct in the hyperviso=
r?<br>
&gt; <br>
&gt; That I don&#39;t know how to do - because then you need a way to<br>
&gt; associate different devices.<br>
&gt; <br>
&gt; Dave<br>
<br>
We could come up with a way maybe but why? Are there so many devices?<br>
<br>
-- <br>
MST<br>
</blockquote></div>

--000000000000bd43870581b4c22c--
