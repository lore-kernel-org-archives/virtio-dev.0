Return-Path: <alvaro.karsz@solid-run.com>
MIME-Version: 1.0
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org> <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org> <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
 <20230217062539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217062539-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 17 Feb 2023 14:17:34 +0200
Message-ID: <CAJs=3_Am5rpEnHjRZNEZVryxAOc69gJQcSbVXphn63CvsWenCw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Not good. I feel we must come up with spec that is backwards compatible.
> Hmm, maybe this is why Parav kept talking about modes.
> I did not realize at the time, sorry Parav.
>
> I still feel modes are not the best way to describe things so I propose this:
> - in addition to per vq parameters, device that supports global TX/RX
>   commands and ring reset maintains two sets of default parameters: for RX and TX
> - existing commands change default and change all enabled vqs
>   of the correct type (RX/TX) to the same value
> - vq reset changes a vq to the default
> - device reset changes defaults to 0 and changes all vqs to  0
>
> note how defaults are only used for ring reset.  is "vq reset parameter"
> a better name? I feel we will repeat "reset" too many times in a
> sentence if we call it that though.
>
> So fundamentally the only change is with RING_RESET, then
> default is not always 0, it can be set by the global command.

I like the idea, maintaining default coalescing parameters is
compatible with vq reset.

"After a queue has been reset by the driver, the device MUST NOT
execute any requests from that virtqueue, or notify the driver for it.
The device MUST reset any state of a virtqueue to the *default state*,
including the available state and the used state."

I wonder if some of that should be included in my patch.
Most of that is not relevant before introducing the per vq command.
So maybe I could just mention in the device conformance that:
"Coalescing parameters MUST/SHOULD persist a virtqueue reset."

And then Heng can edit/add on top of that.


Now that the existing commands do more than just iterating through all
the virtqueues, maybe we should be able to modify all virtqueues with
VIRTIO_NET_F_VQ_NOTF_COAL.

I think that using a special vqn is messy, we can split "le32
reserved" to "le16 flags" and "le16 reserved".
Then we can have:
- A flag to apply parameters to all receive VQs, vqn is ignored in
this case. (same as VIRTIO_NET_CTRL_NOTF_COAL_RX_SET but without
changing the default parameters).
- A flag to apply parameters to all transmit VQs, vqn is ignored in
this case. (same as VIRTIO_NET_CTRL_NOTF_COAL_TX_SET but without
changing the default parameters).

And maybe a flag to apply to all vqs (transmit + receive), I actually
am not sure how useful this is..

