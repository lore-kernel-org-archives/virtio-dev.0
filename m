Return-Path: <virtio-dev-return-11528-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E60DC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:24:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9E002A883
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:24:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA7399866F9
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:24:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9738C9866EE; Wed,  8 Mar 2023 14:24:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 801389866EF;
	Wed,  8 Mar 2023 14:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdPqElg_1678285486;
Message-ID: <0d0dbd22-398a-03ec-3142-a3a920625a8e@linux.alibaba.com>
Date: Wed, 8 Mar 2023 22:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, Alvaro Karsz
 <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org,
 David Edmondson <david.edmondson@oracle.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <m2lekf1iq8.fsf@oracle.com> <20230306175558-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230306175558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation



在 2023/3/7 上午6:57, Michael S. Tsirkin 写道:
> On Thu, Mar 02, 2023 at 11:36:18AM +0000, David Edmondson wrote:
>>> +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
>> Should this now be "whose index is \field{vqn}"?
> Ugh.  I guess we'll have to fix the number/index mess in the spec
> first. Parav you said you are looking into it?



# Where virtqueue number and virtqueue index are used.
   1. In the Virtqueue Configuration Section, use the virtqueue index: 
"Write the **virtqueue index** (first queue is 0) to queue_select."
   2. Both descriptions are used separately in the Notification Section.
       2.1 Here vqn is called virtqueue index:
             "When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, 
the driver sends an available buffer notification
               to the device by writing the **16-bit virtqueue index** 
of this virtqueue to the Queue Notify address.
               ...

               le32 {
                      vqn: 16;
                      next_off : 15;
                      next_wrap: 1;
              };
              ...

              If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the 
driver MUST use the queue_notify_data value instead of the **virtqueue 
index**."

       2.2 Here vqn is called virtqueue number:
             "When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, 
the Notification data contains the **Virtqueue number**.
             ...

             be32 {
                     vqn: 16;
                     next_off : 15;
                     next_wrap: 1;
              };
             ...

             When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, 
this notification involves sending the **virtqueue number** to the 
device (method depending on the transport).
             ...

             vqn -- **VQ number** to be notified."

# 0-based index and 0-based number are used respectively in the RSS Section:
1. "Field unclassified_queue contains the **0-based index** of the 
receive virtqueue to place unclassified packets in. Index 0 corresponds 
to receiveq1."
2. "use the result as the index in the indirection table to get 
**0-based number** of destination receiveq (value of 0 corresponds to 
receiveq1)."



\field{vqn} has been called '0-based virtqueue index' or '0-based 
virtqueue number',
I think both seem to be friendly to readers, so what are your options?

Thanks.

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

