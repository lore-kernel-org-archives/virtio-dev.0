Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Date: Wed, 27 Apr 2022 15:57:35 +0000
Message-ID: <PH0PR12MB5481AC52975356341A964314DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427114055-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427114055-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 27, 2022 11:44 AM
>=20
> On Wed, Apr 27, 2022 at 03:39:40PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, April 27, 2022 11:30 AM
> > >
> > > On Wed, Apr 27, 2022 at 02:51:36PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Wednesday, April 27, 2022 7:30 AM
> > > > >
> > > > > On Wed, Apr 27, 2022 at 6:26 PM Parav Pandit <parav@nvidia.com>
> wrote:
> > > > > >
> > > > > > example flow:
> > > > > > a) 0,0 -> device init time value
> > > > > > b) 1,0 -> vq is enabled by driver and working
> > > > >
> > > > > Did you see my reply in V1? What's the reason for using write to
> > > > > clear behavior that is different from the device status?
> > > > >
> > > > > We can simply make this as 1, 1 here and let the driver write to
> > > > > 0 to reset the virtqueue.
> > > > >
> > > > > And if we do this, the queue_enable and queue_reset are always
> > > > > the same, then we can simply reuse queue_enable.
> > > > >
> > > > Yes, I know we can make this work using new feature bit + single
> > > queue_enable register.
> > > > I replied that in v0 to Michael.
> > >
> > > A bigger question in my eyes is that down the road we might want to
> > > be able to stop the ring without having it lose state.
> > > The natural interface for that seems to be writing 0 to queue enable.
> > Why queue_enable and not queue_reset?
>=20
> If what to disable ring without reset then writing into reset seems
> unintuitive.
>=20
True. I assume you want to start the queue again later, hence the stop/star=
t.
Make sense.

> > to me this interface is unlikely performant and useful for such case.
> > When we want to pause/stop the VQ and query the state we need
> performant scheme, that can even work in a batch for all the VQs.
> > At that point programming 64 registers to pause/stop VQ without losing
> state and querying its indices etc won't be scalable with register interf=
ace.
> > I imagine a AQ (likely) or some other interface.
> >
> > >
> > > > I was not sure how drastic that would be at this point in the spec
> > > > release cycle
> > > that Michael highlighted.
> > > > Hence, I proposed a minimal change fix to queue_reset register give=
n
> timeline.
> > >
> > > Well if accepted this proposal is going to delay the release anyway.
> > > If we are doing a new feature then that can love alongside the one
> > > that is already in the spec.
> > I didn't quite understand your point.
>=20
> I understood your "given timeline" to mean "to avoid delays in 1.2 releas=
e".
Yes.

> My point is any material change will mean a delay at this time.
But this is so basic.
It's hard to gaze at this spec for coming years and the code to see,
Hey sometimes 0 means disabled, sometime 0 means still enabled, sometime 1 =
means enabled, and sometimes 1 means now disabled...
And maintain those weird code in device side and extra state bits burning s=
ome expensive chip resource.

Is removing from 1.2 is equal delay to get is fixed in 1.3?
If yes, I make humble request to fix this and have errata.
Some of the professional standard bodies release the spec and short after t=
hat errata/ratification follows the release that resolve such small issues.
May be time for virtio spec to take this opportunity now and be bit agile o=
n it.
Your call. :)

