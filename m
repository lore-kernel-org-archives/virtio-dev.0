Return-Path: virtio-dev-return-5461-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADA64985C75
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 15:59:35 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm> <20190212082555-mutt-send-email-mst@kernel.org>
 <CAEkmjvX=qMWNr2v-fELh5VFRhfFHcjQpmYPUMSTT6QNFfmLqbQ@mail.gmail.com> <20190219071756.f5qayejwls66jjhb@sirius.home.kraxel.org>
In-Reply-To: <20190219071756.f5qayejwls66jjhb@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 19 Feb 2019 07:59:22 -0800
Message-ID: <CAEkmjvXpAc1KZpYvfQa8jPzrh0MxpHNGPZ1LAH=5nQyRNCaTUw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000cf48340582415342"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000cf48340582415342
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 18, 2019 at 11:18 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, Feb 12, 2019 at 08:17:13AM -0800, Frank Yang wrote:
> > In implementing a complete graphics system, shared memory objects may
> > transcend device boundaries.
> >
> > Consider for example, Android and gralloc. The media codec versus the GPU
> > rendering are commonly considered as separate devices, but they work
> better
> > if operating on a common shared memory type (gralloc buffers).
>
> Linux has dma-bufs for that (driver-api/dma-buf.rst).
>
>
Yes; I also followed a discussion around udmabuf for Vulkan host memory
sharing.

However, dma-buf seems to require either a Linux kernel or a Linux host.
Dma-bufs aren't also 1:1 with Vulkan host visible memory pointers,
or v4l2 codec buffers, or ffmpeg codec buffers, etc.

For the use case of Vulkan, it's fortunate that there is an external memory
dma buf,
but its application seems very limited to linux hosts and
host drivers that support that kind of external memory.

The proposed device would be able to expose memory for direct access in a
way that
does not couple to dma-buf which is highly desirable for our use case.
Using the ping/event messages, even win32 handles and general opaque fds
can be passed from host to guest and back.

You can think of the proposed device as a 'virtio-dmabuf' that
tries to expose shareable memory in a way that disregards implementation
details of
guest and host kernels.


> cheers,
>   Gerd
>
>

--000000000000cf48340582415342
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 18, 2019 at 11:18 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue,=
 Feb 12, 2019 at 08:17:13AM -0800, Frank Yang wrote:<br>
&gt; In implementing a complete graphics system, shared memory objects may<=
br>
&gt; transcend device boundaries.<br>
&gt; <br>
&gt; Consider for example, Android and gralloc. The media codec versus the =
GPU<br>
&gt; rendering are commonly considered as separate devices, but they work b=
etter<br>
&gt; if operating on a common shared memory type (gralloc buffers).<br>
<br>
Linux has dma-bufs for that (driver-api/dma-buf.rst).<br>
<br></blockquote><div>=C2=A0</div><div>Yes; I also followed a discussion ar=
ound udmabuf for Vulkan host memory sharing.</div><div><br></div><div>Howev=
er, dma-buf seems to require either a Linux kernel or a Linux host.</div><d=
iv>Dma-bufs aren&#39;t also 1:1 with Vulkan host visible memory pointers,</=
div><div>or v4l2 codec buffers, or ffmpeg codec buffers, etc.</div><div><br=
></div><div>For the use case of Vulkan, it&#39;s fortunate that there is an=
 external memory dma buf,</div><div>but its application seems very limited =
to linux hosts and</div><div>host drivers that support that kind of externa=
l memory.</div><div><br></div><div>The proposed device would be able to exp=
ose memory for direct access in a way that</div><div>does not couple to dma=
-buf which is highly desirable for our use case.</div><div>Using the ping/e=
vent messages, even win32 handles and general opaque fds</div><div>can be p=
assed from host to guest and back.</div><div><br></div><div>You can think o=
f the proposed device as a &#39;virtio-dmabuf&#39; that</div><div>tries to =
expose shareable memory in a way that disregards implementation details of<=
/div><div>guest and host kernels.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--000000000000cf48340582415342--
