Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 18:52:09 +0000
Message-ID: <PH0PR12MB5481B7DB7CD220C512397B4CDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548145C554CBE6367318A8F9DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208103757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208103757-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 8, 2022 9:10 PM
>=20
> On Tue, Feb 08, 2022 at 03:06:16PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, February 8, 2022 7:29 PM
> > >
> > > > Do we have a concrete example of a command that can be targeted
> > > > for same
> > > device and a target device, which requires differentiating their
> > > destination? If so, lets discuss and then it make sense to add for th=
e well-
> defined use case.
> > >
> > > So e.g. things like controlling NIC's MAC can reasonably be part of
> > > the same device.
> > A mac address of NIC can be programmed via the existing control VQ for =
the
> self.
>=20
> Not if it's disabled for the guest.
>=20
Its unrelated.
The idea was to issue same command in same way by two devices =3D primary a=
nd secondary.
And in case of primary, it will refer to secondary device.
And in second case secondary tells to self.

So if its disabled by guest, it doesn't matter how guest transports it, eit=
her via CVQ or AQ.
Its disabled.
Why to re-invent command that exists on CVQ to AQ?

> OK, and Cornelia also said she thinks 64 is necessary.
>=20
> > So if we really want to cover variety of cases like [1] and some more
> > complex nested cases, we better define, Device identifier as below,
> > struct device_identifier {
> > =09u8 id_length;
> > =09u8 id[];=09/* variable length field
> > };
> > For implicitly grouped VFs of a PF, id can be 2 bytes.
> > For more advance cases it can be a structure consist one or more
> combination of (a) host id or controller id (b) PF BDF, (c) sf id (d) PAS=
ID and
> more.
> >
> > [1]
> > https://www.kernel.org/doc/Documentation/networking/devlink/devlink-po
> > rt.rst
>=20
> I'm fine with this too.
>
Since we aim for future proofing and flexibility, variable length id is bet=
ter than constant u64. It covers the u64 case anyway.
=20
> --
> MST

