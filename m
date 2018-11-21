Return-Path: virtio-dev-return-5004-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <20181121030702.22703-1-mst@redhat.com>
 <13b18a80-6b54-9656-7872-e91eea811599@redhat.com>
 <20181120234232-mutt-send-email-mst@kernel.org>
 <7ac93c87-d51f-fd70-29cd-fbba950919a7@redhat.com>
 <20181121064815-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b3cc5b6-bdb7-1a61-8c54-e2df224a566c@redhat.com>
Date: Wed, 21 Nov 2018 21:44:02 +0800
MIME-Version: 1.0
In-Reply-To: <20181121064815-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] ACCESS_PLATFORM/ACCESS_ORDER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2018/11/21 下午8:10, Michael S. Tsirkin wrote:
> On Wed, Nov 21, 2018 at 03:35:21PM +0800, Jason Wang wrote:
>> On 2018/11/21 下午1:11, Michael S. Tsirkin wrote:
>>>> A question is. Are you suggesting to have VIRTIO_F_ORDER_PLATFORM for each
>>>> hardware implementation?
>>> It's not a simple question. There are implementations such as
>>> VDPA which have a hardware and a software component.
>>> For a hardware only device that is also pluggable into an
>>> arbitrary system, it's true.
>>>
>>>> If not, can a hardware detect the platform by
>>>> itself and advertise this bit automatically?
>>> So a mixed software/hardware device might be able to,
>>> and e.g. fallback to a software implementation
>>> if driver assumes that.
>>>
>>> There's actually some text that suggests this - is
>>> that not clear then?
>>
>> Maybe it's better to add text about the suggestion of hardware
>> implementation.
> As I tried to explain, what exactly is "hardware implementation"
> is very much platform dependent so I don't know how to do that.
> Ideas?
>   


Not a native speaker, but if any part of was done through emulation, it 
should be treated as a software implementation. Otherwise, it's a 
hardware emulation.

Or it's a common implication that it's impossible to implement a 
hardware without ACCESS_PLATFORM (e.g for PCI how can a device bypass 
IOMMU address translation by its own?).


>>>
>>>> ACCESS_PLATFORM has similar question.
>>> That one is a bit different in that guest might rely on e.g.
>>> vIOMMU for security.  So depending on platform device might want
>>> to fail feature negotiation.
>>>
>>> But it's not a problem for e.g. SEV since a legacy non encrypted
>>> guest will just work.
>>
>> How about a encrypted guest that wants to use software IOTLB?
> Software iotlb by itself does not *have* to affect ACCESS_PLATFORM - it is
> enough to just avoid giving device any memory outside the IOTLB.


The problem is, if e.g DMA core can recognize the case of software IOTLB 
without ACCESS_PLATFORM, it can recognize IOMMU, bounce buffer etc as 
well. If we can offload those things to platform/DMA codes, there's no 
need for ACCESS_PLATFORM at all.


> However it is probably more robust to set ACCESS_PLATFORM in
> that setup to avoid any confusion.


So it's the responsibility of management to detect the case and set the 
bit or just set it unconditionally.


>
>>> Maybe a new section about security might make sense.
>>>
>>>> The question is about the necessarily
>>>> of duplicating platform specific feature detection into a device feature.
>>> Historically the assumption drivers made was that
>>> a device is exactly like driver: same physical address,
>>> same permissions and ordering for memory accesses.
>>>
>>> Nowdays some drivers make the assumptions about ordering
>>> but not permissions and physical address.
>>>
>>> We can't just ignore existing drivers, can we?
>>
>> It can only work if both features were supported and advertised by devices.
>> Consider the case that IOMMU is enable but iommu_platform is not,
> So this is a critique of existing spec text then?


No. I meant it only work if ACCESS_PLATFORM and ACCESS_ORDER were set 
correctly.


> Given plans for an imminent 1.1 release let's focus on
> the proposed patch, ok?
>
>
>> in this
>> case:
>>
>> 1) we still can't recognize old guests, so it won't fail gracefully.
>>
>> 2) new guests can't work
>>
>>
>> It depends on how much we can gain from failing gracefully. I believe we
>> don't want to force a software fallback.
> iommu_platform fundamentally doesn't support a software fallback,
> it's a security feature. So I agree but what gave you the idea that we
> force a software fallback?


I don't suggest a software fallback. I meant without a fallback:

- when IOMMU_PLATFORM is not advertised, there are still cases that 
IOMMU_PLATFORM can't handle (the above two cases).

- when IOMMU_PLATFORM is advertised (or could not be turned of for e.g 
hardware implementation), the only difference is a graceful failure or 
silent failure for old guest, but how much important is the case?

Consider the above cases, is it better just implement the semantics of 
IOMMU_PLATFORM silently and deprecate it in the future. Then we may only 
meet one silent failure when driver doesn't correctly detect platform 
requirements.


> So ORDER_PLATFORM it seems prodent to
> suggest a software fallback given not one driver in the field sets it.
>
> Would your comment be addressed if I replace RECOMMENDED with MAY?
>
>> So I wonder how bad just let
>> existing drivers fail and try to patch and backport the fixes without
>> introducing new feature bits. With this we can offload those tasks to
>> platform or configuration specific codes instead of our own.
>>
>>
>> Another question is whether or not we need two separate feature bits.
> Well IOMMU_PLATFORM is already set in the field.
> We can't make it also imply strong barriers without
> breaking a bunch of existing setups.


Or just imply the IOMMU_PLATFORM if ACCESS_ORDER is set.


>
>> E.g
>> when should we set one bit but not for another?
> I am sorry I don't understand the question.  I did try to
> document what does each bit say. Is it completely unclear then?
> Could you give some hints on what is unclear? Which kind
> of functionality is covered by both such that it's
> an open question which one to set?


I meant, e.g spec allow the case of advertising ACCES_ORDER but not 
advertising ACCESS_PLATFORM. This sounds somehow ambiguous since both 
feature are memory related but part were accessed in a way what platform 
requires but the rest doesn't.


>
>>> So a device needs to know what it's dealing with, to
>>> either fail gracefully or recover by a software fallback.
>>>
>>>
>>>> Thanks
>>> All good questions, though I'm not sure whether they mean we
>>> need to add some text to the spec. Suggestions about
>>> what should be documented?
>>>
>> Maybe it's better to clarify the suggestion for hardware or mixed
>> implementations.
>>
>> Thanks
> Right but I don't know what to suggest. E.g. intel recently
> published data about a hardware vDPA which does not set either
> bits.


So this violates spec. Device actually will go through IOMMU but driver 
won't use DMA API at all. But since the control path is under the 
control of software, it's no hard to advertise it I believe. If not, 
it's another call for clarifying ACCESS_PLATFORM/ACCESS_ORDER is 
mandatory for hardware.


> They are working on support for a vIOMMU at which point
> they will set IOMMU_PLATFORM. Once they start worrying about
> portability they might add ORDER_PLATFORM. But given it's
> VDPA they don't necessarily need to fail without even
> on weakly ordered platforms.


If feature bit advertising could be controlled by software it probably 
won't need any suggestion. We probably need suggest only for full 
hardware implementation without any software emulation.

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

