Return-Path: <virtio-dev-return-9888-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B1FE985FFA
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Sep 2022 20:32:09 +0000 (UTC)
Date: Sun, 4 Sep 2022 16:31:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220904162809-mutt-send-email-mst@kernel.org>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <20220902023546-mutt-send-email-mst@kernel.org>
 <94937aaa-e3c0-74fe-290c-59884c6eb9a4@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <94937aaa-e3c0-74fe-290c-59884c6eb9a4@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 02, 2022 at 04:58:16PM +0800, Heng Qi wrote:
> When VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated,
> the driver requires that the buffers submitted to receiveq
> MUST be composed of at least two descriptors,
> which means that each buffer the device gets is a descriptor chain,
> even if the device does not split the header for some packets.
> 
> To store packet in the descriptor chain without header splitting
> by the device, the device MUST start with the first descriptor of
> the descriptor chain to store the packet, and MUST NOT set the
> VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.
> 
> Thanks.

Descriptor chains will hurt performance badly.
How about simply making this feature depend on mergeable buffers?
Then we have a separate buffer for the header and
this works cleanly.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

