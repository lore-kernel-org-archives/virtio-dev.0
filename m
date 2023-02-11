Return-Path: <virtio-comment-return-4147-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com> <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com>
In-Reply-To: <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 11 Feb 2023 12:18:45 +0200
Message-ID: <CAJs=3_Az-v8dm3NO6hgEm27zPfk2=6PMu93rzzvinnuD7MHUKQ@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >> Please add short description something like,
> >>
> >> When the driver prefers to use per virtqueue notifications coalescing, and if queue group (transmit or receive) level notification coalescing is enabled, driver SHOULD first disable device level notification coalescing.
> >> Or it should be,
> >>
> > I disagree here.
> > IMO "queue group level notification coalescing" is not something to
> > enable or disable, but a shortcut to set all TX/RX queues at once.
> > Why should the spec force a driver to "disable device level
> > notification coalescing" (I assume you mean send a
> > VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET command with zeros)?
> > What if the driver sends a VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET
> > command, and then a single queue traffic increases? why should it zero
> > the parameters to all other queues?
>
> Hi, Alvaro! Thanks for your reply!
>
> I think Parav refers more to the scene where ethool sets parameters at
> the queue group level and
> the scene where netdim sets parameters for a single queue. In this
> scenario, netdim should really
> determine the coalescing parameters of the device, and the parameters at
> the queue group level set
> by ethtool should be ignored (many drivers are designed this way, such
> as mlx), that is, we need to give netdim the right,
> because it It has the ability to dynamically adjust parameters.
> (However, I think this friendly constraint is also possible in driver
> implementation.)
>
> Of course, if we consider setting coalescing parameters at the queue
> group level and single queue level separately through ethtool,
> then as you said, we should not set any priority for them.
>
> Back to reality, I think the function of ethtool to set single queue
> parameters may come later, which is thankless for users because of netdim.
>
> Therefore, if our specification tends to be practical, we can add
> Parav's proposal, and if our specification tends to be more general,
> then hand over
> the constraints to the driver implementation. what do you think?

Hi,
I understand your and Parav's point, and that this is needed for netdim.
I just think that the spec should not dictate this, and this should be
implementation specific.
What if a OS with a different adaptive functionality wants to support
these features?

This is just my opinion though.

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

