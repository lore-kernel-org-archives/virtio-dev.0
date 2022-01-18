Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Tue, 18 Jan 2022 10:50:52 +0000
Message-ID: <PH0PR12MB54813403EB286E31EE760098DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118020831-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CAD287BCA267504C16FDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118052715-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118052715-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 4:09 PM
>=20
> On Tue, Jan 18, 2022 at 07:30:34AM +0000, Parav Pandit wrote:
> > An unrelated command to AQ in Jason's proposal [1] is about " The
> management driver MUST create a managed device by allocating".
> > We see that creator of the subfunction is often not the only entity man=
aging
> it.
> > They being same in new era finding less and less users.
> > So this piece needs more discussion whenever we address that.
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-comment/202108/msg00136.h
> > tml
>=20
> This reminds me. How do AQ commands interact with VF lifecycle?
VF device usage is controlled by the same system which is configuring the V=
F via its parent PF device.
So VF device shouldn't be in use. Any configuration change while VF device =
is in use will result in failing the AQ command.

> E.g. can one change number of vectors for an active VF?
> Need to specify this.
>=20
> Also, I started worrying about compatibility here.
> Let's say the msix capability in a VF specifies 16 vectors.
> Can PF specify 32? If yes how will driver program them?
Yes, PF can change to 32. When VF driver queries the PCI capability, it wil=
l reflect 32 instead of 16.
> Can PF specify 8? If yes how do we make sure driver does not attempt to u=
se
> 16? And what happens if it does?
PF is programming the VF msix capability in the device. So virtio pci drive=
r operating the PCI VF device cannot access vectors beyond the max value pr=
ogrammed by the PF driver.

> Again, something to address.
Yes, this has to be described in the spec text. Will add more clearly in v2=
.

>=20
>=20
> --
> MST

