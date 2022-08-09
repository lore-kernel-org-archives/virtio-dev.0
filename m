Return-Path: <virtio-dev-return-9736-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8614986350
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 22:49:51 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 9 Aug 2022 22:49:48 +0000
Message-ID: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809182306-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, August 9, 2022 6:26 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> Stephen <stephen@networkplumber.org>; davem
> <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> Teitz <gavi@nvidia.com>
> Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer leng=
th for
> big packets
>=20
> On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, August 9, 2022 5:38 PM
> >
> > [..]
> > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > buffers of
> > > 1500 bytes.
> > > >
> > > > Device doesn't know about it because mtu in config space is RO fiel=
d.
> > > > Device keep dropping 9K packets because buffers posted are 1500
> bytes.
> > > > This is because device follows the spec " The device MUST NOT pass
> > > received packets that exceed mtu".
> > >
> > >
> > > The "mtu" here is the device config field, which is
> > >
> > >         /* Default maximum transmit unit advice */
> > >
> >
> > It is the field from struct virtio_net_config.mtu. right?
> > This is RO field for driver.
> >
> > > there is no guarantee device will not get a bigger packet.
> > Right. That is what I also hinted.
> > Hence, allocating buffers worth upto mtu is safer.
>=20
> yes
>=20
> > When user overrides it, driver can be further optimized to honor such n=
ew
> value on rx buffer posting.
>=20
> no, not without a feature bit promising device won't get wedged.
>=20
I mean to say as_it_stands today, driver can decide to post smaller buffers=
 with larger mtu.
Why device should be affected with it?
( I am not proposing such weird configuration but asking for sake of correc=
tness).

> > > And there is no guarantee such a packet will be dropped as opposed
> > > to wedging the device if userspace insists on adding smaller buffers.
> > >
> > If user space insists on small buffers, so be it.
>=20
> If previously things worked, the "so be it" is a regression and blaming u=
sers
> won't help us.
>=20
I am not suggesting above.
This was Si-Wei's suggestion that somehow driver wants to post smaller buff=
ers than the mtu because user knows what peer is doing.
So may be driver can be extended to give more weight on user config.

> > It only works when user exactly know what user is doing in the whole
> network.
>=20
> If you want to claim this you need a new feature bit.
>=20
Why is a new bit needed to tell device?
User is doing something its own config mismatching the buffers and mtu.
A solid use case hasn't emerged for this yet.

If user wants to modify the mtu, we should just make virtio_net_config.mtu =
as RW field using new feature bit.
Is that what you mean?
If so, yes, it makes things very neat where driver and device are aligned t=
o each other, the way they are today.
Only limitation is that its one-way. =3D device tells to driver.

> > When user prefers to override the device RO field, device is in the dar=
k and
> things work on best effort basis.
>=20
> Dropping packets is best effort. Getting stuck forever isn't, that's a qu=
ality of
> implementation issue.
>
Not sure, why things get stuck for ever. Maybe you have example to explain.
I am mostly missing something.
=20
> > This must be a reasonably advance user who has good knowledge of its
> network topology etc.
> >
> > For such case, may be yes, driver should be further optimized.
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

