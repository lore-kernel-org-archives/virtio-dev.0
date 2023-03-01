Return-Path: <virtio-dev-return-11338-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B63DC64EC7
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 03:30:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 690522A88B
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 03:30:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6506598666D
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 03:30:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58BF5986646; Wed,  1 Mar 2023 03:30:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4249B9863D1;
	Wed,  1 Mar 2023 03:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vcmfb1Z_1677641438;
Message-ID: <c778af08-7aac-ca35-30d2-c18bd52c5cec@linux.alibaba.com>
Date: Wed, 1 Mar 2023 11:30:37 +0800
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
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v9] virtio-net: support inner header
 hash
Message-ID: <20230301033037.K5uPwgS8uBq3Y2DcBhYUntE1H5sOtMOOi-z6WIs6_8s@z>



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


In fact, similar to protocols such as GRE, there is no outer transport 
header.

Thanks.

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

