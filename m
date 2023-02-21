Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v9] virtio-net: support inner header hash
Date: Tue, 21 Feb 2023 22:32:11 +0000
Message-ID: <PH0PR12MB54816DA52C42EE769C4CBAF4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221161551-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221163930-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230221163930-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 21, 2023 4:46 PM
>=20
> What is this information driver can't observe? It sees all the packets af=
ter all,
> we are not stripping tunneling headers.
Just the tunnel type.
If/when that tunnel header is stripped, it gets complicated where tunnel ty=
pe is still present in the virtio_net_hdr because hash_report_tunnel featur=
e bit is negotiated.

> I also don't really know what are upper layer drivers - for sure layering=
 of
> drivers is not covered in the spec for now so I am not sure what do you m=
ean by
> that.  The risk I mentioned is leaking the information *on the network*.
>=20
Got it.

>=20
>=20
>=20
> > > > > \begin{lstlisting}  struct virtio_net_rss_config {
> > > > > > >      le32 hash_types;
> > > > > > > +    le32 hash_tunnel_types;
> > > > > > This field is not needed as device config space advertisement
> > > > > > for the support
> > > > > is enough.
> > > > > >
> > > > > > If the intent is to enable hashing for the specific tunnel(s),
> > > > > > an individual
> > > > > command is better.
> > > > >
> > > > > new command? I am not sure why we want that. why not handle
> > > > > tunnels like we do other protocols?
> > > >
> > > > I didn't follow.
> > > > We probably discussed in another thread that to set M bits, it is
> > > > wise to avoid
> > > setting N other bits just to keep the command happy, where N >>> M
> > > and these N have a very strong relation in hw resource setup and pack=
et
> steering.
> > > > Any examples of 'other protocols'?
> > >
> > > #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > > #define VIRTIO_NET_HASH_TYPE_TCPv4             (1 << 1)
> > > #define VIRTIO_NET_HASH_TYPE_UDPv4             (1 << 2)
> > >
> > > this kind of thing.
> > >
> > > I don't see how a tunnel is different fundamentally. Why does it
> > > need its own field?
> >
> > Driver is in control to enable/disable tunnel based inner hash accelera=
tion
> only when its needed.
> > This way certain data path hw parsers can be enabled/disabled.
> > Without this it will be always enabled even if there may not be any use=
r of it.
> > Device has scope to optimize this flow.
>=20
> I feel you misunderstand the question. Or maybe I misunderstand what you =
are
> proposing.  So tunnels need their own bits. But why a separate field and =
not just
> more bits along the existing ones?

Because the hashing is not covering the outer header contents.

We may be still not discussing the same.
So let me refresh the context.

The question of discussion was,
Scenario:
1. device advertises the ability to hash on the inner packet header.
2. device prefers that driver enable it only when it needs to use this extr=
a packet parser in hardware.

There are 3 options.
a. Because the feature is negotiated, it means it is enabled for all the tu=
nnel types.
Pros:
1. No need to extend cvq cmd.
Cons:
1. device parser is always enabled, and the driver never uses it. This may =
result in inferior rx performance.

b. Since the feature is useful in a narrow case of sw-based vxlan etc drive=
r, better not to enable hw for it.
Hence, have the knob to explicitly enable in hw.
So have the cvq command.
b.1 should it be combined with the existing command?
Cons:
a. when the driver wants to enable hash on inner, it needs to supply the ex=
act same RSS config as before. Sw overhead with no gain.
b. device needs to parse new command value, compare with old config, and dr=
op the RSS config, just enable inner hashing hw parser.
Or destroy the old rss config and re-apply. This results in weird behavior =
for the short interval with no apparent gain.

b.2 should it be on its own command?
Pros:
a. device and driver doesn't need to bother about b.1.a and b.1.b.
b. still benefits from not always enabling hw parser, as this is not a comm=
on case.
c. has the ability to enable when needed.

