Return-Path: virtio-dev-return-6564-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 531EB985F63
	for <virtio-dev@lists.oasis-open.org>; Sat, 21 Dec 2019 04:36:52 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org> <2730251.jGmEEvB50I@os-lin-dmo>
In-Reply-To: <2730251.jGmEEvB50I@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Sat, 21 Dec 2019 13:36:40 +0900
Message-ID: <CAD90Vcb=38fXTbsWy6dH9FuE0xU-GAVAHWMFFtju0txPg+e1FA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,

On Sat, Dec 21, 2019 at 12:59 AM Dmitry Sepp
<dmitry.sepp@opensynergy.com> wrote:
>
> Hi Keiichi,
>
> On Mittwoch, 18. Dezember 2019 14:02:13 CET Keiichi Watanabe wrote:
> > Hi,
> > This is the 2nd version of virtio-video patch. The PDF is available in =
[1].
> > The first version was sent at [2].
> >
> > Any feedback would be appreciated. Thank you.
> >
> > Best,
> > Keiichi
> >
> > [1]:
> > https://drive.google.com/drive/folders/1eT5fEckBoor2iHZR4f4GLxYzFMVapOF=
x?us
> > p=3Dsharing [2]: https://markmail.org/message/gc6h25acct22niut
> >
> > Change log:
> >
> > v2:
> > * Removed functionalities except encoding and decoding.
> > * Splited encoder and decoder into different devices that use the same
> > protocol. * Replaced GET_FUNCS with GET_CAPABILITY.
> > * Updated structs for capabilities.
> >   - Defined new structs and enums such as image formats, profiles, rang=
e
> > (min, max, step), etc
> >     * For virtio_video_pixel_format, chose a naming convention that is =
used
> >       in DRM. We removed XBGR, NV21 and I422, as they are not used in t=
he
> >       current draft implementation. https://lwn.net/Articles/806416/
> >   - Removed virtio_video_control, whose usage was not documented yet an=
d
> > which is not necessary for the simplest decoding scenario.
> >   - Removed virtio_video_desc, as it is no longer needed.
> > * Updated struct virtio_video_config for changes around capabilities.
> > * Added a way to represent supported combinations of formats.
> >   - A field "mask" in virtio_video_format_desc plays this role.
> > * Removed VIRTIO_VIDEO_T_STREAM_{START,STOP} because they don't play an=
y
> > meaningful roles. * Removed VIRTIO_VIDEO_T_STREAM_{ATTACH, DETACH}_BACK=
ING
> > and merged them into RESOURCE_{CREATE, DESTROY}. * Added a way to
> > notify/specify resource creation method.
> >   - Added a feature flag.
> >   - Defined enum virtio_video_mem_type.
> >   - Added new fields in video_stream_create.
> > * Modified fields in virtio_video_params.
> >   - Added crop information.
> > * Removed enum virtio_video_channel_type because we can get this inform=
ation
> > by image format.
> Could you please explain this? How do you get the information?

It means that if image formats are well-defined, channel information
(e.g. the order of channels) is uniquely determined.

>
> Suppose you have some piece of HW on the host side that wants I420 as one
> contig buffer w/ some offsets. But on the driver side, say, gralloc gives=
 you
> three separate buffers, one per channel. How do we pass those to the devi=
ce
> then?

You're talking about CrOS use case where buffers are allocated by
virtio-gpu, right?
In this case, virtio-gpu allocates one contiguous host-side buffer and
the client regards a pair of (buffer FD, offset) as one channel.
And, we can register this pair to the device when the buffer is imported.
In the virtio-vdec spec draft, this pair corresponds to struct
virtio_vdec_plane in struct virtio_vdec_plane.

So, I suppose we will need similar structs when we add a control to
import buffers. However, I don't think it's necessary when guest pages
are used.

Best regards,
Keiichi


>
> Best regards,
> Dmitry.
>
> > * Renamed virtio_video_pin to virtio_video_buf_type.
> >   - It's similar to V4L2_BUF_TYPE_VIDEO_{OUTPUT, CAPTURE}.
> > * Added an error event.
> > * Reordered some subsections.
> > * Changed styles to make it consistent with other devices.
> >
> > Dmitry Sepp (1):
> >   virtio-video: Add virtio video device specification
> >
> >  content.tex      |   1 +
> >  virtio-video.tex | 579 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 580 insertions(+)
> >  create mode 100644 virtio-video.tex
> >
> > --
> > 2.24.1.735.g03f4e72817-goog
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

