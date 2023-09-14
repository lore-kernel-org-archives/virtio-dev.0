Return-Path: <virtio-dev-return-13758-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F3EDE98F
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 08:20:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E78DC2B01A
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 08:20:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3412986649
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 08:20:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9D9D598402B; Thu, 14 Sep 2023 08:20:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6206986639;
	Thu, 14 Sep 2023 08:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="409842931"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="409842931"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747638693"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="747638693"
Message-ID: <a6ad8621-840f-0858-d250-d5ae3415bf9e@intel.com>
Date: Thu, 14 Sep 2023 16:19:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <de9237c0-9088-9f1a-af6c-13d1f2662e82@intel.com>
 <PH0PR12MB54815D2BB18E83B8DAFCFBC3DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82805bc3-f891-a35a-12fd-f4799e28570c@intel.com>
 <PH0PR12MB548180A5F840A34DC4DFE334DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <987f72eb-f82c-da4b-229c-ffc5b60d6fb4@intel.com>
 <PH0PR12MB5481F256CCB58C10DB65A8D1DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0861d9ff-d126-c6e4-0deb-74ca81675eeb@intel.com>
 <PH0PR12MB5481678840AE3B1B2D97D512DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <30bed94a-e99e-1561-def3-719e25a0dd26@intel.com>
 <PH0PR12MB5481687C209231F8C4CE8A1EDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7424d2ae-2366-882f-bd84-04ee5714764b@intel.com>
 <PH0PR12MB5481E322E66419AAC61822ACDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dd40c978-3606-594d-f70e-6ce2c120a693@intel.com>
 <PH0PR12MB5481F21E67549A3F2CE95B9DDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481F21E67549A3F2CE95B9DDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE



On 9/13/2023 12:36 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Wednesday, September 13, 2023 9:51 AM
>
>>> VQ depth defines the VQ's limit.
>> still sounds like limitless and I will stop arguing this as you can see if there is
>> REALLY a queue can be limitless, we even don't need Multi-queue or RSS.
> If you see some value in limitless queue, please add one.
> I have not seen such construct until now and don’t see the need for it.
It is you consider the admin vq is limitless, not me, and I don't agree 
with that.
And I stop arguing this, the point is clear.
>
>>>>>> If you say, that require multiple AQ, then how many should a vendor
>>>> provide?
>>>>> I didn’t say multiple AQs must be used.
>>>>> It is same as NIC RQs.
>>>> don't you agree a single vq has its own performance limitations?
>>> For LM I don’t see the limitation.
>>> The finite limit an AQ has, such limitation is no different than some register
>> write poll with one entry at a time per device.
>> see above, and we are implementing per device facilities.
>>>> In this series, it says:
>>>> +When setting SUSPEND, the driver MUST re-read \field{device status}
>>>> +to
>>>> ensure the SUSPEND bit is set.
>>>>
>>>> And this is nothing to do with scale.
>>> Hence, it is bringing same scale QOS limitation on register too that you claim
>> may be present in the AQ.
>>> And hence, I responded earlier that when most things are not done through
>> BAR, so there is no need to do suspend/resume via BAR either.
>>> And hence the mode setting command of [1] is just fine.
>> The bar registers are almost "triggers"
>>>>> On top of that once the device is SUSPENDED, it cannot accept some
>>>>> other
>>>> RESET_VQ command.
>>>> so as SiWei suggested, there will be a new feature bit introduced in
>>>> V2 for vq reset.
>>> VQ cannot be RESET after the device reset as you wrote.
>> It is device SUSPEND, not reset.
> Suspend means suspend of English language.
> It cannot accept more synchronous commands after that and not supposed to respond.
Please read the series, 2/5 patch describes SUSPEND behaviors.
>
>>>>>>>> It does not reside on the PF to migrate the VFs.
>>>>>>> Hence it does not scale and cannot do parallel operation within
>>>>>>> the VF,
>>>> unless
>>>>>> each register is replicated.
>>>>>> Why its not scale? It is a per device facility.
>>>>> Because the device needs to answer per device through some large
>>>>> scale
>>>> memory to fit in a response time.
>>>> Again, it is a per-device facility, and it is register based serve
>>>> the only one device itself.
>>>> And we do not plan to log the dirty pages in bar.
>>> Hence, there is no reason to wrap suspend resume on the BAR either.
>>> The mode setting admin command is just fine.
>> They are device status bits.
> And it doesn't have to be.
I don't get your comment.
Do you mean there should not be device status bits?
Challenging even DRIVER_OK is unreasonable?
>
>>>>>> Why do you need parallel operation against the LM facility?
>>>>> Because your downtime was 300msec for 1000 VMs.
>>>> the LM facility in this series is per-device, it only severs itself.
>>> And that single threading and single threading per VQ reset via single register
>> wont scale.
>> it is per-device facility, for example, on the VF, not the owner PF.
> And I repeatedly explained you that you never answered, is how such queue can work after device suspend.
> A weird device bifurcation is not supported by pci and not to be done in virtio.
Didn't you find the answer in my comments?

I repeated several times:
1) as described in this series, once SUSPEND, the device should present 
stabilized config space.
2) the device freeze both it's control path and data path. So we don't 
expect any queues functional since when SUSPEND ~ !SUSPEND.
3) but device status still operational because we may need to recover 
from failed LM or cancel the LM process.
4) We will introduce a new feature bit to allow reset vqs after SUSPEND.

Where so you see we expect the queue to work after SUSPEND?

Clear now?
>
>> see above and please feel free to reuse the basic facilities if you like in your AQ
>> LM
> The whole attitude that "We .." and use in "your" LM is just simply wrong.
why wrong?
> Please work towards collaborative design in technical committee.
This is what I am doing now, no? Or why I am talking to you?
> What you want to repeat was already posted, so take some time to review and utilize. If not, describe why it is not useful.
EOM
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

