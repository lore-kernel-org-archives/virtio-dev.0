Return-Path: <virtio-dev-return-13390-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D3DEB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 15:41:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DDD5D1318CE
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 15:41:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF58D986823
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 15:41:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3A2F986818; Thu, 20 Jul 2023 15:41:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9130498681A
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 15:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fEuGDWmfOpWBGpVu9Jsxdw-1
Date: Thu, 20 Jul 2023 11:40:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org, JP Cottin <jpcottin@google.com>,
	Jorge Moreira Broche <jemoreira@google.com>
Message-ID: <20230720154034.GE184015@fedora>
References: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J6yrPNi8o6vR8O9D"
Content-Disposition: inline
In-Reply-To: <CAOGAQeoLSGR2RtRHX0kyS5dxK=wa+mDZ8BRyZX5oDKaL16LdSg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: Re: [virtio-dev] virtio-snd and snapshots (e.g. in QEMU) when audio
 is active

--J6yrPNi8o6vR8O9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 04:21:08PM -0700, Roman Kiryanov wrote:
> Hi,
>=20
> I work in Android Studio Emulator and we use virtio-snd (implemented
> ourselves) for audio output/input. According to the spec (1.2), the
> device has one TX virtqueue for all output streams and one RX
> virtqueue for all input streams. Each stream may and usually have more
> than one period (I request 4 periods).
>=20
> Because virtqueues are shared between streams (if there are more than
> one stream in the same direction), I cannot fetch vq messages when a
> stream needs one. I fetch vq messages (and put them into my own buffer
> to process them later) when the kernel puts them into a vq. I hope
> this is correct. I think I tried processing them immediately (at least
> for TX) but the kernel was not happy with this because I was draining
> the buffer too fast causing XRUN.
>=20
> If a snapshot request comes when audio streams are active I may have
> several unprocessed messages for several streams for both TX and RX.
> In my case messages are VirtQueueElement* which I don't think can be
> saved directly.
>=20
> Could you please advise what a device is expected to do in this case?

Do you mean QEMU's VirtQueueElement? There are devices in QEMU that
save/load in-flight VirtQueueElements. See qemu_put_virtqueue_element().

Often devices quiesce (e.g. by draining in-flight I/O requests) when the
VM is stopped before the device state is saved. That makes life simpler.

Stefan

>=20
> Thank you.
>=20
> Regards,
> Roman.
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--J6yrPNi8o6vR8O9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5VXIACgkQnKSrs4Gr
c8hYjwgAsXOkSErYhKfLppm2NJwj6riuY4m9VQwJ0GOHQMckLtPdfcYHVHNLgPo/
9UOaAPlY+oZH6hTDdAwzbprOCLpff4t+O0EqYpTZMq2Uu4jny1Kn9e8/hkyQxIbS
9j23K7vI5WqPnEaS+uNnRnp0MrQSSTIVcyP6nT/U46+U+Nwz+1mxelJXcWYu594I
/KrTY1aFNMKFY+T28/gWY4wU+62lyyusWGYfmbQ13Syvjfyuu8JcyoSg0BtHY8/J
qr9bLrEWY5/pkl8JSgzy8Tz0+FwxCUfQ/J3GNAalLrj4RrwIq9seTOYe3XKCrYPb
lUoTSvGR13HDun4nndG3+4S3RvUt/g==
=wBUk
-----END PGP SIGNATURE-----

--J6yrPNi8o6vR8O9D--

