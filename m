Return-Path: virtio-dev-return-6940-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5757985FDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Mar 2020 10:29:44 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 12 Mar 2020 11:29:38 +0100
Message-ID: <1799967.VLH7GnMWUR@os-lin-dmo>
In-Reply-To: <1ac18708-262f-c751-d955-267931270028@xs4all.nl>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <CAD90VcZUqU0nVQEn1vNOQkcicR5GA+HzBGd+M7O_b69f2BCUxA@mail.gmail.com> <1ac18708-262f-c751-d955-267931270028@xs4all.nl>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Hans,

I'm not sure about crosvm, for us it is probably still feasible to implemen=
t=20
FWHT in the device (but it is unfortunately not supposed to be upstreamed=
=20
yet).

The main question is what would be the proper user-space tool to test that?=
 Is=20
v4l2-ctl OK for that? As for gstreamer, AFAIK it does not respect the v4l2=
=20
Video Decoder Interface Spec and we have seen some issues with it.

Best regards,
Dmitry.

On Donnerstag, 12. M=E4rz 2020 10:54:35 CET Hans Verkuil wrote:
> On 3/12/20 10:49 AM, Keiichi Watanabe wrote:
> > Hi Hans,
> >=20
> > On Wed, Mar 11, 2020 at 10:26 PM Hans Verkuil <hverkuil@xs4all.nl> wrot=
e:
> >> Hi Dmitry,
> >>=20
> >> On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> >>> Hi all,
> >>>=20
> >>> This is a v4l2 virtio video driver for the virtio-video device
> >>> specification v3 [1].
> >>>=20
> >>> The first version of the driver was introduced here [2].
> >>>=20
> >>> Changes v1 -> v2:
> >>> * support the v3 spec (mostly)
> >>> * add a module parameter to ask for pages from ZONE_DMA
> >>>=20
> >>> What is not implemented:
> >>> * Plane layout flags should be used to propagate number of planes to
> >>>=20
> >>>   user-space
> >>>=20
> >>> * There is no real use of stream creation with bitstream format in th=
e
> >>>=20
> >>>   parameter list. The driver just uses the first bitstream format fro=
m
> >>>   the list.
> >>>=20
> >>> * Setting bitrate is done in a different way compared to the spec. Th=
is
> >>>=20
> >>>   is because it has been already agreed on that the way the spec
> >>>   currently describes it requires changes.
> >>>=20
> >>> Potential improvements:
> >>> * Do not send stream_create from open. Use corresponding state machin=
e
> >>>=20
> >>>   condition to do this.
> >>>=20
> >>> * Do not send stream_destroy from close. Do it in reqbufs(0).
> >>> * Cache format and control settings. Reduce calls to the device.
> >>=20
> >> Some general notes:
> >>=20
> >> Before this can be merged it needs to pass v4l2-compliance.
> >>=20
> >> I also strongly recommend adding support for V4L2_PIX_FMT_FWHT to
> >> allow testing with the vicodec emulation driver. This will also
> >> allow testing all sorts of corner cases without requiring special
> >> hardware.
> >=20
> > I agree that it's great if we could test virtio-video with vicodec,
> > but I wonder if supporting FWHT is actually needed for the initial
> > patch.
> > Though it wouldn't be difficult to support FWHT in the driver, we also
> > needs to support it in the host's hypervisor to test it. It's not easy
> > for our hypervisor to support FWHT, as it doesn't talk to v4l2 driver
> > directly.
> > Without the host-side implementation, it makes no sense to support it.
> > Also, if we support FWHT, we should have the format in a list of
> > supported formats in the virtio specification. However, I'm not sure
> > if FWHT is a general codec enough to be added in the spec, which
> > shouldn't be specific to Linux.
>=20
> Good point, I didn't know that.
>=20
> Is it possible to add support for FWHT under a linux debug/test option?
>=20
> It's really the main reason for having this, since you would never use
> this in production code. But it is so nice to have for regression testing=
.
>=20
> Regards,
>=20
> =09Hans
>=20
> > Best regards,
> > Keiichi
> >=20
> >> Regards,
> >>=20
> >>         Hans
> >>>=20
> >>> Best regards,
> >>> Dmitry.
> >>>=20
> >>> [1] https://markmail.org/message/dmw3pr4fuajvarth
> >>> [2] https://markmail.org/message/wnnv6r6myvgb5at6



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

