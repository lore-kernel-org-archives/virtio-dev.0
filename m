Return-Path: <david@redhat.com>
Message-ID: <eaa5311e-7bae-f3a9-20eb-b403dbd87005@redhat.com>
Date: Thu, 11 Aug 2022 18:20:53 +0200
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
 <20220809160711-mutt-send-email-mst@kernel.org> <87r11octk4.fsf@redhat.com>
 <20220810194108.78059919.pasic@linux.ibm.com> <87lervcga8.fsf@redhat.com>
 <20220811160915.59ced645.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20220811160915.59ced645.pasic@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.08.22 16:09, Halil Pasic wrote:
> On Thu, 11 Aug 2022 10:53:35 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Wed, Aug 10 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On Wed, 10 Aug 2022 11:54:35 +0200
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>  
>>>>>> These device-specific notifications are needed later when adding support
>>>>>> for virtio-vhost-user device.
>>>>>>
>>>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>    
>>>>>
>>>>> I see ccw is missing. Cornelia, any suggestions?    
>>>>
>>>> Hmm... I seem to be really behind on ccw things :(
>>>>
>>>> We can probably use the following:
>>>>
>>>> - for device->driver notification, use the next bit in the secondary
>>>>   indicators (bit 0 is used for config change notification)
>>>> - for driver->device notification, maybe use a new subcode for diagnose
>>>>   0x500 (4 is probably the next free one?)
>>>>   
>>>
>>> Sounds reasonable! I will have to double check the DIAG stuff though. I'm
>>> not sure where what needs to be reserved and documented.   
>>
>> There's
>> https://gitlab.com/davidhildenbrand/s390x-os-virt-spec/-/merge_requests/1,
>> but nothing much has happened there recently. David?

Heh, I'd like to say it has high priority on my todo list ... but there
is a lot of stuff with even higher priority. I'll definetly come back to
this soonish.

> 
> Hm, that seems to be private. I land on a sign-in page.

Oh, it was private. It's public now.


-- 
Thanks,

David / dhildenb

