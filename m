Return-Path: <virtio-dev-return-11877-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFF5C6FD18
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 08:13:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC5C32AC47
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 08:13:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1E68986574
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 08:13:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AEDAB986563; Fri, 31 Mar 2023 08:13:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DA55986565
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 Mar 2023 08:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4scQPEMxNHWAcDaoGr730w-1
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Halil Pasic
 <pasic@linux.ibm.com>
In-Reply-To: <20230330191114.77acd860.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 31 Mar 2023 10:13:51 +0200
Message-ID: <87jzyxcp8g.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Thu, Mar 30 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 30 Mar 2023 00:23:33 +0300
> Parav Pandit <parav@nvidia.com> wrote:
>
>> 1. Currently, virtqueue is identified between driver and device
>> interchangeably using either number or index terminology.
>> 
>> 2. Between PCI and MMIO transport the queue size (depth) is
>> defined as queue_size and QueueNum respectively.
>> 
>> To avoid confusion and to have consistency, unify them to use Number.
>> 
>> Solution:
>> a. Use virtqueue number description, and rename MMIO register as QueueSize.
>
> I'm in favor of replacing number with size where appropriate.
>
>> b. Replace virtqueue index with virtqueue number
>
> I don't see the benefit of replacing virtqueue index with virtqueue
> number.
>
> Currently virtqueue number is only used in the parts that describe
> notifications (Guest->Host), the rest of the spec uses virtqueue index.
>
> I argue that using a different term in that context than in the rest
> of the specification makes sense, because in the context of notifications
> the virtqueue isn't always identified by its index.
>
> More precisely: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in the
> context of notifications the virtqueue is identified by the
> so called "queue_notify_data"; if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated in the context of notifications the virtqueue is identified by
> the virtqueue index (as usual, for example in queue_select, or in
> the ccws).
>
> As I've pointed out in my comment to patch 2, I believe replacing
> virtqueue index with virtqueue number is detrimental to clarity.
>
> Thus please find a counter-proposal below. If there is interest
> I can make a series out of it, and prettify it. If I can't convince
> you guys, then I will have to get used to vqn and virtqueue number.

I would generally prefer "index" as well, but there seemed to be a
strong sentiment that we should go with "number"... so, what *is* the
actual general sentiment? It's hard to say, but maybe most people are
fine with either?

>
> AFAIR the other problem with index was the RSS for virtio-net. But there
> we are currently heading down a direction of introducing a new
> abstraction. This approach avoids confusion around the term 'virtqueue
> index' as much as it avoids confusion around the term 'virtqueue nuber'.
>
>
>> c. RSS area of virtio net has inherited some logic, describe it
>> using abstract rss_rq_id.
>
> -------------------------8<--------------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Thu, 30 Mar 2023 17:57:53 +0200
> Subject: [PATCH 1/1] content: clarify how virtques are identified
>
> Clarify how virtqueues are identified in the context of
> available notifications and in the context of RSS for
> virtio-net .
>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  content.tex                      | 15 ++++++++++-----
>  device-types/net/description.tex | 30 ++++++++++++++++++++++--------
>  transport-ccw.tex                |  2 +-
>  transport-pci.tex                |  7 ++++---
>  4 files changed, 37 insertions(+), 17 deletions(-)

(...)

> +struct rss_rq_id {
> +   le16 value; /* virtqueue index divided by two */
> +};
> +
>  struct virtio_net_rss_config {
>      le32 hash_types;
>      le16 indirection_table_mask;
> -    le16 unclassified_queue;
> -    le16 indirection_table[indirection_table_length];
> +    struct rss_rq_id unclassified_queue;
> +    struct rss_rq_id indirection_table[indirection_table_length];
>      le16 max_tx_vq;
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
>  };
>  \end{lstlisting}
> +
> +The type struct rss\_rq\_id is introduced to better distinguish receive queue
> +ids form other integral fields.
> +
> +A receive queue id is only defined for receive queues, as the virtqueue index
> +of the receive virtqueue divided by two (the virtqueue index of a receive
> +queue is always even). For example receiveq4 is identified by the virtqueue
> +index 6 and the receive queue id 3.

FWIW, I think this is much easier to understand.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

