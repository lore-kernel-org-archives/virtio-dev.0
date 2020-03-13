Return-Path: virtio-dev-return-6944-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CEEB985FEB
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Mar 2020 10:05:50 +0000 (UTC)
MIME-Version: 1.0
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com>
 <20719772.EfDdHjke4D@os-lin-dmo> <6f8c37b1-8dc4-e3bb-01ed-4ebedaf90915@xs4all.nl>
 <12620787.dW097sEU6C@os-lin-dmo>
In-Reply-To: <12620787.dW097sEU6C@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 13 Mar 2020 11:05:35 +0100
Message-ID: <CAAFQd5BdS2oT+vgM3Qg64wPqWdPRi1uE6ZmOPwXwudv==3JQVA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, dstaessens@chromium.org, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 12, 2020 at 12:48 PM Dmitry Sepp
<dmitry.sepp@opensynergy.com> wrote:
>
> Hi Hans,
>
> One more thing:
>
> > GFP_DMA? That's unusual. I'd expect GFP_DMA32. All V4L2 drivers use tha=
t.
>
> GFP_DMA32 had no effect for me on arm64. Probably I need to recheck.
>

What's the reason to use any specific GFP flags at all? GFP_DMA(32)
memory in the guest would typically correspond to host pages without
any specific location guarantee.

Best regards,
Tomasz

> Best regards,
> Dmitry.
>
> On Donnerstag, 12. M=C3=A4rz 2020 11:18:26 CET Hans Verkuil wrote:
> > On 3/12/20 11:15 AM, Dmitry Sepp wrote:
> > > Hi Hans,
> > >
> > > Thank you for your great detailed review!
> > >
> > > I won't provide inline answers as your comments totally make sense. T=
here
> > > is>
> > > only one thing I want to mention:
> > >>> + struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES];
> > >>
> > >> Why is this virtio specific? Any reason for not using VIDEO_MAX_PLAN=
ES?
> > >
> > > I'd say this is because VIDEO_MAX_PLANES does not exist outside of th=
e
> > > Linux OS, so for whatever other system we need a virtio specific
> > > definition.
> > OK, good reason :-)
> >
> > It's probably a good thing to add a comment where VIRTIO_VIDEO_MAX_PLAN=
ES is
> > defined that explains this.
> >
> > Regards,
> >
> >       Hans
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

