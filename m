Return-Path: <mst@redhat.com>
Date: Tue, 8 Feb 2022 10:39:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220208103757-mutt-send-email-mst@kernel.org>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548145C554CBE6367318A8F9DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548145C554CBE6367318A8F9DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 03:06:16PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 8, 2022 7:29 PM
> > 
> > > Do we have a concrete example of a command that can be targeted for same
> > device and a target device, which requires differentiating their destination? If
> > so, lets discuss and then it make sense to add for the well-defined use case.
> > 
> > So e.g. things like controlling NIC's MAC can reasonably be part of the same
> > device.
> A mac address of NIC can be programmed via the existing control VQ for the self.

Not if it's disabled for the guest.

> Lets come up with some other example.

Go ahead.

> > > So better to first come up with a valid use case and a device that supports it,
> > which needs a group.
> > > Otherwise a target id can be a long string of PCI device = 0000:03:00.0 or a
> > BDF or a VF number or a VF of a different PCI PF or a SF number 32-bit or SF
> > UUID or a VF on a remote DPU system or PCI device on transparent bridge or
> > something else.
> > 
> > Well PASID is IIRC just 20 bit on express. 
> There are off line discussion and some on the mailing list too (I don't have a link to few months/year old email),
> That PASID is being overloaded to identify the SF and process both. And I tend to agree to it.
> 
> So I won't be surprised if a new SF function id takes different route than PASID.
> More below.
> 
> > I find it unlikely that we'll need more
> > than 64 bit. Yes, it's hard to predict the future but just doing 16 bit here seems
> > frankly like a premature optimization. UUID for a transient thing such as SF just
> > seems unnecessary. 32 or 64 bit seem both acceptable.
> > 
> > > Without knowing the grouping and a nonexistence device we shouldn't
> > complicate the commands.
> > >
> > > There are enough opcodes (64K) that can define new structure for more
> > complex devices.
> > 
> > I think you are asking for a bit much frankly, it's up to you to build the interface.
> I likely didn't understand above point.
> 
> > Just like with code, if the design does not feel robust the bar is much higher
> > even if one can not prove there's a locking problem. 
> 
> > Same here, this interface
> > design does not yet feel very robust yet - so either we build it in a way that
> > seems robust based basically on our gut feeling, or actually spend time
> > predicting and addressing future use-cases to prove they can be addressed.
> 
> > I dare say we've developed some intuition about what makes an extensible
> > interface and where things are likely to go here at the TC, so I wouldn't discard
> > all feedback as unnecessary complication even if it does not always come with
> > concrete use-case examples.
> I do not doubt your intuition. 
> I am open to feedback, but we haven't really established at least single explicit grouping example and ask is to add some arbitrary reserved bytes for it.
> 
> >From my DPU experience, over last 3 years, we have built SF and VF device on parent PF-A, and their management interface on parent PF-B.
> On top of that it is expected to be uniquely indefinable in multi-host env, that brings the notion of multiple controllers by a single management device.
> And also make it work uniformly with same interface when parent and management device are same.
> You can see an extendible interface at [1].
> 
> With this base line of [1], I do not agree that defining a u32 device_identifier (to contain 20-bit PASID) will be sufficient in future.
> 

OK, and Cornelia also said she thinks 64 is necessary.

> So if we really want to cover variety of cases like [1] and some more complex nested cases, we better define,
> Device identifier as below,
> struct device_identifier {
> 	u8 id_length;
> 	u8 id[];	/* variable length field
> };
> For implicitly grouped VFs of a PF, id can be 2 bytes.
> For more advance cases it can be a structure consist one or more combination of (a) host id or controller id (b) PF BDF, (c) sf id (d) PASID and more.
> 
> [1] https://www.kernel.org/doc/Documentation/networking/devlink/devlink-port.rst

I'm fine with this too.

-- 
MST

