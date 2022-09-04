Return-Path: <mst@redhat.com>
Date: Sun, 4 Sep 2022 16:27:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7] virtio_net: support split header
Message-ID: <20220904162337-mutt-send-email-mst@kernel.org>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
> We need to clarify that the purpose of header splitting is to make all payloads
> can be independently in a page, which is beneficial for the zerocopy
> implemented by the upper layer.

absolutely, pls add motivation.

> If the driver does not enforce that the buffers submitted to the receiveq MUST
> be composed of at least two descriptors, then header splitting will become meaningless,
> or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not be negotiated at this time.
> 
> 
> Thanks.
> 
> 


This seems very narrow and unecessarily wasteful of descriptors.
What is wrong in this:

<header>...<padding>... <beginning of page><data>

seems to achieve the goal of data in a separate page without
using extra descriptors.

thus my proposal to replace the requirement of a separate
descriptor with an offset of data from beginning of
buffer that driver sets.


-- 
MST

