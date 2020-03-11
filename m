Return-Path: virtio-dev-return-6933-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B2BB985FD9
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Mar 2020 17:24:27 +0000 (UTC)
Date: Wed, 11 Mar 2020 17:24:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200311172411.GG281087@stefanha-x1.localdomain>
References: <874kv15o4q.fsf@linaro.org>
 <20200309154637.GJ7668@stefanha-x1.localdomain>
 <871rq1jx70.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <871rq1jx70.fsf@linaro.org>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 04:43:31PM +0000, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Fri, Mar 06, 2020 at 06:33:57PM +0000, Alex Benn=E9e wrote:
> >> So the context of my question is what sort of common software layer is
> >> required to implement a virtio backend entirely in userspace?
> >
> > Yes and no.
> >
> > vhost-user is currently the most widely-used (cross-VMM) interface for
> > out-of-process VIRTIO device emulation.
> >
> > However, it's not a library, just a protocol specification involving
> > UNIX domain sockets.  You mentioned the various implementations below:
> >
> <snip>
> >
> >> backend be emulated purely with some shared memory and some sockets fo=
r
> >> passing messages/kicks from/to the VMM which then deals with the hyper=
visor
> >> specifics of the virtio-transport?
> >
> > Yes, that is what vhost-user does.
>=20
> I thought so - but does any vhost-user implementation assume it has
> access to the entire of the guests memory space? I can see why that
> might be seen as undesirable from a security point of view.

VMMs typically give the vhost-user device program access to the entirety
of guest RAM.  That's because unmodified VIRTIO guest drivers typically
require access to all of guest memory.

If the guest software cooperates then it's possible to reduce the shared
memory region.  In other words, the vhost-user protocol doesn't demand
that guest RAM is shared, it just requires all addresses to be within
the shared memory region, whatever that may be.

> So aside from virtiofsd and crosvm's various pieces for crostini
> emulation what other out-of-VMM device emulation daemons are you aware
> of?

I haven't checked but my understanding was that crosvm uses its own
out-of-process device interface (not vhost-user).

The previously mentioned vhost-user ones were DPDK
(https://www.dpdk.org/) and SPDK (https://spdk.io/).

Sergio Lopez has implemented vhost-user-blk in Rust:
https://github.com/slp/qsd

I think Nutanix is also using vhost-user, but am not sure and I don't
know if that is open source.

There are probably more that I'm not aware of but a web search would
turn up.

Stefan

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pHrsACgkQnKSrs4Gr
c8iOGwf+LkHuUvY4ieaMpq08H0iN9c7zgECvQmx236ivA8GkoX7QkN44edr7D8ld
60Vb146NY4WrvxH+rjwG9wlGM4G6MJqKSEVcB7NcV+Eg4Ksg07Y4aF3ubtIkRX5p
WqVmiRqUTsAHDaefPN4NO2bRdizRxyBQiFs8IksZmJKvUagOc/DjvagV5p30XwT/
G9WcdH0n93/4D+gwhP7QVNmS3BVpVe4+Yx4HBbF+vJZtNHmSWrqvqL9LC6cZ7Uqz
EBgLoBQN59FPnPVoWanvXOysrMOZrliYW4LD9CjBk1IybohmNpCTtEtMf51LhQQk
hfYOfiXaIUshYrNIn9ggDqzrycuPMw==
=qPDo
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

