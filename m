Return-Path: <virtio-dev-return-13407-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA937C001B0
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Jul 2023 18:08:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C5D24C622E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Jul 2023 18:08:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7E3798653D
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Jul 2023 18:08:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8F3C09864BD; Mon, 24 Jul 2023 18:08:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BBA5986509
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jul 2023 18:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SatHzKsSM66rfF1WWHDfMw-1
Date: Mon, 24 Jul 2023 14:08:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230724180839.GC222590@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
 <20230720182128-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o5VRGi/hTISP7+bi"
Content-Disposition: inline
In-Reply-To: <20230720182128-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

--o5VRGi/hTISP7+bi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:22:08PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> > On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > > > > > Currently QEMU has to know some details about the back-end to b=
e able
> > > > > > to setup the guest. While various parts of the setup can be del=
egated
> > > > > > to the backend (for example config handling) this is a very pie=
cemeal
> > > > > > approach.
> > > > >
> > > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_S=
TANDALONE)
> > > > > > which the back-end can advertise which allows a probe message t=
o be
> > > > > > sent to get all the details QEMU needs to know in one message.
> > > > >
> > > > > The reason we do piecemeal is that these existing pieces can be r=
eused
> > > > > as others evolve or fall by wayside.
> > > > >
> > > > > For example, I can think of instances where you want to connect
> > > > > specifically to e.g. networking backend, and specify it
> > > > > on command line. Reasons could be many, e.g. for debugging,
> > > > > or to prevent connecting to wrong device on wrong channel
> > > > > (kind of like type safety).
> > > > >
> > > > > What is the reason to have 1 message? startup latency?
> > > > > How about we allow pipelining several messages then?
> > > > > Will be easier.
> > > >
> > > > This flag effectively says that the back-end is a full VIRTIO device
> > > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > > device type, etc. This is different from previous vhost-user devices
> > > > which sometimes just offloaded certain virtqueues without providing=
 the
> > > > full VIRTIO device (parts were emulated in the VMM).
> > > >
> > > > So for example, a vhost-user-net device does not support the contro=
lq.
> > > > Alex's "standalone" device is a mode where the vhost-user protocol =
is
> > > > used but the back-end must implement a full virtio-net device.
> > > > Standalone devices are like vDPA device in this respect.
> > > >
> > > > I think it is important to have a protocol feature bit that adverti=
ses
> > > > that this is a standalone device, since the semantics are different=
 for
> > > > traditional vhost-user-net devices.
> > >
> > > Not sure what that would gain as compared to a feature bit per
> > > message as we did previously.
> >=20
> > Having a single feature bit makes it easier to distinguish between a
> > traditional vhost-user device and a standalone device.
> >=20
> > For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> > you whether this device is a standalone device that is appropriate for
> > a new generic QEMU --device vhost-user-device feature that Alex is
> > working on. It could be a traditional vhost-user device that is not
> > standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> >=20
> > How will we detect standalone devices? It will be messy if there is no
> > single feature bit that advertises that this back-end is a standalone
> > device.
> >=20
> > Stefan
>=20
> Looks like standalone implies some 5-6 messages to be supported.
> So just test the 6 bits are all ones.

It's not clear to me that the individual bits together mean this is
really a standalone device, but let's go with individual commands and
see if a front-end can distinguish standalone devices or not. If not,
then we can still add "standalone" feature bit before merging the code.

Stefan

--o5VRGi/hTISP7+bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS+vicACgkQnKSrs4Gr
c8gwHAf/Zt97EcRQvJNEWrSazGTKbMTLdGKZ7TelOycHhzAnDHdlCyrx1BGi544l
rp4kQ7TcJN9zqH1wmQ2SBCkGUnkDCl6y2P3Ce989k2FY6YM0+kJIifJxAvUCOFXK
DCYXTTB6ARA0IAV3lB+nPXLbZ8YCdFyMHGEQ3HtvRA7h8z3EvzzMcL3RZDm9QPOg
QPL2mPB77lpWvtpBivQudZtVBiM5/3AqavlvS2A5WgFQMO+IDW1BfkCNRAY+UMX0
68vth18G0A7LJQ731qmSxRKhcOUbyQIcJTesMwQmx0GYOzGY1wDCb06j7OghZQmV
ACcFtLAFRdp7jg4yKdt+2mzS2HTzcA==
=HvKo
-----END PGP SIGNATURE-----

--o5VRGi/hTISP7+bi--

