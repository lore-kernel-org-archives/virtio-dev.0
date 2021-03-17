Return-Path: virtio-return-3535-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 17 Mar 2021 15:52:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YFIl24pVVmWACUzF@stefanha-x1.localdomain>
References: <20210316211311.154117-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210316211311.154117-1-mst@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH] introduction: document #define syntax
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/EGSU9qtxQQPW7AI"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--/EGSU9qtxQQPW7AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2021 at 05:13:17PM -0400, Michael S. Tsirkin wrote:
> We use the C #define syntax to refer to numeric values.
> Let's document that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  introduction.tex | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/introduction.tex b/introduction.tex
> index cc38e29..4febed2 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -210,6 +210,27 @@ \section{Structure Specifications}
>  \begin{lstlisting}
>  CPU_TO_BE16(B << 15 | A)
>  \end{lstlisting}
> +\section{Constant Specifications}
> +
> +In many cases, numberic values used in the interface between the device
> +and the driver are documented using the C #define and /* */
> +comment syntax. Multiple related values are grouped together with
> +a common name as a prefix, using _ as a separator.
> +Using _XXX as a suffix refers to all values in a group.

This sentence confused me. It's not talking about C #define syntax. It's
a convention for referring to the #defines in the spec text.

This could be clarified:

  Multiple constants with the same prefix are referred to in the text
  using a _XXX a suffix as a shorthand for all constants that share the
  prefix.

I suggest moving this down to the bottom where the VIRTIO_VALUE_XXX
example is given.

--/EGSU9qtxQQPW7AI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBSJdsACgkQnKSrs4Gr
c8gS8wgAyNbVicMYXSse40XH79d37mJwMq3IX2Q8Rc2X8EzyOdSkBlhUrWJW22I4
KOi6XyEw1pN6vSEiNVMz4UsDdKydFy/oPuXMEZgJlKlcr1XBXUIE9MGn710od+BK
r8piMnLxwQ2xnL1kyBuYWl73d4XnTPH4Ol4GZyufTDuZTm0Uwhm00zc7Bzrb0u3P
qS1YR04iBrw2GCJzOLIDEOd5uXySri5+XX3krsmM4U8fgf57bbBbXsU3QIgnElV/
IeREXRXA6pUutcDEi7Nd5IIZd3NTaZeUi0wXDfdNjtmOWQ7QiT/GLTIh7QX8q4C9
Gs4kftkCOT+CUjN21rKFXmLGk/vx3Q==
=6Xgv
-----END PGP SIGNATURE-----

--/EGSU9qtxQQPW7AI--

