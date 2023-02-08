Return-Path: <virtio-dev-return-10831-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29C6B986529
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 22:36:22 +0000 (UTC)
MIME-Version: 1.0
References: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com> <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org> <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org> <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com> <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 9 Feb 2023 00:35:42 +0200
Message-ID: <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > Sent: Wednesday, February 8, 2023 4:56 PM
>
> > > Alvaro,
> > > Do you know if any software used it? Can you get some real data?
> >
> > I implemented this feature in our DPU, so at least 1 vendor is using this feature
>
> But which software (virtio net driver) in which OS is using this?

Sorry, I'm not sure I understand your question.

The feature is implemented in the linux kernel
https://github.com/torvalds/linux/commit/699b045a8e43bd1063db4795be685bfd659649dc
So we'll always have kernel versions accepting this feature, if offered.

> > (I will add support for the per vq command of course).
> > I really don't know about other vendors..
> >
> > You are suggesting to reserve the command and feature bit for safety, so, if we
> > reserve them, why not just use them? What do we lose here?
> >
> If it is used by some unknown software, only that sw breaks by using non release spec.
> If we use it by changing the definition, it may break that unknown sw.
> If we know there is no known sw, we are better of with redefinition (by adding vqn, and by removing tx,rx from it).
>
> > Not having this feature/command even complicates things now that we are
> > talking about removing the RX and TX from the per vq command, how do you
> > change parameters to all TX queues? to all RX queues? we'll need 2 special
> > indexes, so we now need le32 to hold the queue index.
> No need for special index.
> How does a driver disable all queues or reset all queues? -> One by one.
> So if user want to change for all TXQ, sw can do it one by one by iterating TXQ vqns.

Yes, but resetting the queues doesn't require a control command.
If a server has 64K queues, and a user wants to set all coalescing
parameters to X (maybe with ethtool), it will generate 64K control
commands..

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

