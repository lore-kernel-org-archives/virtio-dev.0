Return-Path: virtio-return-2935-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 00:10:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180301000823-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <55eb7e9c-97ee-f7d7-10db-190dd844160d@linux.vnet.ibm.com>
 <20180226224109-mutt-send-email-mst@kernel.org>
 <a8f6a85a-8bab-d21d-1114-dd1719875a8e@linux.vnet.ibm.com>
 <20180227161003-mutt-send-email-mst@kernel.org>
 <fc26698d-e214-9285-0482-cb6db9acada8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc26698d-e214-9285-0482-cb6db9acada8@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] Re: [PATCH v8 08/16] packed
 virtqueues: more efficient virtqueue layout
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 06:03:01PM +0100, Halil Pasic wrote:
> 
> 
> On 02/27/2018 03:11 PM, Michael S. Tsirkin wrote:
> >> [..]
> >>>>> +
> >>>>> +\devicenormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
> >>>>> +A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
> >>>>> +read a device-writable buffer.
> >>>>> +A device MUST NOT use a descriptor unless it observes
> >>>>> +VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
> >>>> I don't really understand this. How does the device observe
> >>>> the VIRTQ_DESC_F_AVAIL bit being changed?
> >>> By reading the descriptor.
> >>>
> >> :) My point is: to observe a change one usually either needs at
> >> least one reading before and at least one reading after the change,
> >> or one needs to know that a certain reading means change. The latter
> >> is possible if we know that at the beginning of the time frame under
> >> consideration (t_0) only a certain set of values,let's say B like before,
> >> is possible, and after the change only a certain other set of values
> >> let's say A like after, is possible, and A and B are disjunctive (
> >> $A \cap B = \emtyset$).
> > Well each descriptor is read each time ring wraps around,
> > and the bit value changes each time ring wraps around.
> > For example device knows it's zero initialized so
> > if it reads bit value as 1 it knows the bit value has changed.
> > 
> > 
> 
> Yeah I kind of understand but I would like having a more straightforward
> formulation here (than changes).
> 
> BTW does this mean that the vhost implementation (that is:
> 
> +static bool desc_is_avail(struct vhost_virtqueue *vq,
> +			  struct vring_desc_packed *desc)
> +{
> +	if (vq->used_wrap_counter)
> +		if ((desc->flags & DESC_AVAIL) && !(desc->flags & DESC_USED))
> +			return true;
> +	if (vq->used_wrap_counter == false)
> +		if (!(desc->flags & DESC_AVAIL) && (desc->flags & DESC_USED))
> +			return true;
> +
> +	return false;
> +}
> 
> ) is needlessly looking at the 'used' bit? (I think that is the case.)
> 
> Bottom line is: I would like avail/used protocol described in a less
> ambiguous fashion.
> 
> However if I'm the only one who finds this aspect hard to understand,
> the problem probably lies with me and not with the text. I can accept
> that too.

I don't want to over-specify it. There are many options.
For example, if driver sets ID to a value != 0 then
when it sees ID != 0 it knows it has been used.

I added pseudo-code for the driver, hopefully that is sufficient.

> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

