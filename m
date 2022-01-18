Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 05:26:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220118052128-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818359B93019B6D1E78B39DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118030205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481284E2B7203F3A1C36A3ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481284E2B7203F3A1C36A3ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 08:23:57AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 1:36 PM
> 
> [..]
> > > > > > You can map it to a queue, yes. But something static and read
> > > > > > only such as list of commands maps well to config space. And
> > > > > > it's not controlling one device from another, so does not really
> > > > > > seem to belong in
> > > > the admin queue.
> > > > > >
> > > > > Aq serves the writing device config too in patch-5 in this patchset.
> > > >
> > > > List of available admin commands does not need to be written.
> > > >
> > > It is not written into the aq commands.
> > > It is part of the feature bit VIRTIO_F_ADMIN_PCI_VIRT_MANAGER indicating
> > a given functionality supported or not in patch-5.
> > 
> > 
> > Btw I don't see what does "VIRT_MANAGER" mean here. "manager" is just a
> > generic thing that means nothing, and VIRT just repeats VIRTIO.
> > 
> VIRT doesn't repeat VIRTIO.

It's literally a substring ;)

> VIRT indicates PCI virtual functions.

I'd use something like "SRIOV" then.

> Manager is generic thing to manage.

generic to the point of being meaningless.

> Below is the snippet from patch-5. 
> 
> +  \item[VIRTIO_F_ADMIN_PCI_VIRT_MANAGER (44)] This feature indicates  
> + that the device can manage PCI related capabilities for its managed 
> + PCI VF  devices and supports VIRTIO_ADMIN_PCI_VIRT_MGMT_ATTR_IDENTIFY,

manage twice here. VFs are always managed. And manage here again
does not mean much. I'd say something like:
"allow control over VFs through admin vq of the PF"

> +  VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET and 
> + VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET
> +  admin commands. This feature can be supported only by PCI devices.
> +
> 
> > 
> > > And structure like, virtio_admin_pci_virt_mgmt_attr_identify_result can
> > potentially grow and storing those fields on on-chip resource is less efficient.
> > > Hence, they are shared via AQ.
> > 
> > The issue is this: VIRTIO_F_ADMIN_PCI_VIRT_MANAGER seems to mean there
> > are pci related admin commands. OK I guess. 
> Right.
> > However you then say this same
> > feature bit implies generic functionality like list of supported commands.
> > Confusing.
> >
> Not sure where I mentioned generic functionality.
> This feature bit implies pci virtualization related functionality by means of above listed commands.

pci virtualization being SRIOV here with PF controlling VFs.

-- 
MST

