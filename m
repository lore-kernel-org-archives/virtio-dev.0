Return-Path: virtio-dev-return-6646-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD672985EE1
	for <virtio-dev@lists.oasis-open.org>; Sat, 11 Jan 2020 16:07:03 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <2137719.ElGaqSPkdT@os-lin-dmo> <CAD90Vcbk5DerrFNQdH1wdAX=HxBjMz9-FoNiWm_ryvwsA_YvYA@mail.gmail.com>
 <7740094.NyiUUSuA9g@os-lin-dmo>
In-Reply-To: <7740094.NyiUUSuA9g@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sun, 12 Jan 2020 01:06:46 +0900
Message-ID: <CAAFQd5DwrrkEigKZ4fRE6GXAa+rvjm6QQYfDCxm85esQBdnh-A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Jan 11, 2020 at 12:12 AM Dmitry Sepp
<dmitry.sepp@opensynergy.com> wrote:
>
> Hi Keiichi,
>
> On Freitag, 10. Januar 2020 14:53:01 CET Keiichi Watanabe wrote:
> > Hi,
> >
> > On Fri, Jan 10, 2020 at 7:16 PM Dmitry Sepp <dmitry.sepp@opensynergy.co=
m>
> wrote:
> > > Hi,
> > >
> > > On Donnerstag, 9. Januar 2020 15:56:08 CET Dmitry Sepp wrote:
> > > > Hi,
> > > >
> > > > On Dienstag, 7. Januar 2020 11:25:56 CET Keiichi Watanabe wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > On Mon, Jan 6, 2020 at 8:28 PM Dmitry Sepp
> > > > > <dmitry.sepp@opensynergy.com>
> > > >
> > > > wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Montag, 6. Januar 2020 11:30:22 CET Keiichi Watanabe wrote:
> > > > > > > Hi Dmitry, Tomasz,
> > > > > > >
> > > > > > > On Fri, Jan 3, 2020 at 10:05 PM Dmitry Sepp
> > > > > > > <dmitry.sepp@opensynergy.com>
> > > > > >
> > > > > > wrote:
> > > > > > > > Hi Tomasz, Keiichi,
> > > > > > > >
> > > > > > > > On Samstag, 21. Dezember 2019 07:19:23 CET Tomasz Figa wrot=
e:
> > > > > > > > > On Sat, Dec 21, 2019 at 3:18 PM Tomasz Figa
> > > > > > > > > <tfiga@chromium.org>
> > > >
> > > > wrote:
> > > > > > > > > > On Sat, Dec 21, 2019 at 1:36 PM Keiichi Watanabe
> > > > > > > > > > <keiichiw@chromium.org>
> > > > > > > >
> > > > > > > > wrote:
> > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, Dec 21, 2019 at 12:59 AM Dmitry Sepp
> > > > > > > > > > >
> > > > > > > > > > > <dmitry.sepp@opensynergy.com> wrote:
> > > > > > > > > > > > Hi Keiichi,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mittwoch, 18. Dezember 2019 14:02:13 CET Keiichi
> > > > > > > > > > > > Watanabe
> > > > > >
> > > > > > wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > This is the 2nd version of virtio-video patch. Th=
e PDF
> > > > > > > > > > > > > is
> > > > > > > > > > > > > available
> > > > > > > > > > > > > in [1].
> > > > > > > > > > > > > The first version was sent at [2].
> > > > > > > > > > > > >
> > > > > > > > > > > > > Any feedback would be appreciated. Thank you.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Best,
> > > > > > > > > > > > > Keiichi
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1]:
> > > > > > > > > > > > > https://drive.google.com/drive/folders/1eT5fEckBo=
or2iH
> > > > > > > > > > > > > ZR4f
> > > > > > > > > > > > > 4G
> > > > > > > > > > > > > LxYz
> > > > > > > > > > > > > FMVa
> > > > > > > > > > > > > pOFx?us
> > > > > > > > > > > > > p=3Dsharing [2]:
> > > > > > > > > > > > > https://markmail.org/message/gc6h25acct22niut
> > > > > > > > > > > > >
> > > > > > > > > > > > > Change log:
> > > > > > > > > > > > >
> > > > > > > > > > > > > v2:
> > > > > > > > > > > > > * Removed functionalities except encoding and
> > > > > > > > > > > > > decoding.
> > > > > > > > > > > > > * Splited encoder and decoder into different devi=
ces
> > > > > > > > > > > > > that
> > > > > > > > > > > > > use
> > > > > > > > > > > > > the
> > > > > > > > > > > > > same
> > > > > > > > > > > > > protocol. * Replaced GET_FUNCS with GET_CAPABILIT=
Y.
> > > > > > > > > > > > > * Updated structs for capabilities.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - Defined new structs and enums such as image
> > > > > > > > > > > > >   formats,
> > > > > > > > > > > > >   profiles,
> > > > > > > > > > > > >   range
> > > > > > > > > > > > >
> > > > > > > > > > > > > (min, max, step), etc
> > > > > > > > > > > > >
> > > > > > > > > > > > >     * For virtio_video_pixel_format, chose a nami=
ng
> > > > > > > > > > > > >     convention
> > > > > > > > > > > > >     that
> > > > > > > > > > > > >     is used
> > > > > > > > > > > > >
> > > > > > > > > > > > >       in DRM. We removed XBGR, NV21 and I422, as =
they
> > > > > > > > > > > > >       are
> > > > > > > > > > > > >       not
> > > > > > > > > > > > >       used
> > > > > > > > > > > > >       in the
> > > > > > > > > > > > >       current draft implementation.
> > > > > > > > > > > > >       https://lwn.net/Articles/806416/
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - Removed virtio_video_control, whose usage was=
 not
> > > > > > > > > > > > >   documented
> > > > > > > > > > > > >   yet
> > > > > > > > > > > > >   and
> > > > > > > > > > > > >
> > > > > > > > > > > > > which is not necessary for the simplest decoding
> > > > > > > > > > > > > scenario.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - Removed virtio_video_desc, as it is no longer
> > > > > > > > > > > > >   needed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > * Updated struct virtio_video_config for changes
> > > > > > > > > > > > > around
> > > > > > > > > > > > > capabilities.
> > > > > > > > > > > > > * Added a way to represent supported combinations=
 of
> > > > > > > > > > > > > formats.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - A field "mask" in virtio_video_format_desc pl=
ays
> > > > > > > > > > > > >   this
> > > > > > > > > > > > >   role.
> > > > > > > > > > > > >
> > > > > > > > > > > > > * Removed VIRTIO_VIDEO_T_STREAM_{START,STOP} beca=
use
> > > > > > > > > > > > > they
> > > > > > > > > > > > > don't
> > > > > > > > > > > > > play
> > > > > > > > > > > > > any
> > > > > > > > > > > > > meaningful roles. * Removed
> > > > > > > > > > > > > VIRTIO_VIDEO_T_STREAM_{ATTACH,
> > > > > > > > > > > > > DETACH}_BACKING
> > > > > > > > > > > > > and merged them into RESOURCE_{CREATE, DESTROY}. =
*
> > > > > > > > > > > > > Added a
> > > > > > > > > > > > > way
> > > > > > > > > > > > > to
> > > > > > > > > > > > > notify/specify resource creation method.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - Added a feature flag.
> > > > > > > > > > > > >   - Defined enum virtio_video_mem_type.
> > > > > > > > > > > > >   - Added new fields in video_stream_create.
> > > > > > > > > > > > >
> > > > > > > > > > > > > * Modified fields in virtio_video_params.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - Added crop information.
> > > > > > > > > > > > >
> > > > > > > > > > > > > * Removed enum virtio_video_channel_type because =
we
> > > > > > > > > > > > > can
> > > > > > > > > > > > > get
> > > > > > > > > > > > > this
> > > > > > > > > > > > > information by image format.
> > > > > > > > > > > >
> > > > > > > > > > > > Could you please explain this? How do you get the
> > > > > > > > > > > > information?
> > > > > > > > > > >
> > > > > > > > > > > It means that if image formats are well-defined, chan=
nel
> > > > > > > > > > > information
> > > > > > > > > > > (e.g. the order of channels) is uniquely determined.
> > > > > > > > > > >
> > > > > > > > > > > > Suppose you have some piece of HW on the host side =
that
> > > > > > > > > > > > wants
> > > > > > > > > > > > I420
> > > > > > > > > > > > as
> > > > > > > > > > > > one
> > > > > > > > > > > > contig buffer w/ some offsets. But on the driver si=
de,
> > > > > > > > > > > > say,
> > > > > > > > > > > > gralloc
> > > > > > > > > > > > gives you three separate buffers, one per channel. =
How
> > > > > > > > > > > > do we
> > > > > > > > > > > > pass
> > > > > > > > > > > > those to the device then?
> > > > > > > > > > >
> > > > > > > > > > > You're talking about CrOS use case where buffers are
> > > > > > > > > > > allocated
> > > > > > > > > > > by
> > > > > > > > > > > virtio-gpu, right?
> > > > > > > > > > > In this case, virtio-gpu allocates one contiguous
> > > > > > > > > > > host-side
> > > > > > > > > > > buffer
> > > > > > > > > > > and
> > > > > > > > > > > the client regards a pair of (buffer FD, offset) as o=
ne
> > > > > > > > > > > channel.
> > > > > > > > > > > And, we can register this pair to the device when the
> > > > > > > > > > > buffer
> > > > > > > > > > > is
> > > > > > > > > > > imported.
> > > > > > > > > > > In the virtio-vdec spec draft, this pair corresponds =
to
> > > > > > > > > > > struct
> > > > > > > > > > > virtio_vdec_plane in struct virtio_vdec_plane.
> > > > > > > > > > >
> > > > > > > > > > > So, I suppose we will need similar structs when we ad=
d a
> > > > > > > > > > > control
> > > > > > > > > > > to
> > > > > > > > > > > import buffers. However, I don't think it's necessary=
 when
> > > > > > > > > > > guest
> > > > > > > > > > > pages
> > > > > > > > > > > are used.
> > > > > > > > > >
> > > > > > > > > > I think we need some way for the guest to know whether =
it
> > > > > > > > > > can
> > > > > > > > > > allocate
> > > > > > > > > > the planes in separate buffers, even when guest pages a=
re
> > > > > > > > > > used.
> > > > > > > > > > This
> > > > > > > > > > would be equivalent to V4L2 M and non-M formats, but mi=
xing
> > > > > > > > > > this
> > > > > > > > > > into
> > > > > > > > > > FourCC in V4L2 is an acknowledged mistake, so we should=
 add
> > > > > > > > > > a
> > > > > > > > > > query or
> > > > > > > > > > something.
> > > > > > > >
> > > > > > > > Yes, this is what I mean. In fact, we already do face the
> > > > > > > > situation
> > > > > > > > when
> > > > > > > > the device side is not happy with the sgt and wants contig.=
 I
> > > > > > > > think
> > > > > > > > we'll
> > > > > > > > add a module parameter for now.
> > > > > > >
> > > > > > > Okay. So, I suppose we'll be able to update structs:
> > > > > > > * Add a flag in virtio_video_format_desc that indicates wheth=
er
> > > > > > > planes
> > > > > > > can be in separate buffers, and
> > > > > > > * Add a flag in virtio_video_format_desc that indicates that =
the
> > > > > > > device requires contiguous buffers for this format.
> > > > > > >
> > > > > > > Does it make sense?
> > > > > >
> > > > > > Sorry, I don't understand the difference between the two above:
> > > > > > isn't
> > > > > > the
> > > > > > first case is just when the flag is not set?
> > > > >
> > > > > Ah, I was confused and wrote something strange. Yeah,  these two =
are
> > > > > the
> > > > > same. Sorry for that.
> > > > >
> > > > > So, the suggestion is to add a field "planes_layout" in
> > > > > virtio_video_format_desc, which is one of the following enums:
> > > > >
> > > > > enum virtio_video_planes_layout {
> > > > >
> > > > >     VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* no special requi=
rement
> > > > >     */
> > > > >     VIRTIO_VIDEO_PLANES_LAYOUT_CONTIGUOUS,
> > > > >
> > > > > };
> > > > >
> > > > > If we have a better idea or naming, please let me know.
> > > >
> > > > The naming looks good for me, I might only change to CONTIG as we h=
ave
> > > > UNSPEC.
> > >
> > > So here we are talking about plane layout in memory, am I correct? Bu=
t I
> > > think we also need a way to communicate memory requirements of the
> > > device: the device might require CMA buffers or it can be ok with SG
> > > lists. What about adding something like this to virtio_video_format_d=
esc:
> > >
> > > enum virtio_video_mem_layout {
> > >
> > >         VIRTIO_VIDEO_MEM_LAYOUT_UNDEFINED =3D 0,
> > >
> > >         VIRTIO_VIDEO_MEM_LAYOUT_CONTIG =3D 0x100,
> > >         VIRTIO_VIDEO_MEM_LAYOUT_NON_CONTIG,
> > >
> > > };
> > >
> > > struct virtio_video_format_desc {
> > >
> > >     __le64 mask;
> > >     __le32 format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > >     __le32 planes_layout; /* One of VIRTIO_VIDEO_PLANES_LAYOUT_* type=
s */
> > >     __le32 mem_layout; /* One of VIRTIO_VIDEO_MEM_LAYOUT_* types */
> > >     ...
> > >
> > > };
> >
> > Good.
> > I'd not like to call it NON_CONTIG, as it sounds like CMA buffers
> > aren't allowed.
> > Instead, how about this definition?
> >
> > enum virtio_video_mem_layout {
> >         VIRTIO_VIDEO_MEM_LAYOUT_UNSPEC =3D 0,  /* no special requiremen=
t */
> >         VIRTIO_VIDEO_MEM_LAYOUT_CONTIG =3D 1,
> > };
>
> Yes, I agree, that would be more correct. We just need an empty line to b=
e
> aligned with other enums.
>
> >
> > With this enum,
> > * the device can simply ignore this field if it doesn't have any
> > requirement and the struct is zero-initialized, and
> > * if we need to add other types of memory layout requirements, we can
> > add them as 2, 4, 8, etc to represent combinations of requirements.
> >
> > Just to confirm, are the following combination of planes_layout and
> > mem_layout valid?
> > (1) (planes_layout, mem_layout) =3D (contig, not specified)
> > (2) (planes_layout, mem_layout) =3D (not specified, contig)
> >
> > In my understanding, (1) means that each plane must be a contiguous
> > buffer while different planes don't have to be in a contig memory, but
> > (2) is invalid.
> > Is it correct?
>
> Let me tell a bit more about my vision:
>
> mem_layout: device can handle SG lists (e.g. using iommu) or it cannot an=
d
> needs CMA. If it can handle SG, CMA is also ok. So it is ether 'I don't c=
are'
> or 'give me CMA'.
>
> planes_layout: some devices might want to see multiplanar data in one buf=
fer.
> So if we allocate two sets of mem entries (one per each plane) and send t=
hem
> to the host, the device will fail to handle those.
>
> So from my perspective you example can be interpreted as follows:
> (1) means all your planes are hosted by one buffer instance (we can see i=
t as
> one fd for all planes plus per-plane offsets inside the buffer), the buff=
er
> itself consists of arbitrary pages (or can consist, as it can of course a=
lso
> be CMA, because of UNSPEC).
> (2) valid, means each plane has its own buffer, each buffer is contiguous=
 in
> memory (must be allocated from CMA), but planes are not necessarily adjac=
ent
> to each other in memory.
>
> This also means that we cannot have unspec for planes layout. Device eith=
er
> expects planes in separate buffers or in one buffer with some offsets, th=
ere
> cannot be mixed cases.

I might be misunderstanding the above, but just to make sure we're on
the same page, here are the cases that we found to exist in practice
with V4L2 stateful decoders:

1) device expects planes in one buffer laid out one after another
without any padding; the device accepts only 1 pointer and no offsets
- this corresponds to V4L2 non-M formats, such as NV12, which exactly
specify the location of planes in the buffer,

2) device accepts separate pointers to all planes - the planes can be
located anywhere in memory, which could be separate buffers, 1 buffer
with planes laid out at arbitrary offsets or even exactly the same
layout as required for 1).

3) device _requires_ planes to be located in separate buffers
allocated from designated areas in memory, e.g. different physical
memory banks, for performance purposes. This is actually a very rare
case and observed only on old generations of Samsung Exynos SoCs.

Please let me know if that matches your expectation,

Best regards,
Tomasz

> So it should look like this:
>
> enum virtio_video_planes_layout {
>     VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* default, invalid */
>
>     VIRTIO_VIDEO_PLANES_LAYOUT_CONTIG =3D 0x100,
>     VIRTIO_VIDEO_PLANES_LAYOUT_NON_CONTIG,
> };
>
> Best regards,
> Dmitry
>
> >
> > Best regards,
> > Keiichi
> >
> > > Best regards,
> > > Dmitry.
> > >
> > > > Best regards,
> > > > Dmitry.
> > > >
> > > > > Best regards,
> > > > > Keiichi
> > > > >
> > > > > > Regards,
> > > > > > Dmitry.
> > > > > >
> > > > > > > Best regards,
> > > > > > > Keiichi
> > > > > > >
> > > > > > > > Regards,
> > > > > > > > Dmitry.
> > > > > > > >
> > > > > > > > > > For future V4L2 development we came up with the idea of=
 a
> > > > > > > > > > format
> > > > > > > > > > flag
> > > > > > > > > > which could mean that the hardware allows putting plane=
s in
> > > > > > > > > > separate
> > > > > > > > > > buffers. We could have a similar per-format flag in the
> > > > > > > > > > capabilities,
> > > > > > > > > > as we already have a list of all the supported formats
> > > > > > > > > > there.
> > > > > > > > >
> > > > > > > > > Sorry, forgot to paste the link from future V4L2 work not=
es
> > > > > > > > > from
> > > > > > > > > this
> > > > > > > > > year
> > > > > > > > > ELCE: https://www.spinics.net/lists/linux-media/msg159789=
.html
> > > > > > > > >
> > > > > > > > > > Best regards,
> > > > > > > > > > Tomasz
> > > > > > > > > >
> > > > > > > > > > > Best regards,
> > > > > > > > > > > Keiichi
> > > > > > > > > > >
> > > > > > > > > > > > Best regards,
> > > > > > > > > > > > Dmitry.
> > > > > > > > > > > >
> > > > > > > > > > > > > * Renamed virtio_video_pin to virtio_video_buf_ty=
pe.
> > > > > > > > > > > > >
> > > > > > > > > > > > >   - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTPUT,
> > > > > > > > > > > > >   CAPTURE}.
> > > > > > > > > > > > >
> > > > > > > > > > > > > * Added an error event.
> > > > > > > > > > > > > * Reordered some subsections.
> > > > > > > > > > > > > * Changed styles to make it consistent with other
> > > > > > > > > > > > > devices.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Dmitry Sepp (1):
> > > > > > > > > > > > >   virtio-video: Add virtio video device specifica=
tion
> > > > > > > > > > > > >
> > > > > > > > > > > > >  content.tex      |   1 +
> > > > > > > > > > > > >  virtio-video.tex | 579
> > > > > > > > > > > > >  +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > > > >  2 files changed, 580 insertions(+)
> > > > > > > > > > > > >  create mode 100644 virtio-video.tex
> > > > > > > > > > > > >
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.24.1.735.g03f4e72817-goog
> > > >
> > > > -------------------------------------------------------------------=
--
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

