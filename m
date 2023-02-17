Return-Path: <virtio-comment-return-4332-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org> <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217053039-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 17 Feb 2023 13:17:50 +0200
Message-ID: <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > Yes, max_packets and max_usecs SHOULD be reset to 0.
> > When the virtqueue is re-enabled, it means that notification conditions are met after each packet is sent/received.
> >
> > As described by Alvaro in "[PATCH v5] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL feature":
> > "+When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the notification conditions are met after every packet received/sent."
>
> Oh. Hmm.
>
> What Alvaro's patch does not describe is what happens when VQ is reset.
>
> Alvaro you said you have hardware implementing this right?
> How does the command interact with vq reset?
>

The device doesn't offer VIRTIO_F_RING_RESET at the moment.

>
> > > What about VIRTIO_NET_CTRL_NOTF_COAL?
> >
> > I think it should be handled in the same way as the above VQ_SET, that is, reset the corresponding virtqeuue parameters to 0.
>
> sounds consistent. but the problem is, I don't think this is
> how we previously behaved. and RING_RESET is out in 1.2.
> So we need something compatible. I am sorry.
>
> I suspect that instead we can say that existing hardware has a default set of
> parameters for tx and rx. And global commands change that
> besides changing all enabled VQs.
>
> That is a side effect beyond just changing all VQs.
>
> Hmm.
> Alvaro?
>

This is indeed a good point.
We mention the device reset case, but nothing about VQ reset.

I feel that no matter how we handle this, we break something.

Having default coalescing values may collide with "Upon reset, a
device MUST initialize all coalescing parameters to 0."

We can say that VQ reset doesn't affect the "global parameters" and a
device reset does, but this collides with "Device Requirements:
Virtqueue Reset".

In fact, resetting coalescing values after vq reset may be derived
from "Upon reset, a device MUST initialize all coalescing parameters
to 0".
This is consistent with "Device Requirements: Virtqueue Reset".

I can add in my patch some clarifications.

This will break the linux virtio_net ethtool implementation a little,
we'll need to fix it.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

