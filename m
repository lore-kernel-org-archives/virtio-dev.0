Return-Path: <mst@redhat.com>
Date: Sun, 24 Jul 2022 17:09:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v5 0/7] Introduce device group and
 device management
Message-ID: <20220724170744-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220706061051-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817E0D45D613834A3C42A4DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I snippet rest of mail - wasn't sure whether you were waiting for an
answer.

On Wed, Jul 06, 2022 at 08:45:26PM +0000, Parav Pandit wrote:
> > Again I don't know what to do with this. I feel if it's put up for vote in the current
> > form it's likely to fail. I propose cutting out as much as possible as a first step, so
> > we can make progress. Specifically the MSI-X commands are clearly PF specific
> > so there's no concern about VF memory use at all.  We can worry about other
> > types of command down the road when it becomes relevant.
> 
> Since feature bits proposes are limited to PF, I agree that current short cut is fine to place in 64-127 feature bits.
> 
> When/if similar functionality is needed at scale for the VF or SIOV devices, placing them in 64-127 bits area weight way less for sake of "people familiarity to feature bits".
> Do you agree?

I think we can all agree that extensions for scalable IOV will need more
work if that is what you are saying.

-- 
MST

