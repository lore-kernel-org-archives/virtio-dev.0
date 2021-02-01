Return-Path: virtio-dev-return-7965-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37C5F98610E
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Feb 2021 07:02:48 +0000 (UTC)
References: <875d1495-9511-4b5d-062c-2063ee9bed7e@redhat.com>
 <2be31437-a43c-39f6-1253-d9dd17e87823@redhat.com>
 <49d2649b-7f46-b2af-2c14-e903bdd25163@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <68652abc-9518-c0d0-8f99-ab2b3d6706d9@redhat.com>
Date: Mon, 1 Feb 2021 15:02:32 +0800
MIME-Version: 1.0
In-Reply-To: <49d2649b-7f46-b2af-2c14-e903bdd25163@redhat.com>
Subject: Re: [virtio-dev] Packed ring only devices clarification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Maxime Coquelin <maxime.coquelin@redhat.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/1/29 =E4=B8=8B=E5=8D=885:14, Maxime Coquelin wrote:
>
> On 1/29/21 10:04 AM, Jason Wang wrote:
>> On 2021/1/29 =E4=B8=8B=E5=8D=884:38, Maxime Coquelin wrote:
>>> Hello,
>>>
>>> In the Virtqueues section of the Virtio specification [0], it is
>>> mentioned that:
>>>
>>> "
>>> Every driver and device supports either the Packed or the Split
>>> Virtqueue format, or both.
>>> "
>>>
>>> However, it seems there is no way to differentiate whether the device
>>> supports both split and packed ring, or only packed ring by reading
>>> its features bits.
>>>
>>> In the case of live-migration, it means we would need to trigger a
>>> features negotiation before the migration is initiated, and see if
>>> FEATURES_OK device status bit is set. Still, we could not be sure a
>>> failure would be due to the device supporting only packed ring.
>>>
>>> Is my understanding correct?
>>
>> Yes, I think so.
>>
>>
>>> If so, maybe we would need to introduce a new feature bit for split
>>> ring, and also a feature bit indicating compliance with the new spec
>>> version for backward compatibility:
>>>
>>> VIRTIO_F_VERSION_1_2(39):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 This indicates compliance with Virtio version=
 1.2 specification.
>>>
>>> VIRTIO_F_RING_SPLIT(40):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 This feature indicates support for the split =
virtqueue layout as
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 described in 2.6 Split Virtqueues.
>>
>> A question here, do we want to fix this issues with old driver (when
>> both of the above are not negotiated)?
> Could you elaborate please? I am not sure to understand your question.


I meant it looks to me we can't avoid the feature pre-negotiation, if we=20
migrate to an elder qemu?


>
> For existing devices only supporting packed ring (if it exists, I don't
> know any for now),


Spec doesn't forbid that so I guess there would be some hardware=20
implementation will do packed only.


>   maybe their drivers could have a quirk adding above
> features.


It won't be easy consider there will be a software updating in the guest.


>   If we do that, we may want to rename VIRTIO_F_VERSION_1_2 with
> something else to restrict it to rings layout support.


This looks like a common issue which is not packed specific, it might=20
happen when destination mandate some features but src doesn't (e.g=20
VIRTIO_F_ACCESS_PLATFORM).

Maybe it's the time to introduce an API in the spec to know the features=20
that is forced by the device.

Thanks


>
> Thanks,
> Maxime
>
>> Thanks
>>
>>
>>>
>>> Best regards,
>>> Maxime
>>>
>>> [0]:
>>> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-cspr=
d01.html#x1-230005
>>>
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

