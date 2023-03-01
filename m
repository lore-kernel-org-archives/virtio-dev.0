Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <c778af08-7aac-ca35-30d2-c18bd52c5cec@linux.alibaba.com>
Date: Wed, 1 Mar 2023 11:30:37 +0800
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [PATCH v9] virtio-net: support inner header
 hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230228061309-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230228061309-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>> If the tunnel is used to encapsulate the packets, the hash calculated
>> using the outer header of the receive packets is always fixed for the
>> same flow packets, i.e. they will be steered to the same receive queue.
> Wait a second. How is this true? Does not everyone stick the
> inner header hash in the outer source port to solve this?
> For example geneve spec says:
>
>     it is necessary for entropy from encapsulated packets to be
>     exposed in the tunnel header.  The most common technique for this is
>     to use the UDP source port
>
> same goes for vxlan did not check further.
>
> so what is the problem?  and which tunnel types actually suffer from the
> problem?


In fact, similar to protocols such as GRE, there is no outer transport 
header.

Thanks.

>

