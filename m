Return-Path: <virtio-dev-return-9341-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19D8398648D
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 16:37:43 +0000 (UTC)
Date: Tue, 1 Mar 2022 16:37:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Yh5L0dNz4+/mji7t@stefanha-x1.localdomain>
References: <20220301120021.147070-1-stefanha@redhat.com>
 <Yh4it+8MroTwbnlz@stefanha-x1.localdomain>
 <20220301084433-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="klPYPZ2TswNXPENL"
Content-Disposition: inline
In-Reply-To: <20220301084433-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document that the capacity field can change
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--klPYPZ2TswNXPENL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 08:45:31AM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 01, 2022 at 01:42:15PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Mar 01, 2022 at 12:00:21PM +0000, Stefan Hajnoczi wrote:
> > > Block devices can change size during operation. A configuration change
> > > notification is sent by the device and the driver detects that the fi=
eld
> > > has changed. Document this behavior that has already been implemented=
 in
> > > Linux and QEMU since 2011.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  content.tex | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> >=20
> > Requesting a vote.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/136
>=20
> We can vote but not for 1.2 unless it's urgent (i.e. a regression), and
> I think we can wait with this one.

I agree, it's not urgent. It can wait for 1.3.

Stefan

--klPYPZ2TswNXPENL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIeS9EACgkQnKSrs4Gr
c8gIVQf+Ng5x/9d2wEqOJmmZtNNcKrSB0cUg1BBF4eMyrVQTY+QAGfcZLaNbvQNt
Tl2GTsJeZ1dOPTL0gO7/pBm7bZiQ8V37L0UUeO2yx+P7Sxu28oA3BaPxNscggI+C
63OnVPT9azjPYPxnHLUJosWZNJ2q+OmfSZrozkFsuUhBCXHrUhBq3AcGpqFIpa5O
tevoAKUAe0u55WYeeAXP6DN7oB/KQsDOlC7hfUm48JelbPINGI5K2d+YkXK9Fkkj
ktwZ09bCYpzpoUDJ2oqQHLpRYGvsc6s4kE5w128DFszqW8QQFq7JktPzuIsf3ydH
v8f4JeNKB8oFT+m0mNoAPK+mv0mL9g==
=0Kcs
-----END PGP SIGNATURE-----

--klPYPZ2TswNXPENL--

