Return-Path: virtio-dev-return-5430-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDF6A985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 09:12:08 +0000 (UTC)
Date: Wed, 13 Feb 2019 17:11:51 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190213091151.GG13081@stefanha-x1.localdomain>
References: <20190213013813.GA14307@stefanha-x1.localdomain>
 <20190212205956-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <20190212205956-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: Requesting ballots for #31 and #32
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 09:04:35PM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 13, 2019 at 09:38:13AM +0800, Stefan Hajnoczi wrote:
> > Hi,
> > I'd like to request ballots for the following issues:
> >=20
> > "content: reserve virtio device ID for file system devices"
> > https://github.com/oasis-tcs/virtio-spec/issues/31
> >=20
> > "virtio-blk: discard and write zeroes clarifications"
> > https://github.com/oasis-tcs/virtio-spec/issues/32
> >=20
> > At least #32 is needed for VIRTIO 1.1 but #31 is trivial and will
> > prevent device ID conflicts so I suggest merging it too.
> >=20
> > Thank you,
> > Stefan
>=20
> Would you say that #32 is a material change or not?
>=20
> 	"Material Change" is any change to the content of a Work Product that
> 	that would require a compliant application or implementation to be
> 	modified or rewritten in order to remain compliant or which adds new
> 	features or otherwise expands the scope of the work product.
>=20
> I think you indicated in the past that it isn't.
>=20
> However I think #31 would be a new feature. If yes including it would not
> qualify as non material change and that would force
> another public review round.
>=20
> Would you agree?
> If doesn't seem worth forcing a public review for a trivial change.

Yes, I agree on both counts.

Stefan

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY99XAAoJEJykq7OBq3PI+KkH/ivFSXN6DszfFgRtpTryHbSR
1xlPyLUeT0rILu4S1K+lUEel9+8WLpTVYjNEOiMv5qaYwJ3yc8P2/PkHcR+6fz3m
iHzsGave8pPcwHdHOZFrtQyt+Qq6dZe00v9cOaHEfO41zxUA0xv1p6oBTkTDpWtr
wEB7AHD+KnY/xZ2UEzMdkhlDyeSebRFcOgoxoFEbV7RB2uzWCtFn/J5Zg8Dht/YE
t2hAof+BWNdh6FZTh/blBUpiKJM+7zceMcmS66j7cRDrehO/id2bpd8pkdMrkqPv
WMishAFk654G/Wnz3S2/I1naYr0Hdgec+fShAoBXVWrPNpuFdOzIJ85WQtM3JI8=
=XN6E
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
