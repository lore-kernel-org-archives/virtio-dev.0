Return-Path: <virtio-dev-return-13929-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1599E7D0C3
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 02:40:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DC132AC46
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 02:40:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 019879866B7
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 02:40:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E86459866A3; Fri, 22 Sep 2023 02:40:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D501498669D;
	Fri, 22 Sep 2023 02:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444829015"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444829015"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890636094"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="890636094"
Message-ID: <396346a5-4562-e89d-edc0-24945e4f437e@intel.com>
Date: Fri, 22 Sep 2023 10:40:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
References: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e8d00e8c-fe32-83fc-fd13-edf3458b8c33@intel.com>
 <PH0PR12MB548188F479E7D7FF56845F39DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c1afd674-28bb-d8d4-7eee-ab1916a3f947@intel.com>
 <PH0PR12MB5481D2B821CBDD72823B2620DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB5481D2B821CBDD72823B2620DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/21/2023 7:28 PM, Parav Pandit wrote:
>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>> Sent: Thursday, September 21, 2023 3:25 PM
>>
>> On 9/21/2023 5:26 PM, Parav Pandit wrote:
>>>> From: Zhu, Lingshan <lingshan.zhu@intel.com>
>>>> Sent: Thursday, September 21, 2023 2:49 PM TDISP devices can not be
>>>> migrated for now, and the TDISP spec make clear examples of attacking
>>>> models, your admin vq LM on the PF exactly match the model.
>>> I gave hint yesterday to you to consult Ravi at Intel who showed TDISP
>> migration using a dedicated TVM using similar mechanism as admin command.
>>> But you sadly ignored...
>>>
>>> So let me make another attempt to explain,
>>>
>>> When in future TDISP device migration to be supported, the admin command
>> will be done through a dedicated PF or a VF that resides in another trust
>> domain, for example another TVM.
>>> Such admin virtio device will not be located in the hypervisor.
>>> Thereby, it will be secure.
>>> The admin commands pave the road to make this happen. Only thing changes
>> is delegation of admin commands to another admin device instead of a PF.
>> if you plan to do it in future, then lets discuss in the future.
>>
>> And TDISP can be migrated in future does not mean admin vq LM is secure, I
>> have repeated for so many times of the attacking model. and I will not repeat
>> again.
>>> There are other solutions too that will arise.
>>> I have seen another one too, may be DPU.
>>>
>>> In all the 2 approaches, TDISP is migratable and spec will evolve as multiple
>> vendors including Intel, AMD and others showed the path towards it without
>> mediation.
>>> Virtio will be able to leverage that as well using admin commands.
>>>
>>> I want to emphasize again, do not keep repeating AQ in your comments.
>>> It is admin commands in proposal [1].
>> we are discussing LM, right? Can TDISP help you here? TDISP spec gives
>> examples of attacking models, and your admin vq matches it, I gave you quote
>> of the spec yesterday.
>>
>> This thread is about live migration anyway, not TDISP.
>>> As Michael also requested, I kindly request to co-operate on doing join
>> technical work, shared ideas, knowledge and improve the spec.
>>> [1]
>>> https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@n
>>> vidia.com/T/#mf15b68617f772770c6bf79f70e8ddc6fea834cfa
>> see other threads, I propose to reuse the basic facilities of live migration in
>> admin vq.
> I don’t see a point in repeating anything anymore with your constant repetitions and ignorance to ideas.
>
> I am happy to collaborate to driver virtio spec when you can give thoughts with an open mind to address two use cases to converge and discuss.
>
> 1. virtio device migration using mediation approach
As Jason and I have told you many times, basic and fundamental of 
virtualization is trap and emulate,
and this series work for trap and emulate.

And for mediation, do you see any troubles?

Can't vDPA migrate devices by this solution?
> 2. virtio member passthrough device migration
if you want, you can build admin vq LM on the basic facilities. But 
still admin vq LM will not work for nested.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

