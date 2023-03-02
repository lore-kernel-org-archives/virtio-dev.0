Return-Path: <virtio-dev-return-11395-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD2DC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 651D441A15
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60D8D98678B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52AD7984091; Thu,  2 Mar 2023 20:52:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 425BE9866AC
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4igjLAyJMr6QPoeLVSstqQ-1
Date: Thu, 2 Mar 2023 15:52:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302205223.GF2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sRX9p0IC0TB9HZWK"
Content-Disposition: inline
In-Reply-To: <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved

--sRX9p0IC0TB9HZWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:14AM -0500, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sRX9p0IC0TB9HZWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBDIcACgkQnKSrs4Gr
c8gXDgf/Qh6m67zYrmGSF+84oVuSMkKBUcpG9egp8rjkkesw2eJiz4gVrv8xCY0A
jxY9pP/qv4tVXITj54bXRi+syMlZYBSzVy8IOkPHqP0qJ0tWQ9b6PrLHB3Z46Hbd
0n49xl7YB6FrSsKu+5xXxD2oALFx5V750L9vIB/ToIE+Nv49sxm4PG0+upxNZx8z
D7d2Y203XROQH/e6Qv4yiI7EVh4qcluZnGLwh3O5v7t/wgo3BoToDCqAhPQH141J
5N93nGT9Fs4sYSgxVPnoqKU7FqdBnYNqUBvvgQxxppcqWFiuvqoEhEiJSHn2r31s
2Ud5HhP57oQ3WBKsWMf7/uT8AS0MEg==
=4Oq4
-----END PGP SIGNATURE-----

--sRX9p0IC0TB9HZWK--

