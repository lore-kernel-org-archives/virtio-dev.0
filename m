Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
Date: Wed, 26 Jan 2022 13:03:15 +0000
Message-ID: <PH0PR12MB5481EB2BC964EDDEDAD6C16FDC209@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <20220125063443-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220125063443-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 25, 2022 5:23 PM
>=20
> On Mon, Jan 24, 2022 at 11:39:18AM +0200, Max Gurtovoy wrote:

> > +In the result of VIRTIO_ADMIN_PCI_SRIOV_ATTRS admin command, a
> > +capable device should return the number of free msix vectors in the
> > +global msix pool for its VFs in \field{vfs_free_msix_count} field and
> > +also the maximal number of msix vectors that can be assigned for a sin=
gle
> VF in \field{per_vf_max_msix_count} field. In addition, bit 0x0 and bit 0=
x1
> should be set to indicate on the validity of the other 2 fields in the
> \field{attrs_mask} field of the result buffer.
> > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin
> > +Virtqueues / VIRTIO ADMIN PCI SRIOV ATTRS command} for more details.
> > +
> > +A PCI PF device may assign default number of MSI-X vectors to the
> > enabled PCI VFs.
>=20
>=20
> MAY SHIULD etc all need to be capitalized and moved to a conformance
> sections.
Above line is an informative detail. It is not related to conformance.
Is current place better? Or?

> Free text just using simple tense, e.g. "bit 0 is set".
>=20
Ok.
> So with a vague statement like this, how can the vectors be managed?  I g=
uess
> one basically has to start by querying all VFs?
Need not be.
When deploying a VF, just pick a first free VF, assign the required vectors=
 if not same, and use it.
But yes, first time query can be done too get all VFs info.

>=20
> > Also, using VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET
> > +it is possible to update the default MSI-X assignment for a specific V=
F.
> > +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET admin
> > +command, a driver set the virtual function number in \field{vf_number}=
 and
> the amount of MSI-X interrupt vectors to configure to the subject virtual
> function in \field{msix_count}.
> > +In addition, bit 0x0 in the \field{attrs_mask} field
>=20
> this use of hex for bit numbers is confusing. it's ok to use them for val=
ues but bit
> numbers are clearer decimail imho.
>=20
Ok.
Need to update in v3.

> > should be set. A successful operation guarantees that the requested
> > +amount of MSI-X interrupt vectors was assigned to the subject virtual
> function.
> > +Also, a successful operation guarantees that the MSI-X capability
> > +access by the subject PCI VF defined by the PCI specification must
> > +reflect the new configuration in all relevant fields. For example, by =
default if
> the PCI VF has been assigned 4 MSI-X vectors, and
> VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_SET increases the MSI-X vectors
> to 8; on this change, reading Table size field of the MSI-X message contr=
ol
> register should reflect a value of 7.
> > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtq=
ueues /
> VIRTIO ADMIN PCI VF INTERRUPT CONFIG SET command} for more details.
>=20
> Lifetime rules for these commands need to be discussed.
It is described below

> I am guessing this command is not allowed when driver is accessing the VF=
?
> VFs have lots of other resources besides MSI-X.
> SRIOV is quite primitive in requiring knowing # of VFs enabled up front.
> If we are going to this length to manage resources per VF should we not s=
tart
> with a more basic thing, and allow enabling/disabling individual VFs?
>=20
Sure, It is.
This is why we and others created scalable functions/subfunctions/adi to ov=
ercome some of these limitations over last 2-3 years.
Even though SIOV exists in some form, it has own deployment limitations fro=
m platform side.

However, this primitive SRIOV technology is exposed by the virtio spec usin=
g VIRTIO_F_SR_IOV for a while and also in use by users. :)
Here is an attempt to improve it.

>=20
> All this looks kind of messy.
>=20
> I think Jason's previous comment where he suggested enabling the VF with =
a
> single command begins to look more attractive.
>=20
The device vendor who actually implements it can propose it extension and p=
lumbing in the spec.
I have explored this more than 2 years ago before upstreaming the mlx5 SF s=
olution. And its fairly complicated beast to achieve in PCI subsystem.
To our knowledge, there is no such device, PCI subsystem, and OS in existen=
ce that can actually do it.

And when that occurs, it will be able to make use of msix config command pr=
esented here on existing VFs.
It will be able to use it without disabling the whole VF on redeploying the=
 VF second time.

> IOW we would have two commands, enable and disable, an enabled VFs has to
> be supplied with all of its configuration.
>=20
I wish best to those who will attempt this.
Devices that we experience are able to handle SR-IOV scale for several hund=
reds of VFs without need to undergo enable-disable individual VFs.

> And naturally driver is supposed to attach only to enabled VFs.
>=20
>=20
> > +
> > +It is beyond the scope of the virtio specification to define
> > necessary synchronization in system software to ensure that a virtio
> > PCI VF device +interrupt configuration modification is reflected in
> > the PCI device.
>=20
> I don't see why this is beyond the scope of the specification, seems quit=
e
> pertinent.=20

It is beyond the scope of specification, because virtio specification do no=
t define what all system software modules to do.
It is very OS specific.
virtio specification doesn't know what those modules are either.
It can only provide the guidance. Cannot define how/what to do.

And this hasn't changed from our discussion in v1.

> > However, it is expected that any modern system software implementing
> > virtio +drivers and PCI subsystem should ensure that any changes
> > occurring in the VF interrupt configuration is either updated in the
> > PCI VF device or +such configuration fails.
> > +
> > +In the data of VIRTIO_ADMIN_PCI_VF_INTERRUPT_CONFIG_GET admin
> > +command, a driver should set the virtual function number in
> > +\field{vf_number}. In addition, bit 0x0 in the \field{attrs_mask}
> > +field should be set to indicate requested output fields in the result =
from the
> device. In the result of a successful operation, the amount of MSI-X inte=
rrupt
> vectors that is currently assigned to the subject virtual function is ret=
urned by
> the device in \field{msix_count} field. In addition, bit 0x0 in the
> \field{attrs_mask} field should be set by the device to indicate on the v=
alidity of
> \field{msix_count} field.
> > +See section \ref{sec:Basic Facilities of a Virtio Device / Admin Virtq=
ueues /
> VIRTIO ADMIN PCI VF INTERRUPT CONFIG GET command} for more details.
> > +
> >  \section{Virtio Over MMIO}\label{sec:Virtio Transport Options /
> > Virtio Over MMIO}
> >
> >  Virtual environments without PCI support (a common situation in
> > --
> > 2.21.0
>=20
> This needs driver and device conformance sections.
Ok. v3 to cover this too.

