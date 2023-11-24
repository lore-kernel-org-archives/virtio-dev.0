Return-Path: <virtio-dev-return-14064-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FF9C61D97
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Nov 2023 07:21:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 966B045B3A
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Nov 2023 07:21:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8254A9868B9
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Nov 2023 07:21:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 71D689868A7; Fri, 24 Nov 2023 07:21:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F2B59868A5;
	Fri, 24 Nov 2023 07:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <qiang4.zhang@linux.intel.com>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Fri, 24 Nov 2023 15:20:15 +0800
Message-ID: <20231124072015.12655-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KxaQ5O8rLYIeRCgpgOgQ1-dQdBiFdtzl
X-Proofpoint-GUID: KxaQ5O8rLYIeRCgpgOgQ1-dQdBiFdtzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240055
Subject: [virtio-dev] [PATCH] [PATCH v5] virtio-spi: add the device specification

virtio-spi is a virtual SPI (Serial Peripheral Interface) controller and it allows
a guest to operate and use the host SPI controller.

This patch adds the specification for virtio-spi.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 device-types/spi/description.tex        | 281 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 +
 device-types/spi/driver-conformance.tex |   7 +
 3 files changed, 295 insertions(+)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
new file mode 100644
index 0000000..8ca8c0d
--- /dev/null
+++ b/device-types/spi/description.tex
@@ -0,0 +1,281 @@
+\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
+
+virtio-spi is a virtual SPI (Serial Peripheral Interface) controller and it allows
+a guest to operate and use the host SPI controller. Host SPI controller may be a
+physical controller, or a virtual one(e.g. controller emulated by the software
+running in the host).
+
+virtio-spi has a single virtqueue. SPI transfer requests are placed into
+the virtqueue, and serviced by the host SPI controller.
+
+In a typical host and guest architecture with virtio-spi, Virtio SPI driver is
+the front-end running in the guest kernel, and Virtio SPI device acts as the
+back-end in the host.
+
+\subsection{Device ID}\label{sec:Device Types / SPI Master Device / Device ID}
+45
+
+\subsection{Virtqueues}\label{sec:Device Types / SPI Master Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / SPI Master Device / Feature bits}
+
+None
+
+\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
+
+All fields of this configuration are always available and read-only for Virtio SPI driver.
+The config space shows the features and settings supported by the host SPI controller.
+
+\begin{lstlisting}
+struct virtio_spi_config {
+	u8 chip_select_max_number;
+	u8 cs_change_supported;
+	u8 tx_nbits_supported;
+	u8 rx_nbits_supported;
+	le32 bits_per_word_mask;
+	le32 mode_func_supported;
+	le32 max_freq_hz;
+	le32 max_word_delay_ns;
+	le32 max_cs_setup_ns;
+	le32 max_cs_hold_ns;
+	le32 max_cs_inactive_ns;
+};
+\end{lstlisting}
+
+The \field{chip_select_max_number} is the maximum number of chipselect the host SPI controller supports.
+
+The \field{cs_change_supported} indicates if the host SPI controller supports to toggle chipselect
+after each transfer in one message:
+        0: supported;
+        1: unsupported, means chipselect will keep active when executing the message transaction.
+Note: Message here contains a sequence of SPI transfer.
+
+The \field{tx_nbits_supported} indicates the supported number of bit for writing:
+        bit 0: 2-bit transfer, 0 for unsupported and 1 for supported;
+        bit 1: 4-bit transfer, 0 for unsupported and 1 for supported;
+        bit 2: 8-bit transfer, 0 for unsupported and 1 for supported;
+        other bits are reserved as 0, 1-bit transfer is always supported.
+
+The \field{rx_nbits_supported} indicates the supported number of bit for reading:
+        bit 0: 2-bit transfer, 0 for unsupported and 1 for supported;
+        bit 1: 4-bit transfer, 0 for unsupported and 1 for supported;
+        bit 2: 8-bit transfer, 0 for unsupported and 1 for supported;
+        other bits are reserved as 0, 1-bit transfer is always supported.
+
+The \field{bits_per_word_mask} is a mask indicating which values of bits_per_word
+are supported. If not set, no limitation for bits_per_word.
+Note: bits_per_word corresponds to \field{bits_per_word} field in
+structure \field{virtio_spi_transfer_head}, see below.
+
+The \field{mode_func_supported} indicates the following features are supported or not:
+        bit 0-1: CPHA feature,
+            0b00: supports CPHA=0 and CPHA=1;
+            0b01: supports CPHA=0 only;
+            0b10: supports CPHA=1 only;
+            0b11: invalid, should support as least one CPHA setting.
+
+        bit 2-3: CPOL feature,
+            0b00: supports CPOL=0 and CPOL=1;
+            0b01: supports CPOL=0 only;
+            0b10: supports CPOL=1 only;
+            0b11: invalid, should support as least one CPOL setting.
+
+        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
+            chipselect active low should always be supported.
+
+        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first should always be
+            supported.
+
+        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
+            should always be supported.
+
+The \field{max_freq_hz} is the maximum clock rate supported in Hz unit, 0 means no
+limitation for transfer speed.
+
+The \field{max_word_delay_ns} is the maximum word delay supported in ns unit, 0 means
+word delay feature is unsupported.
+Note: Just as one message contains a sequence of transfers, one transfer may contain
+a sequence of word.
+
+The \field{max_cs_setup_ns} is the maximum delay supported after chipselect is asserted, in ns unit,
+0 means delay is not supported to introduce after chipselect is asserted.
+
+The \field{max_cs_hold_ns} is the maximum delay supported before chipselect is deasserted, in ns unit,
+0 means delay is not supported to introduce before chipselect is deasserted.
+
+The \field{max_cs_incative_ns} is the maximum delay supported after chipselect is deasserted, in ns unit,
+0 means delay is not supported to introduce after chipselect is deasserted.
+
+\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
+
+\begin{enumerate}
+\item The Virtio SPI driver configures and initializes the virtqueue.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
+
+Virtio SPI driver enqueues requests to the virtqueue, and they are used by Virtio SPI device.
+Each request represents one SPI tranfer and is of the form:
+
+\begin{lstlisting}
+struct virtio_spi_transfer_head {
+        u8 chip_select_id;
+        u8 bits_per_word;
+        u8 cs_change;
+        u8 tx_nbits;
+        u8 rx_nbits;
+        u8 reserved[3];
+        le32 mode;
+        le32 freq;
+        le32 word_delay_ns;
+        le32 cs_setup_ns;
+        le32 cs_delay_hold_ns;
+        le32 cs_change_delay_inactive_ns;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_spi_transfer_result {
+        u8 result;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_spi_transfer_req {
+        struct virtio_spi_transfer_head head;
+        u8 tx_buf[];
+        u8 rx_buf[];
+        struct virtio_spi_transfer_result result;
+};
+\end{lstlisting}
+
+The \field{chip_select_id} indicates the chipselect index the SPI transfer used.
+
+The \field{bits_per_word} indicates the number of bits in each SPI transfer word.
+
+The \field{cs_change} indicates whether to deselect device before starting the
+next SPI transfer, 0 means chipselect keep asserted and 1 means chipselect deasserted
+then asserted again.
+
+The \field{tx_nbits} indicates number of bits used for writing:
+        0,1: 1-bit transfer, also known as SINGLE;
+        2  : 2-bit transfer, also known as DUAL;
+        4  : 4-bit transfer, also known as QUAD;
+        8  : 8-bit transfer, also known as OCTAL;
+        other values are invalid.
+
+The \field{rx_nbits} indicates number of bits used for reading:
+        0,1: 1-bit transfer, also known as SINGLE;
+        2  : 2-bit transfer, also known as DUAL;
+        4  : 4-bit transfer, also known as QUAD;
+        8  : 8-bit transfer, also known as OCTAL;
+        other values are invalid.
+
+The \field{reserved} is for alignement, also for further extension.
+
+The \field{mode} indicates some transfer settings. Bit definitions as follows:
+        bit 0: CPHA, determines the timing (i.e. phase) of the data bits
+	       relative to the clock pulses.
+        bit 1: CPOL, determines the polarity of the clock.
+        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
+        bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
+	       first, else LSB first.
+        bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
+
+The \field{freq} indicates the SPI transfer speed in Hz.
+
+The \field{word_delay_ns} indicates delay to be inserted between consecutive
+words of a transfer, in ns unit.
+
+The \field{cs_setup_ns} indicates delay to be introduced after chipselect
+is asserted, in ns unit.
+
+The \field{cs_delay_hold_ns} indicates delay to be introduced before chipselect
+is deasserted, in ns unit.
+
+The \field{cs_change_delay_inactive_ns} indicates delay to be introduced after
+chipselect is deasserted and before next asserted, in ns unit.
+
+The \field{tx_buf} is the buffer for data sent to the device.
+
+The \field{rx_buf} is the buffer for data received from the device.
+
+The final \field{result} is the transfer result, VIRTIO_SPI_TRANS_OK for success,
+VIRTIO_SPI_PARAM_ERR for parameter error, which means the parameters in 
+\field{virtio_spi_transfer_head} are not all valid, or some fields are set as non-zero values
+but the corresponding features are not supported by host, while
+VIRTIO_SPI_TRANS_ERR for transfer error, means that the parameters are all
+valid but trasnfer process failed.
+
+\begin{lstlisting}
+#define VIRTIO_SPI_TRANS_OK     0
+#define VIRTIO_SPI_PARAM_ERR    1
+#define VIRTIO_SPI_TRANS_ERR    2
+\end{lstlisting}
+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
+
+Fields in structure \field{virtio_spi_transfer_head} are written by Virtio SPI driver, while
+\field{result} in structure \field{virtio_spi_transfer_result} is written by Virtio SPI device.
+
+virtio-spi supports three transfer types:
+        1) half-duplex read;
+        2) half-duplex write;
+        3) full-duplex read and write. 
+
+For half-duplex read transfer, \field{rx_buf} is filled by Virtio SPI device and consumed
+by Virtio SPI driver. For half-duplex write transfer, \field{tx_buf} is filled by Virtio 
+SPI driver and consumed by Virtio SPI device. And for full-duplex read and write transfer,
+both \field{tx_buf} and \field{rx_buf} are used.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
+
+The Virtio SPI driver MUST send transfer requests on the requestq virtqueue.
+
+Fields in structure \field{virtio_spi_transfer_head} MUST be filled by Virtio SPI driver
+and MUST be readable for Virtio SPI device.
+
+Structure \field{virtio_spi_transfer_result} MUST be filled by Virtio SPI device
+and MUST be writable for Virtio SPI device.
+
+For half-duplex read, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
+\field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
+
+For half-duplex write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head},
+\field{tx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
+
+For full-duplex read and write, Virtio SPI driver MUST send structure \field{virtio_spi_transfer_head}, 
+\field{tx_buf}, \field{rx_buf} and structure \field{virtio_spi_transfer_result} to SPI Virtio Device in order.
+
+For half-duplex read or full-duplex read and write transfer, Virtio SPI driver MUST not use \field{rx_buf}
+if the \field{result} returned from Virtio SPI device is not VIRTIO_SPI_TRANS_OK.
+
+For each transfer request, Virtio SPI driver MUST check the fields in structure \field{virtio_spi_transfer_head}
+and MUST reject the request if any filed is invalid or enabling the features not supported by host.
+For example, if \field{freq} in structure \field{virtio_spi_transfer_head} is greater than \field{max_freq_hz}
+in config space, or if \field{max_cs_setup_ns} in config space is 0 while \field{cs_setup_ns} in structure
+\field{virtio_spi_transfer_head} is non-zero, Virtio SPI driver will reject such request.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
+
+Virtio SPI device MUST set all the fields of the structure \field{virtio_spi_config} before
+they are read by Virtio SPI driver.
+
+Virtio SPI device MUST set the structure \field{virtio_spi_transfer_result} before sending
+it back to Virtio SPI driver.
+
+Virtio SPI device MUST be able to identify the transfer type according to the received
+virtqueue descriptors.
+
+Virtio SPI device MUST NOT change the data in \field{tx_buf} if transfer type is half-duplex write
+or full-duplex read and write.
+
+Virtio SPI device MUST verify the parameters in \field{virtio_spi_transfer_head} after receiving the request,
+and MUST set \field{virtio_spi_transfer_result} as VIRTIO_SPI_PARAM_ERR if not all parameters are valid or
+some host SPI controller unsupported features are set.
diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
new file mode 100644
index 0000000..3e771bc
--- /dev/null
+++ b/device-types/spi/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Master Device Conformance}\label{sec:Conformance / Device Conformance / SPI Master Device Conformance}
+
+An SPI Master device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / SPI Master Device / Device Operation}
+\end{itemize}
diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
new file mode 100644
index 0000000..3c965ef
--- /dev/null
+++ b/device-types/spi/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Master Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Master Driver Conformance}
+
+An SPI Master driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / SPI Master Device / Device Operation}
+\end{itemize}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

