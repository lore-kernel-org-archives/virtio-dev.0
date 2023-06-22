Return-Path: <virtio-dev-return-13032-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B968EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:46:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 71A2014E687
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:46:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C6999865D5
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 00:46:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DBF59865CF; Thu, 22 Jun 2023 00:46:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48FF29865D0;
	Thu, 22 Jun 2023 00:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlhOkLe_1687394776;
Message-ID: <8629e939-74aa-5d4d-4ff5-42e34b53ad50@linux.alibaba.com>
Date: Thu, 22 Jun 2023 08:46:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621152451-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621153237-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230621153237-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash



在 2023/6/22 上午3:35, Michael S. Tsirkin 写道:
> On Wed, Jun 21, 2023 at 07:28:33PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Wednesday, June 21, 2023 3:26 PM
>>>
>>> On Wed, Jun 21, 2023 at 05:52:28PM +0000, Parav Pandit wrote:
>>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>>> Sent: Wednesday, June 21, 2023 12:46 PM
>>>>
>>>>> SET carries an additional 32 bits of information. But if you think
>>>>> this will make the overall structure more concise, I'm ok.
>>>>>
>>>> If it is placed in single structure than it needs to be reworded to remove WO
>>> or RO notion.
>>>
>>> Not really. all of structure is RO and WO.
>>>
>> For the device, what is the meaning of driver writing supported_tunnel_types in SET command?
>> Ignore? It doesn't make sense to pass something to ignore.
> It can be helpful for debugging. E.g. if driver sets
> a bit that device does not recognize, it can figure
> out that driver has it set in supported mask.
> Or if it seems like a waste we can just ask drivers to
> put 0 there, works for me too.

For the SET command, it is a bit strange to have the driver write 
support_hash_tunnel_types to the device.
'supported' is the capability of the device, 'enabled' is the capability 
of the driver.
The driver should be read-only to 'supported', the driver should not try 
to write it.

Thanks.

>
>
>> Two structures are cleaner.
> Frankly what's cleaner is what RSS is doing, supported mask in config
> space. Was this discussed in some version? I don't remember.
>
>>>> This also requires additional sw to indicate dma attributes to be RW when
>>> mapping this area.
>>>> And extra text to indicate that supported_hash_tunnel_types to be ignored
>>> on set command.
>>>> Two structures are more cleaner serving its purpose.
>>> No because all of structure is RO or WO.
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee: https://www.oasis-open.org/committees/virtio/
>> Join OASIS: https://www.oasis-open.org/join/
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

