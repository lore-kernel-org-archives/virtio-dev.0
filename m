Return-Path: <virtio-dev-return-12673-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED209C7EE22
	for <virtio-dev@archiver.kernel.org>; Sun, 14 May 2023 21:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2557E2A8E1
	for <virtio-dev@archiver.kernel.org>; Sun, 14 May 2023 21:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECFD898636A
	for <virtio-dev@archiver.kernel.org>; Sun, 14 May 2023 21:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D2896986196; Sun, 14 May 2023 21:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 765E5986319
	for <virtio-dev@lists.oasis-open.org>; Sun, 14 May 2023 21:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Sun, 14 May 2023 22:09:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
Message-ID: <20230514-senior-container-bf049eb882a9-mkl@pengutronix.de>
References: <20230511151444.162882-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <CAMZ6RqJbjoApwZbiivbvJRYQyBWfWXG4azmwuXGaicrMq0Lozg@mail.gmail.com>
 <a83e29fd-09d0-64b4-ce56-c7f7a5e44f66@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6qfmmn4wmyaeefb"
Content-Disposition: inline
In-Reply-To: <a83e29fd-09d0-64b4-ce56-c7f7a5e44f66@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] Re: [RFC PATCH v3] can: virtio: Initial virtio CAN driver.

--i6qfmmn4wmyaeefb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.05.2023 19:39:40, Harald Mommer wrote:
> > > diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> > > index ff8f76295d13..19314adaff59 100644
> > > --- a/drivers/net/can/Makefile
> > > +++ b/drivers/net/can/Makefile
> > > @@ -17,8 +17,8 @@ obj-$(CONFIG_CAN_AT91)                +=3D at91_can=
=2Eo
> > >   obj-$(CONFIG_CAN_BXCAN)                +=3D bxcan.o
> > >   obj-$(CONFIG_CAN_CAN327)       +=3D can327.o
> > >   obj-$(CONFIG_CAN_CC770)                +=3D cc770/
> > > -obj-$(CONFIG_CAN_C_CAN)                +=3D c_can/
> > >   obj-$(CONFIG_CAN_CTUCANFD)     +=3D ctucanfd/
> > > +obj-$(CONFIG_CAN_C_CAN)                +=3D c_can/
> > This reordering is unrelated to this patch goal. Please send it as a
> > separate patch.
>=20
> @Marc Kleine-Budde: We got this reordering change from you.

That reordering was not intended.

> How to proceed?

Remove that change and sorry for the confusion.

> We can split this in 2 commits, reordering and on top adding virtio CAN. =
No
> issue, a question of minutes and done. Fine. But here the word "patch" was
> used, not the word "commit".

I think in first approximation patches and commits can be/are used
interchangeably :) (One thought process might be: If you make it a
separate commit and send it here, it's no longer in git and thus just a
patch, no longer a commit.)

> Sending a separate patch to somewhere? Maybe
> Mikhail does this fight to get this in (unlikely), I personally would pre=
fer
> to run away. Or we don't reorder at all, wrong ordering remains and we wi=
ll
> not make only you unhappy.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--i6qfmmn4wmyaeefb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRhQAsACgkQvlAcSiqK
BOiLrwf+MivjvW3UCXg71VmfmbA3FMZQOYEREO80Bd/GD1zKMbD3PtaN/jFo2bHo
kYXOW4N67y4TYbwHFVoY4wYzzv+1OSfUzVc5xYgYbcGzBBxS80zmGlvMpEmI4H2z
50XyMbZVBZOhxUrAvfQc40KY05IIoSWnkT1ReBN7nmYtm+FK0Ctpww1jgmyGK9/G
9W0ZoIOfmoQWXSTp7KtocxpUWNiU4uCgZYFt9I5bNag/qZDztgjVTFbct1lCYejs
jvNjWvWqXPneFd1B1I6Tca3zup1hTKTpT2C6uOZ1/GcN8GWoIbLdNtBZYIHnnlXg
IhaMq27QJd3111vs57wiCmwwyWcZXQ==
=kAT9
-----END PGP SIGNATURE-----

--i6qfmmn4wmyaeefb--
