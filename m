Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 10:59:02 +0000
Message-ID: <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211008063303-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 8, 2021 4:14 PM
>=20
> On Thu, Oct 07, 2021 at 03:42:24AM +0000, Parav Pandit wrote:
> > > There's no reason for a driver to choose any value - it has nothing e=
lse to
> do.
> > >
> > At least for the devices that we are seeing, driver choosing a default =
value of
> 2 to 3 minutes is good enough and of course useful.
>=20
> Well I don't get this of course yet. I guess it's useful for some workloa=
ds, but
> VM being blocked for 2 minutes breaks lots of workloads.
> Guests with 30 devices do exist, we are talking about an hour to start th=
ese
> guest.
>=20
In usual flow device doesn't take so long to reset. But every single time t=
hings doesn't go well in a system.
So device reset timeout is the upper bound limit. A user can always cancel/=
reboot a physical server or ctrl+c a qemu/kata process.

This can be done regardless of reset timeout anyway.
However the addition here indicates programable way for the sw to recover f=
rom such device or wait enough.

> I wonder whether we should instead just provide some guidance on how long=
 is
> it ok for reset to take? Say if we want to address kata, <100ms boot time=
, I
> guess we can recomment not more than 10ms? Anything more would trigger at
> least a warning.

It may be even a pre-boot environment where 100msec or 10msec may be too sh=
ort interval as other extreme of VM boot time example.

