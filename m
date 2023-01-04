Return-Path: <virtio-comment-return-3677-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 4 Jan 2023 13:28:55 +0000
Message-ID: <PH0PR12MB5481AC6618719A63E6801190DCF59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104040205.360753-1-parav@nvidia.com>
 <20230104013612-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230104013612-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v4] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, January 4, 2023 1:41 AM
>=20
> On Wed, Jan 04, 2023 at 06:02:05AM +0200, Parav Pandit wrote:
> > The filtering behavior of the VLAN filter commands is not very clear
> > as discussed in thread [1].
> >
> > Hence, add the command description and device requirements for it.
> >
> > [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
> > Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> Looks like we are going back to issues that we had in v1.
> what happened here?
>=20
I was missing text in v3 for the case of device behavior for handling vlan =
tagged packets when CTRL_VLAN is not negotiated.
Which I added in v4. Parts of the v1 was taken care. More below.
[..]
> > +
> > +VIRTIO_NET_CTRL_VLAN_DEL command removes specified VLAN from the
> VLAN
>=20
> the specified
>=20
Ack.

> > +filtering table which was previously added using
> > +VIRTIO_NET_CTRL_VLAN_ADD command.
>=20
> bad ordering so it's unclear what was added. it's vlan not the table. So:
> =09removes the specified VLAN - which was previously added using
> =09VIRTIO_NET_CTRL_VLAN_ADD command - from the VLAN filtering
> table.
>
Ack.
=20
> > +
> > +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types /
> > +Network Device / Device Operation / Control Virtqueue / VLAN
> > +Filtering}
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> > +VLAN tagged packets that matches the device's filter configuration.
>=20
> bad grammar here and it's not a match.
>=20
How about,=20

When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts=20
all VLAN tagged packets based on the device configuration.

Above spec line covers=20
(a) existing mac filter table entries
(b) promiscuous variations and=20
(c) future filtering rules.

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

