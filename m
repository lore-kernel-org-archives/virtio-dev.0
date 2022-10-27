Return-Path: <virtio-dev-return-10101-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5789A98642B
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 13:05:01 +0000 (UTC)
Date: Thu, 27 Oct 2022 17:27:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <Y1r3wEnQwTsZqGWg@fedora>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Au/cWD3+9Ci2dusG"
Content-Disposition: inline
In-Reply-To: <20221007165643.3920613-4-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH v3 3/4] content: Introduce driver/device auxiliary
 notifications for MMIO
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Au/cWD3+9Ci2dusG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
> This includes the additions to the corresponding device and driver
> conformances.
>=20
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

You can keep this. One thought:

I realized that virtio-mmio support won't be very useful until
virtio-mmio gets MSI-X support because drivers currently cannot
differentiate between device auxiliary notifications.

Stefan

--Au/cWD3+9Ci2dusG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNa98AACgkQnKSrs4Gr
c8gbqAgAkkH5ksWWCyGMrMN5dgiz4cfUuPPIRKW8d77kWUj5m05wPa2/OtPt5HHR
4KCP8v+TNRCxa9ooLCzWjaSq1PIzggyGlSaQvG65JTC9rprPpZkXk4mr3Khc9Ogy
/n81xq3Hb87BDF2Y/NRTooeaQ7fIFUaBZZkB5upd0W7spZKlYztA9gLEwLxqic9v
gJ7sIYa/WkP9hAWCVNHytd6FTPMBcOY7QCvw77aU0BdL0vWbq+2VVNA5aF8j6rUy
oAIWdI/az8RPgsaQ+jUgaImuYqLl1k9Fthn8MGQExgpnt/3gY8HgV0XYXwPhO8An
lw+OAXuqRoegezVCQcIsoGsNWdmVMw==
=NGk4
-----END PGP SIGNATURE-----

--Au/cWD3+9Ci2dusG--

