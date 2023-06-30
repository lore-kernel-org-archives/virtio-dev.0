Return-Path: <virtio-dev-return-13175-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C6FC0015E
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:55:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 472912B244
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:55:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 386CC9866FB
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:55:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2785E9866EA; Fri, 30 Jun 2023 01:55:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 134019866E7;
	Fri, 30 Jun 2023 01:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VmG73a8_1688090142;
Message-ID: <b957023f-a015-1622-531b-50b6931d974e@linux.alibaba.com>
Date: Fri, 30 Jun 2023 09:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
References: <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4132affe-9b97-a81f-ad57-50ed4341678b@linux.alibaba.com>
 <20230629074627-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230630005420.GC77232@h68b04307.sqa.eu95>
 <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash



在 2023/6/30 上午9:36, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Thursday, June 29, 2023 8:54 PM
>>
>> On Thu, Jun 29, 2023 at 04:59:28PM +0000, Parav Pandit wrote:
>>>
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Thursday, June 29, 2023 7:48 AM
>>>
>>>>>> struct virtio_net_hash_config reserved is fine.
>>>>> +1.
>>>>>
>>>>> Inner header hash is orthogonal to RSS, and it's fine to have its
>>>>> own structure and commands.
>>>>> There is no need to send additional RSS fields when we configure
>>>>> inner header hash.
>>>>>
>>>>> Thanks.
>>>> Not RSS, hash calculations. It's not critical, but I note that
>>>> practically you said you will enable this with symmetric hash so it
>>>> makes sense to me to send this in the same command with the key.
>>>>
>>> In the v19, we have,
>>>
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ
>> along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
>>> So it is done along with rss, so in same struct as rss config is fine.
>> Do you mean having both virtio_net_rss_config and virtio_net_hash_config
>> have enabled_hash_types?
>> Like this:
>>
>> struct virtio_net_rss_config {
>>       le32 hash_types;
>>       le16 indirection_table_mask;
>>       struct rss_rq_id unclassified_queue;
>>       struct rss_rq_id indirection_table[indirection_table_length];
>>       le16 max_tx_vq;
>>       u8 hash_key_length;
>>       u8 hash_key_data[hash_key_length];
>> +    le32 enabled_tunnel_types;
>> };
>>
>> struct virtio_net_hash_config {
>>       le32 hash_types;
>> -    le16 reserved[4];
>> +    le32 enabled_tunnel_types;
>> +    le16 reserved[2];
>>       u8 hash_key_length;
>>       u8 hash_key_data[hash_key_length];
>> };
>>
>>
>> If yes, this should have been discussed in v10 [1] before, enabled_tunnel_types
>> in virtio_net_rss_config will follow the variable length field and cause
>> misalignment.
>>
>> If we let the inner header hash reuse the virtio_net_hash_config structure, it
>> can work, but the only disadvantage is that the configuration of the inner
>> header hash and *RSS*(not hash calculations) becomes somewhat coupled.
>> Just imagine:
>> If the driver and the device negotiated VIRTIO_NET_F_HASH_TUNNEL and
>> VIRTIO_NET_F_RSS, but did not negotiate VIRTIO_NET_F_HASH_REPORT, 1.
>> then if we only want to configure the inner header hash (such as
>> enabled_tunnel_types), it is good for us to send virtio_net_hash_config alone;
>> 2. but then if we want to configure the inner header hash and RSS (such as
>> indirection table), we need to send all virtio_net_rss_config and
>> virtio_net_hash_config once, because virtio_net_rss_config now does not carry
>> enabled_tunnel_types due to misalignment.
>>
>> So, I think the following structure will make it clearer to configure inner header
>> hash and RSS/hash calculation.
>> But in any case, if we still propose to reuse virtio_net_hash_config proposal, I
>> am ok, no objection:
>>
>> 1. The supported_tunnel_types are placed in the device config space;
>>
> Yes. I forgot the variable length part.
>   
> The second disadvantage I remember now is one need to resupply all the rss hash config parameter and device needs to compare and modify for this one field.
>
> Given these two disadvantages, I also prefer independent SET command the way you have it.

OK, let's wait for Michael's input again.

Thanks.

>   
>> 2.
>> Reserve the following structure:
>>
>>        struct virtnet_hash_tunnel {
>> le32 enabled_tunnel_types;
>>        };
>>
>> 3. Reserve the SET command for enabled_tunnel_types and remove the GET
>> command for enabled_tunnel_types.
>>
>> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00317.html
>>
>> Thanks a lot!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

