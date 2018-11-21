Return-Path: virtio-dev-return-4984-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
References: <20181121030702.22703-1-mst@redhat.com>
 <13b18a80-6b54-9656-7872-e91eea811599@redhat.com>
 <20181120234232-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ac93c87-d51f-fd70-29cd-fbba950919a7@redhat.com>
Date: Wed, 21 Nov 2018 15:35:21 +0800
MIME-Version: 1.0
In-Reply-To: <20181120234232-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] ACCESS_PLATFORM/ACCESS_ORDER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2018/11/21 下午1:11, Michael S. Tsirkin wrote:
>> A question is. Are you suggesting to have VIRTIO_F_ORDER_PLATFORM for each
>> hardware implementation?
> It's not a simple question. There are implementations such as
> VDPA which have a hardware and a software component.
> For a hardware only device that is also pluggable into an
> arbitrary system, it's true.
>
>> If not, can a hardware detect the platform by
>> itself and advertise this bit automatically?
> So a mixed software/hardware device might be able to,
> and e.g. fallback to a software implementation
> if driver assumes that.
>
> There's actually some text that suggests this - is
> that not clear then?


Maybe it's better to add text about the suggestion of hardware 
implementation.


>
>
>> ACCESS_PLATFORM has similar question.
> That one is a bit different in that guest might rely on e.g.
> vIOMMU for security.  So depending on platform device might want
> to fail feature negotiation.
>
> But it's not a problem for e.g. SEV since a legacy non encrypted
> guest will just work.


How about a encrypted guest that wants to use software IOTLB?


>
> Maybe a new section about security might make sense.
>
>> The question is about the necessarily
>> of duplicating platform specific feature detection into a device feature.
> Historically the assumption drivers made was that
> a device is exactly like driver: same physical address,
> same permissions and ordering for memory accesses.
>
> Nowdays some drivers make the assumptions about ordering
> but not permissions and physical address.
>
> We can't just ignore existing drivers, can we?


It can only work if both features were supported and advertised by 
devices. Consider the case that IOMMU is enable but iommu_platform is 
not, in this case:

1) we still can't recognize old guests, so it won't fail gracefully.

2) new guests can't work


It depends on how much we can gain from failing gracefully. I believe we 
don't want to force a software fallback. So I wonder how bad just let 
existing drivers fail and try to patch and backport the fixes without 
introducing new feature bits. With this we can offload those tasks to 
platform or configuration specific codes instead of our own.


Another question is whether or not we need two separate feature bits. 
E.g when should we set one bit but not for another?


> So a device needs to know what it's dealing with, to
> either fail gracefully or recover by a software fallback.
>
>
>> Thanks
> All good questions, though I'm not sure whether they mean we
> need to add some text to the spec. Suggestions about
> what should be documented?
>

Maybe it's better to clarify the suggestion for hardware or mixed 
implementations.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

