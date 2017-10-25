Return-Path: virtio-dev-return-2629-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 641CF5819147
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Oct 2017 05:04:56 -0700 (PDT)
References: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
 <20171024062704.GA23141@virtx40>
 <b878c366-6e43-aacc-c7f6-cabb3f91211e@arm.com>
 <20171024165859.GA24369@virtx40> <20171025070704.GA10689@virtx40>
 <6e5c3a23-9e00-1936-f80c-085faf42c420@arm.com>
 <20171025110548.GA20548@virtx40>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b35e1825-a5c2-e8b3-081c-2f23ac2d627f@arm.com>
Date: Wed, 25 Oct 2017 13:05:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171025110548.GA20548@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.5
To: Linu Cherian <linu.cherian@cavium.com>
Cc: Linu Cherian <linuc.decode@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "sunil.goutham@cavium.com" <sunil.goutham@cavium.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 25/10/17 12:05, Linu Cherian wrote:
>>> Also does this solution intend to cover the page table sharing of non SVM 
>>> cases. For example, if we need to share the IOMMU page table for 
>>> a device used in guest kernel, so that map/unmap gets directly handled by the guest
>>> and only TLB invalidates happens through a virtio-iommu channel.
>>
>> Yes for non-SVM in SMMuv3, you still have a context table but with a
>> single descriptor, so the interface stays the same. 
> 
> So for non SVM case, 
> guest virtio-iommu driver will program the context descriptor such a way that,
> ASID is not in shared set(ASET = 1b) and hence Physical IOMMU TLB invalidates would get triggered 
> from software for every viommu_unmap(in guest kernel) through Qemu(using vfio ioctls) ? 

That's right. viommu_unmap will send an INVALIDATE request on the virtio
request queue, forwarded to the driver via a VFIO ioctl.

> And for SVM case, ASID would be in shared set and explicit TLB invalidates 
> are not required from software ?

Yes, although that's only true for integrated devices (non-PCI). On PCI,
devices will have an ATC (a device IOTLB), in which case we still have to
send an invalidation request through virtio and then VFIO, so that the
SMMU driver sends an CMD_ATC_INV.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

