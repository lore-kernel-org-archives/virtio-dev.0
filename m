Return-Path: virtio-dev-return-5860-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBE77985C86
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jul 2019 10:04:31 +0000 (UTC)
Date: Wed, 17 Jul 2019 11:04:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190717100426.GC7341@stefanha-x1.localdomain>
References: <20190611065304.16880-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20190611065304.16880-1-tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH] content: fix typo in feature bit name
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 02:53:04PM +0800, Tiwei Bie wrote:
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  content.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/content.tex b/content.tex
> index 193b6e1..a143d91 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3523,7 +3523,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
> =20
>  \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / VLAN Filtering}
> =20
> -If the driver negotiates the VIRTION_NET_F_CTRL_VLAN feature, it
> +If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
>  can control a VLAN filter table in the device.
> =20
>  \begin{lstlisting}
> --=20
> 2.17.1

I have opened a GitHub Issue so this can be voted on and merged:
https://github.com/oasis-tcs/virtio-spec/issues/46

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0u8qoACgkQnKSrs4Gr
c8jhjwf9HaPqQH+YTJdLI44vdW198YMj93gyiOxUaYcwFxohFVV45AAi3pyJXqa5
Bl2C07/BVchY56uqDmFxmtFoZiDEzMLV1nM3VrkhpT4HPk3+ewJc2yK2ULiIh44c
eo9c+4MRVWAKEw/8RbDv+5/jqGU3+J+3J/Apppk0ugykbIkeEF/zxb4gbL5NXq5g
N2kJZR2qt0ayAVFNZJR0hIY5YA0pLZBS++xaI+LBD42NTkhWbubsDhPSbG/+DrlE
8whr2K4x/VCwubylBWkZ/YRtWKRzbUDnbQEOH8SowRHixGP604fmKiKR2f7DH8Xu
pg4RFn1Dbp93o62zxuQATiaAsGnSFQ==
=/4la
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
