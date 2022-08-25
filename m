Return-Path: <virtio-dev-return-9836-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4F199864BA
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Aug 2022 14:23:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
Date: Thu, 25 Aug 2022 16:22:59 +0200
Message-ID: <87v8qgo118.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v7] virtio_net: support split header
Content-Type: text/plain
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 16 2022, Heng Qi <hengqi@linux.alibaba.com> wrote:

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> The purpose of this feature is to split the header and the payload of
> the packet.
>
> |                    receive buffer                                    |
> |                       0th descriptor             | 1th descriptor    |
> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
>
> We can use a buffer plus a separate page when allocating the receive
> buffer. In this way, we can ensure that all payloads can be
> independently in a page, which is very beneficial for the zerocopy
> implemented by the upper layer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> ---
> v7:
> 	1. Fix some presentation issues.
> 	2. Use "split transport header". @Jason Wang
> 	3. Clarify some paragraphs. @Cornelia Huck
> 	4. determine the device what to do if it does not perform header split on a packet.
>
> v6:
> 	1. Fix some syntax issues. @Cornelia Huck
> 	2. Clarify some paragraphs. @Cornelia Huck
> 	3. Determine the device what to do if it does not perform header split on a packet.
>
> v5:
> 	1. Determine when hdr_len is credible in the process of rx
> 	2. Clean up the use of buffers and descriptors
> 	3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge
>
> v4:
> 	1. fix typo @Cornelia Huck @Jason Wang
> 	2. do not split header for IP fragmentation packet. @Jason Wang
>
> v3:
> 	1. Fix some syntax issues
> 	2. Fix some terminology issues
> 	3. It is not unified with ip alignment, so ip alignment is not included
> 	4. Make it clear that the device must support four types, in the case of successful negotiation.
>
>  conformance.tex |   2 ++
>  content.tex     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)

I do not have any further comments on the change, let's see what the
networking folks think.

[Do we require patches to be posted to virtio-comment, or is virtio-dev
enough? I'm a bit unsure right now.]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

