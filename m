Return-Path: <mst@redhat.com>
Date: Mon, 27 Feb 2023 02:24:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Message-ID: <20230227022133-mutt-send-email-mst@kernel.org>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-3-parav@nvidia.com>
 <20230225121237-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481088CBC9B4C99D2527A92DCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230225174948-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D5D69A3123EEE65BA0C2DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D5D69A3123EEE65BA0C2DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 27, 2023 at 02:48:50AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, February 25, 2023 5:58 PM
> > 
> > On Sat, Feb 25, 2023 at 09:38:16PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Saturday, February 25, 2023 12:27 PM
> > > >
> > > > On Sat, Feb 25, 2023 at 01:12:32AM +0200, Parav Pandit wrote:
> > > > > Currently PCI device requirements section contains mix of
> > > > > normative statements for for regular (non transitional) device and
> > > > > transitional device under one section.
> > > > >
> > > > > Some requirements of the transitional device are also located in
> > > > > legacy interface section which is the right section for it.
> > > >
> > > > > Hence,
> > > > > 1. Move transitional device requirements to their designated Legacy
> > > > >    interface section
> > > > > 2. Describe regular device requirements without quoting it as "non
> > > > >    transitional device"
> > > >
> > > > I do not think this is the way to go.
> > > >
> > > > Spec covers the functioning of modern devices and the transitional
> > > > devices when operated by modern drivers.
> > > We do not have a modern driver term in the spec.
> > > We have the legacy driver and the transitional driver in spec.
> > > The modern driver is the way of Linux implementation as far as I understand
> > that binds to transitional and nontransitional devices.
> > 
> > Technically, non-transitional:
> > 
> > 	Devices or drivers with no legacy compatibility are referred to as
> > 	non-transitional devices and drivers, respectively.
> > 
> Right.
> So the movement by this patch aligns to what you described above.
> 
> > 
> > > > The text that covers using modern interfaces belongs in the regular section.
> > > >
> > > What do you mean by modern interfaces in the context of spec?
> > >
> > > Spec at beginning says "Requirements pertaining to transitional devices and
> > drivers is contained in sections named 'Legacy Interface'
> > > like this one."
> > 
> > yes, but also:
> > 
> > 	When device is used through the legacy interface, transitional
> > 	devices and transitional drivers MUST operate according to the
> > 	requirements documented within these legacy interface sections.
> > 	Specification text within these sections generally does not apply
> > 	to non-transitional devices.
> > 
> o.k. transitional device related description is moved to the legacy interfaces section.
> 
> 
> > 
> > > So the content I moved is for the "transitional device" to the Legacy interface
> > section.
> > >
> > > A Linux implementation is free to implement a modern driver that probes
> > transitional and non-transitional devices.
> > 
> > Let's not confuse things please. Legacy sections talk about the legacy interface.
> Yes, it talks about legacy interface.
> But not limited to only legacy interface.
> It describes the transitional device interface to like the below revision id example.

No, rev id 0 is a legacy requirement.
transitional and non-transitional drivers cope with any revision just
fine.


> > If something applies when device is not used through the legacy interface then
> > it does not belong in the legacy section.
> > 
> > What you are missing is that a non-transitional driver must work with a
> > transitional device. Similarly a non-transitional device must work with a
> > transitional driver.
> > Things you are trying to move are relevant for this.
> > 
> > 
> A description of device id vs revision id for a transitional device in the different section is weird.
> This patch brings them under same section.

And that is not a good idea IMO.

> > 
> > > > Legacy devices and drivers are covered in separate legacy sections
> > > > which are non-normative (not because they have to, but simply
> > > > because writing normative sections for legacy devices would be extra
> > effort).
> > > >
> > > > Take this example. Modern drivers ignore revision, but transitional
> > > > ones need to have 0 because this is what legacy drivers expect.
> > > > Reporting 0 in revision this belongs in legacy section.
> > > >
> > > Sure. And that is how the spec is documented as you have described.
> > >
> > > "Transitional devices MUST have a PCI Revision ID of 0.".
> > 
> > And that's in the legacy section.
> > 
> Right. And similarly Transitional device id also now with this patch in legacy section.


The logic is this: people who do not care about legacy interface should be able to ignore
legacy sections.

Your patch moves statements relevant for people with modern drivers
utilizing transitional devices and vice versa to legacy sections.
Not good.

-- 
MST

