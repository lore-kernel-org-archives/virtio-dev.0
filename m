Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 02:20:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220118021651-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117165941-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118015736-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E021CEB9506359DB23AEDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E021CEB9506359DB23AEDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 07:14:56AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 12:38 PM
> 
> > > Subfunctions with PASID can be similarly managed by extending device
> > identification and its MSIX/IMS vector details.
> > > May be vf_number should be put in the union as,
> > >
> > > union device_id {
> > > 	struct pci_vf vf_id; /* current */
> > > 	struct pci_sf sf_id; /* future */
> > > };
> > >
> > > So that they both can use command opcode.
> > 
> > device id is not a good name, but yes. However this is why I think we should
> > have a slightly more generic terminology, and more space for these IDs, and
> > then we'd have a specific binding for VFs.
> > 
> I couldn't think of better name for identifying a PCI VF. But yes have to think better name for sure.
> 
> > > > I am not
> > > > asking you to add such mechanisms straight away but the current
> > > > proposal kind of obscures this to the point where I don't see how
> > > > would we extend it with these things down the road.
> > > >
> > > Which part in specific make it obscure?
> > 
> > just that the text is not generic. would be nicer if adding new types would
> > involve only changing one or two places
> > 
> > > New device type can be identifiable by above union.
> > >
> > > May be a better structure would be in patch-5 is:
> > > Something like below,
> > >
> > > struct virtio_admin_pci_virt_property_set {
> > > 	enum virtio_device_identifier_type type; /* pci pf, pci vf, subfunction
> > */
> > > 	union virtio_device_identifier {
> > > 		struct virtio_pci_dev_id pf_vf; /* current */
> > > 		struct virtio_subfunction sf; /* future */
> > > 	};
> > > 	enum virtio_interrupt_type interrupt_type; /* msix, ims=device
> > specific, intx, something else */
> > > 	union virtio_interrupt_config {
> > > 		struct virtio_pci_msix_config msix_config;
> > > 	};
> > > };
> > >
> > > struct virtio_pci_interrupt_config {
> > > 	le16 msix_count;
> > > };
> > 
> > you do not need a union straight away, Simply use something like this "device
> > identifier" everywhere and then add some text explaining that currently it is a
> > VF number and that admin device is a PF.
> Unless we reserve some bytes, I fail to see how can it be future compatible for unknown device id type for subfunction.

So reserve some bytes then. 4 should be plenty.

> pci_vf_number is very crisp for the pci device for a PCI VF specific command.
> So I am ruling out arbitrary number of bytes reservation.

we already know we'll need subfunctions. so I would say make it 4 bytes.

> And split the command to two pieces.
> 1. command opcode
> 2. command content (pci vf specific). This will be different structure for subfunction or for non pci device
> 
> Would that be more elegant?

no idea about non pci. we do know about subfunctions so let us not
pretend then are this unknown entity that are very hard to reason about,
it's something that's just around the corner.

> > 
> > However we need better names, device ID is already used in the spec for
> > enumeration/discovery. come up with something else please.
> Yes.

