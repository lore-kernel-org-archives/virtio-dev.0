Return-Path: <virtio-dev-return-13784-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ABCCD37B4
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 03:10:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 026861CA249
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 03:10:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBD0898640C
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 03:10:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B03A998637D; Mon, 18 Sep 2023 03:10:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97CF598638E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 03:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="376874024"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="376874024"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="919301568"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="919301568"
Message-ID: <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
Date: Mon, 18 Sep 2023 11:10:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



On 9/17/2023 1:32 PM, Parav Pandit wrote:
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
>> Behalf Of Zhu, Lingshan
>> Sent: Friday, September 15, 2023 9:59 AM
>>
>> On 9/14/2023 7:14 PM, Michael S. Tsirkin wrote:
>>> On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
>>>> This series introduces
>>>> 1)a new SUSPEND bit in the device status Which is used to suspend the
>>>> device, so that the device states and virtqueue states are
>>>> stabilized.
>>>>
>>>> 2)virtqueue state and its accessor, to get and set last_avail_idx and
>>>> last_used_idx of virtqueues.
>>>>
>>>> The main usecase of these new facilities is Live Migration.
>>>>
>>>> Future work: dirty page tracking and in-flight descriptors.
>>>> This series addresses many comments from Jason, Stefan and Eugenio
>>>> from RFC series.
>>> Compared to Parav's patchset this is much less functional.
>> we will add dirty page tracking and in-flight IO tracker in V2, then it will be a
>> full featured LM solution.
>>
>> They are not in this series because we want this series to be small and focus.
>>> Assuming that one goes in, can't we add ability to submit admin
>>> commands through MMIO on the device itself and be done with it?
>> I am not sure, IMHO, if we use admin vq as back-ends for MMIO based live
>> migration, then the issues in admin vq still exist, for example:
>> 1)nested virtualization
>> 2)bare-metal live migration
>> 3)QOS
>> 4)introduce more attacking surfaces.
>>
> #4 is just random without.
I failed to process "random without".

If you expect admin vq to perform live migration, it can certainly be a 
side channel attacking surface, for example:
a) a malicious SW can stop the device running
b) a malicious SW can sniff guest memory by tracking guest dirty pages, 
then speculate guest operations and stole secrets.
> #3 There is no QoS issue with admin commands and queues. If you claim that then whole virtio spec based on the virtqueues is broken.
> And it is certainly not the case.
Please do not confuse the concepts and purposes of the data queues and 
admin vq.

For data-queues, it can be slow without mq or rss, that means 
performance overhead, but can work.
For admin vq, if it don't meet QOS requirements, it fails to migrate guests.

I have replied to the same question so many times, and this is the last 
time.
>
>> And what's more, if we wants to implementing a new capability onbehalf of
>> admin vq, does the capability need to store at least one descriptor buffer, that is
>> the capability length should be at least the max_lengh_of_buffer?
>>
>> If that is not possible, do we need to implement extra fields like length and
>> remaining_length, then the device repeating update the cap data, and the
>> driver repeat reading, way to complex and introduce significant downtime.
>>
> At least I do not understand. May be you can explain more?
Just try consider how a MMIO bar cap can fit to max_buffer_size.
>
> We observe less than 300 msec downtime using admin commands over admin queue in internal tests in virtio area.
still QOS


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

