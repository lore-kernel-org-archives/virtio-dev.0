Return-Path: virtio-return-3038-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 29 Mar 2018 17:30:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180329171705-mutt-send-email-mst@kernel.org>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
 <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
 <20180328200739-mutt-send-email-mst@kernel.org>
 <20180329110555.708a88b9.cohuck@redhat.com>
 <c5dd1c7e-30e6-119e-d06b-fc8cee0d671c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5dd1c7e-30e6-119e-d06b-fc8cee0d671c@linux.vnet.ibm.com>
Subject: Re: [virtio] [PATCH v12] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 29, 2018 at 04:15:19PM +0200, Halil Pasic wrote:
> 
> 
> On 03/29/2018 11:05 AM, Cornelia Huck wrote:
> > On Wed, 28 Mar 2018 20:21:47 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> >> On Wed, Mar 28, 2018 at 06:56:13PM +0200, Halil Pasic wrote:
> >>>
> >>>
> >>> On 03/27/2018 06:37 PM, Michael S. Tsirkin wrote:  
> >>>> Some devices benefit from ability to find out the number of available
> >>>> descriptors in the ring: for efficiency or as a debugging aid.
> >>>>
> >>>> To help with these optimizations, add a new feature:
> >>>> VIRTIO_F_NOTIFICATION_DATA. When negotiated, driver notifications to the
> >>>> device include this extra information.  
> >>>
> >>> I'm pondering about symmetry and about the nature of these
> >>> optimizations. By symmetry I mean this only works driver->device.
> >>> Why do we want this the one but not the other way around?  
> >>
> >> Because
> >> - memory is already closer to CPU than to devices
> >> - there is no way to pass extra data with an interrupt
> >>
> >>
> 
> Thanks for the explanation!
> 
> >>>>
> >>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> ---
> >>>>
> >>>> v11 -> v12
> >>>> 	add missing 'the' article
> >>>> 	drop duplicate text sections
> >>>> 	use separate listing files for BE and LE, making
> >>>> 	format explicit.
> >>>>
> >>>> v10 -> v11:
> >>>>         drop mention of interrupts: current proposal does not include
> >>>>         this interrupt related information
> >>>>         drop unrelated introduction sections
> >>>>
> >>>>
> >>>>
> >>>>  content.tex        | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >>>>  notifications-be.c |   5 +++
> >>>>  notifications-le.c |   5 +++
> >>>>  3 files changed, 113 insertions(+), 6 deletions(-)
> >>>>  create mode 100644 notifications-be.c
> >>>>  create mode 100644 notifications-le.c
> >>>>
> >>>> diff --git a/content.tex b/content.tex
> >>>> index 7a92cb1..ae5fa4c 100644
> >>>> --- a/content.tex
> >>>> +++ b/content.tex
> >>>> @@ -283,9 +283,49 @@ Packed Virtqueues}).
> >>>>  Every driver and device supports either the Packed or the Split
> >>>>  Virtqueue format, or both.
> >>>>
> >>>> +\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}  
> >>>
> >>> Don't we call the same 'device notification' in 2.5.12.4 Notifying The Device.  
> >>
> >> Oh right.
> >>
> >>> The wordings used to denote the different notifications seems to be
> >>> chaotic and maybe somewhat confusing overall.
> >>>
> >>> Let me provide some examples:
> >>> For *virtqueue notification sent by the driver to the device* we use:
> >>>    * 'driver notifications' (here)  
> >>
> >> We should fix this I think.
> >>
> >>>    * 'device notification' in 2.5.12.4 Notifying The Device)
> >>>    * 'virtqueue notification' (2.5.9 Virtqueue Notification Suppression)  
> >>
> >> Let's change these to 'virtqueue device notifications'?
> >> It's a separate issue though, not introduced by this patch.
> >>
> >>>    * 'guest -> host notification' (4.3.3.2 Guest->Host Notification)  
> >>
> >> That's a transport thing specific to virtio over MMIO.
> > 
> > ccw, right?
> > 
> 
> Yes.
> 
> > I called these 'guest->host' (and 'host->guest') because it was more
> > easily understandable at the time. It would be better to call them
> > 'device notification' and 'driver notification' to align with the
> > wording elsewhere. (As a separate patch.)
> > 
> 
> I'm definitely in favor of aligned wording. I'm also in favor of a
> separate patch, as long as this one does not introduce conflicts,
> which is my primary concern.
> 
> And the 'guest->host' indeed came across as one of the easy to
> understand when I was first exposed to the spec. About 'call them
> device notification and driver notification' I'm not sure. I
> think the conflict, which is my primary concern, demonstrates
> that it's too easy to get it wrong (and to hard to remember did
> we tie the name to the recipient or to the sender). Moreover
> the device sends two types of notifications (virtqueue and confing).
> 
> I don't have a good solution, otherwise I would have proposed already.
> Maybe something like 'available notification' and 'used notification' is
> worth considering. I don't like that one can read available and used
> as normal English (that is a notification that is available and not
> a notification that buffers were made available at the given virtqueue).

I think I like this.

Available buffer / used buffer notifications?


We'd have to make this change all over the spec,
if you like it pls open a github issue and post
a patch.

> Yet the alternatives I had in mind like 'driver to device virtqueue
> notification' are too verbose.
> 
> >>
> >>> The notifications *sent by the device to the driver (virtqueue or
> >>> configuration change)* are often referred to as *interrupts* but occasionally
> >>> also as notifications (e.g. 'host->guest notification').
> > 
> > I think 'notifications' is a better term for these. I'm thinking of a
> > driver polling for outstanding notifications from the device, no
> > interrupts involved.
> > 
> 
> I agree that notifications is more generic (and can fit any mechanism
> established by some transport) while interrupt does smell like implementation
> a bit.
> 
> 
> > But we can discuss that later.
> > 
> 
> Agreed.
> 
> >>>
> >>>
> >>>   
> >>>> +The driver is sometimes required to notify the device after
> >>>> +making changes to the virtqueue.
> >>>> +  
> >>>
> >>> I don't like sometimes. I would prefer something like
> >>> 'Under certain circumstances the driver is required issue
> >>> a virtqueue notification to the device.  
> >>
> >>
> >> Under certain circumstances just says sometimes in 3 words.
> >> Can't we find a way to say it that does not bump the word count x3?
> > 
> > What's wrong with "Sometimes, the driver is required to issue..."?
> > 
> 
> No biggie, but 
> sometimes: Occasionally, rather than all of the time. 
> (https://en.oxforddictionaries.com/definition/sometimes)
> Based on dictionary definitons and on my intuition it occurs
> to me that 'sometimes' has a temporal aspect.
> 
> AFAIR the device can disable these notifications altogether
> and happily poll the ring (that is avail or descriptor ring
> depending on packed). 'Sometimes' would then stand for 'never'
> as the 'certain circumstances' never occur.
> 
> But it ain't a big deal really.
> 
> >>
> >>> The method is transport
> >>> defined.'  
> >>
> >> That's good to add.
> > 
> > Agreed.
> > 
> >>
> >>>> +When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> >>>> +this notification involves sending the
> >>>> +virtqueue number to the device (method depending on the transport).  
> >>>
> >>> I don't like 'involves' here. I think it's supposed to tell
> >>> us that notification is a vitqueue level operation. Moreover
> >>> the point is  when VIRTIO_F_NOTIFICATION_DATA has not been negotiated
> >>> it's a virtueue notification and nothing more.
> > 
> > What about
> > 
> > "When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver
> > notifies the device about the affected virtqueue only."
> > 
> > ?
> 
> I like it.
> 
> > 
> >>>   
> >>>> +
> >>>> +However, some devices benefit from the ability to find out the number of
> >>>> +available descriptors in the ring without accessing the virtqueue in memory:  
> >>>
> >>> What is 'the ring'? (probably descriptor ring or available ring depending
> >>> on what do we have)  
> >>
> >> Maybe buffers in the virtqueue?
> > 
> > Works for me.
> > 
> 
> Hm. I'm not sure it brings us nearer to the truth. AFAIU for non-packed
> this would work like charm since the 'ring' is the available ring. So
> we have one available ring entry for a buffer (that is a descriptor
> chain/scatter-gather list). OTOH for packed we have one entry per descriptor
> and not per descriptor chain (that is buffer/scatter-gather list).
> So AFAIU if we just stared (virtqueue empty) and want to send a notification
> after making one buffer consisting of three elements an not using indirect
> decriptors (that is three chained descriptors in the descriptor table or
> descriptor ring) for non packed we want to send offset 1 and for packed
> offset 3. So for packed 'buffers in virtqueue' seems to be a poor fit.
> 
> I think a more generic wording not using 'number of descriptors' and
> 'the ring' would probably be a better match. But I've failed to find
> a better wording so I'm fine with whatever you decide, because we have
> it spelled out properly a couple of lines later.
> 

... to find out about available buffers in the virtqueue ... ?

> >>
> >>>> +for efficiency or as a debugging aid.
> >>>> +
> >>>> +To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
> >>>> +has been negotiated, driver notifications to the device include
> >>>> +the following information:
> >>>> +
> >>>> +\begin{description}
> >>>> +\item [VQ number]
> >>>> +\item [Offset]
> >>>> +      Within the ring where the next available ring entry
> >>>> +      will be written.
> >>>> +      Without VIRTIO_F_RING_PACKED this refers to the
> >>>> +      15 least significant bits of the available index.
> >>>> +      With VIRTIO_F_RING_PACKED this refers to the offset
> >>>> +      (in units of descriptor entries)  
> >>>
> >>> What does '(in units of descriptor entries)' mean?  
> >>
> >> That it's not an address in bytes.
> >> Offset is a distance right?
> >> Within ring implies from start of ring.
> >> What is left is to tell what are the units.
> >>
> >>> Is it a
> >>> mod ring size index?  
> >>
> >> I don't see how specifying units can be taken
> >> to mean it's modulo some value :(
> 
> The semantic of virtq_avail.idx (aka available index) is defined
> as: "idx field indicates where the driver would put the next descriptor
> entry in the ring (modulo the queue size). This starts at 0, and increases."
> Here 'ring' is virtq_avail.ring and not the descriptor table and
> 'next descriptor' actually means it's index in the descriptor
> table. This is where my modulo cam from.

Well that's a good reason not to say index since we used
modulo with an index in one place and people might assume
it's a modulo in another place, isn't it?

> >>
> >>> If it is, why not call it index consequently
> >>> (instead of this offset-index-offset thing)?  
> >>
> >> In fact index in many places is *not* mod ring size.
> >> For me offset means where it is.
> 
> My point was that we seem to use 'offset' for offset in bytes
> (search for 'offset' in the current spec:
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html),
> while we seem to use idx and index for denoting what you call
> offset in a ring/table. (E.g. avail.idx, used.idx descriptor table index).

So for an index you need to do modulo in other places, and I
was concerned people would this it's necessary here too.
I did not find a way to say "do not do modulo" but
specifying alternative units for an offset seemed natural.

> >> Just need to specify
> >> the units.
> 
> I find this 'descriptor entry' a bit unfortunate. If you search the spec
> for 'descriptor entry' you will get the wrong stuff. Maybe 'ring elements'
> or 'ring entries' is an alternative. We also have a precedence for
> spelling out 'not in bytes'.

We can be explicit here:

.. in 16-byte descriptor entry units ...

would this address the comment?


> > 
> > I agree, and I think the wording is fine here.
> >
> 
> Overall it ain't too bad. I can live with it. Was an observation.
> 
> Regards,
> Halil

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

