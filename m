Return-Path: <virtio-dev-return-11643-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A0FC6FD19
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:26:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4B9857598F
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:26:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37DBD986435
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 13:26:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2CC82983E51; Thu, 16 Mar 2023 13:26:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 193489863D7;
	Thu, 16 Mar 2023 13:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ve.Ue7w_1678973191;
Message-ID: <f0b05b7d-c09d-bd36-99c7-042afd8b5de5@linux.alibaba.com>
Date: Thu, 16 Mar 2023 21:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
 <20230315110736-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230315110736-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash



在 2023/3/15 下午11:09, Michael S. Tsirkin 写道:
> On Wed, Mar 15, 2023 at 09:19:43PM +0800, Heng Qi wrote:
>>> Any encapsulation technology that includes UDP/L4 header likely do not
>>> prefer based on the inner header. This is because the outer header src
>>> port entropy is added based on the inner header.
>>>
>>> I was not able to follow the discussion in v9 that you had with Michael.
>>> Did you conclude if this is needed for vxlan too?
>>>
>>> If not, for now it may be better to skip vxlan and nvegre as they
>>> inherently have unique outer header UDP src port based on the inner
>>> header.
>> Symmetric hashing ignores the order of the five-tuples when calculating the
>> hash, that is, using (a1,a2,p1,p2) and (a2,a1,p2,p1) respectively can
>> calculate the same hash.
>> There is a scenario that the two directions client1->client2 and
>> client2->client1 of the same flow may pass through different tunnels.
>> In order to allow the data in two directions to be processed by the same
>> CPU, we need to calculate a symmetric hash based on the inner packet header.
>> Sorry I didn't mention this earlier just to avoid introducing the concept of
>> symmetric hashing.
> But the hash is already there in the port. Is it then maybe just
> the question of ignoring the IP addresses when hashing?

We do not ignore the IP address, because after the tunnel sends the 
packets to the processing host,
the processing host will parse the outer headers, and then use the inner 
symmetric hash to hand over the
packets of the same flow to the same cpu for processing (for the network 
topology, please check my latest reply thread).

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

