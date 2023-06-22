Return-Path: <virtio-dev-return-13033-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D719DEB64D7
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:59:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C6F018C9C8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:59:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D39C9865F1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:59:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 312AE9865D1; Thu, 22 Jun 2023 00:59:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C8F99865D0;
	Thu, 22 Jun 2023 00:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlhQafS_1687395550;
Message-ID: <4cdc8590-be35-fa58-9c5f-bd0ecf5d5661@linux.alibaba.com>
Date: Thu, 22 Jun 2023 08:59:06 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash



在 2023/6/22 上午4:52, Parav Pandit 写道:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, June 21, 2023 4:38 PM
>>>> And the field is RO so no memory cost to exposing it in all VFs.
>>> Two structures do not bring the asymmetry.
>>> Accessing current and enabled fields via two different mechanism is bringing
>> the asymmetry.
>>
>> I guess it's a matter of taste, but it is clearly more consistent with other hash
>> things, to which it's very similar.
>>
> This is consistent with new commands we define including notification coalescing whose GET is not coming config space.

Yes.

>   
>> Nah, config space is too convenient when we can live with its limitations. I don't
>> thin kwe prefer not to keep growing it.
>> For some things such as this one it's perfect.
>>
> Fields are different between different devices.
>
>> For example, for migration driver might want to validate that two devices have
>> same capability. doing it without dma is nicer.
>>
> A migration driver for real world scenario, will almost have to use the dma for amount of data it needs to exchange.
>
>> Another example, future admin transport will have ability to provision devices
>> by supplying their config space.
>> This will include this capability automatically, if instead we hide it in a command
>> we need to do extra custom work.
>>
>>> So we do not prefer to keep growing the config space anymore, hence
>>> GET is the right approach to me.
>> Heh I know you hate config space. Let it go, stop wasting time arguing about the
>> same thing on every turn and instead help define admin transport to solve it
> This was discussed many times, a driver to have a direct (non-intercepted by owner device) channel to device.
> If you mean this non-intercepted channel as admin transport, fine.
> If you mean this is intercepted and it is going over admin cmd, then it is of no use for all future interfaces.
>
> We discussed this in thread with you and Jason.
> I provided concrete example with size and device provisioning math too and other example of multi-physical address VQ.
> So transporting register by register over some admin transport is sub-optimal.

Parav, your implementation prefers two separate struct versions and 
doesn't let supported_hash_tunnel_types expand in configuration space. I 
remember this.
I agree that we don't want to jump back and forth, especially as there 
are practical reasons and 5 version jumps to get 
supported_hash_tunnel_types back into the config space.

The original intention of Michael's proposal to merge structures in v18 
should be that two separate structures will cause asynchrony.
I don't think so, the driver can cache enabled hash_tunnel_types every 
SET command. Or after the SET command the driver *SHOULD* use the GET 
command again, which is the workaround.

Thanks.

>
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

