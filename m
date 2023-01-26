Return-Path: <virtio-dev-return-10669-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 26 Jan 2023 16:17:30 +0000
Message-ID: <PH0PR12MB5481D1CCC1AFB671C20444C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212550.763889-1-parav@nvidia.com>
	<20230125190454.043e54e0.pasic@linux.ibm.com>
	<PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230126124852.549102a6.pasic@linux.ibm.com>
In-Reply-To: <20230126124852.549102a6.pasic@linux.ibm.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Thursday, January 26, 2023 6:49 AM
>=20
> On Wed, 25 Jan 2023 19:09:28 +0000
> Parav Pandit <parav@nvidia.com> wrote:
>=20
> > > Would just
> > > "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, no VLAN filtering is
> > > done by the device."
> > > work?
> > >
> > This is also fine.
> > However, I prefer the current spec terminology used in mac, promiscuous=
 etc
> area such as "receive/accept/drop".
> > It is lot clearer to understand in steering world.
> > And it also aligns to the steering tools such as tc [3] which defines t=
he action
> as "drop/mirred/redirect" etc.
>=20
> My problem is not the word accept itself. Let me try to explain it once a=
gain,
> now that we have gotten rid of the confusing "as per device configuration=
".
> Now our sentence looks like this.
>=20
> When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept all
> VLAN tagged packets.
>=20
> Let us analyze it.
> Predicate: "MUST accept"
> Object: "all VLAN tagged packets"
> Subject: "the device"
>=20
> Compare that to man 8 tc. There they make it clear that there may the thi=
ngs
> like the next filter, and that those are comprised of actions.
>=20
> I think, in a system with multiple filters, it is a very different piece =
of cake stating
> that a:
> * A certain filter accepts an input.
> * The whole system accepts an input.
>=20
> If in our sentence the subject where not the "the device" but something l=
ike
> "the VLAN filtering facility" or you name it, I would be fine with that.
>=20
> But when without the corresponding domain knowledge, the device MUST
> accept sounds like the driver of an conforming device will see that packe=
t. I.e.
> the device dropping that very same packet for a different reason is not p=
ossible
> without violating that normative.
>=20
> Of course with enough domain knowledge, one would know that we didn't
> really mean that the "the packet must be accepted by the device" but rath=
er
> that the "VLAN filtering mechanism is not allowed to drop the give packet=
".
> Because the former makes no sense.
>=20
> In the end, I believe the target audience of this document does have the
> domain knowledge to deal with the situation. But I prefer normative state=
ment
> that don't lend themselves to misinterpretation.
>=20
Yes. exactly. I did clarify in one of the previous response s(don't have th=
e link handy) that steering section overall for mac, promiscuous, vlan etc =
flitering needs some rewrite for cross dependencies.
I would possibly drive it in a separate issue word it. Because the scope of=
 it beyond just this issue.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

