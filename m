Return-Path: virtio-dev-return-5960-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75C5B985E4A
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 09:35:30 +0000 (UTC)
Date: Tue, 13 Aug 2019 10:35:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190813093523.GO9959@stefanha-x1.localdomain>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
 <20190803171259-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABYnUdqoGSokwVM+"
Content-Disposition: inline
In-Reply-To: <20190803171259-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--ABYnUdqoGSokwVM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2019 at 05:21:19PM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 26, 2019 at 10:53:37AM +0100, Stefan Hajnoczi wrote:
> > +\subsubsection{Security Considerations}\label{sec:Device Types / File =
System Device / Security Considerations}
>=20
> One issue not addressed here at all is sharing the filesystem cache.
> Is that a security consiteration at all?
> A shared resource is often an information sidechannel.

Will add to the next revision.

> > +
> > +The device provides access to a file system containing files owned by =
one or
> > +more POSIX user ids and group ids.  The device has no secure way of
> > +differentiating between users originating requests via the driver.  Th=
erefore
> > +the device accepts the POSIX user ids and group ids provided by the dr=
iver and
> > +security is enforced by the driver rather than the device.  It is neve=
rtheless
> > +possible for devices to implement POSIX user id and group id mapping or
> > +whitelisting to control the ownership and access available to the driv=
er.
> > +
> > +File systems containing special files including device nodes and setuid
> > +executable files pose a security concern.  These properties are define=
d by the
> > +file type and mode, which are set by the driver when creating new file=
s or by
> > +changes at a later time.  These special files present a security risk =
when the
> > +file system is shared with another system, such as the host or another=
 guest.
>=20
> is this a risk to someone using the device, another system
> with which this one is sharing, or both?

Both.  Will add to the next revision.

> > +This issue can be solved on some operating systems using mount options=
 that
> > +ignore special files.
>=20
> For this to be effective should not device provide a way for device
> to report that the issue exists?

Mounting with nosuid,nodev disables these features and therefore
eliminates the security issue.  The device doesn't need to notify or
being involved directly.

> >  It is also possible for devices to implement
> > +restrictions on special files by refusing their creation.
>=20
> And then it can safely be mounted without above flags?
> How would a device do this? The list above is not exhaustive.

The device would fail mknod and setting the setuid/setgid bits so that
clients cannot create these dangerous files.  The exact policy is
implementation-dependent, for example, the device may allow creation of
certain device major:minor nodes if the application depends on them.

Once these dangerous files cannot be created and if we trust that the
file system does not already contain them, then the nosuid,nodev mount
options are no longer necessary.

Since the details are implementation- and application-dependent I don't
want to go into detail in the spec.  The current virtiofsd implemenation
does not do any of this.

> > +
> > +When the device provides shared access to a file system, symlink race
> > +conditions, exhausting file system capacity, and overwriting or deleti=
ng files
> > +used by others are factors to consider.  These issues have a long hist=
ory in
> > +multi-user operating systems and also apply to virtio-fs.  They are ty=
pically
> > +managed at the file system administration level by providing shared ac=
cess only
> > +to mutually trusted users.
>=20
> Can we be a bit more explicit here? I think this discusses
> a device accessing a shared filesystem with some other
> device. I am guessing it's the administrator of the filesystem, right?

Yes, by "shared" I meant the scenario where multiple systems are
accessing the same shared directory tree.  I'll reword it in the next
revision.

Stefan

--ABYnUdqoGSokwVM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ShFsACgkQnKSrs4Gr
c8huPgf+OUCFhrmWRp+nPhzwICdjB9k3QmeaI2MTL+s+xuctiQQp28it6s7qsrDt
qDv3t4zjwRPk6T5MccbON9uTuyLdf6/2agXJN5mBpNYuFqmoztvYJBX/blg4oU9m
M98Bwmvx1J2K7pIbNtmpSFsYTA00mM76EVSAmLDSEGcuWI1hV6PdbUQ0EXl1a7iC
iGIPu15RYrNPcR2rH5KXwJ2syiUEp5OYs7/yrX5QQK1gkjH+TDeyA+DIVvp+EBM6
ZrJql3gvO6t6SUtuNtUb9FSook+6EzIiHUxuuSGKrWeVU385pyY4654FSEHAVpXH
Q//mRyUb1HpLEjlVKr2GfjwlArIghQ==
=MoHU
-----END PGP SIGNATURE-----

--ABYnUdqoGSokwVM+--
