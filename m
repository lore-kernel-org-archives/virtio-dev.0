Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 05:41:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220118053903-mutt-send-email-mst@kernel.org>
References: <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818359B93019B6D1E78B39DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118030205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481284E2B7203F3A1C36A3ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052128-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EFCFBB510E0417B87440DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EFCFBB510E0417B87440DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 10:30:38AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 3:57 PM
> > 
> > On Tue, Jan 18, 2022 at 08:23:57AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 18, 2022 1:36 PM
> > >
> > > [..]
> > > > > > > > You can map it to a queue, yes. But something static and
> > > > > > > > read only such as list of commands maps well to config
> > > > > > > > space. And it's not controlling one device from another, so
> > > > > > > > does not really seem to belong in
> > > > > > the admin queue.
> > > > > > > >
> > > > > > > Aq serves the writing device config too in patch-5 in this patchset.
> > > > > >
> > > > > > List of available admin commands does not need to be written.
> > > > > >
> > > > > It is not written into the aq commands.
> > > > > It is part of the feature bit VIRTIO_F_ADMIN_PCI_VIRT_MANAGER
> > > > > indicating
> > > > a given functionality supported or not in patch-5.
> > > >
> > > >
> > > > Btw I don't see what does "VIRT_MANAGER" mean here. "manager" is
> > > > just a generic thing that means nothing, and VIRT just repeats VIRTIO.
> > > >
> > > VIRT doesn't repeat VIRTIO.
> > 
> > It's literally a substring ;)
> > 
> > > VIRT indicates PCI virtual functions.
> > 
> > I'd use something like "SRIOV" then.
> Yeah. This is good short string.
> How about VIRTIO_F_ADMIN_PCI_SRIOV?

OK

-- 
MST

