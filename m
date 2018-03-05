Return-Path: virtio-dev-return-3415-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D16145818F63
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Mar 2018 06:09:02 -0800 (PST)
Date: Mon, 5 Mar 2018 14:08:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305140859.GL7910@stefanha-x1.localdomain>
References: <7849539ddc252748908b3ff62ca6539b6dea73b0.1519303843.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline
In-Reply-To: <7849539ddc252748908b3ff62ca6539b6dea73b0.1519303843.git.tgolembi@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2] content: document balloon memory
 statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 01:50:52PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Linux kernel provides some balloon memory statistics that were not
> included in the specs. Include them to avoid any ID clashes in the
> future.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  content.tex | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanU97AAoJEJykq7OBq3PIJ+cIAIVqo4OBlQA/XAw0xVQEghDF
7HSy71GHxuTEccmil5Y6P7Df+423uA18SCMJU2XwrG6E8cjlpwJi2SaQUALued6l
rgEBl7Pcqg1CD2CkuW+E2uHE7ZPconapv3GfQJHduxgCFEl1hl/6JvJzdCILpil/
AL4ZDIMCzz4/mGpc2CeB7I1tl63EdMpMG/RspVWs4rEJwSMBzk1GqsG+NpFJ/n1r
1doDBvOmWWclOZNNxIY3/za5QxTSomJPQUe2DJWV1OtEj7HjwiGJXgUiHC82XAek
/Yi5mvHXKEc8s0APjHEdOzn8vsejyX8O8e0P8n8FQWec3bmIxEybIlN/7sAM+dg=
=zP+8
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
