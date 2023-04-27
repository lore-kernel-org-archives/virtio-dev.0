Return-Path: <virtio-dev-return-12444-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D32C7618E
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 02:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C28C29FC9
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 02:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0885A9866EE
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 02:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 77D89986642; Thu, 27 Apr 2023 02:20:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0A74986641;
	Thu, 27 Apr 2023 02:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vh5U1-k_1682561983;
Message-ID: <7f486f29-10a6-7625-fef8-3d543f529e4c@linux.alibaba.com>
Date: Thu, 27 Apr 2023 10:19:42 +0800
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
 <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
 <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] RE: [PATCH v13] virtio-net:
 support inner header hash



在 2023/4/26 下午10:24, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, April 26, 2023 10:04 AM
>> Yes, but that seems like a tiny cost, and the cvq command-related structure is
>> much simpler.
> Current structure size is 24 bytes.
> This size becomes multiplier with device count scale to be always available and rarely changes.
>
> As we add new features such device capabilities grow making the multiplier bigger.
> For example
> a. flow steering capabilities (how many flows, what mask, supported protocols, generic options)
> b. hds capabilities
> c. counter capabilities (histogram based, which error counters supported, etc)
> d. which new type of tx vq improvements supported.
> e. hw gro context count supported
>
> May be more..
>
> Depending on the container/VM size certain capabilities may change from device to device.
> Hence it is hard to deduplicate them at device level.

This makes sense. In general, we should be careful about adding things 
to the device space unless the benefit is non-trivial.

Thanks.

>
> Therefore, ability to query them over a non_always_available transport is preferred choice from the device.
>
> A driver may choose to cache it if its being frequently accessed or ask device when needed.
> Even when it's cached by driver, it is coming from the component that doesn’t have transport level timeouts associated with it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

