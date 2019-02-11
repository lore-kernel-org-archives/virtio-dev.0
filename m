Return-Path: virtio-dev-return-5383-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E99E985BE6
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 08:52:08 +0000 (UTC)
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
Date: Mon, 11 Feb 2019 08:52:01 +0000
MIME-Version: 1.0
In-Reply-To: <20190211021124-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/02/2019 07:33, Michael S. Tsirkin wrote:
> On Fri, Feb 01, 2019 at 02:23:55PM +0000, David Riddoch wrote:
>> All,
>>
>> I'd like to propose a small extension to the packed virtqueue mode.  My
>> proposal is to add an offset/wrap field, written by the driver, indicating
>> how many available descriptors have been added to the ring.
>>
>> The reason for wanting this is to improve performance of hardware devices.
>> Because of high read latency over a PCIe bus, it is important for hardware
>> devices to read multiple ring entries in parallel.  It is desirable to know
>> how many descriptors are available prior to issuing these reads, else you
>> risk fetching descriptors that are not yet available.  As well as wasting
>> bus bandwidth this adds complexity.
>>
>> I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this
>> problem,
> Right. And this seems like the ideal solution latency-wise since
> this pushes data out to device without need for round-trips
> over PCIe.

Yes, and I'm not proposing getting rid of it.  I'd expect a PCIe device 
to use both features together.

>> but we still have a problem.  If you rely on doorbells to tell you
>> how many descriptors are available, then you have to keep doorbells enabled
>> at all times.
> I would say right now there are two modes and device can transition
> between them at will:
>
> 1. read each descriptor twice - once speculatively, once
>     to get the actual data
>
>     optimal for driver suboptimal for device

You might read each descriptor multiple times in some scenarios. Reading 
descriptors in batches is hugely important given the latency and 
overheads of PCIe (and lack of adjacent data fetching that caching gives 
you).

> 2. enable notification for each descritor and rely on
>     these notifications
>
>     optimal for device suboptimal for driver
>
>> This can result in a very high rate of doorbells with some
>> drivers, which can become a severe bottleneck (because x86 CPUs can't emit
>> MMIOs at very high rates).
> Interesting. Is there any data you could share to help guide the design?
> E.g. what's the highest rate of MMIO writes supported etc?

On an E3-1270 v5 @ 3.60GHz, max rate across all cores is ~18M/s.

On an E5-2637 v4 @ 3.50GHz, max rate on PCIe-local socket is ~14M/s.  On 
PCIe-remote socket ~8M/s.

This doesn't just impose a limit on aggregate packet rate: If you hit 
this bottleneck then the CPU core is back-pressured by the MMIO writes, 
and so instr/cycle takes a huge hit.

>> The proposed offset/wrap field allows devices to disable doorbells when
>> appropriate, and determine the latest fill level via a PCIe read.
> This kind of looks like a split ring though, does it not?

I don't agree, because the ring isn't split.  Split-ring is very painful 
for hardware because of the potentially random accesses to the 
descriptor table (including pointer chasing) which inhibit batching of 
descriptor fetches, as well as causing complexity in implementation.

Packed ring is a huge improvement on both dimensions, but introduces a 
specific pain point for hardware offload.

> The issue is
> we will again need to bounce more cache lines to communicate.

You'll only bounce cache lines if the device chooses to read the idx.  A 
PV device need not offer this feature.  A PCIe device will, but the cost 
to the driver of writing an in-memory idx is much smaller than the cost 
of an MMIO, which is always a strongly ordered barrier on x86/64.

With vDPA you ideally would have this feature enabled, and the device 
would sometimes be PV and sometimes PCIe.  The PV device would ignore 
the new idx field and so cache lines would not bounce then either.

Ie. The only time cache lines are shared is when sharing with a PCIe 
device, which is the scenario when this is a win.

> So I wonder: what if we made a change to spec that would allow prefetch
> of ring entries?  E.g. you would be able to read at random and if you
> guessed right then you can just use what you have read, no need to
> re-fetch?

Unless I've misunderstood I think this would imply that the driver would 
have to ensure strict ordering for each descriptor it wrote, which would 
impose a cost to the driver.  At the moment a write barrier is only 
needed before writing the flags of the first descriptor in a batch.

>> I suggest the best place to put this would be in the driver area,
>> immediately after the event suppression structure.
> Could you comment on why is that a good place though?

The new field is written by the driver, as are the other fields in the 
driver area.  Also I expect that devices might be able to read this new 
idx together with the interrupt suppression fields in a single read, 
reducing PCIe overheads.

Placing the new field immediately after the descriptor ring would also 
work, but lose the benefit of combining reads, and potentially cause 
drivers to allocate a substantially bigger buffer (as I expect the 
descriptor ring is typically a power-of-2 size and drivers allocate 
multiples of page size).

Placing the new field in a separate data structure is undesirable, as it 
would require devices to store a further 64bits per virt-queue.

Thanks,
David


>> Presumably we would like this to be an optional feature, as implementations
>> of packed mode already exist in the wild.  How about
>> VIRTIO_F_RING_PACKED_AVAIL_IDX?
>> If I prepare a patch to the spec is there still time to get this into v1.1?
> Any new feature would require another round of public review.
> I personally think it's better to instead try to do 1.2 soon after,
> e.g. we could try to target quarterly releases.
>
> But ultimately that would be up to the TC vote.


-- 
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

