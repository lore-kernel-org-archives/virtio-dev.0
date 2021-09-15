Return-Path: <virtio-dev-return-8667-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90A9A9863CB
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Sep 2021 23:39:17 +0000 (UTC)
MIME-Version: 1.0
References: <20210909013717.861-1-gurchetansingh@chromium.org>
 <20210909013717.861-9-gurchetansingh@chromium.org> <20210915055350.sgfadzktcl5bngtq@sirius.home.kraxel.org>
In-Reply-To: <20210915055350.sgfadzktcl5bngtq@sirius.home.kraxel.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 15 Sep 2021 16:39:02 -0700
Message-ID: <CAAfnVB=z80_cK_Z3Gkk1WXUopkuPiF67QNrD8O8StmijApYqcQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v1 08/12] drm/virtio: implement context
 init: stop using drv->context when creating fence
Content-Type: multipart/alternative; boundary="000000000000b5153905cc113495"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000b5153905cc113495
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 14, 2021 at 10:53 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Wed, Sep 08, 2021 at 06:37:13PM -0700, Gurchetan Singh wrote:
> > The plumbing is all here to do this.  Since we always use the
> > default fence context when allocating a fence, this makes no
> > functional difference.
> >
> > We can't process just the largest fence id anymore, since it's
> > it's associated with different timelines.  It's fine for fence_id
> > 260 to signal before 259.  As such, process each fence_id
> > individually.
>
> I guess you need to also update virtio_gpu_fence_event_process()
> then?  It currently has the strict ordering logic baked in ...
>

The update to virtio_gpu_fence_event_process was done as a preparation a
few months back:

https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/virtio/virtgpu_fence.c?id=36549848ed27c22bb2ffd5d1468efc6505b05f97



>
> take care,
>   Gerd
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000b5153905cc113495
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 14, 2021 at 10:53 PM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed,=
 Sep 08, 2021 at 06:37:13PM -0700, Gurchetan Singh wrote:<br>
&gt; The plumbing is all here to do this.=C2=A0 Since we always use the<br>
&gt; default fence context when allocating a fence, this makes no<br>
&gt; functional difference.<br>
&gt; <br>
&gt; We can&#39;t process just the largest fence id anymore, since it&#39;s=
<br>
&gt; it&#39;s associated with different timelines.=C2=A0 It&#39;s fine for =
fence_id<br>
&gt; 260 to signal before 259.=C2=A0 As such, process each fence_id<br>
&gt; individually.<br>
<br>
I guess you need to also update virtio_gpu_fence_event_process()<br>
then?=C2=A0 It currently has the strict ordering logic baked in ...<br></bl=
ockquote><div><br></div><div>The update to virtio_gpu_fence_event_process w=
as done as a preparation a few months back:<div><br></div><div><a href=3D"h=
ttps://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/virtio/virt=
gpu_fence.c?id=3D36549848ed27c22bb2ffd5d1468efc6505b05f97" target=3D"_blank=
">https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/virtio/v=
irtgpu_fence.c?id=3D36549848ed27c22bb2ffd5d1468efc6505b05f97</a></div></div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
take care,<br>
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

--000000000000b5153905cc113495--

