Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
Date: Sun, 30 Jan 2022 17:12:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com> <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org> <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
 <e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
 <20220130043917-mutt-send-email-mst@kernel.org>
 <f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
 <20220130093740-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220130093740-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/30/2022 4:41 PM, Michael S. Tsirkin wrote:
> On Sun, Jan 30, 2022 at 11:56:30AM +0200, Max Gurtovoy wrote:
>> On 1/30/2022 11:40 AM, Michael S. Tsirkin wrote:
>>> On Sun, Jan 30, 2022 at 11:13:38AM +0200, Max Gurtovoy wrote:
>>>> On 1/29/2022 5:53 AM, Jason Wang wrote:
>>>>> On Fri, Jan 28, 2022 at 11:52 PM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>> On Fri, Jan 28, 2022 at 04:49:34PM +0100, Cornelia Huck wrote:
>>>>>>> On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>
>>>>>>>> On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Huck wrote:
>>>>>>>>> On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>>>>>>>> +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virt=
io Device / Admin Virtqueues}
>>>>>>>>>> +
>>>>>>>>>> +Admin virtqueue is used to send administrative commands to mani=
pulate
>>>>>>>>>> +various features of the device and/or to manipulate various fea=
tures,
>>>>>>>>>> +if possible, of another device within the same group (e.g. PCI =
VFs of
>>>>>>>>>> +a parent PCI PF device are grouped together. These devices can =
be
>>>>>>>>>> +optionally managed by its parent PCI PF using its admin virtque=
ue.).
>>>>>>>>>> +
>>>>>>>>>> +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
>>>>>>>>>> +feature bit.
>>>>>>>>>> +
>>>>>>>>>> +Admin virtqueue index may vary among different device types.
>>>>>>>>> So, my understanding is:
>>>>>>>>> - any device type may or may not support the admin vq
>>>>>>>>> - if the device type wants to be able to accommodate the admin vq=
, it
>>>>>>>>>      also needs to specify where it shows up when the feature is =
negotiated
>>>>>>>>>
>>>>>>>>> Do we expect that eventually all device types will need to suppor=
t the
>>>>>>>>> admin vq (if some use case comes along that will require all devi=
ces to
>>>>>>>>> participate, for example?)
>>>>>>>> I suspect yes. And that's one of the reasons why I'd rather we had=
 a
>>>>>>>> device independent way to locate the admin queue. There are less
>>>>>>>> transports than device types.
>>>>>>> So, do we want to bite the bullet now and simply say that every dev=
ice
>>>>>>> type has the admin vq as the last vq if the feature is negotiated?
>>>>>>> Should be straightforward for the device types that have a fixed nu=
mber
>>>>>>> of vqs, and doable for those that have a variable amount (two devic=
e
>>>>>>> types are covered by this series anyway.) I think we need to put it=
 with
>>>>>>> the device types, as otherwise the numbering of virtqueues could ch=
ange
>>>>>>> in unpredictable ways with the admin vq off/on.
>>>>>> Well that only works once. The next thing we'll need we won't be abl=
e to
>>>>>> make the last one ;) So I am inclined to add a per-transport field t=
hat
>>>>>> gives the admin queue number.
>>>>> Technically, there's no need to use the same namespace for admin
>>>>> virtqueue if it has a dedicated notification area. If we go this way,
>>>>> we can simply use 0 as queue index for admin virtqueue.
>>>> Or we can use index 0xFFFF for admin virtqueue for compatibility.
>>> I think I'd prefer a register with the #. For example we might want
>>> to limit the # of VQs in order to pass extra data with the kick write.
>> So you are suggesting adding a new cfg_type (#define
>> VIRTIO_PCI_CAP_ADMIN_CFG 10) ?
>>
>> that will look something like:
>>
>> struct virtio_pci_admin_cfg {
>>
>>  =C2=A0=C2=A0=C2=A0 le32 queue_index; /* read only for the driver */
>>
>>  =C2=A0=C2=A0=C2=A0 le16 queue_size; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le16 queue_msix_vector; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le16 queue_enable; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le16 queue_notify_off; /* read-only for driver */
>>  =C2=A0=C2=A0=C2=A0 le64 queue_desc; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le64 queue_driver; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le64 queue_device; /* read-write */
>>  =C2=A0=C2=A0=C2=A0 le16 queue_notify_data; /* read-only for driver */
>>  =C2=A0=C2=A0=C2=A0 le16 queue_reset; /* read-write */
>>
>> };
>>
>> instead of re-using the struct virtio_pci_common_cfg ?
>>
>>
>> or do you prefer extending the struct virtio_pci_common_cfg with "le16
>> admin_queue_index; /* read only for the driver */ ?
> The later. Other transports will need this too.
>
>
> Cornelia has another idea which is that instead of
> adding just the admin queue register to all transports,
> we instead add a misc_config structure to all
> transports. Working basically like device specific config,
> but being device independent. For now it will only have
> a single le16 admin_queue_index register.
>
> For PCI we would thus add it with VIRTIO_PCI_CAP_MISC_CFG
>
> The point here is that we are making it easier to add
> more fields just like admin queue index in the future.

OK.

#define VIRTIO_PCI_CAP_MISC_CFG 10

and

struct virtio_pci_misc_cfg {
     le16 admin_queue_index; /* read-only for driver */
};

Is agreed by all for V3 ? instead of the net and blk AQ index definitions.


>
>
>>>
>>>>> Thanks
>>>>>
>>>>>> Another advantage to this approach is that
>>>>>> we can make sure admin queue gets a page by itself (which can be goo=
d if
>>>>>> we want to allow access to regular vqs but not to the admin queue to
>>>>>> guest) even if regular vqs share a page. Will help devices use less
>>>>>> memory space.
>>>>>>
>>>>>> --
>>>>>> MST
>>>>>>

