Return-Path: <virtio-comment-return-4166-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sun, 12 Feb 2023 04:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230212043434-mutt-send-email-mst@kernel.org>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
 <PH0PR12MB548143E73BFAD7207F60F5DFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548143E73BFAD7207F60F5DFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue coalescing
 moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 11, 2023 at 01:47:16PM +0000, Parav Pandit wrote:
> 
> 
> > From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > Sent: Saturday, February 11, 2023 3:45 AM
> > 
> > > Please add short description something like,
> > >
> > > When the driver prefers to use per virtqueue notifications coalescing, and if
> > queue group (transmit or receive) level notification coalescing is enabled, driver
> > SHOULD first disable device level notification coalescing.
> > > Or it should be,
> > >
> > 
> > I disagree here.
> > IMO "queue group level notification coalescing" is not something to enable or
> > disable, but a shortcut to set all TX/RX queues at once.
> That short cut is the enable/disablement.
> 
> > Why should the spec force a driver to "disable device level notification
> > coalescing" (I assume you mean send a
> > VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET command with zeros)?
> Yes. Because to have well defined behavior when sw configured both one after the another.
> 
> > What if the driver sends a VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET
> > command, and then a single queue traffic increases? why should it zero the
> > parameters to all other queues?
> That is short transition when driver is switching over to per queue mode.
> This is fine to have short glitch.
> 
> > I think that this should be discussed in the driver implementation stage, not in
> > the spec.
> > 
> There should be a clear guidance on how device should behave when both per q and per device are configured.
> 
> > > Virtqueue level notifications coalescing, and device level notifications can be
> > enabled together.
> > > When both of them are enabled, per virtqueue notifications coalescing take
> > priority over queue group level.
> > 
> > How do you enable  Virtqueue level notifications coalescing? Why are they
> > different entities?
> Using the new command that has vqn in it.
> 
> > I don't think that we should have priorities, but the last command should be the
> > one that dictates the coalescing parameters.
> > 
> Priority is applicable when driver has issued both the commands. Per tx/rx, and per vqn.
> 
> > For example, let's look at vq0 (RX):
> > Device receives VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, vq0 should change
> > the parameters accordingly (all RX vqs should do the same).
> > Then device receives VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with vqn = 0,
> > vq0 changes the parameters accordingly (all RX vqs are still using the "old"
> > parameters) Then device receives VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, vq0
> > changes the parameters accordingly (all RX vqs should do the same).
> In this example, per VQ were overridden with per device.
> Yes, so the last one is applicable, so priority of last one applies.
> 
> We continue to refuse to add the mode, and hence need to supply these description of both the sequence on how device should behave.
> 
> Sequence_1:
> 1. tx/rx group level
> 2. per vqn level
> When #2 is done, VQ's whose per vq level is configured, follows vqn, rest of the VQs follow #1.
> 
> Sequence_2:
> 1. per vqn
> 2. tx/rx group level
> When #2 is done, group level overrides the per vqn parameters. 

Since there's apparently some room for misunderstanding, I think adding these examples can't hurt.
I would also be more specific and just use specific numbers in the
example, to avoid any ambiguity.

-- 
MST


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

