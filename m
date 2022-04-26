Return-Path: <virtio-dev-return-9457-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F3C79863D4
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Apr 2022 08:48:35 +0000 (UTC)
Date: Tue, 26 Apr 2022 09:48:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Ymex3WO746GcBYuZ@stefanha-x1.localdomain>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4MdxUJQ+btgKWwz"
Content-Disposition: inline
In-Reply-To: <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] queue_reset register polarity to improve
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--H4MdxUJQ+btgKWwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 24, 2022 at 03:28:53PM +0800, Xuan Zhuo wrote:
> On Sun, 24 Apr 2022 00:49:19 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > Hi,
> >
> > A recently defined queue_reset register has a little weird definition t=
hat we should improve.
> > When driver initiate queue reset, it writes queue_reset =3D 1.
> > When device is busy resetting the queue, on this driver request, it is =
expected to return queue_reset=3D0.
> > Once queue reset is completed it is expected to return queue_reset =3D =
1.
> > (Polarity changed twice to same value as what was driver set). See more=
 below.
> >
> > So state wise,
> > # q_enable, q_reset represents :
> > a) 0,0 -> device init time value
> > b) 1,0 -> vq is enabled and working
> > c) 1,1 -> vq is enabled, driver initiated reset
> > d) 1,0 -> vq is enabled, but device is busy doing the reset (conflictin=
g definition with above #b )
> > e) 0,1 -> vq reset is complete in the device and VQ is now disabled (ag=
ain conflict with #a above )
> >
> > Instead, I think we should have below better, consistent definition, no=
 matter how queue reset occurs (init time or later).
> >
> > q_enable, q_reset
> > A) 0, 0 -> default, device init time
> > B) 1, 0 -> driver has enabled vq
> > C) 1, 1 -> driver started q reset
> > D) 1, 1 -> q_reset stays 1 until device is busy resetting vq (communica=
ting that its working on resetting, consistent with #C)
> > E) 0, 0 -> q_reset by device is completed, q got disabled (now matches =
the state same as device init time #A)
>=20
> Seems to me to be two different designs, I don't see any particular value=
 in the
> conflict mentioned here, and under what circumstances would it cause any
> trouble?
>=20
> The design here is similar to many scenarios, such as device reset.
>=20
> So if you want to change to your design, I want to know if there are other
> reasons.

A benefit of Parav's suggested definition is that reading the value of
q_enable and q_reset from the device tells you the state.

The current definition relies on the driver maintaining internal state
(although this could just be assumptions in the code rather than
variables stored in memory) because it cannot determine the state by
reading q_enable and q_reset.

Introspection may not be important for regular drivers because they know
which previous operations they performed, but in some cases like driver
crash recovery or live migration introspection can be useful. That said,
they can reset the entire device to return to a known state, if
necessary.

Stefan

--H4MdxUJQ+btgKWwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJnsd0ACgkQnKSrs4Gr
c8jQTgf+LuvA16hoyiZulk7KJSj+b/VGj4jCQGPvO5WU9SgiN67HJ30pC35WMcif
mr7N7dEEKC5gvWQXeiyy/l83WfIF6wJkinACBHi/fFfzqaU+TQd7UDvrw7pFJhCs
ZZS5oyRFd1KX+zfmI+5l16KWlVQefRdE4WrZKgfyMOb/P50upW9v9gjPBIJ+n1qx
0OWB5DhizM5yLawQ/UOAgPAgLKygCXwEJGanKdEWeWDPj68QAMjbiXxoorEpYLpl
+NUR6Mv31MycqWX5hgjdJUAMel3VBVCfH/9ff+Exb3gncKCVVX25F0R4q3AP4JpK
K1RI6SLtuFQEigRAipCzI4ugR26ZRQ==
=2ECW
-----END PGP SIGNATURE-----

--H4MdxUJQ+btgKWwz--

