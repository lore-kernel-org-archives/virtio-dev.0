Return-Path: <virtio-dev-return-12240-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E3C77B71
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 19:20:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB2202B142
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 19:20:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9641098660E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 19:20:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 83C48986602; Fri, 14 Apr 2023 19:20:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7222C98660D
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 19:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Fri, 14 Apr 2023 21:20:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Harald Mommer <hmo@opensynergy.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
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
Message-ID: <20230414-scariness-disrupt-5ec9cc82b20c-mkl@pengutronix.de>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
 <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
 <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
 <c20ee6cf-2aae-25ef-e97f-0e7fc3f9c5b6@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xnmhcrr72x5qdecz"
Content-Disposition: inline
In-Reply-To: <c20ee6cf-2aae-25ef-e97f-0e7fc3f9c5b6@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.

--xnmhcrr72x5qdecz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.02.2023 16:02:04, Harald Mommer wrote:
> we had here at OpenSynergy an internal discussion about an open source
> virtio-can device implementation.
>=20
> The outcome of this is now that an open source virtio-can device is to be
> developed.
>=20
> It has not yet been decided whether the open source device implementation
> will be done using qemu or kvmtool (or something else?). Negative or
> positive feedback for or against one of those is likely to influence the
> decision what will be used as basis for the development. Using kvmtool may
> be easier to do for me (to be investigated in detail) but on the other ha=
nd
> we have some people around in the team who have the knowledge to support
> with qemu.

It there some code available yet? We as Pengutronix will be on our
yearly techweek soon and I want to look into the VirtIO CAN stuff.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xnmhcrr72x5qdecz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQ5p3EACgkQvlAcSiqK
BOjfHwf+O/dOtHi/KVZ0/GZIlgqpUhXJ3osE2M7NmHrLC0JYVkbg62cVTjVl2G/k
ACcNQR8dbjUiFwlRF/jh1hie27J1NHkBmILuSLcjXU/a1zIq1JfNyNWo7ECS0VOG
7zg3Oryjh7oGqPmafPjSFPeqJ8xmp65NRm4y5CoAoceL/rn/+Qyuw+Qgyuk/3+q2
7xSWXNV2ZnPwIziZkjGgE87XD+osDnyan6P4XVhguFcQmSrVdzVDKaQAvBlPoujE
GZ3aopCKYpnNIdcdGxYrZWnLRFTGKpnXbMemf+JP2OQX9yIxiFL7KwFMylSuk0H+
JSM2kVdA5fptgdB8wOdwlgyrhMA7sQ==
=91Bh
-----END PGP SIGNATURE-----

--xnmhcrr72x5qdecz--
