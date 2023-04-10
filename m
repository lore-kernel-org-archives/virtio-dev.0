Return-Path: <virtio-dev-return-12089-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9B6C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:26:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C161744553
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:26:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9D429863A7
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:26:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9C84E9862A5; Mon, 10 Apr 2023 13:26:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B71A986319;
	Mon, 10 Apr 2023 13:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VfoRJ-i_1681133173;
Message-ID: <6f5171a3-e941-7718-633d-21b768e8a4da@linux.alibaba.com>
Date: Mon, 10 Apr 2023 21:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230228061309-mutt-send-email-mst@kernel.org>
 <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
 <20230308093311-mutt-send-email-mst@kernel.org>
 <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
 <20230309142612-mutt-send-email-mst@kernel.org>
 <021eeb40-aab1-07b9-cfe7-9dd61a32e0b3@linux.alibaba.com>
 <20230315074633-mutt-send-email-mst@kernel.org>
 <4b14043c-6059-1d26-060e-7dc653c4f401@linux.alibaba.com>
 <20230320154556-mutt-send-email-mst@kernel.org>
 <39f3ebf4-1141-8044-4ffc-e32e62edbb2c@linux.alibaba.com>
 <20230408062119-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230408062119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re:
 [virtio-comment] Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner
 header hash



在 2023/4/8 下午6:29, Michael S. Tsirkin 写道:
> On Thu, Mar 30, 2023 at 08:37:21PM +0800, Heng Qi wrote:
>>
>> 在 2023/3/21 上午3:48, Michael S. Tsirkin 写道:
>>> On Wed, Mar 15, 2023 at 08:55:45PM +0800, Heng Qi wrote:
>>>> We use the most basic GRE header fields (not NVGRE), not even optional
>>>> fields.
>>> I'd say yes, the most convincing usecase is with legacy GRE.
>> Yes. But we still have a strong need for VXLAN and GENEVE to do symmetric
>> hashing. Please consider this.
> Using a specific key seems fragile though in that a different one is
> needed for e.g. ipv4 and ipv6.  An issue with VXLAN and GENEVE, yes?

Yes.

> Will support for XOR hashing address this sufficiently or is that not
> acceptable to you? Or alternatively a modified Toeplitz, e.g. this

This is a very good opinion, I will want to follow up on this work and I 
have expressed in other threads.

Thanks.

> https://inbox.dpdk.org/dev/20190731123040.GG4512@6wind.com/
> suggests Mellanox supports that. WDYT?
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

