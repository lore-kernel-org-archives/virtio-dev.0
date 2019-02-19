Return-Path: virtio-dev-return-5462-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50276985C75
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 16:02:29 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org> <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com> <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org>
In-Reply-To: <20190219071222.jjebzcbh55kwlspn@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 19 Feb 2019 08:02:16 -0800
Message-ID: <CAEkmjvVA_pxL7FyR4p+u5LH4JfBNOFgAJf-B3573OM58pAD7+A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002f2c6d0582415e8c"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000002f2c6d0582415e8c
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 18, 2019 at 11:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > slots by doing so. So for Vulkan, we rely on having one large host
> visible
> > region on the host that is a single region of host shared memory. That,
> is
> > then sub-allocated for the guest. So there is no Vulkan host pointer that
>
> Yes, sub-allocating will be needed for reasonable performance.
>
> > In general though, this means that the ideal usage of host pointers would
> > be to set a few regions up front for certain purposes, then share that
> out
> > amongst other device contexts. This also facilitates sharing the memory
> > between guest processes, which is useful for implementing things like
> > compositors.
>
> Guest processes in the same VM or in different VMs?
>


The guest processes are in the same VM.
Are you also considering the usage in different VMs?
In that case, if we had to address it, we would rely on there being
an existing method on the host to map shared regions across processes,
similar to gralloc,
and use the fact that for each VM, they have a host pointer somehow,
and expose the relevant host pointer to the guest.

> This also features heavily for our "virtio userspace" thing.
> > Since this is a common pattern, should this sharing concept be
> standardized
> > somehow? I.e., should there be a standard way to send Shmid/offset/size
> to
> > other devices, or have that be a standard struct in the hypervisor?
>
> Same question: other devices of the same VM?
>

Yes, also, other devices of the same VM.
For different VMs, does the same scheme to send shmid/offset/size to other
VMs work?
Shmid's could be different and alias a common shared memory on the host,
or additional metadata could be passed at some other level
about which memory is "actually" shared.


> cheers,
>   Gerd
>
>

--0000000000002f2c6d0582415e8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 18, 2019 at 11:12 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =
Hi,<br>
<br>
&gt; slots by doing so. So for Vulkan, we rely on having one large host vis=
ible<br>
&gt; region on the host that is a single region of host shared memory. That=
, is<br>
&gt; then sub-allocated for the guest. So there is no Vulkan host pointer t=
hat<br>
<br>
Yes, sub-allocating will be needed for reasonable performance.<br>
<br>
&gt; In general though, this means that the ideal usage of host pointers wo=
uld<br>
&gt; be to set a few regions up front for certain purposes, then share that=
 out<br>
&gt; amongst other device contexts. This also facilitates sharing the memor=
y<br>
&gt; between guest processes, which is useful for implementing things like<=
br>
&gt; compositors.<br>
<br>
Guest processes in the same VM or in different VMs?<br>
=C2=A0</blockquote><div>=C2=A0</div><div>The guest processes are in the sam=
e VM.</div><div>Are you also considering the usage in different VMs?</div><=
div>In that case, if we had to address it, we would rely on there being</di=
v><div>an existing method on the host to map shared regions across processe=
s,</div><div>similar to gralloc,</div><div>and use the fact that for each V=
M, they have a host pointer somehow,</div><div>and expose the relevant host=
 pointer to the guest.</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
&gt; This also features heavily for our &quot;virtio userspace&quot; thing.=
<br>
&gt; Since this is a common pattern, should this sharing concept be standar=
dized<br>
&gt; somehow? I.e., should there be a standard way to send Shmid/offset/siz=
e to<br>
&gt; other devices, or have that be a standard struct in the hypervisor?<br=
>
<br>
Same question: other devices of the same VM?<br></blockquote><div><br></div=
><div>Yes, also, other devices of the same VM.</div><div>For different VMs,=
 does the same scheme to send shmid/offset/size to other VMs work?</div><di=
v>Shmid&#39;s could be different and alias a common shared memory on the ho=
st,</div><div>or additional metadata could be passed at some other level</d=
iv><div>about which memory is &quot;actually&quot; shared.</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--0000000000002f2c6d0582415e8c--
