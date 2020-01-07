Return-Path: virtio-dev-return-6604-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37DDB985D85
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Jan 2020 10:26:10 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <3016670.ToaXtcqt80@os-lin-dmo> <CAD90VcYtS1ZRdikyHGZPcXQMVC7MuNsAhBGAWwiVpGgO3Yittg@mail.gmail.com>
 <2751629.YRu87Tu1Bo@os-lin-dmo>
In-Reply-To: <2751629.YRu87Tu1Bo@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 7 Jan 2020 19:25:56 +0900
Message-ID: <CAD90VcaQCSFTv-JyxZ7cO+Qnc0U2NRGikcYmmy=zitJby9NfXg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,

On Mon, Jan 6, 2020 at 8:28 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wr=
ote:
>
> Hi,
>
> On Montag, 6. Januar 2020 11:30:22 CET Keiichi Watanabe wrote:
> > Hi Dmitry, Tomasz,
> >
> > On Fri, Jan 3, 2020 at 10:05 PM Dmitry Sepp <dmitry.sepp@opensynergy.co=
m>
> wrote:
> > > Hi Tomasz, Keiichi,
> > >
> > > On Samstag, 21. Dezember 2019 07:19:23 CET Tomasz Figa wrote:
> > > > On Sat, Dec 21, 2019 at 3:18 PM Tomasz Figa <tfiga@chromium.org> wr=
ote:
> > > > > On Sat, Dec 21, 2019 at 1:36 PM Keiichi Watanabe
> > > > > <keiichiw@chromium.org>
> > >
> > > wrote:
> > > > > > Hi Dmitry,
> > > > > >
> > > > > > On Sat, Dec 21, 2019 at 12:59 AM Dmitry Sepp
> > > > > >
> > > > > > <dmitry.sepp@opensynergy.com> wrote:
> > > > > > > Hi Keiichi,
> > > > > > >
> > > > > > > On Mittwoch, 18. Dezember 2019 14:02:13 CET Keiichi Watanabe
> wrote:
> > > > > > > > Hi,
> > > > > > > > This is the 2nd version of virtio-video patch. The PDF is
> > > > > > > > available
> > > > > > > > in [1].
> > > > > > > > The first version was sent at [2].
> > > > > > > >
> > > > > > > > Any feedback would be appreciated. Thank you.
> > > > > > > >
> > > > > > > > Best,
> > > > > > > > Keiichi
> > > > > > > >
> > > > > > > > [1]:
> > > > > > > > https://drive.google.com/drive/folders/1eT5fEckBoor2iHZR4f4=
GLxYz
> > > > > > > > FMVa
> > > > > > > > pOFx?us
> > > > > > > > p=3Dsharing [2]: https://markmail.org/message/gc6h25acct22n=
iut
> > > > > > > >
> > > > > > > > Change log:
> > > > > > > >
> > > > > > > > v2:
> > > > > > > > * Removed functionalities except encoding and decoding.
> > > > > > > > * Splited encoder and decoder into different devices that u=
se
> > > > > > > > the
> > > > > > > > same
> > > > > > > > protocol. * Replaced GET_FUNCS with GET_CAPABILITY.
> > > > > > > > * Updated structs for capabilities.
> > > > > > > >
> > > > > > > >   - Defined new structs and enums such as image formats,
> > > > > > > >   profiles,
> > > > > > > >   range
> > > > > > > >
> > > > > > > > (min, max, step), etc
> > > > > > > >
> > > > > > > >     * For virtio_video_pixel_format, chose a naming convent=
ion
> > > > > > > >     that
> > > > > > > >     is used
> > > > > > > >
> > > > > > > >       in DRM. We removed XBGR, NV21 and I422, as they are n=
ot
> > > > > > > >       used
> > > > > > > >       in the
> > > > > > > >       current draft implementation.
> > > > > > > >       https://lwn.net/Articles/806416/
> > > > > > > >
> > > > > > > >   - Removed virtio_video_control, whose usage was not docum=
ented
> > > > > > > >   yet
> > > > > > > >   and
> > > > > > > >
> > > > > > > > which is not necessary for the simplest decoding scenario.
> > > > > > > >
> > > > > > > >   - Removed virtio_video_desc, as it is no longer needed.
> > > > > > > >
> > > > > > > > * Updated struct virtio_video_config for changes around
> > > > > > > > capabilities.
> > > > > > > > * Added a way to represent supported combinations of format=
s.
> > > > > > > >
> > > > > > > >   - A field "mask" in virtio_video_format_desc plays this r=
ole.
> > > > > > > >
> > > > > > > > * Removed VIRTIO_VIDEO_T_STREAM_{START,STOP} because they d=
on't
> > > > > > > > play
> > > > > > > > any
> > > > > > > > meaningful roles. * Removed VIRTIO_VIDEO_T_STREAM_{ATTACH,
> > > > > > > > DETACH}_BACKING
> > > > > > > > and merged them into RESOURCE_{CREATE, DESTROY}. * Added a =
way
> > > > > > > > to
> > > > > > > > notify/specify resource creation method.
> > > > > > > >
> > > > > > > >   - Added a feature flag.
> > > > > > > >   - Defined enum virtio_video_mem_type.
> > > > > > > >   - Added new fields in video_stream_create.
> > > > > > > >
> > > > > > > > * Modified fields in virtio_video_params.
> > > > > > > >
> > > > > > > >   - Added crop information.
> > > > > > > >
> > > > > > > > * Removed enum virtio_video_channel_type because we can get=
 this
> > > > > > > > information by image format.
> > > > > > >
> > > > > > > Could you please explain this? How do you get the information=
?
> > > > > >
> > > > > > It means that if image formats are well-defined, channel inform=
ation
> > > > > > (e.g. the order of channels) is uniquely determined.
> > > > > >
> > > > > > > Suppose you have some piece of HW on the host side that wants=
 I420
> > > > > > > as
> > > > > > > one
> > > > > > > contig buffer w/ some offsets. But on the driver side, say,
> > > > > > > gralloc
> > > > > > > gives you three separate buffers, one per channel. How do we =
pass
> > > > > > > those to the device then?
> > > > > >
> > > > > > You're talking about CrOS use case where buffers are allocated =
by
> > > > > > virtio-gpu, right?
> > > > > > In this case, virtio-gpu allocates one contiguous host-side buf=
fer
> > > > > > and
> > > > > > the client regards a pair of (buffer FD, offset) as one channel=
.
> > > > > > And, we can register this pair to the device when the buffer is
> > > > > > imported.
> > > > > > In the virtio-vdec spec draft, this pair corresponds to struct
> > > > > > virtio_vdec_plane in struct virtio_vdec_plane.
> > > > > >
> > > > > > So, I suppose we will need similar structs when we add a contro=
l to
> > > > > > import buffers. However, I don't think it's necessary when gues=
t
> > > > > > pages
> > > > > > are used.
> > > > >
> > > > > I think we need some way for the guest to know whether it can all=
ocate
> > > > > the planes in separate buffers, even when guest pages are used. T=
his
> > > > > would be equivalent to V4L2 M and non-M formats, but mixing this =
into
> > > > > FourCC in V4L2 is an acknowledged mistake, so we should add a que=
ry or
> > > > > something.
> > >
> > > Yes, this is what I mean. In fact, we already do face the situation w=
hen
> > > the device side is not happy with the sgt and wants contig. I think w=
e'll
> > > add a module parameter for now.
> >
> > Okay. So, I suppose we'll be able to update structs:
> > * Add a flag in virtio_video_format_desc that indicates whether planes
> > can be in separate buffers, and
> > * Add a flag in virtio_video_format_desc that indicates that the
> > device requires contiguous buffers for this format.
> >
> > Does it make sense?
> >
> Sorry, I don't understand the difference between the two above: isn't the=
 first
> case is just when the flag is not set?

Ah, I was confused and wrote something strange. Yeah,  these two are the sa=
me.
Sorry for that.

So, the suggestion is to add a field "planes_layout" in
virtio_video_format_desc, which is one of the following enums:

enum virtio_video_planes_layout {
    VIRTIO_VIDEO_PLANES_LAYOUT_UNSPEC =3D 0,  /* no special requirement */
    VIRTIO_VIDEO_PLANES_LAYOUT_CONTIGUOUS,
};

If we have a better idea or naming, please let me know.

Best regards,
Keiichi

>
> Regards,
> Dmitry.
>
> > Best regards,
> > Keiichi
> >
> > > Regards,
> > > Dmitry.
> > >
> > > > > For future V4L2 development we came up with the idea of a format =
flag
> > > > > which could mean that the hardware allows putting planes in separ=
ate
> > > > > buffers. We could have a similar per-format flag in the capabilit=
ies,
> > > > > as we already have a list of all the supported formats there.
> > > >
> > > > Sorry, forgot to paste the link from future V4L2 work notes from th=
is
> > > > year
> > > > ELCE: https://www.spinics.net/lists/linux-media/msg159789.html
> > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > > > Best regards,
> > > > > > Keiichi
> > > > > >
> > > > > > > Best regards,
> > > > > > > Dmitry.
> > > > > > >
> > > > > > > > * Renamed virtio_video_pin to virtio_video_buf_type.
> > > > > > > >
> > > > > > > >   - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTPUT, CAPTURE}.
> > > > > > > >
> > > > > > > > * Added an error event.
> > > > > > > > * Reordered some subsections.
> > > > > > > > * Changed styles to make it consistent with other devices.
> > > > > > > >
> > > > > > > > Dmitry Sepp (1):
> > > > > > > >   virtio-video: Add virtio video device specification
> > > > > > > >
> > > > > > > >  content.tex      |   1 +
> > > > > > > >  virtio-video.tex | 579
> > > > > > > >  +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  2 files changed, 580 insertions(+)
> > > > > > > >  create mode 100644 virtio-video.tex
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.24.1.735.g03f4e72817-goog
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

