Return-Path: <virtio-dev-return-13612-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B702FC83F33
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 11:11:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18D4A2357E
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 11:11:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F4E99864B2
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 11:11:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0284C9863C1; Mon,  4 Sep 2023 11:11:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E69E39863B7;
	Mon,  4 Sep 2023 11:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VrJdO86_1693825875;
Message-ID: <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
Date: Mon, 4 Sep 2023 19:11:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats



在 2023/9/4 下午6:26, Parav Pandit 写道:
>> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Sent: Monday, September 4, 2023 2:23 PM
>
>>> "The device MUST NOT pass received packets that exceed mtu (plus low
>>> level ethernet header length) size with gso_type NONE or ECN after
>> VIRTIO_NET_F_MTU has been successfully negotiated."
>>
>> NO.
>>
>> If the mtu is 1500, we can pass 64k packets to the driver with gso_type (not
>> NONE).
> Any supporting citation to spec for above comment?

I think it can be referred here:
"The converse features are also available: a driver can save the virtual 
device some work by negotiating these features. Note: For example, a 
network packet transported between two guests on the same system might 
not need checksumming at all, nor segmentation, if both guests are 
amenable."

>
> Each packet must be 1500 for the mtu normative above.
> gso_size to <= mtu (ingoring the hdr math for simplicity for now).
> whole GSO completion can be for 64K to be reported in used_elem.len.
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

