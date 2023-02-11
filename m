Return-Path: <virtio-comment-return-4145-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
In-Reply-To: <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 11 Feb 2023 11:42:06 +0200
Message-ID: <CAJs=3_C7fZpjPLFbhqGFgtvQ2EQSCY7NQFzJn_7Ux3B1Ls=Hgg@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > Please add short description something like,
> >
> > When the driver prefers to use per virtqueue notifications coalescing, and if queue group (transmit or receive) level notification coalescing is enabled, driver SHOULD first disable device level notification coalescing.
> > Or it should be,
> >
>
> I disagree here.
> IMO "queue group level notification coalescing" is not something to
> enable or disable, but a shortcut to set all TX/RX queues at once.
> Why should the spec force a driver to "disable device level
> notification coalescing" (I assume you mean send a
> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET command with zeros)?
> What if the driver sends a VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET
> command, and then a single queue traffic increases? why should it zero
> the parameters to all other queues?
> I think that this should be discussed in the driver implementation
> stage, not in the spec.
>
> > Virtqueue level notifications coalescing, and device level notifications can be enabled together.
> > When both of them are enabled, per virtqueue notifications coalescing take priority over queue group level.
>
> How do you enable  Virtqueue level notifications coalescing? Why are
> they different entities?
> I don't think that we should have priorities, but the last command
> should be the one that dictates the coalescing parameters.
>
> For example, let's look at vq0 (RX):
> Device receives VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, vq0 should change
> the parameters accordingly (all RX vqs should do the same).
> Then device receives VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with vqn = 0,
> vq0 changes the parameters accordingly (all RX vqs are still using the
> "old" parameters)

Opps, I missed a word in here, it should have been:
Then device receives VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with vqn = 0,
vq0 changes the parameters accordingly (all RX vqs EXCEPT FOR vq0
still use the previous parameters)

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

