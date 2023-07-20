Return-Path: <virtio-dev-return-13391-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E44EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:32:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9FF36157EE9
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:32:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FF75986833
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:32:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 635DD986830; Thu, 20 Jul 2023 19:32:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50794986831
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 19:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 79x0Q-uAPjSfJMr-Mo7ZOQ-1
Date: Thu, 20 Jul 2023 15:32:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
	mst@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230720193234.GG210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMZ6YtjoAS9abvaN"
Content-Disposition: inline
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

--rMZ6YtjoAS9abvaN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.
>=20
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> Initial RFC for discussion. I intend to prototype this work with QEMU
> and one of the rust-vmm vhost-user daemons.
> ---
>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c      |  8 ++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..85b1b1583a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,21 @@ Inflight description
> =20
>  :queue size: a 16-bit size of virtqueues
> =20
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_G=
ET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported

What is the purpose of min_vqs? I'm not sure why the front-end needs to
know this.

--rMZ6YtjoAS9abvaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5i9EACgkQnKSrs4Gr
c8hlaQf+MbQ3pGRCXVnZ2FthmpJQmXxTTV436fhUOR1qKE5SOQrFXu7mDSgXGDiw
QYu+czDiW9kF8mkAqLjIw4+8mnStX4/Ck4OM5VvssbS90SpwNo1SSynskVN75OVb
/mk3ej0dHARZ8CU4YlmkvdgM5E5iaglvyDuYTSL1CkO13VgtGmNn5dEUBE+yxApc
VoEyMTz4IE2leIYp6lTI84X7g1fR6ib+ZzYWPTYuLQvG+OMqjgSwlfjUG6B16Y6a
J9mq7dHxThkLGOtA6gKfKQHpSnlwVsNepC9fomWSa3KpSAfebaLtDNgav8rcYTAQ
azD62I/PzUC/bpIAjVa/gJpFkJMzsQ==
=VjIe
-----END PGP SIGNATURE-----

--rMZ6YtjoAS9abvaN--

