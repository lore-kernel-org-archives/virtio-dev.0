Return-Path: virtio-return-3041-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
 <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
 <20180328200739-mutt-send-email-mst@kernel.org>
 <20180329110555.708a88b9.cohuck@redhat.com>
 <c5dd1c7e-30e6-119e-d06b-fc8cee0d671c@linux.vnet.ibm.com>
 <20180329171705-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 17:34:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180329171705-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <28a35397-b62a-0c5d-ad77-c8a6f308dd5f@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v12] VIRTIO_F_NOTIFICATION_DATA:
 extra data to devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/29/2018 04:30 PM, Michael S. Tsirkin wrote:
> On Thu, Mar 29, 2018 at 04:15:19PM +0200, Halil Pasic wrote:
>>
[..]
>>
>> I don't have a good solution, otherwise I would have proposed already.
>> Maybe something like 'available notification' and 'used notification' is
>> worth considering. I don't like that one can read available and used
>> as normal English (that is a notification that is available and not
>> a notification that buffers were made available at the given virtqueue).
> 
> I think I like this.
> 
> Available buffer / used buffer notifications?
> 

I will do it!
@Connie: if you have concerns or something even better in mind
please do tell.
[..]

>>>>>> +However, some devices benefit from the ability to find out the number of
>>>>>> +available descriptors in the ring without accessing the virtqueue in memory:  
>>>>>
>>>>> What is 'the ring'? (probably descriptor ring or available ring depending
>>>>> on what do we have)  
>>>>
>>>> Maybe buffers in the virtqueue?
>>>
>>> Works for me.
>>>
>>
>> Hm. I'm not sure it brings us nearer to the truth. AFAIU for non-packed
>> this would work like charm since the 'ring' is the available ring. So
>> we have one available ring entry for a buffer (that is a descriptor
>> chain/scatter-gather list). OTOH for packed we have one entry per descriptor
>> and not per descriptor chain (that is buffer/scatter-gather list).
>> So AFAIU if we just stared (virtqueue empty) and want to send a notification
>> after making one buffer consisting of three elements an not using indirect
>> decriptors (that is three chained descriptors in the descriptor table or
>> descriptor ring) for non packed we want to send offset 1 and for packed
>> offset 3. So for packed 'buffers in virtqueue' seems to be a poor fit.
>>
>> I think a more generic wording not using 'number of descriptors' and
>> 'the ring' would probably be a better match. But I've failed to find
>> a better wording so I'm fine with whatever you decide, because we have
>> it spelled out properly a couple of lines later.
>>
> 
> ... to find out about available buffers in the virtqueue ... ?
> 

I like this. It's intuitive and at the same time vague
enough to be correct. And we will get precise soon enough.

>>>>
>>>>>> +for efficiency or as a debugging aid.
>>>>>> +
>>>>>> +To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
>>>>>> +has been negotiated, driver notifications to the device include
>>>>>> +the following information:
>>>>>> +
>>>>>> +\begin{description}
>>>>>> +\item [VQ number]
>>>>>> +\item [Offset]
>>>>>> +      Within the ring where the next available ring entry
>>>>>> +      will be written.
>>>>>> +      Without VIRTIO_F_RING_PACKED this refers to the
>>>>>> +      15 least significant bits of the available index.
>>>>>> +      With VIRTIO_F_RING_PACKED this refers to the offset
>>>>>> +      (in units of descriptor entries)  
>>>>>
>>>>> What does '(in units of descriptor entries)' mean?  
>>>>
>>>> That it's not an address in bytes.
>>>> Offset is a distance right?
>>>> Within ring implies from start of ring.
>>>> What is left is to tell what are the units.
>>>>
>>>>> Is it a
>>>>> mod ring size index?  
>>>>
>>>> I don't see how specifying units can be taken
>>>> to mean it's modulo some value :(
>>
>> The semantic of virtq_avail.idx (aka available index) is defined
>> as: "idx field indicates where the driver would put the next descriptor
>> entry in the ring (modulo the queue size). This starts at 0, and increases."
>> Here 'ring' is virtq_avail.ring and not the descriptor table and
>> 'next descriptor' actually means it's index in the descriptor
>> table. This is where my modulo cam from.
> 
> Well that's a good reason not to say index since we used
> modulo with an index in one place and people might assume
> it's a modulo in another place, isn't it?
> 

As you have previously stated yourself index is usually
not modulo. But offset is fine too. I was probably over-thinking
this in the first place.

>>>>
>>>>> If it is, why not call it index consequently
>>>>> (instead of this offset-index-offset thing)?  
>>>>
>>>> In fact index in many places is *not* mod ring size.
>>>> For me offset means where it is.
>>
>> My point was that we seem to use 'offset' for offset in bytes
>> (search for 'offset' in the current spec:
>> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html),
>> while we seem to use idx and index for denoting what you call
>> offset in a ring/table. (E.g. avail.idx, used.idx descriptor table index).
> 
> So for an index you need to do modulo in other places, and I
> was concerned people would this it's necessary here too.
> I did not find a way to say "do not do modulo" but
> specifying alternative units for an offset seemed natural.
> 

I'm not sure offset is a good way to express "do not do modulo".  When I
hear offset I think base + offset. The tricky part is what is base (*type
but also value*). If we say base is an iterator corresponding to some
kind of cyclical data structure like a ring or a ringbuffer then it's
reasonable to assume that the iterator is cyclical in respect to the
underlying array. For an example of what I mean by iterator you can have
a look at:
http://www.boost.org/doc/libs/1_61_0/doc/html/circular_buffer.html Please
notice that this circular isn't necessarily exactly 'modulo' and that
index has similar ambiguity. But his is probably over-thinking again.

>>>> Just need to specify
>>>> the units.
>>
>> I find this 'descriptor entry' a bit unfortunate. If you search the spec
>> for 'descriptor entry' you will get the wrong stuff. Maybe 'ring elements'
>> or 'ring entries' is an alternative. We also have a precedence for
>> spelling out 'not in bytes'.
> 
> We can be explicit here:
> 
> .. in 16-byte descriptor entry units ...
> 
> would this address the comment?
> 
> 
As you probably already understand: there is not much of a concern, yet I
wouldn't be completely satisfied with that solution. But I can certainly
live with any of the proposed solutions.

For me the least ambiguous would be something like the: 'With
VIRTIO_F_RING_PACKED the value of Offset is such that the address of the
descriptor area + 16 * Offset is the address where the next available
descriptor (that is the first descriptor of the next chain) will be
written to.' but it's kinda ugly.

Again, I shouldn't have complained abut it in the first place:
it was good enough. Pick whichever solution you deem the best.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

