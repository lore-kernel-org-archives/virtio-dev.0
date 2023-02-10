Return-Path: <virtio-dev-return-10893-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05676986622
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Feb 2023 10:16:56 +0000 (UTC)
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <CAJs=3_BbbzsYApYkdeZ4+vTcZ9qE+4eG-yDJJ_ZW3vdJEn-drQ@mail.gmail.com>
 <20230210043631-mutt-send-email-mst@kernel.org> <6a3dd0a1-d597-8e12-e0e5-0a8817e097b0@linux.alibaba.com>
In-Reply-To: <6a3dd0a1-d597-8e12-e0e5-0a8817e097b0@linux.alibaba.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 10 Feb 2023 12:16:16 +0200
Message-ID: <CAJs=3_D2Sx8f4BXGoK3LEJ9Lcv9wVMqA45OaJvtA0Xt7kuFD+g@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >> So, should we remove VIRTIO_NET_F_CTRL_VQ here, or fix VIRTIO_NET_F_HOST_ECN?
> > Ah good point.
> > But I think  VIRTIO_NET_F_VQ_NOTF_COAL should not depend on VIRTIO_NET_F_NOTF_COAL.
> > This way devices can drop the all-rx/all-tx commands if they want to.
>
> We need to confirm this. If we make VIRTIO_NET_F_VQ_NOTF_COAL
> independent of VIRTIO_NET_F_NOTF_COAL,
> do we need to give vqn a special value so that the driver can also have
> the fast path of sending all queues with global settings via
> VIRTIO_NET_F_VQ_NOTF_COAL?

IMO we don't need a special vqn value.
A device that can modify all the vqs should offer VIRTIO_NET_F_NOTF_COAL.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

