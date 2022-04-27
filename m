Return-Path: <virtio-dev-return-9474-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76F62986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Apr 2022 15:39:43 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 27 Apr 2022 15:39:40 +0000
Message-ID: <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427111713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 27, 2022 11:30 AM
>=20
> On Wed, Apr 27, 2022 at 02:51:36PM +0000, Parav Pandit wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, April 27, 2022 7:30 AM
> > >
> > > On Wed, Apr 27, 2022 at 6:26 PM Parav Pandit <parav@nvidia.com> wrote=
:
> > > >
> > > > example flow:
> > > > a) 0,0 -> device init time value
> > > > b) 1,0 -> vq is enabled by driver and working
> > >
> > > Did you see my reply in V1? What's the reason for using write to
> > > clear behavior that is different from the device status?
> > >
> > > We can simply make this as 1, 1 here and let the driver write to 0
> > > to reset the virtqueue.
> > >
> > > And if we do this, the queue_enable and queue_reset are always the
> > > same, then we can simply reuse queue_enable.
> > >
> > Yes, I know we can make this work using new feature bit + single
> queue_enable register.
> > I replied that in v0 to Michael.
>=20
> A bigger question in my eyes is that down the road we might want to be ab=
le to
> stop the ring without having it lose state.
> The natural interface for that seems to be writing 0 to queue enable.
Why queue_enable and not queue_reset?

to me this interface is unlikely performant and useful for such case.
When we want to pause/stop the VQ and query the state we need performant sc=
heme, that can even work in a batch for all the VQs.
At that point programming 64 registers to pause/stop VQ without losing stat=
e and querying its indices etc won't be scalable with register interface.
I imagine a AQ (likely) or some other interface.
=20
>=20
> > I was not sure how drastic that would be at this point in the spec rele=
ase cycle
> that Michael highlighted.
> > Hence, I proposed a minimal change fix to queue_reset register given ti=
meline.
>=20
> Well if accepted this proposal is going to delay the release anyway.  If =
we are
> doing a new feature then that can love alongside the one that is already =
in the
> spec.
I didn't quite understand your point.
This queue_reset in its current state (with/without) this proposed fix is m=
ostly usable within the guest for dynamic VQ creation/deletion to connect t=
o ethtool/xdp or more.

I don't see a need to delay the fix, to a larger feature that needs more th=
an just start/stop button.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

