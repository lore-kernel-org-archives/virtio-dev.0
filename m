Return-Path: virtio-dev-return-4927-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEAE3985B7B
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Oct 2018 11:07:34 +0000 (UTC)
Date: Tue, 30 Oct 2018 11:07:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181030110730.GD3743@stefanha-x1.localdomain>
References: <1540891712-10001-1-git-send-email-danielm@mellanox.com>
 <1540891712-10001-2-git-send-email-danielm@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <1540891712-10001-2-git-send-email-danielm@mellanox.com>
Subject: Re: [virtio-dev] [PATCH 1/2] packed-ring/split-ring/content: fixed
 misc typos
To: Daniel Marcovitch <danielm@mellanox.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2018 at 11:28:31AM +0200, Daniel Marcovitch wrote:
>  \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
> -Drivers MUST NOT add a descriptor chain over than $2^{32}$ bytes long in total;
> +Drivers MUST NOT add a descriptor chain over $2^{32}$ bytes long in total;
>  this implies that loops in the descriptor chain are forbidden!

s/long//

Or, even better:

descriptor chain longer than $2^{32}$ bytes in total;

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2DtyAAoJEJykq7OBq3PIzzUH/2JSJupSzAuWG1LB0yJvKfGM
Z9WtYetSqr0S04wNA3ZPlBcxWKqrgRn7UHa6H9FbMvGBNHvEL29N1DHhbCcWLjug
TYjyRmovNqsFp9NbzlZ4Xr8fGF5mX1o2EkXzkYAwe8qNgRCK47ENhMbRAIsD+tT2
bkpaG29jvQfVu/DAVARNhuW2Yf0spg1z/yMJFoL684hZyKbRsI+pRCUdfz7XRN4I
y2OegVojpBkPMjr/nH/0eM+KZGA0stPMytbgym++TRbpHiZV99pbihTBWujoU1Cv
eXfyzrxHIw3pHszkAydw08RrKIE9v/z9q1er4wG99Nv/C7V86YQGX0syPuttMA4=
=XheJ
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
