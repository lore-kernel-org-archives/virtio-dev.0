Return-Path: <virtio-dev-return-11390-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF19AC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 19:40:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E08C22B04E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 19:40:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4D799866AB
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 19:40:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AAE7B9866A8; Thu,  2 Mar 2023 19:40:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 984F09866A9
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 19:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KmELN9IWMaq4RQ-GiwmKGQ-1
Date: Thu, 2 Mar 2023 14:40:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302194033.GA2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sStb6q//4kloA3dD"
Content-Disposition: inline
In-Reply-To: <2d232eba17d75c5dad2db17dc297f34a3612c33e.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: [virtio-dev] Re: [virtio] [PATCH v10 02/10] admin: introduce device group and
 related concepts

--sStb6q//4kloA3dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2023 at 08:04:57AM -0500, Michael S. Tsirkin wrote:
> +The following group types, and their identifiers, are currently specified):

spurious ')'

--sStb6q//4kloA3dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQA+7AACgkQnKSrs4Gr
c8hZ2ggAo3qCbLmPXbLYXEt2FNffTtPy/WR4jCAcq73xGJPLPKptFYy9VZj64ZE3
zkfMjHc/wO+xNxsKfY0QJ6dYKSebtr5Sko4HDb8bcJjmwpE1iUQB2+tXFX89zFEq
j/dA4w4mHe3oSsXthz1Bb6ezIfhVuopAxLEX0npien2ajiW5ekJ5XWDTAIsAmi8m
1D/N2hQo5+i8N+KiNUTJknEsoyhIW7yvTul2TdD0aEJ8ZlbNqosMPPhVT6f25CVw
N3eGPHOt0wk4QMsmgMnHoRx4M0mb2+dnlLxHXOQGDscZiBmLwmOTk78QKxt2HklS
0BPDm2sUo90X7CIrMCVrK19A4CWDjg==
=eEDG
-----END PGP SIGNATURE-----

--sStb6q//4kloA3dD--

