Return-Path: virtio-dev-return-6643-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28927985E7B
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Jan 2020 10:16:42 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Fri, 10 Jan 2020 11:16:34 +0100
Message-ID: <2137719.ElGaqSPkdT@os-lin-dmo>
In-Reply-To: <7712151.T7Z3S40VBb@os-lin-dmo>
References: <20191218130214.170703-1-keiichiw@chromium.org> <CAD90VcaQCSFTv-JyxZ7cO+Qnc0U2NRGikcYmmy=zitJby9NfXg@mail.gmail.com> <7712151.T7Z3S40VBb@os-lin-dmo>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org
Cc: Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com, Dmitry Sepp <dmitry.sepp@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Donnerstag, 9. Januar 2020 15:56:08 CET Dmitry Sepp wrote:
> Hi,
>=20
> On Dienstag, 7. Januar 2020 11:25:56 CET Keiichi Watanabe wrote:
> > Hi Dmitry,
> >=20
> > On Mon, Jan 6, 2020 at 8:28 PM Dmitry Sepp <dmitry.sepp@opensynergy.com=
>
>=20
> wrote:
> > > Hi,
> > >=20
> > > On Montag, 6. Januar 2020 11:30:22 CET Keiichi Watanabe wrote:
> > > > Hi Dmitry, Tomasz,
> > > >=20
> > > > On Fri, Jan 3, 2020 at 10:05 PM Dmitry Sepp
> > > > <dmitry.sepp@opensynergy.com>
> > >=20
> > > wrote:
> > > > > Hi Tomasz, Keiichi,
> > > > >=20
> > > > > On Samstag, 21. Dezember 2019 07:19:23 CET Tomasz Figa wrote:
> > > > > > On Sat, Dec 21, 2019 at 3:18 PM Tomasz Figa <tfiga@chromium.org=
>
>=20
> wrote:
> > > > > > > On Sat, Dec 21, 2019 at 1:36 PM Keiichi Watanabe
> > > > > > > <keiichiw@chromium.org>
> > > > >=20
> > > > > wrote:
> > > > > > > > Hi Dmitry,
> > > > > > > >=20
> > > > > > > > On Sat, Dec 21, 2019 at 12:59 AM Dmitry Sepp
> > > > > > > >=20
> > > > > > > > <dmitry.sepp@opensynergy.com> wrote:
> > > > > > > > > Hi Keiichi,
> > > > > > > > >=20
> > > > > > > > > On Mittwoch, 18. Dezember 2019 14:02:13 CET Keiichi Watan=
abe
> > >=20
> > > wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > This is the 2nd version of virtio-video patch. The PDF =
is
> > > > > > > > > > available
> > > > > > > > > > in [1].
> > > > > > > > > > The first version was sent at [2].
> > > > > > > > > >=20
> > > > > > > > > > Any feedback would be appreciated. Thank you.
> > > > > > > > > >=20
> > > > > > > > > > Best,
> > > > > > > > > > Keiichi
> > > > > > > > > >=20
> > > > > > > > > > [1]:
> > > > > > > > > > https://drive.google.com/drive/folders/1eT5fEckBoor2iHZ=
R4f
> > > > > > > > > > 4G
> > > > > > > > > > LxYz
> > > > > > > > > > FMVa
> > > > > > > > > > pOFx?us
> > > > > > > > > > p=3Dsharing [2]:
> > > > > > > > > > https://markmail.org/message/gc6h25acct22niut
> > > > > > > > > >=20
> > > > > > > > > > Change log:
> > > > > > > > > >=20
> > > > > > > > > > v2:
> > > > > > > > > > * Removed functionalities except encoding and decoding.
> > > > > > > > > > * Splited encoder and decoder into different devices th=
at
> > > > > > > > > > use
> > > > > > > > > > the
> > > > > > > > > > same
> > > > > > > > > > protocol. * Replaced GET_FUNCS with GET_CAPABILITY.
> > > > > > > > > > * Updated structs for capabilities.
> > > > > > > > > >=20
> > > > > > > > > >   - Defined new structs and enums such as image formats=
,
> > > > > > > > > >   profiles,
> > > > > > > > > >   range
> > > > > > > > > >=20
> > > > > > > > > > (min, max, step), etc
> > > > > > > > > >=20
> > > > > > > > > >     * For virtio_video_pixel_format, chose a naming
> > > > > > > > > >     convention
> > > > > > > > > >     that
> > > > > > > > > >     is used
> > > > > > > > > >    =20
> > > > > > > > > >       in DRM. We removed XBGR, NV21 and I422, as they a=
re
> > > > > > > > > >       not
> > > > > > > > > >       used
> > > > > > > > > >       in the
> > > > > > > > > >       current draft implementation.
> > > > > > > > > >       https://lwn.net/Articles/806416/
> > > > > > > > > >  =20
> > > > > > > > > >   - Removed virtio_video_control, whose usage was not
> > > > > > > > > >   documented
> > > > > > > > > >   yet
> > > > > > > > > >   and
> > > > > > > > > >=20
> > > > > > > > > > which is not necessary for the simplest decoding scenar=
io.
> > > > > > > > > >=20
> > > > > > > > > >   - Removed virtio_video_desc, as it is no longer neede=
d.
> > > > > > > > > >=20
> > > > > > > > > > * Updated struct virtio_video_config for changes around
> > > > > > > > > > capabilities.
> > > > > > > > > > * Added a way to represent supported combinations of
> > > > > > > > > > formats.
> > > > > > > > > >=20
> > > > > > > > > >   - A field "mask" in virtio_video_format_desc plays th=
is
> > > > > > > > > >   role.
> > > > > > > > > >=20
> > > > > > > > > > * Removed VIRTIO_VIDEO_T_STREAM_{START,STOP} because th=
ey
> > > > > > > > > > don't
> > > > > > > > > > play
> > > > > > > > > > any
> > > > > > > > > > meaningful roles. * Removed VIRTIO_VIDEO_T_STREAM_{ATTA=
CH,
> > > > > > > > > > DETACH}_BACKING
> > > > > > > > > > and merged them into RESOURCE_{CREATE, DESTROY}. * Adde=
d a
> > > > > > > > > > way
> > > > > > > > > > to
> > > > > > > > > > notify/specify resource creation method.
> > > > > > > > > >=20
> > > > > > > > > >   - Added a feature flag.
> > > > > > > > > >   - Defined enum virtio_video_mem_type.
> > > > > > > > > >   - Added new fields in video_stream_create.
> > > > > > > > > >=20
> > > > > > > > > > * Modified fields in virtio_video_params.
> > > > > > > > > >=20
> > > > > > > > > >   - Added crop information.
> > > > > > > > > >=20
> > > > > > > > > > * Removed enum virtio_video_channel_type because we can
> > > > > > > > > > get
> > > > > > > > > > this
> > > > > > > > > > information by image format.
> > > > > > > > >=20
> > > > > > > > > Could you please explain this? How do you get the
> > > > > > > > > information?
> > > > > > > >=20
> > > > > > > > It means that if image formats are well-defined, channel
> > > > > > > > information
> > > > > > > > (e.g. the order of channels) is uniquely determined.
> > > > > > > >=20
> > > > > > > > > Suppose you have some piece of HW on the host side that
> > > > > > > > > wants
> > > > > > > > > I420
> > > > > > > > > as
> > > > > > > > > one
> > > > > > > > > contig buffer w/ some offsets. But on the driver side, sa=
y,
> > > > > > > > > gralloc
> > > > > > > > > gives you three separate buffers, one per channel. How do=
 we
> > > > > > > > > pass
> > > > > > > > > those to the device then?
> > > > > > > >=20
> > > > > > > > You're talking about CrOS use case where buffers are alloca=
ted
> > > > > > > > by
> > > > > > > > virtio-gpu, right?
> > > > > > > > In this case, virtio-gpu allocates one contiguous host-side
> > > > > > > > buffer
> > > > > > > > and
> > > > > > > > the client regards a pair of (buffer FD, offset) as one
> > > > > > > > channel.
> > > > > > > > And, we can register this pair to the device when the buffe=
r
> > > > > > > > is
> > > > > > > > imported.
> > > > > > > > In the virtio-vdec spec draft, this pair corresponds to str=
uct
> > > > > > > > virtio_vdec_plane in struct virtio_vdec_plane.
> > > > > > > >=20
> > > > > > > > So, I suppose we will need similar structs when we add a
> > > > > > > > control
> > > > > > > > to
> > > > > > > > import buffers. However, I don't think it's necessary when
> > > > > > > > guest
> > > > > > > > pages
> > > > > > > > are used.
> > > > > > >=20
> > > > > > > I think we need some way for the guest to know whether it can
> > > > > > > allocate
> > > > > > > the planes in separate buffers, even when guest pages are use=
d.
> > > > > > > This
> > > > > > > would be equivalent to V4L2 M and non-M formats, but mixing t=
his
> > > > > > > into
> > > > > > > FourCC in V4L2 is an acknowledged mistake, so we should add a
> > > > > > > query or
> > > > > > > something.
> > > > >=20
> > > > > Yes, this is what I mean. In fact, we already do face the situati=
on
> > > > > when
> > > > > the device side is not happy with the sgt and wants contig. I thi=
nk
> > > > > we'll
> > > > > add a module parameter for now.
> > > >=20
> > > > Okay. So, I suppose we'll be able to update structs:
> > > > * Add a flag in virtio_video_format_desc that indicates whether pla=
nes
> > > > can be in separate buffers, and
> > > > * Add a flag in virtio_video_format_desc that indicates that the
> > > > device requires contiguous buffers for this format.
> > > >=20
> > > > Does it make sense?
> > >=20
> > > Sorry, I don't understand the difference between the two above: isn't
> > > the
> > > first case is just when the flag is not set?
> >=20
> > Ah, I was confused and wrote something strange. Yeah,  these two are th=
e
> > same. Sorry for that.
> >=20
> > So, the suggestion is to add a field "planes_layout" in
> > virtio_video_format_desc, which is one of the following enums:
> >=20
> > enum virtio_video_planes_layout {
> >=20
> >     VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* no special requirement=
 */
> >     VIRTIO_VIDEO_PLANES_LAYOUT_CONTIGUOUS,
> >=20
> > };
> >=20
> > If we have a better idea or naming, please let me know.
>=20
> The naming looks good for me, I might only change to CONTIG as we have
> UNSPEC.
>=20

So here we are talking about plane layout in memory, am I correct? But I th=
ink=20
we also need a way to communicate memory requirements of the device: the=20
device might require CMA buffers or it can be ok with SG lists. What about=
=20
adding something like this to virtio_video_format_desc:

=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Benum virtio_video_mem_layout {
=09VIRTIO_VIDEO_MEM_LAYOUT_UNDEFINED =3D 0,

=09VIRTIO_VIDEO_MEM_LAYOUT_CONTIG =3D 0x100,
=09VIRTIO_VIDEO_MEM_LAYOUT_NON_CONTIG,
};

struct virtio_video_format_desc {
    __le64 mask;
    __le32 format; /* One of VIRTIO_VIDEO_FORMAT_* types */
    __le32 planes_layout; /* One of VIRTIO_VIDEO_PLANES_LAYOUT_* types */
    __le32 mem_layout; /* One of VIRTIO_VIDEO_MEM_LAYOUT_* types */
    ...
};

Best regards,
Dmitry.

> Best regards,
> Dmitry.
>=20
> > Best regards,
> > Keiichi
> >=20
> > > Regards,
> > > Dmitry.
> > >=20
> > > > Best regards,
> > > > Keiichi
> > > >=20
> > > > > Regards,
> > > > > Dmitry.
> > > > >=20
> > > > > > > For future V4L2 development we came up with the idea of a for=
mat
> > > > > > > flag
> > > > > > > which could mean that the hardware allows putting planes in
> > > > > > > separate
> > > > > > > buffers. We could have a similar per-format flag in the
> > > > > > > capabilities,
> > > > > > > as we already have a list of all the supported formats there.
> > > > > >=20
> > > > > > Sorry, forgot to paste the link from future V4L2 work notes fro=
m
> > > > > > this
> > > > > > year
> > > > > > ELCE: https://www.spinics.net/lists/linux-media/msg159789.html
> > > > > >=20
> > > > > > > Best regards,
> > > > > > > Tomasz
> > > > > > >=20
> > > > > > > > Best regards,
> > > > > > > > Keiichi
> > > > > > > >=20
> > > > > > > > > Best regards,
> > > > > > > > > Dmitry.
> > > > > > > > >=20
> > > > > > > > > > * Renamed virtio_video_pin to virtio_video_buf_type.
> > > > > > > > > >=20
> > > > > > > > > >   - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTPUT, CAPTUR=
E}.
> > > > > > > > > >=20
> > > > > > > > > > * Added an error event.
> > > > > > > > > > * Reordered some subsections.
> > > > > > > > > > * Changed styles to make it consistent with other devic=
es.
> > > > > > > > > >=20
> > > > > > > > > > Dmitry Sepp (1):
> > > > > > > > > >   virtio-video: Add virtio video device specification
> > > > > > > > > > =20
> > > > > > > > > >  content.tex      |   1 +
> > > > > > > > > >  virtio-video.tex | 579
> > > > > > > > > >  +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > >  2 files changed, 580 insertions(+)
> > > > > > > > > >  create mode 100644 virtio-video.tex
> > > > > > > > > >=20
> > > > > > > > > > --
> > > > > > > > > > 2.24.1.735.g03f4e72817-goog
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

