Return-Path: virtio-comment-return-1636-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jan 2021 14:40:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20210113144055.GE255928@stefanha-x1.localdomain>
References: <dfb21780647c69519f01fb0afbbd18f780963af9.1610091344.git.jie.deng@intel.com>
MIME-Version: 1.0
In-Reply-To: <dfb21780647c69519f01fb0afbbd18f780963af9.1610091344.git.jie.deng@intel.com>
Subject: [virtio-comment] Re: [PATCH v7] virtio-i2c: add the device specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 03:39:08PM +0800, Jie Deng wrote:
> virtio-i2c is a virtual I2C adapter device. It provides a way
> to flexibly communicate with the host I2C slave devices from
> the guest.
>=20
> This patch adds the specification for this device.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  conformance.tex  |  28 +++++++--
>  content.tex      |   1 +
>  introduction.tex |   3 +
>  virtio-i2c.tex   | 176 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 204 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-i2c.tex

Looks good! Thank you for answering my questions and updating the spec.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl//BnYACgkQnKSrs4Gr
c8i/oggAjU9NuJhdHXor3AmlZuFUCd2bm5/tNcagCznzbOlvRM2a2P55Y/GHQj5a
Ehf92pGWZJhhEp/bQdKS25SP51xjlHD+ywjNS39nVR6NlQ33+bKOE5lsvxYNZTHA
iHVZsDLnBiGvA4sgL31N1SJp69RBCTtM2bU/K5nTRU1QAo8WmKQmeC0/z4T5vx1E
N4StxL5hSkQL9F79O6DyPPzKX2qvTD5/OH1HFsstOVZgNEZ73xZYg/WCT93ahTuD
qeqdXN+aCO0TAYjJnOxj35WclkAy19XJVGOqmbOiRAPC74DWikimOAjrp9fpzKFk
guMmzAsBhd/8A9rT2hYQWS45ZI0JaQ==
=bREF
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

