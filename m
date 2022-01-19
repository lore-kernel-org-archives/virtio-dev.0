Return-Path: <mst@redhat.com>
Date: Wed, 19 Jan 2022 10:38:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220119102027-mutt-send-email-mst@kernel.org>
References: <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117165941-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118015736-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E021CEB9506359DB23AEDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118021651-mutt-send-email-mst@kernel.org>
 <84a8a004-cc78-170d-9856-f0b5f8115a6f@nvidia.com>
 <PH0PR12MB5481B646941E0A41D2AF55BEDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b67e0669-afe1-a743-74d8-1482d74b7fdf@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <b67e0669-afe1-a743-74d8-1482d74b7fdf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 04:47:10PM +0200, Max Gurtovoy wrote:
> I agree, I don't see why it's not possible to use a different command opcode
> for vf interrupt configuration and sf interrupt configuration.
> 
> We're not short in opcodes and it's very elegant and extendable IMO.
> 
> I think the order should be:
> 
> 1. add adminq to virtio spec with one simple example (say MSIX config for
> VFs)
> 
> 2. in parallel submission for admin commands: S-IOV support, num VQs config,
> feature bits config and more...

Up to you for sure but didn't you guys try this already?  I think there
are concerns such as how this will be extended to support subfunctions.
I can't say what do you want to do about that in v2, ignoring them
completely is probably not a good way to get more support in the TC.
Just my two cents, hope this helps.

-- 
MST

