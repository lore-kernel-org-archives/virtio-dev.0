Return-Path: virtio-comment-return-727-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20190430135648.38369-1-jean-philippe.brucker@arm.com>
 <20190503102720-mutt-send-email-mst@kernel.org>
 <14cb84e1-ceb1-e489-f29a-8d77d542561a@arm.com>
 <20190510122220-mutt-send-email-mst@kernel.org>
Message-ID: <18182871-5a30-9ef4-e6bc-73f5ad32b7e8@arm.com>
Date: Tue, 14 May 2019 17:07:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190510122220-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3] Add virtio-iommu device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@caviumnetworks.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/05/2019 17:52, Michael S. Tsirkin wrote:
>>>> +/* Flags are: */
>>>> +#define VIRTIO_IOMMU_MAP_F_READ   (1 << 0)
>>>> +#define VIRTIO_IOMMU_MAP_F_WRITE  (1 << 1)
>>>> +#define VIRTIO_IOMMU_MAP_F_EXEC   (1 << 2)
>>>
>>> what is exec? pls add some comments near all flags.
>>
>> Exec means instruction fetch. Some systems have different transaction
>> flags for read and exec (PCI only supports that in the PASID TLP prefix)
>> and some page tables have a "no exec" bit.
> 
> So let's say I don't set EXEC on such a system. Is EXEC allowed or not?
> 
> Maybe we can ask user to always set EXEC is exec is needed,
> but then say we can not promise instruction fetch will fail
> if exec is not set.

So the semantics could be:
* device sets EXEC feature bit
  - driver sets EXEC flag in MAP, instruction fetch succeeds
  - driver doesn't set EXEC flag in MAP, instructions fetch will fail
* device doesn't set EXEC feature bit, then driver cannot set EXEC flag
but instruction fetch may not fail.

But I'm tempted to just remove the EXEC flag for now, I don't think
anyone needs it at the moment (and VFIO doesn't support it). I'd add it
back as NO_EXEC which is closer to what IOMMUs offer.


>>>> +\begin{description}
>>>> +  \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
>>>> +    Accesses to virtual addresses in this region have undefined behavior.
>>>
>>> undefined?  how can platforms with such a property coexist with untrusted
>>> devices?
>>
>> It is "undefined" because I can't enumerate all cases (don't know about
>> all of them). This would contain for example the RMRR regions of VT-d
>> (the BIOS reserving some DMA regions for itself), regions allocated for
>> host-managed MSIs on arm platforms, and some PCI bridge windows
>> (although they removed those from the Linux resv regions recently, not
>> certain why). Ideally we wouldn't have any, but some special cases make
>> it necessary.
>>
>> In general having reserved regions is incompatible with untrusted
>> devices, and in some cases incompatible with untrusted guests. But
>> choosing the policy about which devices to present to guest is up to the
>> platform. The host knows what the resv regions are used for, and if they
>> are safe enough. The guest just need to knows what to avoid.
> 
> Yes but ... if you trust driver and device then what's the
> point of the iommu?

Improving memory allocation. The guest can do scatter-gather for large
buffers, instead of allocating big contiguous chunks of guest-physical
addresses. And with device pass-through, any memory used for DMA has to
be pinned (since devices generally don't support page faults). So when
assigning an endpoint to a guest, without a vIOMMU all of the guest
memory has to be pinned upfront. With an IOMMU only the memory that will
actually be used for DMA is pinned.

> RMRR access basically fails with translation right?
> Not undefined.

From section 3.15 of VT-d rev3.0, it looks like they are translated

"Requests to these reserved regions may either occur as a result of
operations performed by the system software driver (for example in the
case of DMA from unified memory access (UMA) graphics controllers to
graphics reserved memory), or may be initiated by non system software
(for example in case of DMA performed by a USB controller under BIOS SMM
control for legacy keyboard emulation)."

> What happens with MSIs on ARM?

On Arm platforms it's the IRQ chip rather than the IOMMU that performs
MSI isolation - ensure that an endpoint doesn't trigger MSIs for another
endpoint. The SMMU doesn't differentiate an MSI from a normal write,
unlike x86 which has a special address range. MSI-X tables for a
pass-through device are managed by the host, and a virtual MSI-X table
is presented to the guest. So the host allocates a VA range and use it
to map the MSI doorbell in the SMMU. It then reports that VA range as
reserved to the guest. If the endpoint did write to the region, nothing
bad would happen, it would simply trigger an MSI as if it had triggered
via the MSI-X table. But the guest can't use that region for normal
memory mapping.

>>>> or never even reach it.
>>>
>>> that's ok
>>
>> We could be losing isolation if some bridge is intercepting accesses to
>> a range of addresses.
> 
> hmm sorry not sure I understand.

After reading a bit more about this, I don't think this is relevant here.

This was about lack of ACS isolation allowing endpoints to do p2p by
writing to some specific MMIO region, but we already deal with this in
the ATTACH section - either endpoints are properly isolated with ACS, or
the platform describes them as being in the same IOMMU group and they
cannot be isolated from each other. We don't need to care about reserved
MMIO ranges on top of that.

RESV_MEM is used for MSI and RMRR-style regions for now, so I'll
reformulate this paragraph. I'll also require that accesses to RESV
regions don't affect anything else than the endpoint and the SW that
owns it.


>>>> +The driver SHOULD treat any \field{subtype} it doesn't recognize as if it
>>>> +was VIRTIO_IOMMU_RESV_MEM_T_RESERVED.
>>>
>>> why is that a good idea?
>>
>> Some future version might add a new reserved type that provides more
>> details. For a driver that doesn't recognize it but would still work
>> without the additional details, it's better to treat it as a reserved
>> region than try to map it.
> 
> confused. didn't we say we never map these addresses?
> if we just ignore a type then we will map the virtual address no?

Yes, that's why we require the driver not to ignore the region

Thanks,
Jean

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

