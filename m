Return-Path: virtio-dev-return-6775-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A889985D55
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Feb 2020 10:00:09 +0000 (UTC)
Date: Tue, 25 Feb 2020 10:59:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200206102058.247258-2-keiichiw@chromium.org>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 06, 2020 at 07:20:57PM +0900, Keiichi Watanabe wrote:
> From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
>=20
> The virtio video encoder device and decoder device provide functionalitie=
s to
> encode and decode video stream respectively.
> Though video encoder and decoder are provided as different devices, they =
use a
> same protocol.
>=20
> Signed-off-by: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>

Finally found the time for a closer look.
Pretty good overall, some minor nits below ...

> +\begin{description}
> +\item[\field{version}] is the protocol version that the device talks.
> +  The device MUST set this to 0.

What is the intended use case for this?

Given that virtio has feature flags to negotiate support for optional
features and protocol extensions between driver and device, why do you
think this is needed?

> +The format description \field{virtio_video_format_desc} is defined as
> +follows:
> +\begin{lstlisting}
> +enum virtio_video_format {
> +        /* Raw formats */
> +        VIRTIO_VIDEO_FORMAT_RAW_MIN =3D 1,
> +        VIRTIO_VIDEO_FORMAT_ARGB8888 =3D VIRTIO_VIDEO_FORMAT_RAW_MIN,
> +        VIRTIO_VIDEO_FORMAT_BGRA8888,
> +        VIRTIO_VIDEO_FORMAT_NV12, /* 12  Y/CbCr 4:2:0  */
> +        VIRTIO_VIDEO_FORMAT_YUV420, /* 12  YUV 4:2:0     */
> +        VIRTIO_VIDEO_FORMAT_YVU420, /* 12  YVU 4:2:0     */
> +        VIRTIO_VIDEO_FORMAT_RAW_MAX =3D VIRTIO_VIDEO_FORMAT_YVU420,

I'm wondering what the *_MIN and *_MAX values here (and elsewhere) are
good for?  I doubt drivers would actually loop over formats from min to
max, I'd expect they check for specific formats they can handle instead.

If you want define the range for valid raw formats I'd suggest to leave
some room, so new formats can be added without changing MAX values, i.e.
use -- for example -- RAW_MIN =3D 0x100, RAW_MAX =3D 0x1ff, CODED_MIN=3D0x2=
00,
CODED_MAX=3D0x2ff.  Or just drop them ...

> +struct virtio_video_query_control_level {
> +        le32 profile; /* One of VIRTIO_VIDEO_PROFILE_* */
                                                ^^^^^^^  LEVEL ?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

