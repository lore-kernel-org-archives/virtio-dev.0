Return-Path: <virtio-dev-return-12624-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC8CC7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 09:15:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 33BBE16E5AA
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 09:15:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 275429865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 09:15:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1BA44986580; Wed, 10 May 2023 09:15:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05F8F98657F;
	Wed, 10 May 2023 09:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ViFRH25_1683710140;
Message-ID: <13fe574e-19da-b842-76cc-4a729a86d676@linux.alibaba.com>
Date: Wed, 10 May 2023 17:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <20230425165659-mutt-send-email-mst@kernel.org>
 <19e6d4e6-e3d8-7eca-4d54-d113b4cc5504@linux.alibaba.com>
 <20230426104538-mutt-send-email-mst@kernel.org>
 <5463159d-daa2-101b-6abf-ea7aa4f40bd0@linux.alibaba.com>
 <20230427130008-mutt-send-email-mst@kernel.org>
 <20230505135115.GA110622@h68b04307.sqa.eu95>
 <20230505105427-mutt-send-email-mst@kernel.org>
 <e3930c64-b7eb-a01e-39c9-0fe718756185@linux.alibaba.com>
 <20230509110941-mutt-send-email-mst@kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230509110941-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] Re: [virtio-comment] [PATCH v13] virtio-net: support inner
 header hash



在 2023/5/9 下午11:15, Michael S. Tsirkin 写道:
> On Tue, May 09, 2023 at 10:22:19PM +0800, Heng Qi wrote:
>>
>> 在 2023/5/5 下午10:56, Michael S. Tsirkin 写道:
>>> On Fri, May 05, 2023 at 09:51:15PM +0800, Heng Qi wrote:
>>>> On Thu, Apr 27, 2023 at 01:13:29PM -0400, Michael S. Tsirkin wrote:
>>>>> On Thu, Apr 27, 2023 at 10:28:29AM +0800, Heng Qi wrote:
>>>>>> 在 2023/4/26 下午10:48, Michael S. Tsirkin 写道:
>>>>>>> On Wed, Apr 26, 2023 at 10:14:30PM +0800, Heng Qi wrote:
>>>>>>>> This does not mean that every device needs to implement and support all of
>>>>>>>> these, they can choose to support some protocols they want.
>>>>>>>>
>>>>>>>> I add these because we have scale application scenarios for modern protocols
>>>>>>>> VXLAN-GPE/GENEVE:
>>>>>>>>
>>>>>>>> +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
>>>>>>>> +      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
>>>>>>>>
>>>>>>>>
>>>>>>>> Maybe the legacy GRE, VXLAN-GPE and GENEVE? But it has a little crossover.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>> But VXLAN-GPE/GENEVE can use source port for entropy.
>>>>>>>
>>>>>>> 	It is recommended that the UDP source port number
>>>>>>> 	 be calculated using a hash of fields from the inner packet
>>>>>>>
>>>>>>> That is best because
>>>>>>> it allows end to end control and is protocol agnostic.
>>>>>> Yes. I agree with this, I don't think we have an argument on this point
>>>>>> right now.:)
>>>>>>
>>>>>> For VXLAN-GPE/GENEVE or other modern tunneling protocols, we have to deal
>>>>>> with
>>>>>> scenarios where the same flow passes through different tunnels.
>>>>>>
>>>>>> Having them hashed to the same rx queue, is hard to do via outer headers.
>>>>>>> All that is missing is symmetric Toepliz and all is well?
>>>>>> The scenarios above or in the commit log also require inner headers.
>>>>> Hmm I am not sure I get it 100%.
>>>>> Could you show an example with inner header hash in the port #,
>>>>> hash is symmetric, and you still have trouble?
>>>>>
>>>>>
>>>>> It kinds of sounds like not enough entropy is not the problem
>>>>> at this point.
>>>> Sorry for the late reply. :)
>>>>
>>>> For modern tunneling protocols, yes.
>>>>
>>>>> You now want to drop everything from the header
>>>>> except the UDP source port. Is that a fair summary?
>>>>>
>>>> For example, for the same flow passing through different VXLAN tunnels,
>>>> packets in this flow have the same inner header and different outer
>>>> headers. Sometimes these packets of the flow need to be hashed to the
>>>> same rxq, then we can use the inner header as the hash input.
>>>>
>>>> Thanks!
>>> So, they will have the same source port yes?
>> Yes. The outer source port can be calculated using the 5-tuple of the
>> original packet,
>> and the outer ports are the same but the outer IPs are different after
>> different directions of the same flow pass through different tunnels.
>>> Any way to use that
>> We use it in monitoring, firewall and other scenarios.
>>
>>> so we don't depend on a specific protocol?
>> Yes, selected tunneling protocols can be used in this scenario like this.
>>
>> Thanks.
>>
> No, the question was - can we generalize this somehow then?
> For example, a flag to ignore source IP when hashing?
> Or maybe just for UDP packets?

1. I think the common solution is based on the inner header, so that 
GRE/IPIP tunnels can also enjoy inner symmetric hashing.

2. The VXLAN spec does not show that the outer source port in both 
directions of the same flow must be the same [1]
(although the outer source port is calculated based on the consistent 
hash in the kernel. The consistent hash will sort the five-tuple before 
calculating hashing),
but it is best not to assume that consistent hashing is used in all 
VXLAN implementations. The GENEVE spec uses "SHOUlD"[2].

3. How should we generalize? The device uses a feature to advertise all 
the tunnel types it supports, and hashes these tunnel types using the 
outer source port,
and then we still have to give the specific tunneling protocols 
supported by the device, just like we do now.

[1] "Source Port: It is recommended that the UDP source port number be 
calculated using a hash of fields from the inner packet -- one example
being a hash of the inner Ethernet frame's headers. This is to enable a 
level of entropy for the ECMP/load-balancing of the VM-to-VM traffic across
the VXLAN overlay. When calculating the UDP source port number in this 
manner, it is RECOMMENDED that the value be in the dynamic/private
port range 49152-65535 [RFC6335] "

[2] "Source Port: A source port selected by the originating tunnel 
endpoint. This source port SHOULD be the same for all packets belonging to a
single encapsulated flow to prevent reordering due to the use of 
different paths. To encourage an even distribution of flows across 
multiple links,
the source port SHOULD be calculated using a hash of the encapsulated 
packet headers using, for example, a traditional 5-tuple. Since the port
represents a flow identifier rather than a true UDP connection, the 
entire 16-bit range MAY be used to maximize entropy. In addition to 
setting the
source port, for IPv6, the flow label MAY also be used for providing 
entropy. For an example of using the IPv6 flow label for tunnel use 
cases, see [RFC6438]."

Thanks.

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

