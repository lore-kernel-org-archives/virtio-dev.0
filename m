Return-Path: <virtio-comment-return-3668-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 3 Jan 2023 21:58:05 +0000
Message-ID: <PH0PR12MB5481A6CD1B85268B481D7D8ADCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221225003727.103495-1-parav@nvidia.com>
 <20230103054736-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230103054736-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v1] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 3, 2023 5:56 AM
>=20
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> > +VLAN tagged packets which matches  device's filter configuration.
>=20
> which match the device's
>=20
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> > +empty
>=20
> an empty
>=20
> > +VLAN filtering table.
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all the
>=20
> all the -> all
>=20
> > +VLAN tagged packets whose VLAN tag is found in the VLAN filtering
> > +table; device should drop all VLAN tagged packets whose VLAN tag is
> > +not found
>=20
> the device
>=20
> > +in the VLAN filtering table.
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device accepts all
> > +untagged packets which matches device's
>=20
>=20
> which match the device's ...
>=20
> > filter configuration.
>=20
> This confusing, took me several reads to understand.
> E.g. with promisc we accept all packets, it is not necessary about a matc=
h.
> I suggest "
> Filtering of untagged packets is not affected by whether
> VIRTIO_NET_F_CTRL_VLAN is or is not negotiated.
> "
>
Make sense.
I simplified the wordings now.
Also fixed above comments in v2.
Thanks.


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

