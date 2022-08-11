Return-Path: <virtio-dev-return-9764-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B374986406
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Aug 2022 08:53:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220810194108.78059919.pasic@linux.ibm.com>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
 <20220809160711-mutt-send-email-mst@kernel.org>
 <87r11octk4.fsf@redhat.com> <20220810194108.78059919.pasic@linux.ibm.com>
Date: Thu, 11 Aug 2022 10:53:35 +0200
Message-ID: <87lervcga8.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 10 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 10 Aug 2022 11:54:35 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> >> These device-specific notifications are needed later when adding support
>> >> for virtio-vhost-user device.
>> >> 
>> >> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>  
>> >
>> > I see ccw is missing. Cornelia, any suggestions?  
>> 
>> Hmm... I seem to be really behind on ccw things :(
>> 
>> We can probably use the following:
>> 
>> - for device->driver notification, use the next bit in the secondary
>>   indicators (bit 0 is used for config change notification)
>> - for driver->device notification, maybe use a new subcode for diagnose
>>   0x500 (4 is probably the next free one?)
>> 
>
> Sounds reasonable! I will have to double check the DIAG stuff though. I'm
> not sure where what needs to be reserved and documented. 

There's
https://gitlab.com/davidhildenbrand/s390x-os-virt-spec/-/merge_requests/1,
but nothing much has happened there recently. David?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

