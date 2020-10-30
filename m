Return-Path: virtio-return-3446-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 30 Oct 2020 11:01:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201030105945-mutt-send-email-mst@kernel.org>
References: <20201029075047.119209-1-mst@redhat.com>
 <20201030113732.GG307361@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201030113732.GG307361@stefanha-x1.localdomain>
Subject: Re: [virtio] Re: [virtio-dev] [PATCH] VIRTIO_F_RING_PACKED_USED:
 packing used descriptors
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 30, 2020 at 11:37:32AM +0000, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 03:50:57AM -0400, Michael S. Tsirkin wrote:
> > +When after processing the used descriptor, the batch counter
> > +exceeds the ring size, the batch counter is decremented by the
> > +ring size; both device and driver then skip to the
> > +beginning (offset 0) of the ring until processing (reading for
> > +the driver and writing for the device) the next used descriptor.
> 
> This may be clearer:
> 
>   both device and driver then use ring index 0 for the next used
>   descriptor
> 
> Or:
> 
>   The device writes the next used descriptor at ring index 0. The driver
>   reads the next used descriptor from ring index 0.
> 
> I'm not sure I understand this scheme. Is this pseudo-code correct?
> 
>   batch_counter += num_used_descs
>   if batch_counter > ring_size:
>       batch_counter -= ring_size
>       used_idx = 0

yes


> Can you share an explanation of how this scheme ensures that the
> driver's next avail descriptor index never overtakes the device's next
> used descriptor index?

Simply because to overtake it, it needs to wrap around to 0.
That happens when batch counter wraps over to 0, if we make
device wrap at that point all is well.


> Previously it was obvious that the two never cross because the used
> descriptor index jumped by the number of avail descriptors that were
> processed by the device.
> 
> Stefan

it still does that, just at the time of wrap around, not
after each descriptor.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

