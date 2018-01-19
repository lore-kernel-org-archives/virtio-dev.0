Return-Path: virtio-dev-return-3001-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 183BB5818F92
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Jan 2018 08:19:22 -0800 (PST)
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
 <20171117185211.32593-3-jean-philippe.brucker@arm.com>
 <5b236aaa-4abb-2cac-1c74-f8137a0c2244@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b9ede9e9-25a6-2848-e152-ffc61d560be8@arm.com>
Date: Fri, 19 Jan 2018 16:21:52 +0000
MIME-Version: 1.0
In-Reply-To: <5b236aaa-4abb-2cac-1c74-f8137a0c2244@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC PATCH v2 2/5] iommu/virtio-iommu: Add probe request
To: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16/01/18 23:26, Auger Eric wrote:
[...]
>> +	switch (mem->subtype) {
>> +	case VIRTIO_IOMMU_RESV_MEM_T_MSI:
>> +		region = iommu_alloc_resv_region(addr, size, prot,
>> +						 IOMMU_RESV_MSI);
> if (!region)
> 	return -ENOMEM;
>> +		break;
>> +	case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
>> +	default:
>> +		region = iommu_alloc_resv_region(addr, size, 0,
>> +						 IOMMU_RESV_RESERVED);
> same.

I'll add them, thanks

> There is another issue related to the exclusion of iovas belonging to
> reserved regions. Typically on x86, when attempting to run
> virtio-blk-pci with iommu I eventually saw the driver using iova
> belonging to the IOAPIC regions to map phys addr and this stalled qemu
> with a drown trace:
> 
> "virtio: bogus descriptor or out of resources"
> 
> those regions need to be excluded from the iova allocator. This was
> resolved by adding
> if (iommu_dma_init_domain(domain,
> 			  vdev->viommu->geometry.aperture_start,
> 			  vdev->viommu->geometry.aperture_end,
> 			  dev))
> in viommu_attach_dev()

The most recent hack for x86 [1] does call iommu_dma_init_domain() in
attach_dev(). Is it buggy?

We probably shouldn't call iommu_dma_init_domain() unconditionally
(outside of CONFIG_X86 that is), since it's normally done by the arch
(arch/arm64/mm/dma-mapping.c)

Thanks,
Jean

[1]
http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=e910e224b58712151dda06df595a53ff07edef63
on branch virtio-iommu/v0.5-x86

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

