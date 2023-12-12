Return-Path: <virtio-dev-return-14141-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A600EC4167B
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 10:35:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DCC033E56C
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 10:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B9B4398667B
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Dec 2023 10:35:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9F0B5983FE6; Tue, 12 Dec 2023 10:35:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97A77986556
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Dec 2023 10:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377254; x=1702982054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONHT2o8AvXEqFY+vlUlHd0KuAOs7YqS8bCdnIAlUsw=;
        b=LEqceq5wO6wO7csFfVSPCKT/ZpmpTXlUN+D/wYbTu5BnW9ARng7zAfDexWafIqOvHT
         /YywUwWC5+iEx54fJ8fdjd4Ej4Fh0GfIFwGHIDe9Wu3j2dtF+gl5mONd3eqzc3Op+Ze2
         Al2rnhQXEe8kWEnYj8WVoCCpGYAESVk2Yq3TavOaP5LdMRQ0AjJFLuiWJ66xm3WQ8rZ9
         OKK+nEOaYG/oO9BhXifcM1XSX9rJEA4cDXu4ocD3rnPE9etERIEgOfLuqKydj6Nh2UhC
         Say1cnJgdWEK+H9d8pV3gFR+8VvHJY59F6ao5L9ACMppGVH8Pz7ssR8lU7pqNdCg79Hg
         Zs9w==
X-Gm-Message-State: AOJu0Yy0nRhSZ6872eyqtblHw+ZmQVNV5HVyH8y3EX72eXFTBbm+TrBO
	EBWW6ZQgvdp/DJuVZZkOwDUPKQ==
X-Google-Smtp-Source: AGHT+IE83uS0bfgt2WGdT+m3M7qJlgTsnZt4smAeY57uMMQCJ9VZvSWZFb4i8SHRs4EgPisEUKAdug==
X-Received: by 2002:a17:903:2301:b0:1d0:6ffe:1e91 with SMTP id d1-20020a170903230100b001d06ffe1e91mr3173440plh.116.1702377253779;
        Tue, 12 Dec 2023 02:34:13 -0800 (PST)
Date: Tue, 12 Dec 2023 16:04:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
	quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Message-ID: <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).

Hi Harald,

I have reviewed the specifications changes recently and here is an
attempt to go through the kernel code too.

I hope you would be sending a new version soon as there are few
changes in the spec already.

On 27-10-23, 18:10, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add initial virtio-spi.h header for virtio SPI. The header file is
> compliant to the virtio SPI draft specification V4.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_spi.h | 130 ++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..9cf4335784ef
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */

Maybe this should be:

SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause

?

> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +// clang-format off

Why do we want to avoid clang-format here ?

> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA (1u << 0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL (1u << 1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH (1u << 2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST (1u << 3)
> +
> +/*
> + * Beware: From here on the bits do not match any more the Linux definitions!
> + */

Not sure if this is really required here. We are talking about the
interface defined by the Virtio protocol here and there can be
mismatch with Linux definitions.

> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP (1u << 4)
> +
> +/* All config fields are read-only for the Virtio SPI driver */
> +struct virtio_spi_config {

Can you please add proper doc style comments for the structures ?

> +	/* /dev/spidev<bus_num>.CS. For Linux must be >= 0 and <= S16_MAX */
> +	__le16 bus_num;
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +	__le16 chip_select_max_number;
> +	/*
> +	 * 0: physical SPI master doesn't support cs timing setting"
> +	 * 1:_physical SPI master supports cs timing setting
> +	 * TODO: Comment on this, unclear and naming not good!
> +	 * Meant is probably word_delay_ns, cs_setup_ns and cs_delay_hold_ns
> +	 * while cs_change_delay_inactive_ns may be supportable everywhere
> +	 * Or all are meant. And the naming mismatch is the cs_ when the most
> +	 * critical word_delay_ns which cannot be supported everywhere is also
> +	 * affected.
> +	 */
> +	u8 cs_timing_setting_enable;
> +	/* Alignment and future extension */
> +	u8 reserved[3];
> +};
> +
> +/*
> + * @slave_id: chipselect index the SPI transfer used.
> + *
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + *
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + *
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @reserved: for future use.
> + *
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + *
> + * @freq: the transfer speed in Hz.
> + *
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + *
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + *
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + *
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +	__u8 slave_id;
> +	__u8 bits_per_word;
> +	__u8 cs_change;
> +	__u8 tx_nbits;
> +	__u8 rx_nbits;
> +	__u8 reserved[3];
> +	__le32 mode;
> +	__le32 freq;
> +	__le32 word_delay_ns;
> +	__le32 cs_setup_ns;
> +	__le32 cs_delay_hold_ns;
> +	__le32 cs_change_delay_inactive_ns;
> +};
> +
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK 0
> +#define VIRTIO_SPI_TRANS_ERR 1

Maybe just define them above the struct.

> +	__u8 result;
> +};
> +// clang-format on
> +
> +#endif /* #ifndef _COQOS_VIRTIO_VIRTIO_SPI_H */

s/_COQOS_VIRTIO_VIRTIO_SPI_H/_LINUX_VIRTIO_VIRTIO_SPI_H/

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

