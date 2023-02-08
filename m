Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v7] virtio-net: support inner header hash
Date: Wed, 8 Feb 2023 14:29:00 +0000
Message-ID: <PH0PR12MB5481FD04ED6BEF3CBDBCD342DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
 <20230131052834.GA34480@h68b04307.sqa.eu95>
 <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
 <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208082210-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A88AC7D4CA548F95FA95DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208083938-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CA102D99F708E3B198D1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208090304-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208090304-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 9:09 AM

> > > header: it allow users inside the tunnel control queueing outside.
> > > By observing packet loss some information leaks between tunnels.
> > >
> > I likely didn't understand. Can you please explain?
> >
> > Queuing is always done on the inner header with/without encapsulation.
> > Hash is always reported for inner header.
> > It is only adding the ability to hash even when outer header exists.
>=20
>=20
> If hashing just on outer header (currently the only option) then a given =
tunnel
> all lands in a given queue.
> Just keep that queue separate and users of this tunnel can not learn whet=
her
> other queues are overflowing, and can not overflow other queues.
>=20
>=20
> If you hash inner header then user can flood device with packets of a giv=
en
> connection and the same connection in a different tunnel hashes to the sa=
me
> queue. Now one tunnel can
> - cause DoS for another tunnel
> - cause packet loss or latency triggering possible security bugs within g=
uest
> - detect that another tunnel is using the connection by
>   detecting its own packet loss or increased latency
>=20
Yes. It can lead to above issues.
Steering on inner is on best effort based sw implementations running on top=
 of net device.
To avoid above issues, a hierarchical model is needed.
I am not aware of any.
To my knowledge, usually who care for above issues end up using a different=
 net device for each VNI and achieve the desired hierarchy.

>=20
> > If queuing to be decided based on outer header (hash), then that is dif=
ferent.
> > Hashing both inner and outer in a flat q structure unlikely works, righ=
t?
> > Because both hashes can result in different q selection.
>=20
>=20
> That's the point.
>=20
> Is there any precedent in OSes for configuring things like this that we c=
an look
> at?
>=20
ethtool -N (not yet part of virtio) is the closest match that can steer bas=
ed on inner and outer both, but it is not hierarchical, and it is orthogona=
l to this feature.

>=20
> > >
> > > Ideas for solving this they all involve hashing both inner and outer
> > > header:
> > > 1- report two sets of hashes. overkill?
> > > 2- hash both headers together
> > > 2- add salt. can come from driver or device itself
> > >
> > > More ideas?
> > >
> > > --
> > > MST

