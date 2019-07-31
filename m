Return-Path: virtio-dev-return-5908-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C41B985BCA
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 14:57:29 +0000 (UTC)
Date: Wed, 31 Jul 2019 15:57:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190731145723.GA7363@stefanha-x1.localdomain>
References: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
Subject: Re: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: Huang Yang <yang.huang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 09:46:14PM +0800, Huang Yang wrote:
> It is a virtio based RPMB (Replay Protected Memory Block) device.

Please include the request structs.  There is not enough information in
this spec to implement the device.

> +\devicenormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
> +
> +The device provides a simulated RPMB backed by ordinary file or
> +  other medium in host. It SHOULD keep consistent behaviors with

Or it could be a real hardware?  The specification shouldn't discuss
these implementation details except to say that virtio-rpmb could be
backed in a number of ways.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1BrFMACgkQnKSrs4Gr
c8gGogf+JJzCxElhECWbrgUuWKboLXMsYAAmknk4iGN0y8Mi5v5oenm1j3ySThFF
ly8sQFzSg3h6oTWRV/p2e7Q783Vc0tZGiQlagpwH/QnBGvA2AGAxwqlHxKsAGZ/9
bAXC/wmhFIGHIyZotCz6OD4Qnn7qLfRbQu+E3kdDWNs5xRuNhgeHBCSgLHNemZbL
h/hDdONHpQc3IMrwzo/q0oKHdRxQ9thjzVCeTRQ0+KPq7kdA3J4qOCdlp5youZEE
2le8fxKzhlrctPjQocwlx0rV4SIBy/ZGwn4v5pBB+ZakVGmsdWklQikCs87j0oUB
fdq7UHjMTbI9zGZdns7zvRedqxe+3Q==
=2wDr
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
