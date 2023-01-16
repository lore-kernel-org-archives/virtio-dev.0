Return-Path: <virtio-dev-return-10621-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B249298633D
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Jan 2023 08:18:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230116080106.GA114763@h68b04307.sqa.eu95>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
Date: Mon, 16 Jan 2023 09:18:16 +0100
Message-ID: <87k01mnb93.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net: support inner
 header hash
Content-Type: text/plain
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 16 2023, Heng Qi <hengqi@linux.alibaba.com> wrote:

> On Wed, Jan 11, 2023 at 04:45:12AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Jan 04, 2023 at 03:14:01PM +0800, Heng Qi wrote:
>> > @@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>> >          le16 num_buffers;
>> >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>> >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>> > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>> > +        u8 hash_report_tunnel;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated, only valid of VIRTIO_NET_F_HASH_TUNNEL negotiated)
>> 
>> of -> if?
>
> Sorry for the late reply.
> It's Cornelia's suggestion, and 'of' seems to work fine.

I think that was simply a typo, should have been 'if'.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

