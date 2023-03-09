Return-Path: <virtio-dev-return-11556-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167AC678D5
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 02:58:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8681D2A8FD
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 02:58:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 773679866FF
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 02:58:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 69C4A9866AC; Thu,  9 Mar 2023 02:58:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 533AC9866B3;
	Thu,  9 Mar 2023 02:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdRen5X_1678330711;
Message-ID: <4d8e9d73-fcc7-9944-9180-abd03a31a7ad@linux.alibaba.com>
Date: Thu, 9 Mar 2023 10:58:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <817a8cef-21cf-a010-b21d-050c1328c8a0@linux.alibaba.com>
 <PH0PR12MB5481969B2173A3AB7ABDFB19DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481969B2173A3AB7ABDFB19DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [PATCH v10] virtio-net:
 support the virtqueue coalescing moderation



在 2023/3/9 上午6:30, Parav Pandit 写道:
>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
>> Behalf Of Heng Qi
>> Sent: Thursday, March 2, 2023 10:27 PM
>>
>>> I remember we discussed that instead of mentioning each individual field,
>> better to describe the whole structure being read-only or write-only.
>>
>> Consider the following scenarios:
>> 1. A read-only field of the structure virtio_net_ctrl_coal is extended for
>> CTRL_NOTF_COAL_RX/TX_SET to get some extra information
> A set command cannot extend the struct virtio_net_ctrl_coal, particularly for read-only and partially for write-only.
> This would mean that for the tiny number of bytes, an additional dma descriptor is to be allocated with read/write-only permissions.
> It would be inefficient for the driver to do so for the SET command to have vqn as write-only, reserved as read-only, rest fields as write-only dma attributes.
>
> As I think more, I think the whole set command fields should be read-only for device. Better to describe it this way instead of splitting individual fields.
> This way driver can just do a single DMA allocation with read-only attributes for set cmd.
>
> Get command doesn’t have any choice today the way CVQ is structured to it lives with the limitation.

I think it is reasonable and will be revised in the next version.

>
>>> Looks good, however you have well covered in the device normative
>> statements.
>>> So possibly it can be removed from here.
>> I tend to keep this, as we have done in the past, we can have normative
>> descriptions and the corresponding non-normative descriptions.
>>
> Ok. but please revisit if the description can be simpler text than the normative lines.

Ok.

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

