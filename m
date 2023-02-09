Return-Path: <mst@redhat.com>
Date: Thu, 9 Feb 2023 07:48:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: Improve introductory
 description
Message-ID: <20230209074712-mutt-send-email-mst@kernel.org>
References: <20230209014108.209950-1-parav@nvidia.com>
 <m2cz6j2gbz.fsf@oracle.com>
 <PH0PR12MB548195947918089961CEE699DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548195947918089961CEE699DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 12:45:09PM +0000, Parav Pandit wrote:
> 
> > From: David Edmondson <david.edmondson@oracle.com>
> > Sent: Thursday, February 9, 2023 7:03 AM
> > 
> 
> [..]
> > > +to the Ethernet network. The device has transmit and receive queues.
> > > +The driver posts empty buffers in the receive virtqueue.
> > > +The device receives the incoming packets from the link; the device
> > > +places these incoming packets in the receive virtqueue buffers.
> > > +The driver enqueues outgoing packets to the transmit virtqueue. The
> > >  device
> > 
> > We "post" receive buffers, yet "enqueue" transmit buffers. These actions seem
> > the same.
> > 
> > Maybe "submits" in both cases?
> > 
> At virtqueue level it is same.
> In context of virtio net device, transmit operation is queued that awaits processing (to send) by device.
> While receive side, its unsolicited operation done by driver that doesn't await processing by device.
> Whenever/if in future when a packet arrives, the posted buffer is consumed.
> 
> So enqueue and post were capturing this contextual detail.
> But maybe I am trying to be too precise here but above wording were more natural to me at net level. :)
> Let me know..

Just "add" - this is what happens at vq level:

	Driver makes requests available to device by adding
	an available buffer to the queue, i.e., adding a buffer

-- 
MST

