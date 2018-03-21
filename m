Return-Path: virtio-dev-return-3623-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 21CBB5818F5E
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Mar 2018 06:10:23 -0700 (PDT)
References: <20180206181106.21815-1-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191085A76@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3575fbb8-36a9-ef38-8234-6adf6a573b3e@arm.com>
Date: Wed, 21 Mar 2018 13:13:30 +0000
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191085A76@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.6
To: "Tian, Kevin" <kevin.tian@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Kevin,

Thanks for the comments

On 19/03/18 10:03, Tian, Kevin wrote:
> BYPASS feature bit is not covered in "2.3.1/2.3.2/2.3.3"". Is it 
> intended?

In my opinion BYPASS is a bit different from the other features: while the
others are needed for correctness, this one is optional and even if the
guest supports BYPASS, it should be allowed not to accept it. For security
reasons it may not want to let endpoints access the whole guest-physical
address space.

> --2.6.2 Device Requirements: Device operations--
> 
> "If the VIRTIO_IOMMU_F_INPUT_RANGE feature is oﬀered, 
> the device MUST truncate the range described by virt_start 
> and virt_end in requests to ft in the range described by 
> input_range."
> 
> "If the VIRTIO_IOMMU_F_DOMAIN_BITS is oﬀered, the device 
> MUST ignore bits above domain_bits in field domain of requests."
> 
> shouldn't device return error upon above situation instead
> of continuing operation with modified value?

The intent was to allow device and driver to pass metadata in the top bits
of pointers and domain IDs, perhaps for a future extension or for
debugging. I'm not convinced it's useful anymore (and do wonder what my
initial reasoning was...) Such extension would be determined by a new
feature bit and the device would know that the fields contain additional
info, if the driver accepted that feature.

> --2.6.4 DETACH request--
> 
> " Detach an endpoint from its domain. When this request 
> completes, the endpoint cannot access any mapping from that 
> domain anymore "
> 
> Does it make sense to mention BYPASS situation upon this request?

Sure, I'll add something to clarify that situation

> --2.6.8.2 Property RESV_MEM --
> 
> "VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0) Accesses to 
> virtual addresses in this region are not translated by the device. 
> They may either be aborted by the device (or the underlying 
> IOMMU), bypass it, or never even reach it"
> 
> in 3.3 hardware device assignment you described an example 
> that a reserved range is stolen by host to map the MSI 
> doorbell... such map behavior is not described above.

Right, we can say that accesses to the region may be used for host translation

> Then comes a question for VIRTIO_IOMMU_RESV_MEM_T_MSI.
> I know there were quite some discussion around this flag before,
> but my mental picture now still is a bit difficult to understand its
> usage based on examples in implementation notes:
> 
> 	- for x86, you describe it as indicating MSI bypass for
> oxfeexxxxx. However guest doesn't need to know this fact. Only
> requirement is to treat it as reserved range (as on bare metal)
> then T_RESERVED is sufficient for this purpose>
> 	- for ARM, either let guest or let host to choose a virtual
> address for mapping to MSI doorbell. the former doesn't require
> a reserved range. for the latter also T_RESERVED is enough as
> the example in hardware device assignment section.

It might be nicer to have the host decide it, but when the physical IOMMU
is ARM SMMU, nesting translation complicates things, because the guest
*has* to create a mapping:

* The guest is in charge of stage-1. It creates IOVA->GPA mapping for the
  MSI doorbell. The GPA is mapped to the physical MSI doorbell at
  stage-2 by the host.

* when it writes that IOVA in the virtual MSI-X tables, the host updates
  the physical MSI-X tables using an ioctl (it can't map the physical
  tables into the guest, because MSI-X vector data also contain physical
  device info that shouldn't be known by the guest.)

So we need support for software-mapped MSIs in the guest anyway. In Linux
the virtio-iommu driver can use existing plumbing for that, no change
needed in the guest.

> Then what's the real point of differentiating MSI bypass from
> normal reserved range? Is there other example where guest
> may use such info to do special thing?

The presence of an MSI bypass regions allows the driver and the DMA layer
(in Linux iommu_dma_map_msi_msg) to know whether it needs to create a
mapping or if it's bypassed. When writing the entry into the MSI-X table,
if the address in the MSI vector already corresponds to an MSI bypass
region, then there is no need to create a mapping. Making the bypass MSI
region a normal RESV range hides that information.

Another way of choosing would be with #ifdef CONFIG_ARM64, CONFIG_X86 etc,
but I find it nasty, and I personally prefer using MSI bypass for ARM when
possible.

> -- 3.2 Message Signaled Interrupts --
> 
> " Section 3.2.2 describes the added complexity (from the host 
> point of view) of translating the IRQ chip doorbell "
> 
> however later 3.2.2 only says one sentence about host
> complexity - " However, this mode of operations may add 
> significant complexity in the host implementation". If you plan
> to elaborate that part in the future, please add a note. :-)

Oh right, I don't really want to elaborate, I'll try to reword 3.2. The
kvmtool patches have support for both MSI bypass and translation
(selectable with a cmdline flag), which I think is good enough. I'd rather
read a code example than some clumsy prose describing it.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

