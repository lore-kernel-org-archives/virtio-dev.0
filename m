Return-Path: <virtio-dev-return-12921-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2463C7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 09:37:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E70582B03A
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 09:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9E0198669D
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 09:37:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3B05986692; Fri,  9 Jun 2023 09:37:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1BD9986697
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 09:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Fri, 9 Jun 2023 11:37:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Message-ID: <20230609-greasily-jolliness-6b5bde46f390-mkl@pengutronix.de>
References: <20220825133410.18367-1-harald.mommer@opensynergy.com>
 <87o7tj2bgd.fsf@redhat.com>
 <7f10427c-cad4-6eeb-31f0-e39ccdbc38ab@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvutexvarpe3wb7n"
Content-Disposition: inline
In-Reply-To: <7f10427c-cad4-6eeb-31f0-e39ccdbc38ab@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v2 1/1] virtio-can:
 Device specification - 2nd RFC draft.

--gvutexvarpe3wb7n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2023 15:45:33, Harald Mommer wrote:
> > > - Removal of priorities and config space. Priorities cannot be suppor=
ted
> > >    using SocketCAN, the information delivered in the config space can=
not
> > >    be determined using SocketCAN. Support of different priorities was
> > >    anyway too much for a first version of a specification. If priorit=
ies
> > >    are supported in a future version there will probably be only 2
> > >    different priorities, normal and high. In a future version of the
> > >    specification high priority messages may either be supported by us=
ing
> > >    a flag bit in the TX message but most probably the better solution
> > >    will be to add add a dedicated 2nd TX queue for high priority mess=
ages
> > >    in a review comment. But as already said priorities are not for no=
w.
> > Please keep the change log separate from the description.
> >=20
> > [Most people add a S-o-b, although we don't enforce DCO.]
>=20
> I understand neither "S-o-b" nor "DCO". Neither Wikipedia nor Google are
> helpful, nothing fits.

S-o-b: Signed-off-by
DCO: Developer's Certificate of Origin

See https://elixir.bootlin.com/linux/v6.3/source/Documentation/process/subm=
itting-patches.rst#L379

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gvutexvarpe3wb7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSC8u8ACgkQvlAcSiqK
BOjAlQgAmmmSbo1/9cD9bXx+ZSW2cq7d4S8RUeOOeCyiEurgasFP9EtVZqplvTlb
yJ4CFh4HLb+6qdZYtVlEn284rTqGRpdUER3CqJmjIpXggzqKhpgObrYNoGZpDJM4
SIo5xbQtE6nNsLAQB4t6QeLbbQSw6q+UmUsgFZxTaMzkh7/uZlrZ1j1VeZaj3RqM
6yHvZrzmvBHUHqLa1ptjOqRGe2VwFE1K9bclsMTKyGXGvQr+WxthP0m2ZRDGBoNm
97mh4jE8EZ95JFnKPeBogQxZxXA7XExCCOU2fPzJwqnjnnqcz4dQobD/JMUMtLvO
SdrlMuCpfVjbAIUo8kVPQyozFsWTcg==
=L29k
-----END PGP SIGNATURE-----

--gvutexvarpe3wb7n--
