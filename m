Return-Path: <mst@redhat.com>
Date: Tue, 17 May 2022 08:31:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v5 6/7] Introduce MGMT admin commands
Message-ID: <20220517082703-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818C762CC4DAAB3020B2ADDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818C762CC4DAAB3020B2ADDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 16, 2022 at 09:47:23PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, May 15, 2022 10:37 AM
> 
> > > +This value is also returned in the virtio_admin_device_mgmt_result
> > structure.
> > > +Also, a successful operation guarantees that the MSI-X capability
> > > +access by the designated PCI device defined by the PCI specification
> > > +must reflect the new configuration in all relevant fields. For example, by
> > default if the PCI VF has been assigned 4 MSI-X vectors, and
> > VIRTIO_ADMIN_DEVICE_MGMT increases the MSI-X vectors to 8. On this
> > change, reading Table size field of the MSI-X message control register will
> > reflect a value of 7.
> > > +
> > > +It is beyond the scope of the virtio specification to define
> > > necessary synchronization in system software to ensure that a virtio
> > > PCI VF device +interrupt configuration modification is reflected in
> > > the PCI device.
> > 
> > IMHO it is very much in scope of the specification. 
> Many pieces of this system software are not implemented by the virtio specification...
> Not sure, how can it belong to virtio spec.
> 
> > The scope of the
> > specification is to allow device interoperability and this very much fits the bill.
> > 
> How is interoperability affected and between which two entities?

For example, if OS/driver caches the # of vectors in the MSI capability,
and it changes things will not work.  OS/drivers won't know not to cache
values unless we tell them what not to cache.


I'd like to float again the idea of instead exposing a larger number of
vectors than supported. Assigning more vectors than supported will then
fail, drivers already check that so they will recover.
Avoids modifying fields that pci spec expects to be read only.


-- 
MST

