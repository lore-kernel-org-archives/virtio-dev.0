Return-Path: <virtio-dev-return-13519-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED6C001E0
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F3AE2CAD7
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42AC09863A4
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28DE7983F78; Mon, 14 Aug 2023 16:28:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1879D98633D
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2023 16:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Y0kAC3XkPWm_fd_LZrmAPQ-1
Date: Mon, 14 Aug 2023 10:20:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230814142050.GC3146793@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FhdJ9GgMHCQ7UwLN"
Content-Disposition: inline
In-Reply-To: <20230814192904.30062-1-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 0/5] virtio: introduce SUSPEND bit
 and vq state

--FhdJ9GgMHCQ7UwLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 03:28:59AM +0800, Zhu Lingshan wrote:
> This seires introduces
> 1)a new SUSPEND bit in the device status
> Which is used to suspend the device, so that the device states
> and virtqueue states are stablized.

Hanna, you might be interested in this because it has overlap with your
vhost-user device state migration work.

Stefan

>=20
> 2)virtqueue state and accessors, to get and set last_avail_idx
> and last_used_idx of virtqueues.
>=20
> The main usecase of these new facilities is Live Migration.
>=20
> Furture work: dirty page tracking and in-flight descriptors.
>=20
> This is RFC, this series carries on Jason and Eugenio's pervious work.
>=20
> Any comments are welcome.
>=20
> Zhu Lingshan (5):
>   virtio: introduce SUSPEND bit in device status
>   virtio: introduce vq state as basic facility
>   virtio: The actions by the device upon SUSPEND
>   virtqueue: constraints for virtqueue state
>   virtio-pci: implement VIRTIO_F_QUEUE_STATE
>=20
>  content.tex       | 120 ++++++++++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex |  15 ++++++
>  2 files changed, 135 insertions(+)
>=20
> --=20
> 2.35.3
>=20
>=20
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>=20

--FhdJ9GgMHCQ7UwLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaOEIACgkQnKSrs4Gr
c8iQsAf9GCEd+hv/6NOnRYZgXV9USQaGE7iB8pW9BTtEgpxuT98LtnfErAXQEa+q
/m+F74RBbOyUulM7N0VJhA3L3cu+2/L5fguSf+J2hBOgXzlRYoIH9P014sW1I75Z
Az8WRfQjZwG7pgUbxaSvUpCSleVNW3czaO7NskGMX7sjsBhufyoZm7ZbXn2Z5Pmy
CUsvPabEsNrAjQQxUTztaF+yyml3oV/5HYNuikvquyFn/y9su0YS3Nt3KC9mdEKU
Ntv2gzONe0T3zkmP69aqDobjcbmHK9rrIZwO5JfxvZ5T5UY90cZbDIAOl5/nuzSh
5TBu9haeytlYXn6iCK5LpL5niN9Jtg==
=OFPe
-----END PGP SIGNATURE-----

--FhdJ9GgMHCQ7UwLN--

