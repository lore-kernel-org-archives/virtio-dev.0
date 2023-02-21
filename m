Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 12:50:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230221124518-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230218143715.841-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> +\subparagraph{Security risks between encapsulated packets and RSS}
> +There may be potential security risks when encapsulated packets using RSS to
> +select queues for placement. When a user inside a tunnel tries to control the
> +enqueuing of encapsulated packets, then the user can flood the device with invaild
> +packets, and the flooded packets may be hashed into the same queue as packets in
> +other normal tunnels, which causing the queue to overflow.
> +
> +This can pose several security risks:
> +\begin{itemize}
> +\item  Encapsulated packets in the normal tunnels cannot be enqueued due to queue
> +       overflow, resulting in a large amount of packet loss.
> +\item  The delay and retransmission of packets in the normal tunnels are extremely increased.
> +\item  The user can observe the traffic information and enqueue information of other normal
> +       tunnels, and conduct targeted DoS attacks.
> +\end{\itemize}
> +

Hmm with this all written out it sounds pretty severe.
At this point with no ways to mitigate, I don't feel this is something
e.g. Linux can enable.  I am not going to nack the spec patch if
others  find this somehow useful e.g. for dpdk. 
How about CC e.g. dpdk devs or whoever else is going to use this
and asking them for the opinion?


-- 
MST

