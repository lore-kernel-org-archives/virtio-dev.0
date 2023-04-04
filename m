Return-Path: <virtio-dev-return-11970-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E53BC761AF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:05:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 684BA2A8F4
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:05:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E451498663F
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 13:05:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 67B869863E5; Tue,  4 Apr 2023 13:05:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E9479863EF
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 13:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: szwzTg0KMbKLOz03zwvJnQ-1
Date: Tue, 4 Apr 2023 09:03:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404130355.GF428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <f254f6eb0b7ade1aa9892b09539711171a41a02b.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iIHrm8idqmEWcmKe"
Content-Disposition: inline
In-Reply-To: <f254f6eb0b7ade1aa9892b09539711171a41a02b.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: [virtio-dev] Re: [PATCH v11 09/10] admin: conformance clauses

--iIHrm8idqmEWcmKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:56AM -0400, Michael S. Tsirkin wrote:
> Add conformance clauses for admin commands and admin virtqueues.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ---
> typo and wording fixes reported by David
> clarify cmd list use can be repeated but not in parallel with other
> commands, and returning same value across uses - comment by Lingshan
> add conformance clauses for new error codes
> ---
>  admin.tex | 227 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 227 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iIHrm8idqmEWcmKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsIDsACgkQnKSrs4Gr
c8jVGwf+OICyyUQg1GgLhVHU+XYxFc/Zx5aNqqeapgNbbZdgbMtBHDjyJUrjLBUc
D/J0f5ybQkYrVjnT29DOulSj1CRodLX8Kgyeb4DOf0XoyyrpycWJIyT9HJDUSny+
tkG/WKISYlZkalbLV+9olUSj60XFau3slbv/8PUu0mXUF93qtFb8jcUV3P0Lq0Nu
OQQzb/sKzTIWsBT3w4T6xAqM8gA7ijxytJiKxyvErXVb/c79KN3jphDBEIezgLIu
9j5karu0bp5ys920QdBtbj0Hx4lll6W1y0+yCjb3JFOnFTY9yBwZMtyI2YSYobV0
GDnIXFg/WR/m+jZp6kwXBsrMAywIjQ==
=E4EQ
-----END PGP SIGNATURE-----

--iIHrm8idqmEWcmKe--

