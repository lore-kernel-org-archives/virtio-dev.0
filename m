Return-Path: virtio-dev-return-3788-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 468D91CB8078
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 09:19:13 -0700 (PDT)
Date: Tue, 10 Apr 2018 17:18:53 +0100
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <235fd63b-ff33-9907-3516-38e9ef3ba007@arm.com>
References: <20180206181106.21815-1-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191085A76@SHSMSX101.ccr.corp.intel.com>
 <3575fbb8-36a9-ef38-8234-6adf6a573b3e@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19108DBDD@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19108DBDD@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.6
To: "Tian, Kevin" <kevin.tian@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22/03/18 09:44, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Wednesday, March 21, 2018 9:14 PM
>>
>> Hi Kevin,
>>
>> Thanks for the comments
>>
>> On 19/03/18 10:03, Tian, Kevin wrote:
>>> BYPASS feature bit is not covered in "2.3.1/2.3.2/2.3.3"". Is it
>>> intended?
>>
>> In my opinion BYPASS is a bit different from the other features: while the
>> others are needed for correctness, this one is optional and even if the
>> guest supports BYPASS, it should be allowed not to accept it. For security
>> reasons it may not want to let endpoints access the whole guest-physical
>> address space.
> 
> ok, possibly because I'm not familiar with virtio spec convention.
> My original feeling is that each feature bit will have a behavior
> description regarding to whether device reports and whether 
> driver accepts. If no need to cover optional feature, then it's fine
> to me. :-)

I think the virtio spec allows the reader to choose how to implement any
behavior that isn't explicitly described. Whenever a SHOULD or MUST
isn't stated in a requirement section, the spec implies "feature X MAY
be enabled if offered".

Looking at the virtio-net specification, optional features such as
VIRTIO_NET_F_VLAN aren't mentioned in driver requirements. On the other
hand, features that the device needs in order to function properly are
explicitly stated, for example VIRTIO_NET_F_MAC.

>> [...]
>>> Then comes a question for VIRTIO_IOMMU_RESV_MEM_T_MSI.
>>> I know there were quite some discussion around this flag before,
>>> but my mental picture now still is a bit difficult to understand its
>>> usage based on examples in implementation notes:
>>>
>>> 	- for x86, you describe it as indicating MSI bypass for
>>> oxfeexxxxx. However guest doesn't need to know this fact. Only
>>> requirement is to treat it as reserved range (as on bare metal)
>>> then T_RESERVED is sufficient for this purpose>
>>> 	- for ARM, either let guest or let host to choose a virtual
>>> address for mapping to MSI doorbell. the former doesn't require
>>> a reserved range. for the latter also T_RESERVED is enough as
>>> the example in hardware device assignment section.
>>
>> It might be nicer to have the host decide it, but when the physical IOMMU
>> is ARM SMMU, nesting translation complicates things, because the guest
>> *has* to create a mapping:
> 
> confirm one thing first. v0.6 doesn't support binding to guest IOVA
> page table yet. So based on current map/unmap interface, there is 
> no such complicity right? stage-1 is just a shadowed translation (IOVA
> ->HPA) to guest side (IOVA->GPA) with nesting disabled. In that case
> the default behavior is host-reserved style.

Yes, with v0.6 the host chooses whether to translate or bypass the MSIs.

> Then comes nested scenario:
> 
>>
>> * The guest is in charge of stage-1. It creates IOVA->GPA mapping for the
>>   MSI doorbell. The GPA is mapped to the physical MSI doorbell at
>>   stage-2 by the host.
> 
> Is it a must that above GPA is mapped to physical MSI doorbell?
> 
> Ideally:
> 
> 1) Host reserves some IOVA range for mapping MSI doorbell
> 2) the range is reported to user space
> 3) Qemu reported the range as reserved on endpoints, marked
> as T_IDENTITY (a new type to be introduced), meaning guest
> needs setup identity mapping in stage-1

I think it works, and is saner than my idea. I had one concern (thought
I had more but can't find any in my notes; they might resurface when
prototyping): the MSI doorbell has to be mapped with device attributes
(MMIO) to ensure proper interrupt delivery. I think it's fine because
the host maps the doorbell with the right attributes at stage-2, which
will take precedence over what the guest uses for stage-1 according to
the Arm architecture.

So I don't think T_IDENTITY requires arch-specific attributes for now
but there should definitely be space for extension. I also noticed that
Intel and AMD drivers in Linux don't add any special attribute or
protection to identity mappings (RESV_DIRECT in Linux), apart from
READ/WRITE.

For reference the previous discussion about T_IDENTITY is here:
https://www.spinics.net/lists/kvm/msg155240.html

One problem with my idea was that if the device is behind multiple IRQ
chips, the host cannot know which IRQ chip the IOVA corresponds to, when
reading the MSI-X tables. Then again I don't know why multiple IRQ chips
per device would be desirable, but it's allowed.

> 4) Then device should be able to ring physical MSI doorbell
> 5) I'm not sure whether guest still needs to allocate its own
> IOVA and mapping to vGIC doorbell in such case...

I don't think it matters, because the host MSI infrastructure is
decoupled from the guest's. The host programs the physical MSI-X tables
and only needs the guest to create a stage-1 mappings for those, which
is done with T_IDENTITY. The guest doesn't know what the T_IDENTITY
mapping is for.

Then QEMU can choose whether to map or bypass the vGIC MSI doorbell.
With MSI bypass, guest writes a GPA into the virtual MSI-X table,
and QEMU sets up the IRQ routing.

With mapped MSI
- The guest creates a dangling stage-1 mapping for the vGIC doorbell.
  The vGIC doorbell isn't mapped at stage-2, so accessing it from the
  IOVA would fault. It doesn't matter because the host programs a valid
  value into the physical MSI-X table.
- The guest writes an IOVA into the virtual MSI-X table. The host can't
  know which doorbell it corresponds to, because it doesn't walk pIOMMU
  page tables. It has to guess.

So I advise to use bypass. Mapped MSI prevents from having multiple IRQ
chips for one device. Although we probably don't care about this, we
should aim to avoid any guessing in the host.


>> [...]
>> Another way of choosing would be with #ifdef CONFIG_ARM64,
>> CONFIG_X86 etc,
>> but I find it nasty, and I personally prefer using MSI bypass for ARM when
>> possible.
> 
> however from current v0.6 examples, BYPASS is only listed for x86
> case. ARM usage is the missing piece making me confused. 

Are you referring to "3.3 - Hardware device assignment" or "3.2 Message
Signaled Interrupts"?

3.2.2 gives "ARM-based platforms" as an example for MSI address
translation because all physical Arm platforms (except one that has to
work around an erratum) use translated MSIs, and I don't think others do
this. Bypass isn't possible because the GIC interface can be anywhere in
the physical address space, and therefore the PCI RC or the SMMU cannot
distinguish MSIs from other memory accesses.

The virtual platform is a bit different, in that it doesn't need to
perform DMA writes for MSIs. Instead it can create eventfd routes
beforehand, maybe making it easier to support bypass. That is for vhost
and vfio, but I think for userspace devices QEMU performs a normal DMA
write that goes through the IOMMU followed by the GIC.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

