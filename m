Return-Path: virtio-return-3274-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 16:07:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190311160759.GB4315@stefanha-x1.localdomain>
References: <20190311132045.25232-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20190311132045.25232-1-mst@redhat.com>
Subject: Re: [virtio] [PATCH] conformance: clarify
 transitional/non-transitional
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 09:20:49AM -0400, Michael S. Tsirkin wrote:
> Clarify that:
> - non-transitional just satisfy 3 main clauses
> - transitional also has a legacy interface:
>   however note that it's not an optional component
>   *for transitional devices* so MAY is inappropriate
> - legacy device descriptions are non-normative.
>   In fact virtio 0.9 is non-normative as a whole
>   and always was by design: it was early days and
>   spec evolved to document bugs in implementations.
>=20
> VIRTIO-167
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Aside from the \end{note} issue Cornelia mentioned:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJchoffAAoJEJykq7OBq3PI4N4H/A63ZE7+YNkPpO5VZnB+8NmV
K5RokGp0xk5B0ou9gStsR6jeJpWo4NdTDknCA8CqTywA41q3bJvgdwz+KFuoqiPF
wnh5guMa2oI6Om+ZeYA7wMmx+p7To9Fk3cM6+bf0SDPa9JNRaj676O9wR7/0Lcfp
IQqwjD9QdFL/KxZ/+b0KVinrPPqomT56VSLJeoZw3ZMHo+vhvS8QJLxwdyx7A0+4
kIOmcd0TdWhNfD8gi9PhDR1Tg8qLKK2q0FN4NrHnJl+T7pqVqdSrJa1npEASREd/
h0ycD8ezF3g9OAIMJoWJKuaWU6ynDxCRMXiGkt2sWGr2R90SbjeaJbWu2nXmU/c=
=f+NA
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
