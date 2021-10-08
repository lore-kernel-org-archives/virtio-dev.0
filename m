Return-Path: <mst@redhat.com>
Date: Fri, 8 Oct 2021 07:21:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211008071903-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 08, 2021 at 10:59:02AM +0000, Parav Pandit wrote:
> It may be even a pre-boot environment where 100msec or 10msec may be too short interval as other extreme of VM boot time example.

I don't really know what this means. We are talking about how long
it takes device to calm down and stop poking at the host
after it's told to reset. 10ms worst case not enough for this?

-- 
MST

