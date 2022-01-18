Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 1/5] Add virtio Admin Virtqueue specification
Date: Tue, 18 Jan 2022 03:36:19 +0000
Message-ID: <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117165941-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220117165941-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 3:33 AM
>=20
> On Mon, Jan 17, 2022 at 02:12:33PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, January 13, 2022 11:24 PM
> >
> > >
> > > We had an off-list meeting where I proposed addressing one device
> > > from another or grouping multiple devices as a more specific scope.
> > > That would be one way to address this.
> > >
> > > Following this idea, all commands would then gain fields for
> > > addressing one device from another.
> > >
> > Can you please explain your idea more and a need for grouping?
> > What do you want to group? VFs of parent pci device?
> > How to refer to each VF within a group?
>=20
> So for example, VFs of a PF are a group right? And they are all controlle=
d by a
> PF.
>=20
> I can think of setups like nesting where we might want to create a group =
of VFs
> and pass them to L1, one of the VFs to act as an admin for the reset of t=
hem for
> purposes of L2.  subfunctions with PASID etc are another example.=20

Subfunctions with PASID can be similarly managed by extending device identi=
fication and its MSIX/IMS vector details.
May be vf_number should be put in the union as,

union device_id {
=09struct pci_vf vf_id; /* current */
=09struct pci_sf sf_id; /* future */
};

So that they both can use command opcode.

> I am not
> asking you to add such mechanisms straight away but the current proposal
> kind of obscures this to the point where I don't see how would we extend =
it
> with these things down the road.
>=20
Which part in specific make it obscure? New device type can be identifiable=
 by above union.

May be a better structure would be in patch-5 is:
Something like below,

struct virtio_admin_pci_virt_property_set {
=09enum virtio_device_identifier_type type; /* pci pf, pci vf, subfunction =
*/
=09union virtio_device_identifier {
=09=09struct virtio_pci_dev_id pf_vf; /* current */
=09=09struct virtio_subfunction sf; /* future */
=09};
=09enum virtio_interrupt_type interrupt_type; /* msix, ims=3Ddevice specifi=
c, intx, something else */
=09union virtio_interrupt_config {
=09=09struct virtio_pci_msix_config msix_config;
=09};
};

struct virtio_pci_interrupt_config {
=09le16 msix_count;
};

