Return-Path: virtio-dev-return-4603-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D32BA5819230
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Jun 2018 23:12:11 -0700 (PDT)
References: <20180625122442.22432-1-tiwei.bie@intel.com>
 <20180625204233-mutt-send-email-mst@kernel.org>
 <87208c5b-6f51-4a58-6078-5de694d93552@linux.ibm.com>
 <20180626181922.GA28773@debian>
 <20180626212448-mutt-send-email-mst@kernel.org>
 <20180627180803.708b4ed3.cohuck@redhat.com> <20180628085234.GA18042@debian>
 <af1847c0-5c83-685c-4bf6-87a5a48ff2fa@redhat.com>
 <20180629072100-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <209339a3-072f-a3d8-3992-77f1639906b4@redhat.com>
Date: Fri, 29 Jun 2018 14:11:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180629072100-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, stefanha@redhat.com, pbonzini@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年06月29日 12:21, Michael S. Tsirkin wrote:
>>> The discussion is to talk about how to fix the potential
>>> problems that currently may happen when the virtio devices
>>> (which need to bypass the IOMMU) work on the platforms
>>> (which have DMA limitations).
>>>
>>> Currently,
>>>
>>> - IO_BARRIER is just to tell drivers which type of barriers
>>>     should be used.
>>>
>>> - IOMMU_PLATFORM (from my understanding) is to tell drivers
>>>     whether the devices need to bypass the IOMMU.
>>>
>>> Michael is asking whether we should tweak above two bits
>>> or whether we should do something else to solve this problem.
>>>
>>> If we want to tweak above two bits, they may become
>>> something like:
>>>
>>> - PLATFORM_CACHE (from IO_BARRIER): about the memory
>>>      operations visibility between driver and device.
>> One issue here is sometime we may have something like a software IOTLB which
>> is transparent to device. Just infer from the name of PLATFORM_CACHE, it
>> seems does not cover this case.
> I don't think device needs to know about that.
> That's up to driver/OS.

So the question is can driver get those limitations or requirements 
through a transport specific way instead of depending a feature. If we 
define a feature that does not cover all the cases, we probably need 
another one to fix it. That's suboptimal.

>
>>> - PLATFORM_IOMMU (from IOMMU_PLATFORM): about whether
>>>      the DMA addr passed to the device should be prepared
>>>      (because e.g. the device is behind an IOMMU, or the
>>>      device can only access parts of system memory).
>> So I think it's a bug of driver instead of a missing feature.
> what is?

I mean it was probably a bug that we must specify PLATFORM_IOMMU to use 
swiotlb.

>
>
>> We can even
>> fail the device probe in this case for safety.
>>
>> Thanks
> device can and does.

Yes.

Thanks

>
>>> Currently, I don't know what's the best choice..
>>>
>>> Best regards,
>>> Tiwei Bie


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

