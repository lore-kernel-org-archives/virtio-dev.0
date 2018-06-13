Return-Path: virtio-return-3133-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jun 2018 14:09:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613130943.GG24528@stefanha-x1.localdomain>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
 <1528733518-24950-7-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <1528733518-24950-7-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] Re: [PATCH v2 6/6] notifications: update notifications terminology
 for devices
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 06:11:58PM +0200, Halil Pasic wrote:
> The specifications of some virtio device types are still using the old
> terminology for used buffer notifications and configuration change
> notifications calling these interrupts.
>=20
> Let us fix that.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  content.tex |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIReXAAoJEJykq7OBq3PI/x0IAJWsy+0IoO4WX/swlVgpTgeL
BJJuPtnOk2S6OTzsbcLmcUoTkPIqIoE8dvTTRx2ENYVuaKcSoYXr5+uWOpjV/0yi
gmWFhDdyB4sYHYPPzI4liB1znAYF/l84jiejnBoVMVlqlxxmNDTC37pCRtHZolxH
M4xaDcZ6KRKfD0b7KLIF5ilLDB4USrnUJUX9LItnImt3AW41werWDQnWrH0oiMs9
JOJ5QWj2U+OikuiOJdYF0NaY6MisyVMlmyEhthmxnUfykz4ZQWuOY6mZpUlr/r3N
6+2xAQsowQtKpOApDf6IOgzAmSO6zlw7pnRzz/7g6+WrQWpsu0/dQQ9+ho6EfsA=
=SCf4
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
