Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
Date: Wed, 1 Mar 2023 10:56:31 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
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

Yes, you are right. That's what we did before the inner header hash, but 
it has a performance penalty, which I'll explain below.

> For example geneve spec says:
>
>     it is necessary for entropy from encapsulated packets to be
>     exposed in the tunnel header.  The most common technique for this is
>     to use the UDP source port

The end point of the tunnel called the gateway (with DPDK on top of it).

1. When there is no inner header hash, entropy can be inserted into the 
udp src port of the outer header of the tunnel,
and then the tunnel packet is handed over to the host. The host needs to 
take out a part of the CPUs to parse the outer headers (but not drop them)
to calculate the inner hash for the inner payloads, and then use the 
inner hash to forward them to another part of the CPUs that are 
responsible for processing.
1). During this process, the CPUs on the host is divided into two parts, 
one part is used as a forwarding node to parse the outer header,
      and the CPU utilization is low. Another part handles packets.
2). The entropy of the source udp src port is not enough, that is, the 
queue is not widely distributed.

2. When there is an inner header hash, the gateway will directly help 
parse the outer header, and use the inner 5 tuples to calculate the 
inner hash.
The tunneled packet is then handed over to the host.
1) All the CPUs of the host are used to process data packets, and there 
is no need to use some CPUs to forward and parse the outer header.
2) The entropy of the original quintuple is sufficient, and the queue is 
widely distributed.

Thanks.

>
> same goes for vxlan did not check further.
>
> so what is the problem?  and which tunnel types actually suffer from the
> problem?
>

