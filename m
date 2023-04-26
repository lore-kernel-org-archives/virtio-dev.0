Return-Path: <virtio-dev-return-12432-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BC4C7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:03:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 155E726A2E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:03:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D1E4986653
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:03:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 02F8A986640; Wed, 26 Apr 2023 14:03:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2D0398663F;
	Wed, 26 Apr 2023 14:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vh3Z.YL_1682517813;
Message-ID: <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
Date: Wed, 26 Apr 2023 22:03:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
 <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support inner header
 hash



在 2023/4/26 下午9:47, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, April 26, 2023 9:43 AM
>>> "With that no need to define two fields at two different places in
>>> config area and also in cvq."
>> I'm not sure if this is sufficiently motivated, RSS also has supports_hash_types
>> in config space.
>>
> There are many fields grown to MMIO config space because 0.9.5 has config space there.
> These are usually one time read or rarely used; hence it doesn’t need to come from this area of the device to be _always_ available.

Yes.

supported_tunnel_hash_types If in cvq, each GET command needs to return 
supported_tunnel_hash_types and hash_tunnel_types,
but users may only need the hash_tunnel_types "SET" by themselves.

>   
>> We don't actually need cvq and config to sync on
>> supported_tunnel_hash_types, since it doesn't need to change (meaning
>> supported_tunnel_hash_types doesn't send configuration change
>> notifications).
>>
> It doesn’t but device is expected to publish the value at two places.

Yes, but that seems like a tiny cost, and the cvq command-related 
structure is much simpler.

>
>>>> +For scenarios with sufficient external entropy or no internal
>>>> hashing requirements, inner header hash may not be needed:
>>>> +A tunnel is often expected to isolate the external network from the
>>>> internal one. By completely ignoring entropy
>>>> +in the external header and replacing it with entropy from the
>>>> internal header, for hash calculations, this expectation
>>> You wanted to say inner here like rest of the places.
>>>
>>> s/internal header/inner header
>> I want to make the 'external' and 'internal' correspond, but avoid the internal
>> header, and use a unified 'inner header' is also reasonable.:)
>>
> Since in rest of other description, we refer to it as "outer", it is better to keep it consistent as outer instead of external here.

Totally agree.

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

