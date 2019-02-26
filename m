Return-Path: virtio-dev-return-5534-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96B72985DC5
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Feb 2019 19:54:27 +0000 (UTC)
Date: Tue, 26 Feb 2019 19:54:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190226195423.GA7023@stefanha-x1.localdomain>
References: <20190226162553.30231-1-stefanha@redhat.com>
 <20190226180903.497cccaa.cohuck@redhat.com>
 <20190226174416.GA2339@stefanha-x1.localdomain>
 <20190226184521.5f3dc061.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20190226184521.5f3dc061.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-blk: clarify semantics of
 multi-segment discard/write zeroes commands
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 06:45:21PM +0100, Cornelia Huck wrote:
> On Tue, 26 Feb 2019 17:44:16 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Tue, Feb 26, 2019 at 06:09:03PM +0100, Cornelia Huck wrote:
> > > On Tue, 26 Feb 2019 16:25:53 +0000
> > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >  =20
> > > > Describe the failure case and maximum number of segments in a
> > > > multi-segment discard/write zeroes command.
> > > >=20
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/34
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > > I would like to request a vote on this. =20
> > >=20
> > > Only one minor nit from me, below.
> > >  =20
> > > >=20
> > > >  content.tex | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/content.tex b/content.tex
> > > > index c5fdc34..7bfcc78 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3967,8 +3967,10 @@ read from the block device (in multiples of =
512 bytes).  VIRTIO_BLK_T_OUT
> > > >  requests write the contents of \field{data} to the block device (i=
n multiples
> > > >  of 512 bytes).
> > > > =20
> > > > -The \field{data} used for discard or write zeroes command is descr=
ibed
> > > > -by one or more virtio_blk_discard_write_zeroes structs:
> > > > +The \field{data} used for discard or write zeroes commands consist=
s of one or
> > > > +more segments.  The maximum number of segments is \field{max_disca=
rd_seg} for
> > > > +discard commands and \field{max_write_zeroes_seg} for write zeroes=
 commands.
> > > > +Each segment is of form: =20
> > >=20
> > > Maybe s/of form/of the form/ ? =20
> >=20
> > I wanted to stay consistent with the existing text above it:
> >=20
> >   The driver queues requests to the virtqueue, and they are used by
> >   the device (not necessarily in order). Each request is of form:
> >=20
> >   ...
>=20
> Fine with me as well.

Okay, great!  Let's leave it as-is.

Stefan

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdZlvAAoJEJykq7OBq3PIZmIH/RZ6QimHl1NWHORtn9WcZ/y2
tBC15OTwthA/AAP7zKxc8wTyWT20PRTklXG9t1FBHPvrpql2vWKp7k/3APz/sc4h
GojPuE5G0t7p11qBfq12Wuh4Plo4xvrgRKVqVfL6tgZJLxYx5vAHqs/buSMP1eba
Cjyqw9/eHtLbY8XOGPUFuU+JzlWAVYaZ4ElFRbmSqnUFaT4kHJf89x+0ZRv2H6tP
DgB5U9J0d9DXd43B70WVLCDCH7jLA+jUmKx9VDoBWjzIICdlo9E9sMBNSsnkzIDP
R0wLx+GVos1O9jXs1MXb+DIRgSzu+kbMXNo0lnIdoWgqHZGdk7ao67uBt6qmsao=
=VRC/
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
