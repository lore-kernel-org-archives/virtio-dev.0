Return-Path: <virtio-dev-return-13038-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C24BEB64DB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 13:42:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A204685095
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 13:42:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9301D986602
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 13:42:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 86B6A9865D1; Thu, 22 Jun 2023 13:42:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72D3D9865D0;
	Thu, 22 Jun 2023 13:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vlj6t0D_1687441359;
Message-ID: <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
Date: Thu, 22 Jun 2023 21:42:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



在 2023/6/22 下午8:32, Parav Pandit 写道:
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Thursday, June 22, 2023 2:23 AM
>>
>> On Wed, Jun 21, 2023 at 08:52:04PM +0000, Parav Pandit wrote:
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Wednesday, June 21, 2023 4:38 PM
>>>>>> And the field is RO so no memory cost to exposing it in all VFs.
>>>>> Two structures do not bring the asymmetry.
>>>>> Accessing current and enabled fields via two different mechanism
>>>>> is bringing
>>>> the asymmetry.
>>>>
>>>> I guess it's a matter of taste, but it is clearly more consistent
>>>> with other hash things, to which it's very similar.
>>>>
>>> This is consistent with new commands we define including notification
>> coalescing whose GET is not coming config space.
>>
>> But there GET just reports the current state. Not the read only capability. So
>> there would be cost per VF to keep it in config space.
>> This one is RO no cost per VF. Let's make it convenient?
>>
> And each VF can have different value hence requires per VF storage in the device.
>   
>>>> Nah, config space is too convenient when we can live with its
>>>> limitations. I don't thin kwe prefer not to keep growing it.
>>>> For some things such as this one it's perfect.
>>>>
>>> Fields are different between different devices.
>> Not sure what's the implication?
> Implication is device needs to store this in always available on-chip memory which is not good.
>
>>>> For example, for migration driver might want to validate that two
>>>> devices have same capability. doing it without dma is nicer.
>>>>
>>> A migration driver for real world scenario, will almost have to use the dma for
>> amount of data it needs to exchange.
>>
>> Not migration itself, provisioning.
>>
> Provisioning driver usually do not attach to the member device directly.
> This requires device reset, followed by reaching _DRIVER stage, querying features etc and config area.
> And unbinding it and second reset by member driver. Ugh.
>
> Provisioning driver also needs to get the state or capabilities even when member driver is already attached.
> So config space is not much a gain either.
>   
>>>> Another example, future admin transport will have ability to
>>>> provision devices by supplying their config space.
>>>> This will include this capability automatically, if instead we hide
>>>> it in a command we need to do extra custom work.
>>>>
>>>>> So we do not prefer to keep growing the config space anymore,
>>>>> hence GET is the right approach to me.
>>>> Heh I know you hate config space. Let it go, stop wasting time
>>>> arguing about the same thing on every turn and instead help define
>>>> admin transport to solve it
>>> This was discussed many times, a driver to have a direct (non-intercepted by
>> owner device) channel to device.
>>> If you mean this non-intercepted channel as admin transport, fine.
>> we can do that, sure.
>>
>>> If you mean this is intercepted and it is going over admin cmd, then it is of no
>> use for all future interfaces.
>>> We discussed this in thread with you and Jason.
>>> I provided concrete example with size and device provisioning math too and
>> other example of multi-physical address VQ.
>>> So transporting register by register over some admin transport is sub-optimal.
>>>
>> Not register by register, we can send all of config space as long as it's RO. This
>> field is.
>>
> It is RO in context of one member device, but every VF can have different value.
> The device will never know if one will use new cmdvq to access or some old driver will use without it.
> And hence, it always needs to provision it on onchip memory for backward compatibility.

Yes, I think we also have to consider upcoming
     1. device counters (e.g. supported_device_counter),
     2. receive flow filters (e.g. supported_flow_types, 
supported_max_entries),
     3. header splits (e.g. supported_split_types) etc.
Continuous expansion of the configuration space needs to be careful.

>
> Instead of decision point being RO vs RW,
> any new fields via cmdvq and existing fields stays in cfg space, give predictable behavior to size the member devices in the system.
> Once the cmdvq is available, we can get rid of GET command used in this version for new future features.
> Till that arrives, GET command is the efficient way.

Yes, I agree.

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

