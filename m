Return-Path: virtio-dev-return-5970-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2650985E52
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 15:13:21 +0000 (UTC)
Date: Tue, 13 Aug 2019 16:13:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190813151315.GB32090@stefanha-x1.localdomain>
References: <20190726095338.24991-1-stefanha@redhat.com>
 <20190726095338.24991-2-stefanha@redhat.com>
 <20190803170121-mutt-send-email-mst@kernel.org>
 <20190813090711.GN9959@stefanha-x1.localdomain>
 <20190813071146-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20190813071146-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v5 1/2] content: add virtio file system
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 07:24:45AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 13, 2019 at 10:07:11AM +0100, Stefan Hajnoczi wrote:
> > On Sat, Aug 03, 2019 at 05:12:15PM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jul 26, 2019 at 10:53:37AM +0100, Stefan Hajnoczi wrote:
> > > > +\subsubsection{Live migration considerations}\label{sec:Device Typ=
es / File System Device / Live Migration Considerations}
> > > > +
> > > > +When a guest is migrated to a new host
> > >=20
> > > Please use driver and device here and elsewhere.
> >=20
> > Will fix.
> >=20
> > > > it is necessary to consider the FUSE
> > > > +session and its state.  The continuity of FUSE inode numbers (also=
 known as
> > > > +nodeids) and fh values is necessary so the driver can continue ope=
ration
> > > > +without disruption.
> > > > +
> > > > +It is possible to maintain the FUSE session across live migration =
either by
> > > > +transferring the state or by redirecting requests from the new hos=
t to the old
> > > > +host where the state resides.  The details of how to achieve this =
are
> > > > +implementation-dependent and are not visible at the device interfa=
ce level.
> > > > +
> > > > +Maintaining version and feature information negotiated by FUSE\_IN=
IT is
> > > > +necessary so that no FUSE protocol feature changes are visible to =
the driver
> > > > +across live migration.  The FUSE\_INIT information forms part of t=
he FUSE
> > > > +session state that needs to be transferred during live migration.
> > >=20
> > > It bothers me that it's implicit, and is not exposed easily at the
> > > virtio level, so one has to bind a virtqueue and run buffers over it =
to
> > > even just check whether a given device supports a specific interface =
and
> > > can be migrated to.
> > >=20
> > > How about exposing the version of the device in the config space?
> > > Spec can require that it matches the contents of the INIT command.
> >=20
> > FUSE_INIT works like this:
> >=20
> > 1. The client sends FUSE_INIT with the supported highest protocol
> >    version.
> > 2. If the server supports the client's version, it replies with the same
> >    version number and fills in the FUSE_INIT parameters.
> >=20
> >    Otherwise the server lowers the version number and replies to the
> >    client, and the client will resend FUSE_INIT with the lower version
> >    number to acknowledge that it supports the lower version.  Go to step
> >    1.
> >=20
> > With regards to live migration the server's FUSE_INIT reply structure
> > needs to be sent to the destination if a FUSE session has been
> > established.  If the destination does not support this protocol version
> > then live migration fails.
> >=20
> > If management tools want to ensure that migration always succeeds then I
> > think the way to do that is not via virtio config space (they would
> > still need to start a guest in order to access it!).
> >=20
> > I don't understand the benefit of exposing the device's version in the
> > config space?  Do you mean the negotiated version of the current FUSE
> > session or the highest FUSE protocol version supported by the device?
>=20
> The highest version.
> The point is to make it crystal clear that for cross version migration
> the highest version must be consistent.
> Otherwise this is something implementers might easily overlook.

For migration the current FUSE session's negotiated version must be
supported by the destination.  That's all.  The highest version
supported by the device doesn't matter.

> Another option is to add non-normative text explaining what must
> be kept consistent to allow migration between devices.
>=20
> Generally I think that it is unfortunate that pass-through
> devices like this one are growing extensions for
> feature negotiation outside the spec.
> This hurts attempts at generic transport pass-through like vhost-user.

I'm not sure how we'll implement vhost-user live migration.  Currently
the vhost-user protocol doesn't allow the slave to provide migration
state.  But we'll need to do this in order to transfer all the state
associated with the virtio-fs device (FUSE_INIT struct, inodes, file
locks, etc).  It's important to recognize that this state goes way
beyond the FUSE_INIT struct, there is a lot of implementation-specific
state associated with a FUSE session!

Stefan

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1S04sACgkQnKSrs4Gr
c8j4iwf7Bqn1YqSWYmOkAyvXg/3mPuzzswFVxDUhEm7Dv0OpV2GLLagVJzx48Im2
/1O61mZVp6GI3TUfVbQJrGoyKD6fPH9hVL49iSEl2GkhD03WOo5KBJ7uBp4LBBPd
/arWwLg814Lz1hCtK52QaY4I6mVSoVYPnuRJj7yVDClMyGwKOBMXYUOYVuVBOQtX
G5eDMpOkjIktgOZkh/GSNsdTq4E9/20RpBUZnFZs6gUTpQAAK0okHNAF8qPZLE6N
WMd7MhvKSe6AkS/JupXZ6Fk6GzQQqhhFNZCCGTQdE0xgr5qeQ2+Sc25OtvbBIi+J
RFQw1vDy0A1YvjpbiUZEGocAXiiJaw==
=HHYH
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
