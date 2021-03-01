Return-Path: virtio-dev-return-8063-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7478985A84
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 03:51:22 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
Date: Mon, 1 Mar 2021 11:51:08 +0800
MIME-Version: 1.0
In-Reply-To: <20210228162306-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/3/1 5:25 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
> On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:
>> On 2021/2/26 2:53 =E4=B8=8A=E5=8D=88, Michael S. Tsirkin wrote:
>>> On Thu, Feb 25, 2021 at 12:36:07PM +0800, Jason Wang wrote:
>>>> On 2021/2/24 7:12 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
>>>>> On Wed, 24 Feb 2021 17:29:07 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>>> On 2021/2/23 6:58 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
>>>>>>> On Tue, 23 Feb 2021 18:31:07 +0800
>>>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>> On 2021/2/23 6:04 =E4=B8=8B=E5=8D=88, Cornelia Huck wrote:
>>>>>>>>> On Tue, 23 Feb 2021 17:46:20 +0800
>>>>>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>> On 2021/2/23 =E4=B8=8B=E5=8D=885:25, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
>>>>>>>>>>>> On 2/21/2021 8:14 PM, Jason Wang wrote:
>>>>>>>>>>>>> On 2021/2/19 7:54 =E4=B8=8B=E5=8D=88, Si-Wei Liu wrote:
>>>>>>>>>>>>>> Commit 452639a64ad8 ("vdpa: make sure set_features is invoke=
d
>>>>>>>>>>>>>> for legacy") made an exception for legacy guests to reset
>>>>>>>>>>>>>> features to 0, when config space is accessed before features
>>>>>>>>>>>>>> are set. We should relieve the verify_min_features() check
>>>>>>>>>>>>>> and allow features reset to 0 for this case.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It's worth noting that not just legacy guests could access
>>>>>>>>>>>>>> config space before features are set. For instance, when
>>>>>>>>>>>>>> feature VIRTIO_NET_F_MTU is advertised some modern driver
>>>>>>>>>>>>>> will try to access and validate the MTU present in the confi=
g
>>>>>>>>>>>>>> space before virtio features are set.
>>>>>>>>>>>>> This looks like a spec violation:
>>>>>>>>>>>>>
>>>>>>>>>>>>> "
>>>>>>>>>>>>>
>>>>>>>>>>>>> The following driver-read-only field, mtu only exists if
>>>>>>>>>>>>> VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU=
 for the
>>>>>>>>>>>>> driver to use.
>>>>>>>>>>>>> "
>>>>>>>>>>>>>
>>>>>>>>>>>>> Do we really want to workaround this?
>>>>>>>>>>>> Isn't the commit 452639a64ad8 itself is a workaround for legac=
y guest?
>>>>>>>>>>>>
>>>>>>>>>>>> I think the point is, since there's legacy guest we'd have to =
support, this
>>>>>>>>>>>> host side workaround is unavoidable. Although I agree the viol=
ating driver
>>>>>>>>>>>> should be fixed (yes, it's in today's upstream kernel which ex=
ists for a
>>>>>>>>>>>> while now).
>>>>>>>>>>> Oh  you are right:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> static int virtnet_validate(struct virtio_device *vdev)
>>>>>>>>>>> {
>>>>>>>>>>>               if (!vdev->config->get) {
>>>>>>>>>>>                       dev_err(&vdev->dev, "%s failure: config a=
ccess disabled\n",
>>>>>>>>>>>                               __func__);
>>>>>>>>>>>                       return -EINVAL;
>>>>>>>>>>>               }
>>>>>>>>>>>
>>>>>>>>>>>               if (!virtnet_validate_features(vdev))
>>>>>>>>>>>                       return -EINVAL;
>>>>>>>>>>>
>>>>>>>>>>>               if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
>>>>>>>>>>>                       int mtu =3D virtio_cread16(vdev,
>>>>>>>>>>>                                                offsetof(struct =
virtio_net_config,
>>>>>>>>>>>                                                         mtu));
>>>>>>>>>>>                       if (mtu < MIN_MTU)
>>>>>>>>>>>                               __virtio_clear_bit(vdev, VIRTIO_N=
ET_F_MTU);
>>>>>>>>>> I wonder why not simply fail here?
>>>>>>>>> I think both failing or not accepting the feature can be argued t=
o make
>>>>>>>>> sense: "the device presented us with a mtu size that does not mak=
e
>>>>>>>>> sense" would point to failing, "we cannot work with the mtu size =
that
>>>>>>>>> the device presented us" would point to not negotiating the featu=
re.
>>>>>>>>>>>               }
>>>>>>>>>>>
>>>>>>>>>>>               return 0;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> And the spec says:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The driver MUST follow this sequence to initialize a device:
>>>>>>>>>>> 1. Reset the device.
>>>>>>>>>>> 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the=
 device.
>>>>>>>>>>> 3. Set the DRIVER status bit: the guest OS knows how to drive t=
he device.
>>>>>>>>>>> 4. Read device feature bits, and write the subset of feature bi=
ts understood by the OS and driver to the
>>>>>>>>>>> device. During this step the driver MAY read (but MUST NOT writ=
e) the device-specific configuration
>>>>>>>>>>> fields to check that it can support the device before accepting=
 it.
>>>>>>>>>>> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept n=
ew feature bits after this step.
>>>>>>>>>>> 6. Re-read device status to ensure the FEATURES_OK bit is still=
 set: otherwise, the device does not
>>>>>>>>>>> support our subset of features and the device is unusable.
>>>>>>>>>>> 7. Perform device-specific setup, including discovery of virtqu=
eues for the device, optional per-bus setup,
>>>>>>>>>>> reading and possibly writing the device=E2=80=99s virtio config=
uration space, and population of virtqueues.
>>>>>>>>>>> 8. Set the DRIVER_OK status bit. At this point the device is =
=E2=80=9Clive=E2=80=9D.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Item 4 on the list explicitly allows reading config space befor=
e
>>>>>>>>>>> FEATURES_OK.
>>>>>>>>>>>
>>>>>>>>>>> I conclude that VIRTIO_NET_F_MTU is set means "set in device fe=
atures".
>>>>>>>>>> So this probably need some clarification. "is set" is used many =
times in
>>>>>>>>>> the spec that has different implications.
>>>>>>>>> Before FEATURES_OK is set by the driver, I guess it means "the de=
vice
>>>>>>>>> has offered the feature";
>>>>>>>> For me this part is ok since it clarify that it's the driver that =
set
>>>>>>>> the bit.
>>>>>>>>
>>>>>>>>
>>>>>>>>> during normal usage, it means "the feature
>>>>>>>>> has been negotiated".
>>>>>>>> /?
>>>>>>>>
>>>>>>>> It looks to me the feature negotiation is done only after device s=
et
>>>>>>>> FEATURES_OK, or FEATURES_OK could be read from device status?
>>>>>>> I'd consider feature negotiation done when the driver reads FEATURE=
S_OK
>>>>>>> back from the status.
>>>>>> I agree.
>>>>>>
>>>>>>
>>>>>>>>>       (This is a bit fuzzy for legacy mode.)
>>>>>>> ...because legacy does not have FEATURES_OK.
>>>>>>>> The problem is the MTU description for example:
>>>>>>>>
>>>>>>>> "The following driver-read-only field, mtu only exists if
>>>>>>>> VIRTIO_NET_F_MTU is set."
>>>>>>>>
>>>>>>>> It looks to me need to use "if VIRTIO_NET_F_MTU is set by device".
>>>>>>> "offered by the device"? I don't think it should 'disappear' from t=
he
>>>>>>> config space if the driver won't use it. (Same for other config spa=
ce
>>>>>>> fields that are tied to feature bits.)
>>>>>> But what happens if e.g device doesn't offer VIRTIO_NET_F_MTU? It lo=
oks
>>>>>> to according to the spec there will be no mtu field.
>>>>> I think so, yes.
>>>>>
>>>>>> And a more interesting case is VIRTIO_NET_F_MQ is not offered but
>>>>>> VIRTIO_NET_F_MTU offered. To me, it means we don't have
>>>>>> max_virtqueue_pairs but it's not how the driver is wrote today.
>>>>> That would be a bug, but it seems to me that the virtio-net driver
>>>>> reads max_virtqueue_pairs conditionally and handles absence of the
>>>>> feature correctly?
>>>> Yes, see the avove codes:
>>>>
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_has_feature(vd=
ev, VIRTIO_NET_F_MTU)) {
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int mtu =3D virtio_cread16(vdev,
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct virtio_net_config,
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mtu));
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (mtu < MIN_MTU)
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __=
virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> So it's probably too late to fix the driver.
>>>>
>>> Confused. What is wrong with the above? It never reads the
>>> field unless the feature has been offered by device.
>>
>> So the spec said:
>>
>> "
>>
>> The following driver-read-only field, max_virtqueue_pairs only exists if
>> VIRTIO_NET_F_MQ is set.
>>
>> "
>>
>> If I read this correctly, there will be no max_virtqueue_pairs field if =
the
>> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violates
>> what spec said.
>>
>> Thanks
> I think that's a misunderstanding. This text was never intended to
> imply that field offsets change beased on feature bits.
> We had this pain with legacy and we never wanted to go back there.
>
> This merely implies that without VIRTIO_NET_F_MQ the field
> should not be accessed. Exists in the sense "is accessible to driver".
>
> Let's just clarify that in the spec, job done.


Ok, agree. That will make things more eaiser.

Thanks


>
>
>
>
>>>
>>>>>>>> Otherwise readers (at least for me), may think the MTU is only val=
id
>>>>>>>> if driver set the bit.
>>>>>>> I think it would still be 'valid' in the sense that it exists and h=
as
>>>>>>> some value in there filled in by the device, but a driver reading i=
t
>>>>>>> without negotiating the feature would be buggy. (Like in the kernel
>>>>>>> code above; the kernel not liking the value does not make the field
>>>>>>> invalid.)
>>>>>> See Michael's reply, the spec allows read the config before setting
>>>>>> features.
>>>>> Yes, the period prior to finishing negotiation is obviously special.
>>>>>
>>>>>>> Maybe a statement covering everything would be:
>>>>>>>
>>>>>>> "The following driver-read-only field mtu only exists if the device
>>>>>>> offers VIRTIO_NET_F_MTU and may be read by the driver during featur=
e
>>>>>>> negotiation and after VIRTIO_NET_F_MTU has been successfully
>>>>>>> negotiated."
>>>>>>>>> Should we add a wording clarification to the spec?
>>>>>>>> I think so.
>>>>>>> Some clarification would be needed for each field that depends on a
>>>>>>> feature; that would be quite verbose. Maybe we can get away with a
>>>>>>> clarifying statement?
>>>>>>>
>>>>>>> "Some config space fields may depend on a certain feature. In that
>>>>>>> case, the field exits if the device has offered the corresponding
>>>>>>> feature,
>>>>>> So this implies for !VIRTIO_NET_F_MQ && VIRTIO_NET_F_MTU, the config
>>>>>> will look like:
>>>>>>
>>>>>> struct virtio_net_config {
>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 mac[6];
>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 status;
>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 mtu;
>>>>>> };
>>>>>>
>>>>> I agree.
>>>> So consider it's probably too late to fix the driver which assumes som=
e
>>>> field are always persent, it looks to me need fix the spec do declare =
the
>>>> fields are always existing instead.
>>>>
>>>>
>>>>>>>      and may be read by the driver during feature negotiation, and
>>>>>>> accessed by the driver after the feature has been successfully
>>>>>>> negotiated. A shorthand for this is a statement that a field only
>>>>>>> exists if a certain feature bit is set."
>>>>>> I'm not sure using "shorthand" is good for the spec, at least we can
>>>>>> limit the its scope only to the configuration space part.
>>>>> Maybe "a shorthand expression"?
>>>> So the questions is should we use this for all over the spec or it wil=
l be
>>>> only used in this speicifc part (device configuration).
>>>>
>>>> Thanks
>>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

