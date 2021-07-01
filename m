Return-Path: <virtio-dev-return-8218-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C98D49862CF
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:43:18 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-16-cristian.marussi@arm.com>
Message-ID: <81b5d6f8-860b-594d-a6f8-417241083425@opensynergy.com>
Date: Thu, 1 Jul 2021 10:43:12 +0200
In-Reply-To: <20210611165937.701-16-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 15/16] [RFC][REWORK] firmware: arm_scmi: make
 virtio-scmi use delegated xfers
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.21 18:59, Cristian Marussi wrote:
> Draft changes to virtio-scmi to use new support for core delegated xfers
> in an attempt to simplify the interactions between virtio-scmi transport
> and the SCMI core transport layer.
>=20

These changes seem to make xfers delegation mandatory for=20
message-passing transports, so that might be documented.

> TODO:
>   - Polling is still not supported.
>   - Probe/remove sequence still to be reviewed.
>   - Concurrent or inverted reception of related responses and delayed
>     responses is still not addressed.
>     (it will be addressed in the SCMI core anyway most probably)
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/common.h |   5 +
>   drivers/firmware/arm_scmi/msg.c    |  35 +++++
>   drivers/firmware/arm_scmi/virtio.c | 212 +++++++++++++++--------------
>   3 files changed, 152 insertions(+), 100 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index c143a449d278..22e5532fc698 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -428,6 +428,11 @@ void msg_fetch_response(struct scmi_msg_payld *msg, =
size_t len,
>   void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
>   =09=09=09    size_t max_len, struct scmi_xfer *xfer);
>  =20
> +void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
> +=09=09=09   size_t max_len, struct scmi_xfer *xfer);
> +void msg_fetch_raw_response(struct scmi_xfer *xfer);
> +void msg_fetch_raw_notification(struct scmi_xfer *xfer);
> +
>   void scmi_notification_instance_data_set(const struct scmi_handle *hand=
le,
>   =09=09=09=09=09 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *han=
dle);
> diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/=
msg.c
> index 8a2d3303d281..3ed3ad0961ae 100644
> --- a/drivers/firmware/arm_scmi/msg.c
> +++ b/drivers/firmware/arm_scmi/msg.c
> @@ -74,6 +74,17 @@ u32 msg_read_header(struct scmi_msg_payld *msg)
>   =09return le32_to_cpu(msg->msg_header);
>   }
>  =20
> +void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
> +=09=09=09   size_t max_len, struct scmi_xfer *xfer)
> +{
> +=09xfer->rx_raw_len =3D min_t(size_t, max_len,
> +=09=09=09=09 msg_len >=3D sizeof(*msg) ?
> +=09=09=09=09 msg_len - sizeof(*msg) : 0);
> +
> +=09/* Take a copy to the rx buffer.. */
> +=09memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx_raw_len);

In the usage throughout arm-scmi so far, scmi_desc.max_msg_size seems to=20
consistently refer to the payload excluding the return status.=20
scmi_desc.max_msg_size is the actual max_len parameter to this function.

So the logic here would reduce the maximum payload length for responses=20
to (scmi_desc.max_msg_size - sizeof(return status)).

> +}
> +
>   /**
>    * msg_fetch_response() - Fetch response SCMI payload from transport SD=
U.
>    *
> @@ -94,6 +105,25 @@ void msg_fetch_response(struct scmi_msg_payld *msg, s=
ize_t len,
>   =09memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
>   }
>  =20
> +void msg_fetch_raw_response(struct scmi_xfer *xfer)
> +{
> +=09__le32 *msg_payload =3D xfer->rx.buf;
> +
> +=09if (xfer->rx_raw_len < sizeof(xfer->hdr.status)) {
> +=09=09xfer->rx.len =3D 0;
> +=09=09return;
> +=09}
> +
> +=09xfer->hdr.status =3D le32_to_cpu(msg_payload[0]);
> +=09/*
> +=09 * rx.len has been already pre-calculated by fetch_raw
> +=09 * for the whole payload including status, so shrink it
> +=09 */
> +=09xfer->rx.len =3D xfer->rx_raw_len - sizeof(xfer->hdr.status);
> +=09/* Carveout status 4-byte field */
> +=09memmove(xfer->rx.buf, &msg_payload[1], xfer->rx.len);

Wouldn't it be feasible to align properly in msg_fetch_raw_payload()=20
already? That could also get rid of .rx_raw_len.

> +}
> +
>   /**
>    * msg_fetch_notification() - Fetch notification payload from transport=
 SDU.
>    *
> @@ -111,3 +141,8 @@ void msg_fetch_notification(struct scmi_msg_payld *ms=
g, size_t len,
>   =09/* Take a copy to the rx buffer.. */
>   =09memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
>   }
> +
> +void msg_fetch_raw_notification(struct scmi_xfer *xfer)
> +{
> +=09xfer->rx.len =3D xfer->rx_raw_len;
> +}
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_sc=
mi/virtio.c
> index 20972adf6dc7..4412bc590ca7 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -37,23 +37,24 @@
>   /**
>    * struct scmi_vio_channel - Transport channel information
>    *
> - * @lock: Protects access to all members except ready.
> - * @ready_lock: Protects access to ready. If required, it must be taken =
before
> - *              lock.
>    * @vqueue: Associated virtqueue
>    * @cinfo: SCMI Tx or Rx channel
>    * @free_list: List of unused scmi_vio_msg, maintained for Tx channels =
only
>    * @is_rx: Whether channel is an Rx channel
>    * @ready: Whether transport user is ready to hear about channel
> + * @lock: Protects access to all members except ready.
> + * @ready_lock: Protects access to ready. If required, it must be taken =
before
> + *              lock.
>    */
>   struct scmi_vio_channel {
> -=09spinlock_t lock;
> -=09spinlock_t ready_lock;
>   =09struct virtqueue *vqueue;
>   =09struct scmi_chan_info *cinfo;
>   =09struct list_head free_list;
> -=09u8 is_rx;
> -=09u8 ready;
> +=09bool is_rx;
> +=09bool ready;
> +=09unsigned int max_msg;
> +=09spinlock_t lock;
> +=09spinlock_t ready_lock;
>   };
>  =20
>   /**
> @@ -100,6 +101,73 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_chann=
el *vioch,
>   =09return rc;
>   }
>  =20
> +static void scmi_finalize_message(struct scmi_vio_channel *vioch,
> +=09=09=09=09  struct scmi_vio_msg *msg)
> +{
> +=09unsigned long flags;
> +
> +=09if (vioch->is_rx) {
> +=09=09scmi_vio_feed_vq_rx(vioch, msg);
> +=09} else {
> +=09=09spin_lock_irqsave(&vioch->lock, flags);
> +=09=09list_add(&msg->list, &vioch->free_list);
> +=09=09spin_unlock_irqrestore(&vioch->lock, flags);
> +=09}
> +}
> +
> +static void scmi_process_vqueue_input(struct scmi_vio_channel *vioch,
> +=09=09=09=09      struct scmi_vio_msg *msg)
> +{
> +=09u32 msg_hdr;
> +=09int ret;
> +=09struct scmi_xfer *xfer =3D NULL;
> +
> +=09msg_hdr =3D msg_read_header(msg->input);
> +=09/*
> +=09 * Acquire from the core transport layer a currently valid xfer
> +=09 * descriptor associated to the received msg_hdr: this could be a
> +=09 * previously allocated xfer for responses and delayed responses to
> +=09 * in-flight commands, or a freshly allocated new xfer for a just
> +=09 * received notification.
> +=09 *
> +=09 * In case of responses and delayed_responses the acquired xfer, at
> +=09 * the time scmi_transfer_acquire() succcessfully returns is guarante=
ed
> +=09 * to be still associated with a valid (not timed-out nor stale)
> +=09 * descriptor and proper refcounting is kept in the core along this x=
fer
> +=09 * so that should the core time out the xfer concurrently to this rec=
eive
> +=09 * path the xfer will be properly deallocated only once the last user=
 is
> +=09 * done with it. (and this code path will terminate normally even tho=
ugh
> +=09 * all the processing related to the timed out xfer will be discarded=
).
> +=09 */

This comment would better fit to scmi_transfer_acquire().

> +=09ret =3D scmi_transfer_acquire(vioch->cinfo, &msg_hdr, &xfer);
> +=09if (ret) {
> +=09=09dev_err(vioch->cinfo->dev,
> +=09=09=09"Cannot find matching xfer for hdr:0x%X\n", msg_hdr);
> +=09=09scmi_finalize_message(vioch, msg);
> +=09=09return;
> +=09}
> +
> +=09dev_dbg(vioch->cinfo->dev,
> +=09=09"VQUEUE[%d] - INPUT MSG_RX_LEN:%d - HDR:0x%X  TYPE:%d  XFER_ID:%d =
 XFER:%px\n",
> +=09=09vioch->vqueue->index, msg->rx_len, msg_hdr, xfer->hdr.type,
> +=09=09xfer->hdr.seq, xfer);
> +
> +=09msg_fetch_raw_payload(msg->input, msg->rx_len,
> +=09=09=09      scmi_virtio_desc.max_msg_size, xfer); > +
> +=09/* Drop processed virtio message anyway */
> +=09scmi_finalize_message(vioch, msg);
> +
> +=09if (vioch->is_rx || !xfer->hdr.poll_completion)
> +=09=09scmi_rx_callback(vioch->cinfo, msg_hdr);
> +=09else
> +=09=09dev_warn(vioch->cinfo->dev,
> +=09=09=09 "Polling mode NOT supported. Dropped hdr:0X%X\n",
> +=09=09=09 msg_hdr);
> +
> +=09scmi_transfer_release(vioch->cinfo, xfer);
> +}
> +
>   static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>   {
>   =09unsigned long ready_flags;
> @@ -138,15 +206,9 @@ static void scmi_vio_complete_cb(struct virtqueue *v=
queue)
>  =20
>   =09=09if (msg) {
>   =09=09=09msg->rx_len =3D length;
> -
> -=09=09=09/*
> -=09=09=09 * Hold the ready_lock during the callback to avoid
> -=09=09=09 * races when the arm-scmi driver is unbinding while
> -=09=09=09 * the virtio device is not quiesced yet.
> -=09=09=09 */
> -=09=09=09scmi_rx_callback(vioch->cinfo,
> -=09=09=09=09=09 msg_read_header(msg->input), msg);
> +=09=09=09scmi_process_vqueue_input(vioch, msg);
>   =09=09}
> +
>   =09=09spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>   =09}
>  =20
> @@ -163,27 +225,11 @@ static vq_callback_t *scmi_vio_complete_callbacks[]=
 =3D {
>   =09scmi_vio_complete_cb
>   };
>  =20
> -static unsigned int virtio_get_max_msg(bool tx,
> -=09=09=09=09       struct scmi_chan_info *base_cinfo)
> +static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo=
)
>   {
>   =09struct scmi_vio_channel *vioch =3D base_cinfo->transport_info;
> -=09unsigned int ret;
>  =20
> -=09ret =3D virtqueue_get_vring_size(vioch->vqueue);
> -
> -=09/* Tx messages need multiple descriptors. */
> -=09if (tx)
> -=09=09ret /=3D DESCRIPTORS_PER_TX_MSG;
> -
> -=09if (ret > MSG_TOKEN_MAX) {
> -=09=09dev_info_once(
> -=09=09=09base_cinfo->dev,
> -=09=09=09"Only %ld messages can be pending simultaneously, while the %s =
virtqueue could hold %d\n",
> -=09=09=09MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
> -=09=09ret =3D MSG_TOKEN_MAX;
> -=09}
> -
> -=09return ret;
> +=09return vioch->max_msg;
>   }
>  =20
>   static int scmi_vio_match_any_dev(struct device *dev, const void *data)
> @@ -195,13 +241,14 @@ static struct virtio_driver virtio_scmi_driver; /* =
Forward declaration */
>  =20
>   static int virtio_link_supplier(struct device *dev)
>   {
> -=09struct device *vdev =3D driver_find_device(
> -=09=09&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
> +=09struct device *vdev;
> +
> +=09vdev =3D driver_find_device(&virtio_scmi_driver.driver,
> +=09=09=09=09  NULL, NULL, scmi_vio_match_any_dev);
>  =20
>   =09if (!vdev) {
> -=09=09dev_notice_once(
> -=09=09=09dev,
> -=09=09=09"Deferring probe after not finding a bound scmi-virtio device\n=
");
> +=09=09dev_notice_once(dev,
> +=09=09=09=09"Deferring probe after not finding a bound scmi-virtio devic=
e\n");
>   =09=09return -EPROBE_DEFER;
>   =09}
>  =20
> @@ -245,12 +292,8 @@ static int virtio_chan_setup(struct scmi_chan_info *=
cinfo, struct device *dev,
>   =09struct virtio_device *vdev;
>   =09struct scmi_vio_channel *vioch;
>   =09int index =3D tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
> -=09int max_msg;
>   =09int i;
>  =20
> -=09if (!virtio_chan_available(dev, index))
> -=09=09return -ENODEV;
> -
>   =09vdev =3D scmi_get_transport_info(dev);
>   =09vioch =3D &((struct scmi_vio_channel *)vdev->priv)[index];
>  =20
> @@ -259,9 +302,7 @@ static int virtio_chan_setup(struct scmi_chan_info *c=
info, struct device *dev,
>   =09vioch->cinfo =3D cinfo;
>   =09spin_unlock_irqrestore(&vioch->lock, flags);
>  =20
> -=09max_msg =3D virtio_get_max_msg(tx, cinfo);
> -
> -=09for (i =3D 0; i < max_msg; i++) {
> +=09for (i =3D 0; i < vioch->max_msg; i++) {
>   =09=09struct scmi_vio_msg *msg;
>  =20
>   =09=09msg =3D devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
> @@ -322,13 +363,6 @@ static int virtio_send_message(struct scmi_chan_info=
 *cinfo,
>   =09int rc;
>   =09struct scmi_vio_msg *msg;
>  =20
> -=09/*
> -=09 * TODO: For now, we don't support polling. But it should not be
> -=09 * difficult to add support.
> -=09 */
> -=09if (xfer->hdr.poll_completion)
> -=09=09return -EINVAL;
> -
>   =09spin_lock_irqsave(&vioch->lock, flags);
>  =20
>   =09if (list_empty(&vioch->free_list)) {
> @@ -351,6 +385,11 @@ static int virtio_send_message(struct scmi_chan_info=
 *cinfo,
>   =09=09=09     "%s() failed to add to virtqueue (%d)\n", __func__,
>   =09=09=09     rc);
>   =09} else {
> +=09=09dev_dbg(vioch->cinfo->dev,
> +=09=09=09"VQUEUE[%d] - REQUEST - PROTO:0x%X  ID:0x%X  XFER_ID:%d  XFER:%=
px  RX_LEN:%zd\n",
> +=09=09 vioch->vqueue->index, xfer->hdr.protocol_id,
> +=09=09 xfer->hdr.id, xfer->hdr.seq, xfer, xfer->rx.len);

Indentation appears to be inconsistent.

> +
>   =09=09virtqueue_kick(vioch->vqueue);
>   =09}
>  =20
> @@ -360,36 +399,15 @@ static int virtio_send_message(struct scmi_chan_inf=
o *cinfo,
>   }
>  =20
>   static void virtio_fetch_response(struct scmi_chan_info *cinfo,
> -=09=09=09=09  struct scmi_xfer *xfer, void *msg_handle)
> +=09=09=09=09  struct scmi_xfer *xfer)
>   {
> -=09struct scmi_vio_msg *msg =3D msg_handle;
> -=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
> -
> -=09if (!msg) {
> -=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
> -=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
> -=09=09=09     __func__);
> -=09=09return;
> -=09}
> -
> -=09msg_fetch_response(msg->input, msg->rx_len, xfer);
> +=09msg_fetch_raw_response(xfer);
>   }
>  =20
>   static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> -=09=09=09=09      size_t max_len, struct scmi_xfer *xfer,
> -=09=09=09=09      void *msg_handle)
> +=09=09=09=09      size_t max_len, struct scmi_xfer *xfer)
>   {
> -=09struct scmi_vio_msg *msg =3D msg_handle;
> -=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
> -
> -=09if (!msg) {
> -=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
> -=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
> -=09=09=09     __func__);
> -=09=09return;
> -=09}
> -
> -=09msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> +=09msg_fetch_raw_notification(xfer);
>   }
>  =20
>   static void dummy_clear_channel(struct scmi_chan_info *cinfo)
> @@ -402,28 +420,6 @@ static bool dummy_poll_done(struct scmi_chan_info *c=
info,
>   =09return false;
>   }
>  =20
> -static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_=
handle)
> -{
> -=09unsigned long flags;
> -=09struct scmi_vio_channel *vioch =3D cinfo->transport_info;
> -=09struct scmi_vio_msg *msg =3D msg_handle;
> -
> -=09if (!msg) {
> -=09=09dev_dbg_once(&vioch->vqueue->vdev->dev,
> -=09=09=09     "Ignoring %s() call with NULL msg_handle\n",
> -=09=09=09     __func__);
> -=09=09return;
> -=09}
> -
> -=09if (vioch->is_rx) {
> -=09=09scmi_vio_feed_vq_rx(vioch, msg);
> -=09} else {
> -=09=09spin_lock_irqsave(&vioch->lock, flags);
> -=09=09list_add(&msg->list, &vioch->free_list);
> -=09=09spin_unlock_irqrestore(&vioch->lock, flags);
> -=09}
> -}
> -
>   static const struct scmi_transport_ops scmi_virtio_ops =3D {
>   =09.link_supplier =3D virtio_link_supplier,
>   =09.chan_available =3D virtio_chan_available,
> @@ -435,7 +431,6 @@ static const struct scmi_transport_ops scmi_virtio_op=
s =3D {
>   =09.fetch_notification =3D virtio_fetch_notification,
>   =09.clear_channel =3D dummy_clear_channel,
>   =09.poll_done =3D dummy_poll_done,
> -=09.drop_message =3D virtio_drop_message,
>   };
>  =20
>   static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -467,10 +462,26 @@ static int scmi_vio_probe(struct virtio_device *vde=
v)
>   =09dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
>  =20
>   =09for (i =3D 0; i < vq_cnt; i++) {
> +=09=09unsigned int sz;
> +
>   =09=09spin_lock_init(&channels[i].lock);
>   =09=09spin_lock_init(&channels[i].ready_lock);
>   =09=09INIT_LIST_HEAD(&channels[i].free_list);
>   =09=09channels[i].vqueue =3D vqs[i];
> +
> +=09=09sz =3D virtqueue_get_vring_size(channels[i].vqueue);
> +=09=09/* Tx messages need multiple descriptors. */
> +=09=09if (!channels[i].is_rx)
> +=09=09=09sz /=3D DESCRIPTORS_PER_TX_MSG;
> +
> +=09=09if (sz > MSG_TOKEN_MAX) {
> +=09=09=09dev_info_once(dev,
> +=09=09=09=09      "%s virtqueue could hold %d messages. Only %ld allowed=
 to be pending.\n",
> +=09=09=09=09      channels[i].is_rx ? "rx" : "tx",
> +=09=09=09=09      sz, MSG_TOKEN_MAX);
> +=09=09=09sz =3D MSG_TOKEN_MAX;
> +=09=09}
> +=09=09channels[i].max_msg =3D sz;
>   =09}
>  =20
>   =09vdev->priv =3D channels;
> @@ -520,4 +531,5 @@ const struct scmi_desc scmi_virtio_desc =3D {
>   =09.max_rx_timeout_ms =3D 60000, /* for non-realtime virtio devices */
>   =09.max_msg =3D 0, /* overridden by virtio_get_max_msg() */
>   =09.max_msg_size =3D VIRTIO_SCMI_MAX_MSG_SIZE,
> +=09.support_xfers_delegation =3D true,
>   };
>=20




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

