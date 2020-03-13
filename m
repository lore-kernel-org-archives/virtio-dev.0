Return-Path: virtio-dev-return-6947-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2B55985FEB
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Mar 2020 10:27:06 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Fri, 13 Mar 2020 11:27:01 +0100
Message-ID: <6194402.K2JlShyGXD@os-lin-dmo>
In-Reply-To: <CAAFQd5BdS2oT+vgM3Qg64wPqWdPRi1uE6ZmOPwXwudv==3JQVA@mail.gmail.com>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <12620787.dW097sEU6C@os-lin-dmo> <CAAFQd5BdS2oT+vgM3Qg64wPqWdPRi1uE6ZmOPwXwudv==3JQVA@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Tomasz Figa <tfiga@chromium.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, dstaessens@chromium.org, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Tomasz,

On Freitag, 13. M=E4rz 2020 11:05:35 CET Tomasz Figa wrote:
> On Thu, Mar 12, 2020 at 12:48 PM Dmitry Sepp
>=20
> <dmitry.sepp@opensynergy.com> wrote:
> > Hi Hans,
> >=20
> > One more thing:
> > > GFP_DMA? That's unusual. I'd expect GFP_DMA32. All V4L2 drivers use
> > > that.
> >=20
> > GFP_DMA32 had no effect for me on arm64. Probably I need to recheck.
>=20
> What's the reason to use any specific GFP flags at all? GFP_DMA(32)
> memory in the guest would typically correspond to host pages without
> any specific location guarantee.
>=20

Typically, but not always, especially for non x86. Say, some platforms don'=
t=20
have IOMMUs for codec devices and those devices require physically contig l=
ow=20
memory. We had to find a way to handle that.

Best regards,
Dmitry.

> Best regards,
> Tomasz
>=20
> > Best regards,
> > Dmitry.
> >=20
> > On Donnerstag, 12. M=E4rz 2020 11:18:26 CET Hans Verkuil wrote:
> > > On 3/12/20 11:15 AM, Dmitry Sepp wrote:
> > > > Hi Hans,
> > > >=20
> > > > Thank you for your great detailed review!
> > > >=20
> > > > I won't provide inline answers as your comments totally make sense.
> > > > There
> > > > is>
> > > >=20
> > > > only one thing I want to mention:
> > > >>> + struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES]=
;
> > > >>=20
> > > >> Why is this virtio specific? Any reason for not using
> > > >> VIDEO_MAX_PLANES?
> > > >=20
> > > > I'd say this is because VIDEO_MAX_PLANES does not exist outside of =
the
> > > > Linux OS, so for whatever other system we need a virtio specific
> > > > definition.
> > >=20
> > > OK, good reason :-)
> > >=20
> > > It's probably a good thing to add a comment where
> > > VIRTIO_VIDEO_MAX_PLANES is defined that explains this.
> > >=20
> > > Regards,
> > >=20
> > >       Hans



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

