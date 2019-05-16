Return-Path: virtio-comment-return-729-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20190430135648.38369-1-jean-philippe.brucker@arm.com>
 <20190503102720-mutt-send-email-mst@kernel.org>
 <14cb84e1-ceb1-e489-f29a-8d77d542561a@arm.com>
 <20190510122220-mutt-send-email-mst@kernel.org>
 <18182871-5a30-9ef4-e6bc-73f5ad32b7e8@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19CA3166E@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19CA317AC@SHSMSX104.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <89129122-c8e5-17c8-8590-2a6a9f9bf09b@arm.com>
Date: Thu, 16 May 2019 12:46:43 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19CA317AC@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3] Add virtio-iommu device specification
To: "Tian, Kevin" <kevin.tian@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "joro@8bytes.org" <joro@8bytes.org>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "bauerman@linux.ibm.com" <bauerman@linux.ibm.com>, "Alex Williamson (alex.williamson@redhat.com)" <alex.williamson@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 15/05/2019 06:30, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Wednesday, May 15, 2019 1:08 PM
>> To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>; Michael S.
>> Tsirkin <mst@redhat.com>
>>>
>>>
>>>>>>> +\begin{description}
>>>>>>> +  \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
>>>>>>> +    Accesses to virtual addresses in this region have undefined
>> behavior.
>>>>>>
>>>>>> undefined?  how can platforms with such a property coexist with
>>> untrusted
>>>>>> devices?
>>>>>
>>>>> It is "undefined" because I can't enumerate all cases (don't know about
>>>>> all of them). This would contain for example the RMRR regions of VT-d
>>>>> (the BIOS reserving some DMA regions for itself), regions allocated for
>>>>> host-managed MSIs on arm platforms, and some PCI bridge windows
>>>>> (although they removed those from the Linux resv regions recently, not
>>>>> certain why). Ideally we wouldn't have any, but some special cases make
>>>>> it necessary.
> 
> +Alex.
> 
> Actually I don't think RMRR is right example here (sorry if it's my input in
> our previous discussion). There was concern on RMRR providing a shared
> memory region between device and platform controller, thus may cause
> isolation issue:
> 	https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf
> 
> So the basic policy for devices with RMRR is, excluding them from device
> assignment, except for Intel GPU and USB. The latter two has well-understood
> behavior on RMRR, thus they can be safely assigned with RMRR ignored
> (i.e. RMRR region can be reused as valid IOVA region).  

Ah I see, seems like a good policy.

> As I commented below, I think it's safe to describe reserved region behavior
> as either succeed with undefined behavior (e.g. in ARM MSI doorbell case, 
> where a spurious interrupt on allocated doorbell for this device is triggered 
> instead of desired DMA access), or cause vIOMMU unrecoverable fault due 
> to invalid mappings. An untrusted device can never use reserved region to 
> escape since physically IOMMU only contains verified mapping to granted
> resource (MSI) or nothing.

Yes, I will add that as a requirement in next version: reserved regions
are okay as long as they don't allow a device to escape isolation.
Finding the right wording without being too vague is a bit tough for
this one.

>>>>>
>>>>> In general having reserved regions is incompatible with untrusted
>>>>> devices, and in some cases incompatible with untrusted guests. But
>>>>> choosing the policy about which devices to present to guest is up to the
>>>>> platform. The host knows what the resv regions are used for, and if they
>>>>> are safe enough. The guest just need to knows what to avoid.
>>>>
>>>> Yes but ... if you trust driver and device then what's the
>>>> point of the iommu?
>>>
>>> Improving memory allocation. The guest can do scatter-gather for large
>>> buffers, instead of allocating big contiguous chunks of guest-physical
>>> addresses. And with device pass-through, any memory used for DMA has to
>>> be pinned (since devices generally don't support page faults). So when
>>> assigning an endpoint to a guest, without a vIOMMU all of the guest
>>> memory has to be pinned upfront. With an IOMMU only the memory that
>> will
>>> actually be used for DMA is pinned.
>>
>> I'd not vote using current vIOMMU just for avoiding pin instead of for
>> isolation purpose... the map/unmap overhead is high except you only
>> talking about static mapping e.g. in guest user space driver (e.g. DPDK)
>> (but then it's actually for isolation purpose between user and kernel).
>>  btw we are working on a lighter-weight approach (aim <5% perf drop
>> for most cases) while allowing host to fully introspect guest DMA activities.
>> Likely we'll introduce a new virtio-iommu capability for this purpose,
>> instead of using current MAP/UNMAP primitives. Stay tuned and we'll
>> send out RFC soon once getting good result. :-)

Sounds great, I'd like to hear more about this. I also have some drafts
for performance improvement and SVA, but haven't found time to progress
on that in a while. For SVA however, introspection seems nearly
impossible (on Arm the host may not even see invalidation commands from
the guest).

Thanks,
Jean

>>
>> And I don't think having reserved regions is incompatible with untrusted
>> devices. Favoring reserved region is a functional requirement so guest
>> driver can operate assigned device in a good shape. Violating reserved
>> region requirement (e.g. map guest memory page to reserved region) just
>> means device access to this page doesn't provide desired behavior, since
>> host will always guarantee safe behavior in physical IOMMU on those
>> regions:
>>
>> - it is either mapped to fixed resource (e.g ARM MSI doorbell)
>> which is associated with this device and thus safe
>> - or map to nothing
>>
>> I don't think architecturally we break any isolation implication on
>> IOMMU here.
>>
>> Thanks
>> Kevin


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

