Return-Path: <virtio-dev-return-14267-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F6EC47258
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 02:44:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0CCE62ACA8
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 02:44:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 042279867E3
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 02:44:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB5289867D0; Wed, 24 Jan 2024 02:44:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D735E9867D2;
	Wed, 24 Jan 2024 02:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.EQG0T_1706064233;
Message-ID: <323575e1-339b-4c13-92df-c552c0858fb0@linux.alibaba.com>
Date: Wed, 24 Jan 2024 10:43:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240122022002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AB6AAB87DEDC345B1A0EDC742@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240123020653-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240123020653-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE:
 [virtio-comment] [PATCH v2] virtio-net: support setting coalescing params for
 multiple vqs



在 2024/1/23 下午3:15, Michael S. Tsirkin 写道:
> On Tue, Jan 23, 2024 at 05:55:02AM +0000, Parav Pandit wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, January 22, 2024 1:06 PM
>>>
>>> On Mon, Jan 22, 2024 at 05:03:38AM +0000, Parav Pandit wrote:
>>>>>>>> The right test on Linux to do without rtnl lock which is anyway
>>>>>>>> ugly and
>>>>>>> wrong semantic to use blocking the whole netdev stack.
>>>>>>>> (in case if you used that).
>>>>>>> Do you have any good directions and attempts to remove rtnl_lock?
>>>>>>>
>>>>>> I think per device lock instead of rtnl is first step that we can start with.
>>>> Wil check internally who if someone already started working on it.
>>> I feel the issue is at the conceptual level.
>> Not for requests which are initiated by the kernel stack (non user initiated).
> So how is this different? Is it basically just because
> tweaking coalescing in unexpected ways is considered mostly
> harmless?

DIM sends configurations frequently, which is try best.

>
>>> Yes some drivers will take a command
>>> and just queue it for execution later, but this means that errors can not be
>>> propagated back at all. Imagine device with mac
>>> 0x123 in promisc mode. Now commands:
>>>
>>> 1- program MAC 0xabcdef
>>> 2- disable promisc mode
>>>
>> User initiated commands error can be propagated when the command completes.
>> Enqueuing command is at the different bottom level in the driver.
>>
>>> If command 1 fails but 2 proceeds then packets with MAC 0xabc will be
>>> dropped.
>>>
>>> Any attempts to batch arbitrary commands will have this issue - be it at driver
>>> or device level.
>>>
>> There is no suggestion to batch arbitrary commands from the driver side.
>> The suggestion is to batch VQs notification coalescing from the driver side.
>>
>>> So, here's my question: what exactly is the guest behaviour that is driving this
>>> work? Is it with a linux guest?
>> At least looks to me yes based on the partial patches which are taking rtnl lock on netdim's worker callbacks.
>>
>>> which commands does userspace issue that we
>>> need to send multiple vq coalescing commands?
>> None.
>>
>>>   If all you want is to send
>>> same config to all VQs then why not just use
>>> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as opposed to
>>> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET ?
>> Only kernel stack initiated VQ notification coalescing changes.
>> Since every VQ has different values, VIRTIO_NET_CTRL_NOTF_COAL_RX_SET is not sufficient.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

