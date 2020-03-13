Return-Path: virtio-dev-return-6946-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58A55985FEB
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Mar 2020 10:20:15 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Fri, 13 Mar 2020 11:20:09 +0100
Message-ID: <1779643.X513TT2pbd@os-lin-dmo>
In-Reply-To: <75f3a24ac5cd4f656aadf4312bdbcb70a6803a6e.camel@ndufresne.ca>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <1799967.VLH7GnMWUR@os-lin-dmo> <75f3a24ac5cd4f656aadf4312bdbcb70a6803a6e.camel@ndufresne.ca>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/1] Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico
 Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Nicolas,

On Freitag, 13. M=E4rz 2020 03:29:44 CET Nicolas Dufresne wrote:
> Hi Dimitry,
>=20
> Le jeudi 12 mars 2020 =E0 11:29 +0100, Dmitry Sepp a =E9crit :
> > Hi Hans,
> >=20
> > I'm not sure about crosvm, for us it is probably still feasible to
> > implement FWHT in the device (but it is unfortunately not supposed to b=
e
> > upstreamed yet).
> >=20
> > The main question is what would be the proper user-space tool to test
> > that? Is v4l2-ctl OK for that? As for gstreamer, AFAIK it does not
> > respect the v4l2 Video Decoder Interface Spec and we have seen some
> > issues with it.
> GStreamer element has been implemented to support what real drivers do,
> not what the spec suggest should be done. AFAIC, not all drivers have
> been updated with all the new features required by the spec. And the
> new features are not compatible with drivers that are not ported, so it
> creates a lot of complexity for userspace to stay backward compatible.
> Though, the spec should allow drivers to stay backward compatible, if
> not, we'd be very happy to learn why.
>=20
> About the other issues, I'd be very happy to learn what they are, it's
> the first feedback I get from your team thus far. Please feel free to
> file issues or send me (or gstreamer-devel list) an email.

I guess the issues we've observed are related to your point from above: spe=
c=20
vs real HW.

We had that issue with buffer pool configuration for instance: https://
gitlab.freedesktop.org/gstreamer/gst-plugins-good/issues/672

Also it would be nice to wait for metadata to be decoded and only then send=
=20
V4L2_CID_MIN_BUFFERS_FOR_CAPTURE. Currently gstreamer queries that on pipel=
ine=20
start, so for the virtio-video driver we simply have to return 0.

Best regards,
Dmitry.

>=20
> In term of userspace, please consider FFMPEG also, as it's support for
> V4L2 Stateful CODECs has gained momentum. It is again implemented to
> support real drivers, but started much more recently targetting the
> Qualcomm/Venus driver, so it didn't have to suffer all the legacy and
> directions changes in the V4L2 API since 2011.
>=20
> As for the virtio video driver, it will remain useless to non-
> chromeos/chrome users as long as it's not supported by any userspace.
> I'd be very happy so see more contribution into FFMPEG and GStreamer to
> implement the features that, for now, are only implemented in the
> spec.
>=20
> From your comment, bridging a Linux driver in the host through virtio-
> video seems like a huge tasks. I believe this is an important issue to
> address in the long term. If you could provide more details, I think it
> would benefit to readers understanding.
>=20
> > Best regards,
> > Dmitry.
> >=20
> > On Donnerstag, 12. M=E4rz 2020 10:54:35 CET Hans Verkuil wrote:
> > > On 3/12/20 10:49 AM, Keiichi Watanabe wrote:
> > > > Hi Hans,
> > > >=20
> > > > On Wed, Mar 11, 2020 at 10:26 PM Hans Verkuil <hverkuil@xs4all.nl>=
=20
wrote:
> > > > > Hi Dmitry,
> > > > >=20
> > > > > On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> > > > > > Hi all,
> > > > > >=20
> > > > > > This is a v4l2 virtio video driver for the virtio-video device
> > > > > > specification v3 [1].
> > > > > >=20
> > > > > > The first version of the driver was introduced here [2].
> > > > > >=20
> > > > > > Changes v1 -> v2:
> > > > > > * support the v3 spec (mostly)
> > > > > > * add a module parameter to ask for pages from ZONE_DMA
> > > > > >=20
> > > > > > What is not implemented:
> > > > > > * Plane layout flags should be used to propagate number of plan=
es
> > > > > > to
> > > > > >=20
> > > > > >   user-space
> > > > > >=20
> > > > > > * There is no real use of stream creation with bitstream format=
 in
> > > > > > the
> > > > > >=20
> > > > > >   parameter list. The driver just uses the first bitstream form=
at
> > > > > >   from
> > > > > >   the list.
> > > > > >=20
> > > > > > * Setting bitrate is done in a different way compared to the sp=
ec.
> > > > > > This
> > > > > >=20
> > > > > >   is because it has been already agreed on that the way the spe=
c
> > > > > >   currently describes it requires changes.
> > > > > >=20
> > > > > > Potential improvements:
> > > > > > * Do not send stream_create from open. Use corresponding state
> > > > > > machine
> > > > > >=20
> > > > > >   condition to do this.
> > > > > >=20
> > > > > > * Do not send stream_destroy from close. Do it in reqbufs(0).
> > > > > > * Cache format and control settings. Reduce calls to the device=
.
> > > > >=20
> > > > > Some general notes:
> > > > >=20
> > > > > Before this can be merged it needs to pass v4l2-compliance.
> > > > >=20
> > > > > I also strongly recommend adding support for V4L2_PIX_FMT_FWHT to
> > > > > allow testing with the vicodec emulation driver. This will also
> > > > > allow testing all sorts of corner cases without requiring special
> > > > > hardware.
> > > >=20
> > > > I agree that it's great if we could test virtio-video with vicodec,
> > > > but I wonder if supporting FWHT is actually needed for the initial
> > > > patch.
> > > > Though it wouldn't be difficult to support FWHT in the driver, we a=
lso
> > > > needs to support it in the host's hypervisor to test it. It's not e=
asy
> > > > for our hypervisor to support FWHT, as it doesn't talk to v4l2 driv=
er
> > > > directly.
> > > > Without the host-side implementation, it makes no sense to support =
it.
> > > > Also, if we support FWHT, we should have the format in a list of
> > > > supported formats in the virtio specification. However, I'm not sur=
e
> > > > if FWHT is a general codec enough to be added in the spec, which
> > > > shouldn't be specific to Linux.
> > >=20
> > > Good point, I didn't know that.
> > >=20
> > > Is it possible to add support for FWHT under a linux debug/test optio=
n?
> > >=20
> > > It's really the main reason for having this, since you would never us=
e
> > > this in production code. But it is so nice to have for regression
> > > testing.
> > >=20
> > > Regards,
> > >=20
> > > =09Hans
> > > =09
> > > > Best regards,
> > > > Keiichi
> > > >=20
> > > > > Regards,
> > > > >=20
> > > > >         Hans
> > > > > >=20
> > > > > > Best regards,
> > > > > > Dmitry.
> > > > > >=20
> > > > > > [1] https://markmail.org/message/dmw3pr4fuajvarth
> > > > > > [2] https://markmail.org/message/wnnv6r6myvgb5at6



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

