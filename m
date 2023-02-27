Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v9] virtio-net: support inner header hash
Date: Mon, 27 Feb 2023 00:29:33 +0000
Message-ID: <PH0PR12MB54819632C955C5D087117416DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FD1A82D37157AFCFC541DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230224030725-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230224030725-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "ailan@redhat.com" <ailan@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, February 24, 2023 3:13 AM

[..]
> > The inner hash is only needed for GRE, IPIP etc.
> > For VXLAN and NVGRE Linux kernel transmit side uses the entropy of the
> source port of the outer header.
> > It does that based on the inner header.
> > Refer to [1] as one example.
> >
> > [1]
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/geneve.c#L9
> > 22
>=20
> But I think hash was requested for RSS with dpdk, no?
>=20
Yes, but if src inserts the entropy (dpdk or kernel), UDP based tunnel can =
live with outer header hash.
Ip over ip, gre tunnels needs benefit if queues do not overflow or the proc=
essing is fast enough as Heng explained.


> > > The lookup will work like this then:
> > >
> > > calculate outer hash
> > > if (rss[outer hash] & tunnel bit)
> > Tunnel bit, you mean tunneled packet, right?
>=20
> this idea stores a bit in the indirection table which signals which of th=
e hashes
> to use for rss
>=20
> > > then
> > > =09calculate inner hash
> > > =09return rss[inner hash] & ~tunnel bit
> > Why to end with a tunnel bit?
>=20
>=20
> this just clears the bit so we end up with a vq number.
>=20
> > > else
> > > =09return rss[outer hash]
> > >
> > >

Above scheme partitions the rss indirection table into two parts.
1. one for tunnel processing
2. second without it. (this one uses outer hash as today)

When #1 is done in your example, it is without hierarchy.
So inner hash can still result in collision, as before in same VQ.=20
Say VQ 0,1,2,3.
Indirection is setup so that 0,1 has tunnel bit set.
2,3 has tunnel bit cleared.
Rss of our hash finds it true and inner hash for two different tunnel is st=
ill maps to single VQ.

> > > this fixes the security issue returning us back to status quo :
> > > specific tunnels can be directed to separate queues.
> > >
> > The number of tunnels is far higher than the number of queues with para=
 virt
> driver doing decap.
>=20
> True. This seeks to get us back to where we are before the feature:
> driver can send specific outer hashes to specific queues.
> outer hash collisions remain a problem.
>=20
So far mlx5 device has done hash on inner header for non udp.

For steering packets to specific queues is done by flow programming to the =
specific RQs which supports for outer, and inner both.
Ethtool -config-nfc has it for long time too, such flow steering is due for=
 virtio net too.
It is orthogonal to RSS.

>=20
> > >
> > > This is for RSS.
> > >
> > >
> > > For hash reporting indirection table is not used.
> > > Maybe it is enough to signal to driver that inner hash was used.
> > > We do need that signalling though.
> > >
> > > My question would be whether it's practical to implement in hardware.
> >
> > In above example, hw calculating double hash is difficult without much =
gain.
> > Either calculating on one inner or outer makes sense.
> >
> > Signaling whether calculated on inner or outer is fine because hw exact=
ly tells
> what it did.
>=20
> This, in a sense, is what reporting hash tunnel type did.
> Do you now think we need it?

I don't see a consumer sw of it.

