Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v9] virtio-net: support inner header hash
Date: Wed, 22 Feb 2023 01:41:28 +0000
Message-ID: <PH0PR12MB5481D45783B7146F26A4F0C2DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221161551-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221163930-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DA52C42EE769C4CBAF4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221180945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230221180945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 21, 2023 6:18 PM

> > The question of discussion was,
> > Scenario:
> > 1. device advertises the ability to hash on the inner packet header.
> > 2. device prefers that driver enable it only when it needs to use this =
extra
> packet parser in hardware.
> >
> > There are 3 options.
> > a. Because the feature is negotiated, it means it is enabled for all th=
e tunnel
> types.
> > Pros:
> > 1. No need to extend cvq cmd.
> > Cons:
> > 1. device parser is always enabled, and the driver never uses it. This =
may
> result in inferior rx performance.
> >
> > b. Since the feature is useful in a narrow case of sw-based vxlan etc d=
river,
> better not to enable hw for it.
> > Hence, have the knob to explicitly enable in hw.
> > So have the cvq command.
> > b.1 should it be combined with the existing command?
> > Cons:
> > a. when the driver wants to enable hash on inner, it needs to supply th=
e exact
> same RSS config as before. Sw overhead with no gain.
> > b. device needs to parse new command value, compare with old config, an=
d
> drop the RSS config, just enable inner hashing hw parser.
> > Or destroy the old rss config and re-apply. This results in weird behav=
ior for
> the short interval with no apparent gain.
> >
> > b.2 should it be on its own command?
> > Pros:
> > a. device and driver doesn't need to bother about b.1.a and b.1.b.
> > b. still benefits from not always enabling hw parser, as this is not a =
common
> case.
> > c. has the ability to enable when needed.
>=20
> I prefer b.1. With reporting of the tunnel type gone I don't see a fundam=
ental
> difference between hashing over tunneling types and other protocol types =
we
> support.  It's just a flag telling device over which bits to calculate th=
e hash. We
> don't have a separate command for hashing of TCPv6, why have it for vxlan=
?
b.1 to always enable hw for multi-level packet processing is not very optim=
al for actual device implementation.
The difference is one level of header vs second-level hashing.
And new hash type values have zero use of it in sw.

> Extending with more HASH_TYPE makes total sense to me, seems to fit bette=
r
> with the existing design and will make patch smaller.

