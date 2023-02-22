Return-Path: <mst@redhat.com>
Date: Wed, 22 Feb 2023 01:21:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230222010326-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <32675f1a-5da4-dc78-a03f-8c173f59c7da@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <32675f1a-5da4-dc78-a03f-8c173f59c7da@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 22, 2023 at 10:34:39AM +0800, Heng Qi wrote:
> > The user will figure out how to mitigate when such QoS is not available. Either to run in best-effort mode or mitigate differently.
> 
> Yes, our cloud security and cloud network team will configure and use inner
> hash on dpdk.

Sounds good. More practical for dpdk than Linux.
Is there a chance that when the interface is close
to be final, but before the vote, you post a patch to the dpdk list and
get some acks from the maintainers, cc virtio-dev. This way we won't
merge something that will then go unused?
That would be best - do you have a prototype?

> In fact I discussed with them the security issues between
> tunnels,
> and I will quote their solutions to tunnel attacks below, but this is a
> problem between the tunnels, not the introduction of inner hash.
> I don't think we need to focus too much on this, but I'll do my best to
> describe the security issues between tunnels in v10.
> 
> "
> This is not a problem with the inner hash, it is a general problem with the
> outer hash.
> I communicated with our people who are doing cloud security (they are also
> one of the demanders of inner hash),
> and it is a common problem for one tunnel to attack another tunnel.
> 
> For example, there is a tunnel t1; a tunnel t2; a tunnel endpoint VTEP0, and
> the vni id of t1 is id1, and the vni id of v2 is id2; a VM.
> 
> At this time, regardless of the inner hash or the outer hash, the traffic of
> tunnel t1 and tunnel t2 will reach the VM through VTEP0 (whether it is a
> single queue or multiple queues),
> and may be placed on the same queue to cause queue overflow.

Do note (and explain in spec?) that with just an outer hash and RSS it
is possible to configure the tunnels to use distict queues. Impossible
with this interface but arguably only works for a small number of
tunnels anyway.

> # Solutions:

More like mitigations.

> 1. Some current forwarding tools such as DPDK have good forwarding
> performance, and it is difficult to fill up the queue;

Oh that's a good point. If driver is generally faster than the device
and queues stay away from filling up there's no DoS.
I'd add this to the spec.

> 2. or switch the attack traffic to the attack clusters;

What is that?

> 3. or connect the traffic of different tunnels to different network card
> ports or network devices.

Not sure how this is relevant. These a distinct outer MAC - with this
why do we need a tunnel?

> 4..
> "

