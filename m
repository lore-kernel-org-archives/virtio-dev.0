Return-Path: virtio-dev-return-5897-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDDA8985B47
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Jul 2019 13:41:20 +0000 (UTC)
From: Huang Yang <yang.huang@intel.com>
Date: Tue, 30 Jul 2019 21:46:14 +0800
Message-Id: <1564494374-16147-1-git-send-email-yang.huang@intel.com>
Subject: [virtio-dev] [PATCH v2] Add virtio rpmb device specification
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com, Huang Yang <yang.huang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

It is a virtio based RPMB (Replay Protected Memory Block) device.

Signed-off-by: Yang Huang <yang.huang@intel.com>
Reviewed-by: Bing Zhu <bing.zhu@intel.com>
Reviewed-by: Tomas Winkler <tomas.winkler@intel.com>

v1 -> v2:
1. update conformance.
2. wordings change:
   first initialization -> first device initialization
   device size -> device capacity
3. update Device Operation:
   add more decriptions on write counter, key and write operations.
---
 conformance.tex |  19 ++++++++++-
 content.tex     |   3 ++
 virtio-rpmb.tex | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 virtio-rpmb.tex

diff --git a/conformance.tex b/conformance.tex
index 0ac58aa..e0c55e0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -22,7 +22,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
-    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, \ref{sec:Conformance / Device Conformance / Socket Device Conformance} or \ref{sec:Conformance / Device Conformance / RPMB Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -183,6 +183,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
 \end{itemize}
 
+\conformance{\subsection}{RPMB Driver Conformance}\label{sec:Conformance / Driver Conformance / RPMB Driver Conformance}
+
+A RPMB driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / RPMB Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -338,6 +346,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
 \end{itemize}
 
+\conformance{\subsection}{RPMB Device Conformance}\label{sec:Conformance / Device Conformance / RPMB Device Conformance}
+
+An RPMB device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Initialization}
+\item \ref{devicenormative:Device Types / RPMB Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index ee0d7c9..7f54f94 100644
--- a/content.tex
+++ b/content.tex
@@ -2717,6 +2717,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 27         &   PMEM device \\
 \hline
+28         &   RPMB device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
@@ -5677,6 +5679,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
+\input{virtio-rpmb.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-rpmb.tex b/virtio-rpmb.tex
new file mode 100644
index 0000000..aa113bb
--- /dev/null
+++ b/virtio-rpmb.tex
@@ -0,0 +1,100 @@
+\section{RPMB Device}\label{sec:Device Types / RPMB Device}
+
+virtio-rpmb is a virtio based RPMB (Replay Protected Memory Block)
+device. It is used as a tamper-resistant and anti-replay storage.
+It supports four command requests including read, write, get write
+counter and program key. They are placed in the queue.
+
+\subsection{Device ID}\label{sec:Device Types / RPMB Device / Device ID}
+
+28
+
+\subsection{Virtqueues}\label{sec:Device Types / RPMB Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / RPMB Device / Feature bits}
+
+None.
+
+\subsection{Device configuration layout}\label{sec:Device Types / RPMB Device / Device configuration layout}
+
+None.
+
+\devicenormative{\subsection}{Device Initialization}{Device Types / RPMB Device / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized.
+\item The authentication key of device SHOULD NOT be programmed at the first device initialization.
+\item The device capacity SHOULD be initialized to a multiple of 128 Kbytes and up to 16Mbytes.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / RPMB Device / Device Operation}
+
+The operation of a virtio RPMB device is driven by the requests placed on the virtqueue.
+  The type of the request can be program key (VIRTIO_RPMB_REQ_PROGRAM_KEY),
+  get write counter (VIRTIO_RPMB_REQ_GET_WRITE_COUNTER),
+  write (VIRTIO_RPMB_REQ_DATA_WRITE), and read (VIRTIO_RPMB_REQ_DATA_READ).
+  A program key or write request can also combine with a
+  result read (VIRTIO_RPMB_REQ_RESULT_READ) for a returned result.
+
+\begin{lstlisting}
+#define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
+#define VIRTIO_RPMB_REQ_GET_WRITE_COUNTER  0x0002
+#define VIRTIO_RPMB_REQ_DATA_WRITE         0x0003
+#define VIRTIO_RPMB_REQ_DATA_READ          0x0004
+#define VIRTIO_RPMB_REQ_RESULT_READ        0x0005
+\end{lstlisting}
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
+
+The driver MUST configure and initialize all virtqueues for the requests received.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / RPMB Device / Device Operation}
+
+The device provides a simulated RPMB backed by ordinary file or
+  other medium in host. It SHOULD keep consistent behaviors with
+  hardware, including but not limited to:
+\begin{enumerate}
+\item The device maintains an authentication key. Once the first
+   successful key programming is performed, the authentication
+   key MUST be kept unchanged during device lifecycle. It cannot
+   be overwritten, erased or read. This key MUST be kept regardless
+   of device reset or reboot.
+\item The device maintains a monotonic write counter. It MUST be
+   initialized to zero and added by one automatically after each
+   successful write operation. The value cannot be reset. After
+   the counter has reached its maximum value 0xFFFFFFFF, it will
+   not be incremented anymore. This counter MUST be kept regardless
+   of device reset or reboot.
+\item The RPMB device cannot be successfully accessed until RPMB
+   authentication key is programmed. For any operation (read, write,
+   program key, get write counter) done to virtio RPMB device after
+   authentication key is programmed successfully, the device responds
+   with a MAC calculated by HMAC-SHA with authentication key to driver.
+\item For write operation, the device MUST compare the writer counter
+   it receives with the one it maintained internally. If the two are
+   not equal, a VIRTIO_RPMB_RES_COUNT_FAILURE SHOULD be returned as
+   the result. The device MUST calculate the MAC using HMAC-SHA. The
+   authentication key acts as an input of the calculation. If the MAC
+   are not equal to the one it received, a VIRTIO_RPMB_RES_AUTH_FAILURE
+   SHOULD be returned as the result.
+\item
+\end{enumerate}
+
+One of the below error codes MUST be returned to the driver
+  based on the operation result.
+
+\begin{lstlisting}
+#define VIRTIO_RPMB_RES_OK                     0x0000
+#define VIRTIO_RPMB_RES_GENERAL_FAILURE        0x0001
+#define VIRTIO_RPMB_RES_AUTH_FAILURE           0x0002
+#define VIRTIO_RPMB_RES_COUNT_FAILURE          0x0003
+#define VIRTIO_RPMB_RES_ADDR_FAILURE           0x0004
+#define VIRTIO_RPMB_RES_WRITE_FAILURE          0x0005
+#define VIRTIO_RPMB_RES_READ_FAILURE           0x0006
+#define VIRTIO_RPMB_RES_NO_AUTH_KEY            0x0007
+#define VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED  0x0080
+\end{lstlisting}
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

