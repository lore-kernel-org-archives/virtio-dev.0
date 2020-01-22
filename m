Return-Path: virtio-dev-return-6686-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F596985F97
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 11:10:41 +0000 (UTC)
Date: Wed, 22 Jan 2020 06:10:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200122060844-mutt-send-email-mst@kernel.org>
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
 <20200122032103-mutt-send-email-mst@kernel.org>
 <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 22, 2020 at 07:13:41PM +0900, David Stevens wrote:
> > > +When an object created by one virtio device needs to be
> > > +shared with a seperate virtio device, the first device can
> > > +export the object by generating a \field{uuid}
> >
> > This is a field where?
>=20
> It's a property of the exported object, but I guess it doesn't really
> correspond to any concrete field. I'll remove \field.
>=20
> > > which the
> > > +guest can pass to the second device to identify the object.
> >
> > s/guest/Driver/ ?
>=20
> The uuid can be passed to a second device controlled by a different
> driver, so I think 'driver' by itself is ambiguous. I'm using guest as
> a shorthand for 'system which includes the drivers and software which
> sits on top of the drivers', and that meaning does seem to be
> compatible with language in the rest of the spec. If that shorthand
> isn't acceptable, I can rewrite the sentence passively as '... a uuid
> which can then be passed to a second device ...'.
>=20
> > Also - what are guest and host here?
>=20
> There are a number of places in the virtio spec where 'guest' is used
> to refer to the system where drivers run and where 'host' is used to
> refer to the system where devices run. I guess those terms aren't
> concretely defined within the spec, but they do seem to have a well
> understood meaning. Or is the guest/host language discouraged in new
> additions to the spec?
>=20
> -David

Yes - generally most devices are/should be implementable in hardware.
In that setup guest/host doesn't make sense.
We haven't reworked all of spec with that in mind yet,
and in some cases such as the balloon it's actually specific to
virtualization.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

