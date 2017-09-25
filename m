Return-Path: virtio-dev-return-2566-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4093458182C4
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2017 06:28:06 -0700 (PDT)
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <5be484ff-6a1a-6c9b-947c-f64ea23f58cc@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D941E3@SHSMSX101.ccr.corp.intel.com>
 <013a2fdd-86f7-a7ee-7e71-11bbb6261f33@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190DDCF8D@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <68b68f4d-360c-9849-662f-61db6919c7db@arm.com>
Date: Mon, 25 Sep 2017 14:32:15 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190DDCF8D@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] RE: [RFC] virtio-iommu version 0.4
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/09/17 07:27, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Wednesday, September 6, 2017 7:55 PM
>>
>> Hi Kevin,
>>
>> On 28/08/17 08:39, Tian, Kevin wrote:
>>> Here comes some comments:
>>>
>>> 1.1 Motivation
>>>
>>> You describe I/O page faults handling as future work. Seems you
>> considered
>>> only recoverable fault (since "aka. PCI PRI" being used). What about other
>>> unrecoverable faults e.g. what to do if a virtual DMA request doesn't find
>>> a valid mapping? Even when there is no PRI support, we need some basic
>>> form of fault reporting mechanism to indicate such errors to guest.
>>
>> I am considering recoverable faults as the end goal, but reporting
>> unrecoverable faults should use the same queue, with slightly different
>> fields and no need for the driver to reply to the device.
> 
> what about adding a placeholder for now? Though same mechanism
> can be reused, it's an essential part to make virtio-iommu architecture
> complete even before talking support for recoverable faults. :-)

I'll see if I can come up with something simple for v0.5, but it seems
like a big chunk of work. I don't really know what to report to the guest
at the moment. I don't want to report vendor-specific details about the
fault, but it should still be useful content, to let the guest decide
whether they need to reset/kill the device or just print something

[...]
>> Yes I think adding MEM_T_IDENTITY will be necessary. I can see they are
>> used for both iGPU and USB controllers on my x86 machines. Do you know
>> more precisely what they are used for by the firmware?
> 
> VTd spec has a clear description:
> 
> 3.14 Handling Requests to Reserved System Memory
> Reserved system memory regions are typically allocated by BIOS at boot 
> time and reported to OS as reserved address ranges in the system memory 
> map. Requests-without-PASID to these reserved regions may either occur 
> as a result of operations performed by the system software driver (for 
> example in the case of DMA from unified memory access (UMA) graphics 
> controllers to graphics reserved memory), or may be initiated by non 
> system software (for example in case of DMA performed by a USB 
> controller under BIOS SMM control for legacy keyboard emulation). 
> For proper functioning of these legacy reserved memory usages, when 
> system software enables DMA remapping, the second-level translation 
> structures for the respective devices are expected to be set up to provide
> identity mapping for the specified reserved memory regions with read 
> and write permissions.
> 
> (one specific example for GPU happens in legacy VGA usage in early
> boot time before actual graphics driver is loaded)

Thanks for the explanation. So it is only legacy, and enabling nested mode
would be forbidden for a device with Reserved System Memory regions? I'm
wondering if virtio-iommu RESV regions will be extended to affect a
specific PASIDs (or all requests-with-PASID) in the future.
>> It's not necessary with the base virtio-iommu device though (v0.4),
>> because the device can create the identity mappings itself and report them
>> to the guest as MEM_T_BYPASS. However, when we start handing page
> 
> when you say "the device can create ...", I think you really meant
> "host iommu driver can create identity mapping for assigned device",
> correct?
> 
> Then yes, I think above works.

Yes it can be the host IOMMU driver, or simply Qemu sending VFIO ioctls to
create those identity mappings (they are reported in sysfs reserved_regions).

>> table
>> control over to the guest, the host won't be in control of IOVA->GPA
>> mappings and will need to gracefully ask the guest to do it.
>>
>> I'm not aware of any firmware description resembling Intel RMRR or AMD
>> IVMD on ARM platforms. I do think ARM platforms could need
>> MEM_T_IDENTITY
>> for requesting the guest to map MSI windows when page-table handover is
>> in
>> use (MSI addresses are translated by the physical SMMU, so a IOVA->GPA
>> mapping must be installed by the guest). But since a vSMMU would need a
>> solution as well, I think I'll try to implement something more generic.
> 
> curious do you need identity mapping full IOVA->GPA->HPA translation, 
> or just in GPA->HPA stage sufficient for above MSI scenario?

It has to be IOVA->GPA->HPA. So it'll be a bit complicated to implement
for us, I think we're going to need a VFIO ioctl to tell the host what
IOVA the guest allocated for its MSI, but it's not ideal.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

