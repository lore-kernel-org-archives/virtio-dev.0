Return-Path: virtio-dev-return-4116-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 041A358191BB
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 06:07:37 -0700 (PDT)
Date: Tue, 22 May 2018 11:03:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180522100337.GK21655@stefanha-x1.localdomain>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
 <20180517130604.9036-2-venu.busireddy@oracle.com>
 <20180518160623.GB21655@stefanha-x1.localdomain>
 <20180518214336.GA26509@troi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <20180518214336.GA26509@troi>
Subject: Re: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to
 virtio PCI capabilities.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 04:43:36PM -0500, Venu Busireddy wrote:
> On 2018-05-18 17:06:23 +0100, Stefan Hajnoczi wrote:
> > On Thu, May 17, 2018 at 09:06:04AM -0400, Venu Busireddy wrote:
> >=20
> > Can you describe a use case where vendor-specific extensions make sense
> > as opposed to extending the VIRTIO specification?
>=20
> Sometimes, qemu may need to group certain devices together. In our
> problem scenario, qemu needed to tell the driver which virtio device is a
> fallback device for a given vfio-pci device. If the virtio device's PCI
> capabilities are extended, the new capability could be used to store a
> unique ID (say, the bus:device:function) that identifies the vfio-pci
> device. The driver can use that information when needed to pair the
> virtio device with the vfio-pci device.

This feature seems generic and could be in the VIRTIO spec proper.  What
is vendor-specific about it?

> Extending the VIRTIO specification is also a good alternative, but
> every time the vendor needs something new, the specification needs to
> be changed again. A generic "vendor specific" mechanism alleviates that.

If you plan to push Linux code changes upstream to implement this
feature then a vendor-specific extension is inappropriate and you should
extend the VIRTIO spec.

Stefan

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbA+r5AAoJEJykq7OBq3PIxAYH/Axf8K7SHnd6askgobF9WdLy
T5bvD63pABmz0y6XITglx+DEmOWgUFMwl1S8h17YqnK7zjztvhVL6VNI6krxy3Vu
JgZXFgGTIZ20KmWB5WPaJ04AhrQvpL5Z7IhTq/85e2L3Q9nUs2Q2wDRZ4g9p1Juz
ZqfKrY7DQcANJLGKXvlTVNXhhq5GQv+SnVdF5kIfqVhpVglRoZI9z/2HlEX0QIQg
yvlUTT8ioBdAex6jIVN1NREEwUdUazSVVNkwuCxcRgJYK1AVEN6AeDfEhnojvLBd
lwVTczp+VxbuAajh6Lu0S+HO1dJpN5qT8Aw8EY6vPd/1CRV0RwkzVpF8tBXzOBA=
=v2lW
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
