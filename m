Return-Path: <virtio-dev-return-11557-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1D5C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 04:55:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7DF112A888
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 04:55:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 667419866FB
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 04:55:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 56C4F983E8F; Thu,  9 Mar 2023 04:55:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D8989866BE;
	Thu,  9 Mar 2023 04:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdS0uCM_1678337704;
Message-ID: <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
Date: Thu, 9 Mar 2023 12:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230228061309-mutt-send-email-mst@kernel.org>
 <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
 <20230308093311-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230308093311-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v9]
 virtio-net: support inner header hash



在 2023/3/8 下午10:39, Michael S. Tsirkin 写道:
> On Wed, Mar 01, 2023 at 10:56:31AM +0800, Heng Qi wrote:
>>
>> 在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
>>> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>>>> If the tunnel is used to encapsulate the packets, the hash calculated
>>>> using the outer header of the receive packets is always fixed for the
>>>> same flow packets, i.e. they will be steered to the same receive queue.
>>> Wait a second. How is this true? Does not everyone stick the
>>> inner header hash in the outer source port to solve this?
>> Yes, you are right. That's what we did before the inner header hash, but it
>> has a performance penalty, which I'll explain below.
>>
>>> For example geneve spec says:
>>>
>>>      it is necessary for entropy from encapsulated packets to be
>>>      exposed in the tunnel header.  The most common technique for this is
>>>      to use the UDP source port
>> The end point of the tunnel called the gateway (with DPDK on top of it).
>>
>> 1. When there is no inner header hash, entropy can be inserted into the udp
>> src port of the outer header of the tunnel,
>> and then the tunnel packet is handed over to the host. The host needs to
>> take out a part of the CPUs to parse the outer headers (but not drop them)
>> to calculate the inner hash for the inner payloads,
>> and then use the inner
>> hash to forward them to another part of the CPUs that are responsible for
>> processing.
> I don't get this part. Leave inner hashes to the guest inside the
> tunnel, why is your host doing this?

Assuming that the same flow includes a unidirectional flow a->b, or a 
bidirectional flow a->b and b->a,
such flow may be out of order when processed by the gateway(DPDK):

1. In unidirectional mode, if the same flow is switched to another 
gateway for some reason, resulting in different outer IP address,
     then this flow may be processed by different CPUs after reaching 
the host if there is no inner hash. So after the host receives the
     flow, first use the forwarding CPUs to parse the inner hash, and 
then use the hash to ensure that the flow is processed by the
     same CPU.
2. In bidirectional mode, a->b flow may go to gateway 1, and b->a flow 
may go to gateway 2. In order to ensure that the same flow is
     processed by the same CPU, we still need the forwarding CPUs to 
parse the real inner hash(here, the hash key needs to be replaced with a 
symmetric hash key).

>
>> 1). During this process, the CPUs on the host is divided into two parts, one
>> part is used as a forwarding node to parse the outer header,
>>       and the CPU utilization is low. Another part handles packets.
> Some overhead is clearly involved in *sending* packets -
> to calculate the hash and stick it in the port number.
> This is, however, a separate problem and if you want to
> solve it then my suggestion would be to teach the *transmit*
> side about GRE offloads, so it can fill the source port in the card.
>
>> 2). The entropy of the source udp src port is not enough, that is, the queue
>> is not widely distributed.
> how isn't it enough? 16 bit is enough to cover all vqs ...

A 5-tuple brings more entropy than a single port, doesn't it? In fact, 
the inner hash of the physical network card used by
the business team is indeed better than the udp port number of the outer 
header we modify now, but they did not give me the data.

>> 2. When there is an inner header hash, the gateway will directly help parse
>> the outer header, and use the inner 5 tuples to calculate the inner hash.
>> The tunneled packet is then handed over to the host.
>> 1) All the CPUs of the host are used to process data packets, and there is
>> no need to use some CPUs to forward and parse the outer header.
> You really have to parse the outer header anyway,
> otherwise there's no tunneling.
> Unless you want to teach virtio to implement tunneling
> in hardware, which is something I'd find it easier to
> get behind.

There is no need to parse the outer header twice, because we use shared 
memory.

>> 2) The entropy of the original quintuple is sufficient, and the queue is
>> widely distributed.
> It's exactly the same entropy, why would it be better? In fact you
> are taking out the outer hash entropy making things worse.

I don't get the point, why the entropy of the inner 5-tuple and the 
outer tunnel header is the same,
multiple streams have the same outer header.

Thanks.
>
>> Thanks.
>>> same goes for vxlan did not check further.
>>>
>>> so what is the problem?  and which tunnel types actually suffer from the
>>> problem?
>>>
>>
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

