Return-Path: virtio-dev-return-3822-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C78C85818EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Apr 2018 11:34:16 -0700 (PDT)
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
 <20180214145340.1223-3-jean-philippe.brucker@arm.com>
 <8156517f-74b1-2923-2838-402f09a5c488@arm.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c6ae66ca-ddaf-09f6-cfee-87f4b99a7e8f@arm.com>
Date: Wed, 11 Apr 2018 19:33:59 +0100
MIME-Version: 1.0
In-Reply-To: <8156517f-74b1-2923-2838-402f09a5c488@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 2/4] iommu/virtio: Add probe request
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>
List-ID: <virtio-dev.lists.oasis-open.org>

On 23/03/18 15:00, Robin Murphy wrote:
[...]
>> +	/*
>> +	 * Treat unknown subtype as RESERVED, but urge users to update their
>> +	 * driver.
>> +	 */
>> +	if (mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
>> +	    mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_MSI)
>> +		pr_warn("unknown resv mem subtype 0x%x\n", mem->subtype);
> 
> Might as well avoid the extra comparisons by incorporating this into the 
> switch statement, i.e.:
> 
> 	default:
> 		dev_warn(vdev->viommu_dev->dev, ...);
> 		/* Fallthrough */
> 	case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> 		...
> 
> (dev_warn is generally preferable to pr_warn when feasible)

Alright, that's nicer

[...]
>>   	/*
>>   	 * Last step creates a default domain and attaches to it. Everything
>>   	 * must be ready.
>> @@ -735,7 +849,19 @@ static int viommu_add_device(struct device *dev)
>>   
>>   static void viommu_remove_device(struct device *dev)
>>   {
>> -	kfree(dev->iommu_fwspec->iommu_priv);
>> +	struct viommu_endpoint *vdev;
>> +	struct iommu_resv_region *entry, *next;
>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +
>> +	if (!fwspec || fwspec->ops != &viommu_ops)
>> +		return;
> 
> Oh good :) I guess that was just a patch-splitting issue. The group 
> thing still applies, though.

Ok

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

