Return-Path: <virtio-dev-return-8295-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A967B9864C5
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 16:36:14 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-11-cristian.marussi@arm.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <4ad5a421-d9ab-816f-b721-9f88ffabfb39@opensynergy.com>
Date: Thu, 15 Jul 2021 18:36:10 +0200
In-Reply-To: <20210712141833.6628-11-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.07.21 16:18, Cristian Marussi wrote:
> Add a check for the presence of .poll_done transport operation so that
> transports that do not need to support polling mode have no need to provi=
de
> a dummy .poll_done callback either and polling mode can be disabled in th=
e
> SCMI core for that tranport.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index a952b6527b8a..4183d25c9289 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handl=
e *ph,
>   =09}
>  =20
>   =09if (xfer->hdr.poll_completion) {
> -=09=09ktime_t stop =3D ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> -
> -=09=09spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> -
> -=09=09if (ktime_before(ktime_get(), stop)) {
> -=09=09=09unsigned long flags;
> -
> -=09=09=09/*
> -=09=09=09 * Do not fetch_response if an out-of-order delayed
> -=09=09=09 * response is being processed.
> -=09=09=09 */
> -=09=09=09spin_lock_irqsave(&xfer->lock, flags);
> -=09=09=09if (xfer->state =3D=3D SCMI_XFER_SENT_OK) {
> -=09=09=09=09info->desc->ops->fetch_response(cinfo, xfer);
> -=09=09=09=09xfer->state =3D SCMI_XFER_RESP_OK;
> +=09=09if (info->desc->ops->poll_done) {
> +=09=09=09ktime_t stop =3D ktime_add_ns(ktime_get(),
> +=09=09=09=09=09=09    SCMI_MAX_POLL_TO_NS);
> +
> +=09=09=09spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
> +=09=09=09=09=09=09=09=09  stop));
> +
> +=09=09=09if (ktime_before(ktime_get(), stop)) {
> +=09=09=09=09unsigned long flags;
> +
> +=09=09=09=09/*
> +=09=09=09=09 * Do not fetch_response if an out-of-order delayed
> +=09=09=09=09 * response is being processed.
> +=09=09=09=09 */
> +=09=09=09=09spin_lock_irqsave(&xfer->lock, flags);
> +=09=09=09=09if (xfer->state =3D=3D SCMI_XFER_SENT_OK) {
> +=09=09=09=09=09info->desc->ops->fetch_response(cinfo,
> +=09=09=09=09=09=09=09=09=09xfer);
> +=09=09=09=09=09xfer->state =3D SCMI_XFER_RESP_OK;
> +=09=09=09=09}
> +=09=09=09=09spin_unlock_irqrestore(&xfer->lock, flags);
> +=09=09=09} else {
> +=09=09=09=09ret =3D -ETIMEDOUT;
>   =09=09=09}
> -=09=09=09spin_unlock_irqrestore(&xfer->lock, flags);
>   =09=09} else {
> -=09=09=09ret =3D -ETIMEDOUT;
> +=09=09=09dev_warn_once(dev,
> +=09=09=09=09      "Polling mode is not supported by transport.\n");
> +=09=09=09ret =3D EINVAL;

s/EINVAL/-EINVAL

>   =09=09}
>   =09} else {
>   =09=09/* And we wait for the response. */
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

