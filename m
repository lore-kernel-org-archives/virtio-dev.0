Return-Path: <mst@redhat.com>
Date: Wed, 19 Jan 2022 03:21:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220119031801-mutt-send-email-mst@kernel.org>
References: <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118020831-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052715-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118100109-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481134129490AE3D3C95039DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220119021910-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E871F07BAA8BE043CCB9DC599@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E871F07BAA8BE043CCB9DC599@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 08:15:50AM +0000, Parav Pandit wrote:
> > > Virtio driver should not incur any additional complexity in re-reading vector
> > etc.
> > 
> > I think it does this already.
> When does it re-read?
> I do not follow your point of "ask driver to read back any vector". When do you want to do this?


After mapping an event to vector, the
driver MUST verify success by reading the Vector field value: on
success, the previously written value is returned, and on
failure, NO_VECTOR is returned. If a mapping failure is detected,
the driver MAY retry mapping with fewer vectors, disable MSI-X
or report device failure.



> > 
> > > All the msix config should happen much before drivers gets loaded for the VF.
> > > It is PCI layer of the HV to provide a stable device to virtio device driver which
> > is not undergoing msix table changes, when virtio device driver is operating on
> > it.
> > 
> > 
> > Problem is in the guest though. I'm not sure we can rely on this part being part
> > of the driver and not part of the OS.
> It is part of the system software that consist of virtio driver, pci subsystem and user interface.
> I do not follow your comment about "problem is in guest though".

sorry I meant host of course.

> Can you please explain?
> VF is simply not available to the guest, when HV has not given it. And
> when its given, HV doesn’t modify the msix in some random manner.

I am concerned that we can not be sure that changing MSIX capability
while device is present is safe since spec does not promise
the capability is not read by host at boot. However, given device can instead
fail to map events to vectors, even if it is not safe we have other
ways to fail gracefully. It's probably a good idea to mention all
this in the spec text.

-- 
MST

