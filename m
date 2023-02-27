Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org> <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com> <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org> <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230224030509-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Feb 2023 12:07:17 +0800
Message-ID: <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 24, 2023 at 4:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 24, 2023 at 10:26:30AM +0800, Jason Wang wrote:
> > On Thu, Feb 23, 2023 at 9:03 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Thu, Feb 23, 2023 at 10:50:48AM +0800, Jason Wang wrote:
> > > > Hi:
> > > >
> > > > =E5=9C=A8 2023/2/22 14:46, Heng Qi =E5=86=99=E9=81=93:
> > > > > Hi, Jason. Long time no see. :)
> > > > >
> > > > > =E5=9C=A8 2023/2/22 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=
=E9=81=93:
> > > > > >
> > > > > > =E5=9C=A8 2023/2/22 01:50, Michael S. Tsirkin =E5=86=99=E9=81=
=93:
> > > > > > > On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> > > > > > > > +\subparagraph{Security risks between encapsulated packets =
and RSS}
> > > > > > > > +There may be potential security risks when encapsulated
> > > > > > > > packets using RSS to
> > > > > > > > +select queues for placement. When a user inside a tunnel
> > > > > > > > tries to control the
> > > > > >
> > > > > >
> > > > > > What do you mean by "user" here? Is it a remote or local one?
> > > > > >
> > > > >
> > > > > I mean a remote attacker who is not under the control of the tunn=
el
> > > > > owner.
> > > >
> > > >
> > > > Anything may the tunnel different? I think this can happen even wit=
hout
> > > > tunnel (and even with single queue).
> > >
> > > I think you are missing the fact that tunnel is normally a
> > > security boundary: users within the tunnel can not control
> > > what is happening outside.
> > > The feature breaks the encapsulation somewhat.
> >
> > I'm not sure I understand here, if we allow hash based on the inner
> > packet, is it something that you meant the things that are happening
> > outside? It doesn't differ too much from the case where the tunnel is
> > not used. It's impossible to prevent what a remote user is trying to
> > send, and if there's a NIC behaviour that depends on the packet
> > content, the behaviour of the NIC is somehow under the control of the
> > remote user.
> >
> > Since we only care about the device driver interface, what we can do
> > is probably:
> >
> > 1) allow the driver to disable the inner hash when it spots a
> > potential (D)DOS. And in the device, a fair queueing looks like a must
> > but it should be the implementation details.
>
> this breaks rss

Not sure I get here, what I want to say is that the issue described
here is not something than can be addressed in the level of hashing or
RSS. It needs to be processed before the packet can arrive at any hash
filters in the RX pipeline.

There's probably no need to mention in now consider we haven't (or
there's probably no need to) defined a full RX pipeline.

>
> > 2) hash based on both outer and inner
>
> this might help a bit
>
> > >
> > > For example without tunneling it is possible
> > > to create a special "bad guy queue" and direct specific tunnels
> > > there by playing with key and indirection table.
> >
> > Anything makes the tunneling different? We can still do this via the
> > inner header hash, or at least we can disable the inner hash if we see
> > a remote DOS.
> >
> > Thanks
>
> the difference is that tunneling is used for security/partitioning.

The problem is that we don't/can't support all type of tunnel. It
should be no difference with an old virtio-net device without tunnel
hashing.

Btw, this kind of 1:1 hash features seems not scalable and flexible.
It requires an endless extension on bits/fields. Modern NICs allow the
user to customize the hash calculation, for virtio-net we can allow to
use eBPF program to classify the packets. It seems to be more flexible
and scalable and there's almost no maintain burden in the spec (only
bytecode is required, no need any fancy features/interactions like
maps), easy to be migrated etc.

Prototype is also easy, tun/tap had an eBPF classifier for years.

Thanks

>
> > >
> > > > How to mitigate those attackers seems more like a implementation de=
tails
> > > > where might require fair queuing or other QOS technology which has =
been well
> > > > studied.
> > > >
> > > > It seems out of the scope of the spec (unless we want to let driver
> > > > manageable QOS).
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > > > +enqueuing of encapsulated packets, then the user can flood
> > > > > > > > the device with invaild
> > > > > > > > +packets, and the flooded packets may be hashed into the
> > > > > > > > same queue as packets in
> > > > > > > > +other normal tunnels, which causing the queue to overflow.
> > > > > > > > +
> > > > > > > > +This can pose several security risks:
> > > > > > > > +\begin{itemize}
> > > > > > > > +\item  Encapsulated packets in the normal tunnels cannot b=
e
> > > > > > > > enqueued due to queue
> > > > > > > > +       overflow, resulting in a large amount of packet los=
s.
> > > > > > > > +\item  The delay and retransmission of packets in the
> > > > > > > > normal tunnels are extremely increased.
> > > > > > > > +\item  The user can observe the traffic information and
> > > > > > > > enqueue information of other normal
> > > > > > > > +       tunnels, and conduct targeted DoS attacks.
> > > > > > > > +\end{\itemize}
> > > > > > > > +
> > > > > > > Hmm with this all written out it sounds pretty severe.
> > > > > >
> > > > > >
> > > > > > I think we need first understand whether or not it's a problem =
that
> > > > > > we need to solve at spec level:
> > > > > >
> > > > > > 1) anything make encapsulated packets different or why we can't=
 hit
> > > > > > this problem without encapsulation
> > > > > >
> > > > > > 2) whether or not it's the implementation details that the spec
> > > > > > doesn't need to care (or how it is solved in real NIC)
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > > At this point with no ways to mitigate, I don't feel this is =
something
> > > > > > > e.g. Linux can enable.  I am not going to nack the spec patch=
 if
> > > > > > > others  find this somehow useful e.g. for dpdk.
> > > > > > > How about CC e.g. dpdk devs or whoever else is going to use t=
his
> > > > > > > and asking them for the opinion?
> > > > > > >
> > > > > > >
> > > > >
> > >
>

