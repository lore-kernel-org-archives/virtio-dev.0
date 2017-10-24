Return-Path: virtio-dev-return-2622-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0118F5818E17
	for <virtio-dev@lists.oasis-open.org>; Tue, 24 Oct 2017 01:36:35 -0700 (PDT)
References: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
 <20171024062704.GA23141@virtx40>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b878c366-6e43-aacc-c7f6-cabb3f91211e@arm.com>
Date: Tue, 24 Oct 2017 09:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171024062704.GA23141@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.5
To: Linu Cherian <linuc.decode@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "sunil.goutham@cavium.com" <sunil.goutham@cavium.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Linu,

On 24/10/17 07:27, Linu Cherian wrote:
> Hi Jean,
> 
> On Mon Oct 23, 2017 at 10:32:41AM +0100, Jean-Philippe Brucker wrote:
>> This is version 0.5 of the virtio-iommu specification, the paravirtualized
>> IOMMU. This version addresses feedback from v0.4 and adds an event virtqueue.
>> Please find the specification, LaTeX sources and pdf, at:
>> git://linux-arm.org/virtio-iommu.git viommu/v0.5
>> http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/v0.5/virtio-iommu-v0.5.pdf
>>
>> A detailed changelog since v0.4 follows. You can find the pdf diff at:
>> http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/diffs/virtio-iommu-pdf-diff-v0.4-v0.5.pdf
>>
>> * Add an event virtqueue for the device to report translation faults to
>>   the driver. For the moment only unrecoverable faults are available but
>>   future versions will extend it.
>> * Simplify PROBE request by removing the ack part, and flattening RESV
>>   properties.
>> * Rename "address space" to "domain". The change might seem futile but
>>   allows to introduce PASIDs and other features cleanly in the next
>>   versions. In the same vein, the few remaining "device" occurrences were
>>   replaced by "endpoint", to avoid any confusion with "the device"
>>   referring to the virtio device across the document.
>> * Add implementation notes for RESV_MEM properties.
>> * Update ACPI table definition.
>> * Fix typos and clarify a few things.
>>
>> I will publish the Linux driver for v0.5 shortly. Then for next versions
>> I'll focus on optimizations and adding support for hardware acceleration.
>>
>> Existing implementations are simple and can certainly be optimized, even
>> without architectural changes. But the architecture itself can also be
>> improved in a number of ways. Currently it is designed to work well with
>> VFIO. However, having explicit MAP requests is less efficient* than page
>> tables for emulated and PV endpoints, and the current architecture doesn't
>> address this. Binding page tables is an obvious way to improve throughput
>> in that case, but we can explore cleverer (and possibly simpler) ways to
>> do it.
>>
>> So first we'll work on getting the base device and driver merged, then
>> we'll analyze and compare several ideas for improving performance.
>>
>> Thanks,
>> Jean
>>
>> * I have yet to study this behaviour, and would be interested in any
>> prior art on the subject of analyzing devices DMA patterns (virtio and
>> others)
> 
> 
> From the spec,
> Under future extensions.
> 
> "Page Table Handover, to allow guests to manage their own page tables and share them with the MMU"
> 
> Had few questions on this.
> 
> 1. Did you mean SVM support for vfio-pci devices attached to guest processes here.

Yes, using the VFIO BIND and INVALIDATE ioctls that Intel is working on,
and adding requests in pretty much the same format to virtio-iommu.

> 2. Can you give some hints on how this is going to work , since virtio-iommu guest kernel 
>    driver need to create stage 1 page table as required by hardware which is not the case now. 
>    CMIIW. 

The virtio-iommu device advertises which PASID/page table format is
supported by the host (obtained via sysfs and communicated in the PROBE
request), then the guest binds page tables or PASID tables to a domain and
populates it. Binding page tables alone is easy because we already have
the required drivers in the guest (io-pgtable or arch/* for SVM) and code
in the host to manage PASID tables. But since the PASID table pointer is
translated by stage-2, it would requires a little more work in the host
for obtaining GPA buffers from the guest on demand. In addition the BIND
ioctl is different from the one used by VT-d, so this solution didn't get
much appreciation.

The alternative is to bind PASID tables. It requires to factor the guest
PASID handling code into a library, which is difficult for SMMU. Luckily
I'm still working on adding PASID code for SMMUv3, so extracting it out of
the driver isn't a big overhead. The good thing about this solution is
that it reuses any specification work done for VFIO (and vice versa) and
any host driver change made for vSMMU/VT-d emulations.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

