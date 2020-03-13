Return-Path: virtio-dev-return-6945-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 099EC985FEB
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Mar 2020 10:09:18 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Fri, 13 Mar 2020 11:09:11 +0100
Message-ID: <35350330.XM6RcZxFsP@os-lin-dmo>
In-Reply-To: <CAD90VcZLD8keTBXKpK4u-E4st+B3_O1xkb7qgVZMc_ekBjwtCg@mail.gmail.com>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <75f3a24ac5cd4f656aadf4312bdbcb70a6803a6e.camel@ndufresne.ca> <CAD90VcZLD8keTBXKpK4u-E4st+B3_O1xkb7qgVZMc_ekBjwtCg@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Keiichi Watanabe <keiichiw@chromium.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre
 Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel
 Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano
 Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Nicolas, Keiichi,

On Freitag, 13. M=E4rz 2020 08:54:13 CET Keiichi Watanabe wrote:
> Hi Nicolas,
>=20
> On Fri, Mar 13, 2020 at 11:29 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
=20
wrote:
> > Hi Dimitry,
> >=20
> > Le jeudi 12 mars 2020 =E0 11:29 +0100, Dmitry Sepp a =E9crit :
> > > Hi Hans,
> > >=20
> > > I'm not sure about crosvm, for us it is probably still feasible to
> > > implement FWHT in the device (but it is unfortunately not supposed to
> > > be upstreamed yet).
> > >=20
> > > The main question is what would be the proper user-space tool to test
> > > that? Is v4l2-ctl OK for that? As for gstreamer, AFAIK it does not
> > > respect the v4l2 Video Decoder Interface Spec and we have seen some
> > > issues with it.>=20
> > GStreamer element has been implemented to support what real drivers do,
> > not what the spec suggest should be done. AFAIC, not all drivers have
> > been updated with all the new features required by the spec. And the
> > new features are not compatible with drivers that are not ported, so it
> > creates a lot of complexity for userspace to stay backward compatible.
> > Though, the spec should allow drivers to stay backward compatible, if
> > not, we'd be very happy to learn why.
> >=20
> > About the other issues, I'd be very happy to learn what they are, it's
> > the first feedback I get from your team thus far. Please feel free to
> > file issues or send me (or gstreamer-devel list) an email.
> >=20
> > In term of userspace, please consider FFMPEG also, as it's support for
> > V4L2 Stateful CODECs has gained momentum. It is again implemented to
> > support real drivers, but started much more recently targetting the
> > Qualcomm/Venus driver, so it didn't have to suffer all the legacy and
> > directions changes in the V4L2 API since 2011.
> >=20
> > As for the virtio video driver, it will remain useless to non-
> > chromeos/chrome users as long as it's not supported by any userspace.
> > I'd be very happy so see more contribution into FFMPEG and GStreamer to
> > implement the features that, for now, are only implemented in the
> > spec.
> >=20
> > From your comment, bridging a Linux driver in the host through virtio-
> > video seems like a huge tasks. I believe this is an important issue to
> > address in the long term. If you could provide more details, I think it
> > would benefit to readers understanding.
>=20
> Just to clarify, Dmitry is not working for ChromeOS but for another
> hypervisor (, which is not OSS?). So, users are not limited to
> ChromeOS.
> But, yeah, I agree that it's important to make it easy to use
> virtio-video driver without special hardware.
>=20
> Let me explain what is the remaining task.
> To test virtio-video driver, we need to take care of four parts:
> Guest user application, guest virtio-video driver (this patch), host
> virtio-video device, and host video codec device.
> We have several options for each parts:
>=20
> Guest userspace | Guest kernel | Host userspace hypervisor | Host video
> device
> -------------------------------------------------------------------------=
--
> - * FFMPEG      | virtio-video | virtio-video device in    | * real drive=
r *
> GStreamer   |  driver      | * crosvm                  | * vicodec *
> v4l2-ctl    |              | * Dmitry's hypervisor     | * SW en/decoder
>                 |              | * QEMU?                   |
>=20
> The remaining task I commented is implementation of virtio-video
> device in a host hypervisor.

Oh, there is no Dmitry's hypervisor unfortunately :) It is the COQOS=20
Automotive hypervisor. And of course it does not use SW codecs on the host=
=20
side. Yes, correct, the hypervisor is not OSS for obvious reasons.

For us one of the most important guest side users is Android's multimedia=
=20
subsystem, so I'll update the table in this way:

Guest userspace | Guest kernel | Host userspace hypervisor | Host video dev=
ice
---------------------------------------------------------------------------=
-
  * FFMPEG      | virtio-video | virtio-video device in    | * real driver
  * GStreamer   |  driver      | * crosvm                  | * vicodec
  * Codec2 HAL  | virtio-video | * COQOS hypervisor        | * Platform Cod=
ecs
                |              | * QEMU?                   |

> What a virtio-video device does is forwarding guest driver's
> virtio-video commands to host's video decoder/encoder, and vice versa.
> If we use vicodec as a backend host video device, this part's task is
> protocol translation between virtio-video and V4L2 stateful API.
>=20

There is some translation anyway, so from my point of view the problem to=
=20
implement this is not that difficult, it just requires some more time. This=
=20
could be a foundation for some QEMU codec device.

Best regards,
Dmitry.

> Though there are two virtio-video device implementation in the world
> at least (one in crosvm and the other in Dmitry's team's hypervisor),
> I guess both hypervisor implementations are not easy to use without
> special devices.
> So, we might want to have one more virtio-video device implementation
> in QEMU in the long term.
> It will be somehow similar to virtio-gpu device that is already
> implemented in QEMU:
> https://github.com/qemu/qemu/blob/master/hw/display/virtio-gpu.c
>=20
> Best regards,
> Keiichi
>=20
> > > Best regards,
> > > Dmitry.
> > >=20
> > > On Donnerstag, 12. M=E4rz 2020 10:54:35 CET Hans Verkuil wrote:
> > > > On 3/12/20 10:49 AM, Keiichi Watanabe wrote:
> > > > > Hi Hans,
> > > > >=20
> > > > > On Wed, Mar 11, 2020 at 10:26 PM Hans Verkuil <hverkuil@xs4all.nl=
>=20
wrote:
> > > > > > Hi Dmitry,
> > > > > >=20
> > > > > > On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > This is a v4l2 virtio video driver for the virtio-video devic=
e
> > > > > > > specification v3 [1].
> > > > > > >=20
> > > > > > > The first version of the driver was introduced here [2].
> > > > > > >=20
> > > > > > > Changes v1 -> v2:
> > > > > > > * support the v3 spec (mostly)
> > > > > > > * add a module parameter to ask for pages from ZONE_DMA
> > > > > > >=20
> > > > > > > What is not implemented:
> > > > > > > * Plane layout flags should be used to propagate number of
> > > > > > > planes to
> > > > > > >=20
> > > > > > >   user-space
> > > > > > >=20
> > > > > > > * There is no real use of stream creation with bitstream form=
at
> > > > > > > in the
> > > > > > >=20
> > > > > > >   parameter list. The driver just uses the first bitstream
> > > > > > >   format from
> > > > > > >   the list.
> > > > > > >=20
> > > > > > > * Setting bitrate is done in a different way compared to the
> > > > > > > spec. This
> > > > > > >=20
> > > > > > >   is because it has been already agreed on that the way the s=
pec
> > > > > > >   currently describes it requires changes.
> > > > > > >=20
> > > > > > > Potential improvements:
> > > > > > > * Do not send stream_create from open. Use corresponding stat=
e
> > > > > > > machine
> > > > > > >=20
> > > > > > >   condition to do this.
> > > > > > >=20
> > > > > > > * Do not send stream_destroy from close. Do it in reqbufs(0).
> > > > > > > * Cache format and control settings. Reduce calls to the devi=
ce.
> > > > > >=20
> > > > > > Some general notes:
> > > > > >=20
> > > > > > Before this can be merged it needs to pass v4l2-compliance.
> > > > > >=20
> > > > > > I also strongly recommend adding support for V4L2_PIX_FMT_FWHT =
to
> > > > > > allow testing with the vicodec emulation driver. This will also
> > > > > > allow testing all sorts of corner cases without requiring speci=
al
> > > > > > hardware.
> > > > >=20
> > > > > I agree that it's great if we could test virtio-video with vicode=
c,
> > > > > but I wonder if supporting FWHT is actually needed for the initia=
l
> > > > > patch.
> > > > > Though it wouldn't be difficult to support FWHT in the driver, we
> > > > > also
> > > > > needs to support it in the host's hypervisor to test it. It's not
> > > > > easy
> > > > > for our hypervisor to support FWHT, as it doesn't talk to v4l2
> > > > > driver
> > > > > directly.
> > > > > Without the host-side implementation, it makes no sense to suppor=
t
> > > > > it.
> > > > > Also, if we support FWHT, we should have the format in a list of
> > > > > supported formats in the virtio specification. However, I'm not s=
ure
> > > > > if FWHT is a general codec enough to be added in the spec, which
> > > > > shouldn't be specific to Linux.
> > > >=20
> > > > Good point, I didn't know that.
> > > >=20
> > > > Is it possible to add support for FWHT under a linux debug/test
> > > > option?
> > > >=20
> > > > It's really the main reason for having this, since you would never =
use
> > > > this in production code. But it is so nice to have for regression
> > > > testing.
> > > >=20
> > > > Regards,
> > > >=20
> > > >     Hans
> > > > >=20
> > > > > Best regards,
> > > > > Keiichi
> > > > >=20
> > > > > > Regards,
> > > > > >=20
> > > > > >         Hans
> > > > > > >=20
> > > > > > > Best regards,
> > > > > > > Dmitry.
> > > > > > >=20
> > > > > > > [1] https://markmail.org/message/dmw3pr4fuajvarth
> > > > > > > [2] https://markmail.org/message/wnnv6r6myvgb5at6



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

