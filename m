Return-Path: virtio-dev-return-6942-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6637B985FDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Mar 2020 11:48:55 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 12 Mar 2020 12:48:49 +0100
Message-ID: <12620787.dW097sEU6C@os-lin-dmo>
In-Reply-To: <6f8c37b1-8dc4-e3bb-01ed-4ebedaf90915@xs4all.nl>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <20719772.EfDdHjke4D@os-lin-dmo> <6f8c37b1-8dc4-e3bb-01ed-4ebedaf90915@xs4all.nl>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc: virtio-dev@lists.oasis-open.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Hans,

One more thing:

> GFP_DMA? That's unusual. I'd expect GFP_DMA32. All V4L2 drivers use that.

GFP_DMA32 had no effect for me on arm64. Probably I need to recheck.

Best regards,
Dmitry.=20

On Donnerstag, 12. M=E4rz 2020 11:18:26 CET Hans Verkuil wrote:
> On 3/12/20 11:15 AM, Dmitry Sepp wrote:
> > Hi Hans,
> >=20
> > Thank you for your great detailed review!
> >=20
> > I won't provide inline answers as your comments totally make sense. The=
re
> > is>=20
> > only one thing I want to mention:
> >>> +=09struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES];
> >>=20
> >> Why is this virtio specific? Any reason for not using VIDEO_MAX_PLANES=
?
> >=20
> > I'd say this is because VIDEO_MAX_PLANES does not exist outside of the
> > Linux OS, so for whatever other system we need a virtio specific
> > definition.
> OK, good reason :-)
>=20
> It's probably a good thing to add a comment where VIRTIO_VIDEO_MAX_PLANES=
 is
> defined that explains this.
>=20
> Regards,
>=20
> =09Hans



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

