Return-Path: <mst@redhat.com>
Date: Fri, 8 Oct 2021 06:44:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211008063303-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 07, 2021 at 03:42:24AM +0000, Parav Pandit wrote:
> > There's no reason for a driver to choose any value - it has nothing else to do.
> >
> At least for the devices that we are seeing, driver choosing a default value of 2 to 3 minutes is good enough and of course useful.

Well I don't get this of course yet. I guess it's useful for some
workloads, but VM being blocked for 2 minutes breaks lots of workloads.
Guests with 30 devices do exist, we are talking about an hour to start
these guest.

I wonder whether we should instead just provide some guidance on how long
is it ok for reset to take? Say if we want to address kata, <100ms boot
time, I guess we can recomment not more than 10ms? Anything
more would trigger at least a warning.

-- 
MST

