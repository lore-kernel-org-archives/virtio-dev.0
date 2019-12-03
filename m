Return-Path: virtio-dev-return-6455-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 098F9986032
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Dec 2019 17:20:19 +0000 (UTC)
MIME-Version: 1.0
References: <20191128131941.25069-1-kraxel@redhat.com> <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
 <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org> <CAEkmjvW2LbWSuSixU_YWziFjfMw0pLW-EzCAoGvJ8Er34VkZ1Q@mail.gmail.com>
 <20191203093322.gu2zmmgzuqekho4n@sirius.home.kraxel.org>
In-Reply-To: <20191203093322.gu2zmmgzuqekho4n@sirius.home.kraxel.org>
From: Frank Yang <lfy@google.com>
Date: Tue, 3 Dec 2019 09:20:06 -0800
Message-ID: <CAEkmjvWVC_pyBKyco_hKsj7gBW1LW1amBWORAQBkGaUVzCCSdw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: multipart/alternative; boundary="000000000000f6aaa10598cfe8a7"
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matti Moell <Matti.Moell@opensynergy.com>, virtio-dev@lists.oasis-open.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000f6aaa10598cfe8a7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2019 at 1:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Dec 02, 2019 at 09:24:31AM -0800, Frank Yang wrote:
> > Interesting; what's the use case for this?
>
> Mostly reduce data copying.
>
> > Do we already have a mechanism
> > to import memory to virtio-gpu via importing a bo handle from somewhere
> > else?
>
> Inside the guest?  Import is not working yet, that needs another update
> (blob resources) due to current virtio-gpu resources requiring a format
> at creation time and dmabufs not having one.
>
>
Gotcha, I was just poking around related code and it looked like I could
use a resource w/ R8 format and width =3D bytes. Blob resources would be a
more proper way then :)


> See https://www.kraxel.org/blog/2019/11/virtio-gpu-status-and-plans/ for
> some background.
>
> Exporting virtio-gpu resources works in the drm-misc-next branch, should
> land in mainline this merge window (i.e. 5.5-rc1).
>
> cheers,
>   Gerd
>
>

--000000000000f6aaa10598cfe8a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 at 1:33 AM Gerd H=
offmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, D=
ec 02, 2019 at 09:24:31AM -0800, Frank Yang wrote:<br>
&gt; Interesting; what&#39;s the use case for this?<br>
<br>
Mostly reduce data copying.<br>
<br>
&gt; Do we already have a mechanism<br>
&gt; to import memory to virtio-gpu via importing a bo handle from somewher=
e<br>
&gt; else?<br>
<br>
Inside the guest?=C2=A0 Import is not working yet, that needs another updat=
e<br>
(blob resources) due to current virtio-gpu resources requiring a format<br>
at creation time and dmabufs not having one.<br>
<br></blockquote><div><br></div><div>Gotcha, I was just poking around relat=
ed code and it looked like I could use a resource w/ R8 format and width =
=3D bytes. Blob resources would be a more proper way then :)</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
See <a href=3D"https://www.kraxel.org/blog/2019/11/virtio-gpu-status-and-pl=
ans/" rel=3D"noreferrer" target=3D"_blank">https://www.kraxel.org/blog/2019=
/11/virtio-gpu-status-and-plans/</a> for<br>
some background.<br>
<br>
Exporting virtio-gpu resources works in the drm-misc-next branch, should<br=
>
land in mainline this merge window (i.e. 5.5-rc1).<br>
<br>
cheers,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div></div>

--000000000000f6aaa10598cfe8a7--

