Return-Path: virtio-dev-return-5532-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5EFEB985D97
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Feb 2019 17:45:38 +0000 (UTC)
Date: Tue, 26 Feb 2019 18:45:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190226184521.5f3dc061.cohuck@redhat.com>
In-Reply-To: <20190226174416.GA2339@stefanha-x1.localdomain>
References: <20190226162553.30231-1-stefanha@redhat.com>
	<20190226180903.497cccaa.cohuck@redhat.com>
	<20190226174416.GA2339@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LdAaxPfQu25bmEweAGvo=34"; protocol="application/pgp-signature"
Subject: Re: [virtio-dev] [PATCH] virtio-blk: clarify semantics of
 multi-segment discard/write zeroes commands
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Sig_/LdAaxPfQu25bmEweAGvo=34
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Feb 2019 17:44:16 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Feb 26, 2019 at 06:09:03PM +0100, Cornelia Huck wrote:
> > On Tue, 26 Feb 2019 16:25:53 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  =20
> > > Describe the failure case and maximum number of segments in a
> > > multi-segment discard/write zeroes command.
> > >=20
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/34
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > I would like to request a vote on this. =20
> >=20
> > Only one minor nit from me, below.
> >  =20
> > >=20
> > >  content.tex | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/content.tex b/content.tex
> > > index c5fdc34..7bfcc78 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3967,8 +3967,10 @@ read from the block device (in multiples of 51=
2 bytes).  VIRTIO_BLK_T_OUT
> > >  requests write the contents of \field{data} to the block device (in =
multiples
> > >  of 512 bytes).
> > > =20
> > > -The \field{data} used for discard or write zeroes command is describ=
ed
> > > -by one or more virtio_blk_discard_write_zeroes structs:
> > > +The \field{data} used for discard or write zeroes commands consists =
of one or
> > > +more segments.  The maximum number of segments is \field{max_discard=
_seg} for
> > > +discard commands and \field{max_write_zeroes_seg} for write zeroes c=
ommands.
> > > +Each segment is of form: =20
> >=20
> > Maybe s/of form/of the form/ ? =20
>=20
> I wanted to stay consistent with the existing text above it:
>=20
>   The driver queues requests to the virtqueue, and they are used by
>   the device (not necessarily in order). Each request is of form:
>=20
>   ...

Fine with me as well.

--Sig_/LdAaxPfQu25bmEweAGvo=34
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAlx1ezEACgkQ3s9rk8bw
L6+W5A//fbU9bijXhFqoX8lkC5tu/qV9aOubc9fQUwYETbVuujkNebfnDGKdGejF
J/B6H8H6Clct0BQ0KgDPErgEs2cbxddJtahcdMZFxMHC3lGhGza4/TOKA68q5Bk/
v4R2oMFmXug7JuNK0p2CKnCKaHw5plwkScYjUDuyYfzsUvkAuHbZ4+uAKStzitlM
k2w8eIcgKbPZTa9rZVpoPaTZjOfID+Rb9GfcADRSY3QUsnJOWcV/RAoXUv/7t0Hu
zli3YFqWk0GfMe1XDTTpiAhwBOILnu7QpH9ehHtke5UcnqVGIJAqrvFV4gswKYnq
QzFBcWUMN6xq7Zzca6SrBsKpm9Ydu4Clj/5zQyRiS2CFKbcisEyHV11m8Wggyi5W
kYzTuHPnZhViPZBX2qETVPCu/0nU36VReYnLMLzggqGMko5hRlvVR7pVjAI4axCH
8VHJ9Hl+7udTZctpdEKJIBcD2DVSf06VAP0HLP4TqNknEsGjkJiVbwOVV6BryTAW
ayJe1HA4/rZFgYoz5Asn1XQjtXC9HdUq1prac3w47sFyWFmmU2akX679XXpdSZLM
6xz/O/YclPYqD2yDX/zahvDhKKJl3nXubV7A9HRnqpgTAxqfd4YlbaNJY9QB/2xF
17VDhyd3GGciAB7i+7rGIwW7sgLrmVAysJyEnYq/qvPuKl1pMmc=
=EXeI
-----END PGP SIGNATURE-----

--Sig_/LdAaxPfQu25bmEweAGvo=34--
