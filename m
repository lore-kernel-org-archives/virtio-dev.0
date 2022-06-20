Return-Path: <mst@redhat.com>
Date: Mon, 20 Jun 2022 05:59:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Message-ID: <20220620055014-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 31, 2022 at 08:39:24PM +0000, Parav Pandit wrote:
> > And as I said, you will need much more spec work to reach the level to which
> > features are specified - and note we are not yet happy with how features are
> Can you be specific of the work that you are expecting in this v5 version?

I proposed getting rid of attrs_mask/device_admin_caps and instead
specify that e.g. feature bits 64 to 95 are reserved for management
purposes. Maybe just add a 32 bit register, or maybe "extended features"
with a selector and length like mmio and ccw already do, up to you.
I think Cornelia likes this suggestion too.

This would replace functionality of the
VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY/VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT
commands and have the advantage of being generally well specified and
understood.

Is this acceptable? Or is there a reason the new commands are
preferable?

-- 
MST

