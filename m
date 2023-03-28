Return-Path: <virtio-dev-return-11818-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD16CC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 290641922E6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FF259863E6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 14AD698638E; Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05AD99863BF
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RPfPPF6wPLmSOhF3zAx9_w-1
Date: Tue, 28 Mar 2023 10:51:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>,
	virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org
Message-ID: <20230328145145.GB1623159@fedora>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W+f9eOPTmKJwgc15"
Content-Disposition: inline
In-Reply-To: <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: Re: [virtio-dev] [PATCH 1/2] virtio-blk: migrate to the latest
 patchset version

--W+f9eOPTmKJwgc15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 10:29:27PM -0400, Dmitry Fomichev wrote:
> The merged patch series to support zoned block devices in virtio-blk
> is not the most up to date version. The merged patch can be found at
>=20
> https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomich=
ev@wdc.com/
>=20
> , but the latest and reviewed version is
>=20
> https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomic=
hev@wdc.com/
>=20
> The differences between the two are mostly cleanups, but there is one
> change that is very important in terms of compatibility with the
> approved virtio-zbd specification.
>=20
> Before it was approved, the OASIS virtio spec had a change in
> VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
> current virtio-blk driver code. In the running code, the status is
> the first byte of the in-header that is followed by some pad bytes
> and the u64 that carries the sector at which the data has been written
> to the zone back to the driver, aka the append sector.
>=20
> This layout turned out to be problematic for implementing in QEMU and
> the request status byte has been eventually made the last byte of the
> in-header. The current code doesn't expect that and this causes the
> append sector value always come as zero to the block layer. This needs
> to be fixed ASAP.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c      | 238 +++++++++++++++++++++-----------
>  include/uapi/linux/virtio_blk.h |  18 +--
>  2 files changed, 165 insertions(+), 91 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W+f9eOPTmKJwgc15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQi/wEACgkQnKSrs4Gr
c8imZggAhJA5G85LLc28etjnXDmkF7WtvrUc4MoHpgxVUys1SEaxhlmAsh+EIrd5
oSIHcBTkAv6xkMA44ogTyq+Ewl0J4e8Ma46s+HE9Pn0XXuHpOZKeVxJxLvyYUkkS
9RbxlExUCi68vdHy4JKqS8u+iisGRILKXCu06B5Ce3wD1o07kuvYlkZcOKyaJMUs
1Z1ifmiTphIsUT7KHMJ13GsR1QhgBr0+1LH2uCTJu8faD3UGGTJHtH9r+wmFVKbt
AKQ7DsQuhIUfreukTh4AOK1LOAjTgtNyf9mhkQl4js1KkKKoiedxmGqVV9RlHbZw
WFTFCtcjbgVhBQi4SvLAlAgy0yC++g==
=KqDZ
-----END PGP SIGNATURE-----

--W+f9eOPTmKJwgc15--

