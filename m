Return-Path: <virtio-dev-return-10107-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C93F98642C
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 18:52:46 +0000 (UTC)
Date: Mon, 31 Oct 2022 13:26:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y2AFPb75/fVd38pa@fedora>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com>
 <Y1r3wEnQwTsZqGWg@fedora>
 <a0773598-1ce5-1b98-5aa1-95350bccdbb6@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z02RkBrIY9zPCs6H"
Content-Disposition: inline
In-Reply-To: <a0773598-1ce5-1b98-5aa1-95350bccdbb6@bytedance.com>
Subject: Re: [virtio-dev] Re: [External] Re: [PATCH v3 3/4] content:
 Introduce driver/device auxiliary notifications for MMIO
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Z02RkBrIY9zPCs6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 02:22:22PM +0000, Usama Arif wrote:
> On 27/10/2022 22:27, Stefan Hajnoczi wrote:
> > On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
> > > This includes the additions to the corresponding device and driver
> > > conformances.
> > >=20
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > You can keep this. One thought:
> >=20
> > I realized that virtio-mmio support won't be very useful until
> > virtio-mmio gets MSI-X support because drivers currently cannot
> > differentiate between device auxiliary notifications.
> >=20
> > Stefan
>=20
> Did you mean drivers currently cannot differentiate between "driver"
> auxiliary notifications? The driver will be able to be able to choose the
> index it wants to notifiy using DeviceAuxNotificationIndex.

Yes, sorry!

>=20
> I can add the following line in the Interrupt Status change of the patch =
if
> it makes sense?
> "As MSI-X is not available, it is not possible to determine which driver
> auxiliary notification occured, hence only a single notification is
> supported."

Yes, that is how I understood the mechanism to work. Depending on the
nature of the device-specific event, it may be unworkable for the driver
to have no way of identifying the exact event.

Stefan

--Z02RkBrIY9zPCs6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNgBT0ACgkQnKSrs4Gr
c8jvpQf/WL5FURQxS94zpcGacgT0v8wfcDzOrCSbBJg3mC358dTzNBVqnaz9ix7P
hSBjF9qmRK18CxjAnOSAW6eeHZ2PpmE1qJiBf08XRu3MogNQYtsj56WmVoPQ/rob
4JVxotOI+WLDL8zYU07t/PnJFtaBCfuHsJjW5ed00Y4+HyAvhGgypD9cJslbivQ6
rkg7KG96kBUv71/hsNgM8shJBWr1CKRODbMsJhnHpTDO86tdVJHCHWtYZmDSTg43
RCpnHrRI5e2LI7Fzt/bgzryv2XPW9AGmkna1JqDFc0Iy/qx1rAqDbEtVsHbHwlsY
JQMX4tiWulccM0+DMTa0IymdL210zg==
=WSQw
-----END PGP SIGNATURE-----

--Z02RkBrIY9zPCs6H--

