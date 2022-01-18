Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 1/5] Add virtio Admin Virtqueue specification
Date: Tue, 18 Jan 2022 08:23:57 +0000
Message-ID: <PH0PR12MB5481284E2B7203F3A1C36A3ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818359B93019B6D1E78B39DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118030205-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118030205-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 1:36 PM

[..]
> > > > > You can map it to a queue, yes. But something static and read
> > > > > only such as list of commands maps well to config space. And
> > > > > it's not controlling one device from another, so does not really
> > > > > seem to belong in
> > > the admin queue.
> > > > >
> > > > Aq serves the writing device config too in patch-5 in this patchset=
.
> > >
> > > List of available admin commands does not need to be written.
> > >
> > It is not written into the aq commands.
> > It is part of the feature bit VIRTIO_F_ADMIN_PCI_VIRT_MANAGER indicatin=
g
> a given functionality supported or not in patch-5.
>=20
>=20
> Btw I don't see what does "VIRT_MANAGER" mean here. "manager" is just a
> generic thing that means nothing, and VIRT just repeats VIRTIO.
>=20
VIRT doesn't repeat VIRTIO. VIRT indicates PCI virtual functions.
Manager is generic thing to manage.
Below is the snippet from patch-5.=20

+  \item[VIRTIO_F_ADMIN_PCI_VIRT_MANAGER (44)] This feature indicates =20
+ that the device can manage PCI related capabilities for its managed=20
+ PCI VF  devices and supports VIRTIO_ADMIN_PCI_VIRT_MGMT_ATTR_IDENTIFY,
+  VIRTIO_ADMIN_PCI_VIRT_PROPERTY_SET and=20
+ VIRTIO_ADMIN_PCI_VIRT_PROPERTY_GET
+  admin commands. This feature can be supported only by PCI devices.
+

>=20
> > And structure like, virtio_admin_pci_virt_mgmt_attr_identify_result can
> potentially grow and storing those fields on on-chip resource is less eff=
icient.
> > Hence, they are shared via AQ.
>=20
> The issue is this: VIRTIO_F_ADMIN_PCI_VIRT_MANAGER seems to mean there
> are pci related admin commands. OK I guess.=20
Right.
> However you then say this same
> feature bit implies generic functionality like list of supported commands=
.
> Confusing.
>
Not sure where I mentioned generic functionality.
This feature bit implies pci virtualization related functionality by means =
of above listed commands.

