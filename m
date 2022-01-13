Return-Path: <virtio-dev-return-9031-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B3849864F2
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 14:53:41 +0000 (UTC)
Date: Thu, 13 Jan 2022 14:53:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YeA88PL9oOfphhoa@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <Yd//qzpb7EJ1fa1y@stefanha-x1.localdomain>
 <20220113054324-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220113054324-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="piOnwOB6HRv0yWBS"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--piOnwOB6HRv0yWBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 05:45:11AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 13, 2022 at 10:32:11AM +0000, Stefan Hajnoczi wrote:
> > > So my understanding is that instead of delaying the response to read
> > > it's better to simply present the previous PASID value if there're an=
y
> > > pending transactions of previous PASID value. The driver can then
> > > choose to poll or using timers etc.
>=20
> Don't we limit these changes to before DRIVER_OK?
> If we do then no previous transactions can exist.

Not sure if that's possible for the vDPA virtqueue assignment use case
where one large VIRTIO device provides virtqueues for many smaller vDPA
devices?

Stefan

--piOnwOB6HRv0yWBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHgPO8ACgkQnKSrs4Gr
c8i2owgAw+rlplIlHJcGk9jarpXurFFiBiptPbcn/rR6H8YOFTIS9d6Av+Tg6+mI
bbOKsbqK60PCttBMU3Dg/51Izwiun43YYrDqLHRGggWJr+EJ2EomkENLmocKHUFf
9+v/+X4bjYER9mHstG/wmuHJPE808Y86l+/zlLkNCzXgP7KlrwBSVqHnpQZACHdw
cN++k5vCeJUZPFgTBei0U/09wIf6RekSZ2tNn6TruTc7Lpdy4GByQFqXT7XrKqJE
32lUDg65t5ZSy0UdHrkj4kVkJxok/pzzhmNhO8irYxZbj3obC0wPUnhAaiTVRNtH
Pgd9kb/KlbpPabmcX+MMn19rHwGUBw==
=f+X7
-----END PGP SIGNATURE-----

--piOnwOB6HRv0yWBS--

