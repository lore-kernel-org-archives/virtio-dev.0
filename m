Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] virtio-net: Improve introductory description
Date: Wed, 8 Feb 2023 01:17:55 +0000
Message-ID: <PH0PR12MB548198D89BB5C0239237A7C2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230202040012.103782-1-parav@nvidia.com>
 <87cz6lu6uh.fsf@redhat.com>
In-Reply-To: <87cz6lu6uh.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, February 7, 2023 5:07 AM
>=20
> On Thu, Feb 02 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > The control VQ of the virtio network device is used beyond advance
> > steering control. The control VQ dynamically changes multiple features
> > of the initialized device.
> >
> > Hence, update this area of control VQ introductory description at few
> > places and also place the link to its description.
> >
> > Also update the introduction section to better describe receive and
> > transmit virtqueues.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  device-types/net/description.tex | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/device-types/net/description.tex
> > b/device-types/net/description.tex
> > index 88a5770..dedd6b1 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -2,13 +2,13 @@ \section{Network Device}\label{sec:Device Types /
> > Network Device}
> >
> >  The virtio network device is a virtual network interface controller.
> >  It consists of a virtual Ethernet link which connects the device -to
> > the Ethernet network. It is the most complex of the devices -supported
> > so far by virtio. It has enhanced rapidly and demonstrates -clearly
> > how support for new features are added to an existing -device. Empty
> > buffers are placed in one virtqueue for receiving -packets, and
> > outgoing packets are enqueued into another for -transmission in that
> > order. A third command queue is used to -control advanced filtering
> > features.
> > +to the Ethernet network. The driver posts empty buffers in the
> > +receive virtqueue. The device receives the incoming packets from the
> > +link; the device places these incoming packets in the receive virtqueu=
e
> buffers.
> > +The driver enqueues outgoing packets to the transmit virtqueue. The
> > +device dequeues these packets from the transmit virtqueue and sends
> > +them to the link. A control virtqueue is used to dynamically
> > +manipulate various features of the initialized device.
>=20
> General question: Is it better to talk about "the receive virtqueue" (to =
keep it
> simple), or "a receive virtqueue" (as there may be several)?

For sure Michael can better answer this than me. :)
The receive virtqueue aligns to me with "the device", the driver etc.
It also aligns with existing sections in device and driver requirements tha=
t refers to "the receiveq".
Since there are many queues, better to refer as "the".
A receive queue may imply that there is only one.

