Return-Path: <virtio-dev-return-12279-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B606C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 98B0526A34
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86EE6986406
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:06:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7C260984043; Tue, 18 Apr 2023 12:06:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BB499863E3
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 12:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Tue, 18 Apr 2023 14:06:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Harald Mommer <hmo@opensynergy.com>
Cc: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
	stratos-dev@op-lists.linaro.org,
	Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <20230418-pull-negligee-f253a3c8e7db-mkl@pengutronix.de>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
 <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
 <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
 <c20ee6cf-2aae-25ef-e97f-0e7fc3f9c5b6@opensynergy.com>
 <20230414-scariness-disrupt-5ec9cc82b20c-mkl@pengutronix.de>
 <9786872e-1063-e1ff-dc0d-6be5952a1826@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbejfhwai7v6uczb"
Content-Disposition: inline
In-Reply-To: <9786872e-1063-e1ff-dc0d-6be5952a1826@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.

--qbejfhwai7v6uczb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.04.2023 11:50:56, Harald Mommer wrote:
> there is now an implementation of the device for qemu internally under
> review.

Great news!

> The paperwork with the company lawyer to publish source code has also been
> done.

This was probably more work than the actual coding :)

> At the same time we changed the driver and the specification draft also,
> especially the bus off indication is now done by a config space bit inste=
ad
> of having a dedicated indication queue. Minor updates to some other
> structures. This means what we have will match an updated driver and
> specification version not yet sent out. Also to be done so that people can
> play around.

Looking forward to see the code.

> So an open source qemu device is in the work and we are close to publish
> this in our public github repository but until now nothing has been pushed
> yet to github.

Next week is our yearly hacking week. Some working qemu and Linux
drivers would be excellent.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qbejfhwai7v6uczb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQ+h8wACgkQvlAcSiqK
BOiFFgf/XM5nIh2LYk0Iu4Ns08EGdD12H+7cz4mwTAm26MgLjkcJGG5bEMD4AZ6e
OnrKmz+c7hsBk0h+BwF18phQqH3prdje2vnKaczvjD4iNnpId57mCu2hNWP05NhP
x46zraLhQwcy3qS5qpki9gWAV4oMzSAFBhZpV2qp4wwy0HMc2MQhefzJgCa1HxVg
emwNT/3vuf38IslMUlSqZGsnKhCvOajZVTcyo1hpo5DSVf3J0aYWXNRJj/bGaHS3
3KNXmRQjvCCRi5u8VJyYIEp3FGMK6cGtWiNMX+TkIRH6uO/PK9yjLcz/N+1RJbzH
uTR79ceo/ekik35HjzYGnUCxgmtmpw==
=LT/a
-----END PGP SIGNATURE-----

--qbejfhwai7v6uczb--
