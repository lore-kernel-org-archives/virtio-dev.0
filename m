Return-Path: virtio-dev-return-4455-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 40FE55819146
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jun 2018 05:11:19 -0700 (PDT)
References: <2eb17c91-9158-c14f-e582-223dd6e5c6d2@linux.ibm.com>
 <20180615151329-mutt-send-email-mst@kernel.org>
 <545e8649-8029-d135-e927-3ad11f4eb29d@linux.ibm.com>
 <20180615154837-mutt-send-email-mst@kernel.org>
 <cf3ea375-5b01-0222-166d-7ec837ffc205@linux.ibm.com>
 <20180615183657-mutt-send-email-mst@kernel.org>
 <f5d6d437-44a1-3421-cbad-10281c446b56@linux.ibm.com>
 <20180618191934-mutt-send-email-mst@kernel.org>
 <20180619091418.GA3813@debian>
 <634ac848-b9e5-866a-7e22-50ab8dcdae73@linux.ibm.com>
 <20180619163059.GA12527@debian>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 20 Jun 2018 14:10:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180619163059.GA12527@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <01eb18cf-cc4f-95d3-f012-c7b104652a0c@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3] content: enhance device requirements for
 feature bits
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/19/2018 06:30 PM, Tiwei Bie wrote:
> On Tue, Jun 19, 2018 at 12:46:45PM +0200, Halil Pasic wrote:
>> On 06/19/2018 11:14 AM, Tiwei Bie wrote:
>>> On Mon, Jun 18, 2018 at 07:28:33PM +0300, Michael S. Tsirkin wrote:
> [...]
>>> If it would be better to drop this patch,
>>> I'm fine with dropping it. Thanks!
>>>
>> @Tiwei Bie
>> Thanks for your flexibility! What is your opinion (after considering the
>> arguments from my previous mail), is it better to include this patch in the spec or
>> is it better to drop it? Were you able to identify mistakes in my reasoning
>> (I mean points (1)-(12))?
>>
> Hi Halil,
> 
> I think maybe you thought too much about this proposal
> (or maybe I really missed something obvious). In my
> opinion, the device requirement proposed by this patch
> is quite simple and straightforward:
> 
> - It's just to make the spec explicitly require that
>    a certain virtio device shouldn't fail re-negotiation
>    of a feature set it has successfully accepted once.
> 
> - It covers the cases of virtio device reset and system
>    reset (which includes normal shutdown and start).
> 
> I think the requirement is reasonable because for a
> certain virtio device, there is no reason that the
> feature bits it offers will change (because it should
> always offer all the features it understands). And we
> are just to add a device normative to make the spec be
> more explicit about that (because if a device really
> changes the features it offers after a device or
> system reset, something will go wrong). If the configs
> of an emulated virtio device are changed, maybe we
> shouldn't treat it as the same device any more, and
> IMO this case is not related to this proposal.

Thanks for clarifying your position. I don't want to
usurp any more of your valuable time. I'm not convinced
but I've given up on hope to convince the opposition.

I'm giving up.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

