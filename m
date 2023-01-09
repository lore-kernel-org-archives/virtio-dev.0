Return-Path: <mst@redhat.com>
Date: Mon, 9 Jan 2023 06:39:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7] virtio-net: support inner header hash
Message-ID: <20230109063654-mutt-send-email-mst@kernel.org>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230104071401.31746-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 04, 2023 at 03:14:01PM +0800, Heng Qi wrote:
> +are defined below:
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_REPORT_TUNNEL_NONE     0
> +#define VIRTIO_NET_HASH_REPORT_GRE             1
> +#define VIRTIO_NET_HASH_REPORT_VXLAN           2
> +#define VIRTIO_NET_HASH_REPORT_GENEVE          3
> +\end{lstlisting}

Btw this "are defined below" all over the place is just contributing
to making the spec unnecesarily verbose. Simple "are:" will do.

-- 
MST

