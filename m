Return-Path: <virtio-dev-return-9463-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A572986402
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Apr 2022 14:26:26 +0000 (UTC)
Date: Tue, 26 Apr 2022 10:26:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220426102537-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] queue_reset register polarity to improve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Apr 24, 2022 at 03:28:53PM +0800, Xuan Zhuo wrote:
> On Sun, 24 Apr 2022 00:49:19 +0000, Parav Pandit <parav@nvidia.com> wrote:
> > Hi,
> >
> > A recently defined queue_reset register has a little weird definition that we should improve.
> > When driver initiate queue reset, it writes queue_reset = 1.
> > When device is busy resetting the queue, on this driver request, it is expected to return queue_reset=0.
> > Once queue reset is completed it is expected to return queue_reset = 1.
> > (Polarity changed twice to same value as what was driver set). See more below.
> >
> > So state wise,
> > # q_enable, q_reset represents :
> > a) 0,0 -> device init time value
> > b) 1,0 -> vq is enabled and working
> > c) 1,1 -> vq is enabled, driver initiated reset
> > d) 1,0 -> vq is enabled, but device is busy doing the reset (conflicting definition with above #b )
> > e) 0,1 -> vq reset is complete in the device and VQ is now disabled (again conflict with #a above )
> >
> > Instead, I think we should have below better, consistent definition, no matter how queue reset occurs (init time or later).
> >
> > q_enable, q_reset
> > A) 0, 0 -> default, device init time
> > B) 1, 0 -> driver has enabled vq
> > C) 1, 1 -> driver started q reset
> > D) 1, 1 -> q_reset stays 1 until device is busy resetting vq (communicating that its working on resetting, consistent with #C)
> > E) 0, 0 -> q_reset by device is completed, q got disabled (now matches the state same as device init time #A)
> 
> Seems to me to be two different designs, I don't see any particular value in the
> conflict mentioned here, and under what circumstances would it cause any
> trouble?
> 
> The design here is similar to many scenarios, such as device reset.

Hmm. with device reset we have a reverse polarity:

	The driver SHOULD consider a driver-initiated reset complete when it
	reads \field{device status} as 0.

in what sense is the current design similar?

> So if you want to change to your design, I want to know if there are other
> reasons.
> 
> Thanks.
> 
> >
> > Parav
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

