Return-Path: <virtio-dev-return-10804-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 560B19861EC
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 14:17:48 +0000 (UTC)
Date: Wed, 8 Feb 2023 09:17:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208091334-mutt-send-email-mst@kernel.org>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 07:30:34PM +0800, Heng Qi wrote:
> > I see two options.
> > 1. Just have per VQ params. Software has the full knowledge of in which it is operating, and state remains at software level.
> > This effectively achieves both the mode.
> > 
> > 2. Have a mode cmd,
> > Mode = (a) per device or (b) per VQ (c) disable
> > After the mode is set, driver can set per device or per VQ.
> 
> I find this more clear.
> 
> Thanks.
> 

Rereading this I think I misunderstood the proposal.
Now we are burning memory on maintaining mode, and this information is
duplicated.

I'd say let's just add a new command COAL_QUEUE_SET with vqn
as parameter. Existing commands are simply defined as
a shortcut to running COAL_QUEUE_SET on all tx/rx queues
respectively.

Latest command dictates the parameters. To disable just set everything
to 0 (btw we should make this explicit in the spec, but it can be
guessed from:
Upon reset, a device MUST initialize all coalescing parameters to 0.
)

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

