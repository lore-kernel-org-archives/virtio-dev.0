Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 10:09:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220118100109-mutt-send-email-mst@kernel.org>
References: <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118020831-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052715-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 10:50:52AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 4:09 PM
> > 
> > On Tue, Jan 18, 2022 at 07:30:34AM +0000, Parav Pandit wrote:
> > > An unrelated command to AQ in Jason's proposal [1] is about " The
> > management driver MUST create a managed device by allocating".
> > > We see that creator of the subfunction is often not the only entity managing
> > it.
> > > They being same in new era finding less and less users.
> > > So this piece needs more discussion whenever we address that.
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-comment/202108/msg00136.h
> > > tml
> > 
> > This reminds me. How do AQ commands interact with VF lifecycle?
> VF device usage is controlled by the same system which is configuring the VF via its parent PF device.
> So VF device shouldn't be in use. Any configuration change while VF device is in use will result in failing the AQ command.
> 
> > E.g. can one change number of vectors for an active VF?
> > Need to specify this.
> > 
> > Also, I started worrying about compatibility here.
> > Let's say the msix capability in a VF specifies 16 vectors.
> > Can PF specify 32? If yes how will driver program them?
> Yes, PF can change to 32. When VF driver queries the PCI capability, it will reflect 32 instead of 16.
> > Can PF specify 8? If yes how do we make sure driver does not attempt to use
> > 16? And what happens if it does?
> PF is programming the VF msix capability in the device. So virtio pci driver operating the PCI VF device cannot access vectors beyond the max value programmed by the PF driver.

Um. Interesting. This means that the msix capability of the VF changes?
Is that in fact spec compliant? Could some OSes cache the value of the
capability even if the device is not in active use? E.g. I can see how
this might happen in order to map the MSIX tables even before loading
the driver.

The spec says:
	Depending upon system software policy, system software, device driver software, or each at
	different times or environments may configure a function’s MSI-X capability and table
	structures with suitable vectors.

So MSIX canfiguation might not be up to the driver.

We actually ask driver to read back any vector assigned to a VQ
so it's possible to fail vector assignment. Maybe that's better.

> > Again, something to address.
> Yes, this has to be described in the spec text. Will add more clearly in v2.
> 
> > 
> > 
> > --
> > MST

