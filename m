Return-Path: virtio-dev-return-2510-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A91305819215
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2017 04:45:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <f9b02ce1-057f-df4f-90d7-52616ad60b88@redhat.com>
Message-ID: <6b56fd96-fee5-d105-5261-2e7274b4aa15@arm.com>
Date: Wed, 6 Sep 2017 12:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <f9b02ce1-057f-df4f-90d7-52616ad60b88@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
To: Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Eric,

On 23/08/17 14:55, Auger Eric wrote:
> Please find some comments/questions below:

Thanks a lot for this. Sorry for the delay, I was on holiday and it took
me a while to sort out the details.

> 2.6.7:1
> I do not understand the footnode #6 sentence: 'Without a specific
> definition of the ACK requirements for a given property type, it simply
> means that the driver read all fields of that property."

That doesn't serve any purpose, I'll remove the footnote.

> 2.6.7:2
> what if the driver has not provided a big enough buffer and the device
> cannot report all supported properties?

Good point, how about adding the following to 2.6.7.2 - Device
Requirements: PROBE Request

    If the properties array is smaller than \field{probe_size}, then the
device SHOULD NOT write any property and SHOULD set the request
\field{status} to VIRTIO_IOMMU_S_INVAL.

> 2.6.8.2:
> Couldn't we use the same terminology as iommu_resv_type in iommu.h?
> the negative form is not the easiest to understand for me.
> Why F_MSI?

It also needs to be understandable by someone not familiar with the Linux
APIs. It's not entirely obvious to me what the iommu.h regions are without
looking at the implementation, maybe using names from the device point of
view is more clear. I don't mind simplifying though, as I don't see a
reason for the driver to know about BYPASS regions other than
HW MSIs.

How about I remove ABORT and BYPASS, make the only subtype RESV_MEM_T_MSI
(1)? We'd use subtype 0 as "don't care, just don't map this". Can call it
RESV_MEM_T_RESERVED. Flags won't be used for these subtypes.

Another subtype will be RESV_MEM_T_IDENTITY (see my reply to Kevin).
IDENTITY regions must be identity-mapped by the guest and, as I understand
it, are virtual addresses used for DMA by firmware. The flags field will
then contain read/write protection flags.

> 2.6.8.2.1
> Multiple overlapping RESV_MEM properties are merged together. Device
> requirement? if same types I assume?

Combination rules apply to device and driver. When the driver puts
multiple endpoints in the same domain, combination rules apply. They will
become important once the guest attempts to do things like combining
endpoints with different PASID capabilities in the same domain. I'm
considering these endpoints to be behind different physical IOMMUs.

For reserved regions, we specify what the driver should do and what the
device should enforce with regard to mapping IOVAs of overlapping regions.
For example, if a device has some virtual address RESV_T_MSI and an other
device has the same virtual address RESV_T_IDENTITY, what should the
driver do?

I think it should apply the RESV_T_IDENTITY. RESV_T_MSI is just a special
case of RESV_T_RESERVED, it's a hint for the IRQ subsystem and doesn't
have a meaning within a domain. From DMA mappings point of view, it is
effectively the same as RESV_T_RESERVED. When merging RESV_T_RESERVED and
RESV_T_IDENTITY, we should make it RESV_T_IDENTITY. Because it is required
for one endpoint to work (the one with IDENTITY) and is not accessed by
the other (the driver must not allocate this IOVA range for DMA).

More generally, I'd like to add the following combination table to the
spec, that shows the resulting reserved region type after merging regions
from two endpoints. N: no reserved region, R: RESV_T_RESERVED, M:
RESV_T_MSI, I: RESV_T_IDENTITY. It is symmetric so I didn't fill the
bottom half.

      | N | R | M | I
    ------------------
    N | N | R | M | ?
    ------------------
    R |   | R | R | I
    ------------------
    M |   |   | M | I
    ------------------
    I |   |   |   | I

The 'I' column is problematic. If one endpoint has an IDENTITY region and
the other doesn't have anything at that virtual address, then making that
region an identity mapping will result in the second endpoint being able
to access firmware memory. If using nested translation, stage-2 can help
us here. But in general we should allow the device to reject an attach
that would result in a N+I combination if the host considers it too dodgy.
I think the other combinations are safe enough.

> what if the device is a physical assigned device. does the device report
> the host doorbell or the guest doorbell, may be worth to clarify.

Indeed. For a physical assigned device it is the guest doorbell as it
corresponds to the virtual ITS or APIC (though with the APIC it's the same
region).

> 3.1.1 last paragraph
> you talk about device ID but this is a terminology only known by ARM I
> think. Actually it is introduced later in 3.1.2.

Indeed, I'll move the explanation up.

> 3.1.2
> About ACPI integration. Isn't IORT ARM specific?

IORT is currently edited by ARM, as is virtio-iommu. Their contents are
not ARM specific however, they describe software interfaces that solve
mostly generic problems, and aim to be open.

IORT describes the relation between endpoints and their translation
agents. This problem has already been solved by IVRS, DMAR and IORT. From
a technical point of view the latter is more flexible and can host a new
translation agent. It should be relatively easy to use for virtio-iommu in
the kernel, and therefore I don't think we should introduce a fourth type
of table just for virtio-iommu.

> Will other architectures use that table?

Yes, in particular the IORT node would be used on virtual x86 platforms.
On ARM platforms, Linux guests use existing device-tree bindings.
Operating systems that don't implement DT could use IORT as well.

> In IORT we also have Named Component node
> which look pretty the same. Could you elaborate of the difference?

It's the same mechanism, except that the named component node is supposed
to be a leaf in the topology, not a translation agent. Using the same node
type could make it difficult for the driver to understand the table. But
see below.

> Device Object name: isn't it the path to the LNR0005 in the namespace?

It is. However, I wrote the example table to give a rough idea, but didn't
investigate the feasibility. I now think it would be easier to not present
the virtio-iommu as a LNRO0005 to the guest, but solely as the IORT node.
Instead of a namespace path, the node would directly describe the _CRS
content, which should be enough for the kernel to instantiate the device.

I'll prototype something to understand the problem better and find which
is easier to do. I'm busy preparing for conferences, so it might be two or
three weeks.


Unrelated remarks:

* When renaming "devices" to "endpoints" in v0.3 (to avoid confusion wrt
"The device", which is virtio-iommu dev), I didn't update the
attach/detach/probe requests, they still have 'device' fields. Since I'm
already butchering the API by renaming address_space to domain, should I
also rename 'device' to 'endpoint' in the structure? It doesn't matter as
much, since the difference here is mostly stylistic. But I think I will
get it out of the way for v0.5, to make things more clear overall.

* Regarding my question in v0.4 about adding a 'size' field to all
requests. I don't think we should do that. The problem was for parsing
interleaved RO/WO/RO buffers, but we might never hit the problem if we
design virtio-iommu properly. Framing should be left to the transport
protocol and it'd be mostly redundant in virtio-iommu requests.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

