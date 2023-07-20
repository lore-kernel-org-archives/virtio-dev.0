Return-Path: <virtio-dev-return-13392-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B259AEB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:35:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 15B052AD4C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:35:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E05D698683A
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:35:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1F66986830; Thu, 20 Jul 2023 19:35:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 892E5986832
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 19:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3m7NbuOyMTm3RYJBjmG3XQ-1
Date: Thu, 20 Jul 2023 15:34:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
	mst@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230720193405.GH210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j9wh8nmrelTh7uLo"
Content-Disposition: inline
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

--j9wh8nmrelTh7uLo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c4e0cbd702..28b021d5d3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
> =20
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;

You already answered my question about min_vqs in another sub-thread.
I'll continue there. Please ignore my question.

Stefan

--j9wh8nmrelTh7uLo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5jC0ACgkQnKSrs4Gr
c8iN6AgAxdqz+9Xcn0x06RFaLDFhDZZIKyQMS5xX2hORkjyy4/elj76lqsL3LWp3
hg2YULCGZR2aKklkTi0ru6GZ+sHCHgK5b5Jc4mIZv+J9bxxKvPipRfuxaAbax8zp
32swpPC5FMIl+LtM7YT4+DaJo8xggwqXlDMtQ1jIKZI68hqE7gM8DXQBg/XKHNcI
Cb0BFC+up8UgVEE5NhdZKZiHU18ibcTs7B0VilMIrB6E6ca7qZyX0LS6rWAV7QyT
Wfi8eeNpzKnY6ol08simZf+6aSyVLu7cO9MK5PlbpMQMtUUofe8pz55GaBK9Odme
rDiX1BP4ycHowZZ3/W1ItQK2iT1urA==
=zdi6
-----END PGP SIGNATURE-----

--j9wh8nmrelTh7uLo--

