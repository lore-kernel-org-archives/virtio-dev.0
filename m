Return-Path: virtio-dev-return-2462-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E22121CB807B
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2017 02:36:35 -0700 (PDT)
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D7173C@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1770ca04-0deb-a3d4-c63e-82054e8a584c@arm.com>
Date: Mon, 14 Aug 2017 10:38:51 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D7173C@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.4
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 14/08/17 09:27, Tian, Kevin wrote:
>> * First, since the IOMMU is paravirtualized, the device can expose some
>>   properties of the physical topology to the guest, and let it allocate
>>   resources more efficiently. For example, when the virtio-iommu manages
>>   both physical and emulated endpoints, with different underlying IOMMUs,
>>   we now have a way to describe multiple page and block granularities,
>>   instead of forcing the guest to use the most restricted one for all
>>   endpoints. This will most likely be in v0.5.
> 
> emulated IOMMU has similar requirement, e.g. available PASID bits,
> address widths, etc. which may break guest usage if not aligned to
> physical limitation. Suppose we can introduce a general interface
> through VFIO for all vIOMMU incarnations. 

A nice location for this kind of info would be sysfs, as discussed in the
SVM virtualization thread [1]. Properties of an IOMMU could be described
in /sys/class/iommu/<dev>. Properties of a PCI device are available in its
PASID/PRI capabilities. For platform devices we'll have to look at DT and
ACPI properties in /sys/firmware.

>> * Then on top of that, a major improvement will describe hardware
>>   acceleration features available to the guest. There is what I call "Page
>>   Table Handover" (or simply, from the host POV, "Nested"), the ability
>>   for the guest to manipulate its own page tables instead of sending
>>   MAP/UNMAP requests to the host. This, along with IO Page Fault
>>   reporting, will also permit SVM virtualization on different platforms.
> 
> what's your planned cadence for future versions? :-)

Hard to say, it depends on a number of things. I have various other tasks
eating up my bandwidth at the moment and I may have to considerably rework
this version depending on the feedback it gets. Ideally, I would like to
get the base driver merged and a proposal for hardware acceleration out by
the end of the year, but I obviously can't make any guarantee.

Thanks,
Jean

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg05731.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

