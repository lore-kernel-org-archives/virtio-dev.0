Return-Path: <mst@redhat.com>
Date: Tue, 18 Jan 2022 02:07:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
Message-ID: <20220118015736-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117165941-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 18, 2022 at 03:36:19AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 18, 2022 3:33 AM
> > 
> > On Mon, Jan 17, 2022 at 02:12:33PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, January 13, 2022 11:24 PM
> > >
> > > >
> > > > We had an off-list meeting where I proposed addressing one device
> > > > from another or grouping multiple devices as a more specific scope.
> > > > That would be one way to address this.
> > > >
> > > > Following this idea, all commands would then gain fields for
> > > > addressing one device from another.
> > > >
> > > Can you please explain your idea more and a need for grouping?
> > > What do you want to group? VFs of parent pci device?
> > > How to refer to each VF within a group?
> > 
> > So for example, VFs of a PF are a group right? And they are all controlled by a
> > PF.
> > 
> > I can think of setups like nesting where we might want to create a group of VFs
> > and pass them to L1, one of the VFs to act as an admin for the reset of them for
> > purposes of L2.  subfunctions with PASID etc are another example. 
> 
> Subfunctions with PASID can be similarly managed by extending device identification and its MSIX/IMS vector details.
> May be vf_number should be put in the union as,
> 
> union device_id {
> 	struct pci_vf vf_id; /* current */
> 	struct pci_sf sf_id; /* future */
> };
> 
> So that they both can use command opcode.

device id is not a good name, but yes. However this is why I think we
should have a slightly more generic terminology, and more space for
these IDs, and then we'd have a specific binding for VFs.


> > I am not
> > asking you to add such mechanisms straight away but the current proposal
> > kind of obscures this to the point where I don't see how would we extend it
> > with these things down the road.
> > 
> Which part in specific make it obscure?

just that the text is not generic. would be nicer if adding
new types would involve only changing one or two places

> New device type can be identifiable by above union.
> 
> May be a better structure would be in patch-5 is:
> Something like below,
> 
> struct virtio_admin_pci_virt_property_set {
> 	enum virtio_device_identifier_type type; /* pci pf, pci vf, subfunction */
> 	union virtio_device_identifier {
> 		struct virtio_pci_dev_id pf_vf; /* current */
> 		struct virtio_subfunction sf; /* future */
> 	};
> 	enum virtio_interrupt_type interrupt_type; /* msix, ims=device specific, intx, something else */
> 	union virtio_interrupt_config {
> 		struct virtio_pci_msix_config msix_config;
> 	};
> };
> 
> struct virtio_pci_interrupt_config {
> 	le16 msix_count;
> };

you do not need a union straight away, Simply use something like this "device
identifier" everywhere and then add some text explaining that currently
it is a VF number and that admin device is a PF.

However we need better names, device ID is already used in the spec
for enumeration/discovery. come up with something else please.

