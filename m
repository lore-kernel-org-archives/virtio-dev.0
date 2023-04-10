Return-Path: <virtio-dev-return-12090-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432BC77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AF7932AC4E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C8E198669D
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 13:35:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A7B6A98632A; Mon, 10 Apr 2023 13:35:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 485C4986319;
	Mon, 10 Apr 2023 13:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VfoBWql_1681133635;
Message-ID: <8a08b4ee-3b9a-86a0-6c42-b227a971e815@linux.alibaba.com>
Date: Mon, 10 Apr 2023 21:33:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 David Edmondson <david.edmondson@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230404182925.349d402e.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation



在 2023/4/5 上午12:29, Halil Pasic 写道:
> On Thu, 23 Mar 2023 23:24:22 +0800
> Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>> +struct virtio_net_ctrl_coal_vq {
>> +    le16 vqn;
>> +    le16 reserved;
>> +    struct virtio_net_ctrl_coal coal;
>> +};
>> +
>>   #define VIRTIO_NET_CTRL_NOTF_COAL 6
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>>    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
>> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>>   \end{lstlisting}
>>   
>>   Coalescing parameters:
>>   \begin{itemize}
>> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
> Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated, and queue_select != queue_notify_data, is vqn supposed
> to contain queue_notify_data or the number/index that is used for
> queue_select (I'm talking about the PCI transport case)?

Queue event notification is based on transport, as we know, this should 
be discussed in the virtio transport chapter.
Virtqueue coalescing moderation uses the same vqn field as 
notifications, but this has a completely different meaning.
For example, when VIRTIO_F_NOTIF_CONFIG_DATA is negotiated, vqn uses the 
identifier (which Parav is doing) represented by q_notify_data,
such as virtqueue index/number or offset, etc.
vqn here does not belong to the PCI configuration space, because now we 
have involved controlq, which is used to set the non-configuration space.

Thanks.


>
> Regards,
> Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

