Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <dc9abfdc-8b61-8aea-a1c2-fd7b2e8163a5@nvidia.com>
Date: Wed, 18 May 2022 17:09:07 +0300
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220517074130-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 2:48 PM, Michael S. Tsirkin wrote:
> On Mon, May 16, 2022 at 09:08:34PM +0000, Parav Pandit wrote:
>> Hi Michael,
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Sunday, May 15, 2022 11:24 AM
>> [..]
>>
>>>> +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT
>>> command}\label{sec:Basic
>>>> +Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN
>>>> +DEVICE CAPS ACCEPT command}
>>>> +
>>>> +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the
>>> driver to acknowledge those admin capabilities it understands and wishes to
>>> use.
>>>
>>>
>>> ok so we have a protocol here, kind of like feature negotiation. Please write
>>> its description.
>>> e.g. is it ok to change accepted caps? when? can device change its caps etc
>>> etc etc.
>>>
>>> Avoiding this kind of spec work is exactly why me and jason keep telling you
>>> to consider just using features instead. Add a 64 bit admin features field to
>>> the PCI transport and be done with it. CCW and MMIO already have feature
>>> selector so it's trivial to add feature bits.
>>>
>> As we begin to scale with the device, adding more and more registers like this demands more on-device real estate to comply to the PCI standards.
>>
>> And therefore, things are queried/accessed rare or occasionally, are better accessed via a queue interface.
>>
>> One can argue that admin VQ is proposed only for the mgmt. functions so having this cfg register for PF is enough.
>>
>> However, AQ may find some usage in the VF/SF themselves down the road.
>> Hence, keeping the cap exchange transport this way is more optimal.
>>
>> Max has called out this AQ rationale in 4 or 5 points in the cover letter.
> Hmm. It's kind of a generic claim though. We never put devices on a diet
> trying to conserve registers. There is cost associated with this dance
> and that is driver boot time.
>
> I also don't really understand how you can claim you need to save
> memory like this and at the same time blindly add a more or less
> "just in case" misc config in the config space.
> So, not pretty.
>
> And as I said, you will need much more spec work to reach the level
> to which features are specified - and note we are not yet happy with
> how features are specified either! So it's a moving target.
>
> Maybe put this in features for now, and leave the whole
> capability thing for another day?

If you're not happy on the feature negotiation in the spec so please 
don't insist we use this mechanism for admin capabilities.

I don't want to postpone essential and basic definition to another day.

We need to agree on it today (even yesterday).

>

