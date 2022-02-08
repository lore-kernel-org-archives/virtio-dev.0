Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 15:33:36 +0000
Message-ID: <PH0PR12MB54814971919144AC768DAF46DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org> <875yppv1z2.fsf@redhat.com>
 <PH0PR12MB548103028D5B032F42A4F214DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208102807-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208102807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 8, 2022 8:58 PM
> On Tue, Feb 08, 2022 at 03:11:28PM +0000, Parav Pandit wrote:
> >
> > > From: Cornelia Huck <cohuck@redhat.com>
> > > Sent: Tuesday, February 8, 2022 8:29 PM
> >
> > > very specific (essentially PCI-specific), we need to at least answer
> > > the question "how could this work for things that are not PCI?"
> > Why would one want to execute PCI VF MSI-X configuration command for a
> non PCI device?
>=20
> E.g. there were proposals to add msi support to virtio-mmio.

What prevents mmio specific command say mmio_dev_interrupt_config()?
Which fields do overlap with msix config of pci vf?
How is the mmio device identified?

