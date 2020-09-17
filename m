Return-Path: virtio-dev-return-7785-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E072986007
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Sep 2020 00:16:47 +0000 (UTC)
MIME-Version: 1.0
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
 <20200902210847.2689-10-gurchetansingh@chromium.org> <20200909065536.c5rfbmd2rlpwrpn6@sirius.home.kraxel.org>
In-Reply-To: <20200909065536.c5rfbmd2rlpwrpn6@sirius.home.kraxel.org>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed, 16 Sep 2020 17:16:31 -0700
Message-ID: <CAAfnVBmmwUf8GAaG2qDiqtP-0JPu-wA+D82x=rHUCfg7QU7eng@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 09/23] virtio-gpu api: blob resources
Content-Type: multipart/alternative; boundary="000000000000930ac705af774cc8"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000930ac705af774cc8
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 8, 2020 at 11:55 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > @@ -100,7 +102,7 @@ struct drm_virtgpu_resource_info {
> >       __u32 bo_handle;
> >       __u32 res_handle;
> >       __u32 size;
> > -     __u32 stride;
> > +     __u32 blob_mem;
> >  };
>
> Huh?  This is not in the virtio spec update proposed.
>
> >  struct drm_virtgpu_3d_box {
> > @@ -117,6 +119,8 @@ struct drm_virtgpu_3d_transfer_to_host {
> >       struct drm_virtgpu_3d_box box;
> >       __u32 level;
> >       __u32 offset;
> > +     __u32 stride;
> > +     __u32 layer_stride;
> >  };
>
> Same here.
>
> >  struct drm_virtgpu_3d_transfer_from_host {
> > @@ -124,6 +128,8 @@ struct drm_virtgpu_3d_transfer_from_host {
> >       struct drm_virtgpu_3d_box box;
> >       __u32 level;
> >       __u32 offset;
> > +     __u32 stride;
> > +     __u32 layer_stride;
> >  };


> And here.
>

Separated out the virtio and DRM api changes, as per your recommendation.
The virtio spec changes should match v6 of the proposed spec.  Explanations
for these specific DRM changes here are in patch 16 & patch 17 of the v3
implementation.


> take care,
>   Gerd
>
> PS: cherry-picked patches 1-3 into drm-misc-next.
>
>

--000000000000930ac705af774cc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 8, 2020 at 11:55 PM Gerd =
Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 H=
i,<br>
<br>
&gt; @@ -100,7 +102,7 @@ struct drm_virtgpu_resource_info {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 bo_handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 res_handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 size;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__u32 stride;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 blob_mem;<br>
&gt;=C2=A0 };<br>
<br>
Huh?=C2=A0 This is not in the virtio spec update proposed.<br>
<br>
&gt;=C2=A0 struct drm_virtgpu_3d_box {<br>
&gt; @@ -117,6 +119,8 @@ struct drm_virtgpu_3d_transfer_to_host {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_virtgpu_3d_box box;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 level;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 stride;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 layer_stride;<br>
&gt;=C2=A0 };<br>
<br>
Same here.<br>
<br>
&gt;=C2=A0 struct drm_virtgpu_3d_transfer_from_host {<br>
&gt; @@ -124,6 +128,8 @@ struct drm_virtgpu_3d_transfer_from_host {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_virtgpu_3d_box box;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 level;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 stride;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 layer_stride;<br>
&gt;=C2=A0 };=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
And here.<br></blockquote><div><br></div><div>Separated out the virtio and =
DRM api changes, as per your recommendation.=C2=A0 The virtio spec changes =
should match v6 of the proposed spec.=C2=A0 Explanations for these specific=
 DRM changes here are in patch 16 &amp; patch 17 of the v3 implementation.=
=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
take care,<br>
=C2=A0 Gerd<br>
<br>
PS: cherry-picked patches 1-3 into drm-misc-next.<br>
<br>
</blockquote></div></div>

--000000000000930ac705af774cc8--

