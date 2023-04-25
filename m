Return-Path: <virtio-dev-return-12400-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B07C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 09:17:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7E5152B068
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 09:17:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B69798643E
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 09:17:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 54BDB9863E1; Tue, 25 Apr 2023 09:17:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4120898640F
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 09:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 25 Apr 2023 11:17:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
 <20230424170901-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrzhwsd3655udnop"
Content-Disposition: inline
In-Reply-To: <20230424170901-mutt-send-email-mst@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] Re: [PATCH] can: virtio-can: cleanups

--wrzhwsd3655udnop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.04.2023 17:09:23, Michael S. Tsirkin wrote:
> On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> > Address the topics raised in
> >=20
> > https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengut=
ronix.de
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> given base patch is rfc this should be too?

This is an incremental patch that fixes the topics I raised in the
review of "[RFC PATCH v2] can: virtio: Initial virtio CAN driver.", see
linked discussion thread.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wrzhwsd3655udnop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRHmp0ACgkQvlAcSiqK
BOhdHwf/elII+CN8WhgoClA6Y9+l7RyecrlVcqKWmgZNO5hTG6BmvkzP//T6m9Lq
3XEmvI6TFszxDp+0yHDIaRS1fqBDCKaSpjRZEozRyE1df4BH7XBFIkcVyI5M3oEZ
BJ6O94BtlJ+/vlg5pn9mebyFo6TYwaHLQuVwVcB9Gxc3S6JGqgYcE0N6uW2hdr9t
0tk/zZTu+jwul+wlzo1vhd/xkmpiGshP2Z5TCJA8XkAokqz4LcLxOfGtSKS6Xey8
4+qgTgCDpkkX+yhAZrycTfQii7JcMxbOtnBjGONXMkG3vMQo2ueIDaonqlGLvC+/
WWX2HB7sfw7YZMKZ5h7ov7ottPC2ew==
=7r0O
-----END PGP SIGNATURE-----

--wrzhwsd3655udnop--
