Return-Path: virtio-dev-return-5438-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD19C985E10
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 17:38:21 +0000 (UTC)
Date: Wed, 13 Feb 2019 12:38:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190213123151-mutt-send-email-mst@kernel.org>
References: <501110004.11631.1549031044295@oodm23.prod.google.com>
 <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com>
 <20190212134959-mutt-send-email-mst@kernel.org>
 <CAJPjb1+163jTBdkN6YyXne9wWoR8StQuDt9FBSu7=Q4Ua+qamQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJPjb1+163jTBdkN6YyXne9wWoR8StQuDt9FBSu7=Q4Ua+qamQ@mail.gmail.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Rob Miller <rob.miller@broadcom.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 03:03:06PM -0500, Rob Miller wrote:
>=20
>=20
> On Tue, Feb 12, 2019 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
>     On Fri, Feb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:
>     > Agreed that this is needed.
>     >
>     > I would also like to suggest splitting the F_IN_ORDER into
>     > F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,
>     > which can be more of a scatter/gather than tx. This would allow
>     > batchmode for tx at least in packed rings.
>=20
>     I'm not sure what does this buy us. Are you interested in
>     out of order tx with in order rx then?
>=20
> Other way around. It is easier to guarantee that TX pkts are processed in=
 order
> but rx is quite more difficult. The way some rx aggregators work is that=
=A0=A0as
> pkts are received from the wire, a "timer" and flow detector is setup. Th=
is
> allows for other incoming packet with same TCP header (flow) to be egg'd =
into
> one large packet with multiple segments. When a timeout fires (no other
> segments arrive within time) or the TCP header changes, the whole list of=
 RX
> buffers is then sent up to the driver for processing. However during this
> gathering period, multiple flows, say from other TCP sources could be arr=
iving.
> The hardware allocates rx buffers(descriptors) as the fragments hit the
> receiver, hence they will be used out-of-order and batch mode on RX isn't
> possible.

OK so that's for in-order. Sounds reasonable enough, would you like to
propose a spec enhancement on virtio-comment?  From what you describe it
would seem that it is not up to driver, so it should be up to the
device, where some VQs describe themselves as out of order on a device
which is otherwise in order.

>=20
>     > Finally, i would suggest a means to specify a given rings ring mode
>     > and packed leans more towards TX, whilst split can be either really
>     > depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,
>     > we can have RX & TX, split out.
>     >
>     > Sent from my iPhone
>=20
>     Before we jump there a bit more justification would be nice.
>=20
> The above description of rx aggregation, where buffer are allocated for e=
ach rx
> pkt segment as they hit the receiver . If there were 2 ingressing flows f=
rom
> different sources, say nicely interleaved, then i would expect to see rx =
desc
> usage as follows:
>=20
> buffer 0 - flow 0
> buffer 1- flow 1
> buffer 2 - flow 0
> buffer 3 - flow 1
>=20
> I would think this lends itself to a split virtqueue mode of operation be=
tter
> than ring buffer.

I'm not sure I follow why. Split virtqueue uses less cache for
when only a small number of descriptors are outstanding.
It pays for this with indirection and more cache line bounces.
Its main advantage is thus for PV case when guest and host
share a cache so generally ~1 descriptor in flight.

>=20
>=20
>     E.g. doing this change in software isn't a lot of work. How about
>     a software patch with some performance gains measured?
>     Failing that, some back of the napkin calculations showing
>     the potential gains and costs?
>=20
> Yea I could do that. I wanted to bounce the idea around a bit first to
> understand more if there are holes in my logic.=A0
>=20
>=20
>=20
>     > > On Feb 1, 2019, at 9:23 AM, David Riddoch <driddoch@solarflare.co=
m>
>     wrote:
>     > >
>     > > All,
>     > >
>     > > I'd like to propose a small extension to the packed virtqueue mod=
e.=A0 My
>     > > proposal is to add an offset/wrap field, written by the driver,
>     > > indicating how many available descriptors have been added to the =
ring.
>     > >
>     > > The reason for wanting this is to improve performance of hardware
>     > > devices.=A0 Because of high read latency over a PCIe bus, it is i=
mportant
>     > > for hardware devices to read multiple ring entries in parallel.=
=A0 It is
>     > > desirable to know how many descriptors are available prior to iss=
uing
>     > > these reads, else you risk fetching descriptors that are not yet
>     > > available.=A0 As well as wasting bus bandwidth this adds complexi=
ty.
>     > >
>     > > I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve =
this
>     > > problem, but we still have a problem.=A0 If you rely on doorbells=
 to tell
>     > > you how many descriptors are available, then you have to keep doo=
rbells
>     > > enabled at all times.=A0 This can result in a very high rate of d=
oorbells
>     > > with some drivers, which can become a severe bottleneck (because =
x86
>     > > CPUs can't emit MMIOs at very high rates).
>     > >
>     > > The proposed offset/wrap field allows devices to disable doorbell=
s when
>     > > appropriate, and determine the latest fill level via a PCIe read.
>     > >
>     > > I suggest the best place to put this would be in the driver area,
>     > > immediately after the event suppression structure.
>     > >
>     > > Presumably we would like this to be an optional feature, as
>     > > implementations of packed mode already exist in the wild.=A0 How =
about
>     > > VIRTIO_F_RING_PACKED_AVAIL_IDX?
>     > >
>     > > If I prepare a patch to the spec is there still time to get this =
into
>     v1.1?
>     > >
>     > > Best,
>     > > David
>     > >
>     > > --
>     > > David Riddoch=A0 <driddoch@solarflare.com> -- Chief Architect, So=
larflare
>     > >
>     > >
>     > > -----------------------------------------------------------------=
----
>     > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.o=
rg
>     > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open=
.org
>     > >
>     >
>     > -------------------------------------------------------------------=
--
>     > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>     > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

