Return-Path: <virtio-dev-return-11396-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A95FC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:53:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B03842A83F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:53:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A670498678A
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:53:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98E339866AC; Thu,  2 Mar 2023 20:53:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 842579866D7
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yihXnewuOxKnlZvgrcyLQg-1
Date: Thu, 2 Mar 2023 15:53:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302205325.GG2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <cd10fcfd7ab071982b6cd372fb3db29ef4526a02.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vK1qxoTQOmCwutey"
Content-Disposition: inline
In-Reply-To: <cd10fcfd7ab071982b6cd372fb3db29ef4526a02.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [PATCH v10 07/10] ccw: document ADMIN_VQ as reserved

--vK1qxoTQOmCwutey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:18AM -0500, Michael S. Tsirkin wrote:
> Adding relevant registers needs more work and it's not
> clear what the use-case will be as currently only
> the PCI transport is supported. But let's keep the
> door open on this.
> We already say it's reserved in a central place, but it
> does not hurt to remind implementers to mask it.
>=20
> Note: there are more features to add to this list.
> Will be done later with a patch on top.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vK1qxoTQOmCwutey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBDMUACgkQnKSrs4Gr
c8jY+ggAkYfZ3wGUNbAt0EcNh+um5o33n0Z3/xdbVnyj6aqSbc7JSMLZ0z83wbh1
HoUngJOa7UzjqcIbG6au0FYilCvYp5fvqOE6g3lBUq9SvznZ0oveFhrdKQcQ6Pvf
HSbZdP/68y534D0EjHIpREsg+MBSfKQB6L8Gr5eZLbf1+W0z19Wa9n1crZFVdNmt
PmMmRSFaJAnx2eX1RdZAl38eRpNbXdLiUOT01sHKN+CAjaerUy1Wtim5/zUES+aa
Ph4w2gm+z5emwXLqPN7UqGgcz0b0VmX6VXOMM57tdUz9qViLt+uT3xcZIN8mSQiE
g6WNp8M+ehi2BG/kW9isIn3nzsviCg==
=jaVB
-----END PGP SIGNATURE-----

--vK1qxoTQOmCwutey--

