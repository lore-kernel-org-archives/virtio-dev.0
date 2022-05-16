Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v5 6/7] Introduce MGMT admin commands
Date: Mon, 16 May 2022 21:47:23 +0000
Message-ID: <PH0PR12MB54818C762CC4DAAB3020B2ADDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220515102628-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, May 15, 2022 10:37 AM

> > +This value is also returned in the virtio_admin_device_mgmt_result
> structure.
> > +Also, a successful operation guarantees that the MSI-X capability
> > +access by the designated PCI device defined by the PCI specification
> > +must reflect the new configuration in all relevant fields. For example=
, by
> default if the PCI VF has been assigned 4 MSI-X vectors, and
> VIRTIO_ADMIN_DEVICE_MGMT increases the MSI-X vectors to 8. On this
> change, reading Table size field of the MSI-X message control register wi=
ll
> reflect a value of 7.
> > +
> > +It is beyond the scope of the virtio specification to define
> > necessary synchronization in system software to ensure that a virtio
> > PCI VF device +interrupt configuration modification is reflected in
> > the PCI device.
>=20
> IMHO it is very much in scope of the specification.=20
Many pieces of this system software are not implemented by the virtio speci=
fication...
Not sure, how can it belong to virtio spec.

> The scope of the
> specification is to allow device interoperability and this very much fits=
 the bill.
>=20
How is interoperability affected and between which two entities?

