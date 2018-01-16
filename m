Return-Path: virtio-dev-return-2971-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BA3F8581911F
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Jan 2018 09:44:27 -0800 (PST)
Date: Tue, 16 Jan 2018 17:46:40 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <5dbd05b0-aeb2-dcd5-f134-692957db0b39@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
 <20171117185211.32593-3-jean-philippe.brucker@arm.com>
 <d4640ecc-8029-413b-1485-a6062c3b8ece@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4640ecc-8029-413b-1485-a6062c3b8ece@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH v2 2/5] iommu/virtio-iommu: Add probe request
To: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16/01/18 09:25, Auger Eric wrote:
[...]
>> +static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>> +			       struct virtio_iommu_probe_resv_mem *mem,
>> +			       size_t len)
>> +{
>> +	struct iommu_resv_region *region = NULL;
>> +	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>> +
>> +	u64 addr = le64_to_cpu(mem->addr);
>> +	u64 size = le64_to_cpu(mem->size);
>> +
>> +	if (len < sizeof(*mem))
>> +		return -EINVAL;
>> +
>> +	switch (mem->subtype) {
>> +	case VIRTIO_IOMMU_RESV_MEM_T_MSI:
>> +		region = iommu_alloc_resv_region(addr, size, prot,
>> +						 IOMMU_RESV_MSI);
>> +		break;
>> +	case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
>> +	default:
>> +		region = iommu_alloc_resv_region(addr, size, 0,
>> +						 IOMMU_RESV_RESERVED);
>> +		break;
>> +	}
>> +
>> +	list_add(&vdev->resv_regions, &region->list);
>> +
>> +	if (mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
>> +	    mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
>> +		/* Please update your driver. */
>> +		pr_warn("unknown resv mem subtype 0x%x\n", mem->subtype);
>> +		return -EINVAL;
>> +	}
> why not adding this in the switch default case and do not call list_add
> in case the subtype region is not recognized?

Even if the subtype isn't recognized, I think the range should still be
reserved, so that the guest kernel doesn't map it and break something.
That's why I put the following in the spec, 2.6.8.2.1 Driver
Requirements: Property RESV_MEM:

"""
The driver SHOULD treat any subtype it doesn’t recognize as if it was
VIRTIO_IOMMU_RESV_MEM_T_RESERVED.
"""

>> +
>> +	return 0;
>> +}
>> +
>> +static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>> +{
>> +	int ret;
>> +	u16 type, len;
>> +	size_t cur = 0;
>> +	struct virtio_iommu_req_probe *probe;
>> +	struct virtio_iommu_probe_property *prop;
>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +	struct viommu_endpoint *vdev = fwspec->iommu_priv;
>> +
>> +	if (!fwspec->num_ids)
>> +		/* Trouble ahead. */
>> +		return -EINVAL;
>> +
>> +	probe = kzalloc(sizeof(*probe) + viommu->probe_size +
>> +			sizeof(struct virtio_iommu_req_tail), GFP_KERNEL);
>> +	if (!probe)
>> +		return -ENOMEM;
>> +
>> +	probe->head.type = VIRTIO_IOMMU_T_PROBE;
>> +	/*
>> +	 * For now, assume that properties of an endpoint that outputs multiple
>> +	 * IDs are consistent. Only probe the first one.
>> +	 */
>> +	probe->endpoint = cpu_to_le32(fwspec->ids[0]);
>> +
>> +	ret = viommu_send_req_sync(viommu, probe);
>> +	if (ret) {
> goto out?

Ok

[...]
>> +
>> +	iommu_dma_get_resv_regions(dev, head);
> this change may belong to the 1st patch.

Indeed

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

