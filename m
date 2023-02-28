Return-Path: <virtio-dev-return-11333-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96609C64EC7
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 09:56:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB8DD2A898
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 09:56:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A366D986624
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 09:56:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 999B7983EFA; Tue, 28 Feb 2023 09:56:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85D889865FA;
	Tue, 28 Feb 2023 09:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VcixGlm_1677578189;
Message-ID: <8660f842-e443-d206-1f8c-7c298e576274@linux.alibaba.com>
Date: Tue, 28 Feb 2023 17:56:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228034620-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230228034620-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230228095628.Icyu8BYdGEsvA_MAvMvEMUOUqpSZheDUdl5OmMzM7oQ@z>



在 2023/2/28 下午4:52, Michael S. Tsirkin 写道:
> On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
>> On Tue, Feb 28, 2023 at 1:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
>>>> On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
>>>>>> Btw, this kind of 1:1 hash features seems not scalable and flexible.
>>>>>> It requires an endless extension on bits/fields. Modern NICs allow the
>>>>>> user to customize the hash calculation, for virtio-net we can allow to
>>>>>> use eBPF program to classify the packets. It seems to be more flexible
>>>>>> and scalable and there's almost no maintain burden in the spec (only
>>>>>> bytecode is required, no need any fancy features/interactions like
>>>>>> maps), easy to be migrated etc.
>>>>>>
>>>>>> Prototype is also easy, tun/tap had an eBPF classifier for years.
>>>>>>
>>>>>> Thanks
>>>>> Yea BPF offload would be great to have. We have been discussing it for
>>>>> years though - security issues keep blocking it. *Maybe* it's finally
>>>>> going to be there but I'm not going to block this work waiting for BPF
>>>>> offload.  And easily migrated is what BPF is not.
>>>> Just to make sure we're at the same page. I meant to find a way to
>>>> allow the driver/user to fully customize what it wants to
>>>> hash/classify. Similar technologies which is based on private solution
>>>> has been used by some vendors, which allow user to customize the
>>>> classifier[1]
>>>>
>>>> ePBF looks like a good open-source solution candidate for this (there
>>>> could be others). But there could be many kinds of eBPF programs that
>>>> could be offloaded. One famous one is XDP which requires many features
>>>> other than the bytecode/VM like map access, tailcall. Starting from
>>>> such a complicated type is hard. Instead, we can start from a simple
>>>> type, that is the eBPF classifier. All it needs is to pass the
>>>> bytecode to the device, the device can choose to run it or compile it
>>>> to what it can understand for classifying. We don't need maps, tail
>>>> calls and other features.
>>> Until people start asking exactly for maps because they want
>>> state for their classifier?
>> Yes, but let's compare the eBPF without maps with the static feature
>> proposed here. It is much more scalable and flexible.
>>
>>> And it makes sense - if you want
>>> e.g. load balancing you need stats which needs maps.
>> Yes, but we know it's possible to have that (through the XDP offload).
>> This is impossible with the approach proposed here.
> I'm not actually objecting. And at least we then don't need to
> worry about leaking info - it's not virtio leaking info
> it's the bpf program. I wonder what does Heng Qi think.
> Heng Qi would it work for your scenario?

We are positive on ebpf, which looks adequate in our scenario. Although 
it currently has some problems in offloading,
such as imperfect interfaces, unstable, and user-unfriendly ebpf codes 
may consume a lot of device resources. Device support for ebpf will also 
take time.
Also, the presence of ebpf offload does not conflict with other 
solutions, eg we still have RSS.

Our goal is to pass this patch first. For the support of ebpf 
offloading, we have not collected internal requirements for the time 
being, but it is indeed a good direction.

Thanks.

>
>>>> We don't need to worry about the security
>>>> because of its simplicity: the eBPF program is only in charge of doing
>>>> classification, no other interactions with the driver and packet
>>>> modification is prohibited. The feature is limited only to the
>>>> VM/bytecode abstraction itself.
>>>>
>>>> What's more, it's a good first step to achieve full eBPF offloading in
>>>> the future.
>>>>
>>>> Thanks
>>>>
>>>> [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html
>>> Dave seems to have nacked this approach, no?
>> I may miss something but looking at kernel commit, there are few
>> patches to support that:
>>
>> E.g
>>
>> commit c7648810961682b9388be2dd041df06915647445
>> Author: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Date:   Mon Sep 9 06:47:44 2019 -0700
>>
>>      ice: Implement Dynamic Device Personalization (DDP) download
>>
>> And it has been used by DPDK drivers.
>>
>> Thanks
> If we are talking about netdev then this discussion has to take place on netdev.
> If it's dpdk this is more believable.
>
>>>>> --
>>>>> MST
>>>>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

