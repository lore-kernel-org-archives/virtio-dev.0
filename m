Return-Path: virtio-dev-return-6524-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C77E985EDC
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Dec 2019 14:09:29 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org> <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org> <CAAFQd5Bs6NnsoOP1NFLREQSLNJs-K33ZvW5ZcdAZTv95WHmPBA@mail.gmail.com>
 <20191216103236.ugjorzq5pntc7gtt@sirius.home.kraxel.org> <CAAFQd5BN+enTk3-4aUCCB+ZUA+7ZsOP=zndXh4Y=a8faoRk1Pw@mail.gmail.com>
 <20191217133945.oxnassyjr6hwtjbf@sirius.home.kraxel.org>
In-Reply-To: <20191217133945.oxnassyjr6hwtjbf@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 17 Dec 2019 23:09:16 +0900
Message-ID: <CAD90VcaXDXgmJ1-aDMu-o_zFCaJ4+rxN0FxHh7x6Q8MTPAr-jw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

Thanks Tomasz and Gerd for the suggestions and information.

On Tue, Dec 17, 2019 at 10:39 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > On the host side, the encode and decode APIs are different as well, so
> > having separate implementation decoder and encoder, possibly just
> > sharing some helper code, would make much more sense.
>
> When going down that route I'd suggest to use two device ids (even when
> specifying both variants in one spec section and one header file due to
> the overlaps) instead of feature flags.

Sounds good. It makes sense to use different device IDs for different devic=
es.

>
> > > I don't think using fourcc is a problem, and given that both drm and
> > > v4l2 use fourcc already this would be a good choice I think.
> >
> > Both DRM and V4L2 use two mutually incompatible sets of FourCCs, so
> > I'm not sure how it could be a good choice. At least unless we decide
> > to pick a specific set of FourCC. It doesn't help that Windows/DirectX
> > has its own set of FourCCs that's again slightly different than the
> > two mentioned before.
>
> Ouch, wasn't aware of that.  That makes reusing fourcc codes much less
> useful.
>
> > > But the definition should be more specific than just "fourcc".  Best
> > > would be to explicitly list and define each format supported by the
> > > spec.
> >
> > Why not be consistent with virtio-gpu and just define new formats as
> > we add support for them as sequential integers?
>
> Yes, lets do that.
>

It makes sense. I seems to have overestimated FourCC.

Best,
Keiichi

> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

