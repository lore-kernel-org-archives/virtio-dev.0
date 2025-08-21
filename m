Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293F2EA73F
	for <virtio-dev@lists.linux.dev>; Thu, 21 Aug 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765778; cv=none; b=p1HKfJotTh4dvnyMv6WuHaZu6/4iZMEaDCVhaM7A5mLrWptIq3zDOBW8an/NXU9813qjqy3uOW2i9JCxETpgJDzSDFmh1bdb+MxeF3EDCCeMs9m7h1ADRKbwZzRaT7sza905thlQKGSAaVX8O2m63XtAmRPt6p8o5NOYLd3RnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765778; c=relaxed/simple;
	bh=I5NofY1I/J3cD2I9Jah37QRoad7PVZJEMc37nY7nYhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZhpIc7DAp74gHLceqYBT9lDErenqV6O7SxY2h7LE7IC1tI4gowHco1sL+4vPjkn8Kpdk2j93pbi41Y2mWSFR5WqBNTN6+yTmDGtxD9RmR7hmMyT/hSIgS3TQm4DBjMwiQpDNPkZcu6+a9TSBEprxQurQ6Y9eebmm8Qn97U2mk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhnOeq+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhnOeq+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755765776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGmAixpDDtSx5//pjZh8mD9uLe+6T7TvnJDxd1HMKKM=;
	b=KhnOeq+439Je504Nn0UfA31a0+Miac3447z32OzbH6XVVlx8c/kitq8oAkwvGsqRrSW5BQ
	iXojWqlZpmTgw/Mv0GWojBiyWfQFBgR3QDsO7Owec1valaS3Ta0pq2kinm5Ro5Vc8pwQto
	DI3V0AO2Jd+8tCvHBxjJxTW8/HWsau0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-FTO1oXTdMZW1otlt7tnfFg-1; Thu, 21 Aug 2025 04:42:54 -0400
X-MC-Unique: FTO1oXTdMZW1otlt7tnfFg-1
X-Mimecast-MFC-AGG-ID: FTO1oXTdMZW1otlt7tnfFg_1755765773
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1ac1bf0dso4394855e9.0
        for <virtio-dev@lists.linux.dev>; Thu, 21 Aug 2025 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765773; x=1756370573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGmAixpDDtSx5//pjZh8mD9uLe+6T7TvnJDxd1HMKKM=;
        b=SLqvOAyJeT7BZz3ZPgWi6wrR/ZaMPkOAFRh/uApJVXj9Mgz9A6uYMQyW2nG9LEcdSq
         CJAWkP1E8lWRsG7t6u4DYQDXQq/IkxLYZU9jDrY1BHz9/ukd/bjeIufhWBDeiXrYaQiM
         qib/fAGQ3x5i5i/SKCYmUBvAOP59nPdK8pr9D5WqflhmGHyLNbNeJB8qN1XVaCkzLXbi
         +Bd7jakfWAv8T9W5SnMq+zvahiRZbePf3vZcMGdSlRk2pKd046tG68oeM/FIpoMBbGQF
         xp7rQmpDIx1+Hj06vvGN7JFdgevHnfuzOydq4+ijzZ3U/DXFT52+xT6w/15TEre3etDF
         2XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0hjEcNjBzGiUNLIvbuu0+hPaz7atbG7xOSm1im7pxFF8T50nKFE0p2skBBQ8qirPIuYJI7u+vripY@lists.linux.dev
X-Gm-Message-State: AOJu0YwwPVNZLYsji+z4UUT6byRnd9jzPG+djNmHjrb5swMVYU72z6Ro
	9oLyfxc076q07VagYsP51n6oSCZmAO9r/A36JhTM0tf29D0nJkzblcjm0O/N+D+Nz+c8uHF2UQF
	VE5/XXyIuF6iWgowHFFbVPtmSpjiusy/1pMV3tKa4jGY0w1BfDFVwzZs9pcHij+I=
X-Gm-Gg: ASbGncsQbI9+JvhiYMlMDKFbuTA8k5VklekiKDYKRS/HUVCbRn3MLoaU6C5+NRcFfRB
	Gv4F6avqTxCFCT72e2J/HGfDaUmPqKPQpSe4ROoDfm5OMeHWRVspZshCLhxgA7UEQqkUCg6UQjd
	jWA/B1S0NQHL740Lzzt5J35gE+G/jaLAiaq6F5QVmNnnlrKL4M6m782gW4OLimGThaqyJEuryKK
	lDp9s2zTroXNjOd+Kpd9r1gU16oi0M3al3tI7TEHcMJjGu3KxFl75thidhmcgxU/tLoM3vyv3pW
	TOXL/goysCgFQgME8Stwg4sJe6LThpZZ
X-Received: by 2002:a05:600c:a07:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b4d9f41f4mr14568615e9.14.1755765773197;
        Thu, 21 Aug 2025 01:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwZkrl5fXD20Znm+tAZTWUxfgrHTe58SkGcqEtQUMP3n+ZiDjZ6JOOe6sj+jRr77tMsBIMLg==
X-Received: by 2002:a05:600c:a07:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b4d9f41f4mr14568225e9.14.1755765772624;
        Thu, 21 Aug 2025 01:42:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm18352405e9.8.2025.08.21.01.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:42:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:42:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250821044231-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250820084944.84505-3-quic_haixcui@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bFtAd6EhG4vN5ImuTvAbGIGi3WwVeI6J2jaSc3NdvOs_1755765773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  MAINTAINERS                     |   5 +
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  2 files changed, 190 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..3e289677ca18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26760,6 +26760,11 @@ S:	Maintained
>  F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
> +VIRTIO SPI DRIVER
> +M:	Haixu Cui <quic_haixcui@quicinc.com>
> +S:	Maintained
> +F:	include/uapi/linux/virtio_spi.h
> +

I would add a mailing list:

virtualization@lists.linux-foundation.org


>  VIRTUAL BOX GUEST DEVICE DRIVER
>  M:	Hans de Goede <hansg@kernel.org>
>  M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..b55877b3e525
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_types.h>
> +
> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA			_BITUL(0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL			_BITUL(1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> +
> +/**
> + * struct virtio_spi_config - All config fields are read-only for the
> + * Virtio SPI driver
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + *   chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writing:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for reading:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word are
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported or not:
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=0 only
> + *     0b10: supports CPHA=1 only
> + *     0b11: supports CPHA=0 and CPHA=1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=0 only
> + *     0b10: supports CPOL=1 only
> + *     0b11: supports CPOL=0 and CPOL=1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low is supported by default.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first is supported by default.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode is supported by default.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
> + *   A value of 0 indicates that word delay is unsupported.
> + *   Each transfer may consist of a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */
> +struct virtio_spi_config {
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +	__u8 cs_max_number;
> +	__u8 cs_change_supported;
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		_BITUL(0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		_BITUL(1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		_BITUL(2)
> +	__u8 tx_nbits_supported;
> +	__u8 rx_nbits_supported;
> +	__le32 bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		_BITUL(0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		_BITUL(1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		_BITUL(2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		_BITUL(3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		_BITUL(4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		_BITUL(5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		_BITUL(6)
> +	__le32 mode_func_supported;
> +	__le32 max_freq_hz;
> +	__le32 max_word_delay_ns;
> +	__le32 max_cs_setup_ns;
> +	__le32 max_cs_hold_ns;
> +	__le32 max_cs_inactive_ns;
> +};
> +
> +/*
> + * @chip_select_id: chipselect index the SPI transfer used.
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
> +	__u8 chip_select_id;
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
> +#define VIRTIO_SPI_TRANS_OK	0
> +#define VIRTIO_SPI_PARAM_ERR	1
> +#define VIRTIO_SPI_TRANS_ERR	2
> +	__u8 result;
> +};
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */
> -- 
> 2.34.1
> 

