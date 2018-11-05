Return-Path: virtio-dev-return-4933-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2415F9842C4
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Nov 2018 08:53:41 +0000 (UTC)
Date: Mon, 5 Nov 2018 08:53:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181105085337.GA9934@stefanha-x1.localdomain>
References: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
Subject: Re: [virtio-dev] Device-to-driver notification management for
 hardware implementations
To: David Riddoch <driddoch@solarflare.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 05:41:07PM +0100, David Riddoch wrote:
> The VIRTIO_F_NOTIFICATION_DATA feature helps hardware implementations by
> telling them directly how many descriptors are available in the ring, sav=
ing
> speculative reads.=A0 There is a related issue with interrupts: As things
> stand, after writing 'used' descriptors into the ring (packed or split) t=
he
> device has to read the event idx to determine whether a device-to-driver
> notification (interrupt) is needed.
>=20
> It would be very helpful to a hardware implementation if the event idx co=
uld
> be written directly to the device.=A0 Has anyone proposed an extension to
> address this already?=A0 (I have some thoughts on how to do this if we do=
n't
> have a proposal yet).

Hi David,
Has there been any further discussion on this topic?  It seems like a
useful feature to have in VIRTIO.

Stefan

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4AURAAoJEJykq7OBq3PIuhcH/1PzkmAEvu7UJOizfP1zEWXp
JFLJ+5B1mRvqPqLJs/zPKoUfqm3rfTCw+MLBGBaq4IJb+PDwvMEKMmjRl+gfIPUT
tiOKlJ5TQvk/e7WtiASIc1oSESVT0jX9dWemmYFNTwvDnRBu+61Y8Y3/PFHesi1y
vbJzBc9ipSYtBAzYVc0I0zx+flA8rir/WUIUcER9Q9faTNJT91U//gI8S+qKGcdK
fLpjainO3pYggkG5wHtnkrEe6wHq7HageX8Y1n3agPmd+4vg/iu/JW2wMfdQc6+U
MlSuj6kbCQM+wjkj51va1DpLQRKDL1PeetC2xVzFdQ8xLvMa78BfKh1RpckURnQ=
=ORsE
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
