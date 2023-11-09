Return-Path: <virtio-dev-return-14048-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714BFC4332F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 03:31:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D33C33E581
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 03:31:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3310986CC6
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Nov 2023 03:31:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B762B986CBA; Thu,  9 Nov 2023 03:31:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7C83986CBC;
	Thu,  9 Nov 2023 03:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="374948320"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="374948320"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="829178708"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="829178708"
Date: Thu, 9 Nov 2023 11:39:23 +0800
From: Qiang Zhang <qiang4.zhang@linux.intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	harald.mommer@opensynergy.com, cohuck@redhat.com,
	quic_ztu@quicinc.com
Message-ID: <ZUxUa+5510GLrKQh@qzhang4-desk.sh.intel.com>
References: <20231024125346.23546-1-quic_haixcui@quicinc.com>
 <ZUnpqRj4c2BbhaLI@qzhang4-desk.sh.intel.com>
 <f4f1013c-a474-4a82-bd7c-e0304d0e37ae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f1013c-a474-4a82-bd7c-e0304d0e37ae@quicinc.com>
Subject: Re: [virtio-dev] [PATCH v4] virtio-spi: add the device specification

On Thu, Nov 09, 2023 at 10:52:06AM +0800, Haixu Cui wrote:
>
>
>On 11/7/2023 3:40 PM, Qiang Zhang wrote:
>> On Tue, Oct 24, 2023 at 08:53:46PM +0800, Haixu Cui wrote:
>> > virtio-spi is a virtual SPI master and it allows a guest to operate and
>> > use the physical SPI master controlled by the host.
>> > 
>> > This patch adds the specification for virtio-spi.
>> > 
>> > Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
>> > ---
>> > device-types/spi/description.tex        | 206 ++++++++++++++++++++++++
>> > device-types/spi/device-conformance.tex |   7 +
>> > device-types/spi/driver-conformance.tex |   7 +
>> > 3 files changed, 220 insertions(+)
>> > create mode 100644 device-types/spi/description.tex
>> > create mode 100644 device-types/spi/device-conformance.tex
>> > create mode 100644 device-types/spi/driver-conformance.tex
>> > 
>> > diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
>> > new file mode 100644
>> > index 0000000..5dbceaf
>> > --- /dev/null
>> > +++ b/device-types/spi/description.tex
>> > @@ -0,0 +1,206 @@
>> > +\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
>> > +
>> > +virtio-spi is a virtual SPI (Serial Peripheral Interface) master and it allows
>> > +a guest to operate and use the physical SPI master controlled by the host.
>> > +
>> > +virtio-spi has a single virtqueue. SPI transfer requests are placed into
>> > +the virtqueue, and serviced by the physical SPI master.
>> > +
>> > +In a typical host and guest architecture with virtio-spi, Virtio SPI driver is
>> > +the front-end existing in the guest kernel, and Virtio SPI device acts as the
>> > +back-end in the host platform.
>> > +
>> > +\subsection{Device ID}\label{sec:Device Types / SPI Master Device / Device ID}
>> > +45
>> > +
>> > +\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / Virtqueues}
>> > +
>> > +\begin{description}
>> > +\item[0] requestq
>> > +\end{description}
>> > +
>> > +\subsection{Feature bits}\label{sec:Device Types / SPI Master Device / Feature bits}
>> > +
>> > +None
>> > +
>> > +\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
>> > +
>> > +All fields of this configuration are always available and read-only for Virtio SPI driver.
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_spi_config {
>> > +	le16 bus_num;
>> > +	le16 chip_select_max_number;
>> > +	le8 cs_timing_setting_enable;
>> > +	le8 reserved[3];
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +The \field{bus_num} indicates the physical SPI master assigned to guest.
>> 
>> Does this assume that a Virtio SPI controller always corresponds to a physical
>> SPI controller?
>> What if the backend SPI controller and SPI devices are fully emulated or the
>> SPI devices under the Virtio SPI controller come from multiple physical SPI
>> controllers?
>> 
>> Regards,
>> Qiang
>> 
>
>Hi Qiang,
>
>    It's quite possible the host SPI controller is not physical, but
>virtualized controller. In next patch, I will use "host SPI controller" to
>replace "physical SPI controller", "host SPI controller" represents all kinds
>of controller controlled by the host, which is more appropriate.

I think the meaning of "Host Controller" is a little bit opaque and is not
really necessary.

Hypervisor doesn't need to give guest an "id" of the Virtio SPI controller,
since this can be achieved by ACPI/DT in guest.

If guest needs to aware the topology of the backend, it's better to use
other mechanisms becuase it is board or configuration specific.

>
>    A Virtio SPI controller corresponds with a host SPI controller, and the
>guest can only access the devices under this host SPI controller, with the
>assigned cs. For devices under other host controllers, the guest cannot
>access.

We should allow the backend to emulate a SPI controller attached with physical
SPI devices from multiple physical SPI controllers. Anyway, this depends on
the backend implementation. We just give enough flexibility.


Regards,
Qiang

>
>    Thank you for your findings and comments.
>
>Best Regards
>Haixu Cui
>
>
>> > +
>> > +The \field{chip_select_max_number} is the maximum number of chipselect the physical SPI master supports.
>> > +
>> > +The \field{cs_timing_setting_enable} indicates if the physical SPI master supporting cs timing setting:
>> > +	0: physical SPI master doesn't support cs timing setting;
>> > +	1: physical SPI master supports cs timing setting.
>> > +
>> > +The \field{reserved} is for alignment purpose, also for future extension.
>> > +
>> > +\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
>> > +
>> > +\begin{enumerate}
>> > +\item The Virtio SPI driver configures and initializes the virtqueue.
>> > +\end{enumerate}
>> > +
>> > +\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
>> > +
>> > +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
>> > +
>> > +Virtio SPI driver enqueues requests to the virtqueue, and they are used by
>> > +Virtio SPI device. Each request represents one SPI tranfer and is of the form:
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_spi_transfer_head {
>> > +        u8 slave_id;
>> > +        u8 bits_per_word;
>> > +        u8 cs_change;
>> > +        u8 tx_nbits;
>> > +        u8 rx_nbits;
>> > +	 u8 reserved[3];
>> > +        le32 mode;
>> > +        le32 freq;
>> > +        le32 word_delay_ns;
>> > +        le32 cs_setup_ns;
>> > +        le32 cs_delay_hold_ns;
>> > +        le32 cs_change_delay_inactive_ns;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_spi_transfer_result {
>> > +        u8 result;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +\begin{lstlisting}
>> > +struct virtio_spi_transfer_req {
>> > +        struct virtio_spi_transfer_head head;
>> > +        u8 tx_buf[];
>> > +        u8 rx_buf[];
>> > +        struct virtio_spi_transfer_result result;
>> > +};
>> > +\end{lstlisting}
>> > +
>> > +The \field{slave_id} indicates the chipselect index the SPI transfer used.
>> > +
>> > +The \field{bits_per_word} indicates the number of bits in each SPI transfer word.
>> > +
>> > +The \field{cs_change} indicates whether to deselect device before starting the
>> > +next SPI transfer, 0 means chipselect keep asserted and 1 means chipselect deasserted
>> > +then asserted again.
>> > +
>> > +The \field{tx_nbits} indicates bus width for write transfer:
>> > +        0,1: bus width is 1, also known as SINGLE;
>> > +	2  : bus width is 2, also known as DUAL;
>> > +	4  : bus width is 4, also known as QUAD;
>> > +	8  : bus width is 8, also known as OCTAL;
>> > +	other values are invalid.
>> > +
>> > +The \field{rx_nbits} indicates bus width for read transfer:
>> > +        0,1: bus width is 1, also known as SINGLE;
>> > +	2  : bus width is 2, also known as DUAL;
>> > +	4  : bus width is 4, also known as QUAD;
>> > +	8  : bus width is 8, also known as OCTAL;
>> > +	other values are invalid.
>> > +
>> > +The \field{reserved} is for alignement, also for further extension.
>> > +
>> > +The \field{mode} indicates how data is clocked out and in. Bit definitions as follows:
>> > +        bit 0: CPHA, determines the timing (i.e. phase) of the data bits
>> > +	       relative to the clock pulses.
>> > +        bit 1: CPOL, determines the polarity of the clock.
>> > +        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
>> > +	bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>> > +	       first, else LSB first.
>> > +	bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
>> > +
>> > +The \field{freq} indicates the SPI transfer speed in Hz.
>> > +
>> > +The \field{word_delay_ns} indicates delay to be inserted between consecutive
>> > +words of a transfer, in ns unit.
>> > +
>> > +The \field{cs_setup_ns} indicates delay to be introduced after chipselect
>> > +is asserted, in ns unit.
>> > +
>> > +The \field{cs_delay_hold_ns} indicates delay to be introduced before chipselect
>> > +is deasserted, in ns unit.
>> > +
>> > +The \field{cs_change_delay_inactive_ns} indicates delay to be introduced after
>> > +chipselect is deasserted and before next asserted, in ns unit.
>> > +
>> > +The \field{tx_buf} is the buffer for data sent to the device.
>> > +
>> > +The \field{rx_buf} is the buffer for data received to the device.
>> > +
>> > +The final \field{result} is the transfer result, either VIRTIO_SPI_TRANS_OK for success
>> > +or VIRTIO_SPI_TRANS_ERR for error.
>> > +
>> > +\begin{lstlisting}
>> > +#define VIRTIO_SPI_TRANS_OK     0
>> > +#define VIRTIO_SPI_TRANS_ERR    1
>> > +\end{lstlisting}
>> > +
>> > +\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
>> > +
>> > +Fields in structure \field{virtio_spi_transfer_head} are written by Virtio SPI driver, while
>> > +\field{result} in structure \field{virtio_spi_transfer_result} is written by Virtio SPI device.
>> > +
>> > +virtio-spi supports three transfer types:
>> > +        1) half-duplex read;
>> > +        2) half-duplex write;
>> > +        3) full-duplex read and write.
>> > +
>> > +For half-duplex read transfer, \field{rx_buf} is filled by Virtio SPI device and consumed
>> > +by Virtio SPI driver. For half-duplex write transfer, \field{tx_buf} is filled by Virtio
>> > +SPI driver and consumed by Virtio SPI device. And for full-duplex read and write transfer,
>> > +both \field{tx_buf} and \field{rx_buf} are used.
>> > +
>> > +\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
>> > +
>> > +The Virtio SPI driver MUST send transfer requests on the requestq virtqueue.
>> > +
>> > +Fields in structure \field{virtio_spi_transfer_head} MUST be filled by Virtio SPI driver
>> > +and MUST be readable for Virtio SPI device.
>> > +
>> > +Structure \field{virtio_spi_transfer_result} MUST be filled by Virtio SPI device
>> > +and MUST be writable for Virtio SPI device.
>> > +
>> > +For half-duplex read, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
>> > +\field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
>> > +
>> > +For half-duplex write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
>> > +\field{tx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
>> > +
>> > +For full-duplex read and write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
>> > +\field{tx_buf}, \field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
>> > +
>> > +For half-duplex write or full-duplex read and write transfer, Virtio SPI driver MUST not use \field{rx_buf}
>> > +if the \field{result} returned from Virtio SPI device is VIRTIO_SPI_TRANS_ERR.
>> > +
>> > +If \field{cs_timing_setting_enable} in structure \field{virtio_spi_config} is 0, while \field{cs_setup_ns},
>> > +\field{cs_setup_ns} and \field{cs_change_delay_inactive_ns} of the transfer are not all zero, Virtio
>> > +SPI driver MUST print a warning log to alert that the cs timing won't be set as expected.
>> > +
>> > +\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
>> > +
>> > +Virtio SPI device MUST set all the fields of the structure \field{virtio_spi_config} before
>> > +they are read by Virtio SPI driver.
>> > +
>> > +Virtio SPI device MUST set the structure \field{virtio_spi_transfer_result} before sending
>> > +it back to Virtio SPI driver.
>> > +
>> > +Virtio SPI device MUST be able to identify the transfer type according to the received
>> > +virtqueue descriptors.
>> > +
>> > +Virtio SPI device MUST NOT change the data in \field{tx_buf} if transfer type is half-duplex write
>> > +or full-duplex read and write.
>> > diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
>> > new file mode 100644
>> > index 0000000..3e771bc
>> > --- /dev/null
>> > +++ b/device-types/spi/device-conformance.tex
>> > @@ -0,0 +1,7 @@
>> > +\conformance{\subsection}{SPI Master Device Conformance}\label{sec:Conformance / Device Conformance / SPI Master Device Conformance}
>> > +
>> > +An SPI Master device MUST conform to the following normative statements:
>> > +
>> > +\begin{itemize}
>> > +\item \ref{devicenormative:Device Types / SPI Master Device / Device Operation}
>> > +\end{itemize}
>> > diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
>> > new file mode 100644
>> > index 0000000..3c965ef
>> > --- /dev/null
>> > +++ b/device-types/spi/driver-conformance.tex
>> > @@ -0,0 +1,7 @@
>> > +\conformance{\subsection}{SPI Master Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Master Driver Conformance}
>> > +
>> > +An SPI Master driver MUST conform to the following normative statements:
>> > +
>> > +\begin{itemize}
>> > +\item \ref{drivernormative:Device Types / SPI Master Device / Device Operation}
>> > +\end{itemize}
>> > -- 
>> > 2.17.1
>> > 
>> > 
>> > ---------------------------------------------------------------------
>> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

