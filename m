Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 02:12:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220118020831-mutt-send-email-mst@kernel.org>
References: <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 07:07:03AM +0000, Parav Pandit wrote:
> 1. Use AQ for msix query and config
> 2. AQ to follows IN_ORDER and INDIRECT_DESC negotiation like rest of the queues
> 3. Update commit log to describe why config space is not chosen (scale, on-die registers, uniform way to handle all aq cmds)
> 4. Improve documentation around msix config to link to sriov section of virtio spec
> 5. Describe error that if VF is bound to the device, admin commands targeting VF can fail, describe this error code
> 
> Did I miss anything?

Better document in spec text just what is the scope for AQ.


> Yet to receive your feedback on group, if/why is it needed and, why/if it must be in this proposal, what pieces prevents it do as follow-on.

I think this is related to the subfunction usecase or other future
usecase. In case of PF/VF grouping is implicit through the SRIOV
capability. It would be nice to have things somewhat generic in
most of the text though since we already know this will be needed.
E.g. jason sent a proposal for commands to add/delete subfunctions,
take a look at it, somehow AQ needs to be extendable to support that
functionality too.

> Cornelia, Jason,
> Can you please review current proposal as well before we revise v2?

