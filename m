Return-Path: <virtio-dev-return-11966-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9485FC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:58:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6B70026A53
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:58:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BEC3986418
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:58:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A7069863E4; Tue,  4 Apr 2023 11:58:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28055986595
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 11:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NNQGwWFoNQ6EKH2M7ZC_lg-1
Date: Tue, 4 Apr 2023 07:58:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404115821.GC428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RpeEWffEvCgni4AS"
Content-Disposition: inline
In-Reply-To: <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: [virtio-dev] Re: [PATCH v11 04/10] admin: introduce virtio admin virtqueues

--RpeEWffEvCgni4AS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:23AM -0400, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface used to issue admin comm=
ands.
>=20
> Currently the virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on:
> virtio-net, virtio-scsi, etc all have existing control virtqueues. Howeve=
r,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>=20
> Keeping the device-specific virtqueue separate from the admin virtqueue
> is simpler and has fewer potential problems. I don't think creating
> common infrastructure for device-specific control virtqueues across
> device types worthwhile or within the scope of this patch series.
>=20
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
> The admin virtqueue can be seen as the virtqueue analog to a transport.
> The admin queue thus does nothing device type-specific (net, scsi, etc)
> and instead focuses on transporting the admin commands.
>=20
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ---
> explain ordering of commands as suggested by Stefan
> dropped Max's S.O.B
> reword commit log as suggested by David
> minor wording fixes suggested by David
> ---
>  admin.tex   | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  7 +++--
>  2 files changed, 80 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RpeEWffEvCgni4AS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsEN0ACgkQnKSrs4Gr
c8iqPQgAr1uOSQBVh6UC/6xMmfuhyAL1m7anLBYVpjdweBzEW0NZGbdIa84QsFCF
+jZPZPG0Apfi0zBZ6lWHtNTfAkBE/FnHGtbNOPCmJtoYWrBuxikmNuqiCZPjOEWX
0iQzP24aIWr2cLzviE4ZvRJdqM+785wPRNq25qazhcnhm7hZd2OFX1aQB7Hga93Z
ZqXSgMsG5xleJzDD8xMpfD62h1QunXNNapv6+MaGYw9CWd4mmjy9ea0lrruKr6jd
kuSRRltQKUoEHcSWb/xPAHkuQRfiAUawL3kFo7qmKNaeE24vSNKWT4XM1kwh6I6s
FDcQW//nrdV5sh7knoOwoeiRcJ2+HA==
=2CxR
-----END PGP SIGNATURE-----

--RpeEWffEvCgni4AS--

