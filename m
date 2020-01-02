Return-Path: virtio-dev-return-6580-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2256985C94
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Jan 2020 09:13:32 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
Date: Thu, 2 Jan 2020 17:13:28 +0800
MIME-Version: 1.0
In-Reply-To: <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

[...]

>>>
>>>> +
>>>> +/* RO: MSI feature enabled mask */
>>>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=C2=A0=C2=A0=C2=A0 0x8000
>>>> +/* RO: Maximum queue size available */
>>>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=C2=A0=C2=A0=C2=A0 0x07ff
>>>> +/* Reserved */
>>>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=C2=A0=C2=A0=C2=A0 0x7800
>>>> +
>>>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=C2=A0=C2=A0=C2=A0 0x1
>>>
>>>
>>> I believe we need a command to read the number of vectors supported=20
>>> by the device, or 2048 is assumed to be a fixed size here?
>>
>> For not bringing much complexity, we proposed vector per queue and=20
>> fixed relationship between events and vectors.
>
>
> It's a about the number of MSIs not the mapping between queues to=20
> MSIs.And it looks to me it won't bring obvious complexity, just need a=20
> register to read the #MSIs. Device implementation may stick to a fixed=20
> size.

Based on that assumption, the device supports #MSIs =3D #queues + #config.=
=20
Then driver need not read the register.

We're trying to make such kind of agreement on spec level.

>
> Having few pages for a device that only have one queue is kind of a=20
> waste.

Could I ask what's the meaning of few pages here? BTW, we didn't define=20
MSIx-like tables for virtio-mmio.

Thanks,

Jing

>
> Thanks
>
>
>>
>>
>> So the number of vectors supported by device is equal to the total=20
>> number of vqs and config.
>>
>> We will try to explicitly highlight this point in spec for later=20
>> version.
>>
>>
>> Thanks!
>>
>> Jing
>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

