Return-Path: virtio-dev-return-6522-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 342AF985ED9
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Dec 2019 13:16:13 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org> <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org> <CAAFQd5Bs6NnsoOP1NFLREQSLNJs-K33ZvW5ZcdAZTv95WHmPBA@mail.gmail.com>
 <20191216103236.ugjorzq5pntc7gtt@sirius.home.kraxel.org>
In-Reply-To: <20191216103236.ugjorzq5pntc7gtt@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 17 Dec 2019 22:15:56 +0900
Message-ID: <CAAFQd5BN+enTk3-4aUCCB+ZUA+7ZsOP=zndXh4Y=a8faoRk1Pw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 16, 2019 at 7:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Hmm, modern GPUs support both encoding and decoding ...
> >
> > Many SoC architectures have completely separate IP blocks for encoding
> > and decoding. Similarly, in GPUs those are usually completely separate
> > parts of the pipeline.
>
> In the OS there is one driver per GPU handling both ...
>

That's usually only the case for the desktop PC-style GPUs. That said,
it probably doesn't matter from the protocol point of view how it's
handled in the host. At least it is definitely safe to assume that the
host provides functionality for independently decoding and encoding
things from different processes, which is enough to implement virtio
decoder and encoder as separate devices.

> > > I don't think we should bake that restriction into the specification.
> > > It probably makes sense to use one virtqueue per function though, tha=
t
> > > will simplify dispatching in both host and guest.
> > >
> >
> > Wouldn't it make the handling easier if we had one virtio device per fu=
nction?
>
> I don't think there is much of a difference between one device per
> function and one virtqueue per function.  You'll probably have a single
> driver for both anyway, to share common code for buffer management etc.
>

The semantics of the encoder and decoder on the driver side, at least
on Linux where V4L2 is used, are different enough for much of the code
to be separated.

That said, even with separate devices, the same driver can be
instantiated multiple times, which is a common case in Linux, handled
by the driver core. That basically gives us the ability to have as
many instances of whatever function we want for free, without the need
to explicitly handle multiple functions in one device in the driver.
So that clearly equals simpler driver code.

On the host side, the encode and decode APIs are different as well, so
having separate implementation decoder and encoder, possibly just
sharing some helper code, would make much more sense.

> > > Use separate pixel_format (fourcc) and stream_format (H.264 etc.) enu=
ms?
> >
> > I'd specifically avoid FourCC here, as it's very loosely defined and
> > could introduce confusion.
>
> I don't think using fourcc is a problem, and given that both drm and
> v4l2 use fourcc already this would be a good choice I think.

Both DRM and V4L2 use two mutually incompatible sets of FourCCs, so
I'm not sure how it could be a good choice. At least unless we decide
to pick a specific set of FourCC. It doesn't help that Windows/DirectX
has its own set of FourCCs that's again slightly different than the
two mentioned before.

>
> But the definition should be more specific than just "fourcc".  Best
> would be to explicitly list and define each format supported by the
> spec.

Why not be consistent with virtio-gpu and just define new formats as
we add support for them as sequential integers?

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

