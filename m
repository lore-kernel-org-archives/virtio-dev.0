Return-Path: virtio-dev-return-2511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 208925819215
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2017 04:51:27 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <5be484ff-6a1a-6c9b-947c-f64ea23f58cc@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D941E3@SHSMSX101.ccr.corp.intel.com>
Message-ID: <013a2fdd-86f7-a7ee-7e71-11bbb6261f33@arm.com>
Date: Wed, 6 Sep 2017 12:54:46 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D941E3@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.4
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Kevin,

On 28/08/17 08:39, Tian, Kevin wrote:
> Here comes some comments:
> 
> 1.1 Motivation
> 
> You describe I/O page faults handling as future work. Seems you considered
> only recoverable fault (since "aka. PCI PRI" being used). What about other
> unrecoverable faults e.g. what to do if a virtual DMA request doesn't find 
> a valid mapping? Even when there is no PRI support, we need some basic
> form of fault reporting mechanism to indicate such errors to guest.

I am considering recoverable faults as the end goal, but reporting
unrecoverable faults should use the same queue, with slightly different
fields and no need for the driver to reply to the device.

> 2.6.8.2 Property RESV_MEM
> 
> I'm not immediately clear when VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT
> should be explicitly reported. Is there any real example on bare metal IOMMU?
> usually reserved memory is reported to CPU through other method (e.g. e820
> on x86 platform). Of course MSI is a special case which is covered by BYPASS 
> and MSI flag... If yes, maybe you can also include an example in implementation 
> notes.

The RESV_MEM regions only describes IOVA space for the moment, not
guest-physical, so I guess it provides different information than e820.

I think a useful example is the PCI bridge windows reported by the Linux
host to userspace using RESV_RESERVED regions (see
iommu_dma_get_resv_regions). If I understand correctly, they represent DMA
addresses that shouldn't be accessed by endpoints because they won't reach
the IOMMU. These are specific to the physical topology: a device will have
different reserved regions depending on the PCI slot it occupies.

When handled properly, PCI bridge windows quickly become a nuisance. With
kvmtool we observed that carving out their addresses globally removes a
lot of useful GPA space from the guest. Without a virtual IOMMU we can
either ignore them and hope everything will be fine, or remove all
reserved regions from the GPA space (which currently means editing by hand
the static guest-physical map...)

That's where RESV_MEM_T_ABORT comes handy with virtio-iommu. It describes
reserved IOVAs for a specific endpoint, and therefore removes the need to
carve the window out of the whole guest.

> Another thing I want to ask your opinion, about whether there is value of
> adding another subtype (MEM_T_IDENTITY), asking for identity mapping
> in the address space. It's similar to Reserved Memory Region Reporting
> (RMRR) structure defined in VT-d, to indicate BIOS allocated reserved
> memory ranges which may be DMA target and has to be identity mapped
> when DMA remapping is enabled. I'm not sure whether ARM has similar
> capability and whether there might be a general usage beyond VT-d. For
> now the only usage in my mind is to assign a device with RMRR associated
> on VT-d (Intel GPU, or some USB controllers) where the RMRR info needs
> propagated to the guest (since identity mapping also means reservation
> of virtual address space).

Yes I think adding MEM_T_IDENTITY will be necessary. I can see they are
used for both iGPU and USB controllers on my x86 machines. Do you know
more precisely what they are used for by the firmware?

It's not necessary with the base virtio-iommu device though (v0.4),
because the device can create the identity mappings itself and report them
to the guest as MEM_T_BYPASS. However, when we start handing page table
control over to the guest, the host won't be in control of IOVA->GPA
mappings and will need to gracefully ask the guest to do it.

I'm not aware of any firmware description resembling Intel RMRR or AMD
IVMD on ARM platforms. I do think ARM platforms could need MEM_T_IDENTITY
for requesting the guest to map MSI windows when page-table handover is in
use (MSI addresses are translated by the physical SMMU, so a IOVA->GPA
mapping must be installed by the guest). But since a vSMMU would need a
solution as well, I think I'll try to implement something more generic.

> 2.6.8.2.3 Device Requirements: Property RESV_MEM
> 
> --citation start--
> If an endpoint is attached to an address space, the device SHOULD leave 
> any access targeting one of its VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS 
> regions pass through untranslated. In other words, the device SHOULD 
> handle such a region as if it was identity-mapped (virtual address equal to
> physical address). If the endpoint is not attached to any address space, 
> then the device MAY abort the transaction.
> --citation end
> 
> I have a question for the last sentence. From definition of BYPASS, it's
> orthogonal to whether there is an address space attached, then should
> we still allow "May abort" behavior? 

The behavior is left as an implementation choice, and I'm not sure it's
worth enforcing in the architecture. If the endpoint isn't attached to any
domain then (unless VIRTIO_IOMMU_F_BYPASS is negotiated), it isn't
necessarily able to do DMA at all. The virtio-iommu device may setup DMA
mastering lazily, in which case any DMA transaction would abort, or have
setup DMA already, in which case the endpoint can access MEM_T_BYPASS regions.

Thanks!
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

