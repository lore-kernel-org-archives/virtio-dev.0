Return-Path: virtio-dev-return-6012-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 094A0985CF5
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Aug 2019 14:58:50 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:58:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190823145844.GA27586@stefanha-x1.localdomain>
References: <20190813131320.30829-1-stefanha@redhat.com>
 <20190813131320.30829-3-stefanha@redhat.com>
 <20190822133405.7a0fb101.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20190822133405.7a0fb101.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH v6 2/2] virtio-fs: add DAX window
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 01:34:05PM +0200, Cornelia Huck wrote:
> On Tue, 13 Aug 2019 14:13:20 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > Describe how shared memory region ID 0 is the DAX window and how
> > FUSE_SETUPMAPPING maps file ranges into the window.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
> > https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fu=
se.h
> >=20
> > v6:
> >  * Document timing side-channel attacks [Michael]
> > ---
> >  virtio-fs.tex | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >=20
> > diff --git a/virtio-fs.tex b/virtio-fs.tex
> > index 81adf85..154b043 100644
> > --- a/virtio-fs.tex
> > +++ b/virtio-fs.tex
> > @@ -178,6 +178,51 @@ \subsubsection{Device Operation: High Priority Que=
ue}\label{sec:Device Types / F
> > =20
> >  The driver MUST anticipate that request queues are processed concurren=
tly with the hiprio queue.
> > =20
> > +\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / =
File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
> > +driver-provided buffer and the device.  In cases where data transfer is
> > +undesirable, the device can map file contents into the DAX window shar=
ed memory
> > +region.  The driver then accesses file contents directly in device-own=
ed memory
> > +without a data transfer.
> > +
> > +Shared memory region ID 0 is called the DAX window.  Drivers map this =
shared
> > +memory region with writeback caching as if it were regular RAM.  The c=
ontents
> > +of the DAX window are undefined unless a mapping exists for that range.
>=20
> Are drivers still free to use FUSE_{READ,WRITE}?

Yes.  Will mention it in the next revision.

> > +
> > +The driver maps a file range into the DAX window using the FUSE\_SETUP=
MAPPING
> > +request.  Alignment constraints for FUSE\_SETUPMAPPING and FUSE\_REMOV=
EMAPPING
> > +requests are communicated during FUSE\_INIT negotiation.
> > +
> > +When a FUSE\_SETUPMAPPING request perfectly overlaps a previous mappin=
g, the
> > +previous mapping is replaced.  When a mapping partially overlaps a pre=
vious
> > +mapping, the previous mapping is split into one or two smaller mapping=
s.  When
> > +a mapping is partially unmapped it is also split into one or two small=
er
> > +mappings.
> > +
> > +Establishing new mappings or splitting existing mappings consumes reso=
urces.
> > +If the device runs out of resources the FUSE\_SETUPMAPPING request fai=
ls until
> > +resources are available again following FUSE\_REMOVEMAPPING.
> > +
> > +After FUSE\_SETUPMAPPING has completed successfully the file range is
> > +accessible from the DAX window at the offset provided by the driver in=
 the
> > +request.  A mapping is removed using the FUSE\_REMOVEMAPPING request.
> > +
> > +Data is only guaranteed to be persistent when a FUSE\_FSYNC request is=
 used by
> > +the device after having been made available by the driver following th=
e write.
> > +
> > +\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Type=
s / File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +The device MUST allow mappings that completely or partially overlap ex=
isting mappings within the DAX window.
> > +
> > +The device MUST reject mappings that would go beyond the end of the DA=
X window.
> > +
> > +\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Type=
s / File System Device / Device Operation / Device Operation: DAX Window}
> > +
> > +The driver SHOULD be prepared to find shared memory region ID 0 absent=
 and fall back to FUSE\_READ and FUSE\_WRITE requests.
>=20
> Should the _device_ also be prepared that the driver does not use the
> dax window? Likely yes (old drivers etc.); do we need to spell it out?

Yes, will fix in the next revision.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1f/yQACgkQnKSrs4Gr
c8jDzAf/YKJhND2SeDs4povfGzYpmwVpYJUEBOlYCnh4OBTMU8fBq0U2mYRgf2C2
qyD4IEv3DGzNcRBrdf/b5+837VfDjpp+Stp56oZ14Op0thppOReh7zFC0VaT5COe
7aHaJLjtnbyWb6nzIqRE0L7tkHYQGYAxSXKEBxuT0XMhL7O6U9c0UyaASRYrvJOV
A6qy29EyVa+V2DxVFiuuZu5U8gIMWNTn4O6SPvv8WAb1YiX5iiDC9ML4Vyk2k2Lx
yoSIGBByacAxkRbkMnADzJO1/ZQ/q/A4tgqVsuyMaGGbIW7hJmFl+5vJuxOSBjhs
iIQj5UUkPZv0P/dKm86EYDGxg9ToRw==
=n4eH
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
