Return-Path: virtio-return-2920-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <55eb7e9c-97ee-f7d7-10db-190dd844160d@linux.vnet.ibm.com>
 <20180226224109-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 12:53:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180226224109-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a8f6a85a-8bab-d21d-1114-dd1719875a8e@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [PATCH v8 08/16] packed virtqueues: more efficient
 virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

[..]
>> On 02/16/2018 08:24 AM, Michael S. Tsirkin wrote:
>>> Performance analysis of this is in my kvm forum 2016 presentation.  The
>>> idea is to have a r/w descriptor in a ring structure, replacing the used
>>> and available ring, index and descriptor buffer.
>>>
>>> This is also easier for devices to implement than the 1.0 layout.
>>> Several more enhancements will be necessary to actually make this
>>> efficient for devices to use.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  content.tex     |  28 ++-
>>>  packed-ring.tex | 646 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 671 insertions(+), 3 deletions(-)
>>>  create mode 100644 packed-ring.tex
[..]
>>> +
>>> +\subsection{Element Address and Length}
>>> +\label{sec:Packed Virtqueues / Element Address and Length}
>>> +
>>> +In an available descriptor, Element Address corresponds to the
>>> +physical address of the buffer element. The length of the element assumed
>>> +to be physically contigious is stored in Element Length.
>>> +
>>> +In a used descriptor, Element Address is unused. Element Length
>>> +specifies the length of the buffer that has been initialized
>>> +(written to) by the device.
>>> +
>>> +Element length is reserved for used descriptors without the
>>> +VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
>>> +
>>> +\subsection{Scatter-Gather Support}
>>
>> [Consistent wording] Both types of virtqueues support scatter-gather
>> but the term is used only for packed. Maybe we could unify the wording.
>> Or is this something for later?
> 
> I'll take a look but this can be safely done later too.
> 
> 

Agreed.

[..]
>>> +
>>> +\subsection{Multi-buffer requests}
>>> +\label{sec:Packed Virtqueues / Multi-descriptor batches}
>>> +Some devices combine multiple buffers as part of processing of a
>>> +single request.  These devices always mark the first descriptor
>>> +in the request used after the rest of the descriptors in the
>>> +request has been written out into the ring. This guarantees that
>>> +the driver will never observe a partial request in the ring.
>>> +
>>
>> I see you've changed s/in the request available/in the request used/.
>> But I still don't understand this paragraph. I will try to figure
>> it out later (and will come back to you if I fail).
> 
> FYI this applies to mergeable buffers for the network device.
> 
> 

Yeah, was my understanding to, but I will have to look into the
details starting from there. Will come back to you if I can't
clear it up for myself.

[..]
>>> +
>>> +\devicenormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
>>> +A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
>>> +read a device-writable buffer.
>>> +A device MUST NOT use a descriptor unless it observes
>>> +VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
>>
>> I don't really understand this. How does the device observe
>> the VIRTQ_DESC_F_AVAIL bit being changed?
> 
> By reading the descriptor.
> 

:) My point is: to observe a change one usually either needs at
least one reading before and at least one reading after the change,
or one needs to know that a certain reading means change. The latter
is possible if we know that at the beginning of the time frame under
consideration (t_0) only a certain set of values,let's say B like before,
is possible, and after the change only a certain other set of values
let's say A like after, is possible, and A and B are disjunctive (
$A \cap B = \emtyset$).

I guess here the latter is supposed to be the case. But then I think
we need a more detailed description here. Please see also my other email
(response to Jens).

[..]
>>> +Suppression Structure Format}.
>>> +
>>> +\begin{note}
>>> +For optimal performance, a driver MAY disable interrupts while processing
>>> +the used buffers, but beware the problem of missing interrupts between
>>> +emptying the ring and reenabling interrupts.  This is usually handled by
>>> +re-checking for more used buffers after interrups are re-enabled:
>>> +\end{note}
>>> +
>>> +\begin{lstlisting}
>>> +vq->driver_event.flags = 0x2;
>>> +
>>> +for (;;) {
>>> +        struct virtq_desc *d = vq->desc[vq->next_used];
>>> +
>>> +        flags = d->flags;
>>> +        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
>>> +        bool used = flags & (1 << VIRTQ_DESC_F_USED);
>>> +
>>> +        if (avail != used) {
>>
>> I don't understand the condition which is AFAIU supposed to
>> correspond to the descriptor *not* being used.
> 
> So avail == used means used. avail != used means available.
> 

Please see the follow up with Jens.

>>> +                vq->driver_event.flags = 0x1;
>>> +                memory_barrier();
>>> +
>>> +                flags = d->flags;
>>> +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
>>> +                bool used = flags & (1 << VIRTQ_DESC_F_USED);
>>> +                if (avail != used) {
>>> +                        break;
>>> +                }
>>> +
>>> +                vq->driver_event.flags = 0x2;
>>> +        }
>>> +
>>> +	read_memory_barrier();
[..]
>> I'm pretty much confused on how this scheme with the available
>> and used wrap counters (or device and driver wrap counters is
>> supposed to work). A working implementation in C would really help
>> me to understand this.
> 
> DPDK based implementation has been posted.
>

Thank you very much for the hint. Slipped past me unfortunately.

Regards,
Halil
 
>>> +        process_buffer(d);
>>> +        vq->next_used++;
>>> +        if (vq->next_used >= vq->size) {
>>> +                vq->next_used = 0;
>>> +        }
>>> +}
>>> +\end{lstlisting}
>>>
> 
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
> 


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

