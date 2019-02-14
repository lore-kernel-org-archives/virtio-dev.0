Return-Path: virtio-dev-return-5443-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2BBE986074
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Feb 2019 03:41:47 +0000 (UTC)
Date: Wed, 13 Feb 2019 22:41:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190213223515-mutt-send-email-mst@kernel.org>
References: <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
 <20190211233612-mutt-send-email-mst@kernel.org>
 <3ce6415d-e36d-8dcb-dd99-5203a63e5883@redhat.com>
 <20190212082915-mutt-send-email-mst@kernel.org>
 <9bed9f5d-ab7d-287e-3497-0c4b61e3b8c0@redhat.com>
 <20190213100640-mutt-send-email-mst@kernel.org>
 <dda354db-2b63-8f73-8017-a7ded99a822e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dda354db-2b63-8f73-8017-a7ded99a822e@redhat.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Jason Wang <jasowang@redhat.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 14, 2019 at 11:21:54AM +0800, Jason Wang wrote:
> 
> On 2019/2/13 下午11:20, Michael S. Tsirkin wrote:
> > On Wed, Feb 13, 2019 at 06:00:41PM +0800, Jason Wang wrote:
> > > On 2019/2/12 下午9:44, Michael S. Tsirkin wrote:
> > > > On Tue, Feb 12, 2019 at 03:28:26PM +0800, Jason Wang wrote:
> > > > > On 2019/2/12 下午1:08, Michael S. Tsirkin wrote:
> > > > > > On Mon, Feb 11, 2019 at 02:58:30PM +0000, David Riddoch wrote:
> > > > > > > > > > > This can result in a very high rate of doorbells with some
> > > > > > > > > > > drivers, which can become a severe bottleneck (because x86 CPUs can't emit
> > > > > > > > > > > MMIOs at very high rates).
> > > > > > > > > > Interesting. Is there any data you could share to help guide the design?
> > > > > > > > > > E.g. what's the highest rate of MMIO writes supported etc?
> > > > > > > > > On an E3-1270 v5 @ 3.60GHz, max rate across all cores is ~18M/s.
> > > > > > > > > 
> > > > > > > > > On an E5-2637 v4 @ 3.50GHz, max rate on PCIe-local socket is ~14M/s.  On
> > > > > > > > > PCIe-remote socket ~8M/s.
> > > > > > > > Is that mega bytes? Or million writes?
> > > > > > > > With 32 bit writes are we limited to 2M then?
> > > > > > > Sorry, this is million-writes-per-second.  The size of the write doesn't
> > > > > > > matter.
> > > > > > So it's not too bad, you only need one per batch after all.
> > > > > > 
> > > > > > 
> > > > > > Also I thought some more about this. In fact on x86/intel specifically
> > > > > > PCI descriptor reads are atomic with cache line granularity
> > > > > > and writes are ordered. So in fact you can safely prefetch
> > > > > > descriptors and if you see them valid, you can go ahead
> > > > > > and use them.
> > > > > If I understand this correctly, unless driver set avail in order for several
> > > > > descriptors. Device could not assume that if N is avail then [0, N) is also
> > > > > available.
> > > > Well you don't need that assumption. You check it and discard
> > > > prefetched data if not.
> > > 
> > > Ok, this is probably ok for hardware implementation. But for software
> > > implementation, it may result lots of re-read.
> > That will be on a slow path where you got unlucky.
> 
> 
> Yes.
> 
> 
> > 
> > 
> > > > 
> > > > > But prefetching indeed improve the performance when I play with vhost kernel
> > > > > implementation. It reduces the overhead of memory accessing, which is
> > > > > similar to PCI.
> > > > Prefetch as in prefetchnta?
> > > 
> > > Sorry, "prefetch" is probably not accurate. "Speculation" is probably
> > > better.
> > > 
> > > What I did is just read more than one descriptor e.g 16. And check whether
> > > the last is available, if yes, assume all the rest are available.
> > So how problematic is it to check them all?  In fact you can optimize
> > out the rmb (or dependency barrier), just issue one barrier after
> > checking all.
> 
> 
> Let me reply in another thread.
> 
> 
> > 
> > 
> > > > 
> > > > > > This makes the descriptor index merely a hint for performance,
> > > > > > which device can play with at will.
> > > > > > 
> > > > > > 
> > > > > > Other platforms are not like this so you need the data
> > > > > > but do they have the same problem?
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > > This doesn't just impose a limit on aggregate packet rate: If you hit this
> > > > > > > > > bottleneck then the CPU core is back-pressured by the MMIO writes, and so
> > > > > > > > > instr/cycle takes a huge hit.
> > > > > > > > > 
> > > > > > > > > > > The proposed offset/wrap field allows devices to disable doorbells when
> > > > > > > > > > > appropriate, and determine the latest fill level via a PCIe read.
> > > > > > > > > > This kind of looks like a split ring though, does it not?
> > > > > > > > > I don't agree, because the ring isn't split.  Split-ring is very painful for
> > > > > > > > > hardware because of the potentially random accesses to the descriptor table
> > > > > > > > > (including pointer chasing) which inhibit batching of descriptor fetches, as
> > > > > > > > > well as causing complexity in implementation.
> > > > > > > > That's different with IN_ORDER, right?
> > > > > > > Yes, IN_ORDER will give some of the benefit of packed ring, and is also a
> > > > > > > win because you can merge 'used' writes.  (But packed-ring still wins due to
> > > > > > > not having to fetch ring and descriptor table separately).
> > > > > Note, with IN_ORDER, there's no need to read available ring at all even for
> > > > > split ring. And in some cases, no need to update used ring at all.
> > > > Yes you said so at some point but it seems that the spec
> > > > is written ambigously and others do not read it like this.
> > > > Can you clarify?
> > > 
> > > Yes, it was unclear about how available ring was dealt with in this case. My
> > > understanding is, since device use the descriptor table in order, if
> > > last_avail_idx is N and avail_idx is M, driver could assume [N, M) is
> > > available. In this case, avail_idx points to idx of descriptor ring instead
> > > of avail ring. So there's no need for both side to read or write avail ring
> > > entries.
> > > 
> > > Does this make sense? 10% PPS was seen through this way when I playing this
> > > for vhost.
> > Problem is, if you add a chain of descriptors, index is incremented by 1
> > while the descriptor buffer advances by X. So how can you find out
> > without reading avail ring?
> 
> 
> I think it's as simple as increase the avail idx by X? Since descriptor were
> used in order, device can just read the next X-1 descriptors in this case.
> 
> Thanks

Right so a spec change would be needed, it's not transparent to guest.



> 
> > 
> > Maybe you can start with fetching based on index (so 1 above), then
> > fetch an extra descriptor each time you see a NEXT bit.
> > And given PV tends to use INDIRECT aggressively, that won't happen
> > too often.
> > Is that the idea?
> > 
> > 
> > > > 
> > > > > > > > > Packed ring is a huge improvement on both dimensions, but introduces a
> > > > > > > > > specific pain point for hardware offload.
> > > > > > > > > 
> > > > > > > > > > The issue is
> > > > > > > > > > we will again need to bounce more cache lines to communicate.
> > > > > > > > > You'll only bounce cache lines if the device chooses to read the idx.  A PV
> > > > > > > > > device need not offer this feature.  A PCIe device will, but the cost to the
> > > > > > > > > driver of writing an in-memory idx is much smaller than the cost of an MMIO,
> > > > > > > > > which is always a strongly ordered barrier on x86/64.
> > > > > > > > > 
> > > > > > > > > With vDPA you ideally would have this feature enabled, and the device would
> > > > > > > > > sometimes be PV and sometimes PCIe.  The PV device would ignore the new idx
> > > > > > > > > field and so cache lines would not bounce then either.
> > > > > > > > > 
> > > > > > > > > Ie. The only time cache lines are shared is when sharing with a PCIe device,
> > > > > > > > > which is the scenario when this is a win.
> > > > > > > > True. OTOH on non-x86 you will need more write barriers :( It would be
> > > > > > > > natural to say driver can reuse the barrier before flags update, but note
> > > > > > > > that that would mean hardware still needs to support re-fetching if
> > > > > > > > flags value is wrong. Such re-fetch is probably rare so fine by me, but it
> > > > > > > > does add a bit more complexity.
> > > > > > > I would prefer to have the write barrier before writing the idx.
> > > > > > Well that's driver overhead for something device might never utilise in
> > > > > > a given workload. If we are optimizing let's optimize for speed.
> > > > > > 
> > > > > > > Note that drivers could take advantage of this feature to avoid read
> > > > > > > barriers when consuming descriptors: At the moment there is a virtio_rmb()
> > > > > > > per descriptor read.  With the proposed feature the driver can do just one
> > > > > > > barrier after reading idx.
> > > > > > Oh you want device to write a used index too? Hmm. Isn't this
> > > > > > contrary to your efforts to consume PCIe BW?
> > > > > > 
> > > > > > > I expect that on platforms where write barriers
> > > > > > > have a cost read barriers likely have a significant cost too, so this might
> > > > > > > be a win with PV devices too.
> > > > > > I'm not sure.  It is pretty easy to replace an rmb with a dependency
> > > > > > which is generally quite cheap in my testing.
> > > > > > 
> > > > > > But since it's supposed to benefit PV, at this point we already have
> > > > > > implementations so rather than speculate (pun intended), people can
> > > > > > write patches and experiment.
> > > > > > 
> > > > > > For the proposed avail idx I think Jason (CC'd) was interested in adding
> > > > > > something like this for vhost.
> > > > > Yes, it's kind of IN_ORDER + split ring I believe.
> > > > > 
> > > > > Thanks
> > > > Well IN_ORDER is only good for e.g. network. Storage wants out of order
> > > > so it could benefit from a new feature.  I am however worried about the
> > > > extra wmb implied.  Still thinking about ways to avoid adding that.
> > > > 
> > > Ok.
> > > 
> > > Thanks
> > > 
> > > 
> > > > 
> > > > > > > > > > So I wonder: what if we made a change to spec that would allow prefetch
> > > > > > > > > > of ring entries?  E.g. you would be able to read at random and if you
> > > > > > > > > > guessed right then you can just use what you have read, no need to
> > > > > > > > > > re-fetch?
> > > > > > > > > Unless I've misunderstood I think this would imply that the driver would
> > > > > > > > > have to ensure strict ordering for each descriptor it wrote, which would
> > > > > > > > > impose a cost to the driver.  At the moment a write barrier is only needed
> > > > > > > > > before writing the flags of the first descriptor in a batch.
> > > > > > > > On non-x86 right?  OTOH the extra data structure also adds more ordering
> > > > > > > > requirements.
> > > > > > > Yes on non-x86.  The extra data structure only adds an ordering once per
> > > > > > > request (when enabled) whereas allowing prefetch would add an ordering per
> > > > > > > descriptor.  The number of descriptors is always >= the number of requests,
> > > > > > > and can be much larger (esp. for a net rx virt-queue).
> > > > > > Question is, is MMIO also slow on these non-x86 platforms?
> > > > > > 
> > > > > > 
> > > > > > Prefetch if successful just drastically lowers latency. You can't beat
> > > > > > not needing a read at all.
> > > > > > 
> > > > > > > > > > > I suggest the best place to put this would be in the driver area,
> > > > > > > > > > > immediately after the event suppression structure.
> > > > > > > > > > Could you comment on why is that a good place though?
> > > > > > > > > The new field is written by the driver, as are the other fields in the
> > > > > > > > > driver area.  Also I expect that devices might be able to read this new idx
> > > > > > > > > together with the interrupt suppression fields in a single read, reducing
> > > > > > > > > PCIe overheads.
> > > > > > > > OK then you need it in the same aligned 256 byte boundary.
> > > > > > > The event suppression structs currently require 4byte align.  Are you
> > > > > > > suggesting we increase the align required when
> > > > > > > VIRTIO_F_RING_PACKED_AVAIL_IDX is negotiated?  Sounds good to me, but 8bytes
> > > > > > > would presumably suffice.
> > > > > > OK.
> > > > > > 
> > > > > > I am also wondering: what would the analog of this feature be for split
> > > > > > rings? We are burning a feature bit, might as well find a good
> > > > > > use for it.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Thanks for the feedback.
> > > > > > > 
> > > > > > > David
> > > > > > > 
> > > > > > > -- 
> > > > > > > David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare
> > > > > > > 
> > > > > > > 
> > > > > > > ---------------------------------------------------------------------
> > > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

