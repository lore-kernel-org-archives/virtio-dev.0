Return-Path: virtio-return-3381-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 23 Jul 2019 14:16:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190723131615.GE5445@stefanha-x1.localdomain>
References: <20190722203854.16494-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20190722203854.16494-1-mst@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH] README.md: document github use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 04:39:39PM -0400, Michael S. Tsirkin wrote:
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  README.md | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/README.md b/README.md
> index 3de0c1e..0aceb75 100644
> --- a/README.md
> +++ b/README.md
> @@ -69,6 +69,34 @@ in <A
>  HREF=3D"https://github.com/oasis-tcs/virtio-admin">https://github.com/oa=
sis-tcs/virtio-admin</A>.
> =20
>  </div>
> +<h4>Use of github issues</h4>
> +Note: according to the virtio TC rules, all official TC communication
> +is taking on one of the TC mailing lists.

s/is taking on/takes place on/

> +In particular, all comments must be provided on
> +one of the TC mailing lists. Accordingly, the TC will not respond
> +to comments provided in github issues: github issues are
> +used solely to track integration of comments into the
> +specification.<p>

This sense can be made clearer:

  "github issues are used solely to track integration of comments from
  the TC mailing lists into the specification"

> +To request a TC vote on resolving a specific comment:
> +<ol>
> +<li>Create a github issue, or edit an existing issue, with
> +a short summary of the comment.
> +The issue MUST specify
> +the link to the latest proposal in the TC mailing list
> +archives. <em>Note:</em> the link MUST be in the issue description itsel=
f -
> +<em>not</em> in the comments.</li>

I don't understand what this note means.

> +<li>Reply by email to the comment email, requesting that the TC vote
> +on resolving the issue.
> +The mail requesting the vote should include the following, on a line by =
itself:<br>
> +<code>
> +Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN
> +</code>
> +(NNN is the issue number)</li>
> +<li>Please make sure to allow time after a comment resolving

Clarification:

  "Please make sure to allow time for review after a comment resolving
  ..."

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03CJ8ACgkQnKSrs4Gr
c8inlQf/bE8UUFAWtXZPFqPIGnjVfP3s0WzV724ogLRMQ13BOiRdSLASAJul5phw
H2fjVadmIB7lZZajbXEOl30lZb91NpRXx8d4ql0mpKhRVPNSRkNYPZQTvmKbFH3g
Yrt2vjrFDz+7pYvl6A7jKwf0rgblc25XE/TQyvSEBi/kdeGY7rFaBGfuxWu3S+JF
4cdNtMAVK2ZTEWyFqHLJApsjYGAMnfLMS2PTBr90elSrqa7fr+Lm1tuTpaB7g4cp
imU7V6WWoU9x5V5OWXKCR9WA5h2/5YZuFyxn/i6YbMuufTr3Vfpbrx1/vqwZyvIT
SZbEq45QeZBWY1IdZMbNgbgaKXNf3A==
=t6rO
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
