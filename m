Return-Path: <virtio-dev-return-14219-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE4BC4707C
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 03:10:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 535B042A6C
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 03:10:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 431699866F2
	for <virtio-dev@archiver.kernel.org>; Fri, 12 Jan 2024 03:10:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36749984033; Fri, 12 Jan 2024 03:10:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D9819866DA;
	Fri, 12 Jan 2024 03:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W-RMXVj_1705028990;
Message-ID: <ab9eac43-774f-46ba-9691-2297ede2c922@linux.alibaba.com>
Date: Fri, 12 Jan 2024 11:09:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
References: <1704263702-50528-1-git-send-email-hengqi@linux.alibaba.com>
 <9f223f31-d82d-4554-817b-d46327a9cdee@linux.alibaba.com>
 <79c04138-6e41-4b53-a830-33bfa36501bb@linux.alibaba.com>
 <87mstbomxf.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87mstbomxf.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [PATCH v8] virtio-net: correct
 conditions for devices to validate packet checksum



在 2024/1/12 上午12:27, Cornelia Huck 写道:
> On Thu, Jan 11 2024, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> 在 2024/1/4 下午12:47, Heng Qi 写道:
>>>
>>> 在 2024/1/3 下午2:35, Heng Qi 写道:
>>>> There is a historical error in virtio spec:
>>>>     "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST*
>>>> set flags
>>>>      to zero and SHOULD supply a fully checksummed packet to the driver."
>>>>
>>>> Currently in Linux and virtio-related implementations, the device
>>>> validates
>>>> the packet checksum and sets DATA_VALID regardless of whether
>>>> VIRTIO_NET_F_GUEST_CSUM is negotiated.
>>>>
>>>> Please refer to the following summary and thread[1] for details and
>>>> reasons:
>>>>
>>>> Summary
>>>> =============
>>>> 1. GUEST_CSUM at virtio spec 0.95 is intended to be compatible with
>>>> partially
>>>> checksummed packets (NEEDS_CSUM <-> CHECKSUM_PARTIAL). So GUEST_CSUM
>>>> is mapped
>>>> to NETIF_F_RXCSUM.
>>>> GUEST_CSUM only indicates whether the driver handles partially
>>>> checksummed packets.
>>>> When XDP is loaded, the GUEST_CSUM's offload will be disabled, which
>>>> means that
>>>> packets have NEEDS_CSUM set will be dropped, and packets have
>>>> DATA_VALID set will
>>>> still be received.
>>>>
>>>> 2. When DATA_VALID was added to Linux in 2011[2] and virtio1.0, it
>>>> was actually
>>>> expected that rx checksum offload (the driver can set
>>>> CHECKSUM_UNNECESSARY) had
>>>> nothing to do with whether GUEST_CSUM was negotiated. But due to an
>>>> error, below
>>>> desctiption was added incorrectly:
>>>>     "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST*
>>>> set flags
>>>>      to zero and SHOULD supply a fully checksummed packet to the driver."
>>>>
>>>> 3. We now hope to correct this error. Let the setting of DATA_VALID
>>>> not be
>>>> controlled by whether GUEST_CSUM is negotiated, but only controlled
>>>> by whether
>>>> rx checksum offload is enabled on the OS side. The state of this rx
>>>> checksum
>>>> offload is not aware of the device.
>>>>
>>>> 4. [Optional] NETIF_F_RXCSUM corresponding to rx checksum offload
>>>> should be
>>>> added to dev->hw_features. When the user turns off rx checksum
>>>> offload through
>>>> ethtool -K, neither NEEDS_CSUM nor DATA_VALID should be taken care
>>>> of, that is,
>>>> all packets will be marked as CHECKSUM_NONE.
>>>>
>>>> Related Link
>>>> =============
>>>> [1]
>>>> https://lists.oasis-open.org/archives/virtio-comment/202312/msg00135.html
>>>> [2] 10a8d94a9574 ("virtio_net: introduce VIRTIO_NET_HDR_F_DATA_VALID")
>>>>
>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/185
>>> Hi Michael, Cornelia.
>>>
>>> Could you please open a voting for this fix?
>> Hi Michael and Cornelia.
>>
>> Sincerely asking if you missed this message?
> I've been back from end-of-year PTO only this week...
>
> I'm currently waiting for a confirmed updated schedule for the
> infrastructure migration, as I don't want to risk having the platform
> out of order in the middle of the voting period.

I got it. It depends on when the infrastructure is migrated, thanks for 
the sync.

>
>> In addition, Jason recently responded with his reviewed-by tag.
>> Do I need to publish a new version carrying his tag (thanks Jason)?
> No, we can add his R-b when pushing to git.

Ok.

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

