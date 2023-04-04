Return-Path: <virtio-dev-return-11964-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41281C761AF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:38:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9840B2AC7A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:38:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86CEC986400
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 11:38:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 754879863EF; Tue,  4 Apr 2023 11:38:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F7719863ED
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 11:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dStyea-MN1ubmLasenPV1w-1
Date: Tue, 4 Apr 2023 07:38:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404113816.GA428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ObMZ9YbhLenZBb8P"
Content-Disposition: inline
In-Reply-To: <f83a6a225a28909eea927575b6783c0fe238fdbd.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Subject: [virtio-dev] Re: [PATCH v11 02/10] admin: introduce device group and related
 concepts

--ObMZ9YbhLenZBb8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:09AM -0400, Michael S. Tsirkin wrote:
> Each device group has a type. For now, define one initial group type:
>=20
> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> PCI SR-IOV physical function (PF). This group may contain zero or more
> virtio devices according to NumVFs configured.
>=20
> Each device within a group has a unique identifier. This identifier
> is the group member identifier.
>=20
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer
> to a new device type or a new transport type.
>=20
> However, I expect that we will add more features in the near future. To
> facilitate this as much as possible of the text is located in the new
> admin chapter.
>=20
> I did my best to minimize transport-specific text.
>=20
> There's a bit of duplication with 0x1 repeated twice and
> no special section for group type identifiers.
> I think it's ok to defer adding these until we have more group
> types.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> changes in v11:
> 	dropped Max's S.O.B.
> 	dropped an unmatched ) as reported by Parav
> 	document that member id is 1 to numvfs
> 	document that vf enable must be set (will also be reflected in
> 		the conformance section)
> 	document that we deferred generalizing text as requested by Parav -
> 	I think we can do it later
> 	minor wording fixes to address comments by David
> 	add concepts of owner and member driver. unused currently
> 	but will come in handy later, as suggested by Stefan
> ---
>  admin.tex   | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  2 ++
>  2 files changed, 65 insertions(+)
>  create mode 100644 admin.tex

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ObMZ9YbhLenZBb8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsDCgACgkQnKSrs4Gr
c8g4Ygf/bvHqkS7mavN/XcYt93pnkjWPQHozb9AfrNob7Ya24RSO/zCbVZcLqJTW
D1kIT6YfkY1U2E7SNKY8kIX+VqwGsDHb6/lSpas8LoiY2K13v+tOFBKFAn+5rkQG
LAvRahlf0PKPyFRH1mJUwk/rZkCBzJD5ZlHA8kMYM9sn4mWOlhb1t3JLTF/RHXV3
Dv0ELZ9Na53dVc29+ArOs6pD/CQuNqy8UPmU5CbjZ7lzOA9m0jYMTt85IIEIRFIa
6mHa1ewnqddA6eP6MPbrWrJIw8l1vLfDm+ac+7JTDqMfuMgBS558ht1Q1Az0VO4t
s0OHA5P/mUgpJR8Y6iGEirUOKZ9V6w==
=7QkZ
-----END PGP SIGNATURE-----

--ObMZ9YbhLenZBb8P--

