Return-Path: <virtio-dev-return-13035-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B33EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:17:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 06CCB41EF8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:17:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F16AB9865F1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 01:17:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E32CB9865D1; Thu, 22 Jun 2023 01:17:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE9B09865D0;
	Thu, 22 Jun 2023 01:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlhTGKp_1687396658;
Message-ID: <572936be-8620-62e7-20fb-6759ab824cb6@linux.alibaba.com>
Date: Thu, 22 Jun 2023 09:17:33 +0800
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
 <4cdc8590-be35-fa58-9c5f-bd0ecf5d5661@linux.alibaba.com>
 <PH0PR12MB548161398FD1A470FBA6E604DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548161398FD1A470FBA6E604DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash



在 2023/6/22 上午9:04, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, June 21, 2023 8:59 PM
> [..]
>>> We discussed this in thread with you and Jason.
>>> I provided concrete example with size and device provisioning math too and
>> other example of multi-physical address VQ.
>>> So transporting register by register over some admin transport is sub-optimal.
>> Parav, your implementation prefers two separate struct versions and doesn't let
>> supported_hash_tunnel_types expand in configuration space. I remember this.
>> I agree that we don't want to jump back and forth, especially as there are
>> practical reasons and 5 version jumps to get supported_hash_tunnel_types
>> back into the config space.
>>
> Right.
>
>> The original intention of Michael's proposal to merge structures in v18 should
>> be that two separate structures will cause asynchrony.
>> I don't think so, the driver can cache enabled hash_tunnel_types every SET
>> command. Or after the SET command the driver *SHOULD* use the GET
>> command again, which is the workaround.
>>
> There is no need to perform GET after SET.

Yes.

> A driver-device contract is, is SET command returns success, it means device accepted the command and will apply the filter.
> If device fails it, there is anyway error.
>
> Later when if driver wants to modify the tunnel type (add/remove),
> a. either it can used previously read supported type (if cached in driver)
> b. issue GET to know supported tunnel types (if not cached)

You are right. This is what I want to say.

Thanks.

>   
>> Thanks.
>>
>>>
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

