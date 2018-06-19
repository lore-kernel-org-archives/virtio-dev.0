Return-Path: virtio-dev-return-4422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 40A335818CC0
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 03:47:03 -0700 (PDT)
References: <20180611075640.19751-1-tiwei.bie@intel.com>
 <2eb17c91-9158-c14f-e582-223dd6e5c6d2@linux.ibm.com>
 <20180615151329-mutt-send-email-mst@kernel.org>
 <545e8649-8029-d135-e927-3ad11f4eb29d@linux.ibm.com>
 <20180615154837-mutt-send-email-mst@kernel.org>
 <cf3ea375-5b01-0222-166d-7ec837ffc205@linux.ibm.com>
 <20180615183657-mutt-send-email-mst@kernel.org>
 <f5d6d437-44a1-3421-cbad-10281c446b56@linux.ibm.com>
 <20180618191934-mutt-send-email-mst@kernel.org>
 <20180619091418.GA3813@debian>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 19 Jun 2018 12:46:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180619091418.GA3813@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <634ac848-b9e5-866a-7e22-50ab8dcdae73@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3] content: enhance device requirements for
 feature bits
To: Tiwei Bie <tiwei.bie@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/19/2018 11:14 AM, Tiwei Bie wrote:
> On Mon, Jun 18, 2018 at 07:28:33PM +0300, Michael S. Tsirkin wrote:
[..]
>>>
>>> (11) The VIRTIO specification is a bit vague about how a reset is
>>> supposed to be handled by the guest, but it certainly does not prohibit
>>> the negotiated features from changing after reset. Here I will quote two
>>> fragments that hint this is actually something foreseen by the VIRTIO
>>> standard:
>>>   * 'During device initialization, the driver reads this and tells the
>>>      device the subset that it accepts.  The only way to renegotiate is to
>>>      reset the device.'
>>>   * 'If the driver sets the FAILED bit, the driver MUST later reset the
>>>      device before attempting to re-initialize.' If re-initialize is in a
>>>      sense of '3.1.1 Driver Requirements: Device Initialization' then full
>>>      feature negotiation seems to be compulsory.  Linux does not do this. But
>>>      since setting up queues seems to be a part of the 3.1.1 initialization
>>>      sequence (even if formulated somewhat vague), my best guess after reset
>>>      the driver is not supposed to perform 3.1.1 to the letter.
>>
>> I think frankly if we want dynamic features we should work on
>> a mechanism that allows changing them without a system reset.
>>

@Michael
I was talking abut normal virtio reset in (11). I think in Linux we
have dynamic features without system reset today if a virtio device driver
that is loaded as module gets replaced (e.g. rmmod/insmod new) with a more
capable implementation of the same device driver.  

>> And I think the use-case that triggered this is the SRIOV feature,
>> take a look at how that is handled across e.g. suspend/resume.
>>
>>>
>>> (12) If I were to hibernate my PC and then, let's say replace my NIC with
>>> a different model, the hardware does not change assumption would not hold
>>> for a non-virtualized system either. I'm not sure this problem is ours to
>>> solve.
>>
>> Precisely and since we can't solve it, we warn people not to
>> create this kind of configuration unless they know exactly what they
>> are doing.

@Michael
I assume the various bus specifications don't bother to spell this out,
and I doubt manuals of HW components do either.

If our main goal is to warn the end user to not fiddle with the features
of a hibernated VM (e.g. via libvirt domain xml), and hint that if the guest
is going to get hibernated, he should better configure guest as migratable
even if it's not (e.g. machine type, cpu model should not be moving target)
I doubt the VIRTIO spec is the right place.

IMHO neither QEMU nor KVM can detect the condition in question, and I don't
think higher level management software can help either. That's why I say
end-user.

Hibernate is IMHO an OS concept, and I guess some OSes don't have the concept of
hibernate. I see support for hibernate out of scope for the VIRTIO spec (much like
migration). But since the VIRTIO spec is supposed to be helpful above all, I'm
not opposed to a note that spells the warning out.

I still oppose a device normative, as this does not seem to be something an
implementer of the device should heed. And if we do want to place a note,
it needs to be more direct. I could not figure out what is this about. I doubt
end-users have better chances to.

>>
>>> My conclusion is the following. I think constraining feature changes
>>> after system_reset is a bad idea. For 'normal' virtio reset some
>>> clarifications would be welcome, but this one does not seem to be a very
>>> good one. Regarding changing features, I think we are good enough with
>>> what we have today (both standard and implementation). However if we want
>>> to prohibit the features from changing after a reset in spite of my
>>> arguments presented here, IMHO we need a driver normative statement too.
>>>
>>> Regards,
>>> Halil
>>
>> Well the motion passed with 1 abstain and 5 in favor.  Tiwei was the one
>> who proposed it so as I already did this in the past, I'll wait a day or
>> two for him to respond and let us know whether he'd like to drop the
>> patch, but in absence of such a response I'll have to push the proposed
>> wording.
>> In that case you will need to put in a motion to revert, or make some
>> other change on top.
>>

@Michael
If I can not convince you, nor at least some of the committee people here
I'm not willing to escalate this as a motion to revert. There is no point,
as I'm running out of arguments. While I'm still not convinced that this
is the way to go, I'm willing to bow my head in front of the opinion of
the majority. It is not like including this would have tragic consequences.
I think mustered a fair effort to form an opinion and defend it. Thus
there is no shame in admitting defeat.


> 
> If it would be better to drop this patch,
> I'm fine with dropping it. Thanks!
> 

@Tiwei Bie
Thanks for your flexibility! What is your opinion (after considering the
arguments from my previous mail), is it better to include this patch in the spec or
is it better to drop it? Were you able to identify mistakes in my reasoning
(I mean points (1)-(12))?

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

