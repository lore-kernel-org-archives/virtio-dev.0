Return-Path: <virtio-dev-return-12198-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D009C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:51:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C49A2A8DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:51:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 840689865F5
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:51:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6B8EE9865B2; Wed, 12 Apr 2023 14:51:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58F569865B5
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 14:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ILGGb8RUN3ifo31zAeBqmA-1
Date: Wed, 12 Apr 2023 10:51:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230412145140.GC2790100@fedora>
References: <20230411201647.753327-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RzhsDMbWlcRYn4sb"
Content-Disposition: inline
In-Reply-To: <20230411201647.753327-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] transport-mmio: Replace virtual queue
 with virtqueue

--RzhsDMbWlcRYn4sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 11:16:47PM +0300, Parav Pandit wrote:
> Basic facilities define the virtqueue construct for device <-> driver
> communication.
>=20
> PCI transport and individual devices description also refers to it as
> virtqueue.
>=20
> MMIO refers to it as 'virtual queue'.
>=20
> Align MMIO transport description to call such object a virtqueue.
>=20
> This patch is on top of [1].
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202304/msg00253.html
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-mmio.tex | 50 +++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RzhsDMbWlcRYn4sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQ2xXsACgkQnKSrs4Gr
c8j+Agf/fDaU1NW2rEUCJllQ5cxxi6aaCcCC/RyebVGdkrQShZ8DnkI9ffw+TaMl
vA59+w0tOQ6/bBmmH56vGu499lVpDqgAE+Tjq1XTEBR7i0ZDw1RhbaoKVTAEbLkp
FlRk2Ln0m9fQa9HplWwBuImZKlwSBXTyYQdKu2ZQVLsTZwyOawDA4irxMEdK40+z
32AP8JvD1nzVbg2XOZdrI96euBbn/O9vbXQnkiwJqs8nqLGe1GflQBuOJPs73dMi
bOkwJZ1UIMhCNznrIMRchaL4g9sL9BsJ+vM+2YVFLqTP4iutGmDO3bYhG+X8AsFO
1ItARiQ0I+pcPHLmTLPCxovUEWzGqQ==
=EluH
-----END PGP SIGNATURE-----

--RzhsDMbWlcRYn4sb--

