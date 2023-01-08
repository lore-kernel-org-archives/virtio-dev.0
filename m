Return-Path: <virtio-comment-return-3702-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 8 Jan 2023 17:06:09 +0000
Message-ID: <PH0PR12MB54811189A5DD2C06063C66CEDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230108144659.438750-1-parav@nvidia.com>
 <20230108103653-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230108103653-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v6] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, January 8, 2023 10:39 AM
>=20
> > +VIRTIO_NET_CTRL_VLAN_ADD command adds the specified VLAN to the
> VLAN
> > +filter table.
> > +
> > +VIRTIO_NET_CTRL_VLAN_DEL command removes the specified VLAN from
> the
> > +VLAN filter table.
> > +
Above two are functional description not placed in the requirements. So no =
need for normative.

> > +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types /
> > +Network Device / Device Operation / Control Virtqueue / VLAN
> > +Filtering}
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> > +VLAN tagged packets as per the device configuration.
> > +
Above one adding must looks fine.

> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with an
> > +empty VLAN filter table.
> > +
I am inclined to move this out of requirements and write in the description=
 along with add/delete command.

> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> > +VLAN tagged packets whose VLAN tag is present in the VLAN filter
> > +table;=20

I will add must for above line.

> > the device should drop all VLAN tagged packets whose VLAN tag
> > +is absent in the VLAN filter table. The VLAN filter table applies
> > +only to VLAN tagged packets.
> > +
>=20
Above one is written as should will change to "SHOULD".

> We need to make them normative statements. As written they are not.
> Either MUST or SHOULD in this case. I am guessing MUST since this was alw=
ays
> the intent we just never spelled it out?

Right.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

