Return-Path: virtio-dev-return-6527-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78BE2985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 06:43:59 +0000 (UTC)
Date: Wed, 18 Dec 2019 07:43:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191218064310.kf5gl4zxdfvihm5d@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <20191217133945.oxnassyjr6hwtjbf@sirius.home.kraxel.org>
 <CAD90VcaXDXgmJ1-aDMu-o_zFCaJ4+rxN0FxHh7x6Q8MTPAr-jw@mail.gmail.com>
 <15520793.X85Ks0aH1j@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <15520793.X85Ks0aH1j@os-lin-dmo>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Dec 17, 2019 at 05:13:59PM +0100, Dmitry Sepp wrote:
> Hi,
>=20
> On Dienstag, 17. Dezember 2019 15:09:16 CET Keiichi Watanabe wrote:
> > Hi,
> >=20
> > Thanks Tomasz and Gerd for the suggestions and information.
> >=20
> > On Tue, Dec 17, 2019 at 10:39 PM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > >   Hi,
> > >  =20
> > > > On the host side, the encode and decode APIs are different as well,=
 so
> > > > having separate implementation decoder and encoder, possibly just
> > > > sharing some helper code, would make much more sense.
> > >=20
> > > When going down that route I'd suggest to use two device ids (even wh=
en
> > > specifying both variants in one spec section and one header file due =
to
> > > the overlaps) instead of feature flags.
> >=20
> > Sounds good. It makes sense to use different device IDs for different
> > devices.
> Does this mean one driver handles both? Or we have two separate drivers?

That is the driver writers choice.  You can have a single kernel module
registering as driver for both IDs.  Or you can have two kernel modules,
each registering for one of the IDs, possibly with a third library
module with helper code for common bits like buffer management.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

