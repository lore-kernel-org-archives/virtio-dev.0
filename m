Return-Path: virtio-dev-return-5473-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8C1F985D75
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 15:32:05 +0000 (UTC)
MIME-Version: 1.0
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm> <20190212082555-mutt-send-email-mst@kernel.org>
 <CAEkmjvX=qMWNr2v-fELh5VFRhfFHcjQpmYPUMSTT6QNFfmLqbQ@mail.gmail.com>
 <20190219071756.f5qayejwls66jjhb@sirius.home.kraxel.org> <CAEkmjvXpAc1KZpYvfQa8jPzrh0MxpHNGPZ1LAH=5nQyRNCaTUw@mail.gmail.com>
 <20190220065152.44xv26wjtopkdnu2@sirius.home.kraxel.org>
In-Reply-To: <20190220065152.44xv26wjtopkdnu2@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Wed, 20 Feb 2019 07:31:53 -0800
Message-ID: <CAEkmjvVcCYYk_ssmU+F19qMbgMmZquhMqmfhV6pwtBfeBEjqJA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000056817e0582550fd3"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000056817e0582550fd3
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 19, 2019 at 10:52 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > However, dma-buf seems to require either a Linux kernel or a Linux host.
>
> Sure.  They allow passing buffers from one linux driver to another
> without copying the data.
>
> > Dma-bufs aren't also 1:1 with Vulkan host visible memory pointers,
> > or v4l2 codec buffers, or ffmpeg codec buffers, etc.
>
> Some v4l2 drivers have dma-buf support, so you can pass buffers from
> v4l2 to (for example) gpu drivers that way.
>
> > The proposed device would be able to expose memory for direct access in a
> > way that
> > does not couple to dma-buf which is highly desirable for our use case.
> > Using the ping/event messages, even win32 handles and general opaque fds
> > can be passed from host to guest and back.
> >
> > You can think of the proposed device as a 'virtio-dmabuf' that
> > tries to expose shareable memory in a way that disregards implementation
> > details of
> > guest and host kernels.
>
> That would probably look alot like virtio-gpu with only the resource
> handling.  virtio-gpu fundamentally are just buffers.
>
>
This plus new transport makes me wonder if we can have something like a
transport/device pair
where the transport makes it easy to work directly off host memory pci bar,
and the device is virtio-gpu except really just buffers.
We'd really like to go for something like this.

Also virtio-dmabuf would be a pretty bad name.  dma-bufs are not a
> virtio concept, they are a linux concept.  They can be used by linux
> guests, to pass buffers from/to virtio-gpu (note: I'm still busy adding
> driver support for that).  They can be used by linux hosts, to pass
> buffers (with udmabuf help) from qemu to other processes/devices
> (details are still to be hashed out).
>
>
Got it, that sounds pretty interesting.


> Non-linux systems obviously need something else for the job.  The
> guest/host implementation details don't affect the virtio-gpu specs
> though.


While we're talking about this: what is your plan for virtio-gpu
implementations for non-Linux guests/hosts?


>
>
cheers,
>   Gerd
>
>

--00000000000056817e0582550fd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 19, 2019 at 10:52 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =
Hi,<br>
<br>
&gt; However, dma-buf seems to require either a Linux kernel or a Linux hos=
t.<br>
<br>
Sure.=C2=A0 They allow passing buffers from one linux driver to another<br>
without copying the data.<br>
<br>
&gt; Dma-bufs aren&#39;t also 1:1 with Vulkan host visible memory pointers,=
<br>
&gt; or v4l2 codec buffers, or ffmpeg codec buffers, etc.<br>
<br>
Some v4l2 drivers have dma-buf support, so you can pass buffers from<br>
v4l2 to (for example) gpu drivers that way.<br>
<br>
&gt; The proposed device would be able to expose memory for direct access i=
n a<br>
&gt; way that<br>
&gt; does not couple to dma-buf which is highly desirable for our use case.=
<br>
&gt; Using the ping/event messages, even win32 handles and general opaque f=
ds<br>
&gt; can be passed from host to guest and back.<br>
&gt; <br>
&gt; You can think of the proposed device as a &#39;virtio-dmabuf&#39; that=
<br>
&gt; tries to expose shareable memory in a way that disregards implementati=
on<br>
&gt; details of<br>
&gt; guest and host kernels.<br>
<br>
That would probably look alot like virtio-gpu with only the resource<br>
handling.=C2=A0 virtio-gpu fundamentally are just buffers.<br>
<br></blockquote><div>=C2=A0</div><div>This plus new transport makes me won=
der if we can have something like a transport/device pair</div><div>where t=
he transport makes it easy to work directly off host memory pci bar,</div><=
div>and the device is virtio-gpu except really just buffers.</div><div>We&#=
39;d really like to go for something like this.</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Also virtio-dmabuf would be a pretty bad name.=C2=A0 dma-bufs are not a<br>
virtio concept, they are a linux concept.=C2=A0 They can be used by linux<b=
r>
guests, to pass buffers from/to virtio-gpu (note: I&#39;m still busy adding=
<br>
driver support for that).=C2=A0 They can be used by linux hosts, to pass<br=
>
buffers (with udmabuf help) from qemu to other processes/devices<br>
(details are still to be hashed out).<br>
<br></blockquote><div><br></div><div>Got it, that sounds pretty interesting=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Non-linux systems obviously need something else for the job.=C2=A0 The<br>
guest/host implementation details don&#39;t affect the virtio-gpu specs<br>
though.</blockquote><div><br></div><div>While we&#39;re talking about this:=
 what is your plan for virtio-gpu implementations for non-Linux guests/host=
s?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--00000000000056817e0582550fd3--
