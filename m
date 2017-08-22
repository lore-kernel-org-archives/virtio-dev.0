Return-Path: virtio-dev-return-2488-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 927341CB807D
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Aug 2017 07:16:47 -0700 (PDT)
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
 <20170407191747.26618-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190CADECE@SHSMSX101.ccr.corp.intel.com>
 <34166633-f4d5-21d5-20db-9091243ccd84@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190CB262D@SHSMSX101.ccr.corp.intel.com>
 <a4df3472-449f-297f-2a18-b3a21affadee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D7BAB1@SHSMSX101.ccr.corp.intel.com>
 <454095c4-cae5-ad52-a459-5c9e2cce4047@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D7CF52@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <03eabc9f-5db1-0eb9-b91a-c47da9d1a29b@arm.com>
Date: Tue, 22 Aug 2017 15:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D7CF52@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC 2/3] virtio-iommu: device probing and operations
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Auger Eric <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22/08/17 07:24, Tian, Kevin wrote:
>>> (sorry to pick up this old thread, as the .tex one is not good for review
>>> and this thread provides necessary background for IOASID).
>>>
>>> Hi, Jean,
>>>
>>> I'd like to hear more clarification regarding the relationship between
>>> IOASID and PASID. When reading back above explanation, it looks
>>> confusing to me now (though I might get the meaning months ago :/).
>>> At least Intel VT-d only understands PASID (or you can think IOASID
>>> =PASID). There is no such layered address space concept. Then for
>>> map/unmap type request, do you intend to steal some PASIDs for
>>> that purpose on such architecture (since IOASID is a mandatory field
>>> in map/unmap request)?
>>
>> IOASID is a logical ID, it isn't used by hardware. The address space
>> concept in virtio-iommu allows to group endpoints together, so that they
>> have the same address space. I thought it was pretty much the same as
>> "domains" in VT-d? In any case, it is the same as domains in Linux. An
>> IOASID provides a handle for communication between virtio-iommu device
>> and
>> driver, but unlike PASID, the IOASID number doesn't mean anything outside
>> of virtio-iommu.
> 
> Thanks. It's clear to me then.
> 
> btw does it make more sense to use "domain id" instead of "IO address
> space id"? For one, when talking about layered address spaces
> usually parent address space is a superset of all child address spaces
> which doesn't apply to this case, since either anonymous address
> space or PASID-tagged address spaces are completely isolated. Instead> 'domain' is a more inclusive terminology to embrace multiple address
> spaces. For two, 'domain' is better aligned to software terminology (e.g.
> iommu_domain) is easier for people to catch up. :-)

I do agree that the naming isn't great. I didn't use "domain" for various
reasons (it also has a different meanings in ARM) but I keep regretting
it. As there is no virtio-iommu code upstream yet, it is still possible to
change this one.

I find that "address space" was a good fit for the baseline device, but
the name doesn't scale. When introducing PASIDs, the address space moves
one level down in the programming model. It is contexts, anonymous or
PASID-tagged, that should be called address spaces. I was considering
replacing it with "domain", "container", "partition"...

Even though I don't want to use too much Linux terminology (virtio isn't
just Linux), "domain" is better fitted, somewhat neutral, and gets the
point across. A domain has one or more input address spaces and a single
output address space.

When introducing nested translation to virtio-iommu (for the guest to have
virtual machines itself), there will be one or more intermediate address
spaces. Domains will be nested, with the terminology "parent domain" and
"child domain". I only briefly looked at a programming model for this but
I think we can nest virtio-iommus without much hassle.

If there is no objection the next version will use "domain" in place of
"address_space". The change is quite invasive at this point, but I believe
that it will makes things more clear down the road.

>> I haven't introduced PASIDs in public virtio-iommu documents yet, but the
>> way I intend it, PASID != IOASID. We will still have a logical address
>> space identified by IOASID, that can contain multiple contexts identified
>> by PASID. At the moment, after the ATTACH request, an address space
>> contains a single anonymous context (NO PASID) that can be managed with
>> MAP/UNMAP requests. With virtio-iommu v0.4, structures look like the
>> following. The NO PASID context is implicit.
>>
>>                     address space      context
>>     endpoint ----.                                  .- mapping
>>     endpoint ----+---- IOASID -------- NO PASID ----+- mapping
>>     endpoint ----'                                  '- mapping
>>
>> I'd like to add a flag to ATTACH that says "don't create a default
>> anonymous context, I'll handle contexts myself". Then a new "ADD_TABLE"
>> request to handle contexts. When creating a context, the guest decides if
>> it wants to manage it via MAP/UNMAP requests (and a new "context" field),
>> or instead manage mappings itself by allocating a page directory and use
>> INVALIDATE requests.
>>
>>                     address space      context
>>     endpoint ----.                                  .- mapping
>>     endpoint ----+---- IOASID ----+--- NO PASID ----+- mapping
>>     endpoint ----'                |                 '- mapping
>>                                   +--- PASID 0  ---- pgd
>>                                   |     ...
>>                                   '--- PASID N  ---- pgd
>>
>> In this example the guest chose to still have an anonymous context that
>> uses MAP/UNMAP, along with a few PASID contexts with their own page
>> tables.
>>
> 
> Above explanation is a good background. Is it useful to include it
> in current spec? Though SVM support is not planned now, adding
> such background could help build a full story for IOASID concept.

I think introducing this explanation when PASIDs are added to the spec is
good enough. Right now it would look like clutter.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

