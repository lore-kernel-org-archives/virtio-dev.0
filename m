Return-Path: virtio-dev-return-4058-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 690BD5819120
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 May 2018 01:18:21 -0700 (PDT)
Date: Thu, 10 May 2018 09:18:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510081819.GB1296@stefanha-x1.localdomain>
References: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
 <1525895585-79023-2-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <1525895585-79023-2-git-send-email-thomas.tai@oracle.com>
Subject: Re: [virtio-dev] [PATCH V2 1/1] virtio-balloon: fix internal stat
 name array to match Linux kernel
To: Thomas Tai <thomas.tai@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, rob.gardner@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 03:53:05PM -0400, Thomas Tai wrote:
> The Linux kernel commit b40000325044 ("virtio_balloon: add array
> of stat names") defines an array of stat name strings for consumers
> of the virtio interface to use via the virtio_balloon.h header
> file, rather than requiring each consumer to define its own. But at
> present, the stat names defined in this array by the Linux kernel
> do not match up with those defined internally by QEMU.
>=20
> This patch fixes this inconsistency by importing the header file
> from linux and use the new macro to construct the balloon_stat_names
> array.
>=20
> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> Cc: Rob Gardner <rob.gardner@oracle.com>
> ---
>  docs/virtio-balloon-stats.txt                   |  2 ++
>  hw/virtio/virtio-balloon.c                      | 13 ++-----------
>  include/standard-headers/linux/virtio_balloon.h | 19 ++++++++++++++++++-
>  3 files changed, 22 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9ABLAAoJEJykq7OBq3PIgiYIAJUyBq7S6cvlpvA8DECPnq7Z
HZLlP83Reo6gUcoMMcndPRtW0BFxCBqjM9Fw0czPpYanzxNgtxU63EUTg+k8yE4d
wd4QSt+Zi4Picq0NX1dH1jEAi4o0uuMxBGHwNWYfpOBrFUGTawzY1cTZtaoRlcFS
HCmDIHlJ88fQV/hZWtazTh92q+RHWFUmlDjHUd2nlYBJFvazz3pF77JSQkyVBsZm
lG9BIBIGD7DaIju+8NbLwb/Qir7eyHgLRh9PlMqAMKO5QyZEDeq9w3id2i0095Wd
EnylN4OnapNJYFOkJJpox0Ywx48nsADgNDgcla7MnJzcXPJOMWp+f91nYc7i8wY=
=x954
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
