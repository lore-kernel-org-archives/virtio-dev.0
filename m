Return-Path: <mst@redhat.com>
Date: Wed, 8 Feb 2023 04:46:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-net: Improve introductory description
Message-ID: <20230208043417-mutt-send-email-mst@kernel.org>
References: <20230202040012.103782-1-parav@nvidia.com>
 <87cz6lu6uh.fsf@redhat.com>
 <PH0PR12MB548198D89BB5C0239237A7C2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548198D89BB5C0239237A7C2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 01:17:55AM +0000, Parav Pandit wrote:
> 
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Tuesday, February 7, 2023 5:07 AM
> > 
> > On Thu, Feb 02 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > The control VQ of the virtio network device is used beyond advance
> > > steering control. The control VQ dynamically changes multiple features
> > > of the initialized device.
> > >
> > > Hence, update this area of control VQ introductory description at few
> > > places and also place the link to its description.
> > >
> > > Also update the introduction section to better describe receive and
> > > transmit virtqueues.
> > >
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  device-types/net/description.tex | 21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/device-types/net/description.tex
> > > b/device-types/net/description.tex
> > > index 88a5770..dedd6b1 100644
> > > --- a/device-types/net/description.tex
> > > +++ b/device-types/net/description.tex
> > > @@ -2,13 +2,13 @@ \section{Network Device}\label{sec:Device Types /
> > > Network Device}
> > >
> > >  The virtio network device is a virtual network interface controller.
> > >  It consists of a virtual Ethernet link which connects the device -to
> > > the Ethernet network. It is the most complex of the devices -supported
> > > so far by virtio. It has enhanced rapidly and demonstrates -clearly
> > > how support for new features are added to an existing -device. Empty
> > > buffers are placed in one virtqueue for receiving -packets, and
> > > outgoing packets are enqueued into another for -transmission in that
> > > order. A third command queue is used to -control advanced filtering
> > > features.
> > > +to the Ethernet network. The driver posts empty buffers in the
> > > +receive virtqueue. The device receives the incoming packets from the
> > > +link; the device places these incoming packets in the receive virtqueue
> > buffers.
> > > +The driver enqueues outgoing packets to the transmit virtqueue. The
> > > +device dequeues these packets from the transmit virtqueue and sends
> > > +them to the link. A control virtqueue is used to dynamically
> > > +manipulate various features of the initialized device.

What happened here? Parav it looks like your client mangled Cornelia's
response. Pls take a look at your client config.

> > General question: Is it better to talk about "the receive virtqueue" (to keep it
> > simple), or "a receive virtqueue" (as there may be several)?
> 
> For sure Michael can better answer this than me. :)
> The receive virtqueue aligns to me with "the device", the driver etc.
> It also aligns with existing sections in device and driver requirements that refers to "the receiveq".
> Since there are many queues, better to refer as "the".
> A receive queue may imply that there is only one.

My take is that it should be "a queue" the first time
we talk about it. Then if it's the same queue we say "the queue".
I also feel an intro sentence saying something along the lines
of "the device has receive and transmit queues". Then
rest of uses can be "the".

-- 
MST

