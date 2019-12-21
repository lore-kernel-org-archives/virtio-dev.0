Return-Path: virtio-dev-return-6567-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D455985F63
	for <virtio-dev@lists.oasis-open.org>; Sat, 21 Dec 2019 06:46:49 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <2932378.s8JBUXtX1Y@os-lin-dmo> <CAD90VcZU_jkY=wZ21R_abTnO8BrL_Sf4AO4Rfz3NP5xZMwmaHA@mail.gmail.com>
 <2584386.DF4NACHtsB@os-lin-dmo>
In-Reply-To: <2584386.DF4NACHtsB@os-lin-dmo>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sat, 21 Dec 2019 15:46:34 +0900
Message-ID: <CAAFQd5DUY6jYu-kuOP9pc72dddg80gZzMktxTGdkxE_PDw1HRg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 1/1] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Dec 21, 2019 at 12:46 AM Dmitry Sepp
<dmitry.sepp@opensynergy.com> wrote:
> On Freitag, 20. Dezember 2019 16:26:50 CET Keiichi Watanabe wrote:
> > On Thu, Dec 19, 2019 at 10:28 PM Dmitry Sepp
> > <dmitry.sepp@opensynergy.com> wrote:
> > > On Mittwoch, 18. Dezember 2019 14:02:14 CET Keiichi Watanabe wrote:
[snip]
> > > > +enum virtio_video_format {
> > > > + VIRTIO_VIDEO_FORMAT_UNDEFINED =3D 0,
> > > > + /* Raw formats */
> > > > + VIRTIO_VIDEO_FORMAT_NV12 =3D 1,
> > > > + VIRTIO_VIDEO_FORMAT_YUV420,
> > > > + VIRTIO_VIDEO_FORMAT_YVU420,
> > >
> > > Let's add some variants of RGB, like RGBA, ARGB. We need it for the
> > > encoder in particular .
> >
> > Sounds good.
> > BTW, which "ARGB8888" or "A8R8G8B8" is preferred? While the first one
> > comes from DRM's FourCC, the second one comes from virtio_gpu_formats.
> > I personally prefer the first one, then we can have a naming convention
> > like: VIRTIO_VIDEO_FORMAT_<name from drm_fourcc.h>
> >
>
> I'd go with ARGB8888 and BGRA8888 (might be with X variants).

Just to make sure we're talking about the same formats. DRM naming
convention is based on the little endian convention, which for 32-bit
formats means that you interpret the whole pixel as a packed 32-bit
word on a little endian system. For ARGB8888 that would mean (bit 31)
ARGB (bit 0) in the 32-bit word and (byte 0) B, G, R, A (byte 3) when
looking at separate bytes in memory. Does that correspond to your
expected format?

We also have to be specific about the A and X formats, as the A format
should be supported only if the hardware (host) doesn't ignore the
alpha channel. I haven't seen any hardware capable of encoding alpha
channel yet, but apparently for WebM the standard is to just encode
the alpha channel into another stream as Y, together with dummy U and
V values. [1] That sounds like something that would be handled by two
separate encoding streams and not just one that accepts RGBA on the
input.

[1] http://wiki.webmproject.org/alpha-channel

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

