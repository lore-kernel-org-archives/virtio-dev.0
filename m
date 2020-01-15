Return-Path: virtio-dev-return-6662-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43013985F6B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jan 2020 11:23:55 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo> <CAAFQd5DwrrkEigKZ4fRE6GXAa+rvjm6QQYfDCxm85esQBdnh-A@mail.gmail.com>
 <3448919.MHq7AAxBmi@os-lin-dmo>
In-Reply-To: <3448919.MHq7AAxBmi@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 15 Jan 2020 20:23:41 +0900
Message-ID: <CAD90VcYb4Lj+GEy-Qy=i-s_uup8+hwOkhhtKhzcER76KF6Btzw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,
Thank you for the detailed explanation about your ideas on
planes_layout and mem_layout.

On Mon, Jan 13, 2020 at 6:50 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi Tomasz,
>
> On Samstag, 11. Januar 2020 17:06:46 CET Tomasz Figa wrote:
> > On Sat, Jan 11, 2020 at 12:12 AM Dmitry Sepp
> >
> > <dmitry.sepp@opensynergy.com> wrote:
> > > Hi Keiichi,
> > >
> > > On Freitag, 10. Januar 2020 14:53:01 CET Keiichi Watanabe wrote:
> > > > Hi,
> > > >
> > > > On Fri, Jan 10, 2020 at 7:16 PM Dmitry Sepp
> > > > <dmitry.sepp@opensynergy.com>
> > >
> > > wrote:
> > > > > Hi,
> > > > >
> > > > > On Donnerstag, 9. Januar 2020 15:56:08 CET Dmitry Sepp wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Dienstag, 7. Januar 2020 11:25:56 CET Keiichi Watanabe wrote=
:
> > > > > > > Hi Dmitry,
> > > > > > >
> > > > > > > On Mon, Jan 6, 2020 at 8:28 PM Dmitry Sepp
> > > > > > > <dmitry.sepp@opensynergy.com>
> > > > > >
> > > > > > wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Montag, 6. Januar 2020 11:30:22 CET Keiichi Watanabe wro=
te:
> > > > > > > > > Hi Dmitry, Tomasz,
> > > > > > > > >
> > > > > > > > > On Fri, Jan 3, 2020 at 10:05 PM Dmitry Sepp
> > > > > > > > > <dmitry.sepp@opensynergy.com>
> > > > > > > >
> > > > > > > > wrote:
> > > > > > > > > > Hi Tomasz, Keiichi,
> > > > > > > > > >
> > > > > > > > > > On Samstag, 21. Dezember 2019 07:19:23 CET Tomasz Figa
> wrote:
> > > > > > > > > > > On Sat, Dec 21, 2019 at 3:18 PM Tomasz Figa
> > > > > > > > > > > <tfiga@chromium.org>
> > > > > >
> > > > > > wrote:
> > > > > > > > > > > > On Sat, Dec 21, 2019 at 1:36 PM Keiichi Watanabe
> > > > > > > > > > > > <keiichiw@chromium.org>
> > > > > > > > > >
> > > > > > > > > > wrote:
> > > > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, Dec 21, 2019 at 12:59 AM Dmitry Sepp
> > > > > > > > > > > > >
> > > > > > > > > > > > > <dmitry.sepp@opensynergy.com> wrote:
> > > > > > > > > > > > > > Hi Keiichi,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Mittwoch, 18. Dezember 2019 14:02:13 CET Kei=
ichi
> > > > > > > > > > > > > > Watanabe
> > > > > > > >
> > > > > > > > wrote:
> > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > This is the 2nd version of virtio-video patch=
. The
> > > > > > > > > > > > > > > PDF
> > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > available
> > > > > > > > > > > > > > > in [1].
> > > > > > > > > > > > > > > The first version was sent at [2].
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Any feedback would be appreciated. Thank you.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Best,
> > > > > > > > > > > > > > > Keiichi
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [1]:
> > > > > > > > > > > > > > > https://drive.google.com/drive/folders/1eT5fE=
ckBoo
> > > > > > > > > > > > > > > r2iH
> > > > > > > > > > > > > > > ZR4f
> > > > > > > > > > > > > > > 4G
> > > > > > > > > > > > > > > LxYz
> > > > > > > > > > > > > > > FMVa
> > > > > > > > > > > > > > > pOFx?us
> > > > > > > > > > > > > > > p=3Dsharing [2]:
> > > > > > > > > > > > > > > https://markmail.org/message/gc6h25acct22niut
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Change log:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > v2:
> > > > > > > > > > > > > > > * Removed functionalities except encoding and
> > > > > > > > > > > > > > > decoding.
> > > > > > > > > > > > > > > * Splited encoder and decoder into different
> > > > > > > > > > > > > > > devices
> > > > > > > > > > > > > > > that
> > > > > > > > > > > > > > > use
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > same
> > > > > > > > > > > > > > > protocol. * Replaced GET_FUNCS with
> > > > > > > > > > > > > > > GET_CAPABILITY.
> > > > > > > > > > > > > > > * Updated structs for capabilities.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - Defined new structs and enums such as ima=
ge
> > > > > > > > > > > > > > >   formats,
> > > > > > > > > > > > > > >   profiles,
> > > > > > > > > > > > > > >   range
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > (min, max, step), etc
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >     * For virtio_video_pixel_format, chose a
> > > > > > > > > > > > > > >     naming
> > > > > > > > > > > > > > >     convention
> > > > > > > > > > > > > > >     that
> > > > > > > > > > > > > > >     is used
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       in DRM. We removed XBGR, NV21 and I422,=
 as
> > > > > > > > > > > > > > >       they
> > > > > > > > > > > > > > >       are
> > > > > > > > > > > > > > >       not
> > > > > > > > > > > > > > >       used
> > > > > > > > > > > > > > >       in the
> > > > > > > > > > > > > > >       current draft implementation.
> > > > > > > > > > > > > > >       https://lwn.net/Articles/806416/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - Removed virtio_video_control, whose usage=
 was
> > > > > > > > > > > > > > >   not
> > > > > > > > > > > > > > >   documented
> > > > > > > > > > > > > > >   yet
> > > > > > > > > > > > > > >   and
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > which is not necessary for the simplest decod=
ing
> > > > > > > > > > > > > > > scenario.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - Removed virtio_video_desc, as it is no lo=
nger
> > > > > > > > > > > > > > >   needed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Updated struct virtio_video_config for chan=
ges
> > > > > > > > > > > > > > > around
> > > > > > > > > > > > > > > capabilities.
> > > > > > > > > > > > > > > * Added a way to represent supported combinat=
ions
> > > > > > > > > > > > > > > of
> > > > > > > > > > > > > > > formats.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - A field "mask" in virtio_video_format_des=
c
> > > > > > > > > > > > > > >   plays
> > > > > > > > > > > > > > >   this
> > > > > > > > > > > > > > >   role.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Removed VIRTIO_VIDEO_T_STREAM_{START,STOP}
> > > > > > > > > > > > > > > because
> > > > > > > > > > > > > > > they
> > > > > > > > > > > > > > > don't
> > > > > > > > > > > > > > > play
> > > > > > > > > > > > > > > any
> > > > > > > > > > > > > > > meaningful roles. * Removed
> > > > > > > > > > > > > > > VIRTIO_VIDEO_T_STREAM_{ATTACH,
> > > > > > > > > > > > > > > DETACH}_BACKING
> > > > > > > > > > > > > > > and merged them into RESOURCE_{CREATE, DESTRO=
Y}. *
> > > > > > > > > > > > > > > Added a
> > > > > > > > > > > > > > > way
> > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > notify/specify resource creation method.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - Added a feature flag.
> > > > > > > > > > > > > > >   - Defined enum virtio_video_mem_type.
> > > > > > > > > > > > > > >   - Added new fields in video_stream_create.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Modified fields in virtio_video_params.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - Added crop information.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Removed enum virtio_video_channel_type beca=
use
> > > > > > > > > > > > > > > we
> > > > > > > > > > > > > > > can
> > > > > > > > > > > > > > > get
> > > > > > > > > > > > > > > this
> > > > > > > > > > > > > > > information by image format.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Could you please explain this? How do you get t=
he
> > > > > > > > > > > > > > information?
> > > > > > > > > > > > >
> > > > > > > > > > > > > It means that if image formats are well-defined,
> > > > > > > > > > > > > channel
> > > > > > > > > > > > > information
> > > > > > > > > > > > > (e.g. the order of channels) is uniquely determin=
ed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Suppose you have some piece of HW on the host s=
ide
> > > > > > > > > > > > > > that
> > > > > > > > > > > > > > wants
> > > > > > > > > > > > > > I420
> > > > > > > > > > > > > > as
> > > > > > > > > > > > > > one
> > > > > > > > > > > > > > contig buffer w/ some offsets. But on the drive=
r
> > > > > > > > > > > > > > side,
> > > > > > > > > > > > > > say,
> > > > > > > > > > > > > > gralloc
> > > > > > > > > > > > > > gives you three separate buffers, one per chann=
el.
> > > > > > > > > > > > > > How
> > > > > > > > > > > > > > do we
> > > > > > > > > > > > > > pass
> > > > > > > > > > > > > > those to the device then?
> > > > > > > > > > > > >
> > > > > > > > > > > > > You're talking about CrOS use case where buffers =
are
> > > > > > > > > > > > > allocated
> > > > > > > > > > > > > by
> > > > > > > > > > > > > virtio-gpu, right?
> > > > > > > > > > > > > In this case, virtio-gpu allocates one contiguous
> > > > > > > > > > > > > host-side
> > > > > > > > > > > > > buffer
> > > > > > > > > > > > > and
> > > > > > > > > > > > > the client regards a pair of (buffer FD, offset) =
as
> > > > > > > > > > > > > one
> > > > > > > > > > > > > channel.
> > > > > > > > > > > > > And, we can register this pair to the device when=
 the
> > > > > > > > > > > > > buffer
> > > > > > > > > > > > > is
> > > > > > > > > > > > > imported.
> > > > > > > > > > > > > In the virtio-vdec spec draft, this pair correspo=
nds
> > > > > > > > > > > > > to
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > virtio_vdec_plane in struct virtio_vdec_plane.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, I suppose we will need similar structs when w=
e add
> > > > > > > > > > > > > a
> > > > > > > > > > > > > control
> > > > > > > > > > > > > to
> > > > > > > > > > > > > import buffers. However, I don't think it's neces=
sary
> > > > > > > > > > > > > when
> > > > > > > > > > > > > guest
> > > > > > > > > > > > > pages
> > > > > > > > > > > > > are used.
> > > > > > > > > > > >
> > > > > > > > > > > > I think we need some way for the guest to know whet=
her
> > > > > > > > > > > > it
> > > > > > > > > > > > can
> > > > > > > > > > > > allocate
> > > > > > > > > > > > the planes in separate buffers, even when guest pag=
es
> > > > > > > > > > > > are
> > > > > > > > > > > > used.
> > > > > > > > > > > > This
> > > > > > > > > > > > would be equivalent to V4L2 M and non-M formats, bu=
t
> > > > > > > > > > > > mixing
> > > > > > > > > > > > this
> > > > > > > > > > > > into
> > > > > > > > > > > > FourCC in V4L2 is an acknowledged mistake, so we sh=
ould
> > > > > > > > > > > > add
> > > > > > > > > > > > a
> > > > > > > > > > > > query or
> > > > > > > > > > > > something.
> > > > > > > > > >
> > > > > > > > > > Yes, this is what I mean. In fact, we already do face t=
he
> > > > > > > > > > situation
> > > > > > > > > > when
> > > > > > > > > > the device side is not happy with the sgt and wants con=
tig.
> > > > > > > > > > I
> > > > > > > > > > think
> > > > > > > > > > we'll
> > > > > > > > > > add a module parameter for now.
> > > > > > > > >
> > > > > > > > > Okay. So, I suppose we'll be able to update structs:
> > > > > > > > > * Add a flag in virtio_video_format_desc that indicates
> > > > > > > > > whether
> > > > > > > > > planes
> > > > > > > > > can be in separate buffers, and
> > > > > > > > > * Add a flag in virtio_video_format_desc that indicates t=
hat
> > > > > > > > > the
> > > > > > > > > device requires contiguous buffers for this format.
> > > > > > > > >
> > > > > > > > > Does it make sense?
> > > > > > > >
> > > > > > > > Sorry, I don't understand the difference between the two ab=
ove:
> > > > > > > > isn't
> > > > > > > > the
> > > > > > > > first case is just when the flag is not set?
> > > > > > >
> > > > > > > Ah, I was confused and wrote something strange. Yeah,  these =
two
> > > > > > > are
> > > > > > > the
> > > > > > > same. Sorry for that.
> > > > > > >
> > > > > > > So, the suggestion is to add a field "planes_layout" in
> > > > > > > virtio_video_format_desc, which is one of the following enums=
:
> > > > > > >
> > > > > > > enum virtio_video_planes_layout {
> > > > > > >
> > > > > > >     VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* no special
> > > > > > >     requirement
> > > > > > >     */
> > > > > > >     VIRTIO_VIDEO_PLANES_LAYOUT_CONTIGUOUS,
> > > > > > >
> > > > > > > };
> > > > > > >
> > > > > > > If we have a better idea or naming, please let me know.
> > > > > >
> > > > > > The naming looks good for me, I might only change to CONTIG as =
we
> > > > > > have
> > > > > > UNSPEC.
> > > > >
> > > > > So here we are talking about plane layout in memory, am I correct=
? But
> > > > > I
> > > > > think we also need a way to communicate memory requirements of th=
e
> > > > > device: the device might require CMA buffers or it can be ok with=
 SG
> > > > > lists. What about adding something like this to
> > > > > virtio_video_format_desc:
> > > > >
> > > > > enum virtio_video_mem_layout {
> > > > >
> > > > >         VIRTIO_VIDEO_MEM_LAYOUT_UNDEFINED =3D 0,
> > > > >
> > > > >         VIRTIO_VIDEO_MEM_LAYOUT_CONTIG =3D 0x100,
> > > > >         VIRTIO_VIDEO_MEM_LAYOUT_NON_CONTIG,
> > > > >
> > > > > };
> > > > >
> > > > > struct virtio_video_format_desc {
> > > > >
> > > > >     __le64 mask;
> > > > >     __le32 format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > > > >     __le32 planes_layout; /* One of VIRTIO_VIDEO_PLANES_LAYOUT_* =
types
> > > > >     */
> > > > >     __le32 mem_layout; /* One of VIRTIO_VIDEO_MEM_LAYOUT_* types =
*/
> > > > >     ...
> > > > >
> > > > > };
> > > >
> > > > Good.
> > > > I'd not like to call it NON_CONTIG, as it sounds like CMA buffers
> > > > aren't allowed.
> > > > Instead, how about this definition?
> > > >
> > > > enum virtio_video_mem_layout {
> > > >
> > > >         VIRTIO_VIDEO_MEM_LAYOUT_UNSPEC =3D 0,  /* no special requir=
ement
> > > >         */
> > > >         VIRTIO_VIDEO_MEM_LAYOUT_CONTIG =3D 1,
> > > >
> > > > };
> > >
> > > Yes, I agree, that would be more correct. We just need an empty line =
to be
> > > aligned with other enums.
> > >
> > > > With this enum,
> > > > * the device can simply ignore this field if it doesn't have any
> > > > requirement and the struct is zero-initialized, and
> > > > * if we need to add other types of memory layout requirements, we c=
an
> > > > add them as 2, 4, 8, etc to represent combinations of requirements.
> > > >
> > > > Just to confirm, are the following combination of planes_layout and
> > > > mem_layout valid?
> > > > (1) (planes_layout, mem_layout) =3D (contig, not specified)
> > > > (2) (planes_layout, mem_layout) =3D (not specified, contig)
> > > >
> > > > In my understanding, (1) means that each plane must be a contiguous
> > > > buffer while different planes don't have to be in a contig memory, =
but
> > > > (2) is invalid.
> > > > Is it correct?
> > >
> > > Let me tell a bit more about my vision:
> > >
> > > mem_layout: device can handle SG lists (e.g. using iommu) or it canno=
t and
> > > needs CMA. If it can handle SG, CMA is also ok. So it is ether 'I don=
't
> > > care' or 'give me CMA'.
> > >
> > > planes_layout: some devices might want to see multiplanar data in one
> > > buffer. So if we allocate two sets of mem entries (one per each plane=
)
> > > and send them to the host, the device will fail to handle those.
> > >
> > > So from my perspective you example can be interpreted as follows:
> > > (1) means all your planes are hosted by one buffer instance (we can s=
ee it
> > > as one fd for all planes plus per-plane offsets inside the buffer), t=
he
> > > buffer itself consists of arbitrary pages (or can consist, as it can =
of
> > > course also be CMA, because of UNSPEC).
> > > (2) valid, means each plane has its own buffer, each buffer is contig=
uous
> > > in memory (must be allocated from CMA), but planes are not necessaril=
y
> > > adjacent to each other in memory.
> > >
> > > This also means that we cannot have unspec for planes layout. Device
> > > either
> > > expects planes in separate buffers or in one buffer with some offsets=
,
> > > there cannot be mixed cases.
> >
> > I might be misunderstanding the above, but just to make sure we're on
> > the same page, here are the cases that we found to exist in practice
> > with V4L2 stateful decoders:
> >
> > 1) device expects planes in one buffer laid out one after another
> > without any padding; the device accepts only 1 pointer and no offsets
> > - this corresponds to V4L2 non-M formats, such as NV12, which exactly
> > specify the location of planes in the buffer,
> >
> > 2) device accepts separate pointers to all planes - the planes can be
> > located anywhere in memory, which could be separate buffers, 1 buffer
> > with planes laid out at arbitrary offsets or even exactly the same
> > layout as required for 1).
> >
> > 3) device _requires_ planes to be located in separate buffers
> > allocated from designated areas in memory, e.g. different physical
> > memory banks, for performance purposes. This is actually a very rare
> > case and observed only on old generations of Samsung Exynos SoCs.
> >
> > Please let me know if that matches your expectation,
> >
>
> Thank you for the update!
>
> Yes, I think this matches our expectations, and this also does not contra=
dict
> the enums I provided in the previous email.
>
> Btw, you haven't mentioned anything regarding mem layout. Do you agree wi=
th
> what was proposed?

Tomasz, do you find any thought on mem layout Dmitry suggested?

I have one question about mem layout.
When the device reports VIRTIO_VIDEO_MEM_LAYOUT_UNSPEC, doesn't the
driver want to tell whether it uses contiguous memory or not?
In other words, I'm wondering if we should have a field "mem_layout"
in virtio_video_resource_create to store one of enum
virtio_video_mem_layout type.
If so,  we might want to add a new type like
VIRTIO_VIDEO_MEM_LAYOUT_SG_LIST to tell that contiguous memories
aren't used.

Best regards,
Keiichi


Best regards,
Keiichi

>
> Best regards,
> Dmitry
>
> > Best regards,
> > Tomasz
> >
> > > So it should look like this:
> > >
> > > enum virtio_video_planes_layout {
> > >
> > >     VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* default, invalid */
> > >
> > >     VIRTIO_VIDEO_PLANES_LAYOUT_CONTIG =3D 0x100,
> > >     VIRTIO_VIDEO_PLANES_LAYOUT_NON_CONTIG,
> > >
> > > };
> > >
> > > Best regards,
> > > Dmitry
> > >
> > > > Best regards,
> > > > Keiichi
> > > >
> > > > > Best regards,
> > > > > Dmitry.
> > > > >
> > > > > > Best regards,
> > > > > > Dmitry.
> > > > > >
> > > > > > > Best regards,
> > > > > > > Keiichi
> > > > > > >
> > > > > > > > Regards,
> > > > > > > > Dmitry.
> > > > > > > >
> > > > > > > > > Best regards,
> > > > > > > > > Keiichi
> > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Dmitry.
> > > > > > > > > >
> > > > > > > > > > > > For future V4L2 development we came up with the ide=
a of
> > > > > > > > > > > > a
> > > > > > > > > > > > format
> > > > > > > > > > > > flag
> > > > > > > > > > > > which could mean that the hardware allows putting p=
lanes
> > > > > > > > > > > > in
> > > > > > > > > > > > separate
> > > > > > > > > > > > buffers. We could have a similar per-format flag in=
 the
> > > > > > > > > > > > capabilities,
> > > > > > > > > > > > as we already have a list of all the supported form=
ats
> > > > > > > > > > > > there.
> > > > > > > > > > >
> > > > > > > > > > > Sorry, forgot to paste the link from future V4L2 work
> > > > > > > > > > > notes
> > > > > > > > > > > from
> > > > > > > > > > > this
> > > > > > > > > > > year
> > > > > > > > > > > ELCE:
> > > > > > > > > > > https://www.spinics.net/lists/linux-media/msg159789.h=
tml
> > > > > > > > > > >
> > > > > > > > > > > > Best regards,
> > > > > > > > > > > > Tomasz
> > > > > > > > > > > >
> > > > > > > > > > > > > Best regards,
> > > > > > > > > > > > > Keiichi
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Best regards,
> > > > > > > > > > > > > > Dmitry.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Renamed virtio_video_pin to
> > > > > > > > > > > > > > > virtio_video_buf_type.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTP=
UT,
> > > > > > > > > > > > > > >   CAPTURE}.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > * Added an error event.
> > > > > > > > > > > > > > > * Reordered some subsections.
> > > > > > > > > > > > > > > * Changed styles to make it consistent with o=
ther
> > > > > > > > > > > > > > > devices.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Dmitry Sepp (1):
> > > > > > > > > > > > > > >   virtio-video: Add virtio video device
> > > > > > > > > > > > > > >   specification
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  content.tex      |   1 +
> > > > > > > > > > > > > > >  virtio-video.tex | 579
> > > > > > > > > > > > > > >  ++++++++++++++++++++++++++++++++++++++++++++=
+++
> > > > > > > > > > > > > > >  2 files changed, 580 insertions(+)
> > > > > > > > > > > > > > >  create mode 100644 virtio-video.tex
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > 2.24.1.735.g03f4e72817-goog
> > > > > >
> > > > > > ---------------------------------------------------------------=
-----
> > > > > > -
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > > > > > For additional commands, e-mail:
> > > > > > virtio-dev-help@lists.oasis-open.org
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

