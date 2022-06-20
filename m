Return-Path: <mst@redhat.com>
Date: Mon, 20 Jun 2022 05:49:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Message-ID: <20220620054801-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620051247-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220620051247-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 20, 2022 at 05:24:02AM -0400, Michael S. Tsirkin wrote:
> With 1.2 release nearing completion I went back to see what's going on
> with this wotk, and it looks like I forgot to reply to this question.
> Sorry.
> 
> 
> On Tue, May 31, 2022 at 08:39:24PM +0000, Parav Pandit wrote:
> > > And as I said, you will need much more spec work to reach the level to which
> > > features are specified - and note we are not yet happy with how features are
> > Can you be specific of the work that you are expecting in this v5 version?
> 
> I think we need a way for device to be notified about capabilities
> of the driver. Current query only works the other way.

Sorry I spoke from memory about previous version.
Pls ignore this one and I will reply properly.

> I would like us to move to add another group of feature bits intended
> for the management purposes. Maybe just 32 bit, or maybe "extended
> features" with a selector and length like mmio and ccw already do,
> up to you.
> 
> This will replace functionality of the query capabilities command and
> have the advantage of also notifying device about capabilities of the
> driver.
> 
> 
> -- 
> MST

