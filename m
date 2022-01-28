Return-Path: <jasowang@redhat.com>
Message-ID: <6979b063-d707-710d-fd13-454158ca7541@redhat.com>
Date: Fri, 28 Jan 2022 11:35:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] Add support for MSI-X vectors configuration for
 PCI VFs
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-5-mgurtovoy@nvidia.com>
 <e0726651-4534-26e9-3368-abee12ed13c0@redhat.com>
 <PH0PR12MB5481398EBFC427C178D5F51BDC219@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEte-oLuF81QwTjFJ67VLUksdUsG90rz8RCtnZBxWqaQ2Q@mail.gmail.com>
 <DM8PR12MB5480F4C39589FBA7A3D17336DC229@DM8PR12MB5480.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <DM8PR12MB5480F4C39589FBA7A3D17336DC229@DM8PR12MB5480.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/28 上午11:30, Parav Pandit 写道:
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Friday, January 28, 2022 8:54 AM
>> vxlan part actually.
> Right.
>>> Similarly, we prefer the ability and flexibility to set more fields in one
>> command.
>>
>> I understood this motivation. But what I want to say is:
>>
>> struct virtio_cmd {
>>      u64 attr_mask;
>>      field_X;
>>      field_Y;
>>      field_Z;
>> }
>>
>> What's the default value if one of the X,Y, Z is not specified?
> If minimum default values are not provided, HV cannot proceed to do configuration and ENOSUPPORT error code is returned by kernel to user.


Do we need to document the minimum default value?


>
>> How to get those default values?
>>
> By doing identify or _get respective command.


This can only work if there's no attr_mask in get command. If the device 
can selectively provides us partial information we can't do 
compatibility check since we don't know its value.


>   
>> And suppose we add a new field
>>
>> struct virtio_cmd {
>>      u64 attr_mask;
>>      field_X;
>>      field_Y;
>>      field_Z;
>>      field_M;
>> }
>>
>> How can the driver know it can use field_M?
> If attribute mask is present for field_M, driver can use it.


So the driver need first use get then try to use set?


>
>> And if field_M is supported in src
>> but not dst, how can we keep the migration compatibility?
> This is HV level command to query and provision a VF.
> Migration compatibility is high level check where it will identify on which HV to migrate where I can provision X vectors for a VF.


By probing capability of attr_mask in each possible commands?


>
>> Would it be simple to just mandate all the fields in this case?
>>
> May be, attribute mask is basically to let expand structure without inventing new fields.


It could be done via new command.

Thanks


> For a given command few minimal attributes to be set and driver can verify, that if they are not, a given functionality is unsupported.
>

