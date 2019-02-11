Return-Path: virtio-dev-return-5387-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45A55985C59
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 14:58:37 +0000 (UTC)
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
Date: Mon, 11 Feb 2019 14:58:30 +0000
MIME-Version: 1.0
In-Reply-To: <20190211080432-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

>>>> This can result in a very high rate of doorbells with some
>>>> drivers, which can become a severe bottleneck (because x86 CPUs can't emit
>>>> MMIOs at very high rates).
>>> Interesting. Is there any data you could share to help guide the design?
>>> E.g. what's the highest rate of MMIO writes supported etc?
>> On an E3-1270 v5 @ 3.60GHz, max rate across all cores is ~18M/s.
>>
>> On an E5-2637 v4 @ 3.50GHz, max rate on PCIe-local socket is ~14M/s.  On
>> PCIe-remote socket ~8M/s.
> Is that mega bytes? Or million writes?
> With 32 bit writes are we limited to 2M then?

Sorry, this is million-writes-per-second.  The size of the write doesn't 
matter.

>> This doesn't just impose a limit on aggregate packet rate: If you hit this
>> bottleneck then the CPU core is back-pressured by the MMIO writes, and so
>> instr/cycle takes a huge hit.
>>
>>>> The proposed offset/wrap field allows devices to disable doorbells when
>>>> appropriate, and determine the latest fill level via a PCIe read.
>>> This kind of looks like a split ring though, does it not?
>> I don't agree, because the ring isn't split.  Split-ring is very painful for
>> hardware because of the potentially random accesses to the descriptor table
>> (including pointer chasing) which inhibit batching of descriptor fetches, as
>> well as causing complexity in implementation.
> That's different with IN_ORDER, right?

Yes, IN_ORDER will give some of the benefit of packed ring, and is also 
a win because you can merge 'used' writes.  (But packed-ring still wins 
due to not having to fetch ring and descriptor table separately).

>> Packed ring is a huge improvement on both dimensions, but introduces a
>> specific pain point for hardware offload.
>>
>>> The issue is
>>> we will again need to bounce more cache lines to communicate.
>> You'll only bounce cache lines if the device chooses to read the idx.  A PV
>> device need not offer this feature.  A PCIe device will, but the cost to the
>> driver of writing an in-memory idx is much smaller than the cost of an MMIO,
>> which is always a strongly ordered barrier on x86/64.
>>
>> With vDPA you ideally would have this feature enabled, and the device would
>> sometimes be PV and sometimes PCIe.  The PV device would ignore the new idx
>> field and so cache lines would not bounce then either.
>>
>> Ie. The only time cache lines are shared is when sharing with a PCIe device,
>> which is the scenario when this is a win.
> True. OTOH on non-x86 you will need more write barriers :( It would be
> natural to say driver can reuse the barrier before flags update, but note
> that that would mean hardware still needs to support re-fetching if
> flags value is wrong. Such re-fetch is probably rare so fine by me, but it
> does add a bit more complexity.

I would prefer to have the write barrier before writing the idx.

Note that drivers could take advantage of this feature to avoid read 
barriers when consuming descriptors: At the moment there is a 
virtio_rmb() per descriptor read.  With the proposed feature the driver 
can do just one barrier after reading idx.  I expect that on platforms 
where write barriers have a cost read barriers likely have a significant 
cost too, so this might be a win with PV devices too.

>>> So I wonder: what if we made a change to spec that would allow prefetch
>>> of ring entries?  E.g. you would be able to read at random and if you
>>> guessed right then you can just use what you have read, no need to
>>> re-fetch?
>> Unless I've misunderstood I think this would imply that the driver would
>> have to ensure strict ordering for each descriptor it wrote, which would
>> impose a cost to the driver.  At the moment a write barrier is only needed
>> before writing the flags of the first descriptor in a batch.
> On non-x86 right?  OTOH the extra data structure also adds more ordering
> requirements.

Yes on non-x86.  The extra data structure only adds an ordering once per 
request (when enabled) whereas allowing prefetch would add an ordering 
per descriptor.  The number of descriptors is always >= the number of 
requests, and can be much larger (esp. for a net rx virt-queue).

>>>> I suggest the best place to put this would be in the driver area,
>>>> immediately after the event suppression structure.
>>> Could you comment on why is that a good place though?
>> The new field is written by the driver, as are the other fields in the
>> driver area.  Also I expect that devices might be able to read this new idx
>> together with the interrupt suppression fields in a single read, reducing
>> PCIe overheads.
> OK then you need it in the same aligned 256 byte boundary.

The event suppression structs currently require 4byte align.  Are you 
suggesting we increase the align required when 
VIRTIO_F_RING_PACKED_AVAIL_IDX is negotiated?  Sounds good to me, but 
8bytes would presumably suffice.

Thanks for the feedback.

David

-- 
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

