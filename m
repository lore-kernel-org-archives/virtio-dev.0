Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Wed, 19 Jan 2022 17:07:53 +0000
Message-ID: <PH0PR12MB548162D00EBED7465A28A627DC599@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220118020831-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052715-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118100109-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481134129490AE3D3C95039DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220119021910-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E871F07BAA8BE043CCB9DC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220119031801-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5480F3C323C7B7DBD099BBD9DC599@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20220119113804-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220119113804-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, January 19, 2022 10:10 PM
>=20
> On Wed, Jan 19, 2022 at 10:10:38AM +0000, Parav Pandit wrote:
> > Virtio spec should define a minimum expectations from the system such
> > as flushing the cache or no cache
>=20
> well one of the things virtio is trying to do is being compatible with a =
wide
> range of hypervisors/OSes.=20
We are not breaking any compatibility with this optional enhancement.

> it might be tricky to change how they work
> internally. if we are relying on tricks like this it might be necessary t=
o poke at
> some popular systems to see what they do.
Sure it should work on wide range of hypervisors/OSes. It's a new feature s=
o those will implement when scale is critical for them.

If we consider Linux as popular system than Linux pci subsystem and mlx5 dr=
iver already implements it in upstream kernel 5.13.
(It doesn't cache it).

Similar implementation for non virtio also exists in _other_ popular OS, wh=
ich I should avoid annotating here.

