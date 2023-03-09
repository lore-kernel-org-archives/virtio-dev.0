Return-Path: <virtio-dev-return-11566-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3185C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:28:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46BC72A889
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:28:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3995C986701
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 12:28:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F53B9866F6; Thu,  9 Mar 2023 12:28:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B3169866F3;
	Thu,  9 Mar 2023 12:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdTkCv2_1678364883;
Message-ID: <e875b1f1-bf6e-9e0a-a679-2e61799f9b38@linux.alibaba.com>
Date: Thu, 9 Mar 2023 20:28:00 +0800
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



在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>> If the tunnel is used to encapsulate the packets, the hash calculated
>> using the outer header of the receive packets is always fixed for the
>> same flow packets, i.e. they will be steered to the same receive queue.
> Wait a second. How is this true? Does not everyone stick the
> inner header hash in the outer source port to solve this?
> For example geneve spec says:
>
>     it is necessary for entropy from encapsulated packets to be
>     exposed in the tunnel header.  The most common technique for this is
>     to use the UDP source port
>
> same goes for vxlan did not check further.
>
> so what is the problem?  and which tunnel types actually suffer from the
> problem?
>

Inner hash can at least hash tunnel flows without outer transport 
headers like GRE to multiple queues,
which is beneficial to us.

For tunnel flows with outer transport headers like VXLAN, although they 
can hash flows to different queues
by setting different outer udp port, this does not conflict with inner 
hash. Inner hashing can also be used for this purpose.

For the same flow, packets in the receiving and sending directions may 
pass through different tunnels respectively, which cause
the same flow to be hashed to different queues. In this case, we have to 
calculate a symmetric hash (can be called an inner symmetric hash, which 
is a type of inner hash.)
through the inner header, so that the same flow can be hashed to the 
same queue.

Symmetric hashing can ignore the order of the 5-tuples to calculate the 
hash, that is, the hash values ​​calculated by (a1, a2, a3, a4) and (a2, 
a1, a4, a3) respectively are the same.

Thanks.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

