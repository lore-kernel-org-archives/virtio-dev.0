Return-Path: <virtio-dev-return-8294-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3F5E9864BC
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 16:36:09 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <a163653c-51f9-adf0-c978-b747ddf2498a@opensynergy.com>
Date: Thu, 15 Jul 2021 18:36:03 +0200
In-Reply-To: <20210712141833.6628-8-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12.07.21 16:18, Cristian Marussi wrote:
> Even though in case of asynchronous commands an SCMI platform server is
> constrained to emit the delayed response message only after the related
> message response has been sent, the configured underlying transport could
> still deliver such messages together or in inverted order, causing races
> due to the concurrent or out-of-order access to the underlying xfer.
>=20
> Introduce a mechanism to grant exclusive access to an xfer in order to
> properly serialize concurrent accesses to the same xfer originating from
> multiple correlated messages.
>=20
> Add additional state information to xfer descriptors so as to be able to
> identify out-of-order message deliveries and act accordingly:
>=20
>   - when a delayed response is expected but delivered before the related
>     response, the synchronous response is considered as successfully
>     received and the delayed response processing is carried on as usual.
>=20
>   - when/if the missing synchronous response is subsequently received, it
>     is discarded as not congruent with the current state of the xfer, or
>     simply, because the xfer has been already released and so, now, the
>     monotonically increasing sequence number carried by the late response
>     is stale.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v5 --> v6
> - added spinlock comment
> ---
>   drivers/firmware/arm_scmi/common.h |  18 ++-
>   drivers/firmware/arm_scmi/driver.c | 229 ++++++++++++++++++++++++-----
>   2 files changed, 212 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index 2233d0a188fc..9efebe1406d2 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -19,6 +19,7 @@
>   #include <linux/module.h>
>   #include <linux/refcount.h>
>   #include <linux/scmi_protocol.h>
> +#include <linux/spinlock.h>
>   #include <linux/types.h>
>  =20
>   #include <asm/unaligned.h>
> @@ -145,6 +146,13 @@ struct scmi_msg {
>    * @pending: True for xfers added to @pending_xfers hashtable
>    * @node: An hlist_node reference used to store this xfer, alternativel=
y, on
>    *=09  the free list @free_xfers or in the @pending_xfers hashtable
> + * @busy: An atomic flag to ensure exclusive write access to this xfer
> + * @state: The current state of this transfer, with states transitions d=
eemed
> + *=09   valid being:
> + *=09    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_O=
K ]
> + *=09    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
> + *=09      (Missing synchronous response is assumed OK and ignored)
> + * @lock: A spinlock to protect state and busy fields.
>    */
>   struct scmi_xfer {
>   =09int transfer_id;
> @@ -156,6 +164,15 @@ struct scmi_xfer {
>   =09refcount_t users;
>   =09bool pending;
>   =09struct hlist_node node;
> +#define SCMI_XFER_FREE=09=090
> +#define SCMI_XFER_BUSY=09=091
> +=09atomic_t busy;
> +#define SCMI_XFER_SENT_OK=090
> +#define SCMI_XFER_RESP_OK=091
> +#define SCMI_XFER_DRESP_OK=092
> +=09int state;
> +=09/* A lock to protect state and busy fields */
> +=09spinlock_t lock;
>   };
>  =20
>   /*
> @@ -392,5 +409,4 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *=
shmem,
>   void scmi_notification_instance_data_set(const struct scmi_handle *hand=
le,
>   =09=09=09=09=09 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *han=
dle);
> -
>   #endif /* _SCMI_COMMON_H */
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index 245ede223302..5ef33d692670 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -369,6 +369,7 @@ static struct scmi_xfer *scmi_xfer_get(const struct s=
cmi_handle *handle,
>  =20
>   =09if (!IS_ERR(xfer)) {
>   =09=09refcount_set(&xfer->users, 1);
> +=09=09atomic_set(&xfer->busy, SCMI_XFER_FREE);
>   =09=09xfer->transfer_id =3D atomic_inc_return(&transfer_last_id);
>   =09}
>   =09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> @@ -430,6 +431,168 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *m=
info, u16 xfer_id)
>   =09return xfer ?: ERR_PTR(-EINVAL);
>   }
>  =20
> +/**
> + * scmi_msg_response_validate  - Validate message type against state of =
related
> + * xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_type: Message type to check
> + * @xfer: A reference to the xfer to validate against @msg_type
> + *
> + * This function checks if @msg_type is congruent with the current state=
 of
> + * a pending @xfer; if an asynchronous delayed response is received befo=
re the
> + * related synchronous response (Out-of-Order Delayed Response) the miss=
ing
> + * synchronous response is assumed to be OK and completed, carrying on w=
ith the
> + * Delayed Response: this is done to address the case in which the under=
lying
> + * SCMI transport can deliver such out-of-order responses.
> + *
> + * Context: Assumes to be called with xfer->lock already acquired.
> + *
> + * Return: 0 on Success, error otherwise
> + */
> +static inline int scmi_msg_response_validate(struct scmi_chan_info *cinf=
o,
> +=09=09=09=09=09     u8 msg_type,
> +=09=09=09=09=09     struct scmi_xfer *xfer)
> +{
> +=09/*
> +=09 * Even if a response was indeed expected on this slot at this point,
> +=09 * a buggy platform could wrongly reply feeding us an unexpected
> +=09 * delayed response we're not prepared to handle: bail-out safely
> +=09 * blaming firmware.
> +=09 */
> +=09if (msg_type =3D=3D MSG_TYPE_DELAYED_RESP && !xfer->async_done) {
> +=09=09dev_err(cinfo->dev,
> +=09=09=09"Delayed Response for %d not expected! Buggy F/W ?\n",
> +=09=09=09xfer->hdr.seq);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09switch (xfer->state) {
> +=09case SCMI_XFER_SENT_OK:
> +=09=09if (msg_type =3D=3D MSG_TYPE_DELAYED_RESP) {
> +=09=09=09/*
> +=09=09=09 * Delayed Response expected but delivered earlier.
> +=09=09=09 * Assume message RESPONSE was OK and skip state.
> +=09=09=09 */
> +=09=09=09xfer->hdr.status =3D SCMI_SUCCESS;
> +=09=09=09xfer->state =3D SCMI_XFER_RESP_OK;
> +=09=09=09complete(&xfer->done);
> +=09=09=09dev_warn(cinfo->dev,
> +=09=09=09=09 "Received valid OoO Delayed Response for %d\n",
> +=09=09=09=09 xfer->hdr.seq);
> +=09=09}
> +=09=09break;
> +=09case SCMI_XFER_RESP_OK:
> +=09=09if (msg_type !=3D MSG_TYPE_DELAYED_RESP)
> +=09=09=09return -EINVAL;
> +=09=09break;
> +=09case SCMI_XFER_DRESP_OK:
> +=09=09/* No further message expected once in SCMI_XFER_DRESP_OK */
> +=09=09return -EINVAL;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static bool scmi_xfer_is_free(struct scmi_xfer *xfer)
> +{
> +=09int ret;
> +
> +=09ret =3D atomic_cmpxchg(&xfer->busy, SCMI_XFER_FREE, SCMI_XFER_BUSY);

Naming: Rather unusual to change state in an _is_free() function,=20
looking at other _is_free() functions in the kernel.

> +
> +=09return ret =3D=3D SCMI_XFER_FREE;
> +}
> +
> +/**
> + * scmi_xfer_command_acquire  -  Helper to lookup and acquire a command =
xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_hdr: A message header to use as lookup key
> + *
> + * When a valid xfer is found for the sequence number embedded in the pr=
ovided
> + * msg_hdr, reference counting is properly updated and exclusive access =
to this
> + * xfer is granted till released with @scmi_xfer_command_release.
> + *
> + * Return: A valid @xfer on Success or error otherwise.
> + */
> +static inline struct scmi_xfer *
> +scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
> +{
> +=09int ret;
> +=09unsigned long flags;
> +=09struct scmi_xfer *xfer;
> +=09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
> +=09struct scmi_xfers_info *minfo =3D &info->tx_minfo;
> +=09u8 msg_type =3D MSG_XTRACT_TYPE(msg_hdr);
> +=09u16 xfer_id =3D MSG_XTRACT_TOKEN(msg_hdr);
> +
> +=09/* Are we even expecting this? */
> +=09spin_lock_irqsave(&minfo->xfer_lock, flags);
> +=09xfer =3D scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +=09if (IS_ERR(xfer)) {
> +=09=09dev_err(cinfo->dev,
> +=09=09=09"Message for %d type %d is not expected!\n",
> +=09=09=09xfer_id, msg_type);
> +=09=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +=09=09return xfer;
> +=09}
> +=09refcount_inc(&xfer->users);
> +=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +=09spin_lock_irqsave(&xfer->lock, flags);
> +=09ret =3D scmi_msg_response_validate(cinfo, msg_type, xfer);
> +=09/*
> +=09 * If a pending xfer was found which was also in a congruent state wi=
th
> +=09 * the received message, acquire exclusive access to it setting the b=
usy
> +=09 * flag.
> +=09 * Spins only on the rare limit condition of concurrent reception of
> +=09 * RESP and DRESP for the same xfer.
> +=09 */
> +=09if (!ret) {
> +=09=09spin_until_cond(scmi_xfer_is_free(xfer));

Maybe there should be an additional comment to indicate that the=20
xfer->lock cannot be reaquired later during response processing, to=20
avoid a deadlock in conjunction with the xfer->busy flag.

> +=09=09xfer->hdr.type =3D msg_type;
> +=09}
> +=09spin_unlock_irqrestore(&xfer->lock, flags);
> +
> +=09if (ret) {
> +=09=09dev_err(cinfo->dev,
> +=09=09=09"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
> +=09=09=09msg_type, xfer_id, msg_hdr, xfer->state);
> +=09=09/* On error the refcount incremented above has to be dropped */
> +=09=09__scmi_xfer_put(minfo, xfer);
> +=09=09xfer =3D ERR_PTR(-EINVAL);
> +=09}
> +
> +=09return xfer;
> +}
> +
> +static inline void scmi_xfer_command_release(struct scmi_info *info,
> +=09=09=09=09=09     struct scmi_xfer *xfer)
> +{
> +=09atomic_set(&xfer->busy, SCMI_XFER_FREE);
> +=09__scmi_xfer_put(&info->tx_minfo, xfer);
> +}
> +
> +/**
> + * scmi_xfer_state_update  - Update xfer state
> + *
> + * @xfer: A reference to the xfer to update
> + *
> + * Context: Assumes to be called on an xfer exclusively acquired using t=
he
> + *=09    busy flag.
> + */
> +static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
> +{
> +=09switch (xfer->hdr.type) {
> +=09case MSG_TYPE_COMMAND:
> +=09=09xfer->state =3D SCMI_XFER_RESP_OK;
> +=09=09break;
> +=09case MSG_TYPE_DELAYED_RESP:
> +=09=09xfer->state =3D SCMI_XFER_DRESP_OK;
> +=09=09break;
> +=09}
> +}
> +
>   static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 =
msg_hdr)
>   {
>   =09struct scmi_xfer *xfer;
> @@ -462,57 +625,37 @@ static void scmi_handle_notification(struct scmi_ch=
an_info *cinfo, u32 msg_hdr)
>   =09info->desc->ops->clear_channel(cinfo);
>   }
>  =20
> -static void scmi_handle_response(struct scmi_chan_info *cinfo,
> -=09=09=09=09 u16 xfer_id, u8 msg_type)
> +static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_h=
dr)
>   {
> -=09unsigned long flags;
>   =09struct scmi_xfer *xfer;
> -=09struct device *dev =3D cinfo->dev;
>   =09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
> -=09struct scmi_xfers_info *minfo =3D &info->tx_minfo;
>  =20
> -=09/* Are we even expecting this? */
> -=09spin_lock_irqsave(&minfo->xfer_lock, flags);
> -=09xfer =3D scmi_xfer_lookup_unlocked(minfo, xfer_id);
> -=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +=09xfer =3D scmi_xfer_command_acquire(cinfo, msg_hdr);
>   =09if (IS_ERR(xfer)) {
> -=09=09dev_err(dev, "message for %d is not expected!\n", xfer_id);
>   =09=09info->desc->ops->clear_channel(cinfo);
>   =09=09return;
>   =09}
>  =20
> -=09/*
> -=09 * Even if a response was indeed expected on this slot at this point,
> -=09 * a buggy platform could wrongly reply feeding us an unexpected
> -=09 * delayed response we're not prepared to handle: bail-out safely
> -=09 * blaming firmware.
> -=09 */
> -=09if (unlikely(msg_type =3D=3D MSG_TYPE_DELAYED_RESP && !xfer->async_do=
ne)) {
> -=09=09dev_err(dev,
> -=09=09=09"Delayed Response for %d not expected! Buggy F/W ?\n",
> -=09=09=09xfer_id);
> -=09=09info->desc->ops->clear_channel(cinfo);
> -=09=09/* It was unexpected, so nobody will clear the xfer if not us */
> -=09=09__scmi_xfer_put(minfo, xfer);
> -=09=09return;
> -=09}
> +=09scmi_xfer_state_update(xfer);

Since this update is not protected by the xfer->lock any more, it may=20
not become visible in time to a concurrent response which is checking=20
and possibly updating state in scmi_msg_response_validate(). I think=20
this should be avoided, even if it might not cause practical problems ATM.

>  =20
>   =09/* rx.len could be shrunk in the sync do_xfer, so reset to maxsz */
> -=09if (msg_type =3D=3D MSG_TYPE_DELAYED_RESP)
> +=09if (xfer->hdr.type =3D=3D MSG_TYPE_DELAYED_RESP)
>   =09=09xfer->rx.len =3D info->desc->max_msg_size;
>  =20
>   =09info->desc->ops->fetch_response(cinfo, xfer);
>  =20
>   =09trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
>   =09=09=09   xfer->hdr.protocol_id, xfer->hdr.seq,
> -=09=09=09   msg_type);
> +=09=09=09   xfer->hdr.type);
>  =20
> -=09if (msg_type =3D=3D MSG_TYPE_DELAYED_RESP) {
> +=09if (xfer->hdr.type =3D=3D MSG_TYPE_DELAYED_RESP) {
>   =09=09info->desc->ops->clear_channel(cinfo);
>   =09=09complete(xfer->async_done);
>   =09} else {
>   =09=09complete(&xfer->done);
>   =09}
> +
> +=09scmi_xfer_command_release(info, xfer);
>   }
>  =20
>   /**
> @@ -529,7 +672,6 @@ static void scmi_handle_response(struct scmi_chan_inf=
o *cinfo,
>    */
>   void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   {
> -=09u16 xfer_id =3D MSG_XTRACT_TOKEN(msg_hdr);
>   =09u8 msg_type =3D MSG_XTRACT_TYPE(msg_hdr);
>  =20
>   =09switch (msg_type) {
> @@ -538,7 +680,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u=
32 msg_hdr)
>   =09=09break;
>   =09case MSG_TYPE_COMMAND:
>   =09case MSG_TYPE_DELAYED_RESP:
> -=09=09scmi_handle_response(cinfo, xfer_id, msg_type);
> +=09=09scmi_handle_response(cinfo, msg_hdr);
>   =09=09break;
>   =09default:
>   =09=09WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
> @@ -550,7 +692,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u=
32 msg_hdr)
>    * xfer_put() - Release a transmit message
>    *
>    * @ph: Pointer to SCMI protocol handle
> - * @xfer: message that was reserved by scmi_xfer_get
> + * @xfer: message that was reserved by xfer_get_init
>    */
>   static void xfer_put(const struct scmi_protocol_handle *ph,
>   =09=09     struct scmi_xfer *xfer)
> @@ -568,7 +710,12 @@ static bool scmi_xfer_done_no_timeout(struct scmi_ch=
an_info *cinfo,
>   {
>   =09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
>  =20
> +=09/*
> +=09 * Poll also on xfer->done so that polling can be forcibly terminated
> +=09 * in case of out-of-order receptions of delayed responses
> +=09 */
>   =09return info->desc->ops->poll_done(cinfo, xfer) ||
> +=09       try_wait_for_completion(&xfer->done) ||
>   =09       ktime_after(ktime_get(), stop);
>   }
>  =20
> @@ -608,6 +755,7 @@ static int do_xfer(const struct scmi_protocol_handle =
*ph,
>   =09=09=09      xfer->hdr.protocol_id, xfer->hdr.seq,
>   =09=09=09      xfer->hdr.poll_completion);
>  =20
> +=09xfer->state =3D SCMI_XFER_SENT_OK;

To be completely safe, this assignment could also be protected by the=20
xfer->lock.

>   =09ret =3D info->desc->ops->send_message(cinfo, xfer);
>   =09if (ret < 0) {
>   =09=09dev_dbg(dev, "Failed to send message %d\n", ret);
> @@ -619,10 +767,22 @@ static int do_xfer(const struct scmi_protocol_handl=
e *ph,
>  =20
>   =09=09spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
>  =20
> -=09=09if (ktime_before(ktime_get(), stop))
> -=09=09=09info->desc->ops->fetch_response(cinfo, xfer);
> -=09=09else
> +=09=09if (ktime_before(ktime_get(), stop)) {
> +=09=09=09unsigned long flags;
> +
> +=09=09=09/*
> +=09=09=09 * Do not fetch_response if an out-of-order delayed
> +=09=09=09 * response is being processed.
> +=09=09=09 */
> +=09=09=09spin_lock_irqsave(&xfer->lock, flags);
> +=09=09=09if (xfer->state =3D=3D SCMI_XFER_SENT_OK) {
> +=09=09=09=09info->desc->ops->fetch_response(cinfo, xfer);
> +=09=09=09=09xfer->state =3D SCMI_XFER_RESP_OK;
> +=09=09=09}
> +=09=09=09spin_unlock_irqrestore(&xfer->lock, flags);
> +=09=09} else {
>   =09=09=09ret =3D -ETIMEDOUT;
> +=09=09}
>   =09} else {
>   =09=09/* And we wait for the response. */
>   =09=09timeout =3D msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> @@ -1220,6 +1380,7 @@ static int __scmi_xfer_info_init(struct scmi_info *=
sinfo,
>  =20
>   =09=09xfer->tx.buf =3D xfer->rx.buf;
>   =09=09init_completion(&xfer->done);
> +=09=09spin_lock_init(&xfer->lock);
>  =20
>   =09=09/* Add initialized xfer to the free list */
>   =09=09hlist_add_head(&xfer->node, &info->free_xfers);
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

