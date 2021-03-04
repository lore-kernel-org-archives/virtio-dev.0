Return-Path: virtio-dev-return-8097-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9A179864C7
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Mar 2021 08:24:36 +0000 (UTC)
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
 <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
 <20210303092905.677eb66c.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b5b3f9b-41d7-795c-c677-c45f1d5a774e@redhat.com>
Date: Thu, 4 Mar 2021 16:24:16 +0800
MIME-Version: 1.0
In-Reply-To: <20210303092905.677eb66c.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/3/3 4:29 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
> On Wed, 3 Mar 2021 12:01:01 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2021/3/2 8:08 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
>>> On Mon, 1 Mar 2021 11:51:08 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>  =20
>>>> On 2021/3/1 5:25 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
>>>>> On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:
>>>>>> On 2021/2/26 2:53 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
>>>>>>> Confused. What is wrong with the above? It never reads the
>>>>>>> field unless the feature has been offered by device.
>>>>>> So the spec said:
>>>>>>
>>>>>> "
>>>>>>
>>>>>> The following driver-read-only field, max_virtqueue_pairs only exist=
s if
>>>>>> VIRTIO_NET_F_MQ is set.
>>>>>>
>>>>>> "
>>>>>>
>>>>>> If I read this correctly, there will be no max_virtqueue_pairs field=
 if the
>>>>>> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() viol=
ates
>>>>>> what spec said.
>>>>>>
>>>>>> Thanks
>>>>> I think that's a misunderstanding. This text was never intended to
>>>>> imply that field offsets change beased on feature bits.
>>>>> We had this pain with legacy and we never wanted to go back there.
>>>>>
>>>>> This merely implies that without VIRTIO_NET_F_MQ the field
>>>>> should not be accessed. Exists in the sense "is accessible to driver"=
.
>>>>>
>>>>> Let's just clarify that in the spec, job done.
>>>> Ok, agree. That will make things more eaiser.
>>> Yes, that makes much more sense.
>>>
>>> What about adding the following to the "Basic Facilities of a Virtio
>>> Device/Device Configuration Space" section of the spec:
>>>
>>> "If an optional configuration field does not exist, the corresponding
>>> space is still present, but reserved."
>>
>> This became interesting after re-reading some of the qemu codes.
>>
>> E.g in virtio-net.c we had:
>>
>> *static VirtIOFeature feature_sizes[] =3D {
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, mac)=
},
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_STATUS,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, stat=
us)},
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MQ,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, max_=
virtqueue_pairs)},
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_MTU,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, mtu)=
},
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, dupl=
ex)},
>>   =C2=A0=C2=A0=C2=A0 {.flags =3D (1ULL << VIRTIO_NET_F_RSS) | (1ULL <<
>> VIRTIO_NET_F_HASH_REPORT),
>>   =C2=A0=C2=A0=C2=A0=C2=A0 .end =3D endof(struct virtio_net_config, supp=
orted_hash_types)},
>>   =C2=A0=C2=A0=C2=A0 {}
>> };*
>>
>> *It has a implict dependency chain. E.g MTU doesn't presnet if
>> DUPLEX/RSS is not offered ...
>> *
> But I think it covers everything up to the relevant field, no? So MTU
> is included if we have the feature bit, even if we don't have
> DUPLEX/RSS.
>
> Given that a config space may be shorter (but must not collapse
> non-existing fields), maybe a better wording would be:
>
> "If an optional configuration field does not exist, the corresponding
> space will still be present if it is not at the end of the
> configuration space (i.e., further configuration fields exist.)


This should work but I think we need to define the end of configuration=20
space first?


> This
> implies that a given field, if it exists, is always at the same offset
> from the beginning of the configuration space."
>
>
>>> (Do we need to specify what a device needs to do if the driver tries to
>>> access a non-existing field? We cannot really make assumptions about
>>> config space accesses; virtio-ccw can just copy a chunk of config space
>>> that contains non-existing fields...
>>
>> Right, it looks to me ccw doesn't depends on config len which is kind of
>> interesting. I think the answer depends on the implementation of both
>> transport and device:
> (virtio-ccw is a bit odd, because channel I/O does not have the concept
> of a config space and I needed to come up with something)


Ok.


>
>> Let's take virtio-net-pci as an example, it fills status unconditionally
>> in virtio_net_set_config() even if VIRTIO_NET_F_STATUS is not
>> negotiated. So with the above feature_sizes:
>>
>> 1) if one of the MQ, MTU, DUPLEX or RSS is implemented, driver can still
>> read status in this case
>> 2) if none of the above four is negotied, driver can only read a 0xFF
>> (virtio_config_readb())
>>
>>
>>> I guess the device could ignore
>>> writes and return zeroes on read?)
>>
>> So consider the above, it might be too late to fix/clarify that in the
>> spec on the expected behaviour of reading/writing non-exist fields.
> We could still advise behaviour via SHOULD, though I'm not sure it adds
> much at this point in time.
>
> It really feels a bit odd that a driver can still read and write fields
> for features that it did not negotiate, but I fear we're stuck with it.


Yes, since the device (at least virtio-pci) implment thing like this.

Thanks


>
>> Thanks
>>
>>
>>> I've opened https://github.com/oasis-tcs/virtio-spec/issues/98 for the
>>> spec issues.
>>>  =20
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

