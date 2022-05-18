Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <f14b6468-8082-4c26-f25d-dbbdfa155651@nvidia.com>
Date: Wed, 18 May 2022 17:42:05 +0300
Subject: Re: [PATCH v5 5/7] Add miscellaneous configuration structure for PCI
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-6-mgurtovoy@nvidia.com>
 <20220515105131-mutt-send-email-mst@kernel.org> <87wnekfowv.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87wnekfowv.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 1:12 PM, Cornelia Huck wrote:
> On Sun, May 15 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Wed, Apr 27, 2022 at 01:58:22AM +0300, Max Gurtovoy wrote:
>>> This new structure will be used for adding new miscellaneous registers
>>> for a virtio device configuration layout.
>>>
>>> For now, only admin_queue_index register is added. Admin virtqueue index
>>> does not depend on the device type. Hence, add a PCI capability to read
>>> the admin virtqueue index.
>>>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>> I guess we discussed this but I forgot. Why do we have this new
>> structure as opposed to just adding the value at the end of config
>> structure? I was kind of hoping that the structure can be
>> reused for CCW/MMIO and then we can add more use-cases with
>> new transport and device independent structures.
>>
>> If we keep it transport specific I don't really understand why
>> is it useful ...
> Nod, just define a common misc_configuration struct and have the
> individual transports access it in the way it works best for them.

can we agree on it ?

I think we got 3 acks on this in the past, are we opening this topic again ?

