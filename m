Return-Path: <virtio-dev-return-12110-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB9C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:42:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2026DC6360
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:42:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFDA59863D1
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:42:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD3C3983DFF; Tue, 11 Apr 2023 08:42:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAEEF986366;
	Tue, 11 Apr 2023 08:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VfrYbjp_1681202551;
Message-ID: <6df8e99a-de4e-4558-ef30-c98441f8066a@linux.alibaba.com>
Date: Tue, 11 Apr 2023 16:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: Parav Pandit <parav@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <336f9b36-6704-51a6-0097-22381c623b8b@linux.alibaba.com>
 <87o7nukfns.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87o7nukfns.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation



在 2023/4/11 下午4:05, Cornelia Huck 写道:
> On Thu, Mar 23 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> Hi all! If after reviewing it you feel it meets the necessary
>> requirements, I kindly request a vote.
>>
>> Thanks a lot!
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/166
> So this has been voted upon and accepted, but we have further discussion
> downthread.
>
> Should we merge the voted-upon version now and do further changes on
> top, or wait for the discussion to conclude first so that we can merge
> all of it in one go?
Hi, Cornelia.

According to Parav's excellent patch set work on "rename" I tracked and 
Halil and Michael's discussion,
the discussion is about vqn-> vq_notify_id, queue_notify_data-> 
queue_notify_id, virtqueue number->virtqueue index in the *Notifications 
chapter*;
in *MMIO Device Register Layout chapter*, QueueNum->QueueSize.
Thanks Parav for his respectable work and the reviewer's comments, which 
made the spec clearer.

We left the virtqueue number/index of RSS and virtqueue coalescing (this 
work) parts unchanged as suggested by Halil.
Please correct me if my trace missed something.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

