Return-Path: <virtio-dev-return-11633-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A49BC6FD1D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:25:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E58D16024D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:25:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DAF9E986412
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:25:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFFCD9863FC; Wed, 15 Mar 2023 15:25:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFEA8986402
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nlHLXK6FOqadA5943BuqQA-1
Date: Wed, 15 Mar 2023 11:25:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20230315152503.GC16636@fedora>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OCgU33HjGcfce1Ev"
Content-Disposition: inline
In-Reply-To: <cover.1678351495.git.viresh.kumar@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping
 quirks

--OCgU33HjGcfce1Ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 02:20:59PM +0530, Viresh Kumar wrote:
> Hello,
>=20
> This patchset tries to update the vhost-user protocol to make it support =
special
> memory mapping required in case of Xen hypervisor.
>=20
> The first patch is mostly cleanup and second one introduces a new xen spe=
cific
> feature.
>=20
> V2->V3:
> - Remove the extra message and instead update the memory regions to carry
>   additional data.
>=20
> - Drop the one region one mmap relationship and allow back-end to map onl=
y parts
>   of a region at once, required for Xen grant mappings.
>=20
> - Additional cleanup patch 1/2.
>=20
> V1->V2:
> - Make the custom mmap feature Xen specific, instead of being generic.
> - Clearly define which memory regions are impacted by this change.
> - Allow VHOST_USER_SET_XEN_MMAP to be called multiple times.
> - Additional Bit(2) property in flags.

Looks good, thanks!

Michael is the maintainer and this patch series will go through his tree.

Stefan

--OCgU33HjGcfce1Ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQR408ACgkQnKSrs4Gr
c8gHnQf/QCidE8WSy1ka0dk9J5LPoXLVAWi2jeZa8dQXbtfkfPLQVuMD94klQw0p
ttlBsAdsyw5lvbC0fdSClu12bCgKzMDVNH/vXFNkSkDWYFX4gIgx0jtDfeYbtW75
YmWbol1fw+CM/RWkUWKm+FsyyGge8iNDf7HfM4BvpzfvdZh+4YSOEj+xBmYaq9VT
NGM5DzCy5N8LpC/oHv3sxnKLXUqML6+rdlHvcAZpDlos4UzcobtHAh7YOhumhBuw
qfCXVKjSQ7hglcFaZRTUtoPOWZR+a3GpRAhS3V6sTryjmal/wuOrKe8SAYXD9ba1
dPqU2PNw8Qq3755oaw/Haw+2cO9JXw==
=BraW
-----END PGP SIGNATURE-----

--OCgU33HjGcfce1Ev--

