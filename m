Return-Path: <virtio-dev-return-11817-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C4FC76196
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 59229F92C8
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42EBA9863DE
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3033E98638E; Tue, 28 Mar 2023 14:51:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FA709863BF
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 14:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Y6KFKFGlMjesR4n930Bj6A-1
Date: Tue, 28 Mar 2023 10:51:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>,
	virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org
Message-ID: <20230328145112.GA1623159@fedora>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UeJ1ldfXW4hAubI9"
Content-Disposition: inline
In-Reply-To: <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: Re: [virtio-dev] [PATCH 2/2] virtio-blk: fix ZBD probe in kernels
 without ZBD support

--UeJ1ldfXW4hAubI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 10:29:28PM -0400, Dmitry Fomichev wrote:
> When the kernel is built without support for zoned block devices,
> virtio-blk probe needs to error out any host-managed device scans
> to prevent such devices from appearing in the system as non-zoned.
> The current virtio-blk code simply bypasses all ZBD checks if
> CONFIG_BLK_DEV_ZONED is not defined and this leads to host-managed
> block devices being presented as non-zoned in the OS. This is one of
> the main problems this patch series is aimed to fix.
>=20
> In this patch, make VIRTIO_BLK_F_ZONED feature defined even when
> CONFIG_BLK_DEV_ZONED is not. This change makes the code compliant with
> the voted revision of virtio-blk ZBD spec. Modify the probe code to
> look at the situation when VIRTIO_BLK_F_ZONED is negotiated in a kernel
> that is built without ZBD support. In this case, the code checks
> the zoned model of the device and fails the probe is the device
> is host-managed.
>=20
> The patch also adds the comment to clarify that the call to perform
> the zoned device probe is correctly placed after virtio_device ready().
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UeJ1ldfXW4hAubI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQi/uAACgkQnKSrs4Gr
c8iXUQf/XeQDhMQwhrkmGbNhqXJTGDOpHG9MFxMuLAyseS0nCgzBwHREd3ta3ZJH
o7wCIYOoCpVJLBEbYT3DswgL8YZvW9kAQd9TTiVSILN7lO1ZuLrTzopS0dUCofKK
CTsfVp5RwR+kmDr0nsZR/l4O6GMP1IuNv0ZLxMu10YuQZWO9pzJYbIaEA7K2J88G
3cfMF5TnrcIfPMsOBJPLiLDW6npuvY9ch9A+MFLawmMl9bLJYZHYNN5esmkmbsH/
1OXRs/vSK3RFUaBmCzVfupCq6p8hI7NeoHNVHosLb0zwuTowF7ooz40oJqCmSzPT
v5VAggpWBRbOcOz6UOz0Vjwa5dVlVQ==
=w94Z
-----END PGP SIGNATURE-----

--UeJ1ldfXW4hAubI9--

