Return-Path: virtio-return-3159-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 2 Jul 2018 16:51:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180702155134.GN2155@stefanha-x1.localdomain>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [PATCH v3 0/6] rework notifications terminology
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 02:21:26PM +0200, Halil Pasic wrote:
> Abstract=20
> --------
> The terminology around notifications is currently somewhat
> fragmented. Unify notifications terminology using available and used
> buffer notification consistently for the virtqueue notifications.
> Consistent use of the term configuration change notification is of
> concern.
>=20
> Changelog:
> ---------
> v2 -> v3:
> * Addressed all comments from the previous round
> * Added r-b's
>=20
> v1 -> v2:
> * Addressed Stefan's comments (mostly typos, grammar and inconsistencies).
>   Thanks Stefan!
> * Rebased onto the current master.
>=20
> RFC -> v1:
> * Devices and the transports PCI and MMIO were omitted.
> Now the rework should be complete.
> * Addressed review comments and minor changes for the first
> three patches.=20
>=20
> Halil Pasic (6):
>   notifications: unify notifications wording in core
>   notifications: notifications as basic virtio facility
>   ccw: map common notifications terminology to ccw
>   pci: map common notifications terminology to PCI
>   mmio: map common notifications terminology to MMIO
>   notifications: update notifications terminology for devices
>=20
>  cl-os.tex       |    2 +-
>  conformance.tex |   10 ++--
>  content.tex     |  164 +++++++++++++++++++++++++++++++++++++++++--------=
-----
>  packed-ring.tex |   60 +++++++++++---------
>  split-ring.tex  |   72 ++++++++++++++----------
>  5 files changed, 206 insertions(+), 102 deletions(-)
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOkoGAAoJEJykq7OBq3PIMukH/iWrEKdrF7JRAzimBgSko3yo
qMCHlgye3h1K4U0+M9ZAug8K5qSwO2Lt0IEE6Vs8fW6He6vbU84aOYTbVbteQGZU
+3GUNH0boLlWcSBrC1aalz6jPYQJRcRa/+4lsPJWWh0D2WI+5IqOR+S47CRpYeis
he3EyGJn1yF314ltGRhhpjkzdOjp1YVKfRMpi4VQhHwm+ZKUm4JfZMhpqe0OLzZi
NdtE2DAMaw9saCsFIiXBU3hvwQkDiNPuo60k2TONcpcyXbEGDWBr/XrNSq4X6mS4
Pd5R4ZpnE+nxbCq5xEXl0m5ErSxNSJlnO3OKGyFVe4ZrVsvdPmZ/esHsAk8x/iU=
=ub/W
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
