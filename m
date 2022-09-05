Return-Path: <virtio-dev-return-9889-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1653986298
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Sep 2022 08:03:51 +0000 (UTC)
Message-ID: <1662364338.205864-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 5 Sep 2022 15:52:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <20220902023546-mutt-send-email-mst@kernel.org>
 <94937aaa-e3c0-74fe-290c-59884c6eb9a4@linux.alibaba.com>
 <20220904162809-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220904162809-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, kangjie.xu@linux.alibaba.com, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, 4 Sep 2022 16:31:59 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Sep 02, 2022 at 04:58:16PM +0800, Heng Qi wrote:
> > When VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated,
> > the driver requires that the buffers submitted to receiveq
> > MUST be composed of at least two descriptors,
> > which means that each buffer the device gets is a descriptor chain,
> > even if the device does not split the header for some packets.
> >
> > To store packet in the descriptor chain without header splitting
> > by the device, the device MUST start with the first descriptor of
> > the descriptor chain to store the packet, and MUST NOT set the
> > VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.
> >
> > Thanks.
>
> Descriptor chains will hurt performance badly.

I understand the reasons for the performance impact here are:
1. Two buffers are used
2. One buffer occupies two descs

This is the same as my understanding in the case of mergeable. We also need to
pack the packets into two buffers, and a packet will eventually occupy two
descs.


> How about simply making this feature depend on mergeable buffers?
> Then we have a separate buffer for the header and
> this works cleanly.


Under mergeable, each buffer is independent, and the split header requires two
unequal descs.

If we implement it based on mergeable, then consider the scenario of tcp
zerocopy, when we fill receive vq, each buffer is an separate page, and if we use an
separate buffer to save the header, then this is a waste, we may
have to copy at the driver layer.

@Qi Do you think there will be other problems with this approach?

Thanks.



>
> --
> MST
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

