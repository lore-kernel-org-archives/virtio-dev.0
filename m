Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <927f2a80-90a0-e50a-75c9-88465170cdc8@nvidia.com>
Date: Wed, 18 May 2022 18:14:35 +0300
Subject: Re: [virtio-comment] RE: [PATCH v5 6/7] Introduce MGMT admin commands
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-7-mgurtovoy@nvidia.com>
 <20220515102628-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818C762CC4DAAB3020B2ADDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517082703-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220517082703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 3:31 PM, Michael S. Tsirkin wrote:
> On Mon, May 16, 2022 at 09:47:23PM +0000, Parav Pandit wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Sunday, May 15, 2022 10:37 AM
>>>> +This value is also returned in the virtio_admin_device_mgmt_result
>>> structure.
>>>> +Also, a successful operation guarantees that the MSI-X capability
>>>> +access by the designated PCI device defined by the PCI specification
>>>> +must reflect the new configuration in all relevant fields. For example, by
>>> default if the PCI VF has been assigned 4 MSI-X vectors, and
>>> VIRTIO_ADMIN_DEVICE_MGMT increases the MSI-X vectors to 8. On this
>>> change, reading Table size field of the MSI-X message control register will
>>> reflect a value of 7.
>>>> +
>>>> +It is beyond the scope of the virtio specification to define
>>>> necessary synchronization in system software to ensure that a virtio
>>>> PCI VF device +interrupt configuration modification is reflected in
>>>> the PCI device.
>>> IMHO it is very much in scope of the specification.
>> Many pieces of this system software are not implemented by the virtio specification...
>> Not sure, how can it belong to virtio spec.
>>
>>> The scope of the
>>> specification is to allow device interoperability and this very much fits the bill.
>>>
>> How is interoperability affected and between which two entities?
> For example, if OS/driver caches the # of vectors in the MSI capability,
> and it changes things will not work.  OS/drivers won't know not to cache
> values unless we tell them what not to cache.

There is a support today in Linux to change msi-x configuration of mlx5 VFs.

You're welcome to review it and raise issues if you find some.

I'll fwd these issues to relevant maintainers of RDMA and PCI subsystems.

We mentioned that drivers shouldn't probe the VF, so for sure the driver 
will not cache the # of vectors if it didn't probe the VF.

>
> I'd like to float again the idea of instead exposing a larger number of
> vectors than supported. Assigning more vectors than supported will then
> fail, drivers already check that so they will recover.
> Avoids modifying fields that pci spec expects to be read only.

It's nothing new.

This exist today in linux.

starting from some large unsupported number might cause issues to 
un-resilient drivers.

Are you sure this is what you like to write in the spec ?

>

