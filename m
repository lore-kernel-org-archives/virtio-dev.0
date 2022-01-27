Return-Path: <mst@redhat.com>
Date: Thu, 27 Jan 2022 12:28:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
Message-ID: <20220127120820-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <20220125063443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EB2BC964EDDEDAD6C16FDC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220126085334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548106F93293256FA2AA270CDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220127021356-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F0D0BB5BD5C352A92F0DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819F0D0BB5BD5C352A92F0DC219@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 27, 2022 at 02:16:32PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, January 27, 2022 6:10 PM
> 
> > > If the system admin wants to assign 4 vectors to a VF, the current value in VF
> > and desired value are same.
> > > So no need to assign.
> > 
> > But there's no way to know how many vectors there are by default, or even
> > whether the default is same for all VFs, without first issuing a ton of commands.
> Either query all and build database (likely sane thing to do) or 
> Query the first free VF, configure the value to it and use it.

And not only that. Let's say you have 256 vectors split between 256 VFs
equally. If you want to increase vectors for VF0, you need to start
by reducing vectors for other VFs.

It's really a ton of round trips to the card just for startup.



> > 
> > Nothing here specifies the lifetime, e.g. nothing precludes tweaking the
> > number while driver is using the VF. Which will just be a mess to support.
> 
> It is described in the v2.
> 
> +{Before setting msix_count property the virtual/managed device (VF) shall be un-initialized and may not be used by the driver.
> 
> Above should be changed to "must not be used by the driver."

ok so there's an implicit uninitialized state.

This is why I felt that instead, we should make it implicit
calling the command INITIALIZE, with flags specifying
what is being initialized.

And an UINITIALIZE command for symmetry.

Alternatively - VFs should start in
a known state, with 0 vectors, and uninitialized - driver can not bind.
Following this, we'd do commands to assign resources to the VFs.
Finally, we make the VF initialized - after this point driver can bind,
but configuration can no longer be changed.

It looks like in your proposal, just assigning msix count makes
VF initialized, so this is implicit. One also can not put VF
back in uninitialized state which seems asymmetrical.


> > > It is like a netdevice comes up default with some X queues and if user wants
> > to modify it, it does ethtool and use the new value.
> > > It is not that complex.
> > 
> > A ton of commands will be needed to first query all VFs, then configure them
> > all the way management wants to.
> So, it that a problem? To configure some value, query is needed.

yes because it's not even one command. It can be like 200 commands.
That is excessive.

> If user doesn't want to issue too many commands it can pick the free VF and configure it.
> 
> Other option is below, where HV says, ah I don't like to query all the VFs.
> I want to manage each VF individually.
> So HV does one command even before enabling SR-IOV to give 0 vectors by default to each VF.



> So sequence will be like,
> 
> 1. reset all vf vectors, count = 0.

This one small step is like 200 commands though.

> 2. query total vectors of the device
> 3. enable sriov (num vfs = N)
> 3. assign #A vectors to VF-A.
> 4. assign VF to VM
> 5. use VM
> 6. release VM and VF
> 7. assign #B vectors to VF-A.
> 8. Repeat 5 to 6
> 
> > 
> > > > And alternative is to declare that VF is not set up automatically,
> > > > and ask driver to set it up before use.
> > > >
> > > Yes. This is equally good idea.
> > > May be a pci_msix_config on PF device will be good idea indicating that,
> > always have all the VFs with zero default vector.
> > > And user will setup the vector before giving the VF to the driver.
> > >
> > > > It's strictly less work for the device so I find it hard to believe
> > > > it's impossible to implement.
> > > >
> > > It is less work. This is fine.
> > > Enabling/disabling individual VF is a completely different mechanics.
> > 
> > Well. you seem to already allow allocating 0 vectors to a VF, which will break
> > most drivers effectively disabling it.
> Allocating 0 vectors is not to break driver. Not sure why you use the term break.

just that most drivers won't work if device can not drive any interrupt.

> > I just this it's best to formalize this.
> I liked the idea of above 8 steps example, this will be efficient for the user.

step 1 is problematic though.

> > > > > > IOW we would have two commands, enable and disable, an enabled
> > > > > > VFs has to be supplied with all of its configuration.
> > > > > >
> > > > > I wish best to those who will attempt this.
> > > >
> > > > It's possible that you will end up being that person, we need to
> > > > have the interface that's generic and clear enough even if your
> > > > hardware does not benefit.
> > > >
> > > > > Devices that we experience are able to handle SR-IOV scale for
> > > > > several
> > > > hundreds of VFs without need to undergo enable-disable individual VFs.
> > > >
> > > > OK... and is it true that at the same time they do not support
> > > > enough MSI-X vectors per VF such that we need complex machinery to
> > control them?
> > > >
> > > Yes.
> > >
> > > > What is the motivation for this proposal again?
> > > >
> > > Efficiently distribute device resources among large number of VFs.
> > 
> > So what's the total # of vectors supported and what's the # of VFs then?
> 
> One example, 256 VFs. total of 2K MSI-X vectors among these 256 VFs.

OK so 128 per VF by default. So pls think of a set of commands where
we can manage most reasonable tasks without resorting to hundreds of
commands.


> > > When to pci capabilities, where to store in driver structure, when to update
> > them, when to mark those capabilities dirty and re-read it.
> > > All above is not defined by PCI spec; it varies from OS to OS. Virtio spec can
> > give guidance of what to expect so that OS can implement above for msix
> > config update.
> > 
> > All I'm saying it let's drop the "beyond the scope" thing and in fact this whole
> > paragraph does not seem to add anything useful to the spec.
> > 
> Oh, you suggested to describe this details in v1 in the spec. 

Wall this does is try to say that you won't though.

> > Maybe you are trying to say that the driver or systems software needs to do
> > some kind of synchronization - is that it?
> Yes.
> > It is not clear from this description what are you talking about, what is synched
> > with what, or what does "reflected in the PCI device" mean.
> 
> Below is what is written in proposed patch:
> 
> "MSI-X capability access by the subject PCI VF defined by the PCI specification must 
> reflect the new configuration in all relevant fields."

MUST I guess and do the conformance paragraph dance then.

and I think you mean "after setting the msix_count field" right?

otherwise this is ok, but I was referring to the beyond scope part,
not to this sentence at all.

> 
> All the configuration relevant to the MSI-X should reflect in necessary registers defined by PCI spec.
> 
> Probably it should be written as "All MSI-X related registers, capabilities and fields must reflect the new configuration".
> Is this better?

no, that sentence was mostly ok.

I think this thread has outlived its usefulness.
Please just post a new version and we can restart as at this point it's no longer
clear who is responding to what.


-- 
MST

