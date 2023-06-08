Return-Path: <virtio-dev-return-12894-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD26CC7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:29:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 17C702CAD4
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:29:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1167A986681
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:29:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0650E986674; Thu,  8 Jun 2023 15:29:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6885986673;
	Thu,  8 Jun 2023 15:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkegTyW_1686238177;
Message-ID: <0e9403b3-b6ec-bb11-5f12-9ee06100320f@linux.alibaba.com>
Date: Thu, 8 Jun 2023 23:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230608064042.GC28580@h68b04307.sqa.eu95>
 <PH0PR12MB548119AC6E8CF4A5EBCBA4D3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548119AC6E8CF4A5EBCBA4D3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash



在 2023/6/8 下午10:26, Parav Pandit 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Thursday, June 8, 2023 2:41 AM
> [..]
>>>> +The device MUST calculate the inner header hash for the configured
>>>> \field{hash_tunnel_types} without the outer UDP header if
>>>> \field{hash_option} is 1.
>>>> +
>>> This I think conflicts with the current RSS where if this override (higher priority
>> than RSS) or not.
>>
>> VIRTIO_NET_F_HASH_TUNNEL instructs the device to calculate an inner header
>> hash for configured tunnel types.
>> Then, which fields are used for the calculation of the inner header hash is
>> determined by the RSS configuration.
>>
>> Therefore, if the inner header hash uses \field{hash_option} to indicate that the
>> outer source UDP port is used to calculate the hash, it overrides the RSS
>> configuration (higher priority than RSS). It now not only indicates for which
>> tunnel types the inner hash should be calculated, but also indicates which fields
>> participate in the RSS hash calculation.
>>
>> At this point, we can
>> 1. continue to allow this behavior. That is, if \field{hash_option} is set to 1, the
>> hash value calculated based on the outer source port indicated by
>> VIRTIO_NET_F_HASH_TUNNEL is provided to the indirection table to select the
>> rxq instead of the hash value provided by RSS.
>>
>> 2. hand over to RSS the ability to specify a hash based on the outer source port.
>> That is, we can add VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_{v4, v6,
>> EX} in \field{supported_hash_types} to indicate that the hash should be
>> calculated using the outer source port for all UDP tunneling protocols.
>> This approach removes the need for \field{hash_option} and makes the line
>> between VIRTIO_NET_F_HASH_TUNNEL and VIRTIO_NET_F_RSS clearer.
>>
> #2 is preferred.

Ok.

>
> But I must be missing something.
> Without VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X, today if one wants to do RSS based on the outer UDP ports,
> It is already supported by the RSS (even in presence of the inner header).
>
> So why do have to introduce VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X?

For legacy tunneling protocols like IPIP/GRE_2784/GRE_2890 that do not 
have outer transport headers,
it is worth calculating the inner header hash for these protocols.

For modern tunneling protocols with outer transport headers, although 
they can provide entropy through the outer source udp port,
sometimes we need to perform symmetric hashing on these tunneling protocols.
Then,
1. We can achieve this through the inner header, but we need a way to 
cope with the addition of new tunneling protocols in the future;
2. The outer source udp port can identify the same flow in modern 
tunneling protocols such as VXLAN/VXLAN-GPE/GENEVE/NVGRE.
But this is marked as "SHOULD" or "RECOMMEND" in various RFCs, so it is 
not reliable. This method ( adding
VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X) can deal with the needs of 
new tunneling protocols in the future for symmetric hashing.

If #2 is preferred, I'll update it in the next version.
(this also doesn't affect the migration, and maybe we shouldn't need a 
new feature to extend new values for \field{supported_hash_types}.)

Thanks!



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

