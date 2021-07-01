Return-Path: <virtio-dev-return-8217-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FC9F9862CF
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:43:12 +0000 (UTC)
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-15-cristian.marussi@arm.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <ccc64935-08fa-d1a3-fc21-227c9d05fe24@opensynergy.com>
Date: Thu, 1 Jul 2021 10:43:07 +0200
In-Reply-To: <20210611165937.701-15-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 14/16] firmware: arm_scmi: Add virtio transport
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.21 18:59, Cristian Marussi wrote:

<snip>

> +static struct virtio_driver virtio_scmi_driver =3D {
> +=09.driver.name =3D "scmi-virtio",
> +=09.driver.owner =3D THIS_MODULE,
> +=09.feature_table =3D features,
> +=09.feature_table_size =3D ARRAY_SIZE(features),
> +=09.id_table =3D id_table,
> +=09.probe =3D scmi_vio_probe,
> +=09.remove =3D scmi_vio_remove,
> +};
> +

It might be good to also check for the VIRTIO_F_VERSION_1 feature bit in=20
the optional .validate op (not yet implemented above), as some other=20
devices do (quoting virtio-snd in the following):

> /**
>  * virtsnd_validate() - Validate if the device can be started.
>  * @vdev: VirtIO parent device.
>  *
>  * Context: Any context.
>  * Return: 0 on success, -EINVAL on failure.
>  */
> static int virtsnd_validate(struct virtio_device *vdev)
> {

<snip>

>=20
> =09if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> =09=09dev_err(&vdev->dev,
> =09=09=09"device does not comply with spec version 1.x\n");
> =09=09return -EINVAL;
> =09}
>=20

<snip>

>=20
> static struct virtio_driver virtsnd_driver =3D {
> =09.driver.name =3D KBUILD_MODNAME,
> =09.driver.owner =3D THIS_MODULE,
> =09.id_table =3D id_table,
> =09.validate =3D virtsnd_validate,

(end of virtio-snd quote)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

