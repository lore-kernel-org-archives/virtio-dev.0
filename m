Return-Path: <virtio-dev-return-9727-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 550AF98633A
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 21:32:11 +0000 (UTC)
Date: Tue, 9 Aug 2022 17:32:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220809173024-mutt-send-email-mst@kernel.org>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
 <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09, 2022 at 09:13:42PM +0000, Parav Pandit wrote:
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > Sent: Tuesday, August 9, 2022 4:33 PM
> >=20
> > On 8/9/2022 12:18 PM, Parav Pandit wrote:
> > >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >> Sent: Tuesday, August 9, 2022 3:09 PM
> > >>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >>>> Sent: Tuesday, August 9, 2022 2:39 PM Currently it is not. Not a
> > >>>> single patch nor this patch, but the context for the eventual goal
> > >>>> is to allow XDP on a MTU=3D9000 link when guest users intentionall=
y
> > >>>> lower down MTU to 1500.
> > >>> Which application benefit by having asymmetry by lowering mtu to
> > >>> 1500
> > >> to send packets but want to receive 9K packets?
> > > Below details doesn=E2=80=99t answer the question of asymmetry. :)
> > >
> > >> I think virtio-net driver doesn't differentiate MTU and MRU, in whic=
h
> > >> case the receive buffer will be reduced to fit the 1500B payload siz=
e
> > >> when mtu is lowered down to 1500 from 9000.
> > > How? Driver reduced the mXu to 1500, say it is improved to post buffe=
rs of
> > 1500 bytes.
> > For big_packet path, yes, we need improvement; for mergeable, it's
> > adaptable to any incoming packet size so 1500 is what it is today.
> > >
> > > Device doesn't know about it because mtu in config space is RO field.
> > > Device keep dropping 9K packets because buffers posted are 1500 bytes=
.
> > > This is because device follows the spec " The device MUST NOT pass
> > received packets that exceed mtu".
> > Right, that's what it happens today on device side (i.e. vhost-net, btw
> > mlx5 vdpa device seems to have a bug not pro-actively dropping packets =
that
> > exceed the MTU size, causing guest panic in small packet path).
> > >
> > > So, I am lost what virtio net device user application is trying to ac=
hieve by
> > sending smaller packets and dropping all receive packets.
> > > (it doesn=E2=80=99t have any relation to mergeable or otherwise).
> >=20
> > Usually, the use case I'm aware of would set the peer's MTU to 1500 (e.=
g. on
> > a virtual network appliance), or it would rely on path mtu discovery to=
 avoid
> > packet drop across links.
> Ok. Somehow the application knows the mtu to set on (all) peer(s) and hop=
e for the best.
> Understood.

That's generally what one has to do with mtu, yes - it has to be set
consistently across the LAN. While e.g. pMTU might help work around some
misconfigured LANs with a mix of different MTUs it was never designed
for that.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

