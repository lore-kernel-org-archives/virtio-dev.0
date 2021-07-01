Return-Path: <virtio-dev-return-8213-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 303239862C0
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:42:49 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-2-cristian.marussi@arm.com>
Message-ID: <cb24778e-60fd-4582-c855-238d71319067@opensynergy.com>
Date: Thu, 1 Jul 2021 10:42:40 +0200
In-Reply-To: <20210611165937.701-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 01/16] firmware: arm_scmi: Fix max pending messages
 boundary check
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Cristian,

please find some remarks to the patch series in this email and the=20
following.

On 11.06.21 18:59, Cristian Marussi wrote:
> SCMI message headers carry a sequence number and such field is sized to
> allow for MSG_TOKEN_MAX distinct numbers; moreover zero is not really an
> acceptable maximum number of pending in-flight messages.
>=20
> Fix accordignly the checks performed on the value exported by transports
> in scmi_desc.max_msg.
>=20
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: aa4f886f3893 ("firmware: arm_scmi: add basic driver infrastructure=
 for SCMI")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index 66e5e694be7d..6713b259f1e6 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1025,8 +1025,9 @@ static int __scmi_xfer_info_init(struct scmi_info *=
sinfo,
>  =09const struct scmi_desc *desc =3D sinfo->desc;
> =20
>  =09/* Pre-allocated messages, no more than what hdr.seq can support */
> -=09if (WARN_ON(desc->max_msg >=3D MSG_TOKEN_MAX)) {
> -=09=09dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
> +=09if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
> +=09=09dev_err(dev,
> +=09=09=09"Invalid max_msg %d. Maximum messages supported %ld.\n",

%ld -> %lu

>  =09=09=09desc->max_msg, MSG_TOKEN_MAX);
>  =09=09return -EINVAL;
>  =09}
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

