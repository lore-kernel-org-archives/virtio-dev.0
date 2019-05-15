Return-Path: virtio-dev-return-5749-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 949CE985E88
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 May 2019 16:03:45 +0000 (UTC)
Date: Wed, 15 May 2019 17:03:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190515160339.GN29507@stefanha-x1.localdomain>
References: <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
 <20190510154824.GJ22311@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA25EB1@MXS02.open-synergy.com>
 <20190514134448.GB6555@stefanha-x1.localdomain>
 <76D732A88286A1478FFA94B453B715C1EEA27A2B@MXS02.open-synergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Content-Disposition: inline
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA27A2B@MXS02.open-synergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 06:30:45AM +0000, Anton Yakovlev wrote:
> >> So, our proposal is to support classic way of communications by defaul=
t and introduce shared memory based approach as either non-standard extensi=
on or part of future VIRTIO device types. And switch to this mode where it'=
s possible or make sense. Like, all modern type-2 hypervisors usually have =
no problems with sharing memory between guest and host, so why not provide =
to user high quality virtual audio device?
> >
> > virtqueues offer reliable delivery, so #2 isn't an issue.
> >
> > Real-time is achievable and can be done with low latency.  Make the
> > receiver a real-time thread that polls the vring periodically (based on
> > the latency/buffer size requirement).  The vring supports lock-free
> > access so this is perfect for real-time.
> >
> > When I say "receiver" I mean the driver's capture and device's playback
> > components.  Both of them have real-time requirements.
> >
> > Does this approach meet your requirements?
>=20
> After careful consideration, I think polling mode should make it possible=
=2E Like, using dedicated "data" queue per stream in polling mode (multiple=
xing is not an option, since it reduces queue throughput in proportion to t=
he number of multiplexed streams). How to describe it in specification?

Polling is an implementation detail for both drivers and devices.
Therefore it's not described explicitly in the specification.

By the way, virtqueue buffers can be completed out-of-order by the
device.  This means sharing a virtqueue between multiple streams does
not necessarily introduce any kind of waiting.

The only issue is the virtqueue size (e.g. 128 buffers) determines how
many buffers can be made available from the driver to the device at any
given time.  Some device implementations uses virtqueue sizes like 1024
so that this does not become a practical concern.  Does this change your
view on multiplexing streams?

Stefan

--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzcOFsACgkQnKSrs4Gr
c8gIDQgAvCNixe3ls9LdQmt7kEg2B6LbMpKQCtI5feGIxmvI82/48tQIXwvPDgcs
SDOdIgJfUlUcdDBl76G2uLi8hdpiCzslGDI/9JORLUUKLzgtm+cdt6M7xxFHVt6T
AblaPy0nzQODCZVz1rFVy0ojby7W0f4Ahe/nsZtpR/WVJCabACZnxQnCHjaT5fy4
qLciavsF46vn+Sd0GrafYjF0YRGCC1PZtEzi78UgvLqq1+Av4qw7apt14i5zPhKg
IqDSbj792LzIYpHV2vs3gdz6gFxtZBZ5RmLL+8X2rjSW49g6+QchQM0BUWIz3y44
BLvboraJqFbvuqXj1FmMVtsj6ulquQ==
=z4QM
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--
