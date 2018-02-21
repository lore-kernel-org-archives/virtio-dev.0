Return-Path: virtio-dev-return-3249-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 353265818120
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2018 03:33:43 -0800 (PST)
Date: Wed, 21 Feb 2018 11:33:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221113328.GB19501@stefanha-x1.localdomain>
References: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
 <20180220171544.GC12161@stefanha-x1.localdomain>
 <20180221001135.41bc13a1@fiorina>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20180221001135.41bc13a1@fiorina>
Subject: Re: [virtio-dev] [PATCH] content: document balloon memory statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 12:11:35AM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> On Tue, 20 Feb 2018 17:15:44 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Mon, Feb 19, 2018 at 02:10:29PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=
=C3=BD wrote:
> > > +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory currently us=
ed for
> > > +  caching files and other data from disk (in bytes).
> > >  \end{description} =20
> >=20
> > This one is somewhat vague.  I'm not sure if it means guest page cache
> > specifically or something more general.
> >=20
> > On the other hand, the numbers tend to be OS specific...
>=20
> We should come up with a definition that is as definite as possible
> while leaving room for all systems to substitute a value that is
> natively available. So if anyone has a better formulation then please
> advise. The original intent was not to create a Linux specific field.
>=20
> On Linux the value corresponds to Buffers + Cached + SwapCached memory
> stats. Correct me if I'm wrong but that should be all clean pages that
> have a counterpart on disk and can be quickly reclaimed and used for
> something else (without additional IO).

Thanks for clarifying.  Based on what you posted, how about:

"The amount of memory, in bytes, that can be quickly reclaimed without
additional I/O.  Typically these pages are used for caching files from
disk."

?

> On Windows this roughly corresponds to the standby list. Or maybe
> standby list plus something else. I suppose there may be some
> alternative on BSD too.
>=20
>     Tomas
>=20
>=20
> --=20
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajVkIAAoJEJykq7OBq3PIGmUIALP9whe7zVy9vz4QEhNRvsQo
vnie7fRJ2ADU3KSRm5MzcDUGU1uMvW36TPOOFkrlu3fJPSVooYfSZFUfYEP8W09V
H7guyuzCbhN5KquDmbUvYBWFp/Dw7mPAYYagt1Y8X5doSEq8Rm4X/LxvDsLaviyF
rnzQlMStcf0FmRjJdAvgJ+B0srE30z5S8Yb047jCpZw6bSfgKDVDCJcey/JG8K0j
2mPJy73ypf/an8UArhdn4MnpVDNUu1Fd3j7b/Ft5FrLMb1o+TNgpvdk8OllmSKya
ShFra5+AgphA2vbdCCZPCPz7dWuuMBzyrJtIY63DXvj3exPhc0RDxfugyo5x7XM=
=zxRI
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
