Return-Path: virtio-dev-return-4134-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A213F5818F8A
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 May 2018 05:31:00 -0700 (PDT)
Date: Wed, 23 May 2018 13:30:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180523123048.GE3898@stefanha-x1.localdomain>
References: <20180517130604.9036-1-venu.busireddy@oracle.com>
 <20180517130604.9036-2-venu.busireddy@oracle.com>
 <20180518160623.GB21655@stefanha-x1.localdomain>
 <20180518214336.GA26509@troi>
 <20180522100337.GK21655@stefanha-x1.localdomain>
 <20180522134858.GA27663@troi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20180522134858.GA27663@troi>
Subject: Re: [virtio-dev] [PATCH 1/1] Allow "Vendor Specific" extension to
 virtio PCI capabilities.
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 08:48:58AM -0500, Venu Busireddy wrote:
> On 2018-05-22 11:03:37 +0100, Stefan Hajnoczi wrote:
> > On Fri, May 18, 2018 at 04:43:36PM -0500, Venu Busireddy wrote:
> > > On 2018-05-18 17:06:23 +0100, Stefan Hajnoczi wrote:
> > > > On Thu, May 17, 2018 at 09:06:04AM -0400, Venu Busireddy wrote:
> > > >=20
> > > > Can you describe a use case where vendor-specific extensions make s=
ense
> > > > as opposed to extending the VIRTIO specification?
> > >=20
> > > Sometimes, qemu may need to group certain devices together. In our
> > > problem scenario, qemu needed to tell the driver which virtio device =
is a
> > > fallback device for a given vfio-pci device. If the virtio device's P=
CI
> > > capabilities are extended, the new capability could be used to store a
> > > unique ID (say, the bus:device:function) that identifies the vfio-pci
> > > device. The driver can use that information when needed to pair the
> > > virtio device with the vfio-pci device.
> >=20
> > This feature seems generic and could be in the VIRTIO spec proper.  What
> > is vendor-specific about it?
> >=20
> > > Extending the VIRTIO specification is also a good alternative, but
> > > every time the vendor needs something new, the specification needs to
> > > be changed again. A generic "vendor specific" mechanism alleviates th=
at.
> >=20
> > If you plan to push Linux code changes upstream to implement this
> > feature then a vendor-specific extension is inappropriate and you should
> > extend the VIRTIO spec.
>=20
> I will redo the patch to extend the virtio specification.
>=20
> Since the new patch will be conceptually different, shall I create a
> new thread, or should I post it as v2?

Please post a new patch.  Thanks!

Stefan

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBV74AAoJEJykq7OBq3PID3QH/2Iox3Yk5Ct+P3/x4pLSVX1o
+mEXf4OUYzP+RsBho8JSDm1iFVmM/9YUriI4ML1Ec4a+R3CdeCC3diHSQ/nQ/H64
byrCCfyt0Ch8GXYBnTU1cxKqWOfVtXYn0gXuSVNT3YTAFZdtLzolHNVMn8yFMVhK
ZzP5+MbDxPkugZA8lB5VCJX5JZ2iLNMeVAAhOm7BuxtQOCD13VVETpN1PWgp/ZZb
jYyS1dfVmqU6TBvf7XUQDHOcgDc9GEpcUCQLbk25IT8HpT3QtS+8wR9nTTlAIN7M
FY2qG72pUc/QPVwPAXRd4lOaPQANojZn7RLkhQdfYtJBUYVJ07COqsNWX02jKbU=
=8RhG
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
