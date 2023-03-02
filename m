Return-Path: <virtio-dev-return-11398-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F169C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:12:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 94DFD2ACFF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:12:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 785EF9866D5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:12:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6266A984091; Thu,  2 Mar 2023 21:12:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D9E19866AC
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 21:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cLNx4jDFMW2C4w0m9WPWIg-1
Date: Thu, 2 Mar 2023 16:12:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302211219.GI2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <45e31c1bfd92e91bb721e2c3fbb15c848c3c49c5.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+cOJC+N7qw6eanwa"
Content-Disposition: inline
In-Reply-To: <45e31c1bfd92e91bb721e2c3fbb15c848c3c49c5.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [PATCH v10 10/10] ccw: document more reserved features

--+cOJC+N7qw6eanwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:30AM -0500, Michael S. Tsirkin wrote:
> vq reset and shared memory are unsupported, too.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+cOJC+N7qw6eanwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBETMACgkQnKSrs4Gr
c8hi6Qf6AxwE2RDb6okUOfO7AOxmE/bMVIbW+fk5cKRD9KMENNWfX9uJ7O4fpVYd
wrDNLAHf87OLhgeFmXcTRo9I9ek235NvgQs8qKYozh7rjDoUrzMjyDeaUNxAkClg
LeWEOdBR6voLD+bLr9gnw/VS9z32GfRe1lmBDOyIa6VwNXenjiXQDXWwTpSXXHjb
x7RSz9BPYtMX9hZ5qP4zw6AGY/Ch3PY9cgrpsQc+KH6eECk9judMScLX9rQyI2QH
JAmMdO3zX7jGihu/bYdRjUGiLjUSCHDxMHnRDFMwiPoSVH4DwK190DYc3ENktNjN
Syg00YRvyPyVDJ9d4TQE6vr3Whb5zQ==
=UWjr
-----END PGP SIGNATURE-----

--+cOJC+N7qw6eanwa--

