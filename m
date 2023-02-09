Return-Path: <virtio-comment-return-4109-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 9 Feb 2023 12:45:09 +0000
Message-ID: <PH0PR12MB548195947918089961CEE699DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209014108.209950-1-parav@nvidia.com>
 <m2cz6j2gbz.fsf@oracle.com>
In-Reply-To: <m2cz6j2gbz.fsf@oracle.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH v3] virtio-net: Improve introductory
 description
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: David Edmondson <david.edmondson@oracle.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Thursday, February 9, 2023 7:03 AM
>=20

[..]
> > +to the Ethernet network. The device has transmit and receive queues.
> > +The driver posts empty buffers in the receive virtqueue.
> > +The device receives the incoming packets from the link; the device
> > +places these incoming packets in the receive virtqueue buffers.
> > +The driver enqueues outgoing packets to the transmit virtqueue. The
> >  device
>=20
> We "post" receive buffers, yet "enqueue" transmit buffers. These actions =
seem
> the same.
>=20
> Maybe "submits" in both cases?
>=20
At virtqueue level it is same.
In context of virtio net device, transmit operation is queued that awaits p=
rocessing (to send) by device.
While receive side, its unsolicited operation done by driver that doesn't a=
wait processing by device.
Whenever/if in future when a packet arrives, the posted buffer is consumed.

So enqueue and post were capturing this contextual detail.
But maybe I am trying to be too precise here but above wording were more na=
tural to me at net level. :)
Let me know..

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

