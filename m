Return-Path: <virtio-comment-return-2644-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 26 Jan 2022 09:08:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220126085334-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <20220125063443-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EB2BC964EDDEDAD6C16FDC209@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EB2BC964EDDEDAD6C16FDC209@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 01:03:15PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 25, 2022 5:23 PM
> > 
> > On Mon, Jan 24, 2022 at 11:39:18AM +0200, Max Gurtovoy wrote:
> 
> > > +In the result of VIRTIO_ADMIN_PCI_SRIOV_ATTRS admin command, a
> > > +capable device should return the number of free msix vectors in the
> > > +global msix pool for its VFs in \field{vfs_free_msix_count} field and
> > > +also the maximal number of msix vectors that can be assigned for a single
> > VF in \field{per_vf_max_msix_count} field. In addition, bit 0x0 and bit 0x1
> > should be set to indicate on the validity of the other 2 fields in the
> > \field{attrs_mask} field of the result buffer.
> > > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin
> > > +Virtqueues / VIRTIO ADMIN PCI SRIOV ATTRS command} for more details.
> > > +
> > > +A PCI PF device may assign default number of MSI-X vectors to the
> > > enabled PCI VFs.
> > 
> > 
> > MAY SHIULD etc all need to be capitalized and moved to a conformance
> > sections.
> Above line is an informative detail. It is not related to conformance.
> Is current place better? Or?

the way we do it generally is this. write an informative text avoiding
use of MAY/SHOULD etc. Just describe the way it works. Add conformance
statements somewhat repeating the informative text using MAY/SHOULD/MUST
etc.


> > Free text just using simple tense, e.g. "bit 0 is set".
> > 
> Ok.
> > So with a vague statement like this, how can the vectors be managed?  I guess
> > one basically has to start by querying all VFs?
> Need not be.
> When deploying a VF, just pick a first free VF, assign the required vectors

management tools need to balance requirements versus availability

> if not same,

same as what?

> and use it.
> But yes, first time query can be done too get all VFs info.
> 
> > 
> > > Also, using VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
> > > +it is possible to update the default MSI-X assignment for a specific VF.
> > > +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET admin
> > > +command, a driver set the virtual function number in \field{vf_number} and
> > the amount of MSI-X interrupt vectors to configure to the subject virtual
> > function in \field{msix_count}.
> > > +In addition, bit 0x0 in the \field{attrs_mask} field
> > 
> > this use of hex for bit numbers is confusing. it's ok to use them for values but bit
> > numbers are clearer decimail imho.
> > 
> Ok.
> Need to update in v3.
> 
> > > should be set. A successful operation guarantees that the requested
> > > +amount of MSI-X interrupt vectors was assigned to the subject virtual
> > function.
> > > +Also, a successful operation guarantees that the MSI-X capability
> > > +access by the subject PCI VF defined by the PCI specification must
> > > +reflect the new configuration in all relevant fields. For example, by default if
> > the PCI VF has been assigned 4 MSI-X vectors, and
> > VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET increases the MSI-X vectors
> > to 8; on this change, reading Table size field of the MSI-X message control
> > register should reflect a value of 7.
> > > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues /
> > VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
> > 
> > Lifetime rules for these commands need to be discussed.
> It is described below

Couldn't find it sorry. Adding a reference might be helpful.

> > I am guessing this command is not allowed when driver is accessing the VF?
> > VFs have lots of other resources besides MSI-X.
> > SRIOV is quite primitive in requiring knowing # of VFs enabled up front.
> > If we are going to this length to manage resources per VF should we not start
> > with a more basic thing, and allow enabling/disabling individual VFs?
> > 
> Sure, It is.
> This is why we and others created scalable functions/subfunctions/adi to overcome some of these limitations over last 2-3 years.
> Even though SIOV exists in some form, it has own deployment limitations from platform side.
> 
> However, this primitive SRIOV technology is exposed by the virtio spec using VIRTIO_F_SR_IOV for a while and also in use by users. :)
> Here is an attempt to improve it.

Right. So how about enabling/disabling individual VFs then?

> > 
> > All this looks kind of messy.
> > 
> > I think Jason's previous comment where he suggested enabling the VF with a
> > single command begins to look more attractive.
> > 
> The device vendor who actually implements it can propose it extension and plumbing in the spec.
> I have explored this more than 2 years ago before upstreaming the mlx5 SF solution. And its fairly complicated beast to achieve in PCI subsystem.
> To our knowledge, there is no such device, PCI subsystem, and OS in existence that can actually do it.
> 
> And when that occurs, it will be able to make use of msix config command presented here on existing VFs.
> It will be able to use it without disabling the whole VF on redeploying the VF second time.

I'm not sure we are speaking about the same thing.
The way you propose is each VF gets some "default" config and then the
commands can be used to tweak that.  Which seems pretty complex for
management software if it ever does need to tweak things.

And alternative is to declare that VF is not set up
automatically, and ask driver to set it up before use.

It's strictly less work for the device so I find it hard to
believe it's impossible to implement.







> > IOW we would have two commands, enable and disable, an enabled VFs has to
> > be supplied with all of its configuration.
> > 
> I wish best to those who will attempt this.

It's possible that you will end up being that person, we need to
have the interface that's generic and clear enough even if
your hardware does not benefit.

> Devices that we experience are able to handle SR-IOV scale for several hundreds of VFs without need to undergo enable-disable individual VFs.

OK... and is it true that at the same time they do not support enough
MSI-X vectors per VF such that we need complex machinery to control
them?

What is the motivation for this proposal again?


> > And naturally driver is supposed to attach only to enabled VFs.
> > 
> > 
> > > +
> > > +It is beyond the scope of the virtio specification to define
> > > necessary synchronization in system software to ensure that a virtio
> > > PCI VF device +interrupt configuration modification is reflected in
> > > the PCI device.
> > 
> > I don't see why this is beyond the scope of the specification, seems quite
> > pertinent. 
> 
> It is beyond the scope of specification, because virtio specification do not define what all system software modules to do.
> It is very OS specific.
> virtio specification doesn't know what those modules are either.
> It can only provide the guidance. Cannot define how/what to do.
> 
> And this hasn't changed from our discussion in v1.

Well we define a bunch of PCI things like BARs, device ID etc.  How is
this one different? I think basically it's a lot of work and we do not
think it's srictly necessary to define it, but it's not because of
scope.


> > > However, it is expected that any modern system software implementing
> > > virtio +drivers and PCI subsystem should ensure that any changes
> > > occurring in the VF interrupt configuration is either updated in the
> > > PCI VF device or +such configuration fails.
> > > +
> > > +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin
> > > +command, a driver should set the virtual function number in
> > > +\field{vf_number}. In addition, bit 0x0 in the \field{attrs_mask}
> > > +field should be set to indicate requested output fields in the result from the
> > device. In the result of a successful operation, the amount of MSI-X interrupt
> > vectors that is currently assigned to the subject virtual function is returned by
> > the device in \field{msix_count} field. In addition, bit 0x0 in the
> > \field{attrs_mask} field should be set by the device to indicate on the validity of
> > \field{msix_count} field.
> > > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtqueues /
> > VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command} for more details.
> > > +
> > >  \section{Virtio Over MMIO}\label{sec:Virtio Transport Options /
> > > Virtio Over MMIO}
> > >
> > >  Virtual environments without PCI support (a common situation in
> > > --
> > > 2.21.0
> > 
> > This needs driver and device conformance sections.
> Ok. v3 to cover this too.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

