Return-Path: <virtio-dev-return-10829-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94CA7986529
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 22:29:22 +0000 (UTC)
Date: Wed, 8 Feb 2023 17:29:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208172646-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
 <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208171348-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AE46696AD124FD436DF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AE46696AD124FD436DF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 10:23:00PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 8, 2023 5:16 PM
> > > > Not having this feature/command even complicates things now that we
> > > > are talking about removing the RX and TX from the per vq command,
> > > > how do you change parameters to all TX queues? to all RX queues?
> > > > we'll need 2 special indexes, so we now need le32 to hold the queue index.
> > > No need for special index.
> > > How does a driver disable all queues or reset all queues? -> One by one.
> > > So if user want to change for all TXQ, sw can do it one by one by iterating TXQ
> > vqns.
> > 
> > I think we can split this effort in two parts:
> > 
> > 1. add a new command and feature bit
> > 2. drop the old command
> > 
> > 
> > Looks like there's consensus on 1?  And it looks like Alvaro wants to work on 1
> > but not 2. Once that is in Parav can work on 2 if he wants to.
> 
> 3. rename the current one if there is no sw driver that used it.

That's probably the worst of all options, silently changing behaviour.

> May be lets wait for Alvaro's answer if there is any sw that used.
> 
> Doing #3 would be the simplest for all devices and sw to implement and consume respectively.
> 
> I can work with Alvaro to have 1 and 2 as part of same series as two patches, so that we don't have to re-discuss this again.
> Without that 
> a. negotiating two bits at same time is hard.
> b. Wording #1 also need to mention about what happens when global is also negotiated and device is in partial mode.

There's no mode, partial or otherwise, in either Alvaro's or my
proposal.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

