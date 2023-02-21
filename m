Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v9] virtio-net: support inner header hash
Date: Tue, 21 Feb 2023 21:36:06 +0000
Message-ID: <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221161551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230221161551-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 21, 2023 4:24 PM
>=20
> On Tue, Feb 21, 2023 at 07:29:20PM +0000, Parav Pandit wrote:
> > > > When a specific receive queue is shared to receive packets of
> > > > multiple
> > > tunnels, there is no quality of service for packets of multiple tunne=
ls.
> > >
> > > "shared to receive" is not grammatical either :)
> > >
> > "Shared by multiple tunnels" will make it grammatical?
>=20
> I think so, yes.
>=20
> > > If you are talking about a security risk you need to explain
> > > 1- what is the threat, what configurations are affected.
> > > 2- what is the attack type: DOS, information leak, etc.
> > > 3- how to mitigate it
> > >
> > > This text touches a bit on 1 and 2 but not in an ordererly way.
> > >
> > >
> > it is best effort based.
> >
> > #3 is outside the scope of this patch set.
>=20
> Scope is from greek for "target". It's what we are aiming for.
> If we document a security risk then I would say yes we should aim to prov=
ide
> not just problems but solutions too.
>=20
> > > > +
> > > > > +This can pose several security risks:
> > > > > +\begin{itemize}
> > > > > +\item  Encapsulated packets in the normal tunnels cannot be
> > > > > +enqueued due to
> > > > > queue
> > > > > +       overflow, resulting in a large amount of packet loss.
> > > > > +\item  The delay and retransmission of packets in the normal
> > > > > +tunnels are
> > > > > extremely increased.
> > > > This is something very protocol specific and doesn't belong here.
> > >
> > > I don't see how it's specific - many protocols have retransmission
> > > and are affected by delays. "extremely increased" sounds unrammatical=
 to
> me though.
> > >
> > >
> > I am not sure where you want to lead this discussion.
>=20
> I just disagree that documenting timing effects does not belong in the sp=
ec.
>=20
> > I am trying to help the spec and feature definition to be compact enoug=
h to
> progress.
> >
> > It is specific to a protocol(s) and somehow arbitrarily concluded with =
a large
> number of packet losses.
> > Maybe only one ICMP packet got dropped and retransmit was just one
> packet.
> > Maybe it was TCP with selective retransmit enabled/disabled.
> >
> > As far as receive side is concerned, it should say that there is no QoS=
 among
> different tunnels.
> > The user will figure out how to mitigate when such QoS is not available=
.
> Either to run in best-effort mode or mitigate differently.
>=20
> So you are saying either live with the problem (this is best effort yes?)=
=20
Yes to best effort usage.

>=20
>=20
> > > > > +\item  The user can observe the traffic information and enqueue
> > > > > +information
> > > > > of other normal
> > > > > +       tunnels, and conduct targeted DoS attacks.
> > > > Once hash_report_tunnel_types is removed, this second attack is no
> > > > longer
> > > applicable.
> > > > Hence, please remove this too.
> > >
> > >
> > > ?
> > > I don't get how removing a field helps DoS.
> > >
> > I meant for the "observe and enqueue" part of the tunnel as not applica=
ble.
>=20
> Sorry still don't get it :( I don't know what is the "observe and enqueue=
" part of
> the tunnel and what is not applicable. But maybe Heng Qi does.
>=20
Tunnel type such as vxlan/gre etc is not placed in the virtio_net_hdr.
This way the net_hdr doesn't leak such information to upper layer drivers a=
s it cannot observe it.

> > > \begin{lstlisting}  struct virtio_net_rss_config {
> > > > >      le32 hash_types;
> > > > > +    le32 hash_tunnel_types;
> > > > This field is not needed as device config space advertisement for
> > > > the support
> > > is enough.
> > > >
> > > > If the intent is to enable hashing for the specific tunnel(s), an
> > > > individual
> > > command is better.
> > >
> > > new command? I am not sure why we want that. why not handle tunnels
> > > like we do other protocols?
> >
> > I didn't follow.
> > We probably discussed in another thread that to set M bits, it is wise =
to avoid
> setting N other bits just to keep the command happy, where N >>> M and th=
ese
> N have a very strong relation in hw resource setup and packet steering.
> > Any examples of 'other protocols'?
>=20
> #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> #define VIRTIO_NET_HASH_TYPE_TCPv4             (1 << 1)
> #define VIRTIO_NET_HASH_TYPE_UDPv4             (1 << 2)
>=20
> this kind of thing.
>=20
> I don't see how a tunnel is different fundamentally. Why does it need its=
 own
> field?

Driver is in control to enable/disable tunnel based inner hash acceleration=
 only when its needed.
This way certain data path hw parsers can be enabled/disabled.
Without this it will be always enabled even if there may not be any user of=
 it.
Device has scope to optimize this flow.

