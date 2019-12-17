Return-Path: virtio-dev-return-6523-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D2E1985EDB
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Dec 2019 13:39:52 +0000 (UTC)
Date: Tue, 17 Dec 2019 14:39:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191217133945.oxnassyjr6hwtjbf@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org>
 <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org>
 <CAAFQd5Bs6NnsoOP1NFLREQSLNJs-K33ZvW5ZcdAZTv95WHmPBA@mail.gmail.com>
 <20191216103236.ugjorzq5pntc7gtt@sirius.home.kraxel.org>
 <CAAFQd5BN+enTk3-4aUCCB+ZUA+7ZsOP=zndXh4Y=a8faoRk1Pw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BN+enTk3-4aUCCB+ZUA+7ZsOP=zndXh4Y=a8faoRk1Pw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tomasz Figa <tfiga@chromium.org>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> On the host side, the encode and decode APIs are different as well, so
> having separate implementation decoder and encoder, possibly just
> sharing some helper code, would make much more sense.

When going down that route I'd suggest to use two device ids (even when
specifying both variants in one spec section and one header file due to
the overlaps) instead of feature flags.

> > I don't think using fourcc is a problem, and given that both drm and
> > v4l2 use fourcc already this would be a good choice I think.
>=20
> Both DRM and V4L2 use two mutually incompatible sets of FourCCs, so
> I'm not sure how it could be a good choice. At least unless we decide
> to pick a specific set of FourCC. It doesn't help that Windows/DirectX
> has its own set of FourCCs that's again slightly different than the
> two mentioned before.

Ouch, wasn't aware of that.  That makes reusing fourcc codes much less
useful.

> > But the definition should be more specific than just "fourcc".  Best
> > would be to explicitly list and define each format supported by the
> > spec.
>=20
> Why not be consistent with virtio-gpu and just define new formats as
> we add support for them as sequential integers?

Yes, lets do that.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

