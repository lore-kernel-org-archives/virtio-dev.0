Return-Path: <virtio-dev-return-11313-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B38C64ED8
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 12:38:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BD146370F9
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 12:38:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2171986561
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 12:38:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A6C3598640A; Mon, 27 Feb 2023 12:38:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 941EC9863FE;
	Mon, 27 Feb 2023 12:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VcehiiW_1677501509;
Message-ID: <ec9c66b7-16d9-8b5e-8515-2024c618f684@linux.alibaba.com>
Date: Mon, 27 Feb 2023 20:38:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227123826.Cvuk1UJWyPRUtPzHuaaHKjDKUECMxVGfc2SqMEou9fM@z>



在 2023/2/27 下午4:35, Jason Wang 写道:
> On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
>>> Btw, this kind of 1:1 hash features seems not scalable and flexible.
>>> It requires an endless extension on bits/fields. Modern NICs allow the
>>> user to customize the hash calculation, for virtio-net we can allow to
>>> use eBPF program to classify the packets. It seems to be more flexible
>>> and scalable and there's almost no maintain burden in the spec (only
>>> bytecode is required, no need any fancy features/interactions like
>>> maps), easy to be migrated etc.
>>>
>>> Prototype is also easy, tun/tap had an eBPF classifier for years.
>>>
>>> Thanks
>> Yea BPF offload would be great to have. We have been discussing it for
>> years though - security issues keep blocking it. *Maybe* it's finally
>> going to be there but I'm not going to block this work waiting for BPF
>> offload.  And easily migrated is what BPF is not.
> Just to make sure we're at the same page. I meant to find a way to
> allow the driver/user to fully customize what it wants to
> hash/classify. Similar technologies which is based on private solution
> has been used by some vendors, which allow user to customize the
> classifier[1]
>
> ePBF looks like a good open-source solution candidate for this (there
> could be others). But there could be many kinds of eBPF programs that
> could be offloaded. One famous one is XDP which requires many features
> other than the bytecode/VM like map access, tailcall. Starting from
> such a complicated type is hard. Instead, we can start from a simple
> type, that is the eBPF classifier. All it needs is to pass the
> bytecode to the device, the device can choose to run it or compile it
> to what it can understand for classifying. We don't need maps, tail
> calls and other features. We don't need to worry about the security
> because of its simplicity: the eBPF program is only in charge of doing
> classification, no other interactions with the driver and packet
> modification is prohibited. The feature is limited only to the
> VM/bytecode abstraction itself.

Since the instruction set of ebpf is not complicated, some devices 
already support the offloading of ebpf,
but what troubles them is how to standardize each device to implement 
standard and optional subsystem interfaces.
There are two reasons:
#1, due to the rapid development of ebpf , so it is difficult for them 
to ensure the backward compatibility of the interface.
#2, such as network and blk devices, which interfaces must be 
implemented to allow the same ebpf program to run perfectly on each other.
Also, ebpf program is not isolated, it is expected to interact with 
userspace programs, and few examples can demonstrate
how to use them effectively.

Maybe we can take advantage of the virtio spec to get out there first.

Thanks.

>
> What's more, it's a good first step to achieve full eBPF offloading in
> the future.
>
> Thanks
>
> [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html
>
>> --
>> MST
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

