Return-Path: virtio-dev-return-4785-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3FA0985C1F
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Aug 2018 06:56:43 +0000 (UTC)
References: <f9a2a8b4-440a-cdb7-87c3-0b2ea7a66c90@kernkonzept.com>
 <09a45081-54e3-a55c-1f14-36893bdc663b@redhat.com>
 <88724ffb-1548-ed50-ea4c-b612fa056d09@kernkonzept.com>
 <FF7FC980937D6342B9D289F5F3C7C2625B713CF1@SHSMSX103.ccr.corp.intel.com>
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Message-ID: <99f2c075-a4ee-77a2-b9a6-f8b91541fe33@kernkonzept.com>
Date: Thu, 16 Aug 2018 08:56:40 +0200
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B713CF1@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Clarifications for the new DISCARD and WRITE ZEROES
 commands
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/16/2018 02:25 AM, Liu, Changpeng wrote:
> The latest patch set for adding DISCARD and WRITE ZEROES to virtio-blk locates here, 
> https://lists.linuxfoundation.org/pipermail/virtualization/2018-June/038299.html

Wonderful, thanks!

Jakub

> 
> 
> 
>> -----Original Message-----
>> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On
>> Behalf Of Jakub Jermar
>> Sent: Thursday, August 16, 2018 5:33 AM
>> To: virtio-dev@lists.oasis-open.org
>> Subject: Re: [virtio-dev] Clarifications for the new DISCARD and WRITE ZEROES
>> commands
>>
>> On 08/15/2018 05:47 PM, Paolo Bonzini wrote:
>>> On 15/08/2018 17:12, Jakub Jermar wrote:
>>>> In the absence of such a conforming patch, I would kindly ask someone to
>>>> clarify the relationship between the virtio_blk_discard_write_zeroes
>>>> structures and the virtio descriptor. [1] seems to indicate that there
>>>> is always one struct virtio_blk_discard_write_zeroes per descriptor, but
>>>> the wording is not very clear. If the containing descriptor must be a
>>>> multiple of 512 in size (because of u8 data[][512]),
>>>
>>> The descriptors are intended to be a multiple of 16 bytes in size for
>>> discard and write zeroes.
>>>
>>> In fact, even for reads/writes the descriptors are a multiple of the
>>> logical block size, not of 512.  That ought to be corrected as well.
>>>
>>>> there is no way to
>>>> figure out how many of these structs it contains. So there must be only
>>>> one and the only way to add a segment is to chain descriptors.
>>>
>>> No, it does not matter how descriptors are chained.  Data is always
>>> treated as if it was just one descriptor.
>>>
>>>> Unless
>>>> the descriptor size is somehow allowed to be a multiple of sizeof(struct
>>>> virtio_blk_discard_write_zeroes) in which case it could be determined
>>>> and there may be several of these structures per descriptor.
>>>>
>>>> Also, why is it that there is discard_sector_alignment but no
>>>> write_zeroes_sector_alignment?
>>>
>>> You can use discard_zeroes_alignment too if unmap=1 in the descriptor's
>>> flags.  If unmap=0, it doesn't matter.
>>
>> Thank you, that was quite helpful.
>>
>> Jakub
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

