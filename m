Return-Path: virtio-dev-return-6936-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19174985FDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Mar 2020 09:04:07 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 12 Mar 2020 10:03:58 +0100
Message-ID: <3182728.aeNJFYEL58@os-lin-dmo>
In-Reply-To: <c4d7622b-e396-3920-0e14-5a73a0225c0f@xs4all.nl>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <c4d7622b-e396-3920-0e14-5a73a0225c0f@xs4all.nl>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc: virtio-dev@lists.oasis-open.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Hans,

Thanks for reviewing.

Sure, we understand the driver must pass v4l2-compliance. But the spec is n=
ot=20
finalized yet, so it was a bit out of the scope.

Best regards,
Dmitry.

On Mittwoch, 11. M=E4rz 2020 14:26:46 CET Hans Verkuil wrote:
> Hi Dmitry,
>=20
> On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> > Hi all,
> >=20
> > This is a v4l2 virtio video driver for the virtio-video device
> > specification v3 [1].
> >=20
> > The first version of the driver was introduced here [2].
> >=20
> > Changes v1 -> v2:
> > * support the v3 spec (mostly)
> > * add a module parameter to ask for pages from ZONE_DMA
> >=20
> > What is not implemented:
> > * Plane layout flags should be used to propagate number of planes to
> >=20
> >   user-space
> >=20
> > * There is no real use of stream creation with bitstream format in the
> >=20
> >   parameter list. The driver just uses the first bitstream format from
> >   the list.
> >=20
> > * Setting bitrate is done in a different way compared to the spec. This
> >=20
> >   is because it has been already agreed on that the way the spec
> >   currently describes it requires changes.
> >=20
> > Potential improvements:
> > * Do not send stream_create from open. Use corresponding state machine
> >=20
> >   condition to do this.
> >=20
> > * Do not send stream_destroy from close. Do it in reqbufs(0).
> > * Cache format and control settings. Reduce calls to the device.
>=20
> Some general notes:
>=20
> Before this can be merged it needs to pass v4l2-compliance.
>=20
> I also strongly recommend adding support for V4L2_PIX_FMT_FWHT to
> allow testing with the vicodec emulation driver. This will also
> allow testing all sorts of corner cases without requiring special
> hardware.
>=20
> Regards,
>=20
> =09Hans
>=20
> > Best regards,
> > Dmitry.
> >=20
> > [1] https://markmail.org/message/dmw3pr4fuajvarth
> > [2] https://markmail.org/message/wnnv6r6myvgb5at6



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

