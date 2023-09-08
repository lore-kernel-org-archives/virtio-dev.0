Return-Path: <virtio-dev-return-13658-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7EEE7FEF
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 13:01:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4649DEEA14
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 13:01:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 150E1986605
	for <virtio-dev@archiver.kernel.org>; Fri,  8 Sep 2023 13:01:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE0C598644B; Fri,  8 Sep 2023 13:01:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBE8B98644C
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Sep 2023 13:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XHa_rEn6M5y8aqpl4SPiSw-1
Date: Fri, 8 Sep 2023 09:01:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org
Message-ID: <20230908130108.GA3561353@fedora>
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
 <20230907192259.GC1560640@fedora>
 <87v8ckzx0g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4lYbCNRBzkY5d5b4"
Content-Disposition: inline
In-Reply-To: <87v8ckzx0g.fsf@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Subject: [virtio-dev] Re: [RFC PATCH v2] docs/interop: define PROBE feature for vhost-user
 VirtIO devices

--4lYbCNRBzkY5d5b4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 01:03:26PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > On Fri, Sep 01, 2023 at 12:00:18PM +0100, Alex Benn=E9e wrote:
> >> Currently QEMU has to know some details about the VirtIO device
> >> supported by a vhost-user daemon to be able to setup the guest. This
> >> makes it hard for QEMU to add support for additional vhost-user
> >> daemons without adding specific stubs for each additional VirtIO
> >> device.
> >>=20
> >> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> >> which the back-end can advertise which allows a probe message to be
> >> sent to get all the details QEMU needs to know in one message.
> >>=20
> >> Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> >> VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> >> daemons which are capable of handling all aspects of the VirtIO
> >> transactions with only a generic stub on the QEMU side. These daemons
> >> can also be used without QEMU in situations where there isn't a full
> >> VMM managing their setup.
> >>=20
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >
> > I think the mindset for this change should be "vhost-user is becoming a
> > VIRTIO Transport". VIRTIO Transports have a reasonably well-defined
> > feature set in the VIRTIO specification. The goal should be to cover
> > every VIRTIO Transport operation via vhost-user protocol messages so
> > that the VIRTIO device model can be fully conveyed over vhost-user.
>=20
> Is it though? The transport is a guest visible construct whereas
> vhost-user is purely a backend implementation detail that should be
> invisible to the guest.

No, the transport is not necessarily guest-visible. The vhost-user model
is that the front-end emulates a VIRTIO device and some aspects of that
device are delegated to the vhost-user back-end.

In other words, the vhost-user device is not the same as the VIRTIO
device that the guest sees, but it's still important for the vhost-user
back-end to be a VIRTIO Transport because that's how we can be sure it
supports the VIRTIO device model properly.

>=20
> Also the various backends do things a different set of ways. The
> differences between MMIO and PCI are mostly around where config space is
> and how IRQs are handled. For CCW we do actually have a set of commands
> we can look at:
>=20
>   #define CCW_CMD_SET_VQ 0x13=20
>   #define CCW_CMD_VDEV_RESET 0x33=20
>   #define CCW_CMD_SET_IND 0x43=20
>   #define CCW_CMD_SET_CONF_IND 0x53=20
>   #define CCW_CMD_SET_IND_ADAPTER 0x73=20
>   #define CCW_CMD_READ_FEAT 0x12=20
>   #define CCW_CMD_WRITE_FEAT 0x11=20
>   #define CCW_CMD_READ_CONF 0x22=20
>   #define CCW_CMD_WRITE_CONF 0x21=20
>   #define CCW_CMD_WRITE_STATUS 0x31=20
>   #define CCW_CMD_READ_VQ_CONF 0x32=20
>   #define CCW_CMD_SET_VIRTIO_REV 0x83=20
>   #define CCW_CMD_READ_STATUS 0x72
>=20
> which I think we already have mappings for.

Yes, there are differences between the transports. vhost-user uses
eventfds (callfd/kickfd) instead of interrupts.

> > Anything less is yet another ad-hoc protocol extension that will lead to
> > more bugs and hacks when it turns out some VIRTIO devices cannot be
> > expressed due to limitations in the protocol.
>=20
> I agree we want to do this right.
>=20
> > This requires going through the VIRTIO spec to find a correspondence
> > between virtio-pci/virtio-mmio/virtio-ccw's interfaces and vhost-user
> > protocol messages. In most cases vhost-user already offers messages and
> > your patch adds more of what is missing. I think this effort is already
> > very close but missing the final check that it really matches the VIRTIO
> > spec.
> >
> > Please do the comparison against the VIRTIO Transports and then adjust
> > this patch to make it clear that the back-end is becoming a full-fledged
> > VIRTIO Transport:
> > - The name of the patch series should reflect that.
> > - The vhost-user protocol feature should be named F_TRANSPORT.
> > - The messages added in this patch should have a 1:1 correspondence with
> >   the VIRTIO spec including using the same terminology for consistency.
> >
> > Sorry for the hassle, but I think this is a really crucial point where
> > we have the chance to make vhost-user work smoothly in the future...but
> > only if we can faithfully expose VIRTIO Transport semantics.
>=20
> I wonder if first be handled by cleaning up the VirtIO spec to make it
> clear what capabilities each transport needs to support?

It's a fair point that the VIRTIO spec does not provide an interface
definition for the VIRTIO Transport or at least a definitive list of
requirements. The requirements are implicit (i.e. it is assumed that
very transport provides a way to set the virtqueue descriptor table
addresses) so it's necessary to review the existing transports to
understand their functionality.

If you want to create a list of the requirements for a VIRTIO Transport
and propose a patch to the VIRTIO spec then that would be great, but I
don't think that stops this patch series. It's possible to review
virtio-pci/virtio-mmio/virtio-ccw and check that there is equivalent
functionality in the vhost-user protocol.

Stefan

--4lYbCNRBzkY5d5b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT7GxQACgkQnKSrs4Gr
c8jWtwf/Z/A+yL3qr82N3fRom3WITQnljqD3IS0npyBNRVpd7t0PNa8dIi/bn6Ex
yuxUFNQsE5BnzBxoRyTEm1BhnfhN0+nb6yauE6gg8wb6cMPkW22Ug5I6pniHrR8x
i+TOaP6T2Pn7mDbjGGhkoLvz56V9QCw7AclNtPSzx1u+XxhtsH+gePY/fZnIqRAT
LVReg8ha48Beh7CUlOVX5CtrpzKap8V+qg4oIXhIO0crwuKMJo7CtQ3auGB/lsRm
ZJW+wyE9tk45sH24vPQhk/F/SZc1QCZqou57vA5kJq9yqqNcC6+J2b29yUBay3Sm
Hz/TQSEaTWUZJVA6iu0Cd6etbsbo4w==
=/1HJ
-----END PGP SIGNATURE-----

--4lYbCNRBzkY5d5b4--

