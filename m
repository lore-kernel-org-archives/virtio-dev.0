Return-Path: <jasowang@redhat.com>
Message-ID: <3418f436-2d0b-c0ee-264d-2153315f1c56@redhat.com>
Date: Tue, 25 Jan 2022 11:45:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117170442-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F371AF762EE35F25EC1BDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481F371AF762EE35F25EC1BDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/20 上午4:25, Parav Pandit 写道:
> Hi Jason,
>
>> From: Parav Pandit
>> Sent: Wednesday, January 19, 2022 10:18 AM
>>
>>
>>> From: Jason Wang <jasowang@redhat.com>
>>> Sent: Wednesday, January 19, 2022 9:33 AM
>>>
>>>
>>> It it means IMS, there's already a proposal[1] that introduce MSI
>>> commands via the admin virtqueue. And we had similar requirement for
>>> virtio-MMIO[2] and managed device or SF [3], so I would rather to
>>> introduce IMS (need a better name though) as a basic facility instead
>>> of tie it to any specific transport.
>>>
>> IMS of [1] is a interrupt configuration by the virtio driver for the device is it
>> driving, which needs a queue.
>> So regardless of the device type as PCI PF/VF/SF/ADI, there is desire to have a
>> generic admin queue not attached to device type.
>> And AQ in this proposal exactly serves this purpose.
>>
>> Device configuring its own IMS vector vs PCI PF configuring VF's MSI-X max
>> vector count are two different functionality.
>> Both of these commands can ride on a generic queue.
>> However the queue is not same, because
>> PF owns its own admin queue (for vf msix config), VF or SF operates its own
>> admin queue (for IMS config).
>>
>> So a good example is,
>> 1. PCI PF configures 8 MSI-X or 16 IMS vectors for the VF using PF_AQ in HV.
>> 2. PCI VF when using IMS configures, IMS data, vector, mask etc using VF_AQ in
>> GVM.
>> Both the functions will have AQ feature bit set.
>>
>> Fair enough, so we have more users of admin queue than just MSI-X config.
>>
> If we treat the AQ as any other VQ, than IMS configuration by the virtio driver of #2 for VF or SF cannot be done through AQ.
> Because AQ needs to be live before setting DRIVER_OK.
> And spec mandates "The driver MUST configure the other virtqueue fields before enabling the virtqueue with queue_enable."
> This includes the vector configuration.
> So AQ will operate in polling mode which is not so good.
> And it cannot be disabled to update MSI-X/IMS vectore because spec says "The driver MUST NOT write a 0 to queue_enable.".
>
> Make special exception to AQ is equally not good in physical device implementation given all the queue config is located in single config space.
>
> So a better approach for IMS configuration would be to have, limited config registers to bootstrap IMS configuration.
> Something like,
>
> struct virtio_pci_dev_interrupt_cfg {
> 	le16 max_device_interrupts; /* read-only tells maximum ims interrupts */


Is it better to use the same terminology with MSI capability like 
"max_device_vectors"


> 	le16 refer_index; /* write-only interrupt index to program */
> 	u8 status;	/* read only response by device, 0x0 = success, 0x1=busy, other error codes */
> 	u8 enable;	/* enable/disable interrupt referred by index */


Any reason we need this assuming we've already had PCI_NO_VECTOR in 
common cfg? I think what's better to have is the ability to mask and 
unmask a vector.


> 	le16 reserved_pad;
> 	u64 addr; /* write only interrupt addr handle on MSIX TLPs */
> 	u32 data; /* write only interrupt data handle.. */
> };


Is this better to split the above into different commands?

Thanks


> This way, VF, SF can configure large number of vectors before starting the queue and without on-chip resource.
> Only on-chip resource required per VF is 20 bytes of above cfg registers.

