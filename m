Return-Path: virtio-return-3325-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 26 Mar 2019 10:25:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190326102536.GL21018@stefanha-x1.localdomain>
References: <20190318225430.16823-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Content-Disposition: inline
In-Reply-To: <20190318225430.16823-1-mst@redhat.com>
Subject: Re: [virtio] [PATCH] block: drop duplicate text
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Gil Savir <gil.savir@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 06:54:37PM -0400, Michael S. Tsirkin wrote:
> In version 1.1 draft 01 - Section 5.2.6.4 - second bullet:
>=20
> Duplicated text "errors, data_len, sense_len and residual MUST reside in
> a single, separate device-writable descriptor" appears +both in the
> beginning and at the end of the 2nd sentence.
>=20
> The original text:
>=20
> For SCSI commands there are additional constraints. errors, data_len,
> sense_len and residual MUST reside in a single, separate device-writable
> descriptor, sense MUST reside in a single separate device-writable
> descriptor of size 96 bytes, and errors, data_len, sense_len and
> residual MUST reside a single separate device-writable descriptor.
> I suggest to delete the 1st one, so in the end result, fields are
> described in same order as appear in struct virtio_scsi_pc_req.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/39
> Reported-by: Gil Savir <gil.savir@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcmf4gAAoJEJykq7OBq3PIa4gIAK6tNv6fHa18QSeAvxXeAnAb
ahtfX/phCGbnCDx/1+DdZUids9dQOLh2BJzBGnr8y1G1JHunIn7FNoDQ4vsJ23Tj
FW6Lx+5adLVMk0HPdvGz33OolthmMuh1F4ulyr5DGbvtHgHktCUZBxW5n7ZTDrfp
xzn0/d2EXknOMz1W1Quxqo16SzTYYU5qYINkUEYSoMBSCMFFpE2uAZDiu3F7UH8b
M4PkfjRWyIzNBhy/k/ioM0Rm/oZvXYxhdcJq7XQMUs/okFvQW22sYhnvA+egClEP
wCu3vb24mfbC0820BQ4WO+7R6os7dYsCdEp2wUwN6b4tu7WhqpBByyAC5PyVB7Q=
=T84b
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--
