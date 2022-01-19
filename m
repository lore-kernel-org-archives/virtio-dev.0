Return-Path: <mst@redhat.com>
Date: Wed, 19 Jan 2022 11:40:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220119113804-mutt-send-email-mst@kernel.org>
References: <20220118020831-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052715-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118100109-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481134129490AE3D3C95039DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220119021910-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E871F07BAA8BE043CCB9DC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220119031801-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5480F3C323C7B7DBD099BBD9DC599@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5480F3C323C7B7DBD099BBD9DC599@DM8PR12MB5480.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 10:10:38AM +0000, Parav Pandit wrote:
> Virtio spec should define a minimum expectations from the system such
> as flushing the cache or no cache

well one of the things virtio is trying to do is being compatible with a
wide range of hypervisors/OSes. it might be tricky to change how they
work internally. if we are relying on tricks like this it might be
necessary to poke at some popular systems to see what they do.
lots of work ...

-- 
MST

