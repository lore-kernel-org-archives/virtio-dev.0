Return-Path: virtio-return-2982-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
 <1519860484-7936-15-git-send-email-mst@redhat.com>
 <20180307121158.34829f6b.cohuck@redhat.com>
 <20180307155530-mutt-send-email-mst@kernel.org>
 <20180307154941.06a27742.cohuck@redhat.com>
 <1ad91690-7096-7826-3fe7-93330bc7d2a5@linux.vnet.ibm.com>
 <20180307171427.3eb8efc6.cohuck@redhat.com>
 <20180307214210-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 8 Mar 2018 14:03:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180307214210-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8f459bb6-6520-46ac-e858-34ae457ac314@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] Re: [PATCH v9 14/16]
 VIRTIO_F_NOTIFICATION_DATA: extra data to devices
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/07/2018 08:53 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 07, 2018 at 05:14:27PM +0100, Cornelia Huck wrote:
>> On Wed, 7 Mar 2018 17:05:24 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 03/07/2018 03:49 PM, Cornelia Huck wrote:
>>>>>>> +When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>>>>>>> +the driver notifies the device by writing the following
>>>>>>> +32-bit value to the Queue Notify address:
>>>>>>> +\begin{lstlisting}
>>>>>>> +le32 vqn : 16,
>>>>>>> +     next_off : 15,
>>>>>>> +     next_wrap : 1;    
>>>>>> Don't we want to write this as
>>>>>>
>>>>>> le32 vqn : 16;
>>>>>> le32 next_off :15;
>>>>>> le32 next_wrap : 1;
>>>>>>
>>>>>> ?    
>>>>> Same thing in C, but would be more confusing IMHO since it will be up to
>>>>> the reader to figure out which fields comprise the 32 bit integer.  
>>>> It looked weird to me. Other opinions?
>>>>   
>>>

[..]

>>
>> I'm not sure we should go down the C standard rabbit hole. People have
>> gotten lost in there.
> 
> +1
> In particular virtio already uses C-like syntax for structure
> without regard to what the C standard says. It's just pseudo-code,
> nothing to be hang about.

I'm not the one who started talking abut C (I mean the sentence
'Same thing in C...'). Sadly I did get confused into thinking this
is a syntactic construct borrowed form C along with it's semantic.

I've realized my mistake later.

In that light Connie's proposal does not make sense to me, because
with the semantic we defined in 1.4 Structure Specifications what
Connie wrote is something completely different: The whole thing gets
12 byte instead of 4 (assuming that leftovers are permitted and kind
of reserved for future use -- it ain't really specified if be16 a:16:, b:15;
is legit nor what it means).

> 
>> If the clarification of what we mean by this notation (patch 1 + the
>> update sent later) is not enough,
> 
> Halil, can you pls say whether it's enough?
> 

I think the notation is confusing. It looks like C, it compiles
when put in a struct, but has different semantic. You have a note
for that in 1.4 Structure Specifications, and that's great, but looking
at the construct where it's used, it is too easy to jump on the C train.

I think I would prefer a notation less similar to C bit-fields
to avoid confusion.

I think the definition in  '1.4 Structure Specifications' is
kind of OK but I can't say if it is waterproof or not. One thing is
sure however: the definition lacks a formal definition of the (phrase) syntax
and solely relies on the example for that purpose. So without the example,
there is no definition.

Another thing is the semantic of the fields. I guess those are to be
considered unsigned integers of the specified width with the next in
significance relationship on the bits preserved.

>> I'd rather prefer us to add a
>> clarifying sentence/diagram/... there. I was mainly bothered by the
>> change to the definition in this patch...
> 
> Here's what we are trying to say (for example):
> 
> 	+the value A stored in the low 15 bit of a 16 bit
> 	+integer and the value B stored in the high bit of the 16 bit
> 	+integer, the integer in turn using the big-endian byte order.
> 
> Thus we can write:
> 
> be16 A : 15,
>      B : 1;
> 
> which maps to:
> 
> be -> big endian
> 16 -> 16 bit integer
> 
> A : 15 - low 15 bits
> B : 1 - following 1 bit
> 
> Why not repeat be16 twice? Well first of all why repeat information
> twice? Second this notation lets us list many integer fields
> as we might have in the structure:
> 
> be16 A : 15,
>      B : 1;
> be16 C;
> 

Yeah, I understood this in a meanwhile.

> And it also ties to the existing notation for full integers.
> 
> Any suggestions on how to do it better?

I will have to think about this. Especially if we all agree that
the current notation is not good enough.

One stray idea was something like

be32 (A:16;B:15;C:1);

With 
* A occupying bits 0-15
* B occupying bits 16-30
* C occupying bit 30

And bit n of B (n \in [0..15] being the n-16-th bit of the be32
subdivided into fields.

The idea behind () is that it ain't unusual for tuples, and
also the most common grouping semantic is fitting in a sense
that all the fields are together the be32. The separation by
semicolon is to make it obvious that this has nothing to do
with C and that it's not intended to be implemented with C
bit-fields.

> Please provide an example based on the above.
> 


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

