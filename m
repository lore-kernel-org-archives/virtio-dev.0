Return-Path: <virtio-dev-return-11318-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57CD4986561
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 17:33:28 +0000 (UTC)
Date: Mon, 27 Feb 2023 12:33:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230227123226-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
 <PH0PR12MB5481CA831447E7E7AEA46A58DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CA831447E7E7AEA46A58DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH 0/3] Rename queue index to queue number
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 27, 2023 at 04:00:24PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Monday, February 27, 2023 3:46 AM
> > 
> > On Thu, Feb 23 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > 1. Currently, virtqueue is identified between driver and device
> > > interchangeably using either number of index terminology.
> > >
> > > 2. Between PCI and MMIO transport the queue size (depth) is defined as
> > > queue_size and QueueNum respectively.
> > >
> > > To avoid confusion and to have consistency, unify them to use as Number.
> > >
> > > Solution:
> > > Use virtqueue number description, and rename MMIO register as QueueSize.
> > >
> > > Patch summary:
> > > patch-1 renames index to number for pci transport
> > > patch-2 renames mmio register from Num to Size
> > > patch-3 renames index to number for mmio transport
> > >
> > > Please review.
> > > This series fixes the issue [1].
> > >
> > > This series is on top of [2].
> > >
> > > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> > > [2]
> > > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
> > >
> > > ---
> > > Cornelia:
> > > I was not sure about ccw for vq_config_block and vq_info_block
> > > structures index field refers to the queue number or not.
> > > Can you please clarify?
> > >
> > > If it vqn, I will send v1 by replacing index to vqn to be consistent
> > > with other part of the spec which also uses vqn.
> > 
> > The vq_*_block structures use "index" for the vq index/number and "num"
> > for the number of buffers (queue size).
> > 
> Shall I change it too given the below response?
> Or ccw sync is not very interesting at this point?

I'm for changing this. I am guessing Cornelia didn't being it up
just to move some electrons around either...

> > I'm wondering what terminology we should standardize on. For the size of the
> > queue, we have queue_size, QueueNum, and num. Calling it some variation of
> > "queue size" and mentioning that it refers to the number of buffers makes
> > sense.
> > 
> > For the vq index/number, I'm not that sure that "virtqueue number" is better
> > that "virtqueue index" -- actually, I'd prefer the latter. We'd need some
> > renaming either way.
> 
> In other thread, we discussed with Michael to use vq number to align to the following ongoing work.
> 1. existing spec 
> 2. future patches that he wrote for AQ (v10)
> 3. VQ level interrupt moderation patches (v9)
> #2 and #3 uses vq number terminology.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

