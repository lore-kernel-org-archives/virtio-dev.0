Return-Path: <virtio-dev-return-9465-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75C8D98643E
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Apr 2022 09:05:41 +0000 (UTC)
Message-ID: <1651049438.3881402-2-xuanzhuo@linux.alibaba.com>
Date: Wed, 27 Apr 2022 16:50:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
 <20220426102537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220426102537-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] queue_reset register polarity to improve
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 26 Apr 2022 10:26:18 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Sun, Apr 24, 2022 at 03:28:53PM +0800, Xuan Zhuo wrote:
> > On Sun, 24 Apr 2022 00:49:19 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > > Hi,
> > >
> > > A recently defined queue_reset register has a little weird definition that we should improve.
> > > When driver initiate queue reset, it writes queue_reset = 1.
> > > When device is busy resetting the queue, on this driver request, it is expected to return queue_reset=0.
> > > Once queue reset is completed it is expected to return queue_reset = 1.
> > > (Polarity changed twice to same value as what was driver set). See more below.
> > >
> > > So state wise,
> > > # q_enable, q_reset represents :
> > > a) 0,0 -> device init time value
> > > b) 1,0 -> vq is enabled and working
> > > c) 1,1 -> vq is enabled, driver initiated reset
> > > d) 1,0 -> vq is enabled, but device is busy doing the reset (conflicting definition with above #b )
> > > e) 0,1 -> vq reset is complete in the device and VQ is now disabled (again conflict with #a above )
> > >
> > > Instead, I think we should have below better, consistent definition, no matter how queue reset occurs (init time or later).
> > >
> > > q_enable, q_reset
> > > A) 0, 0 -> default, device init time
> > > B) 1, 0 -> driver has enabled vq
> > > C) 1, 1 -> driver started q reset
> > > D) 1, 1 -> q_reset stays 1 until device is busy resetting vq (communicating that its working on resetting, consistent with #C)
> > > E) 0, 0 -> q_reset by device is completed, q got disabled (now matches the state same as device init time #A)
> >
> > Seems to me to be two different designs, I don't see any particular value in the
> > conflict mentioned here, and under what circumstances would it cause any
> > trouble?
> >
> > The design here is similar to many scenarios, such as device reset.
>
> Hmm. with device reset we have a reverse polarity:
>
> 	The driver SHOULD consider a driver-initiated reset complete when it
> 	reads \field{device status} as 0.
>
> in what sense is the current design similar?

It's my understanding of register polarity that is wrong.
I just learned the process of setting device reset.

The reasons for simplifying the hardware complexity, crash recovery and live
migrationhot have convinced me.

I still don't understand "register polarity". Is it a hardware design term?
Or is it just a description of the problem, not a problem in itself.

Thanks.

>
> > So if you want to change to your design, I want to know if there are other
> > reasons.
> >
> > Thanks.
> >
> > >
> > > Parav
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

