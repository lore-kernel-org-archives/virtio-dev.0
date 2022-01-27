Return-Path: <mst@redhat.com>
Date: Thu, 27 Jan 2022 07:39:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
Message-ID: <20220127021356-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <20220125063443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EB2BC964EDDEDAD6C16FDC209@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220126085334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548106F93293256FA2AA270CDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548106F93293256FA2AA270CDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 27, 2022 at 03:40:22AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, January 26, 2022 7:39 PM
> 
> > > > > +A PCI PF device may assign default number of MSI-X vectors to the
> > > > > enabled PCI VFs.
> > > >
> > > >
> > > > MAY SHIULD etc all need to be capitalized and moved to a conformance
> > > > sections.
> > > Above line is an informative detail. It is not related to conformance.
> > > Is current place better? Or?
> > 
> > the way we do it generally is this. write an informative text avoiding use of
> > MAY/SHOULD etc. 
> Ok. 
> > Just describe the way it works. Add conformance
> > statements somewhat repeating the informative text using
> > MAY/SHOULD/MUST etc.
> > 
> Got it. Will do in v3.
> 
> > 
> > > > Free text just using simple tense, e.g. "bit 0 is set".
> > > >
> > > Ok.
> > > > So with a vague statement like this, how can the vectors be managed?
> > > > I guess one basically has to start by querying all VFs?
> > > Need not be.
> > > When deploying a VF, just pick a first free VF, assign the required
> > > vectors
> > 
> > management tools need to balance requirements versus availability
> > 
> > > if not same,
> > 
> > same as what?
> >
> Basically the example is,
> If say all the VFs has default of 4 vectors, and if system admin wants to assign 8 vectors to a VF,
> It issues msix_config command for a VF A to change from 4 to 8, and uses the VF.
> 
> If the system admin wants to assign 4 vectors to a VF, the current value in VF and desired value are same.
> So no need to assign.

But there's no way to know how many vectors there are by default,
or even whether the default is same for all VFs,
without first issuing a ton of commands.

> 
> > > > VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
> > > >
> > > > Lifetime rules for these commands need to be discussed.
> > > It is described below
> >
> Below is the snippet from the patch. Please let us know if its missing something for lifetime rules.
> > Couldn't find it sorry. Adding a reference might be helpful.
> 
> A PCI PF device may assign default number of MSI-X vectors to the 
> +enabled PCI VFs. Also, using VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
> +it is possible to update the default MSI-X assignment for a specific VF.
> +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET admin command, 
> +a driver set the virtual function number in \field{vf_number} and the amount of MSI-X interrupt vectors to configure to the subject virtual function in \field{msix_count}.
> +In addition, bit 0x0 in the \field{attrs_mask} field should be set. A 
> +successful operation guarantees that the requested amount of MSI-X interrupt vectors was assigned to the subject virtual function.
> +Also, a successful operation guarantees that the MSI-X capability 
> +access by the subject PCI VF defined by the PCI specification must 
> +reflect the new configuration in all relevant fields. For example, by default if the PCI VF has been assigned 4 MSI-X vectors, and VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET increases the MSI-X vectors to 8; on this change, reading Table size field of the MSI-X message control register should reflect a value of 7.
> +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
> +


Nothing here specifies the lifetime, e.g. nothing precludes tweaking the
number while driver is using the VF. Which will just be a mess to
support.


> > > However, this primitive SRIOV technology is exposed by the virtio spec
> > > using VIRTIO_F_SR_IOV for a while and also in use by users. :) Here is an
> > attempt to improve it.
> > 
> > Right. So how about enabling/disabling individual VFs then?
> >
>  
> > > >
> > > > All this looks kind of messy.
> > > >
> > > > I think Jason's previous comment where he suggested enabling the VF
> > > > with a single command begins to look more attractive.
> > > >
> > > The device vendor who actually implements it can propose it extension and
> > plumbing in the spec.
> > > I have explored this more than 2 years ago before upstreaming the mlx5 SF
> > solution. And its fairly complicated beast to achieve in PCI subsystem.
> > > To our knowledge, there is no such device, PCI subsystem, and OS in
> > existence that can actually do it.
> > >
> > > And when that occurs, it will be able to make use of msix config command
> > presented here on existing VFs.
> > > It will be able to use it without disabling the whole VF on redeploying the VF
> > second time.
> > 
> > I'm not sure we are speaking about the same thing.
> > The way you propose is each VF gets some "default" config and then the
> > commands can be used to tweak that.  Which seems pretty complex for
> > management software if it ever does need to tweak things.
> >
> A default configured vector can be zero, or device may have given some default value.
> 
> It is like a netdevice comes up default with some X queues and if user wants to modify it, it does ethtool and use the new value.
> It is not that complex.

A ton of commands will be needed to first query all VFs,
then configure them all the way management wants to.

> > And alternative is to declare that VF is not set up automatically, and ask driver
> > to set it up before use.
> > 
> Yes. This is equally good idea.
> May be a pci_msix_config on PF device will be good idea indicating that, always have all the VFs with zero default vector.
> And user will setup the vector before giving the VF to the driver.
> 
> > It's strictly less work for the device so I find it hard to believe it's impossible to
> > implement.
> >
> It is less work. This is fine.
> Enabling/disabling individual VF is a completely different mechanics.

Well. you seem to already allow allocating 0 vectors to a VF,
which will break most drivers effectively disabling it.
I just this it's best to formalize this.


> > 
> > > > IOW we would have two commands, enable and disable, an enabled VFs
> > > > has to be supplied with all of its configuration.
> > > >
> > > I wish best to those who will attempt this.
> > 
> > It's possible that you will end up being that person, we need to have the
> > interface that's generic and clear enough even if your hardware does not
> > benefit.
> > 
> > > Devices that we experience are able to handle SR-IOV scale for several
> > hundreds of VFs without need to undergo enable-disable individual VFs.
> > 
> > OK... and is it true that at the same time they do not support enough MSI-X
> > vectors per VF such that we need complex machinery to control them?
> >
> Yes.
>  
> > What is the motivation for this proposal again?
> > 
> Efficiently distribute device resources among large number of VFs.

So what's the total # of vectors supported and what's the # of VFs then?

> > 
> > > > And naturally driver is supposed to attach only to enabled VFs.
> > > >
> > > >
> > > > > +
> > > > > +It is beyond the scope of the virtio specification to define
> > > > > necessary synchronization in system software to ensure that a
> > > > > virtio PCI VF device +interrupt configuration modification is
> > > > > reflected in the PCI device.
> > > >
> > > > I don't see why this is beyond the scope of the specification, seems
> > > > quite pertinent.
> > >
> > > It is beyond the scope of specification, because virtio specification do not
> > define what all system software modules to do.
> > > It is very OS specific.
> > > virtio specification doesn't know what those modules are either.
> > > It can only provide the guidance. Cannot define how/what to do.
> > >
> > > And this hasn't changed from our discussion in v1.
> > 
> > Well we define a bunch of PCI things like BARs, device ID etc.  How is this one
> > different? 
> It is different in following way.
> When to pci capabilities, where to store in driver structure, when to update them, when to mark those capabilities dirty and re-read it.
> All above is not defined by PCI spec; it varies from OS to OS. Virtio spec can give guidance of what to expect so that OS can implement above for msix config update.

All I'm saying it let's drop the "beyond the scope" thing and in fact
this whole paragraph does not seem to add anything useful to the spec.

Maybe you are trying to say that the driver or systems software
needs to do some kind of synchronization - is that it?
It is not clear from this description what are you talking about,
what is synched with what, or
what does "reflected in the PCI device" mean.

-- 
MST

