Return-Path: virtio-return-3074-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-4-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411095018.61b0caed.cohuck@redhat.com>
 <82689e84-227f-38d2-713a-b81ef8e1dc1e@linux.vnet.ibm.com>
 <20180411180052.52616c91.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 13:12:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180411180052.52616c91.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4c3f5299-c745-2ec7-3ecd-9ab7b2dbb667@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [RFC PATCH 3/3] ccw: map common
 notifications terminology to ccw
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/11/2018 06:00 PM, Cornelia Huck wrote:
> On Wed, 11 Apr 2018 15:42:34 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 04/11/2018 09:50 AM, Cornelia Huck wrote:
>>> On Wed, 11 Apr 2018 00:11:27 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>>>> +\item Notifications (via hypercall and virtual interrupts).  
>>>
>>> Why 'virtual' interrupts? Better call this 'I/O interrupts' (includes
>>> both classic and adapter interrupts)?
>>>   
>>
>> The idea was 'hypercall' and 'virtual' should harmonize well. These
>> I/O interrupts are kind of 'real' from the perspective of the virtual
>> machine, but are 'virtual' from the perspective of HW and AR perspective. 
> 
> Yes, but that's an implementation detail. I/O interrupts follow the
> same architecture in any case, there's nothing special about I/O
> interrupts for virtio.
> 

I'm not sure about that. For instance, there is this check your
notifiers unsolicited subchannel associated I/O interruption. I don't
think this is just plain old channel I/O interrupt handling.

>>
>> What I mean, there is AFAIU no way to implement a control unit
>> and device combo in HW attach it to a z box and do virtio over CIO
>> naively.
> 
> It does not seem completely impossible (I/O interrupts are abstractions
> already). The diagnose notification might be a problem, though :)
> 

I don't understand. How would the control unit/device (let's say CU
connected to an FCP feature) sent 'classic' indicators?

>>
>> Even with classic I/O interrupts we have to do set indicator + inject
>> subchannel interrupt to realize a notification. This is however
>> form core perspective one notification/even/interrupt.
> 
> But the I/O interrupt + indicators combination already exits (cf.
> QDIO). I don't think we should single out virtio.
> 

Consider the reader of this spec. QDIO is not PoP material. I don't
think the virtio-ccw (as specified here) can be implemented over it either.
My understanding of QDIO is very limited. With that limited understanding
I would say that there are some similarities, but that is it.

Bottom line is the following. The statement 'A driver receiving a virtio
configuration change notifications corresponds to a (classic) I/O 
interruption for the subchannel corresponding to the  virtio-ccw proxy 
device.' is at best an oversimplification for me. (In fact making a I/O
interrupt pending can be optimized away under certain circumstances.)

That is why I used 'Notifications (via hypercall and virtual interrupts).'
instead of 'Notifications (via hypercall and I/O interrupts)'. IMHO the first
one points the people into the right direction, while remaining blurry
enough, and hinting think virtual (that is not strictly architecture).

AFAIU other transports don't have this 'can not be implemented
natively staying within the present architectural boundaries'.

But you seem bothered by this 'virtual' and I respect that. So how about
'Notifications (via hypercall and a combination of I/O interrupts and
indicator bits).'?

>>
>> So this is why I added this 'virtual' (to hint it may not fit anything
>> one can find in the PoP perfectly).
> 
> I certainly would welcome addition of the adapter interrupt
> architecture to the PoP :)
> 

I've adopted a policy of acting on the assumption that the
company has good reasons for publishing what is published
and keeping unpublished what is not. It would be certainly
easier for me to do my work, if all architecture were public.

>>
>>>> +\end{itemize} 
>>>> +
>>>> +\subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
>>>> +over channel I/O / Basic Concepts/ Channel Commands for Virtio}
>>>> +
>>>>  In addition to the basic channel commands, virtio-ccw defines a
>>>>  set of channel commands related to configuration and operation of
>>>>  virtio:
>>>> @@ -1958,6 +1969,36 @@ virtio:
>>>>  #define CCW_CMD_READ_STATUS 0x72
>>>>  \end{lstlisting}
>>>>  
>>>> +\subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
>>>> +over channel I/O / Basic Concepts/ Notifications}
>>>> +
>>>> +Available buffer notifications are realized as a hypercall. No additional
>>>> +setup by the driver is needed. The operation of available buffer
>>>> +notifications is described in section \ref{sec:Virtio Transport Options /
>>>> +Virtio over channel I/O / Device Operation / Guest->Host Notification}.
>>>> +
>>>> +Used buffer notifications are realized either as so called classic or as
>>>> +adapter interrupts depending on a transport level negotiation. The  
>>>
>>> "as so-called classic or adapter I/O interrupts"?  
>>
>> Valid. These are indeed called 'adapter I/O interrupts' through out
>> this spec. I was i a hurry to write up something demonstrating he idea,
>> so I did not check this. I think these are usually called 'adapter interrupts'
>> (without the I/O in between) elsewhere, but internal integrity is more
>> important.
>>
>> I will take it.
>>
>>>
>>> (I'd really like a reference to I/O interrupts here... especially as
>>> the old, never standardized s390 transport used external interrupts.)
>>>   
>>
>> You mean with the wording you proposed, or something more? If something
>> more could you do a patch on top (later)?
> 
> I think simply adding "I/O" should be enough.
> 

OK.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

