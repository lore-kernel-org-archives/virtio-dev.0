Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] [PATCH v3] virtio-net: support
 the virtqueue coalescing moderation
Date: Fri, 17 Feb 2023 15:54:56 +0000
Message-ID: <PH0PR12MB54819DCA7AF970AF0D563B44DCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <CAJs=3_AS5qZ5ZcHWod+U5NSQazmZNgMkMvqGghr3aNsqSapRFA@mail.gmail.com>
 <20230217093110.GA124425@h68b04307.sqa.eu95>
 <CAJs=3_B95eUsMRqsY+4u0R77HQVntP44CpR+iMfNL-NbW5jHfw@mail.gmail.com>
 <20230217045446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217045446-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, February 17, 2023 5:07 AM


> > > #1
> > > struct virtio_net_ctrl_coal {
> > >     le32 max_packets;
> > >     le32 max_usecs;
> > > };
> > >
> > > struct virtio_net_ctrl_coal_vq {
> > >     le16 vqn;
> > >     le16 reserved;
> > >     struct virtio_net_ctrl_coal coal; } coal_vq;


> > > I think we should hear from Michael and Parav.
> > >
> >
> > I meant #1.
> > We can see virtio_net_ctrl_coal as a struct holding coalescing
> > parameters, regardless of the commands.
> > Yes, let's wait for more comments on that.
>
+1 for #1.
=20
> Reusing virtio_net_ctrl_coal is a nice thought. Makes it a bit clearer th=
ese have
> exactly the same role.
> Whether to put vqn first or last does not matter imho.
>=20
Putting VQN first looks better to me, to say for vqn -> below are the param=
eters.
We may find more parameters in future too in same struct.
At that point also having vqn first reads better.

> > > > > +Virtqueue coalescing parameters:
> > > > > +\begin{itemize}
> > > > > +\item \field{vqn}: The virtqueue number of the enabled transmit =
or
> receive virtqueue, excluding the control virtqueue.
> > > > > +\item \field{max_packets}: The maximum number of packets
> sent/received by the specified virtqueue before a TX/RX notification.
> > > > > +\item \field{max_usecs}: The maximum number of TX/RX usecs that
> the specified virtqueue delays a TX/RX notification.
> > > > > +\end{itemize}
> > > > > +
> > > > > +\field{reserved} is reserved and it is ignored by the device.
> > > > > +
> > > >
> > > > max_packets is the same with VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> and
> > > > with VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET.
> > > > ("Maximum number of packets to receive/send before a RX/TX
> notification").
> > > > The fact that this is applied to all VQs or to a specific one is
> > > > derived from the command.
> > > > Same for max_usecs.
> > > > Maybe we can join the coalescing parameters somehow instead of
> > > > repeating the explanations?
> > > >
> >
> > Any thoughts on this part?
>=20
> I think I agree. Generally I think we should first of all describe the ne=
w
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, moving all explanation text to that.
>=20
> Then just explain that VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET have the same effect as
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET repeated for all currently enabled
> tx/rx vqs.
> Plus maybe a single annotated example where there's a mix of
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET commands. For example with 2 vq
> pairs:
>=20
> 1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets for vq 0 and 2, vq 1 and 3 retai=
n
> reset value 2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets vq 0, vq 2 retains
> value from 1 3. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET sets vq 1, vq 3 retains
> reset value 4. VIRTIO_NET_CTRL_NOTF_COAL_TX_SET overrides command 3
>=20
> no need for many examples.

+1.

