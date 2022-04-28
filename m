Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220427102559.305669-1-parav@nvidia.com> <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEviG8JkDZkv3FBChPcKb2zWdnsZpVrh5Oa6d1C1shHdJw@mail.gmail.com>
 <PH0PR12MB5481515FBE5E8842D44AFF2DDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <cb3684ef-0c6c-58ec-7eed-36e4605963e1@redhat.com> <20220428002220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428002220-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 14:10:46 +0800
Message-ID: <CACGkMEtRcZaNAAZYyAtRgmqsB+KvVQzYFN0B+w4XUQOdD2gA7Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 28, 2022 at 12:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 11:43:16AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/4/28 11:24, Parav Pandit =E5=86=99=E9=81=93:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, April 27, 2022 11:15 PM
> > > >
> > > > On Wed, Apr 27, 2022 at 11:39 PM Parav Pandit <parav@nvidia.com> wr=
ote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, April 27, 2022 11:30 AM
> > > > > >
> > > > > > On Wed, Apr 27, 2022 at 02:51:36PM +0000, Parav Pandit wrote:
> > > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > > Sent: Wednesday, April 27, 2022 7:30 AM
> > > > > > > >
> > > > > > > > On Wed, Apr 27, 2022 at 6:26 PM Parav Pandit <parav@nvidia.=
com>
> > > > wrote:
> > > > > > > > > example flow:
> > > > > > > > > a) 0,0 -> device init time value
> > > > > > > > > b) 1,0 -> vq is enabled by driver and working
> > > > > > > > Did you see my reply in V1? What's the reason for using wri=
te to
> > > > > > > > clear behavior that is different from the device status?
> > > > > > > >
> > > > > > > > We can simply make this as 1, 1 here and let the driver wri=
te to
> > > > > > > > 0 to reset the virtqueue.
> > > > > > > >
> > > > > > > > And if we do this, the queue_enable and queue_reset are alw=
ays
> > > > > > > > the same, then we can simply reuse queue_enable.
> > > > > > > >
> > > > > > > Yes, I know we can make this work using new feature bit + sin=
gle
> > > > > > queue_enable register.
> > > > > > > I replied that in v0 to Michael.
> > > > > > A bigger question in my eyes is that down the road we might wan=
t to
> > > > > > be able to stop the ring without having it lose state.
> > > > > > The natural interface for that seems to be writing 0 to queue e=
nable.
> > > > > Why queue_enable and not queue_reset?
> > > > >
> > > > > to me this interface is unlikely performant and useful for such c=
ase.
> > > > > When we want to pause/stop the VQ and query the state we need
> > > > performant scheme, that can even work in a batch for all the VQs.
> > > > > At that point programming 64 registers to pause/stop VQ without l=
osing
> > > > state and querying its indices etc won't be scalable with register =
interface.
> > > >
> > > > The register interface to sync indices has already been implemented=
 in real
> > > > hardware for years.
> > > >
> > > Sure. I meant to that when we want to pause a VQ and restart later us=
e-case will require more plumbing than just enable/disable register.
> > > And to do that, a register interface won't be performant/scalable. So=
 for the wider use case this may not be the good choice.
> > >
> > > And I explained the other reason that we lose the state information w=
ith this busy-wait register in the other reply to V2 and summary in the git=
hub issue too on Michael's request.
> >
> >
> > I've replied to the thread.
> >
> >
> > >
> > > > > I imagine a AQ (likely) or some other interface.
> > > > So did the queue_enable registers, we need to write 1 to queue_enab=
le for
> > > > each virtqueue before DRIVER_OK.
> > > >
> > > > Where to allow writing 0 to queue_enable is orthogonal to scalabili=
ty.
> > > Sure, lets sync after you get chance to go through my other reply to =
Michael about why with single busy-wait register we lose the state.
> > > And hence, queue_reset register (with the fix) is better.
> >
> >
> > Note that the MMIO transport allows writing 0 to queue_ready.
> >
> > Thanks
>
> ... without the side effect of resetting the queue state.

It's unclear in the spec that whether or not we had such side effects.

> I think ideally there should be text in MMIO stating it does not
> support the reset feature at the moment,

So do you mean the state is held after writing 0 to queue_ready? What
happen if driver do

write 0 to queue_enable,
avail_idx =3D 0,
write 1 to queue_enable,

?

> so devices should not expose
> this feature and drivers should not acknowledge this if exposed by device
> but should not fail if it's exposed (for future expansion).

I'm not sure I understand this, but it looks too late to do that? (We
don't have a feature for this).

Or we can simply forbid writing 0 to queue_ready until we refine this
behaviour with a feature.

> This is an existing spec issue, should be a separate patch.
>
> Regarding MMIO it is not exactly clear but I think the assumption
> always was you don't disable queues after DRIVER_OK.
>
> Just thinking aloud, I am wondering:
>
>
> So in the proposal, the new queue reset register does two things:
> - reset the internal queue state

Does the reset also mean stop?

> - disable the queue

What's the benefit of separating the functions here?

>
>
> It seems possible to split the functionality: queue reset would just
> disable counters, queue enable would disable queue.

This requires hardware to synchronize the queue_reset with datapath
internally which looks a little bit complicated.

> If we do
> that:
> 1- We need to specify what happens if we reset counters while ring is ena=
bled.
>    I guess queue then has to go until ring is empty, then stop?
>    Draining queue like this has value for e.g. snapshots.
>    An alternative is to prohibit this transition.

Does this mean we only support queue_reset after disabling the queue?
If yes, this basically go back to using a single queue_enable
register.

>
>    By the way current spec does not make it clear what happens if
>    driver keeps adding buffers to the queue after writing to
>    reset. It's probably a good idea to specify that device
>    should not wait to drain the queue, it should just reset,
>    but again this is an existing defect so maybe a separate patch.
>
> 2- what happens if queue is disabled but
>    without reset, and queue size changes? We do not specify.
>    Maybe that has to be prohibited.

Yes, after we enable a queue.

>
> I conclude that at some point, there is a chance we will want
> to add VIRTIO_RING_F_DISABLE making queue enable writeable for
> all transports after DRIVER_OK.

It looks to me it's better to have a single feature for disable/rest.
And it's self-contained if:

1) it holds a virtualenv state (indices)
2) allows the driver to modify the indices after it has been stopped
(with another feature).

This seems to cover all the use cases.

Thanks

> If we do, we might want the reset register behaviour to change
> if VIRTIO_RING_F_DISABLE has been negotiated.
> Parav from hardware point of view, would you say such a register where
> behaviour changes depending on feature bit be too messy?
>
>
> Overall, this makes me feel existing two register interface is
> fine, reusing queue enable would make future expansion harder
> while making queue enable writeable would be a new feature
> and needs its own feature bit.
>
>
> --
> MST
>

