Return-Path: virtio-dev-return-2486-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E322B58190D2
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Aug 2017 04:57:46 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
 <20170407191747.26618-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190CADECE@SHSMSX101.ccr.corp.intel.com>
 <34166633-f4d5-21d5-20db-9091243ccd84@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190CB262D@SHSMSX101.ccr.corp.intel.com>
 <a4df3472-449f-297f-2a18-b3a21affadee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D7BAB1@SHSMSX101.ccr.corp.intel.com>
Message-ID: <454095c4-cae5-ad52-a459-5c9e2cce4047@arm.com>
Date: Mon, 21 Aug 2017 13:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D7BAB1@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC 2/3] virtio-iommu: device probing and operations
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 21/08/17 08:59, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Monday, April 24, 2017 11:06 PM
>>>>>>   1. Attach device
>>>>>>   ----------------
>>>>>>
>>>>>> struct virtio_iommu_req_attach {
>>>>>> 	le32	address_space;
>>>>>> 	le32	device;
>>>>>> 	le32	flags/reserved;
>>>>>> };
>>>>>>
>>>>>> Attach a device to an address space. 'address_space' is an identifier
>>>>>> unique to the guest. If the address space doesn't exist in the IOMMU
>>>>>
>>>>> Based on your description this address space ID is per operation right?
>>>>> MAP/UNMAP and page-table sharing should have different ID spaces...
>>>>
>>>> I think it's simpler if we keep a single IOASID space per virtio-iommu
>>>> device, because the maximum number of address spaces (described by
>>>> ioasid_bits) might be a restriction of the pIOMMU. For page-table
>> sharing
>>>> you still need to define which devices will share a page directory using
>>>> ATTACH requests, though that interface is not set in stone.
>>>
>>> got you. yes VM is supposed to consume less IOASIDs than physically
>>> available. It doesn’t hurt to have one IOASID space for both IOVA
>>> map/unmap usages (one IOASID per device) and SVM usages (multiple
>>> IOASIDs per device). The former is digested by software and the latter
>>> will be bound to hardware.
>>>
>>
>> Hmm, I'm using address space indexed by IOASID for "classic" IOMMU, and
>> then contexts indexed by PASID when talking about SVM. So in my mind an
>> address space can have multiple sub-address-spaces (contexts). Number of
>> IOASIDs is a limitation of the pIOMMU, and number of PASIDs is a
>> limitation of the device. Therefore attaching devices to address spaces
>> would update the number of available contexts in that address space. The
>> terminology is not ideal, and I'd be happy to change it for something more
>> clear.
>>
> 
> (sorry to pick up this old thread, as the .tex one is not good for review
> and this thread provides necessary background for IOASID).
> 
> Hi, Jean,
> 
> I'd like to hear more clarification regarding the relationship between 
> IOASID and PASID. When reading back above explanation, it looks
> confusing to me now (though I might get the meaning months ago :/).
> At least Intel VT-d only understands PASID (or you can think IOASID
> =PASID). There is no such layered address space concept. Then for
> map/unmap type request, do you intend to steal some PASIDs for
> that purpose on such architecture (since IOASID is a mandatory field 
> in map/unmap request)?

IOASID is a logical ID, it isn't used by hardware. The address space
concept in virtio-iommu allows to group endpoints together, so that they
have the same address space. I thought it was pretty much the same as
"domains" in VT-d? In any case, it is the same as domains in Linux. An
IOASID provides a handle for communication between virtio-iommu device and
driver, but unlike PASID, the IOASID number doesn't mean anything outside
of virtio-iommu.

I haven't introduced PASIDs in public virtio-iommu documents yet, but the
way I intend it, PASID != IOASID. We will still have a logical address
space identified by IOASID, that can contain multiple contexts identified
by PASID. At the moment, after the ATTACH request, an address space
contains a single anonymous context (NO PASID) that can be managed with
MAP/UNMAP requests. With virtio-iommu v0.4, structures look like the
following. The NO PASID context is implicit.

                    address space      context
    endpoint ----.                                  .- mapping
    endpoint ----+---- IOASID -------- NO PASID ----+- mapping
    endpoint ----'                                  '- mapping

I'd like to add a flag to ATTACH that says "don't create a default
anonymous context, I'll handle contexts myself". Then a new "ADD_TABLE"
request to handle contexts. When creating a context, the guest decides if
it wants to manage it via MAP/UNMAP requests (and a new "context" field),
or instead manage mappings itself by allocating a page directory and use
INVALIDATE requests.

                    address space      context
    endpoint ----.                                  .- mapping
    endpoint ----+---- IOASID ----+--- NO PASID ----+- mapping
    endpoint ----'                |                 '- mapping
                                  +--- PASID 0  ---- pgd
                                  |     ...
                                  '--- PASID N  ---- pgd

In this example the guest chose to still have an anonymous context that
uses MAP/UNMAP, along with a few PASID contexts with their own page tables.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

