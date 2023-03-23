Return-Path: <virtio-dev-return-11748-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8631EC6FD1C
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:58:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C40A22AD6E
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:58:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB50E98646A
	for <virtio-dev@archiver.kernel.org>; Thu, 23 Mar 2023 03:58:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA376983DE2; Thu, 23 Mar 2023 03:58:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90912986455;
	Thu, 23 Mar 2023 03:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VeSxM1-_1679543924;
Message-ID: <57e1cc23-ad1e-2105-20cc-35f2130dd9d0@linux.alibaba.com>
Date: Thu, 23 Mar 2023 11:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230320111840.64039-1-hengqi@linux.alibaba.com>
 <20230320144625-mutt-send-email-mst@kernel.org>
 <3a1969e7-2c4d-b64e-33b2-57311d73fb45@linux.alibaba.com>
 <20230321032921-mutt-send-email-mst@kernel.org>
 <b7e44ed9-ef85-bc89-b146-dc35f1af574e@linux.alibaba.com>
 <20230321115516-mutt-send-email-mst@kernel.org>
 <90da02fb-ab7f-6c53-fc46-aadc22564539@linux.alibaba.com>
 <20230322124010-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B877D417412CF94145E7DC879@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481B877D417412CF94145E7DC879@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash



在 2023/3/23 上午11:13, Parav Pandit 写道:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, March 22, 2023 12:42 PM
>   
>> Yes. But my point is this. Some flows can be IPv4 others IPv6.
>> Do you see a way to have a key that will result in a symmetrical hash for both
>> IPv4 and IPv6? Can you give an example please?
>>
> Heng,
>
> Is that the requirement to have two completely different flows (ipv, ipv6) to steer to a single RQ?

Michael should be talking about whether there is a symmetric key that 
can serve both IPv4 and IPv6, so that they can respectively achieve the 
purpose of symmetric hashing.
I am not an expert in hashing, but this article [1] deduces a symmetric 
hash key, and I think it should be possible to deduce a specific key to 
meet this requirement.

Or we should support XOR hashing.

Thanks.

> The requirement, what I understood, is between two directions for a flow to result in a single hash value.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

