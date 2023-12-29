Return-Path: <virtio-dev-return-14204-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF03C46CD4
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9EF794218A
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9344298654C
	for <virtio-dev@archiver.kernel.org>; Fri, 29 Dec 2023 08:09:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 86C179862A5; Fri, 29 Dec 2023 08:09:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77DF698642F;
	Fri, 29 Dec 2023 08:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>,
        <cohuck@redhat.com>, <harald.mommer@opensynergy.com>,
        <broonie@kernel.org>, <viresh.kumar@linaro.org>
CC: <quic_ztu@quicinc.com>, Haixu Cui <quic_haixcui@quicinc.com>
Date: Fri, 29 Dec 2023 16:08:55 +0800
Message-ID: <20231229080855.16519-3-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231229080855.16519-1-quic_haixcui@quicinc.com>
References: <20231229080855.16519-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9x8FAACCgay6zUpqDSrMCD1gRLTX0mMT
X-Proofpoint-GUID: 9x8FAACCgay6zUpqDSrMCD1gRLTX0mMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312290063
Subject: [virtio-dev][PATCH V10 2/2] virtio-spi: add the device specification

The Virtio SPI (Serial Peripheral Interface) device is a virtual
SPI controller that allows the driver to operate and use the SPI
controller under the control of the host.

This patch adds the specification for virtio-spi.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 conformance.tex                         |  12 +-
 content.tex                             |   1 +
 device-types/spi/description.tex        | 286 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 +
 device-types/spi/driver-conformance.tex |   7 +
 5 files changed, 309 insertions(+), 4 deletions(-)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index dc00e84..af8aca0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / SPI Controller Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
-\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
-\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
+\ref{sec:Conformance / Device Conformance / SPI Controller Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
 \input{device-types/pmem/driver-conformance.tex}
+\input{device-types/spi/driver-conformance.tex}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
 \input{device-types/pmem/device-conformance.tex}
+\input{device-types/spi/device-conformance.tex}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index 1c608eb..84bc68f 100644
--- a/content.tex
+++ b/content.tex
@@ -767,6 +767,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/spi/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
new file mode 100644
index 0000000..84fd2c9
--- /dev/null
+++ b/device-types/spi/description.tex
@@ -0,0 +1,286 @@
+\section{SPI Controller Device}\label{sec:Device Types / SPI Controller Device}
+
+The Virtio SPI (Serial Peripheral Interface) device is a virtual SPI controller that
+allows the driver to operate and use the SPI controller under the control of the host,
+either a physical SPI controller, or an emulated one.
+
+The Virtio SPI device has a single virtqueue. SPI transfer requests are placed into
+the virtqueue by the driver, and are serviced by the device.
+
+In a typical host and guest architecture with the Virtio SPI device, the Virtio SPI driver
+is the front-end running in the guest, and the Virtio SPI device is the back-end
+in the host.
+
+\subsection{Device ID}\label{sec:Device Types / SPI Controller Device / Device ID}
+45
+
+\subsection{Virtqueues}\label{sec:Device Types / SPI Controller Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / SPI Controller Device / Feature bits}
+
+None
+
+\subsection{Device configuration layout}\label{sec:Device Types / SPI Controller Device / Device configuration layout}
+
+All fields of this configuration are mandatory and read-only for the driver.
+The config space shows the features and settings supported by the device.
+
+\begin{lstlisting}
+struct virtio_spi_config {
+	u8 cs_max_number;
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
+\field{cs_max_number} is the maximum number of chipselect the device supports.
+
+Note: chipselect is an electrical signal, which is used to select the SPI peripherals connected
+to the controller.
+
+\field{cs_change_supported} indicates if the device supports to toggle chipselect
+after each transfer in one message:
+        0: unsupported, chipselect will be kept in active state throughout the message transaction;
+        1: supported.
+
+Note: Message here contains a sequence of SPI transfers.
+
+\field{tx_nbits_supported} and \field{rx_nbits_supported} indicate the different n-bit transfer
+modes supported by the device, for writing and reading respectively. SINGLE is always supported.
+A set bit here indicates that the corresponding n-bit transfer is supported, otherwise not:
+        bit 0: DUAL;
+        bit 1: QUAD;
+        bit 2: OCTAL;
+        other bits are reserved and must be set as 0 by the device.
+
+Note: The commonly used SPI n-bit transfer options are:
+\begin{itemize}
+\item SINGLE: 1-bit transfer
+\item DUAL: 2-bit transfer
+\item QUAD: 4-bit transfer
+\item OCTAL: 8-bit transfer
+\end{itemize}
+
+\field{bits_per_word_mask} is a mask indicating which values of bits_per_word are supported.
+If bit n of \field{bits_per_word_mask} is set, the bits_per_word with value (n+1) is supported.
+If \field{bits_per_word_mask} is 0, there is no limitation for bits_per_word.
+
+Note: bits_per_word corresponds to \field{bits_per_word} in \field{struct virtio_spi_transfer_head}.
+
+\field{mode_func_supported} indicates whether the following features are supported or not:
+        bit 0-1: CPHA feature,
+            0b00: invalid, must support as least one CPHA setting.
+            0b01: supports CPHA=0 only;
+            0b10: supports CPHA=1 only;
+            0b11: supports CPHA=0 and CPHA=1;
+
+        bit 2-3: CPOL feature,
+            0b00: invalid, must support as least one CPOL setting.
+            0b01: supports CPOL=0 only;
+            0b10: supports CPOL=1 only;
+            0b11: supports CPOL=0 and CPOL=1;
+
+        bit 4: chipselect active high feature, 0 for unsupported and 1 for supported,
+            chipselect active low must always be supported.
+
+        bit 5: LSB first feature, 0 for unsupported and 1 for supported, MSB first must always be
+            supported.
+
+        bit 6: loopback mode feature, 0 for unsupported and 1 for supported, normal mode
+            must always be supported.
+
+Note: CPOL is clock polarity and CPHA is clock phase. If CPOL is 0, the clock idles at the logical
+low voltage, otherwise it idles at the logical high voltage. CPHA determines how data is outputted
+and sampled. If CPHA is 0, the first bit is outputted immediately when chipselect is active and
+subsequent bits are outputted on the clock edges when the clock transitions from active level to idle
+level. Data is sampled on the clock edges when the clock transitions from idle level to active level. 
+If CPHA is 1, the first bit is outputted on the fist clock edge after chipselect is active, subsequent
+bits are outputted on the clock edges when the clock transitions from idle level to active level.
+Data is sampled on the clock edges when the clock transitions from active level to idle level.
+
+Note: LSB first indicates that data is transferred least significant bit first, and MSB first
+indicates that data is transferred most significant bit first.
+
+\field{max_freq_hz} is the maximum clock rate supported in Hz unit, 0 means no limitation
+for transfer speed.
+
+\field{max_word_delay_ns} is the maximum word delay supported in ns unit, 0 means word delay
+feature is unsupported.
+
+Note: Just as one message contains a sequence of transfers, one transfer may contain
+a sequence of words.
+
+\field{max_cs_setup_ns} is the maximum delay supported after chipselect is asserted, in ns unit,
+0 means delay is not supported to introduce after chipselect is asserted.
+
+\field{max_cs_hold_ns} is the maximum delay supported before chipselect is deasserted, in ns unit,
+0 means delay is not supported to introduce before chipselect is deasserted.
+
+\field{max_cs_incative_ns} is the maximum delay supported after chipselect is deasserted, in ns unit,
+0 means delay is not supported to introduce after chipselect is deasserted.
+
+\subsection{Device Initialization}\label{sec:Device Types / SPI Controller Device / Device Initialization}
+
+\begin{enumerate}
+\item The Virtio SPI driver configures and initializes the virtqueue.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / SPI Controller Device / Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Controller Device / Device Operation: Request Queue}
+
+The Virtio SPI driver enqueues requests to the virtqueue, and they are used by the Virtio SPI device.
+Each request represents one SPI transfer and is of the form:
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
+\field{chip_select_id} indicates the chipselect index to use for the SPI transfer.
+
+\field{bits_per_word} indicates the number of bits in each SPI transfer word.
+
+\field{cs_change} indicates whether to deselect device before starting the next SPI transfer,
+0 means chipselect keep asserted and 1 means chipselect deasserted then asserted again.
+
+\field{tx_nbits} and \field{rx_nbits} indicate n-bit transfer mode for writing and reading:
+        0,1: SINGLE;
+        2  : DUAL;
+        4  : QUAD;
+        8  : OCTAL;
+        other values are invalid.
+
+\field{reserved} is currently unused and might be used for further extensions in the future.
+
+\field{mode} indicates some transfer settings. Bit definitions as follows:
+        bit 0: CPHA, determines the timing (i.e. phase) of the data bits relative to the
+	       clock pulses.
+        bit 1: CPOL, determines the polarity of the clock.
+        bit 2: CS_HIGH, if 1, chipselect active high, else active low.
+        bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB first, else LSB first.
+        bit 4: LOOP, if 1, device is in loopback mode, else normal mode.
+
+\field{freq} indicates the SPI transfer speed in Hz.
+
+\field{word_delay_ns} indicates delay to be inserted between consecutive words of a transfer,
+in ns unit.
+
+\field{cs_setup_ns} indicates delay to be introduced after chipselect is asserted, in ns unit.
+
+\field{cs_delay_hold_ns} indicates delay to be introduced before chipselect is deasserted,
+in ns unit.
+
+\field{cs_change_delay_inactive_ns} indicates delay to be introduced after chipselect is
+deasserted and before next asserted, in ns unit.
+
+\field{tx_buf} is the buffer for data sent to the device.
+
+\field{rx_buf} is the buffer for data received from the device.
+
+\field{result} is the transfer result, it may be one of the following values:
+
+\begin{lstlisting}
+#define VIRTIO_SPI_TRANS_OK     0
+#define VIRTIO_SPI_PARAM_ERR    1
+#define VIRTIO_SPI_TRANS_ERR    2
+\end{lstlisting}
+
+VIRTIO_SPI_TRANS_OK indicates successful completion of the transfer.
+
+VIRTIO_SPI_PARAM_ERR indicates a parameter error, which means the parameters in
+\field{struct virtio_spi_transfer_head} are not all valid, or some fields are set as
+non-zero values but the corresponding features are not supported by device.
+In particular, for full-duplex transfer, VIRTIO_SPI_PARAM_ERR can also indicate that
+\field{tx_buf} and \field{rx_buf} are not of the same length.
+
+VIRTIO_SPI_TRANS_ERR indicates a transfer error, which means that the parameters are all
+valid but the transfer process failed.
+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Controller Device / Device Operation: Operation Status}
+
+Fields in \field{struct virtio_spi_transfer_head} are written by the Virtio SPI driver, while
+\field{result} in \field{struct virtio_spi_transfer_result} is written by the Virtio SPI device.
+
+virtio-spi supports three transfer types:
+\begin{itemize}
+\item half-duplex read;
+\item half-duplex write;
+\item full-duplex transfer.
+\end{itemize}
+
+For half-duplex read and full-duplex transfer, \field{rx_buf} is filled by the Virtio SPI device
+and consumed by the Virtio SPI driver. For half-duplex write and full-duplex transfer, \field{tx_buf}
+is filled by the Virtio SPI driver and consumed by the Virtio SPI device.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Controller Device / Device Operation}
+
+For half-duplex read, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
+\field{rx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device in that order.
+
+For half-duplex write, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
+\field{tx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device in that order.
+
+For full-duplex transfer, the Virtio SPI driver MUST send \field{struct virtio_spi_transfer_head},
+\field{tx_buf}, \field{rx_buf} and \field{struct virtio_spi_transfer_result} to the SPI Virtio Device
+in that order.
+
+For full-duplex transfer, the Virtio SPI driver MUST guarantee that the buffer size of \field{tx_buf}
+and \field{rx_buf} is the same.
+
+The Virtio SPI driver MUST not use \field{rx_buf} if the \field{result} returned from the Virtio SPI device is
+not VIRTIO_SPI_TRANS_OK.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Controller Device / Device Operation}
+
+The Virtio SPI device MUST set all the fields of \field{struct virtio_spi_config} before they are
+read by the Virtio SPI driver.
+
+The Virtio SPI device MUST NOT change the data in \field{tx_buf}.
+
+The Virtio SPI device MUST verify the parameters in \field{struct virtio_spi_transfer_head} after receiving
+the request, and MUST set \field{struct virtio_spi_transfer_result} as VIRTIO_SPI_PARAM_ERR if not all
+parameters are valid or some device unsupported features are set.
+
+For full-duplex transfer, the Virtio SPI device MUST verify that the buffer size of \field{tx_buf} is equal to
+that of \field{rx_buf}. If not, the Virtio SPI device MUST set \field{struct virtio_spi_transfer_result}
+as VIRTIO_SPI_PARAM_ERR.
diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
new file mode 100644
index 0000000..4509156
--- /dev/null
+++ b/device-types/spi/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Controller Device Conformance}\label{sec:Conformance / Device Conformance / SPI Controller Device Conformance}
+
+An SPI Controller device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / SPI Controller Device / Device Operation}
+\end{itemize}
diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
new file mode 100644
index 0000000..bbd1967
--- /dev/null
+++ b/device-types/spi/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Controller Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Controller Driver Conformance}
+
+An SPI Controller driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / SPI Controller Device / Device Operation}
+\end{itemize}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

