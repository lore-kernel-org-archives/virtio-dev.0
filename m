Return-Path: <virtio-dev-return-14371-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44DBC54798
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 08:22:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0411C2B015
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 08:22:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB3A8986542
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Feb 2024 08:22:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4F99983E93; Thu, 29 Feb 2024 08:22:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B358A986530
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Feb 2024 08:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194947; x=1709799747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4kIsmcKhhflwhBbcpPfclRumN4oUdpHtr9LDaDVhg4=;
        b=aRtXVYZvcNV3MhHonLFG/2oyI23GXFE5948QxsomBELi9uMHu9zSeU2TGaFDfAlbU3
         sQOP7LFGLBoL51Z1S+Io6ohwaj8H1kel4XpiV8445YYFw+bCauN2OuAU8E8Wwa5GeW5P
         JI1oZBmZ5kMX4wXnOkW7IpBLiTL7dDmXi/o6Ei7SnL3nfCeNfcMoEZPQegXLW0I73PnN
         GusqdkqpHk56hPxRbB3hLWE9uwJkk9TWgaDlQN53GJeeAv0ZqobRkUM23SoLAJNdMFbC
         Orpr7czGZQd9avp4YeqSjVJS3xCbIbD3dtepb7pcuJVRnr5lRxHSewPQCPAriIlVePuX
         Pi1w==
X-Gm-Message-State: AOJu0Yz4Kif4+8DQU+RaDVHkgRZ/a20S6nZnsrsKJTDHDPFMAgTWlRGG
	xWbScD8y1msrmKbMjYjQpr5MWx8qWjkcrYwm39c15+dwf2hYml/u2V5lMO67hBg=
X-Google-Smtp-Source: AGHT+IHS9mdIRgTsBalN5Wx8ktYN4NJOOVtV/1p04KbzhR6lJj4k4MXvv9tFHXgr2Fz52qa2YAdq6w==
X-Received: by 2002:a17:903:495:b0:1db:e089:745b with SMTP id jj21-20020a170903049500b001dbe089745bmr1322502plb.6.1709194946750;
        Thu, 29 Feb 2024 00:22:26 -0800 (PST)
Date: Thu, 29 Feb 2024 13:52:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Message-ID: <20240229082224.2kh2scyjpielwx7v@vireshk-i7>
References: <20240228142755.4061-1-Harald.Mommer@opensynergy.com>
 <20240228142755.4061-4-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228142755.4061-4-Harald.Mommer@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v1 3/3] virtio-spi: Add virtio SPI driver.

On 28-02-24, 15:27, Harald Mommer wrote:
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct device_node *np = vdev->dev.parent->of_node;
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int err;
> +	u32 bus_num;
> +	u16 csi;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl) {
> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
> +			__func__);

The print can be dropped I guess.

> +		return -ENOMEM;
> +	}
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	init_completion(&priv->spi_req.completion);
> +
> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	/* Method to do a single SPI transfer */

The comments for obvious statements are normally not required. There
are a couple of them here.

> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	/* Initialize virtqueues */
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");

Maybe "Failed to" instead of "Cannot" ?

> +		return err;
> +	}
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	board_info.max_speed_hz = priv->max_freq_hz;
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)ctrl->bus_num;
> +
> +	/* Add chip selects to controller */
> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;

Maybe a blank line here.

> +		/* TODO: Discuss setting of board_info.mode */
> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> +			board_info.mode = SPI_MODE_0;
> +		else
> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;

and here to improve readability.

> +		if (!spi_new_device(ctrl, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			spi_unregister_controller(ctrl);
> +			err = -ENODEV;
> +			goto err_return;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_return:
> +	vdev->config->del_vqs(vdev);
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */

Not sure if this comment is required or not, since we don't add
similar ones while registering.

> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);
> +}

Other than that.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

