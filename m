Return-Path: <virtio-dev-return-9921-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89729986534
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 19:24:07 +0000 (UTC)
Date: Wed, 7 Sep 2022 15:23:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220907152156-mutt-send-email-mst@kernel.org>
References: <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 3:12 PM
> 
> > > Because of shallow queue of 16 entries deep.
> > 
> > but why is the queue just 16 entries?
> I explained the calculation in [1] about 16 entries.
> 
> [1] https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com/
> 
> > does the device not support indirect?
> >
> Yes, indirect feature bit is disabled on the device.

OK that explains it.

> > because with indirect you get 256 entries, with 16 s/g each.
> > 
> Sure. I explained below that indirect comes with 7x memory cost that is not desired.
> (Ignored the table memory allocation cost and extra latency).

Oh sure, it's a waste. I wonder what effect does the patch have
on bandwidth with indirect enabled though.


> Hence don't want to enable indirect in this scenario.
> This optimization also works with indirect with smaller indirect table.
> 
> > 
> > > With driver turn around time to repost buffers, device is idle without any
> > RQ buffers.
> > > With this improvement, device has 85 buffers instead of 16 to receive
> > packets.
> > >
> > > Enabling indirect in device can help at cost of 7x higher memory per VQ in
> > the guest VM.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

