Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v9] virtio-net: support inner header hash
Date: Tue, 21 Feb 2023 19:29:20 +0000
Message-ID: <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230221115147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 21, 2023 12:06 PM
>=20
> On Tue, Feb 21, 2023 at 04:20:59AM +0000, Parav Pandit wrote:
> >
> > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > Sent: Saturday, February 18, 2023 9:37 AM
> >
> > > If the tunnel is used to encapsulate the packets, the hash
> > > calculated using the
> > s/hash calculated/hash is calculated
> >
> > > outer header of the receive packets is always fixed for the same
> > > flow packets, i.e. they will be steered to the same receive queue.
> > >
> > A little descriptive commit message like below reads better to me.
> > Currently, when a received packet is an encapsulated packet meaning the=
re
> is an outer and an inner header, virtio device is unable to calculate the=
 hash for
> the inner header.
> > Due to this limitation, multiple different flows identified by the inne=
r header
> for the same outer header result in selecting the same receive queue.
> > This effectively disables the RSS, resulting in poor receive performanc=
e.
> >
> > Hence, to overcome this limitation, a new feature is introduced using a
> feature bit VIRTIO_NET_F_HASH_TUNNEL.
> > This feature enables the device to advertise the capability to calculat=
e the
> hash for the inner packet header.
> > Thereby regaining better RSS performance in presence of outer packet
> header.
>=20
> I think this is a good description however Parav I think it is important =
to make
> contributors write their own commit messages so they know what is the rea=
son
> for the proposed change.=20
Sure. Contributor can rewrite it.

> What's good for the goose is good for the gander -
> contributors should explain why their change to spec is benefitial but re=
viewers
> should also explain why their changes to the patch are benefitial, and "r=
eads
> better to me" does not cut it - it does not allow the contributor to impr=
ove with
> time.  It's more than about a single contribution, see?
>=20
I provided an example template on how to write problem_description -> solut=
ion commit log.

At the beginning, I said "little descriptive" to explain why it reads bette=
r.
But it seems, even more verbosity is needed even for the reviewer to sugges=
t.
I didn't see this often happening by other reviewers, but I make a note of =
it now, at least I can improve from this feedback.

I imagined that the contributor would see the pattern as problem->solution =
in the example commit log and follow in the future patches.
Giving example of current patch was best to describe how to write it.

> In this case I would say the issue is that motivation for the change is n=
ever
> explained.

> > When a specific receive queue is shared to receive packets of multiple
> tunnels, there is no quality of service for packets of multiple tunnels.
>=20
> "shared to receive" is not grammatical either :)
>=20
"Shared by multiple tunnels" will make it grammatical?

> If you are talking about a security risk you need to explain
> 1- what is the threat, what configurations are affected.
> 2- what is the attack type: DOS, information leak, etc.
> 3- how to mitigate it
>=20
> This text touches a bit on 1 and 2 but not in an ordererly way.
>=20
>=20
it is best effort based.

#3 is outside the scope of this patch set.

> > +
> > > +This can pose several security risks:
> > > +\begin{itemize}
> > > +\item  Encapsulated packets in the normal tunnels cannot be
> > > +enqueued due to
> > > queue
> > > +       overflow, resulting in a large amount of packet loss.
> > > +\item  The delay and retransmission of packets in the normal
> > > +tunnels are
> > > extremely increased.
> > This is something very protocol specific and doesn't belong here.
>=20
> I don't see how it's specific - many protocols have retransmission and ar=
e
> affected by delays. "extremely increased" sounds unrammatical to me thoug=
h.
>=20
>=20
I am not sure where you want to lead this discussion.
I am trying to help the spec and feature definition to be compact enough to=
 progress.

It is specific to a protocol(s) and somehow arbitrarily concluded with a la=
rge number of packet losses.
Maybe only one ICMP packet got dropped and retransmit was just one packet.
Maybe it was TCP with selective retransmit enabled/disabled.

As far as receive side is concerned, it should say that there is no QoS amo=
ng different tunnels.
The user will figure out how to mitigate when such QoS is not available. Ei=
ther to run in best-effort mode or mitigate differently.

> > > +\item  The user can observe the traffic information and enqueue
> > > +information
> > > of other normal
> > > +       tunnels, and conduct targeted DoS attacks.
> > Once hash_report_tunnel_types is removed, this second attack is no long=
er
> applicable.
> > Hence, please remove this too.
>=20
>=20
> ?
> I don't get how removing a field helps DoS.
>=20
I meant for the "observe and enqueue" part of the tunnel as not applicable.=
=20

> \begin{lstlisting}  struct virtio_net_rss_config {
> > >      le32 hash_types;
> > > +    le32 hash_tunnel_types;
> > This field is not needed as device config space advertisement for the s=
upport
> is enough.
> >
> > If the intent is to enable hashing for the specific tunnel(s), an indiv=
idual
> command is better.
>=20
> new command? I am not sure why we want that. why not handle tunnels like
> we do other protocols?

I didn't follow.
We probably discussed in another thread that to set M bits, it is wise to a=
void setting N other bits just to keep the command happy, where N >>> M and=
 these N have a very strong relation in hw resource setup and packet steeri=
ng.
Any examples of 'other protocols'?

