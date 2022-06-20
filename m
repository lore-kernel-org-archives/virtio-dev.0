Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <05e1c6be-9d80-1fcb-f09b-70f5b4d562e4@nvidia.com>
Date: Mon, 20 Jun 2022 19:54:00 +0300
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620123447-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220620123447-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 6/20/2022 7:46 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 20, 2022 at 11:06:07AM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, June 20, 2022 6:00 AM
>>>
>>> On Tue, May 31, 2022 at 08:39:24PM +0000, Parav Pandit wrote:
>>>>> And as I said, you will need much more spec work to reach the level
>>>>> to which features are specified - and note we are not yet happy with
>>>>> how features are
>>>> Can you be specific of the work that you are expecting in this v5 version?
>>> I proposed getting rid of attrs_mask/device_admin_caps and instead specify
>>> that e.g. feature bits 64 to 95 are reserved for management purposes.
>>> Maybe just add a 32 bit register, or maybe "extended features"
>>> with a selector and length like mmio and ccw already do, up to you.
>>> I think Cornelia likes this suggestion too.
>>>
>>> This would replace functionality of the
>>> VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY/VIRTIO_ADMIN_DEVICE_CAPS_AC
>>> CEPT
>>> commands and have the advantage of being generally well specified and
>>> understood.
>>>
>>> Is this acceptable? Or is there a reason the new commands are preferable?
>> We prefer the new commands for following reason.
>>
>> 1. proposed new command doesn't demand exposing registers in the PCI memory mapped area
>> 2. Today AQ is perceived in to be PF, but it doesn't have to be. For next 10 years spec may evolve to have AQ for some other purpose on VFs/SFs.
>> Such devices scale at much higher magnitude than PFs.
>> And exposing memory mapped registers for rare functionality is the last thing to do in my mind.
>> 3. Placements of such features bits in an AQ gives device lot more flexibility on _how_ to implement them. Some in sw, fw, hw, memory die etc.
>> Placement of them in PCI register space reduces these options.
>>
>> So exposing them something in PCI register space has to have strong technical reason than just simplicity of access.
> I ansolutely get this argument. Please do get mine which is avoiding
> duplicating very similar functionality is subtly differing ways.
>
> Your above arguments apply equally to most other registers we already
> have.  Wouldn't you then agree we need to address this more drastically by
> defining an alternative transport such as virtio over virtqueue then?

No.

Virtqueues are part of the virtio device.

Admin virtq is yet another queue. It has its own command set. That's it.

And it's ok to have an administration queue to do some control 
configurations. It is common practice in other specifications and not of 
them created a new "queue transport".

Adding a transport is not needed and not relevant to this solution.

>

