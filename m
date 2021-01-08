Return-Path: virtio-comment-return-1626-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jie Deng <jie.deng@intel.com>
Date: Fri,  8 Jan 2021 15:39:08 +0800
Message-Id: <dfb21780647c69519f01fb0afbbd18f780963af9.1610091344.git.jie.deng@intel.com>
Subject: [virtio-comment] [PATCH v7] virtio-i2c: add the device specification
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com, Jie Deng <jie.deng@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-i2c is a virtual I2C adapter device. It provides a way
to flexibly communicate with the host I2C slave devices from
the guest.

This patch adds the specification for this device.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88
Signed-off-by: Jie Deng <jie.deng@intel.com>
---
 conformance.tex  |  28 +++++++--
 content.tex      |   1 +
 introduction.tex |   3 +
 virtio-i2c.tex   | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 4 deletions(-)
 create mode 100644 virtio-i2c.tex

diff --git a/conformance.tex b/conformance.tex
index eb33240..e78adfd 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -27,8 +27,10 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / RPMB Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance}
+\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance}.
+
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
@@ -47,8 +49,10 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Socket Device Conformance}, 
 \ref{sec:Conformance / Device Conformance / RPMB Device Conformance},
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
-\ref{sec:Conformance / Device Conformance / Sound Device Conformance} or
-\ref{sec:Conformance / Device Conformance / Memory Device Conformance}.
+\ref{sec:Conformance / Device Conformance / Sound Device Conformance}
+\ref{sec:Conformance / Device Conformance / Memory Device Conformance} or
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance}.
+
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -264,6 +268,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Memory Device / Device Operation / STATE request}
 \end{itemize}
 
+\conformance{\subsection}{I2C Adapter Driver Conformance}\label{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance}
+
+An I2C Adapter driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / I2C Adapter Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -483,6 +495,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Memory Device / Device Operation / STATE request}
 \end{itemize}
 
+\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Conformance / Device Conformance / I2C Adapter Device Conformance}
+
+An I2C Adapter device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 61eab41..48002a2 100644
--- a/content.tex
+++ b/content.tex
@@ -6484,6 +6484,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-iommu.tex}
 \input{virtio-sound.tex}
 \input{virtio-mem.tex}
+\input{virtio-i2c.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/introduction.tex b/introduction.tex
index cc38e29..bc0217f 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -73,6 +73,9 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:HDA}\textbf{[HDA]} &
 	High Definition Audio Specification,
 	\newline\url{https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/high-definition-audio-specification.pdf}\\
+	\phantomsection\label{intro:I2C}\textbf{[I2C]} &
+	I2C-bus specification and user manual,
+	\newline\url{https://www.nxp.com/docs/en/user-guide/UM10204.pdf}\\
 
 \end{longtable}
 
diff --git a/virtio-i2c.tex b/virtio-i2c.tex
new file mode 100644
index 0000000..949d75f
--- /dev/null
+++ b/virtio-i2c.tex
@@ -0,0 +1,176 @@
+\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device}
+
+virtio-i2c is a virtual I2C adapter device. It provides a way to flexibly
+organize and use the host I2C controlled devices from the guest. By attaching
+the host ACPI I2C controlled nodes to the virtual I2C adapter device, the guest can
+communicate with them without changing or adding extra drivers for these
+controlled I2C devices.
+
+\subsection{Device ID}\label{sec:Device Types / I2C Adapter Device / Device ID}
+34
+
+\subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Virtqueues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / Feature bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / I2C Adapter Device / Device configuration layout}
+
+None currently defined.
+
+\subsection{Device Initialization}\label{sec:Device Types / I2C Adapter Device / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device / Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Adapter Device / Device Operation: Request Queue}
+
+The driver queues requests to the virtqueue, and they are used by the
+device. The request is the representation of segments of an I2C
+transaction. Each request is of the form:
+
+\begin{lstlisting}
+struct virtio_i2c_out_hdr {
+        le16 addr;
+        le16 padding;
+        le32 flags;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_i2c_in_hdr {
+        u8 status;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_i2c_req {
+        struct virtio_i2c_out_hdr out_hdr;
+        u8 write_buf[];
+        u8 read_buf[];
+        struct virtio_i2c_in_hdr in_hdr;
+};
+\end{lstlisting}
+
+The \field{addr} of the request is the address of the I2C controlled device.
+For 7-bit address mode (A0 ... A6) and 10-bit address mode (A0 ... A9),
+the format of \field{addr} is defined as follows:
+
+\begin{tabular}{ |l||l|l|l|l|l|l|l|l|l|l|l|l|l|l|l|l| }
+\hline
+Bits           & 15 & 14 & 13 & 12 & 11 & 10 & 9  & 8  & 7  & 6  & 5  & 4  & 3  & 2  & 1  & 0 \\
+\hline
+7-bit address  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & 0  & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 0 \\
+\hline
+10-bit address & A7 & A6 & A5 & A4 & A3 & A2 & A1 & A0 & 1  & 1  & 1  & 1  & 0  & A9 & A8 & 0 \\
+\hline
+\end{tabular}
+
+The \field{padding} is used to pad to full dword.
+
+The \field{flags} of the request is defined as follows:
+
+\begin{description}
+\item[VIRTIO_I2C_FLAGS_FAIL_NEXT(0)] is used to group the requests.
+    For a group requests, a driver clears this bit on the final request
+    and sets it on the other requests. If this bit is set and a device fails
+    to process the current request, it needs to fail the next request instead
+    of attempting to execute it.
+\end{description}
+
+Other bits of \field{flags} are currently reserved as zero for future feature
+extensibility.
+
+The \field{write_buf} of the request contains one segment of an I2C transaction
+being written to the device.
+
+The \field{read_buf} of the request contains one segment of an I2C transaction
+being read from the device.
+
+The final \field{status} byte of the request is written by the device: either
+VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
+
+\begin{lstlisting}
+#define VIRTIO_I2C_MSG_OK     0
+#define VIRTIO_I2C_MSG_ERR    1
+\end{lstlisting}
+
+If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
+the request is called write request.
+
+If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
+the request is called read request.
+
+If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
+the request is called write-read request. It means an I2C write segment followed
+by a read segment. Usually, the write segment provides the number of an I2C
+controlled device register to be read.
+
+The case when ``length of \field{write_buf}''=0, and at the same time,
+``length of \field{read_buf}''=0 doesn't make any sense.
+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C Adapter Device / Device Operation: Operation Status}
+
+\field{addr}, \field{flags}, ``length of \field{write_buf}'' and ``length of \field{read_buf}''
+are determined by the driver, while \field{status} is determined by the processing
+of the device. A driver puts the data written to the device into \field{write_buf}, while
+a device puts the data of the corresponding length into \field{read_buf} according to the
+request of the driver.
+
+A driver may send one request or multiple requests to the device at a time.
+The requests in the virtqueue are both queued and processed in order.
+
+If a driver sends multiple requests at a time and a device fails to process
+some of them, then a device needs to set the \field{status} of the first failed request
+to be VIRTIO_I2C_MSG_ERR. For the remaining requests in the same group with
+the first failed one, a driver needs to treat them as VIRTIO_I2C_MSG_ERR, no matter
+what \field{status} of them, a device needs to fail them instead of attempting to
+execute them according to the VIRTIO_I2C_FLAGS_FAIL_NEXT bit.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
+
+A driver MUST set \field{addr} and \field{flags} before sending the request.
+
+A driver MUST set the reserved bits of \field{flags} to be zero.
+
+The driver MUST NOT send a request with ``length of \field{write_buf}''=0 and
+``length of \field{read_buf}''=0 at the same time.
+
+A driver MUST NOT use \field{read_buf} if the final \field{status} returned
+from the device is VIRTIO_I2C_MSG_ERR.
+
+A driver MUST queue the requests in order if multiple requests are going to
+be sent at a time.
+
+If multiple requests are sent at a time and some of them returned from the
+device have the \field{status} being VIRTIO_I2C_MSG_ERR, a driver MUST treat
+the first failed request and the remaining requests in the same group with
+the first failed one as VIRTIO_I2C_MSG_ERR.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
+
+A device SHOULD keep consistent behaviors with the hardware as described in
+\hyperref[intro:I2C]{I2C}.
+
+A device MUST NOT change the value of \field{addr}, reserved bits of \field{flags}
+and \field{write_buf}.
+
+A device MUST place one I2C segment of the corresponding length into \field{read_buf}
+according the driver's request.
+
+A device MUST guarantee the requests in the virtqueue being processed in order
+if multiple requests are received at a time.
+
+If multiple requests are received at a time and processing of some of the
+requests fails, a device MUST set the \field{status} of the first failed
+request to be VIRTIO_I2C_MSG_ERR and MAY set the \field{status} of the
+remaining requests in the same group with the first failed one
+to be VIRTIO_I2C_MSG_ERR.
-- 
2.7.4


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

