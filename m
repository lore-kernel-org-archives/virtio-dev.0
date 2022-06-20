Return-Path: <mst@redhat.com>
Date: Mon, 20 Jun 2022 16:53:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Message-ID: <20220620163309-mutt-send-email-mst@kernel.org>
References: <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620123447-mutt-send-email-mst@kernel.org>
 <05e1c6be-9d80-1fcb-f09b-70f5b4d562e4@nvidia.com>
 <20220620125514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548128A2365D39DD16A094FCDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548128A2365D39DD16A094FCDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 20, 2022 at 05:19:26PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 20, 2022 1:04 PM
> > 
> > Max with transport I am not talking about admin queue specifically.
> > The point Parav made is that he wants to avoid using memory writable
> > registers for slow path configuration, as far as possible.
> Precisely, especially those one which doesn't have direct impact on the device initialization sequence.
> 
> Please see my previous response.

Right. However
1. The cost is quite modest here. E.g. we have two feature selectors which
   just wastes bits.
   How bad would be to just use feature bits for now, and
   later/separately add an interface that reduces amount of writeable mmio,
   if deemed appropriate?
2. Driver features are writeable but device features are not -
   so why not have device features in memory?

-- 
MST

