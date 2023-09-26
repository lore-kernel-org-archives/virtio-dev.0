Return-Path: <virtio-dev-return-13955-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A536EE8181D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:37:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E240E613F8
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:37:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC9AE986422
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 05:37:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C9A35983DE3; Tue, 26 Sep 2023 05:37:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B749298639D;
	Tue, 26 Sep 2023 05:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378768660"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="378768660"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922292137"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922292137"
Message-ID: <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
Date: Tue, 26 Sep 2023 13:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/26/2023 11:40 AM, Parav Pandit wrote:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Tuesday, September 26, 2023 8:16 AM
>>
>> On Mon, Sep 25, 2023 at 6:41 PM Parav Pandit <parav@nvidia.com> wrote:
>>>
>>>
>>>> From: Jason Wang <jasowang@redhat.com>
>>>> Sent: Friday, September 22, 2023 8:38 AM
>>>>> Device context has no overlap.
>>>> I can give you one example, e.g debugging.
>>>>
>>> Almost every feature needs debugging. :) So I am omitting it for time
>>> being.
>> Well, I don't think so. We have a lot of handy tools for that (ethtool -d?).
> Sure add something specific for debug and explicitly mention that it is for debug like -d.
> Every feature and functionality needs debug, not specifically device context.
> So add infra for debug. Device migration series is not the vehicle to piggy back on.
>
>>>> 1) define virtqueue state, inflight descriptors in the section of
>>>> basic facility but not under the admin commands
>>> It will be part of the device context such a way that so that one can only read
>> the vq state only instead of full device context.
>>> This will work.
>> I'm not sure what it looks like, but I think they are well decoupled in this series.
>> E.g driver can choose to just read e.g last_avail_idx and report to ethtool or
>> watchdog.
>>
> Once its done it will be visible how it looks like.
> The key is it needs to cover BOTH use cases.
>
>> As I replied in other thread, I see several problems:
>>
>> 1) layer violation, PCI specific state were mixed into the basic facilities
> After agreeing to see merged donctext, now you are hinting that you don’t agree to merge two.
> I disagree if you are leaning towards that direction.
> I hope my deduction from your above comment is incorrect.
>
> There is no violation. PCI specific device context will be captured in PCI specific section.
> Device type contexts will be captured in those device type sections.
>
> TLVs will cover many of the device context information.
>
>> 2) I don't see a good definition on "device context"
>> 3) TLV works fine for queue but not registers
>>
> Please definition of device context in [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00064.html
>
>> What needs to be done first is to describe what device context means and what
>> it contains. Not the actual data structure since it may vary.
>>
> Sure, it is already defined in device migration theory of operation section in [2].
> I will try to take it out and put in device management section, so that device migration can refer to it and
> Some other basic facility also can refer to it (which must need to explain a use case beyond silly debug point).
>
> [2] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00062.html
>
>>>> 3) define transport specific interfaces or admin commands to access
>>>> them
>>>>
>>> As you also envisioned, it is done using admin commands to access it.
>> That's fine, but it should allow other ways.
>>
> For passthrough admin commands fits the design.
> Sure, you need to draft it how to do other ways..
>   > >
>>>> Does this work? It seems you refused such steps in the past.
>>>>
>>> I didn’t.
>>> There must be some confusion in many emails we both exchanged, because
>> already posted v0 has it split such as device context.
>>> For dirty page tracking I couldn’t find a solid use case without device
>> migration, so I asked which you already replied above.
>>
>> First, you never explain why such coupling gives us any benefit.
> It is not coupled. Device migration uses this facility. So it is matter of text organization in the spec.
> Not the design.
>
>> Second, I've given you sufficient examples but you tend to ignore them. Why
>> not go through Qemu codes then you will see the answer.
> You gave example of debug, and profiling. You didn’t explain the use case of how to actually connect and how to profile etc.
>
>>>> Actually, I would like to leave 2) as it's very complicated which
>>>> might not converge easily.
>>>>
>>> I will split current "device migration" section to two.
>>> 1. device management
>>> 2. device migration
>>>
>>> Device management covers device mode, device context and dirty page
>> tracking.
>>
>> I don't see any connection between "management" and "device context".
>>
> You have better name than device management?
> May be device operation.
> May be it is just better to have the device context just the way it is in [1] under basic facility.
>   
>>> Device migration refers to device management section.
>>>
>>> We can omit the dirty page tracking commands for a moment and first close
>> on the device mode and device context as first step.
>>> Since it is already part of v0 and it is needed, I will keep it in subsequent v1 but
>> moved to device management section.
>>
>> Could you please answer what's wrong with the first 4 patches in this series?
>>
> 1. cover letter is missing the problem statement and use case
I only reply to this section of comments, this does not mean I agree 
with you on your other statements, Instead I agree with
Jason on his replies to you.

In my cover letter:
"The main usecase of these new facilities is Live Migration."

Did you miss it?
> 2. why queue suspend and both device suspend are introduced, only one should be there. The design description is missing.
there are no queue suspend, they are device suspend and vq state 
accessors. please read the patch if you want to comment.
> 3. Even though it claims under some random basic facility, cover letter clearly states the main use case is "live migration".
it is not random, they are precisely defined virtio basic facilities.
> 4. Patch 4 is not needed at all. When device is suspended, it is _suspended_. It does not do any bifurcation.
The device should not accept vq reset and the driver should reset vqs, 
please read previous discussions with MST
and please don't ignore the conclusions
> 5. only suspend bit of patch2 is not enough to cover P2P. One needs suspend and freeze both covered in series [1].
we have discussed this for many times, P2P is out of virtio spec, do you 
want to mediate every PCI state/functionality?
> 6. Finally the whole description of 1 to 4 need to be split in the device operation, so that both passthrough and medication can utilize it using admin cmd and otherwise.
Do you see any reasons this solution can not be used for passthrough and 
mediation?
Or does features_OK work for passthrough or mediation? Any difference?
> Since Zhu, told that dirty tracking and inflight descriptors will be done, I presume he will propose to do over admin q or command interface.
> And since all can run over the admin commands, the plumbing done in 1 to 4 can be made using admin commands.
No
>
> Until now we could not establish creating yet another DMA interface that is better than q interface.
> So ...
> To me both the methods will start looking more converged to me over admin command and queues.
I don't think so, again, we are introducing basic facilities and these 
facilities don't
depend on or rely on admin vq.
>
> Passthrough will use them over owner device.
> Mediation somehow need to do over member device.
> Mediation will not use any device suspend command because it needs to keep bisecting everything.
please read QEMU vhost live migration solution


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

