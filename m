Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 10:51:02 +0000
Message-ID: <PH0PR12MB5481E5C53991AE2A98AA7D9FDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008060329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211008060329-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 8, 2021 3:42 PM

> > When a device migrates to destination, it starts from where the device
> > left off on the source side.  So yes, destination side, device must be
> > usable (out of reset), and after that its current state will be
> > overwritten by the migrating device.
>=20
> I get what you are trying to say here but it's a hack.=20
What is a hack? I didn't follow.

> Nothing prevents a reset
> for driver's internal reasons at any point, and in particular reset is us=
ed e.g. for
> driver removal.
Sure nothing prevents a reset on destination. When device state restoration=
 is going on, if the device reset, device state restoration will simply not=
 go through.

> >  If you ask, does migration
> > overwrite the reset timeout register value? I would say no, because
> > how long device would take to reset is decided by the destination side
> > implementation.
>=20
> Problem is, driver can cache the value on source. Then it's migrated and =
used
> on destination when driver wants to reset the device.
> This can lead to a timeout if the destination does not finish within the =
source
> timeout value.
>
Usually driver has interest in caching fields that it uses in data path. De=
vice reset timeout is not close to it.
But fair enough, driver can cache the value whichever it chooses to.
Like other fields of the device migratable device, a backend needs to have =
same device or lower device reset timeout.
=20
> That's why I ask: why do we bother? What's wrong with just waiting foreve=
r or
> until user gets tired of this and cancels with CTRL-C?

Today, device removal of the device gets stuck for the device which didn't =
finish the reset, because its waiting for ever.

modprobe to my knowledge cannot be Ctrl-C. In another scenario, device prob=
ing of hot plug device occurs by hotplug driver in a workqueue context.

It doesn't sound right to pass the burden to the user to invent some kind o=
f ctrl-C cancel operation in hotplug drivers.

> Is there a use-case where that's not good enough?
A guest has got one good and another device that encountered a fault.
Due to this faulty device which is unable to reset, is blocking other opera=
tions in the system.

>=20
>=20
> > And this is probably yet another good reason to define migratable bits
> > of a virtio device in the live migration spec extension.
>=20
> "migratable bits" being what? non-guest visible device state? Sure, would=
 be
> great to have.  Don't think it will help in this instance.
>=20
> --
> MST

