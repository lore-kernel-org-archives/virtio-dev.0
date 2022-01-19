Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <b67e0669-afe1-a743-74d8-1482d74b7fdf@nvidia.com>
Date: Wed, 19 Jan 2022 16:47:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] Add virtio Admin Virtqueue specification
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BAD47AA812DF42811466DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117165941-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2443CB685591E194C11DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118015736-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E021CEB9506359DB23AEDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118021651-mutt-send-email-mst@kernel.org>
 <84a8a004-cc78-170d-9856-f0b5f8115a6f@nvidia.com>
 <PH0PR12MB5481B646941E0A41D2AF55BEDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <PH0PR12MB5481B646941E0A41D2AF55BEDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 1/19/2022 2:21 PM, Parav Pandit wrote:
>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Sent: Wednesday, January 19, 2022 5:04 PM
> [..]
>>>>>> struct virtio_admin_pci_virt_property_set {
>>>>>> =09enum virtio_device_identifier_type type; /* pci pf, pci vf,
>>>>>> subfunction
>>>>> */
>>>>>> =09union virtio_device_identifier {
>>>>>> =09=09struct virtio_pci_dev_id pf_vf; /* current */
>>>>>> =09=09struct virtio_subfunction sf; /* future */
>>>>>> =09};
>>>>>> =09enum virtio_interrupt_type interrupt_type; /* msix, ims=3Ddevice
>>>>> specific, intx, something else */
>>>>>> =09union virtio_interrupt_config {
>>>>>> =09=09struct virtio_pci_msix_config msix_config;
>>>>>> =09};
>>>>>> };
>>>>>>
>>>>>> struct virtio_pci_interrupt_config {
>>>>>> =09le16 msix_count;
>>>>>> };
>>>>> you do not need a union straight away, Simply use something like
>>>>> this "device identifier" everywhere and then add some text
>>>>> explaining that currently it is a VF number and that admin device is =
a PF.
>>>> Unless we reserve some bytes, I fail to see how can it be future compa=
tible
>> for unknown device id type for subfunction.
>>> So reserve some bytes then. 4 should be plenty.
> I am not comfortable reserving 4 bytes for sf, though it is good option a=
nd already in use in one OS for more a year now.
>
>> Ok so in V2 we'll use 4 bytes as device identifier to be generic.
>>
>> We can call it lid (local id) of vlid (virtio local id) ?
>>
>> Are we ok with one of the above names ?
>>
> I go back to rethink the structure, and don=E2=80=99t see a need to abstr=
act something which is so well defined.
>
> I see need of below structures, how should it be made more abstract witho=
ut breaking backward compat and without defining as TLV.

I agree, I don't see why it's not possible to use a different command=20
opcode for vf interrupt configuration and sf interrupt configuration.

We're not short in opcodes and it's very elegant and extendable IMO.

I think the order should be:

1. add adminq to virtio spec with one simple example (say MSIX config=20
for VFs)

2. in parallel submission for admin commands: S-IOV support, num VQs=20
config, feature bits config and more...

The below example emphasizes that the adminq protocol is flexible and=20
easily extendable.

>
> struct virtio_admin_pci_vf_interrupt_config {
> =09/* v1 current */
> =09le64 property_mask; /* bit 0 valid */
> =09le16 vf_number;
> =09le16 msix_count;
> };
>
> struct virtio_admin_pci_vf_interrupt_config {
> =09/* v2 near future, backward compatible */
> =09le64 property_mask; /* bit 0, 1 valid */
> =09le16 vf_number;
> =09le16 msix_count;
> =09le16 ims_count;
> };
>
> struct virtio_admin_pci_sf_interrupt_config {
> =09/* v3 future, new struct, no need of backward compat */
> =09le64 property_mask; /* bit 0,1,2, valid */
> =09le32 sf_number;
> =09/* is 4 bytes enough to describe sf,
> =09 * what if community decides uuid to identify sf?
> =09 * How about we take out device identifier outside of this struct?
> =09 */
> =09le16 msix_count;
> =09le16 ims_count;
> =09le16 pci_caps; /* pci atomics enable */
> };
>
> virtio_unknown_transport_interrupt_config {
> =09/* vX future */
> =09le64 property_mask;
> =09<unknown len> device identifier;
> =09le16 msix_count;
> =09le16 ims_count;
> };

