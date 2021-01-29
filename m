Return-Path: virtio-dev-return-7963-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4583D986585
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jan 2021 09:14:46 +0000 (UTC)
References: <875d1495-9511-4b5d-062c-2063ee9bed7e@redhat.com>
 <2be31437-a43c-39f6-1253-d9dd17e87823@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <49d2649b-7f46-b2af-2c14-e903bdd25163@redhat.com>
Date: Fri, 29 Jan 2021 10:14:32 +0100
MIME-Version: 1.0
In-Reply-To: <2be31437-a43c-39f6-1253-d9dd17e87823@redhat.com>
Subject: Re: [virtio-dev] Packed ring only devices clarification
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 1/29/21 10:04 AM, Jason Wang wrote:
>=20
> On 2021/1/29 =E4=B8=8B=E5=8D=884:38, Maxime Coquelin wrote:
>> Hello,
>>
>> In the Virtqueues section of the Virtio specification [0], it is
>> mentioned that:
>>
>> "
>> Every driver and device supports either the Packed or the Split
>> Virtqueue format, or both.
>> "
>>
>> However, it seems there is no way to differentiate whether the device
>> supports both split and packed ring, or only packed ring by reading
>> its features bits.
>>
>> In the case of live-migration, it means we would need to trigger a
>> features negotiation before the migration is initiated, and see if
>> FEATURES_OK device status bit is set. Still, we could not be sure a
>> failure would be due to the device supporting only packed ring.
>>
>> Is my understanding correct?
>=20
>=20
> Yes, I think so.
>=20
>=20
>>
>> If so, maybe we would need to introduce a new feature bit for split
>> ring, and also a feature bit indicating compliance with the new spec
>> version for backward compatibility:
>>
>> VIRTIO_F_VERSION_1_2(39):
>> =C2=A0=C2=A0=C2=A0=C2=A0 This indicates compliance with Virtio version 1=
.2 specification.
>>
>> VIRTIO_F_RING_SPLIT(40):
>> =C2=A0=C2=A0=C2=A0=C2=A0 This feature indicates support for the split vi=
rtqueue layout as
>> =C2=A0=C2=A0=C2=A0=C2=A0 described in 2.6 Split Virtqueues.
>=20
>=20
> A question here, do we want to fix this issues with old driver (when
> both of the above are not negotiated)?

Could you elaborate please? I am not sure to understand your question.

For existing devices only supporting packed ring (if it exists, I don't
know any for now), maybe their drivers could have a quirk adding above
features. If we do that, we may want to rename VIRTIO_F_VERSION_1_2 with
something else to restrict it to rings layout support.

Thanks,
Maxime

> Thanks
>=20
>=20
>>
>>
>> Best regards,
>> Maxime
>>
>> [0]:
>> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd=
01.html#x1-230005
>>
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

