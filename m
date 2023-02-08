Return-Path: <virtio-comment-return-4071-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 8 Feb 2023 17:57:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208175438-mutt-send-email-mst@kernel.org>
References: <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
 <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
Subject: Re: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Parav Pandit <parav@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 12:35:42AM +0200, Alvaro Karsz wrote:
> > > From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > > Sent: Wednesday, February 8, 2023 4:56 PM
> >
> > > > Alvaro,
> > > > Do you know if any software used it? Can you get some real data?
> > >
> > > I implemented this feature in our DPU, so at least 1 vendor is using this feature
> >
> > But which software (virtio net driver) in which OS is using this?
> 
> Sorry, I'm not sure I understand your question.
> 
> The feature is implemented in the linux kernel
> https://github.com/torvalds/linux/commit/699b045a8e43bd1063db4795be685bfd659649dc
> So we'll always have kernel versions accepting this feature, if offered.
> 
> > > (I will add support for the per vq command of course).
> > > I really don't know about other vendors..
> > >
> > > You are suggesting to reserve the command and feature bit for safety, so, if we
> > > reserve them, why not just use them? What do we lose here?
> > >
> > If it is used by some unknown software, only that sw breaks by using non release spec.
> > If we use it by changing the definition, it may break that unknown sw.
> > If we know there is no known sw, we are better of with redefinition (by adding vqn, and by removing tx,rx from it).
> >
> > > Not having this feature/command even complicates things now that we are
> > > talking about removing the RX and TX from the per vq command, how do you
> > > change parameters to all TX queues? to all RX queues? we'll need 2 special
> > > indexes, so we now need le32 to hold the queue index.
> > No need for special index.
> > How does a driver disable all queues or reset all queues? -> One by one.
> > So if user want to change for all TXQ, sw can do it one by one by iterating TXQ vqns.
> 
> Yes, but resetting the queues doesn't require a control command.
> If a server has 64K queues, and a user wants to set all coalescing
> parameters to X (maybe with ethtool), it will generate 64K control
> commands..

Amount of time spent on bike-shedding here is mind-boggling.  Pls just
send a new version and we'll go from there.  In the end it's a majority
we don't have to have consensus if we can't get it.

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

