Return-Path: <mst@redhat.com>
Date: Tue, 28 Feb 2023 06:16:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230228061309-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230218143715.841-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> If the tunnel is used to encapsulate the packets, the hash calculated
> using the outer header of the receive packets is always fixed for the
> same flow packets, i.e. they will be steered to the same receive queue.

Wait a second. How is this true? Does not everyone stick the
inner header hash in the outer source port to solve this?
For example geneve spec says:

   it is necessary for entropy from encapsulated packets to be
   exposed in the tunnel header.  The most common technique for this is
   to use the UDP source port

same goes for vxlan did not check further.

so what is the problem?  and which tunnel types actually suffer from the
problem?

-- 
MST

