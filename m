Return-Path: <virtio-dev-return-14093-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B22C10DC1
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 11:20:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 25F6FC6126
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 11:20:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9CF20986925
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 11:20:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D6F15986676; Thu, 30 Nov 2023 11:20:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FE03986674
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 11:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343144; x=1701947944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtKUNnHSmKhAL7AZmJa+00969kwDC9KD1fKFUGVrOLw=;
        b=p3de75ODksRxXaQ7VaTeZoFSxdX8nDMK1eHZOBy/8hZ7L2XQd2Bw35n5WxVWpbn4sH
         ekFCAWAP7m8nxlTbLxDbP3wQMDlIMcrB/9VISpLvfVoMlCfB6aP+Pnjjj6CLo/DYV6v1
         Q2T537xxgEGhrEEIWAIr4A/+S+pG+pNMI7P8J2b4rCG+rSP/sXIXiZ1Ip+pBkgN1I7EL
         cNuRxNNke+2O/1VlVP37erJsW/og2trCMTofL/jCou5dmaIOqpEXnVBfYsNOLZJpEsu/
         JphO6cuqAro8tJSmSA38REIR/glTFL+PSdXlTf1fNy+ZDCqwvyaN9kDf/KbkIRxajokA
         nOtA==
X-Gm-Message-State: AOJu0YyZiI2uBqoK8ol+IwSu4OrgTwgCS3Y36Bsj5Yi+8dnJ36MJekHS
	ww59y3PWn2A0B8WocuYSS3605A==
X-Google-Smtp-Source: AGHT+IEIyLMUxeSUhZUjAZmAwGdbf2noHXHZLwgvfFBn0pFsn6aRlesF8KYfgioViZ9PMNSJgUqC3w==
X-Received: by 2002:a17:903:1205:b0:1cc:5589:7dba with SMTP id l5-20020a170903120500b001cc55897dbamr24137206plh.43.1701343143987;
        Thu, 30 Nov 2023 03:19:03 -0800 (PST)
Date: Thu, 30 Nov 2023 16:49:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	cohuck@redhat.com, harald.mommer@opensynergy.com,
	broonie@kernel.org, qiang4.zhang@linux.intel.com,
	quic_ztu@quicinc.com
Message-ID: <20231130111900.ix3cfsxlns2blp4r@vireshk-i7>
References: <20231130092242.17303-1-quic_haixcui@quicinc.com>
 <20231130092242.17303-3-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130092242.17303-3-quic_haixcui@quicinc.com>
Subject: Re: [virtio-dev] [PATCH V6 2/2] virtio-spi: add the device
 specification

On 30-11-23, 17:22, Haixu Cui wrote:
> The Virtio SPI (Serial Peripheral Interface) device is a virtual
> SPI controller that allows the driver to operate and use the SPI
> controller under the control of the device.
> 
> This patch adds the specification for virtio-spi.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  device-types/spi/description.tex        | 288 ++++++++++++++++++++++++
>  device-types/spi/device-conformance.tex |   7 +
>  device-types/spi/driver-conformance.tex |   7 +
>  3 files changed, 302 insertions(+)
>  create mode 100644 device-types/spi/description.tex
>  create mode 100644 device-types/spi/device-conformance.tex
>  create mode 100644 device-types/spi/driver-conformance.tex
> 
> diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
> new file mode 100644
> index 0000000..c4816a6
> --- /dev/null
> +++ b/device-types/spi/description.tex
> @@ -0,0 +1,288 @@
> +\section{SPI Controller Device}\label{sec:Device Types / SPI Controller Device}
> +
> +The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
> +allows the driver to operate and use the SPI controller under the control of the device,

s/control of the device/control of the host/

The host emulates and provides the guest with a device. 'device' is not really a
replacement for the word 'host`, but should be used to refer to the entity
emulated by the host.

> +either a physical SPI controller, or an emulated one.
> +
> +The Virtio SPI device has a single virtqueue. SPI transfer requests are placed into
> +the virtqueue, and serviced by the device.

s/the virtqueue, and /the virtqueue by the driver, and are /

> +
> +\subsection{Device ID}\label{sec:Device Types / SPI Controller Device / Device ID}
> +45
> +
> +\subsection{Virtqueues}\label{sec:Device Types / SPI Controller Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] requestq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / SPI Controller Device / Feature bits}
> +
> +None
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / SPI Controller Device / Device configuration layout}
> +
> +All fields of this configuration are always available and read-only for Virtio SPI driver.

s/always available/mandatory/

and "the Virtio SPI driver", everywhere else too..

> +The config space shows the features and settings supported by the device.
> +
> +\begin{lstlisting}
> +struct virtio_spi_config {
> +	u8 cs_max_number;
> +	u8 cs_change_supported;
> +	u8 tx_nbits_supported;
> +	u8 rx_nbits_supported;
> +	le32 bits_per_word_mask;
> +	le32 mode_func_supported;
> +	le32 max_freq_hz;
> +	le32 max_word_delay_ns;
> +	le32 max_cs_setup_ns;
> +	le32 max_cs_hold_ns;
> +	le32 max_cs_inactive_ns;
> +};
> +\end{lstlisting}
> +
> +\field{cs_max_number} is the maximum number of chipselect the device supports.
> +
> +Note: chipselect is an electrical signal controlled by the SPI controller, used to select the
> +SPI slaves connected to the controller.

It isn't mandatory for the CS to be controlled by the controller. It can also be
a GPIO pin too which is controlled by the host driver.

Suggest rewriting as:

Note: chipselect is an electrical signal, which is used to select the SPI slaves
connected to the controller.

> +\field{cs_change_supported} indicates if the device supports to toggle chipselect
> +after each transfer in one message:
> +        0: unsupported, means chipselect will keep active when executing the message transaction;

        0: unsupported, chipselect will be kept in active state throughout the transaction;

> +        1: supported.
> +
> +Note: Message here contains a sequence of SPI transfers.
> +
> +\field{tx_nbits_supported} indicates the supported number of bit for writing, SINGLE is always
> +supported. In the bit definition below, a set bit means the transfer is supported, otherwise not:
> +        bit 0: DUAL;
> +        bit 1: QUAD;
> +        bit 2: OCTAL;
> +        other bits are reserved and must be set to 0 by the device.
> +

Not sure if the below Note and the item list is required at all.

> +Note: Transfer bit options are commonly used in SPI:
> +\begin{itemize}
> +\item SINGLE: 1-bit transfer
> +\item DUAL: 2-bit transfer
> +\item QUAD: 4-bit transfer
> +\item OCTAL: 8-bit transfer
> +\end{itemize}
> +
> +\field{rx_nbits_supported} indicates the supported number of bit for reading, SINGLE is always
> +supported. In the bit definition below, a set bit means the transfer is supported, otherwise not:
> +        bit 0: DUAL;
> +        bit 1: QUAD;
> +        bit 2: OCTAL;
> +        other bits are reserved and must be set to 0 by the device.
> +

There is still some duplication left here in tx and rx bits supported fields.
Maybe rewrite the whole thing as:

"
\field{tx_nbits_supported} and \field{rx_nbits_supported} indicate the different
n-bit transfer modes supported by the device. The 1-bit transfer mode is always
supported. A set bit here indicates that the corresponding mode is supported,
otherwise not:

        bit 0: DUAL;
        bit 1: QUAD;
        bit 2: OCTAL;
        other bits are reserved and must be set to 0 by the device.
"

> +\field{bits_per_word_mask} is a mask indicating which values of bits_per_word are supported.
> +If not set, no limitation for bits_per_word.
> +
> +Note: bits_per_word corresponds to \field{bits_per_word} in \field{struct virtio_spi_transfer_head}.
> +
> +\field{mode_func_supported} indicates whether the following features are supported or not:
> +        bit 0-1: CPHA feature,
> +            0b00: supports CPHA=0 and CPHA=1;
> +            0b01: supports CPHA=0 only;
> +            0b10: supports CPHA=1 only;
> +            0b11: invalid, must support as least one CPHA setting.
> +
> +        bit 2-3: CPOL feature,
> +            0b00: supports CPOL=0 and CPOL=1;
> +            0b01: supports CPOL=0 only;
> +            0b10: supports CPOL=1 only;
> +            0b11: invalid, must support as least one CPOL setting.
> +
> +        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
> +            chipselect active low must always be supported.
> +
> +        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first must always be
> +            supported.
> +
> +        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
> +            must always be supported.
> +
> +Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, clock idles at the logical
> +low voltage, otherwise idles at the logical high voltage. CPHA determines how data is outputted
> +and sampled.
> +
> +Note: LSB first indicates that data is transferred least significant bit first,and MSB first
> +indicates that data is transferred most significant bit first.
> +
> +\field{max_freq_hz} is the maximum clock rate supported in Hz unit, 0 means no limitation
> +for transfer speed.
> +
> +\field{max_word_delay_ns} is the maximum word delay supported in ns unit, 0 means word delay 
> +feature is unsupported.
> +
> +Note: Just as one message contains a sequence of transfers, one transfer may contain
> +a sequence of words.
> +
> +\field{max_cs_setup_ns} is the maximum delay supported after chipselect is asserted, in ns unit,
> +0 means delay is not supported to introduce after chipselect is asserted.
> +
> +\field{max_cs_hold_ns} is the maximum delay supported before chipselect is deasserted, in ns unit,
> +0 means delay is not supported to introduce before chipselect is deasserted.
> +
> +\field{max_cs_incative_ns} is the maximum delay supported after chipselect is deasserted, in ns unit,
> +0 means delay is not supported to introduce after chipselect is deasserted.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / SPI Controller Device / Device Initialization}
> +
> +\begin{enumerate}
> +\item The Virtio SPI driver configures and initializes the virtqueue.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / SPI Controller Device / Device Operation}
> +
> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Controller Device / Device Operation: Request Queue}
> +
> +The Virtio SPI driver enqueues requests to the virtqueue, and they are used by Virtio SPI device.
> +Each request represents one SPI transfer and is of the form:
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_head {
> +        u8 chip_select_id;
> +        u8 bits_per_word;
> +        u8 cs_change;
> +        u8 tx_nbits;
> +        u8 rx_nbits;
> +        u8 reserved[3];
> +        le32 mode;
> +        le32 freq;
> +        le32 word_delay_ns;
> +        le32 cs_setup_ns;
> +        le32 cs_delay_hold_ns;
> +        le32 cs_change_delay_inactive_ns;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_result {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +\begin{lstlisting}
> +struct virtio_spi_transfer_req {
> +        struct virtio_spi_transfer_head head;
> +        u8 tx_buf[];
> +        u8 rx_buf[];
> +        struct virtio_spi_transfer_result result;
> +};
> +\end{lstlisting}
> +
> +\field{chip_select_id} indicates the chipselect index the SPI transfer used.

\field{chip_select_id} indicates the chipselect index to use for the SPI transfer.

> +\field{bits_per_word} indicates the number of bits in each SPI transfer word.
> +
> +\field{cs_change} indicates whether to deselect device before starting the next SPI transfer,
> +0 means chipselect keep asserted and 1 means chipselect deasserted then asserted again.
> +
> +\field{tx_nbits} indicates number of bits used for writing:
> +        0,1: SINGLE;
> +        2  : DUAL;
> +        4  : QUAD;
> +        8  : OCTAL;
> +        other values are invalid.
> +
> +\field{rx_nbits} indicates number of bits used for reading:
> +        0,1: SINGLE;
> +        2  : DUAL;
> +        4  : QUAD;
> +        8  : OCTAL;
> +        other values are invalid.

Duplication here can be removed too, like in the earlier example I gave.

Looks much better now. Thanks.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

