Return-Path: virtio-dev-return-5520-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85853985AA7
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Feb 2019 16:54:07 +0000 (UTC)
Date: Mon, 25 Feb 2019 16:54:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225165400.GF379@stefanha-x1.localdomain>
References: <20190221162219.9790-1-stefanha@redhat.com>
 <20190221162219.9790-6-stefanha@redhat.com>
 <20190222100008-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <20190222100008-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v3 5/5] virtio-blk: clarify semantics of
 multi-segment discard/write zeroes commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 10:01:13AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 21, 2019 at 04:22:19PM +0000, Stefan Hajnoczi wrote:
> > Describe the failure case and maximum number of segments in a
> > multi-segment discard/write zeroes command.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> OK so just making sure.  Patches 1-4 have already been approved, so I
> should apply them. Patch 5 needs another vote. Is that right?

Yes, sorry for combining it all into a single series.

Stefan

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdB2oAAoJEJykq7OBq3PIKqYIAJvqbBRY0KpyJoWK7U1xFY0B
/PbqhR4Lw368iAJ0p6DNkcvCD+R/Yg1zpEPCeK11i56MFjgJFRF6f/cU93jcYb+B
NjoTBt6u0clBYDkaj9xpD+jxBu6UU9FoswMyJhsbeAbfujNYp6GbNITRwFepIXqA
UmeDeGwqFTGt9/aajHSb0uix/O5u91A/c+NlvyYF1pYD7PWmERjp5IUOBfsD8iQJ
xF3EE1BuV3PHSz7ILS33GP73Vc7iQRqbXA1BOzg3qkicnW/Wrzu+3x+p8rGgW5jI
9MW6y1O+Oa7WQ/GQPjTCLohowz8Qpgc5S17TlEoMBgaj5vc52G62A8/Rq6l65Y0=
=5F7b
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
