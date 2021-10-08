Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 12:55:38 +0000
Message-ID: <PH0PR12MB5481ACC8C86F60DEDC6170A4DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008060329-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E5C53991AE2A98AA7D9FDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008070712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211008070712-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 8, 2021 4:48 PM
>=20
> On Fri, Oct 08, 2021 at 10:51:02AM +0000, Parav Pandit wrote:
> > > That's why I ask: why do we bother? What's wrong with just waiting
> > > forever or until user gets tired of this and cancels with CTRL-C?
> >
> > Today, device removal of the device gets stuck for the device which did=
n't
> finish the reset, because its waiting for ever.
> >
> > modprobe to my knowledge cannot be Ctrl-C. In another scenario, device
> probing of hot plug device occurs by hotplug driver in a workqueue contex=
t.
>=20
> Frankly I'm not sure we need to worry about esoterica like hotplug workin=
g
> when device can't get out of reset.=20

A linux virtio driver is not even able to pass a developer's basic test whe=
re 30 devices are hotplugged and unplugged.
This is because the driver is waiting infinitely for device to finish the r=
eset, and a device cannot tell that it has 1sec timeout.

>=20
> So if it's device removal you are after to fix, then the proposed spec wo=
n't be
> enough I suspect, since there's no specific time when we can be sure DMA
> won't happen anymore. Just giving up on device isn't possible, if you do =
you risk
> corrupting guest memory which seems scarier than just blocking hotplug.
>=20
You are right, if the device is running and reset is initiated, and if time=
out expires, it is better to leave the device the state it is in.

However as explained in other examples where device is undergoing its first=
 reset during the spec defined initialization sequence, there is no reason =
for it to wait infinitely when DMA/interrupts are not even ever initiated o=
r even features negotiation didn't even finish.
Right?

> I guess with this in mind, what would be needed is a more fine-grained
> approach. E.g. driver writes 0 to reset, device returns 1 to indicate res=
et in
> progress, at that point it can promise that DMA/interrupts won't happen a=
ny
> longer, so driver can go away.
>=20
How is this helping? This is what happens today, no?
But it doesn't indicate that DMA/interrupts won't continue anymore.
I must be missing something.
I thought device would set DEVICE_NEEDS_RESET if it encountered error durin=
g reset or otherwise.

