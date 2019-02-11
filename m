Return-Path: virtio-dev-return-5385-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8808985C4B
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 14:24:36 +0000 (UTC)
Date: Mon, 11 Feb 2019 09:24:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211080432-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 11, 2019 at 08:52:01AM +0000, David Riddoch wrote:
> On 11/02/2019 07:33, Michael S. Tsirkin wrote:
> > On Fri, Feb 01, 2019 at 02:23:55PM +0000, David Riddoch wrote:
> > > All,
> > >=20
> > > I'd like to propose a small extension to the packed virtqueue mode.=
=A0 My
> > > proposal is to add an offset/wrap field, written by the driver, indic=
ating
> > > how many available descriptors have been added to the ring.
> > >=20
> > > The reason for wanting this is to improve performance of hardware dev=
ices.
> > > Because of high read latency over a PCIe bus, it is important for har=
dware
> > > devices to read multiple ring entries in parallel.=A0 It is desirable=
 to know
> > > how many descriptors are available prior to issuing these reads, else=
 you
> > > risk fetching descriptors that are not yet available.=A0 As well as w=
asting
> > > bus bandwidth this adds complexity.
> > >=20
> > > I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this
> > > problem,
> > Right. And this seems like the ideal solution latency-wise since
> > this pushes data out to device without need for round-trips
> > over PCIe.
>=20
> Yes, and I'm not proposing getting rid of it.=A0 I'd expect a PCIe device=
 to
> use both features together.
>=20
> > > but we still have a problem.=A0 If you rely on doorbells to tell you
> > > how many descriptors are available, then you have to keep doorbells e=
nabled
> > > at all times.
> > I would say right now there are two modes and device can transition
> > between them at will:
> >=20
> > 1. read each descriptor twice - once speculatively, once
> >     to get the actual data
> >=20
> >     optimal for driver suboptimal for device
>=20
> You might read each descriptor multiple times in some scenarios. Reading
> descriptors in batches is hugely important given the latency and overheads
> of PCIe (and lack of adjacent data fetching that caching gives you).
>=20
> > 2. enable notification for each descritor and rely on
> >     these notifications
> >=20
> >     optimal for device suboptimal for driver
> >=20
> > > This can result in a very high rate of doorbells with some
> > > drivers, which can become a severe bottleneck (because x86 CPUs can't=
 emit
> > > MMIOs at very high rates).
> > Interesting. Is there any data you could share to help guide the design?
> > E.g. what's the highest rate of MMIO writes supported etc?
>=20
> On an E3-1270 v5 @ 3.60GHz, max rate across all cores is ~18M/s.
>=20
> On an E5-2637 v4 @ 3.50GHz, max rate on PCIe-local socket is ~14M/s.=A0 On
> PCIe-remote socket ~8M/s.

Is that mega bytes? Or million writes?
With 32 bit writes are we limited to 2M then?

> This doesn't just impose a limit on aggregate packet rate: If you hit this
> bottleneck then the CPU core is back-pressured by the MMIO writes, and so
> instr/cycle takes a huge hit.
>
> > > The proposed offset/wrap field allows devices to disable doorbells wh=
en
> > > appropriate, and determine the latest fill level via a PCIe read.
> > This kind of looks like a split ring though, does it not?
>=20
> I don't agree, because the ring isn't split.=A0 Split-ring is very painfu=
l for
> hardware because of the potentially random accesses to the descriptor tab=
le
> (including pointer chasing) which inhibit batching of descriptor fetches,=
 as
> well as causing complexity in implementation.

That's different with IN_ORDER, right?


> Packed ring is a huge improvement on both dimensions, but introduces a
> specific pain point for hardware offload.
>=20
> > The issue is
> > we will again need to bounce more cache lines to communicate.
>=20
> You'll only bounce cache lines if the device chooses to read the idx.=A0 =
A PV
> device need not offer this feature.=A0 A PCIe device will, but the cost t=
o the
> driver of writing an in-memory idx is much smaller than the cost of an MM=
IO,
> which is always a strongly ordered barrier on x86/64.
>=20
> With vDPA you ideally would have this feature enabled, and the device wou=
ld
> sometimes be PV and sometimes PCIe.=A0 The PV device would ignore the new=
 idx
> field and so cache lines would not bounce then either.
>=20
> Ie. The only time cache lines are shared is when sharing with a PCIe devi=
ce,
> which is the scenario when this is a win.

True. OTOH on non-x86 you will need more write barriers :( It would be
natural to say driver can reuse the barrier before flags update, but note
that that would mean hardware still needs to support re-fetching if
flags value is wrong. Such re-fetch is probably rare so fine by me, but it
does add a bit more complexity.


> > So I wonder: what if we made a change to spec that would allow prefetch
> > of ring entries?  E.g. you would be able to read at random and if you
> > guessed right then you can just use what you have read, no need to
> > re-fetch?
>=20
> Unless I've misunderstood I think this would imply that the driver would
> have to ensure strict ordering for each descriptor it wrote, which would
> impose a cost to the driver.=A0 At the moment a write barrier is only nee=
ded
> before writing the flags of the first descriptor in a batch.

On non-x86 right?  OTOH the extra data structure also adds more ordering
requirements.


> > > I suggest the best place to put this would be in the driver area,
> > > immediately after the event suppression structure.
> > Could you comment on why is that a good place though?
>=20
> The new field is written by the driver, as are the other fields in the
> driver area.=A0 Also I expect that devices might be able to read this new=
 idx
> together with the interrupt suppression fields in a single read, reducing
> PCIe overheads.

OK then you need it in the same aligned 256 byte boundary.


> Placing the new field immediately after the descriptor ring would also wo=
rk,
> but lose the benefit of combining reads, and potentially cause drivers to
> allocate a substantially bigger buffer (as I expect the descriptor ring is
> typically a power-of-2 size and drivers allocate multiples of page size).
>=20
> Placing the new field in a separate data structure is undesirable, as it
> would require devices to store a further 64bits per virt-queue.
>=20
> Thanks,
> David
>=20
>=20
> > > Presumably we would like this to be an optional feature, as implement=
ations
> > > of packed mode already exist in the wild.=A0 How about
> > > VIRTIO_F_RING_PACKED_AVAIL_IDX?
> > > If I prepare a patch to the spec is there still time to get this into=
 v1.1?
> > Any new feature would require another round of public review.
> > I personally think it's better to instead try to do 1.2 soon after,
> > e.g. we could try to target quarterly releases.
> >=20
> > But ultimately that would be up to the TC vote.
>=20
>=20
> --=20
> David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

