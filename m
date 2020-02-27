Return-Path: virtio-dev-return-6793-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D53E2985E3A
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 07:24:13 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org> <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
In-Reply-To: <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu, 27 Feb 2020 16:24:00 +0900
Message-ID: <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Thanks for the review, Gerd.
Please see my replies inline below.

FYI, I'm implementing virtio-video device for ChromeOS that works with
Dmitry's virtio-video driver
https://patchwork.linuxtv.org/patch/61717/.
Once it becomes fully functional, I'll post a list of possible
improvements of protocol.

On Tue, Feb 25, 2020 at 7:00 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 06, 2020 at 07:20:57PM +0900, Keiichi Watanabe wrote:
> > From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> >
> > The virtio video encoder device and decoder device provide functionalit=
ies to
> > encode and decode video stream respectively.
> > Though video encoder and decoder are provided as different devices, the=
y use a
> > same protocol.
> >
> > Signed-off-by: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> > Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>
> Finally found the time for a closer look.
> Pretty good overall, some minor nits below ...
>
> > +\begin{description}
> > +\item[\field{version}] is the protocol version that the device talks.
> > +  The device MUST set this to 0.
>
> What is the intended use case for this?
>
> Given that virtio has feature flags to negotiate support for optional
> features and protocol extensions between driver and device, why do you
> think this is needed?

While feature flags work well when we "extend" the protocol with an
optional feature, they don't when we want to "drop" or "modify"
features.
For example, I guess it'd be useful when we want:
* to abandon a non-optional command,
* to change a non-optional struct's layout,or
* to change the order of commands in which the device expects to be sent.

Though it might be possible to handle these changes by feature flags,
I suspect the version number allow us to transition protocols more
smoothly.
WDYT?

>
> > +The format description \field{virtio_video_format_desc} is defined as
> > +follows:
> > +\begin{lstlisting}
> > +enum virtio_video_format {
> > +        /* Raw formats */
> > +        VIRTIO_VIDEO_FORMAT_RAW_MIN =3D 1,
> > +        VIRTIO_VIDEO_FORMAT_ARGB8888 =3D VIRTIO_VIDEO_FORMAT_RAW_MIN,
> > +        VIRTIO_VIDEO_FORMAT_BGRA8888,
> > +        VIRTIO_VIDEO_FORMAT_NV12, /* 12  Y/CbCr 4:2:0  */
> > +        VIRTIO_VIDEO_FORMAT_YUV420, /* 12  YUV 4:2:0     */
> > +        VIRTIO_VIDEO_FORMAT_YVU420, /* 12  YVU 4:2:0     */
> > +        VIRTIO_VIDEO_FORMAT_RAW_MAX =3D VIRTIO_VIDEO_FORMAT_YVU420,
>
> I'm wondering what the *_MIN and *_MAX values here (and elsewhere) are
> good for?  I doubt drivers would actually loop over formats from min to
> max, I'd expect they check for specific formats they can handle instead.
>
> If you want define the range for valid raw formats I'd suggest to leave
> some room, so new formats can be added without changing MAX values, i.e.
> use -- for example -- RAW_MIN =3D 0x100, RAW_MAX =3D 0x1ff, CODED_MIN=3D0=
x200,
> CODED_MAX=3D0x2ff.  Or just drop them ...

Ah, that's a good point. I agree that drivers don't need to loop over forma=
ts.
If they need, they can define such an alias locally.

Still, I guess it's worth defining the range for valid raw/coded formats.
This allows devices to report more detailed errors if a driver sent an
unexpected format.
i.e. "opposite format type" v.s. "unknown format"

So, I'd use your idea of RAW_MIN =3D 0x100 and RAW_MAX =3D 0x1ff.

>
> > +struct virtio_video_query_control_level {
> > +        le32 profile; /* One of VIRTIO_VIDEO_PROFILE_* */
>                                                 ^^^^^^^  LEVEL ?

Nope, it should be profile.
This "profile" field is specified by the driver to query supported
levels for a specific profile.

In my understanding, supported levels depend on profiles.
At least, the specification of H.264 [1] says that `"levels" are
specified within each profile.` at section "0.5 Profiles and levels".

[1] https://www.itu.int/rec/T-REC-H.264-201906-I/en

Best regards,
Keiichi

>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

