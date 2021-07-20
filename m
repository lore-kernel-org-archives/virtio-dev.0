Return-Path: <jasowang@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
References: <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <542aad20-8bca-f5db-647b-41909dacb8d1@nvidia.com>
 <03c6db33-58c8-5357-4c6d-7e5e836b328c@redhat.com>
 <YO//YVrsCTUfgPVO@stefanha-x1.localdomain>
 <1c631d4e-97ba-c132-3ab6-696ab4d4d38d@redhat.com>
 <YPVrRNthlY62blyK@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc3ea56f-e39b-0434-93af-666c08dda8f1@redhat.com>
Date: Tue, 20 Jul 2021 10:46:44 +0800
MIME-Version: 1.0
In-Reply-To: <YPVrRNthlY62blyK@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2021/7/19 下午8:08, Stefan Hajnoczi 写道:
> On Fri, Jul 16, 2021 at 09:48:43AM +0800, Jason Wang wrote:
>> 在 2021/7/15 下午5:26, Stefan Hajnoczi 写道:
>>> On Thu, Jul 15, 2021 at 09:38:55AM +0800, Jason Wang wrote:
>>>> 在 2021/7/15 上午12:22, Max Gurtovoy 写道:
>>>>> On 7/14/2021 6:07 PM, Stefan Hajnoczi wrote:
>>>>>>> It requires much more works than the simple virtqueue interface:
>>>>>>> (the main
>>>>>>> issues is that the function is not self-contained in a single function)
>>>>>>>
>>>>>>> 1) how to interact with the existing device status state machine?
>>>>>>> 2) how to make it work in a nested environment?
>>>>>>> 3) how to migrate the PF?
>>>>>>> 4) do we need to allow more control other than just stop/freeze
>>>>>>> the device
>>>>>>> in the admin virtqueue? If yes, how to handle the concurrent
>>>>>>> access from PF
>>>>>>> and VF?
>>>>>>> 5) how it is expected to work with non-PCI virtio device?
>>>>>> I guess your device splitting proposal addresses some of these things?
>>>>>>
>>>>>> Max probably has the most to say about these points.
>>>>>>
>>>>>> If you want more input I can try to answer too, but I personally am not
>>>>>> developing devices that need this right now, so I might not be the best
>>>>>> person to propose solutions.
>>>>> I think we mentioned this in the past and agreed that the only common
>>>>> entity between my solution for virtio VF migration to this proposal is
>>>>> the new admin control queue.
>>>>>
>>>>> I can prepare some draft for this.
>>>>>
>>>>> In our solution the PF will manage migration process for it's VFs using
>>>>> the PF admin queue. PF is not migratable.
>>>> That limits the use cases.
>>>>
>>>>
>>>>> I don't know who is using nested environments in production so don't
>>>>> know if it worth talking about that.
>>>> There should be plenty users for the nested case.
>>> Yes, nested virtualization is becoming available in clouds, etc. I think
>>> nested virtualization support should be part of the design.
>>>
>>>>> But, if you would like to implement it for testing, no problem. The VF
>>>>> in level n, probably seen as PF in level n+1. So it can manage the
>>>>> migration process for its nested VFs.
>>>> The PF dependency makes the design almost impossible to be used in a nested
>>>> environment.
>>> I'm not sure I understood Max's example, but first I want to check I
>>> understand yours:
>>>
>>> A physical PF is passed through to an L1 guest. L2 guests are assigned
>>> VFs created by the L1 guest from the PF.
>>>
>>> Now we want to live migrate the L1 guest to another host. We need to
>>> migrate the PF and its VFs are automatically included since there is no
>>> migration from the L2 perspective?
>>
>> Yes, and I believe the more common case is.
>>
>> PF is for L0, and we want to migrate L2 guest.
>>
>> This can hardly work in the current design.
>>
>> The reason is that the functions is not self contained in the VF.
> Thanks for highlighting this case. It requires that the mechanism for
> stopping and saving/loading state comes with the VF so the L1 guest can
> perform live migration even though it does not have L0 PF access.
>
> Stefan


Yes.

Thanks


