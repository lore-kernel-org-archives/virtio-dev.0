Return-Path: <virtio-comment-return-3052-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <a71782bb-5915-ada7-711e-81e9848c03fd@nvidia.com>
Date: Wed, 18 May 2022 16:42:28 +0300
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgjgfp46.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87zgjgfp46.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/17/2022 1:08 PM, Cornelia Huck wrote:
> On Mon, May 16 2022, Parav Pandit <parav@nvidia.com> wrote:
>
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
> I'm not against using a queue, but why not use feature bits for
> capabilities? As Michael said, the infrastructure for that is already in
> place.

It's not scalable.

After few features we'll add, we'll regret we ever did it.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

