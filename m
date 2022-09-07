Return-Path: <virtio-dev-return-9919-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 417BE986534
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 19:11:41 +0000 (UTC)
Date: Wed, 7 Sep 2022 15:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220907151026-mutt-send-email-mst@kernel.org>
References: <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 07, 2022 at 07:06:09PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, September 7, 2022 2:16 PM
> > 
> > On Wed, Sep 07, 2022 at 04:12:47PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, September 7, 2022 10:40 AM
> > > >
> > > > On Wed, Sep 07, 2022 at 02:33:02PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, September 7, 2022 10:30 AM
> > > > >
> > > > > [..]
> > > > > > > > actually how does this waste space? Is this because your
> > > > > > > > device does not have INDIRECT?
> > > > > > > VQ is 256 entries deep.
> > > > > > > Driver posted total of 256 descriptors.
> > > > > > > Each descriptor points to a page of 4K.
> > > > > > > These descriptors are chained as 4K * 16.
> > > > > >
> > > > > > So without indirect then? with indirect each descriptor can
> > > > > > point to
> > > > > > 16 entries.
> > > > > >
> > > > > With indirect, can it post 256 * 16 size buffers even though vq
> > > > > depth is 256
> > > > entries?
> > > > > I recall that total number of descriptors with direct/indirect
> > > > > descriptors is
> > > > limited to vq depth.
> > > >
> > > >
> > > > > Was there some recent clarification occurred in the spec to clarify this?
> > > >
> > > >
> > > > This would make INDIRECT completely pointless.  So I don't think we
> > > > ever had such a limitation.
> > > > The only thing that comes to mind is this:
> > > >
> > > > 	A driver MUST NOT create a descriptor chain longer than the Queue
> > > > Size of
> > > > 	the device.
> > > >
> > > > but this limits individual chain length not the total length of all chains.
> > > >
> > > Right.
> > > I double checked in virtqueue_add_split() which doesn't count table
> > entries towards desc count of VQ for indirect case.
> > >
> > > With indirect descriptors without this patch the situation is even worse
> > with memory usage.
> > > Driver will allocate 64K * 256 = 16MB buffer per VQ, while needed (and
> > used) buffer is only 2.3 Mbytes.
> > 
> > Yes. So just so we understand the reason for the performance improvement
> > is this because of memory usage? Or is this because device does not have
> > INDIRECT?
> 
> Because of shallow queue of 16 entries deep.

but why is the queue just 16 entries?
does the device not support indirect?

because with indirect you get 256 entries, with 16 s/g each.


> With driver turn around time to repost buffers, device is idle without any RQ buffers.
> With this improvement, device has 85 buffers instead of 16 to receive packets.
> 
> Enabling indirect in device can help at cost of 7x higher memory per VQ in the guest VM.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

