Return-Path: <virtio-dev-return-12384-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED03DC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:09:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1CADA1FF65
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:09:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFA4598642F
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 21:09:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D465E983F7A; Mon, 24 Apr 2023 21:09:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C10A59863A5
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 21:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4xb5bf2LOluHuZxKEjGpWA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682370568; x=1684962568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2DIw9E0DWGPudpd861Kjkn+cGauwIMc/nQBn5q2geI=;
        b=PCNxmHGkmI1pOq9PLOVDWv1orf7yVRlrBgnfSyx3cmEPg+/OiRQHse9mdIB6YgE2iV
         QrKYB81+wD96ggov66iZVy/X/sDb9yXMDy0Xf1HohxHtG23Ht6TSj1QERbJY6L1QfBIn
         0p88IxXVWprzR6zhPZwt8moc+L0fDualoIugj8IS591lyKuHVgA7o9HrEeq6+fi0Cao6
         +WZotviZHsLxjt2B98YBwWRichINdA62PGtfSNlHxnZP4q+P8bRoDQUul+iijUAFkNI5
         EqWtLu/0p8JoS9oa+QSCWnQMDqV0V4TJlWhEEn9FDvQovG7j6HNqo788MQGwram+sT8M
         MuMA==
X-Gm-Message-State: AAQBX9fgvvf+HEwRkwVVpyi0G2OinW9b+fqlx37OWj7cHUMOnrck8M/5
	3OEvtTSSE6+j5w8LpOqorDPvmbmqhbHnL4okQsWcplLRdzqqRJzBPPHXcJT6ti4s+xiCLF9BgdO
	Rd68pC17vqDag4G6pSSFYrZkEnCul
X-Received: by 2002:a5d:404e:0:b0:2f8:2d4:74ef with SMTP id w14-20020a5d404e000000b002f802d474efmr10698163wrp.43.1682370568253;
        Mon, 24 Apr 2023 14:09:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350YHMM9T0V0+QlHyo0phBynPWZ5d4SFmalLRfzRfQMsm6PgmZ6pd6ITCa8CU1e9IDifaQL432g==
X-Received: by 2002:a5d:404e:0:b0:2f8:2d4:74ef with SMTP id w14-20020a5d404e000000b002f802d474efmr10698158wrp.43.1682370567918;
        Mon, 24 Apr 2023 14:09:27 -0700 (PDT)
Date: Mon, 24 Apr 2023 17:09:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <20230424170901-mutt-send-email-mst@kernel.org>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] can: virtio-can: cleanups

On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> Address the topics raised in
> 
> https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

given base patch is rfc this should be too?

> ---
>  drivers/net/can/Makefile        |  4 +--
>  drivers/net/can/virtio_can.c    | 56 ++++++++++++++-------------------
>  include/uapi/linux/virtio_can.h |  4 +--
>  3 files changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index e409f61d8e93..19314adaff59 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -17,8 +17,8 @@ obj-$(CONFIG_CAN_AT91)		+= at91_can.o
>  obj-$(CONFIG_CAN_BXCAN)		+= bxcan.o
>  obj-$(CONFIG_CAN_CAN327)	+= can327.o
>  obj-$(CONFIG_CAN_CC770)		+= cc770/
> -obj-$(CONFIG_CAN_C_CAN)		+= c_can/
>  obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
> +obj-$(CONFIG_CAN_C_CAN)		+= c_can/
>  obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
>  obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
>  obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
> @@ -30,7 +30,7 @@ obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
>  obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
>  obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
>  obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
> -obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
>  obj-$(CONFIG_CAN_VIRTIO_CAN)	+= virtio_can.o
> +obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
>  
>  subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index 23f9c1b6446d..c11a652613d0 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -312,13 +312,12 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  	struct scatterlist sg_in[1];
>  	struct scatterlist *sgs[2];
>  	unsigned long flags;
> -	size_t len;
>  	u32 can_flags;
>  	int err;
>  	netdev_tx_t xmit_ret = NETDEV_TX_OK;
>  	const unsigned int hdr_size = offsetof(struct virtio_can_tx_out, sdu);
>  
> -	if (can_dropped_invalid_skb(dev, skb))
> +	if (can_dev_dropped_skb(dev, skb))
>  		goto kick; /* No way to return NET_XMIT_DROP here */
>  
>  	/* Virtio CAN does not support error message frames */
> @@ -338,27 +337,25 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  
>  	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
>  	can_flags = 0;
> -	if (cf->can_id & CAN_EFF_FLAG)
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
>  		can_flags |= VIRTIO_CAN_FLAGS_EXTENDED;
> +		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> +	} else {
> +		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
> +	}
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		can_flags |= VIRTIO_CAN_FLAGS_RTR;
> +	else
> +		memcpy(can_tx_msg->tx_out.sdu, cf->data, cf->len);
>  	if (can_is_canfd_skb(skb))
>  		can_flags |= VIRTIO_CAN_FLAGS_FD;
> +
>  	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
> -	can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> -	len = cf->len;
> -	can_tx_msg->tx_out.length = len;
> -	if (len > sizeof(cf->data))
> -		len = sizeof(cf->data);
> -	if (len > sizeof(can_tx_msg->tx_out.sdu))
> -		len = sizeof(can_tx_msg->tx_out.sdu);
> -	if (!(can_flags & VIRTIO_CAN_FLAGS_RTR)) {
> -		/* Copy if not a RTR frame. RTR frames have a DLC but no payload */
> -		memcpy(can_tx_msg->tx_out.sdu, cf->data, len);
> -	}
> +	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
>  
>  	/* Prepare sending of virtio message */
> -	sg_init_one(&sg_out[0], &can_tx_msg->tx_out, hdr_size + len);
> +	sg_init_one(&sg_out[0], &can_tx_msg->tx_out, hdr_size + cf->len);
>  	sg_init_one(&sg_in[0], &can_tx_msg->tx_in, sizeof(can_tx_msg->tx_in));
>  	sgs[0] = sg_out;
>  	sgs[1] = sg_in;
> @@ -895,8 +892,8 @@ static int virtio_can_probe(struct virtio_device *vdev)
>  	priv->tx_putidx_list =
>  		kcalloc(echo_skb_max, sizeof(struct list_head), GFP_KERNEL);
>  	if (!priv->tx_putidx_list) {
> -		free_candev(dev);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto on_failure;
>  	}
>  
>  	INIT_LIST_HEAD(&priv->tx_putidx_free);
> @@ -914,7 +911,6 @@ static int virtio_can_probe(struct virtio_device *vdev)
>  	vdev->priv = priv;
>  
>  	priv->can.do_set_mode = virtio_can_set_mode;
> -	priv->can.state = CAN_STATE_STOPPED;
>  	/* Set Virtio CAN supported operations */
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
>  	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> @@ -968,11 +964,10 @@ static int virtio_can_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  /* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
>   * virtio_card.c/virtsnd_freeze()
>   */
> -static int virtio_can_freeze(struct virtio_device *vdev)
> +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
>  {
>  	struct virtio_can_priv *priv = vdev->priv;
>  	struct net_device *ndev = priv->dev;
> @@ -996,7 +991,7 @@ static int virtio_can_freeze(struct virtio_device *vdev)
>  /* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
>   * virtio_card.c/virtsnd_restore()
>   */
> -static int virtio_can_restore(struct virtio_device *vdev)
> +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
>  {
>  	struct virtio_can_priv *priv = vdev->priv;
>  	struct net_device *ndev = priv->dev;
> @@ -1020,7 +1015,6 @@ static int virtio_can_restore(struct virtio_device *vdev)
>  
>  	return 0;
>  }
> -#endif /* #ifdef CONFIG_PM_SLEEP */
>  
>  static struct virtio_device_id virtio_can_id_table[] = {
>  	{ VIRTIO_ID_CAN, VIRTIO_DEV_ANY_ID },
> @@ -1037,18 +1031,16 @@ static unsigned int features[] = {
>  static struct virtio_driver virtio_can_driver = {
>  	.feature_table = features,
>  	.feature_table_size = ARRAY_SIZE(features),
> -	.feature_table_legacy = NULL,
> -	.feature_table_size_legacy = 0,
> -	.driver.name =	KBUILD_MODNAME,
> -	.driver.owner =	THIS_MODULE,
> -	.id_table =	virtio_can_id_table,
> -	.validate =	virtio_can_validate,
> -	.probe =	virtio_can_probe,
> -	.remove =	virtio_can_remove,
> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table = virtio_can_id_table,
> +	.validate = virtio_can_validate,
> +	.probe = virtio_can_probe,
> +	.remove = virtio_can_remove,
>  	.config_changed = virtio_can_config_changed,
>  #ifdef CONFIG_PM_SLEEP
> -	.freeze =	virtio_can_freeze,
> -	.restore =	virtio_can_restore,
> +	.freeze = virtio_can_freeze,
> +	.restore = virtio_can_restore,
>  #endif
>  };
>  
> diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_can.h
> index de85918aa7dc..f59a2ca6ebd1 100644
> --- a/include/uapi/linux/virtio_can.h
> +++ b/include/uapi/linux/virtio_can.h
> @@ -35,7 +35,7 @@ struct virtio_can_config {
>  struct virtio_can_tx_out {
>  #define VIRTIO_CAN_TX                   0x0001
>  	__le16 msg_type;
> -	__le16 length; /* 0..8 CC, 0..64 CAN­FD, 0..2048 CAN­XL, 12 bits */
> +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
>  	__le32 reserved; /* May be needed in part for CAN XL priority */
>  	__le32 flags;
>  	__le32 can_id;
> @@ -50,7 +50,7 @@ struct virtio_can_tx_in {
>  struct virtio_can_rx {
>  #define VIRTIO_CAN_RX                   0x0101
>  	__le16 msg_type;
> -	__le16 length; /* 0..8 CC, 0..64 CAN­FD, 0..2048 CAN­XL, 12 bits */
> +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
>  	__le32 reserved; /* May be needed in part for CAN XL priority */
>  	__le32 flags;
>  	__le32 can_id;
> -- 
> 2.39.2
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

