Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 15:48:42 +0000
Message-ID: <PH0PR12MB54818E39CB898C7BCC29C221DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org> <875yppv1z2.fsf@redhat.com>
 <20220208102341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176C6907729FA956FB81DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208103637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208103637-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 8, 2022 9:08 PM


> On Tue, Feb 08, 2022 at 03:35:58PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, February 8, 2022 8:56 PM
> >
> > > > I might have been a bit too vague about what I had been thinking
> > > > about. Let's do a sketch (intentionally without concrete sizes):
> > > >
> > > > +-------------------------------------------------------+
> > > > | command                                               |
> > > > +-------------------------------------------------------+
> > > > | target type (0 - self, 1 - dev id, 2 - group id, ...  |
> > > > +-------------------------------------------------------+
> > > > | dev id                                                |
> > > > +-------------------------------------------------------+
> > > > | group id                                              |
> > > > +-------------------------------------------------------+
> > > > | command-specific data                                 |
> > > > +-------------------------------------------------------+
> > > > | response part                                         |
> > > > +-------------------------------------------------------+
> > > >
> > > > 'dev id' would be valid for 'target type' =3D=3D 1, 'group id' woul=
d
> > > > be valid for 'target type' =3D=3D 2. Alternatively, 'dev id' and 'g=
roup id'
> > > > could be a single 'target id' field; if there's nothing better to
> > > > use, it can simply contain a uuid.
> > >
> > > I am not sure why do we have both dev id and group id.
> > > They are never used together right?
> > > Maybe just have an id length field if we can't agree on how much
> > > space to reserve.
> > This is what I propose in a previous email.
> > A device id can be duplicate in different groups.
> > So to build hierarchy group id will be desired.
> >
> > So id[] array can contain nested one or multiple fields.
>=20
> I guess nesting is for when there's like an SF within a VF?
That is one case, but I imagine that if SF is on top of VF, than VF will di=
rectly manage it. PF should not get involved in nested management.

Nesting is for the case, where there is explicit group. A simple example is=
,
A NIC has two PCI functions, both support SR-IOV and VFs.
But only one PF is managing the VFs for msix, mac etc configuration.
In this case there are two groups g0, g1.
grp0 belongs to PF0.
grp1 belongs to PF1.

So a id definition looks like below.

struct pf_identifier {
=09u8 device; /* pci device of bdf */
=09u8 function;=09/* pci function of bdf */
} __attribute__(packed);

struct pci_vf_grouped_id {
=09struct pf_identifier pf_id;
=09u16 vf_num;
};

struct device_identfier {
=09u8 id_type;=09/* below id type enum */
=09u16 id_len;
=09union {
=09=09u8 raw[0];
=09=09struct pci_vf_grouped_id gvf_id;
=09} id_data;=09
};

enum id_type {
=09VIRTIO_PCI_VF =3D 0,=09/* implicitly grouped VF */
=09VIRTIO_PCI_REMOTE_VF =3D 1, /* part of hirechical group */
=09VIRTIO_SF,
=09VIRTIO_PCI_REMOTE_SF, /* part of hirechical group */
=09VIRTIO_MMIO,
=09/* more */
};

