Return-Path: virtio-return-3447-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 3 Nov 2020 17:18:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201103171834.GC259481@stefanha-x1.localdomain>
References: <20201029075047.119209-1-mst@redhat.com>
 <20201030113732.GG307361@stefanha-x1.localdomain>
 <20201030105945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201030105945-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio] Re: [virtio-dev] [PATCH] VIRTIO_F_RING_PACKED_USED:
 packing used descriptors
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:01:10AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 30, 2020 at 11:37:32AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Oct 29, 2020 at 03:50:57AM -0400, Michael S. Tsirkin wrote:
> > > +When after processing the used descriptor, the batch counter
> > > +exceeds the ring size, the batch counter is decremented by the
> > > +ring size; both device and driver then skip to the
> > > +beginning (offset 0) of the ring until processing (reading for
> > > +the driver and writing for the device) the next used descriptor.
> >=20
> > This may be clearer:
> >=20
> >   both device and driver then use ring index 0 for the next used
> >   descriptor
> >=20
> > Or:
> >=20
> >   The device writes the next used descriptor at ring index 0. The drive=
r
> >   reads the next used descriptor from ring index 0.
> >=20
> > I'm not sure I understand this scheme. Is this pseudo-code correct?
> >=20
> >   batch_counter +=3D num_used_descs
> >   if batch_counter > ring_size:
> >       batch_counter -=3D ring_size
> >       used_idx =3D 0
>=20
> yes
>=20
>=20
> > Can you share an explanation of how this scheme ensures that the
> > driver's next avail descriptor index never overtakes the device's next
> > used descriptor index?
>=20
> Simply because to overtake it, it needs to wrap around to 0.
> That happens when batch counter wraps over to 0, if we make
> device wrap at that point all is well.

What confuses me is that batch_counter is not reset to 0. It is set to
batch_counter -=3D ring_size.

I guess I need to get my crayons and draw pictures :-).

Stefan

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hkOoACgkQnKSrs4Gr
c8holQgAmfsNypri4XArOifeJBlZRpNBUocpueu+iFTluzEHe7tPMXLlfEmBBCJc
6ERwWZ3B91OaN8H/uw38Imlr+ohDAH7k9HeHWJyC6rq+HNwgoLX4ryHhA56Wbff4
1vlBQtRy+YW3CgxPou4p1eOqBNqxbNw/vBMTOBlLDKWlgsWFiq8mIWBZED9HhFir
MVN2hkOPsKOOC+Fbcy5wRxyjk6XYL+i1fnZUW/n2blTnZIlknBsguAJtqZDdyWP5
Xl4Z7heFm8XKKbCbJ/afsnk/yG7+bjl6360h8RKeoZ5e+uBFA8J/8xz4lf6g4AD/
yb3BW1EGrw5kZNPzppNBAWeBitwxCg==
=/YAn
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

