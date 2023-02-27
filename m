Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v1 2/2] transport-pci: Move transitional device id to
 legacy section
Date: Mon, 27 Feb 2023 02:54:09 +0000
Message-ID: <PH0PR12MB54811B0B6E6E95A659DA41B0DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230225220636.429990-1-parav@nvidia.com>
 <20230225220636.429990-3-parav@nvidia.com>
 <20230225175847-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225175847-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 6:00 PM
>=20
> On Sun, Feb 26, 2023 at 12:06:36AM +0200, Parav Pandit wrote:
> > Currently PCI device requirements section contains mix of normative
> > statements for for regular (non transitional) device and transitional
> > device under one section.
> >
> > Some requirements of the transitional device are also located in
> > legacy interface section which is the right section for it.
> >
> > Hence,
> > 1. Move transitional device requirements to their designated Legacy
> >    interface section
> > 2. Describe regular device requirements without quoting it as "non
> >    transitional device"
> >
> > While at it, write the description using a singular object definition.
> >
> > This is only an editorial change.
> >
> > This patch is on top of [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> nack I already answered this. legacy sections describe legacy interface o=
f
> transitional devices.
>=20
Legacy device id of the transitional device is 0x1000 for net.=20
Legacy revision id of the transitional device is 0x0.
Why revision id belongs to legacy section, but device id doesn't?
Still trying to understand this convoluted policy.
Will re-read your email again if that is explained somehow without bringing=
 the driver in context.

