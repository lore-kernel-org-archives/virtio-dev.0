Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and device
 management
Date: Tue, 2 Aug 2022 17:40:23 +0000
Message-ID: <PH0PR12MB54812EC8C4E0378B24D249ACDC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724170744-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481269E252B7DD8EFE2109DDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220724191530-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127CD9F333F8F92580531DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220725030303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812685041A59D642227920DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220731112614-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220731112614-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, July 31, 2022 11:39 AM
>=20
> On Sat, Jul 30, 2022 at 01:21:20PM +0000, Parav Pandit wrote:
> > > > Not a good reason to introduce something inferior.
> > >
> > > Avoiding duplication and focusing on low hanging fruit are all sound
> > > engineering principles.
> > >
> > It is not a duplication.
> > I iterate again. The bits we asked to put in the Aq commands are the on=
e
> that does not need to be negotiated early.
> > Feature bits were mis-used to put all things in there because in past a
> generic AQ didn't exists.
> > And there is no reason for that past decision to influence current prop=
osal.
> >
> > Feature bits that are so basic for device bring up stage, stays in feat=
ure bits
> area defined today.
> > Hence, its not a duplication.
>=20
> Let's take a look at a network device for example.
>=20
>=20
> =09\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial
> checksum.   This
> =09  ``checksum offload'' is a common feature on modern network cards.
>=20
> =09\item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with
> partial checksum.
>=20
> =09\item[VIRTIO_NET_F_CTRL_GUEST_OFFLOADS (2)] Control channel
> offloads
> =09=09reconfiguration support.
>=20
> =09\item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is
> supported. If
> =09    offered by the device, device advises driver about the value of
> =09    its maximum MTU. If negotiated, the driver uses \field{mtu} as
> =09    the maximum MTU value.
>=20
> =09\item[VIRTIO_NET_F_MAC (5)] Device has given MAC address.
>=20
> =09\item[VIRTIO_NET_F_GUEST_TSO4 (7)] Driver can receive TSOv4.
>=20
> =09\item[VIRTIO_NET_F_GUEST_TSO6 (8)] Driver can receive TSOv6.
>=20
> =09\item[VIRTIO_NET_F_GUEST_ECN (9)] Driver can receive TSO with
> ECN.
>=20
> =09\item[VIRTIO_NET_F_GUEST_UFO (10)] Driver can receive UFO.
>=20
> =09\item[VIRTIO_NET_F_HOST_TSO4 (11)] Device can receive TSOv4.
>=20
> =09\item[VIRTIO_NET_F_HOST_TSO6 (12)] Device can receive TSOv6.
>=20
> =09\item[VIRTIO_NET_F_HOST_ECN (13)] Device can receive TSO with
> ECN.
>=20
> =09\item[VIRTIO_NET_F_HOST_UFO (14)] Device can receive UFO.
>=20
> =09\item[VIRTIO_NET_F_MRG_RXBUF (15)] Driver can merge receive
> buffers.
>=20
> =09\item[VIRTIO_NET_F_STATUS (16)] Configuration status field is
> =09    available.
>=20
> =09\item[VIRTIO_NET_F_CTRL_VQ (17)] Control channel is available.
>=20
> =09\item[VIRTIO_NET_F_CTRL_RX (18)] Control channel RX mode
> support.
>=20
> =09\item[VIRTIO_NET_F_CTRL_VLAN (19)] Control channel VLAN
> filtering.
>=20
> =09\item[VIRTIO_NET_F_GUEST_ANNOUNCE(21)] Driver can send
> gratuitous
> =09    packets.
>=20
> =09\item[VIRTIO_NET_F_MQ(22)] Device supports multiqueue with
> automatic
> =09    receive steering.
>=20
> =09\item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address
> through control
> =09    channel.
>=20
> =09\item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications
> coalescing.
>=20
> =09\item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4
> packets.
>=20
> =09\item[VIRTIO_NET_F_GUEST_USO6 (55)] Driver can receive USOv6
> packets.
>=20
> =09\item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO
> packets. Unlike UFO
> =09 (fragmenting the packet) the USO splits large UDP packet
> =09 to several segments when each of these smaller packets has UDP
> header.
>=20
> =09\item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-
> packet hash
> =09    value and a type of calculated hash.
>=20
> =09\item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the
> exact \field{hdr_len}
> =09    value. Device benefits from knowing the exact header length.
>=20
> =09\item[VIRTIO_NET_F_RSS(60)] Device supports RSS (receive-side
> scaling)
> =09    with Toeplitz hash calculation and configurable hash
> =09    parameters for receive steering.
>=20
> =09\item[VIRTIO_NET_F_RSC_EXT(61)] Device can process duplicated
> ACKs
> =09    and report number of coalesced segments and duplicated ACKs.
>=20
> =09\item[VIRTIO_NET_F_STANDBY(62)] Device may act as a standby for
> a primary
> =09    device with the same MAC address.
>=20
> =09\item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed and
> duplex.
>=20
>=20
> which of these are basic for bring up stage?
>=20
>=20
As you pointed all above fields has zero relation to the device initializat=
ion.
Those can be very well-done post device init stage over an AQ.
The fact that such queue never existed before, it was logic to extend the f=
eature bits.
Otherwise, they are very well suitable to be negotiated over net CVQ or new=
 AQ.
> > >
> > Even for non SIOV devices?
>=20
> Yes.
In that case it is no different than the AQ. :)
Not sure what are we debating for.
You say that feature bits of the VF _itself_ are negotiated over a transpor=
t queue by VF itself.
Including the above one that you listed?
Right?
If so, that is useful.
Yet to review the rfc.

> > > Not 100% sure what you are saing here, so I think you should post a
> > > new version, yes. Generally iterating faster is a good idea. If you
> > > feel you didn't get enough feedback on a given version and some time
> > > passed try pinging people.
> > Without closing the discussion, I have seen same topic come up again an=
d
> again in future version.
> > So even though new series is up for posting, we better close the
> discussion.
>=20
> That's a mistake, it will be harder for you to make progress like this.
> Reviewers have limited attention span and memory, text bitrots, you decid=
e
> to make unrelated changes yourself... Sorry I'm repeating myself but iter=
ate
> quickly in the open even if there are known issues not addressed yet, jus=
t
> make very sure to be open and detailed about issues you addressed and
> known issues you did not address.
Ok. Thanks for the useful direction.

