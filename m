Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] virtio-net: Improve introductory description
Date: Thu, 9 Feb 2023 01:25:40 +0000
Message-ID: <PH0PR12MB5481B921C71D12523E793942DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230202040012.103782-1-parav@nvidia.com>
 <87cz6lu6uh.fsf@redhat.com>
 <PH0PR12MB548198D89BB5C0239237A7C2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208043417-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208043417-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 4:46 AM

[..]
> > > General question: Is it better to talk about "the receive virtqueue"
> > > (to keep it simple), or "a receive virtqueue" (as there may be severa=
l)?
> >
> > For sure Michael can better answer this than me. :) The receive
> > virtqueue aligns to me with "the device", the driver etc.
> > It also aligns with existing sections in device and driver requirements=
 that
> refers to "the receiveq".
> > Since there are many queues, better to refer as "the".
> > A receive queue may imply that there is only one.
>=20
> My take is that it should be "a queue" the first time we talk about it. T=
hen if it's
> the same queue we say "the queue".
> I also feel an intro sentence saying something along the lines of "the de=
vice has
> receive and transmit queues". Then rest of uses can be "the".
Will update this in v3.

