Return-Path: <virtio-comment-return-3697-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 6 Jan 2023 18:22:09 +0000
Message-ID: <PH0PR12MB548149E2555AF64484D09F5EDCFB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104040205.360753-1-parav@nvidia.com>
 <20230104013612-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC6618719A63E6801190DCF59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230104083633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230104083633-mutt-send-email-mst@kernel.org>
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
> Sent: Wednesday, January 4, 2023 8:38 AM

[..]
> > When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> > VLAN tagged packets based on the device configuration.
>=20
> We came up with a better wording e.g. in 20230103054736-mutt-send-email-
> mst@kernel.org .

The above link is broken for me.
Did you mean below wordings?
" Filtering of untagged packets is not affected by whether VIRTIO_NET_F_CTR=
L_VLAN is or is not negotiated."

If so, then it's different because above text line is for the untagged pack=
ets.
While the text I added bak in v4 is for tagged packets.

Please review v5 to see if it makes sense.

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

