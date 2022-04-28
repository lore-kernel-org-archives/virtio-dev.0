Return-Path: <jasowang@redhat.com>
Message-ID: <cb3684ef-0c6c-58ec-7eed-36e4605963e1@redhat.com>
Date: Thu, 28 Apr 2022 11:43:16 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEviG8JkDZkv3FBChPcKb2zWdnsZpVrh5Oa6d1C1shHdJw@mail.gmail.com>
 <PH0PR12MB5481515FBE5E8842D44AFF2DDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481515FBE5E8842D44AFF2DDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/4/28 11:24, Parav Pandit 写道:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Wednesday, April 27, 2022 11:15 PM
>>
>> On Wed, Apr 27, 2022 at 11:39 PM Parav Pandit <parav@nvidia.com> wrote:
>>>
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Wednesday, April 27, 2022 11:30 AM
>>>>
>>>> On Wed, Apr 27, 2022 at 02:51:36PM +0000, Parav Pandit wrote:
>>>>>> From: Jason Wang <jasowang@redhat.com>
>>>>>> Sent: Wednesday, April 27, 2022 7:30 AM
>>>>>>
>>>>>> On Wed, Apr 27, 2022 at 6:26 PM Parav Pandit <parav@nvidia.com>
>> wrote:
>>>>>>> example flow:
>>>>>>> a) 0,0 -> device init time value
>>>>>>> b) 1,0 -> vq is enabled by driver and working
>>>>>> Did you see my reply in V1? What's the reason for using write to
>>>>>> clear behavior that is different from the device status?
>>>>>>
>>>>>> We can simply make this as 1, 1 here and let the driver write to
>>>>>> 0 to reset the virtqueue.
>>>>>>
>>>>>> And if we do this, the queue_enable and queue_reset are always
>>>>>> the same, then we can simply reuse queue_enable.
>>>>>>
>>>>> Yes, I know we can make this work using new feature bit + single
>>>> queue_enable register.
>>>>> I replied that in v0 to Michael.
>>>> A bigger question in my eyes is that down the road we might want to
>>>> be able to stop the ring without having it lose state.
>>>> The natural interface for that seems to be writing 0 to queue enable.
>>> Why queue_enable and not queue_reset?
>>>
>>> to me this interface is unlikely performant and useful for such case.
>>> When we want to pause/stop the VQ and query the state we need
>> performant scheme, that can even work in a batch for all the VQs.
>>> At that point programming 64 registers to pause/stop VQ without losing
>> state and querying its indices etc won't be scalable with register interface.
>>
>> The register interface to sync indices has already been implemented in real
>> hardware for years.
>>
> Sure. I meant to that when we want to pause a VQ and restart later use-case will require more plumbing than just enable/disable register.
> And to do that, a register interface won't be performant/scalable. So for the wider use case this may not be the good choice.
>
> And I explained the other reason that we lose the state information with this busy-wait register in the other reply to V2 and summary in the github issue too on Michael's request.


I've replied to the thread.


>
>>> I imagine a AQ (likely) or some other interface.
>> So did the queue_enable registers, we need to write 1 to queue_enable for
>> each virtqueue before DRIVER_OK.
>>
>> Where to allow writing 0 to queue_enable is orthogonal to scalability.
> Sure, lets sync after you get chance to go through my other reply to Michael about why with single busy-wait register we lose the state.
> And hence, queue_reset register (with the fix) is better.


Note that the MMIO transport allows writing 0 to queue_ready.

Thanks


