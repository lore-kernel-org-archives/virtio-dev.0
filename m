Return-Path: virtio-dev-return-5678-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96978985C8A
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 09:02:06 +0000 (UTC)
Date: Tue, 23 Apr 2019 10:01:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190423090158.GB32465@stefanha-x1.localdomain>
References: <20190422052215.4471-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20190422052215.4471-1-pagupta@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3] content: reserve device ID for virtio-pmem devices
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 10:52:15AM +0530, Pankaj Gupta wrote:
> We need a device ID for virtio-pmem devices. As 25 is requested by
> audio device and 26 is requested by virtio-fs, so requesting
> next available(27). Also, updated the previously requested github
> issue[1] for voting.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/38
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
> v3:
> Added fixes tag and reviewed by.
> v2:
>  Use device ID 27
> =20
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvtSGAAoJEJykq7OBq3PIr9EH/2JT0Yi9ZUczapqROSXh4Ghz
lfOFzfo1O9VukZZf2bpJ4P4r+zq5TrP82QUKrzmsf7SSVVm6vt4TvUTtk7+iDJQu
tFQKciiVSK6oaVktGzQd7Tmi10u4U89e2ab16c4L90bOwckrOpn1snc06ltx5D/I
LMurRSvrSXVk/h4a/UK0Gonz2Q0CZjiW61UdUTRG1K7gn8Lq1VLn7W+Lm2lGPA0Z
44pTGDf4/UMjxUa1z31xGORwjphtByJJr7J18aNOWm+soD2J+B7bFvP0J7c7p6ly
FOyoZ2yN3SQOb052BOGsZY0ISUQhjTX0xF5UTp/5aSchlaCF8Ibhr36s4e3Gewk=
=J5hO
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
