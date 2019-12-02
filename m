Return-Path: virtio-dev-return-6444-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FED2985C17
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 17:24:44 +0000 (UTC)
MIME-Version: 1.0
References: <20191128131941.25069-1-kraxel@redhat.com> <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
 <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org>
In-Reply-To: <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Mon, 2 Dec 2019 09:24:31 -0800
Message-ID: <CAEkmjvW2LbWSuSixU_YWziFjfMw0pLW-EzCAoGvJ8Er34VkZ1Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: multipart/alternative; boundary="000000000000ef7de30598bbdaa0"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matti Moell <Matti.Moell@opensynergy.com>, virtio-dev@lists.oasis-open.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000ef7de30598bbdaa0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Interesting; what's the use case for this? Do we already have a mechanism
to import memory to virtio-gpu via importing a bo handle from somewhere
else?

On Thu, Nov 28, 2019 at 9:37 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Thu, Nov 28, 2019 at 07:04:23PM +0100, Matti Moell wrote:
> > Hi Gerd,
> >
> > I really like this!
> >
> > On 28.11.19 14:19, Gerd Hoffmann wrote:
> > > @@ -186,6 +211,7 @@ \subsubsection{Device Operation: Request
> header}\label{sec:Device Types / GPU De
> > >           VIRTIO_GPU_CMD_GET_CAPSET_INFO,
> > >           VIRTIO_GPU_CMD_GET_CAPSET,
> > >           VIRTIO_GPU_CMD_GET_EDID,
> > > +        VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
> > Shouldn't there also the RESOURCE_CREATE_3D_SHARED? I know that 3D isn'=
t
> > speced here but it looks awkward not to reserve it.
>
> Yep, none of the 3D commands is in the specs, thats why
> RESOURCE_CREATE_3D_SHARED isn't there too (but, yes, it exists).
>
> Guess it might be a good idea to at least list the commands,
> but that is something for a separate patch ...
>
> cheers,
>   Gerd
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000ef7de30598bbdaa0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Interesting; what&#39;s the use case for this? Do we alrea=
dy have a mechanism to import memory to virtio-gpu via importing a bo handl=
e from somewhere else?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Nov 28, 2019 at 9:37 PM Gerd Hoffmann &lt;<a =
href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Nov 28, 2019 at =
07:04:23PM +0100, Matti Moell wrote:<br>
&gt; Hi Gerd,<br>
&gt; <br>
&gt; I really like this!<br>
&gt; <br>
&gt; On 28.11.19 14:19, Gerd Hoffmann wrote:<br>
&gt; &gt; @@ -186,6 +211,7 @@ \subsubsection{Device Operation: Request head=
er}\label{sec:Device Types / GPU De<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_CMD_GET_CAPSET=
_INFO,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_CMD_GET_CAPSET=
,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_CMD_GET_EDID,<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SH=
ARED,<br>
&gt; Shouldn&#39;t there also the RESOURCE_CREATE_3D_SHARED? I know that 3D=
 isn&#39;t<br>
&gt; speced here but it looks awkward not to reserve it.<br>
<br>
Yep, none of the 3D commands is in the specs, thats why<br>
RESOURCE_CREATE_3D_SHARED isn&#39;t there too (but, yes, it exists).<br>
<br>
Guess it might be a good idea to at least list the commands,<br>
but that is something for a separate patch ...<br>
<br>
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
</blockquote></div>

--000000000000ef7de30598bbdaa0--

