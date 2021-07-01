Return-Path: <virtio-dev-return-8215-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D79DD98630B
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Jul 2021 08:42:58 +0000 (UTC)
From: Peter Hilber <peter.hilber@opensynergy.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-6-cristian.marussi@arm.com>
Message-ID: <1675b521-8164-4daa-baa1-592268474a56@opensynergy.com>
Date: Thu, 1 Jul 2021 10:42:51 +0200
In-Reply-To: <20210611165937.701-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4 05/16] firmware: arm_scmi: Introduce delegated xfers
 support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.21 18:59, Cristian Marussi wrote:
> Introduce optional support for delegated xfers allocation.
>=20
> An SCMI transport can optionally declare to support delegated xfers and
> then use a few helper functions exposed by the core SCMI transport layer =
to
> query the core for existing in-flight transfers matching a provided messa=
ge
> header or alternatively and transparently obtain a brand new xfer to hand=
le
> a freshly received notification message.
> In both cases the obtained xfer is uniquely mapped into a specific xfer
> through the means of the message header acting as key.
>=20
> In this way such a transport can properly store its own transport specifi=
c
> payload into the xfer uniquely associated to the message header before
> even calling into the core scmi_rx_callback() in the usual way, so that
> the transport specific message envelope structures can be freed early
> and there is no more need to keep track of their status till the core
> fully processes the xfer to completion or times out.
>=20
> The scmi_rx_callbak() does not need to be modified to carry additional
> transport-specific ancillary data related to such message envelopes since
> an unique natural association is established between the xfer and the
> related message header.
>=20
> Existing transports that do not need anything of the above will continue
> to work as before without any change.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |  14 +++
>  drivers/firmware/arm_scmi/driver.c | 132 ++++++++++++++++++++++++++++-
>  2 files changed, 143 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_sc=
mi/common.h
> index e64c5ca9ee7c..0edc04bc434c 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -80,6 +80,7 @@ struct scmi_msg_resp_prot_version {
>   * @status: Status of the transfer once it's complete
>   * @poll_completion: Indicate if the transfer needs to be polled for
>   *=09completion or interrupt mode is used
> + * @saved_hdr: A copy of the original msg_hdr
>   */
>  struct scmi_msg_hdr {
>  =09u8 id;
> @@ -88,6 +89,7 @@ struct scmi_msg_hdr {
>  =09u16 seq;
>  =09u32 status;
>  =09bool poll_completion;
> +=09u32 saved_hdr;
>  };
> =20
>  /**
> @@ -154,6 +156,9 @@ struct scmi_msg {
>   * @rx: Receive message, the buffer should be pre-allocated to store
>   *=09message. If request-ACK protocol is used, we can reuse the same
>   *=09buffer for the rx path as we use for the tx path.
> + * @rx_raw_len: A field which can be optionally used by a specific trans=
port
> + *=09=09to save transport specific message length
> + *=09=09It is not used by the SCMI transport core
>   * @done: command message transmit completion event
>   * @async_done: pointer to delayed response message received event compl=
etion
>   * @users: A refcount to track the active users for this xfer
> @@ -165,6 +170,7 @@ struct scmi_xfer {
>  =09struct scmi_msg_hdr hdr;
>  =09struct scmi_msg tx;
>  =09struct scmi_msg rx;
> +=09size_t rx_raw_len;
>  =09struct completion done;
>  =09struct completion *async_done;
>  =09refcount_t users;
> @@ -355,6 +361,9 @@ struct scmi_device *scmi_child_dev_find(struct device=
 *parent,
>   * @max_msg: Maximum number of messages that can be pending
>   *=09simultaneously in the system
>   * @max_msg_size: Maximum size of data per message that can be handled.
> + * @support_xfers_delegation: A flag to indicate if the described transp=
ort
> + *=09=09=09      will handle delegated xfers, so the core can
> + *=09=09=09      derive proper related assumptions.
>   */
>  struct scmi_desc {
>  =09int (*init)(void);
> @@ -363,6 +372,7 @@ struct scmi_desc {
>  =09int max_rx_timeout_ms;
>  =09int max_msg;
>  =09int max_msg_size;
> +=09bool support_xfers_delegation;
>  };
> =20
>  extern const struct scmi_desc scmi_mailbox_desc;
> @@ -391,4 +401,8 @@ void scmi_notification_instance_data_set(const struct=
 scmi_handle *handle,
>  =09=09=09=09=09 void *priv);
>  void *scmi_notification_instance_data_get(const struct scmi_handle *hand=
le);
> =20
> +int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
> +=09=09=09  struct scmi_xfer **xfer);
> +void scmi_transfer_release(struct scmi_chan_info *cinfo,
> +=09=09=09   struct scmi_xfer *xfer);
>  #endif /* _SCMI_COMMON_H */
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_sc=
mi/driver.c
> index f0b20ddb24f4..371d3804cd79 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -432,6 +432,124 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *m=
info, u16 xfer_id)
>  =09return xfer ?: ERR_PTR(-EINVAL);
>  }
> =20
> +/**
> + * scmi_xfer_acquire  -  Helper to lookup and acquire an xfer
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel typ=
e
> + * @xfer_id: Token ID to lookup in @pending_xfers
> + *
> + * When a valid xfer is found for the provided @xfer_id, reference count=
ing is
> + * properly updated.
> + *
> + * Return: A valid @xfer on Success or error otherwise.
> + */
> +static struct scmi_xfer *
> +scmi_xfer_acquire(struct scmi_xfers_info *minfo, u16 xfer_id)
> +{
> +=09unsigned long flags;
> +=09struct scmi_xfer *xfer;
> +
> +=09spin_lock_irqsave(&minfo->xfer_lock, flags);
> +=09xfer =3D scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +=09if (!IS_ERR(xfer))
> +=09=09refcount_inc(&xfer->users);
> +=09spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +=09return xfer;
> +}
> +
> +/**
> + * scmi_transfer_acquire  -  Lookup for an existing xfer or freshly allo=
cate a
> + * new one depending on the type of the message
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_hdr: A pointer to the message header to lookup.
> + * @xfer: A reference to the pre-existent or freshly allocated xfer
> + *=09  associated with the provided *msg_hdr.
> + *
> + * This function can be used by transports supporting delegated xfers to=
 obtain
> + * a valid @xfer associated with the provided @msg_hdr param.
> + *
> + * The nature of the resulting @xfer depends on the type of message spec=
ified in
> + * @msg_hdr:
> + *  - for responses and delayed responses a pre-existent/pre-allocated i=
n-flight
> + *    xfer descriptor will be returned (properly refcounted)
> + *  - for notifications a brand new xfer will be allocated; in this case=
 the
> + *    provided message header sequence number will also be mangled to ma=
tch
> + *    the token in the freshly allocated xfer: this is needed to establi=
sh a
> + *    link between the picked xfer and the msg_hdr that will be subseque=
ntly
> + *    passed back via usual scmi_rx_callback().
> + *
> + * Return: 0 if a valid xfer is returned in @xfer, error otherwise.
> + */
> +int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
> +=09=09=09  struct scmi_xfer **xfer)
> +{
> +=09u8 msg_type;
> +=09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
> +
> +=09if (!xfer || !msg_hdr || !info->desc->support_xfers_delegation)
> +=09=09return -EINVAL;
> +
> +=09msg_type =3D MSG_XTRACT_TYPE(*msg_hdr);
> +=09switch (msg_type) {
> +=09case MSG_TYPE_COMMAND:
> +=09case MSG_TYPE_DELAYED_RESP:
> +=09=09/* Grab an existing xfer for xfer_id */
> +=09=09*xfer =3D scmi_xfer_acquire(&info->tx_minfo,
> +=09=09=09=09=09  MSG_XTRACT_TOKEN(*msg_hdr));
> +=09=09break;
> +=09case MSG_TYPE_NOTIFICATION:
> +=09=09/* Get a brand new RX xfer */
> +=09=09*xfer =3D scmi_xfer_get(cinfo->handle, &info->rx_minfo);
> +=09=09if (!IS_ERR(*xfer)) {
> +=09=09=09/* Save original msg_hdr and fix sequence number */
> +=09=09=09(*xfer)->hdr.saved_hdr =3D *msg_hdr;

The saved header isn't used anywhere.

> +=09=09=09*msg_hdr &=3D ~MSG_TOKEN_ID_MASK;
> +=09=09=09*msg_hdr |=3D FIELD_PREP(MSG_TOKEN_ID_MASK,
> +=09=09=09=09=09       (*xfer)->hdr.seq);

This will invalidate the token set by the platform in=20
scmi_dump_header_dbg(). Maybe it would have been more elegant to=20
introduce a dedicated hash table key field?

> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09*xfer =3D ERR_PTR(-EINVAL);
> +=09=09break;
> +=09}
> +
> +=09if (IS_ERR(*xfer)) {
> +=09=09dev_err(cinfo->dev,
> +=09=09=09"Failed to acquire a valid xfer for hdr:0x%X\n",
> +=09=09=09*msg_hdr);
> +=09=09return PTR_ERR(*xfer);
> +=09}
> +
> +=09/* Fix xfer->hdr.type with actual msg_hdr carried type */
> +=09unpack_scmi_header(*msg_hdr, &((*xfer)->hdr));
> +
> +=09return 0;
> +}
> +
> +/**
> + * scmi_transfer_release  - Release an previously acquired xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @xfer: A reference to the xfer to release.
> + */
> +void scmi_transfer_release(struct scmi_chan_info *cinfo, struct scmi_xfe=
r *xfer)
> +{
> +=09struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
> +=09struct scmi_xfers_info *minfo;
> +
> +=09if (!xfer || !info->desc->support_xfers_delegation)
> +=09=09return;
> +
> +=09if (xfer->hdr.type =3D=3D MSG_TYPE_NOTIFICATION)
> +=09=09minfo =3D &info->rx_minfo;
> +=09else
> +=09=09minfo =3D &info->tx_minfo;
> +
> +=09__scmi_xfer_put(minfo, xfer);
> +}
> +
>  static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 m=
sg_hdr)
>  {
>  =09struct scmi_xfer *xfer;
> @@ -441,7 +559,11 @@ static void scmi_handle_notification(struct scmi_cha=
n_info *cinfo, u32 msg_hdr)
>  =09ktime_t ts;
> =20
>  =09ts =3D ktime_get_boottime();
> -=09xfer =3D scmi_xfer_get(cinfo->handle, minfo);
> +
> +=09if (!info->desc->support_xfers_delegation)
> +=09=09xfer =3D scmi_xfer_get(cinfo->handle, minfo);
> +=09else
> +=09=09xfer =3D scmi_xfer_acquire(minfo, MSG_XTRACT_TOKEN(msg_hdr));
>  =09if (IS_ERR(xfer)) {
>  =09=09dev_err(dev, "failed to get free message slot (%ld)\n",
>  =09=09=09PTR_ERR(xfer));
> @@ -449,8 +571,11 @@ static void scmi_handle_notification(struct scmi_cha=
n_info *cinfo, u32 msg_hdr)
>  =09=09return;
>  =09}
> =20
> -=09unpack_scmi_header(msg_hdr, &xfer->hdr);
>  =09scmi_dump_header_dbg(dev, &xfer->hdr);
> +
> +=09if (!info->desc->support_xfers_delegation)
> +=09=09unpack_scmi_header(msg_hdr, &xfer->hdr);
> +

Why dump the header before unpacking?

>  =09info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
>  =09=09=09=09=09    xfer);
>  =09scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
> @@ -496,7 +621,8 @@ static void scmi_handle_response(struct scmi_chan_inf=
o *cinfo,
>  =09=09=09xfer_id);
>  =09=09info->desc->ops->clear_channel(cinfo);
>  =09=09/* It was unexpected, so nobody will clear the xfer if not us */
> -=09=09__scmi_xfer_put(minfo, xfer);
> +=09=09if (!info->desc->support_xfers_delegation) //XXX ??? Really
> +=09=09=09__scmi_xfer_put(minfo, xfer);
>  =09=09return;
>  =09}
> =20
>=20




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

