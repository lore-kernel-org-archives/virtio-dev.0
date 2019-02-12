Return-Path: virtio-dev-return-5391-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05D7D985CE7
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 05:09:01 +0000 (UTC)
Date: Tue, 12 Feb 2019 00:08:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211233612-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 11, 2019 at 02:58:30PM +0000, David Riddoch wrote:
> > > > > This can result in a very high rate of doorbells with some
> > > > > drivers, which can become a severe bottleneck (because x86 CPUs c=
an't emit
> > > > > MMIOs at very high rates).
> > > > Interesting. Is there any data you could share to help guide the de=
sign?
> > > > E.g. what's the highest rate of MMIO writes supported etc?
> > > On an E3-1270 v5 @ 3.60GHz, max rate across all cores is ~18M/s.
> > >=20
> > > On an E5-2637 v4 @ 3.50GHz, max rate on PCIe-local socket is ~14M/s.=
=A0 On
> > > PCIe-remote socket ~8M/s.
> > Is that mega bytes? Or million writes?
> > With 32 bit writes are we limited to 2M then?
>=20
> Sorry, this is million-writes-per-second.=A0 The size of the write doesn't
> matter.

So it's not too bad, you only need one per batch after all.


Also I thought some more about this. In fact on x86/intel specifically
PCI descriptor reads are atomic with cache line granularity
and writes are ordered. So in fact you can safely prefetch
descriptors and if you see them valid, you can go ahead
and use them.

This makes the descriptor index merely a hint for performance,
which device can play with at will.


Other platforms are not like this so you need the data
but do they have the same problem?





> > > This doesn't just impose a limit on aggregate packet rate: If you hit=
 this
> > > bottleneck then the CPU core is back-pressured by the MMIO writes, an=
d so
> > > instr/cycle takes a huge hit.
> > >=20
> > > > > The proposed offset/wrap field allows devices to disable doorbell=
s when
> > > > > appropriate, and determine the latest fill level via a PCIe read.
> > > > This kind of looks like a split ring though, does it not?
> > > I don't agree, because the ring isn't split.=A0 Split-ring is very pa=
inful for
> > > hardware because of the potentially random accesses to the descriptor=
 table
> > > (including pointer chasing) which inhibit batching of descriptor fetc=
hes, as
> > > well as causing complexity in implementation.
> > That's different with IN_ORDER, right?
>=20
> Yes, IN_ORDER will give some of the benefit of packed ring, and is also a
> win because you can merge 'used' writes.=A0 (But packed-ring still wins d=
ue to
> not having to fetch ring and descriptor table separately).
>
> > > Packed ring is a huge improvement on both dimensions, but introduces a
> > > specific pain point for hardware offload.
> > >=20
> > > > The issue is
> > > > we will again need to bounce more cache lines to communicate.
> > > You'll only bounce cache lines if the device chooses to read the idx.=
=A0 A PV
> > > device need not offer this feature.=A0 A PCIe device will, but the co=
st to the
> > > driver of writing an in-memory idx is much smaller than the cost of a=
n MMIO,
> > > which is always a strongly ordered barrier on x86/64.
> > >=20
> > > With vDPA you ideally would have this feature enabled, and the device=
 would
> > > sometimes be PV and sometimes PCIe.=A0 The PV device would ignore the=
 new idx
> > > field and so cache lines would not bounce then either.
> > >=20
> > > Ie. The only time cache lines are shared is when sharing with a PCIe =
device,
> > > which is the scenario when this is a win.
> > True. OTOH on non-x86 you will need more write barriers :( It would be
> > natural to say driver can reuse the barrier before flags update, but no=
te
> > that that would mean hardware still needs to support re-fetching if
> > flags value is wrong. Such re-fetch is probably rare so fine by me, but=
 it
> > does add a bit more complexity.
>=20
> I would prefer to have the write barrier before writing the idx.

Well that's driver overhead for something device might never utilise in
a given workload. If we are optimizing let's optimize for speed.

> Note that drivers could take advantage of this feature to avoid read
> barriers when consuming descriptors: At the moment there is a virtio_rmb()
> per descriptor read.=A0 With the proposed feature the driver can do just =
one
> barrier after reading idx.

Oh you want device to write a used index too? Hmm. Isn't this
contrary to your efforts to consume PCIe BW?

> I expect that on platforms where write barriers
> have a cost read barriers likely have a significant cost too, so this mig=
ht
> be a win with PV devices too.

I'm not sure.  It is pretty easy to replace an rmb with a dependency
which is generally quite cheap in my testing.

But since it's supposed to benefit PV, at this point we already have
implementations so rather than speculate (pun intended), people can
write patches and experiment.

For the proposed avail idx I think Jason (CC'd) was interested in adding
something like this for vhost.


> > > > So I wonder: what if we made a change to spec that would allow pref=
etch
> > > > of ring entries?  E.g. you would be able to read at random and if y=
ou
> > > > guessed right then you can just use what you have read, no need to
> > > > re-fetch?
> > > Unless I've misunderstood I think this would imply that the driver wo=
uld
> > > have to ensure strict ordering for each descriptor it wrote, which wo=
uld
> > > impose a cost to the driver.=A0 At the moment a write barrier is only=
 needed
> > > before writing the flags of the first descriptor in a batch.
> > On non-x86 right?  OTOH the extra data structure also adds more ordering
> > requirements.
>=20
> Yes on non-x86.=A0 The extra data structure only adds an ordering once per
> request (when enabled) whereas allowing prefetch would add an ordering per
> descriptor.=A0 The number of descriptors is always >=3D the number of req=
uests,
> and can be much larger (esp. for a net rx virt-queue).

Question is, is MMIO also slow on these non-x86 platforms?


Prefetch if successful just drastically lowers latency. You can't beat
not needing a read at all.

> > > > > I suggest the best place to put this would be in the driver area,
> > > > > immediately after the event suppression structure.
> > > > Could you comment on why is that a good place though?
> > > The new field is written by the driver, as are the other fields in the
> > > driver area.=A0 Also I expect that devices might be able to read this=
 new idx
> > > together with the interrupt suppression fields in a single read, redu=
cing
> > > PCIe overheads.
> > OK then you need it in the same aligned 256 byte boundary.
>=20
> The event suppression structs currently require 4byte align.=A0 Are you
> suggesting we increase the align required when
> VIRTIO_F_RING_PACKED_AVAIL_IDX is negotiated?=A0 Sounds good to me, but 8=
bytes
> would presumably suffice.

OK.

I am also wondering: what would the analog of this feature be for split
rings? We are burning a feature bit, might as well find a good
use for it.





> Thanks for the feedback.
>=20
> David
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

