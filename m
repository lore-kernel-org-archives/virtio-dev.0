Return-Path: virtio-return-2885-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 13:18:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212131844.GB4913@stefanha-x1.localdomain>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-9-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <1516665617-30748-9-git-send-email-mst@redhat.com>
Subject: Re: [virtio] [PATCH v7 09/11] content: in-order buffer use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 02:01:08AM +0200, Michael S. Tsirkin wrote:
> Using descriptors in-order is sometimes benefitial.  Add an option for
> that - per-format detail allowing more optimizations will be added by
> follow-up patches.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagZQ0AAoJEJykq7OBq3PIlVAH/jktpLzlR+Eyt4/aMlpCJ1hR
oY9xotX9Hmyd9SevkzrEzQj0tCHAm9fAsWYc1lSpouESI7g/LM6pn0w65iX3qNHl
mmtggWZ2Jkbq6kryWlW+E9iIC9v7DmQzp2HxfEmtcchjchVjhi0SL6BAueaTcbr7
qLCJjwZqLax8W6O4iNiGpplLKRQknC9yDjx2ftmw2MgybQL5lmfefLRLOpTiYaE7
4paJTybjpb5TstqGh2PGj1leJ0H0TeyHt7CPmOJhKTjkAZsxs2BuhKrJmqcP+HX2
yqZl2TdZyxMxRPeICiRC+n6AkPivyf2lxXj/ADxTr7ATGkCAIGaQsigbc5PhmiI=
=9YjW
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
