Return-Path: <virtio-dev-return-13394-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70476C001DC
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:59:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE8F845B2C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:59:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8522598683E
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 19:59:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6576D986830; Thu, 20 Jul 2023 19:59:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52A41986831
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 19:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rOCc9eh6MjmAnkY4mda72A-1
Date: Thu, 20 Jul 2023 15:58:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230720195837.GJ210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y3Pyr4rpz3fA5NCs"
Content-Disposition: inline
In-Reply-To: <20230706124347-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

--y3Pyr4rpz3fA5NCs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > Currently QEMU has to know some details about the back-end to be able
> > to setup the guest. While various parts of the setup can be delegated
> > to the backend (for example config handling) this is a very piecemeal
> > approach.
>=20
> > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALON=
E)
> > which the back-end can advertise which allows a probe message to be
> > sent to get all the details QEMU needs to know in one message.
>=20
> The reason we do piecemeal is that these existing pieces can be reused
> as others evolve or fall by wayside.
>=20
> For example, I can think of instances where you want to connect
> specifically to e.g. networking backend, and specify it
> on command line. Reasons could be many, e.g. for debugging,
> or to prevent connecting to wrong device on wrong channel
> (kind of like type safety).
>=20
> What is the reason to have 1 message? startup latency?
> How about we allow pipelining several messages then?
> Will be easier.

This flag effectively says that the back-end is a full VIRTIO device
with a Device Status Register, Configuration Space, Virtqueues, the
device type, etc. This is different from previous vhost-user devices
which sometimes just offloaded certain virtqueues without providing the
full VIRTIO device (parts were emulated in the VMM).

So for example, a vhost-user-net device does not support the controlq.
Alex's "standalone" device is a mode where the vhost-user protocol is
used but the back-end must implement a full virtio-net device.
Standalone devices are like vDPA device in this respect.

I think it is important to have a protocol feature bit that advertises
that this is a standalone device, since the semantics are different for
traditional vhost-user-net devices.

However, I think having a single message is inflexible and duplicates
existing vhost-user protocol messages like VHOST_USER_GET_QUEUE_NUM. I
would prefer VHOST_USER_GET_DEVICE_ID and other messages.

Stefan

--y3Pyr4rpz3fA5NCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5ke0ACgkQnKSrs4Gr
c8hj3wf+OxDIxO3gPzNYxNljVy5Q+tGdkNsGXwheOv7mDLm3fRfKUpJLlFbUz7uG
lgx9e/arw5qy885ZkOA9ElHVuAEA283hk2WpnGGhW8oh3pSN9aZHx2p/cNRWBSx/
XsjghkSF0GwDXOWfhACGwVySezmpIU7lmp52XfyPNKn06u6PA6psRBQsJpr1HuHx
wt8Mck6AvhETrpBG9kzJgqFK3EDxdN4sBvbh3Yi1v+Z1AaQfWMNsmWgU1v/B+NYz
0PDGcHAlrBvIBNWRQrE/PcUf7163Mn/5XLDKaavN2udfNi/BUhifTpso9q4Jbd+J
Oezp7UpOgKRdFAcw/JOssBQJ+WfU9w==
=XMod
-----END PGP SIGNATURE-----

--y3Pyr4rpz3fA5NCs--

