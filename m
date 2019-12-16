Return-Path: virtio-dev-return-6517-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1BA8985BE3
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Dec 2019 10:32:44 +0000 (UTC)
Date: Mon, 16 Dec 2019 11:32:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191216103236.ugjorzq5pntc7gtt@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org>
 <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org>
 <CAAFQd5Bs6NnsoOP1NFLREQSLNJs-K33ZvW5ZcdAZTv95WHmPBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Bs6NnsoOP1NFLREQSLNJs-K33ZvW5ZcdAZTv95WHmPBA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tomasz Figa <tfiga@chromium.org>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Hmm, modern GPUs support both encoding and decoding ...
>=20
> Many SoC architectures have completely separate IP blocks for encoding
> and decoding. Similarly, in GPUs those are usually completely separate
> parts of the pipeline.

In the OS there is one driver per GPU handling both ...

> > I don't think we should bake that restriction into the specification.
> > It probably makes sense to use one virtqueue per function though, that
> > will simplify dispatching in both host and guest.
> >
>=20
> Wouldn't it make the handling easier if we had one virtio device per func=
tion?

I don't think there is much of a difference between one device per
function and one virtqueue per function.  You'll probably have a single
driver for both anyway, to share common code for buffer management etc.

> > Use separate pixel_format (fourcc) and stream_format (H.264 etc.) enums=
?
>=20
> I'd specifically avoid FourCC here, as it's very loosely defined and
> could introduce confusion.

I don't think using fourcc is a problem, and given that both drm and
v4l2 use fourcc already this would be a good choice I think.

But the definition should be more specific than just "fourcc".  Best
would be to explicitly list and define each format supported by the
spec.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

