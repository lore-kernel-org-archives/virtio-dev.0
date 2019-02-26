Return-Path: virtio-dev-return-5531-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5A9C985D97
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Feb 2019 17:44:18 +0000 (UTC)
Date: Tue, 26 Feb 2019 17:44:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190226174416.GA2339@stefanha-x1.localdomain>
References: <20190226162553.30231-1-stefanha@redhat.com>
 <20190226180903.497cccaa.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20190226180903.497cccaa.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-blk: clarify semantics of
 multi-segment discard/write zeroes commands
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 06:09:03PM +0100, Cornelia Huck wrote:
> On Tue, 26 Feb 2019 16:25:53 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > Describe the failure case and maximum number of segments in a
> > multi-segment discard/write zeroes command.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/34
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > I would like to request a vote on this.
>=20
> Only one minor nit from me, below.
>=20
> >=20
> >  content.tex | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/content.tex b/content.tex
> > index c5fdc34..7bfcc78 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3967,8 +3967,10 @@ read from the block device (in multiples of 512 =
bytes).  VIRTIO_BLK_T_OUT
> >  requests write the contents of \field{data} to the block device (in mu=
ltiples
> >  of 512 bytes).
> > =20
> > -The \field{data} used for discard or write zeroes command is described
> > -by one or more virtio_blk_discard_write_zeroes structs:
> > +The \field{data} used for discard or write zeroes commands consists of=
 one or
> > +more segments.  The maximum number of segments is \field{max_discard_s=
eg} for
> > +discard commands and \field{max_write_zeroes_seg} for write zeroes com=
mands.
> > +Each segment is of form:
>=20
> Maybe s/of form/of the form/ ?

I wanted to stay consistent with the existing text above it:

  The driver queues requests to the virtqueue, and they are used by
  the device (not necessarily in order). Each request is of form:

  ...

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdXrwAAoJEJykq7OBq3PITAkH/A9OSO/n80TxLmHpJCdKSjKD
D7vseeZ7c54AY6YELxWs3cediNPJmuMHtcDECQh9WuSJTLmlAhCI/0WIRYts/clD
jriwDY+VGkitJZdbmULz355h4GKdO63vc9rzLreJk3EZ35QqBntulWiaE4PxetuT
8cgZHqr8w9wRNFpmAOxRe//ZuAIYJDrK6XsZz6hpUhRgn4NHdTiiz7wZ+qAvPIcW
cd3iIednSkZifphh6lr8CNQt8xnbO+1DT92No7+TVae73w1rKjm5o/SKLgn6t4H5
CnvDllM+pGmR2s/kb19COmVOIeBZ2xmvobrZehqQoZJ268U7FoMRyFcYJh59P7c=
=kPGo
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
