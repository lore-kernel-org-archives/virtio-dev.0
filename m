Return-Path: <virtio-dev-return-11337-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4DCC64EC7
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:56:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08B802A8E4
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:56:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04A9698666C
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 02:56:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED5BA98664A; Wed,  1 Mar 2023 02:56:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9ACC986645;
	Wed,  1 Mar 2023 02:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vcm6ylM_1677639393;
Message-ID: <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
Date: Wed, 1 Mar 2023 10:56:31 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230228061309-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230301025631.-ScWS1aNfJsN3YqkW0JYi8CAu-LnZ4StU9wqSf0tTHQ@z>



在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>> If the tunnel is used to encapsulate the packets, the hash calculated
>> using the outer header of the receive packets is always fixed for the
>> same flow packets, i.e. they will be steered to the same receive queue.
> Wait a second. How is this true? Does not everyone stick the
> inner header hash in the outer source port to solve this?

Yes, you are right. That's what we did before the inner header hash, but 
it has a performance penalty, which I'll explain below.

> For example geneve spec says:
>
>     it is necessary for entropy from encapsulated packets to be
>     exposed in the tunnel header.  The most common technique for this is
>     to use the UDP source port

The end point of the tunnel called the gateway (with DPDK on top of it).

1. When there is no inner header hash, entropy can be inserted into the 
udp src port of the outer header of the tunnel,
and then the tunnel packet is handed over to the host. The host needs to 
take out a part of the CPUs to parse the outer headers (but not drop them)
to calculate the inner hash for the inner payloads, and then use the 
inner hash to forward them to another part of the CPUs that are 
responsible for processing.
1). During this process, the CPUs on the host is divided into two parts, 
one part is used as a forwarding node to parse the outer header,
      and the CPU utilization is low. Another part handles packets.
2). The entropy of the source udp src port is not enough, that is, the 
queue is not widely distributed.

2. When there is an inner header hash, the gateway will directly help 
parse the outer header, and use the inner 5 tuples to calculate the 
inner hash.
The tunneled packet is then handed over to the host.
1) All the CPUs of the host are used to process data packets, and there 
is no need to use some CPUs to forward and parse the outer header.
2) The entropy of the original quintuple is sufficient, and the queue is 
widely distributed.

Thanks.

>
> same goes for vxlan did not check further.
>
> so what is the problem?  and which tunnel types actually suffer from the
> problem?
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

