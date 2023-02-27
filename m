Return-Path: <virtio-dev-return-11309-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B7BC7EE2D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:23:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E9EF92B054
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:23:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA174986561
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:23:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AD00A9863FE; Mon, 27 Feb 2023 08:23:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 985139863F0;
	Mon, 27 Feb 2023 08:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <virtio-dev@lists.oasis-open.org>, <virtio-comment@lists.oasis-open.org>
CC: Haixu Cui <quic_haixcui@quicinc.com>, <quic_ztu@quicinc.com>
Date: Mon, 27 Feb 2023 16:23:29 +0800
Message-ID: <20230227082329.31337-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GBO2Uz3f84x-wtPQmav3DbmlXqWyPIla
X-Proofpoint-ORIG-GUID: GBO2Uz3f84x-wtPQmav3DbmlXqWyPIla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270064
Subject: [virtio-dev] [PATCH] virtio-spi: add the device specification
Message-ID: <20230227082329.cqodTRG_H7eHU0jlx2rE2D0lg0uDJrlHkYlfdnvKTFU@z>

virtio-spi is a virtual SPI master and it allows a guset to operate and
use the physical SPI master controlled by the host.

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 content.tex                             |   2 +
 device-types/spi/description.tex        | 153 ++++++++++++++++++++++++
 device-types/spi/device-conformance.tex |   7 ++
 device-types/spi/driver-conformance.tex |   7 ++
 4 files changed, 169 insertions(+)
 create mode 100644 device-types/spi/description.tex
 create mode 100644 device-types/spi/device-conformance.tex
 create mode 100644 device-types/spi/driver-conformance.tex

diff --git a/content.tex b/content.tex
index 0c7cdf8..86bf709 100644
--- a/content.tex
+++ b/content.tex
@@ -2994,6 +2994,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 44         &   ISM device \\
 \hline
+45         &   SPI Master \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
diff --git a/device-types/spi/description.tex b/device-types/spi/description.tex
new file mode 100644
index 0000000..0b69700
--- /dev/null
+++ b/device-types/spi/description.tex
@@ -0,0 +1,153 @@
+\section{SPI Master Device}\label{sec:Device Types / SPI Master Device}
+
+virtio-spi is a virtual SPI master and it allows a guest to operate and use
+the physical SPI master devices controlled by the host.
+
+In a typical host and guest architecture with Virtio SPI, Virtio SPI driver 
+is the front-end and exists in the guest kernel, Virtio SPI device acts as 
+the back-end and exists in the host. And VirtQueues assist Virtio SPI driver 
+and Virtio SPI device in perform VRing operations for communication between 
+the front-end and the back-end.
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
+None.
+
+\subsection{Device configuration layout}\label{sec:Device Types / SPI Master Device / Device configuration layout}
+
+All fields of this configuration are always available and read-only for the Virtio SPI driver.
+
+\begin{lstlisting}
+struct virtio_spi_config {
+    u32 bus_num;
+    u32 chip_select_max_number;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{bus_num}] is the physical spi master assigned to guset, and this is SOC-specific.
+
+\item[\field{chip_select_max_number}] is the number of chipselect the physical spi master supported.
+\end{description}
+
+\subsection{Device Initialization}\label{sec:Device Types / SPI Master Device / Device Initialization}
+
+\begin{itemize}
+\item The Virtio SPI driver configures and initializes the virtqueue.
+
+\item The Virtio SPI driver allocates and registers the virtual SPI master.
+\end{itemize}
+
+\subsection{Device Operation}\label{sec:Device Types / SPI Master Device / Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / SPI Master Device / Device Operation: Request Queue}
+
+The Virtio SPI driver queues requests to the virtqueue, and they are used by the
+Virtio SPI device. Each request represents one SPI transfer and it is of the form:
+
+\begin{lstlisting}
+struct virtio_spi_transfer_head {
+    u32 mode;
+    u32 freq;
+    u32 word_delay;
+    u8 slave_id;
+    u8 bits_per_word;
+    u8 cs_change;
+    u8 reserved;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_spi_transfer_end {
+    u8 status;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_spi_req {
+    struct virtio_spi_transfer_head head;
+    u8 *rx_buf;
+    u8 *tx_buf;
+    struct virtio_spi_transfer_end end;
+};
+\end{lstlisting}
+
+The \field{mode} defines the SPI transfer mode.
+
+The \field{freq} defines the SPI transfer speed in Hz.
+
+The \field{word_delay} defines how long to wait between words within one SPI transfer,
+in ns unit.
+
+The \field{slave_id} defines the chipselect index the SPI transfer used.
+
+The \field{bits_per_word} defines the number of bits in each SPI transfer word.
+
+The \field{cs_change} defines whether to deselect device before starting the next SPI transfer.
+
+The \field{rx_buf} is the receive buffer, used to hold the data received from the external device.
+
+The \field{tx_buf} is the transmit buffer, used to hold the data sent to the external device.
+
+The final \field{status} byte of the request is written by the Virtio SPI device: either
+VIRTIO_SPI_MSG_OK for success or VIRTIO_SPI_MSG_ERR for error.
+
+\begin{lstlisting}
+#define VIRTIO_SPI_MSG_OK     0
+#define VIRTIO_SPI_MSG_ERR    1
+\end{lstlisting}
+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / SPI Master Device / Device Operation: Operation Status}
+
+Members in \field{struct virtio_spi_transfer_head} are determined by the Virtio SPI driver, while \field{status} 
+in \field{struct virtio_spi_transfer_end} is determined by the processing of the Virtio SPI device.
+
+Virtio SPI supports three transfer types: 1) half-duplex read, 2) half-duplex write, 3) full-duplex read and write.
+For half-duplex read transfer, \field{rx_buf} is filled by the Virtio SPI device and consumed by the Virtio SPI driver.
+For half-duplex write transfer, \field{tx_buf} is filled by the Virtio SPI driver and consumed by the Virtio SPI device.
+And for full-duplex read and write transfer, both \field{tx_buf} and \field{rx_buf} are used.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
+
+The Virtio SPI driver MUST send messages on the requestq virtqueue.
+
+The \field{struct spi_transfer_head} MUST be filled by the Virtio SPI driver 
+and MUST be readable for the Virtio SPI device.
+
+The \field{struct spi_transfer_end} MUST be filled by the Virtio SPI device 
+and MUST be writable for the Virtio SPI device.
+
+For half-duplex read, the Virtio SPI driver MUST send \field{struct spi_transfer_head}, 
+\field{rx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
+
+For half-duplex write, the Virtio SPI driver MUST send \field{struct spi_transfer_head}, 
+\field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
+
+For full-duplex read and write, the Virtio SPI driver MUST send \field{struct spi_transfer_head}, 
+\field{rx_buf}, \field{tx_buf} and \field{struct spi_transfer_end} to the SPI Virtio Device in order.
+
+For half-duplex write or full-duplex read and write, the Virtio SPI driver MUST not use
+\field{rx_buf} if the final \field{status} returned from the Virtio SPI device is VIRTIO_SPI_MSG_ERR.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / SPI Master Device / Device Operation}
+
+The Virtio SPI device MUST set all the fields of the \field{struct virtio_spi_config} on 
+receiving a configuration request from the Virtio SPI driver.
+
+The Virtio SPI device MUST set the \field{struct spi_transfer_end} before sending it 
+back to the Virtio SPI driver.
+
+The Virtio SPI device MUST be able to identify the transfer type according to the 
+received VirtQueue descriptors.
+
+The Virtio SPI device MUST NOT change the value of the send buffer if transfer type 
+is half-duplex write or full-duplex read and write.
diff --git a/device-types/spi/device-conformance.tex b/device-types/spi/device-conformance.tex
new file mode 100644
index 0000000..b9dea91
--- /dev/null
+++ b/device-types/spi/device-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Master Device Conformance}\label{sec:Conformance / Device Conformance / SPI Master Device Conformance}
+
+A SPI Master device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / SPI Master Device / Device Operation}
+\end{itemize}
diff --git a/device-types/spi/driver-conformance.tex b/device-types/spi/driver-conformance.tex
new file mode 100644
index 0000000..719b42e
--- /dev/null
+++ b/device-types/spi/driver-conformance.tex
@@ -0,0 +1,7 @@
+\conformance{\subsection}{SPI Master Driver Conformance}\label{sec:Conformance / Driver Conformance / SPI Master Driver Conformance}
+
+A SPI Master driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / SPI Master Device / Device Operation}
+\end{itemize}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

