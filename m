Return-Path: <virtio-dev-return-14342-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17C9C48BF6
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 12:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 00D8076EC8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 12:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF38A98652E
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 12:50:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B487E9864A1; Wed, 21 Feb 2024 12:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAE619864B2
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2024 12:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 21 Feb 2024 13:49:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, 
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6fbgss6kbbxpo54"
Content-Disposition: inline
In-Reply-To: <ZdXShopKyMYPTUva@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtio-dev@lists.oasis-open.org
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.

--n6fbgss6kbbxpo54
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> > > +The length of the \field{sdu} is determined by the \field{length}.
> > > +
> > > +The type of a CAN message identifier is determined by \field{flags}.=
 The
> > > +3 most significant bits of \field{can_id} do not bear the information
> > > +about the type of the CAN message identifier and are 0.
> > > +
> > > +The device MUST reject any CAN frame type for which support has not =
been
> > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST =
NOT
> > > +schedule the message for transmission. A CAN frame with an undefined=
 bit
> > > +set in \field{flags} is treated like a CAN frame for which support h=
as
> > > +not been negotiated.
> > > +
> > > +The device MUST reject any CAN frame for which \field{can_id} or
> > > +\field{sdu} length are out of range or the CAN controller is in an
> > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MU=
ST
> > > +NOT schedule the message for transmission.
> > > +
> I am not very familiar with CAN but how does the device figure out that
> the can_id is out of range?

In classical CAN we have the standard CAN frames, which have an 11 bit
ID, and there are extended CAN frames, which have 29 bits ID. Extended
frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.

So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
out of range.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n6fbgss6kbbxpo54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXV8VgACgkQKDiiPnot
vG9Dfwf/fB9BsfKlNrhf0m0/Ym50ssSYlC9p4UdBqBli+D4CQQbFhKXuJIc5pbsF
cxMDyo3aayKdXskeVJWiBys8wBI52EY/gRFuwM/OuBLsaN3WS+nLVrINT+EniPHn
mu1yPVoYWPfFjQKi3sPZkQUluJ8O1KUbL3m77jUVPJ93SAoQM6nQrIwsQvPIg7Ct
gsmpD1UruWsbNGWzvPK6BoQ+tNfYkCcuMwn5y6BUyOX2GFAQhaDaqRjATyjlfJDC
DbytEO1tE0lWW+Z1UxaTamF0r7hLIcNKmEP5gD5J+qSCE60NOotPcgbimBJ973Aq
8E8oGG6CFa5E5oyEam1M4qulavwknQ==
=SERR
-----END PGP SIGNATURE-----

--n6fbgss6kbbxpo54--
