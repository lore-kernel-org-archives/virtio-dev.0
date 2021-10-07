Return-Path: <stefanha@redhat.com>
Date: Thu, 7 Oct 2021 09:41:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2] content: Remove duplicate paragraph
Message-ID: <YV6yqO+nfZc8QJKC@stefanha-x1.localdomain>
References: <20211006112816.71892-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MP/y9ACLsO0uxFMD"
Content-Disposition: inline
In-Reply-To: <20211006112816.71892-1-jean-philippe@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


--MP/y9ACLsO0uxFMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 12:28:19PM +0100, Jean-Philippe Brucker wrote:
> It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
> type") had a merge issue. It includes the device normative paragraph for
> Shared memory capability, which was already added right above it by
> commit 855ad7af2bd6 ("shared memory: Define PCI capability").
>=20
> The two paragraphs differ, and the first paragraph is correct. It refers
> to struct virtio_pci_cap64 which embeds struct virtio_pci_cap:
>=20
>   struct virtio_pci_cap64 {
>     struct virtio_pci_cap {
>       ...
>       le32 offset;
>       le32 length;
>     } cap;
>     u32 offset_hi;
>     u32 length_hi;
>   }
>=20
> Merge the two paragraph while keeping the best of both. Drop the spaces
> after \field to stay consistent with the rest of the document.
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07815=
=2Ehtml
> ---
>  content.tex | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MP/y9ACLsO0uxFMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFesqgACgkQnKSrs4Gr
c8j2BggAkNUx0qX1F/ghBLOj7JKvRLcVlS/sgczLYraBa9YRgJFyzzTVARmnsRmn
d84h0ebGJrbieoVwSI8V3lEgdIkyjg5T5aDFCT6o50zoL2uKAHA0ySw2FlL+v22g
2JCAegQwWtoeXyp7EjCqrX76FYIouYUGla269ofPVRCUOcUh+P2JUTKrR1nr92Rj
tbZzP/TXq1XbOHwSjuC7j7pIw+yEFI7DkqhaoGd6xCYHAKnpNHItcSkEhS3PykGz
N8J5pu2+vwuQXw0174q2dtdI3NjRAa1xnpB2wd7hIG4xXybMiTo8Vlt58AngYnna
NyEcoP8x0BYZqWlRxNS0re6r1jMsow==
=UPQM
-----END PGP SIGNATURE-----

--MP/y9ACLsO0uxFMD--

