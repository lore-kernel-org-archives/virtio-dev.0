Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3] virtio-net: Improve introductory description
Date: Thu, 9 Feb 2023 12:38:03 +0000
Message-ID: <PH0PR12MB54818C922063B200FBD0244CDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209014108.209950-1-parav@nvidia.com>
 <87a61n6pci.fsf@redhat.com>
In-Reply-To: <87a61n6pci.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, February 9, 2023 6:38 AM

> > +to the Ethernet network. The device has transmit and receive queues.
> > +The driver posts empty buffers in the receive virtqueue.
> > +The device receives the incoming packets from the link; the device
> > +places these incoming packets in the receive virtqueue buffers.
> > +The driver enqueues outgoing packets to the transmit virtqueue. The
> > +device dequeues these packets from the transmit virtqueue and sends
> > +them to the link. The device may have a control virtuqueue. The
> > +driver
>=20
> typo: s/virtuqueue/virtqueue/

Fix fix. Thanks.

