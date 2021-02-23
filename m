Return-Path: virtio-dev-return-8024-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A0CC986027
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Feb 2021 10:18:01 +0000 (UTC)
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223045600-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c188353e-9aca-a94c-e8f5-4bad5942481c@redhat.com>
Date: Tue, 23 Feb 2021 18:17:49 +0800
MIME-Version: 1.0
In-Reply-To: <20210223045600-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2021/2/23 6:01 =E4=B8=8B=E5=8D=88, Michael S. Tsirkin wrote:
> On Tue, Feb 23, 2021 at 05:46:20PM +0800, Jason Wang wrote:
>> On 2021/2/23 =E4=B8=8B=E5=8D=885:25, Michael S. Tsirkin wrote:
>>> On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
>>>> On 2/21/2021 8:14 PM, Jason Wang wrote:
>>>>> On 2021/2/19 7:54 =E4=B8=8B=E5=8D=88, Si-Wei Liu wrote:
>>>>>> Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
>>>>>> for legacy") made an exception for legacy guests to reset
>>>>>> features to 0, when config space is accessed before features
>>>>>> are set. We should relieve the verify_min_features() check
>>>>>> and allow features reset to 0 for this case.
>>>>>>
>>>>>> It's worth noting that not just legacy guests could access
>>>>>> config space before features are set. For instance, when
>>>>>> feature VIRTIO_NET_F_MTU is advertised some modern driver
>>>>>> will try to access and validate the MTU present in the config
>>>>>> space before virtio features are set.
>>>>> This looks like a spec violation:
>>>>>
>>>>> "
>>>>>
>>>>> The following driver-read-only field, mtu only exists if
>>>>> VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the
>>>>> driver to use.
>>>>> "
>>>>>
>>>>> Do we really want to workaround this?
>>>> Isn't the commit 452639a64ad8 itself is a workaround for legacy guest?
>>>>
>>>> I think the point is, since there's legacy guest we'd have to support,=
 this
>>>> host side workaround is unavoidable. Although I agree the violating dr=
iver
>>>> should be fixed (yes, it's in today's upstream kernel which exists for=
 a
>>>> while now).
>>> Oh  you are right:
>>>
>>>
>>> static int virtnet_validate(struct virtio_device *vdev)
>>> {
>>>           if (!vdev->config->get) {
>>>                   dev_err(&vdev->dev, "%s failure: config access disabl=
ed\n",
>>>                           __func__);
>>>                   return -EINVAL;
>>>           }
>>>
>>>           if (!virtnet_validate_features(vdev))
>>>                   return -EINVAL;
>>>
>>>           if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
>>>                   int mtu =3D virtio_cread16(vdev,
>>>                                            offsetof(struct virtio_net_c=
onfig,
>>>                                                     mtu));
>>>                   if (mtu < MIN_MTU)
>>>                           __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
>>
>> I wonder why not simply fail here?
> Back in 2016 it went like this:
>
> =09On Thu, Jun 02, 2016 at 05:10:59PM -0400, Aaron Conole wrote:
> =09> +     if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> =09> +             dev->mtu =3D virtio_cread16(vdev,
> =09> +                                       offsetof(struct virtio_net_c=
onfig,
> =09> +                                                mtu));
> =09> +     }
> =09> +
> =09>       if (vi->any_header_sg)
> =09>               dev->needed_headroom =3D vi->hdr_len;
> =09>
>
> =09One comment though: I think we should validate the mtu.
> =09If it's invalid, clear VIRTIO_NET_F_MTU and ignore.
>
>
> Too late at this point :)
>
> I guess it's a way to tell device "I can not live with this MTU",
> device can fail FEATURES_OK if it wants to. MIN_MTU
> is an internal linux thing and at the time I felt it's better to
> try to make progress.


What if e.g the device advertise a large MTU. E.g 64K here? In that=20
case, the driver can not live either. Clearing MTU won't help here.

Thanks


>
>
>>>           }
>>>
>>>           return 0;
>>> }
>>>
>>> And the spec says:
>>>
>>>
>>> The driver MUST follow this sequence to initialize a device:
>>> 1. Reset the device.
>>> 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
>>> 3. Set the DRIVER status bit: the guest OS knows how to drive the devic=
e.
>>> 4. Read device feature bits, and write the subset of feature bits under=
stood by the OS and driver to the
>>> device. During this step the driver MAY read (but MUST NOT write) the d=
evice-specific configuration
>>> fields to check that it can support the device before accepting it.
>>> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new featu=
re bits after this step.
>>> 6. Re-read device status to ensure the FEATURES_OK bit is still set: ot=
herwise, the device does not
>>> support our subset of features and the device is unusable.
>>> 7. Perform device-specific setup, including discovery of virtqueues for=
 the device, optional per-bus setup,
>>> reading and possibly writing the device=E2=80=99s virtio configuration =
space, and population of virtqueues.
>>> 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cl=
ive=E2=80=9D.
>>>
>>>
>>> Item 4 on the list explicitly allows reading config space before
>>> FEATURES_OK.
>>>
>>> I conclude that VIRTIO_NET_F_MTU is set means "set in device features".
>>
>> So this probably need some clarification. "is set" is used many times in=
 the
>> spec that has different implications.
>>
>> Thanks
>>
>>
>>> Generally it is worth going over feature dependent config fields
>>> and checking whether they should be present when device feature is set
>>> or when feature bit has been negotiated, and making this clear.
>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

