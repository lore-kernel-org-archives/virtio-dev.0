Return-Path: <virtio-comment-return-3916-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 26 Jan 2023 12:48:52 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230126124852.549102a6.pasic@linux.ibm.com>
In-Reply-To: <PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212550.763889-1-parav@nvidia.com>
	<20230125190454.043e54e0.pasic@linux.ibm.com>
	<PH0PR12MB548193F9D20E6C75CE29E3B4DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 25 Jan 2023 19:09:28 +0000
Parav Pandit <parav@nvidia.com> wrote:

> > Would just
> > "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, no VLAN filtering is do=
ne
> > by the device."
> > work?
> > =20
> This is also fine.
> However, I prefer the current spec terminology used in mac, promiscuous e=
tc area such as "receive/accept/drop".
> It is lot clearer to understand in steering world.
> And it also aligns to the steering tools such as tc [3] which defines the=
 action as "drop/mirred/redirect" etc.

My problem is not the word accept itself. Let me try to explain it once
again, now that we have gotten rid of the confusing "as per device
configuration". Now our sentence looks like this.

When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept
all VLAN tagged packets.

Let us analyze it.=20
Predicate: "MUST accept"
Object: "all VLAN tagged packets"
Subject: "the device"

Compare that to man 8 tc. There they make it clear that there may
the things like the next filter, and that those are comprised of
actions.=20

I think, in a system with multiple filters, it is a very different
piece of cake stating that a:
* A certain filter accepts an input.
* The whole system accepts an input.

If in our sentence the subject where not the "the device" but
something like "the VLAN filtering facility" or you name it,
I would be fine with that.

But when without the corresponding domain knowledge, the device
MUST accept sounds like the driver of an conforming device will see that
packet. I.e. the device dropping that very same packet for a different
reason is not possible without violating that normative.

Of course with enough domain knowledge, one would know that we didn't
really mean that the "the packet must be accepted by the device" but
rather that the "VLAN filtering mechanism is not allowed to drop the
give packet". Because the former makes no sense.

In the end, I believe the target audience of this document does have
the domain knowledge to deal with the situation. But I prefer normative
statement that don't lend themselves to misinterpretation.

Regards,
Halil



>=20
> Hence, lets keep
> "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept al=
l VLAN tagged packets"
>=20
> This way spec language is same for negotiated/non-negotiated case of acce=
pt/drop etc.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

