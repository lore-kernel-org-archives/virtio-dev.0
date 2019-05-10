Return-Path: virtio-comment-return-725-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20190430135648.38369-1-jean-philippe.brucker@arm.com>
 <20190503102720-mutt-send-email-mst@kernel.org>
Message-ID: <14cb84e1-ceb1-e489-f29a-8d77d542561a@arm.com>
Date: Fri, 10 May 2019 13:07:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190503102720-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3] Add virtio-iommu device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, tnowicki@caviumnetworks.com, eric.auger@redhat.com, kevin.tian@intel.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Thanks for taking the time to review it! For brevity I only replied to
questions and the bits I don't completely agree with, I will change the
rest.

On 03/05/2019 18:05, Michael S. Tsirkin wrote:
> On Tue, Apr 30, 2019 at 02:56:48PM +0100, Jean-Philippe Brucker wrote:
>> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
[...]
>> +\item[VIRTIO_IOMMU_F_DOMAIN_BITS (1)]
>> +  The number of domains supported is described in \field{domain_bits}
> 
> I would rename this to domain_range or something like this.
> E.g. there's an option of 0 which is special.

I don't see a use for it right now, but I can make this a range.

>> +\drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
>> +
>> +The driver SHOULD accept any of the VIRTIO_IOMMU_F_INPUT_RANGE,
>> +VIRTIO_IOMMU_F_DOMAIN_BITS, VIRTIO_IOMMU_F_MAP_UNMAP and
>> +VIRTIO_IOMMU_F_PROBE feature bits if offered by the device.
> 
> Why does it have to accept MAP_UNMAP if it does not want to use it?

I was thinking a future version that adds another mode would remove this
statement. I can remove it, it's clear enough that currently the driver
won't get anything if it doesn't accept the bit.

>> +If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all endpoints can
>> +access guest-physical addresses ("bypass mode").
> 
> I think this means actually "all unattached endpoints"?
> 
> 
> So how does this interact with e.g. encrypted memory?
> I think it's actually weaker. This bit IMHO just means that
> all accesses are allowed by the iommu and all addresses
> are translated 1:1.

Yes that's what it means, I'll try to clarify the description. I haven't
looked at memory encryption yet, I guess it's disabled until you attach
a domain, and then you need to pass keys in an extended MAP request.

> Also what about other endpoints? With bypass
> does an endpoint not in any domain get access to all other
> endpoints?

Note that it's guest-physical addresses, not physical memory. If other
devices are memory-mapped, then with bypass an endpoint can access them.

>> If the feature is not
>> +negotiated, then any memory access from endpoints will fault.
> 
> fault -> fail?
> 
> So all accesses are disallowed, right?

Yes (Minus reserved regions in some cases. More below)

I rewrote the paragraph as:
"If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
unattached endpoints are allowed and translated by the IOMMU using the
identity function. If the feature is not negotiated, any memory access
from an unattached endpoint will fail. Upon attaching an endpoint in
bypass mode to a new domain, any memory access from the endpoint fails,
since the domain does not contain any mapping."

>> +
>> +\begin{itemize}
>> +\item \field{page_size_mask} contains the bitmask of all page sizes that
>> +  can be mapped. The least significant bit set defines the page
>> +  granularity of IOMMU mappings.
> 
> so this refers to map/unmap requests only really?

Yes

>> Other bits in the mask are hints
>> +  describing page sizes that the IOMMU can merge into a single mapping
>> +  (page blocks).
> 
> what does this merging refer to? I don't find it anywhere in the spec.

It doesn't refer to anything else in the spec, the current wording isn't
great. When the host stores mappings in page tables, it's useful for the
guest to know which huge page sizes are available. For example if the
physical IOMMU can map 2M and 1G blocks in addition to 4k pages, then
the mask is 0x40201000. The hints allow a guest to optimize DMA
allocation (iommu_dma_alloc() in Linux), in order to minimize the number
of IOTLB entries used in hardware.

I now have the following:
"Other bits in \field{page_size_mask} are hints and describe larger page
sizes that the IOMMU device handles efficiently. For example, when the
device stores mappings using a page table tree, it may be able to
describe large mappings using a few leaf entries in intermediate tables,
rather than using lots of entries in the last level of the tree.
Creating mappings aligned on large page size can improve performance
since they require fewer page tables and TLB entries."

>> +  The smallest page granularity supported by the IOMMU is one byte. It is
>> +  legal for the driver to map one byte at a time if bit 0 of
>> +  \field{page_size_mask} is set.
> 
> With single byte mappings, can't guest quickly exhaust
> device memory? what guidance can we provide for handling
> this kind of issue? how do device and driver avoid it?

The advantage of a single-byte granularity is arbitrary mapping sizes,
it doesn't mean that the driver will use any single-byte mapping. If the
host uses page tables to store mappings then the granularity is
generally 4kB. But if it uses interval trees then it can have
arbitrary mapping sizes, for example the guest could map a packet with a
1500-byte mapping.

For the moment the best way to deal with memory exhaustion might be to
return a "out of memory" status in the MAP request (more below).

>> +\subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device operations / ATTACH request}
>> +
>> +\begin{lstlisting}
>> +struct virtio_iommu_req_attach {
>> +  struct virtio_iommu_req_head head;
>> +  le32 domain;
>> +  le32 endpoint;
>> +  u8   reserved[8];
>> +  struct virtio_iommu_req_tail tail;
>> +};
>> +\end{lstlisting}
>> +
>> +Attach an endpoint to a domain. \field{domain} is an identifier unique to
>> +the virtio-iommu device.
> 
> what does this mean? do you mean that it uniquely identifies
> a domain? 

It uniquely identifies a domain for one device. When there are multiple
virtio-iommu devices, the driver can maintain one domain ID space per
device rather than a global ID space.

> And I guess the assumption is that endpoints in different domains
> are isolated from each other?

Yes, I'll add this.

>> +\devicenormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}
>> +
>> +If the \field{reserved} field of an ATTACH request is not zero, the device
>> +SHOULD set the request \field{status} to VIRTIO_IOMMU_S_INVAL and SHOULD
>> +NOT attach the endpoint to the domain. \footnote{The device should
> 
> what does should mean here? Is expected to? Or is this part of
> the conformance clause? the SHOULD and take it out of the footnote.
> 
>> +validate input of ATTACH requests in case the driver attempts to attach in
>> +a mode that is unimplemented by the device, and would be incompatible with
>> +the modes implemented by the device.}
> 
> Where does mode come from?

It would be a new feature bit. I don't think the footnote is useful, so
I'll just specify that the device rejects the request if reserved != 0.

>> +\subsubsection{MAP request}\label{sec:Device Types / IOMMU Device / Device operations / MAP request}
>> +
>> +\begin{lstlisting}
>> +struct virtio_iommu_req_map {
>> +  struct virtio_iommu_req_head head;
>> +  le32  domain;
>> +  le64  virt_start;
>> +  le64  virt_end;
>> +  le64  phys_start;
>> +  le32  flags;
>> +  struct virtio_iommu_req_tail tail;
>> +};
>> +
>> +/* Flags are: */
>> +#define VIRTIO_IOMMU_MAP_F_READ   (1 << 0)
>> +#define VIRTIO_IOMMU_MAP_F_WRITE  (1 << 1)
>> +#define VIRTIO_IOMMU_MAP_F_EXEC   (1 << 2)
> 
> what is exec? pls add some comments near all flags.

Exec means instruction fetch. Some systems have different transaction
flags for read and exec (PCI only supports that in the PASID TLP prefix)
and some page tables have a "no exec" bit.

>> The precise meaning of the MMIO flag depends on the
>> +underlying memory architecture (for example on Armv8-A it corresponds to
>> +the "Device-nGnRE" memory type). Unless needed by mapped MSIs, the device
>> +isn't required to support the MMIO flag.
> 
> I really dislike how this part is written. A platform specific bit that
> does whatever platform wants? How does one use it based on this?
> Platform documentation is hoghly unlikely to explain what does
> VIRTIO_IOMMU_MAP_F_MMIO mean.
> 
> Does this mean "not buffered, elided, or combined with other writes"?
> 
> Also maybe add a feature bit so platforms can declare support.

Right, a feature bit for MMIO is a good idea. I'll add one for EXEC as
well. I'll describe MMIO using only the expected behavior of memory
accesses to the region, which is the same regardless of the architecture.

>> +The device MUST NOT allow writes to a range mapped without the
>> +VIRTIO_IOMMU_MAP_F_WRITE flag. However, if the underlying architecture
>> +does not support write-only mappings, the device MAY allow reads to a
>> +range mapped with VIRTIO_IOMMU_MAP_F_WRITE but not
>> +VIRTIO_IOMMU_MAP_F_READ.
> 
> do drivers care? if yes how about a way for it to know?

I don't think they care. If write-implies-read was a security problem I
think that architectures (x86, arm64) would have changed it by now.

>> +(4) a = map(0, 9);
>> +    unmap(0, 4)                  -> faults, doesn't unmap anything
> 
> fails?
> 
>> +
>> +(5) a = map(0, 4);
>> +    b = map(5, 9);
>> +    unmap(0, 4)                  -> succeeds, unmaps a
>> +
>> +(6) a = map(0, 4);
>> +    unmap(0, 9)                  -> succeeds, unmaps a
>> +
>> +(7) a = map(0, 4);
>> +    b = map(10, 14);
>> +    unmap(0, 14)                 -> succeeds, unmaps a and b
>> +\end{lstlisting}
>> +
> 
> what about a partial unmap? e.g. unmap 0, 3?

That's not allowed at the moment (example 4 and next-to-last paragraph
of device normative).

>> +If a mapping affected by the range is not covered in its entirety by the
>> +range (the UNMAP request would split the mapping), then the device SHOULD
>> +set the request \field{status} to VIRTIO_IOMMU_S_RANGE, and SHOULD NOT
>> +remove any mapping.
>> +
>> +If part of the range or the full range is not covered by an existing
>> +mapping, then the device SHOULD remove all mappings affected by the range
>> +and set the request \field{status} to VIRTIO_IOMMU_S_OK.
>> +
> 
> 
> So based on above, it seems clear that device must remember any number
> of mappings sent to it in device memory. Seems like an easy way
> for guest to use any amount of device memory.
> 
> If any limits are allowed then I think device needs a way
> to communicate them to driver.

Except for embedded implementations, it seems difficult to determine a
limit upfront, since it's going to depend on the host's memory which
changes at runtime. And even if we do advertise a limit in the config,
the driver is unlikely to change its DMA allocation strategy. It will
still create mappings until it has to return an error to the caller. So
for now the best strategy is probably for the device to return a DEVERR
status when it runs out of mappings.

>> +The driver parses the first property by reading \field{type}, then
>> +\field{length}. If the driver recognizes \field{type}, it reads and
>> +handles the rest of the property. The driver then reads the next property,
>> +that is located $(\field{length} + 4)$ bytes after the beginning of the
>> +first one, and so on. The driver parses all properties until it reaches a
>> +NONE property or the end of \field{properties}.
> 
> I guess device must make sure length fits within the buffer?

Yes, the device knows how much info it needs to communicate, and writes
it in the probe_size field of the config.

>> +\paragraph{Property NONE}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / NONE}
>> +
>> +Marks the end of the property list. This property doesn't have any value,
>> +and should have \field{length} 0.
> 
> why is this needed btw?

Just provides a convenient way to mark the end of the list.

>> +\paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
>> +
>> +The RESV_MEM property describes a chunk of reserved virtual memory. It may
>> +be used by the device to describe virtual address ranges that shouldn't be
>> +allocated by the driver, or that are special.
> 
> avoid shouldn't outside conformance clauses. maybe add a conformance
> clause that driver must avoid these ranges?
> what if driver ignores this property? I guess device must validate
> the addresses?

Yes, device returns an error when a MAP request crosses a resv region.

> 
>> +
>> +\begin{lstlisting}
>> +struct virtio_iommu_probe_resv_mem {
>> +  struct virtio_iommu_probe_property head;
>> +  u8    subtype;
>> +  u8    reserved[3];
>> +  le64  start;
>> +  le64  end;
>> +};
>> +\end{lstlisting}
>> +
>> +Fields \field{start} and \field{end} describe the range of reserved virtual
>> +addresses. \field{subtype} may be one of:
>> +
>> +\begin{description}
>> +  \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
>> +    Accesses to virtual addresses in this region have undefined behavior.
> 
> undefined?  how can platforms with such a property coexist with untrusted
> devices?

It is "undefined" because I can't enumerate all cases (don't know about
all of them). This would contain for example the RMRR regions of VT-d
(the BIOS reserving some DMA regions for itself), regions allocated for
host-managed MSIs on arm platforms, and some PCI bridge windows
(although they removed those from the Linux resv regions recently, not
certain why). Ideally we wouldn't have any, but some special cases make
it necessary.

In general having reserved regions is incompatible with untrusted
devices, and in some cases incompatible with untrusted guests. But
choosing the policy about which devices to present to guest is up to the
platform. The host knows what the resv regions are used for, and if they
are safe enough. The guest just need to knows what to avoid.

> 
>> +    They may be aborted by the device,
> 
> the device as in the iommu device?

Yes, although I can't think of an example of this case right now.

> 
>> bypass it,
> 
> bypass might be a big security problem.

I have two cases in mind:
* MSI, which is fine since the irqchip provides device isolation,
* mappings reserved by the BIOS, which again only affects the device but
may allow the guest to access firmware information. In my opinion such
endpoint shouldn't be assigned to a guest.

>> or never even reach it.
> 
> that's ok

We could be losing isolation if some bridge is intercepting accesses to
a range of addresses.

>> +    The region may also be used for host mappings, for example Message
>> +    Signaled Interrupts.
> 
> Let's avoid mentioning host if we can.
> 
>> +
>> +    The guest should neither use these virtual addresses in a MAP request
>> +    nor instruct endpoints to perform DMA on them.
> 
> avoid should outside conformance clauses.
> 
> and what it guest does not obey this request?
> 
> I think we must fix this and require that such accesses
> are ignored.

That's generally not something the host can enforce. It has to make sure
that such accesses would only disturb the guest or the endpoint.
Otherwise it had better trust both guest and endpoint, or it shouldn't
present the endpoint to the guest at all.

>> +The driver SHOULD treat any \field{subtype} it doesn't recognize as if it
>> +was VIRTIO_IOMMU_RESV_MEM_T_RESERVED.
> 
> why is that a good idea?

Some future version might add a new reserved type that provides more
details. For a driver that doesn't recognize it but would still work
without the additional details, it's better to treat it as a reserved
region than try to map it.

>> +These faults are not recoverable\footnote{This means that the PRI
>> +extension to PCI, for example, that allows recoverable faults, isn't
>> +supported for the moment.}. The guest has to do its best to
>> +prevent any future fault from happening, by stopping or resetting the
>> +endpoint.
> 
> what does recoverable mean from virtio iommu pov?
> nothing right?
> it's an endpoint issue.

With PRI the IOMMU receives page requests, and handles them through the
memory management subsystem. A response to the fault ("we fixed the
fault, retry access") is returned through the IOMMU, not the endpoint.

> 
>> +
>> +When the fault is reported by a physical IOMMU, the fault reasons may not
>> +match exactly the reason of the original fault report. The device should
>> +try its best to find the closest match.
>> +
>> +If the device encounters a fault
> 
> device doesn't right? endpoint does ...

This paragraph describes what to do if the virtio-iommu encounters
some asynchronous error of its own, without any endpoint involved.

> 
>> that wasn't caused by a specific
>> +endpoint, it is unlikely that the driver would be able to do anything else
>> +than print the fault and stop using the device, so reporting the fault on
>> +the event queue isn't useful. In that case, we recommend using the
>> +DEVICE_NEEDS_RESET status bit.

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

