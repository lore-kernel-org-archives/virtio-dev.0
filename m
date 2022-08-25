Return-Path: <virtio-comment-return-3409-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Harald Mommer <harald.mommer@opensynergy.com>
Date: Thu, 25 Aug 2022 15:34:10 +0200
Message-Id: <20220825133410.18367-1-harald.mommer@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH v2 1/1] virtio-can: Device specification - 2nd RFC draft.
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org
Cc: Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>, Harald Mommer <harald.mommer@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-can is a virtual CAN device. It provides a way to give access to
a CAN controller from a driver guest. The device is aimed to be used by
driver guests running a HLOS as well as by driver guests running a
typical RTOS as used in controller environments.

This is the reworked (2nd) version of the specification after having
gotten some feedback on the virtio lists and the Linux CAN mailing
lists. (The 1st now outdated version of the specification draft has been
sent out on 1-Apr-2021 to the virtio lists.) There is now also a virtio
CAN Linux driver which in the meantime has become good enough to be
shown.

There were a lot of changes, only mentioning the most important ones
omitting editorial changes.

- Classic CAN is indeed non-mandatory, so a feature bit is needed.
  According to ISO all CAN controllers support classic CAN but it may be
  disabled by configuration. So classic CAN is indeed a feature which
  may not be available in some environments.

- Introduce a new feature flag VIRTIO_CAN_F_LATE_TX_ACK. While marking
  as used after the actual transmission has been done on the CAN bus
  this cannot be implemented reliably in all environments. SocketCAN is
  affected at least under heavy load for TX and RX.

- RTR frames were requested on the Linux mailing list. They cannot be
  supported when the underlying CAN driver backend is a 3rd party
  AUTOSAR driver as AUTOSAR CAN does not support RTR frames. A feature
  flag VIRTIO_CAN_F_RTR_FRAMES has been added to make support of RTR
  frames an optional feature.

- Add le32 flags. There is now a reserved field in both RX and TX
  messages which might serve to contain an AUTOSAR hardware object
  handle or similar in a future version of the specification without
  need to change the layout of the RX and TX message structures.

- Removal of priorities and config space. Priorities cannot be supported
  using SocketCAN, the information delivered in the config space cannot
  be determined using SocketCAN. Support of different priorities was
  anyway too much for a first version of a specification. If priorities
  are supported in a future version there will probably be only 2
  different priorities, normal and high. In a future version of the
  specification high priority messages may either be supported by using
  a flag bit in the TX message but most probably the better solution
  will be to add add a dedicated 2nd TX queue for high priority messages
  in a review comment. But as already said priorities are not for now.
---
 conformance.tex  |  27 +++++-
 content.tex      |   1 +
 introduction.tex |   2 +
 virtio-can.tex   | 229 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+), 4 deletions(-)
 create mode 100644 virtio-can.tex

diff --git a/conformance.tex b/conformance.tex
index c3c1d3e..db09353 100644
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
+\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
 
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
+\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -335,6 +337,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
 \end{itemize}
 
+\conformance{\subsection}{CAN Driver Conformance}\label{sec:Conformance / Driver Conformance / CAN Driver Conformance}
+
+A CAN driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / CAN Device / Device Operation / Initialization}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -621,6 +631,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
 \end{itemize}
 
+\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
+
+A CAN device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / CAN Device / Feature bits}
+\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index e863709..0a82212 100644
--- a/content.tex
+++ b/content.tex
@@ -6851,6 +6851,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-can.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..e76c8a9 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -98,6 +98,8 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
+	ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
 
 \end{longtable}
 
diff --git a/virtio-can.tex b/virtio-can.tex
new file mode 100644
index 0000000..ef4de7b
--- /dev/null
+++ b/virtio-can.tex
@@ -0,0 +1,229 @@
+\section{CAN Device}\label{sec:Device Types / CAN Device}
+
+virtio-can is a virtio based CAN (Controller Area Network) controller.
+It is used to give a virtual machine access to a CAN bus. The CAN bus
+might either be a physical CAN bus or a virtual CAN bus between virtual
+machines or a combination of both.
+
+\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
+
+36
+
+\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
+
+\begin{description}
+\item[0] Txq
+\item[1] Rxq
+\item[2] Controlq
+\item[3] Indicationq
+\end{description}
+
+The \field{Txq} is used to send CAN packets to the CAN bus.
+
+The \field{Rxq} is used to receive CAN packets from the CAN bus.
+
+The \field{Controlq} is used to control the state of the CAN controller.
+
+The \field{Indicationq} is used to receive unsolicited indications of
+CAN controller state changes.
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / CAN Device / Feature bits}
+
+Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
+as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
+CAN~2.0B Extended CAN IDs is considered as mandatory for this
+specification.
+
+\begin{description}
+
+\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
+
+The device supports classic CAN frames with a maximum payload size of 8
+bytes.
+
+\item[VIRTIO_CAN_F_CAN_FD (1)]
+
+The device supports CAN FD frames with a maximum payload size of 64
+bytes.
+
+\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
+
+The device supports RTR (remote transmission request) frames. RTR frames
+are only supported with classic CAN.
+
+\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
+
+The virtio CAN device marks transmission requests from the \field{Txq}
+as used after the CAN message has been transmitted on the CAN bus.
+Without this feature flag negotiated the device is allowed to mark
+transmission requests already as used when the CAN message has been
+scheduled for transmission but might not yet have been transmitted on
+the CAN bus.
+
+\end{description}
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Initialization}
+
+\begin{enumerate}
+
+\item Read the feature bits and negotiate with the device.
+
+\item The driver MUST populate the \field{Rxq} with empty
+device-writeable buffers of at least the struct virtio_can_rx size to be
+ready for the reception of CAN messages.
+
+\item The driver MUST populate the \field{Indicationq} with empty
+device-writeable buffers of at least the struct virtio_can_event_ind size
+so that the CAN device is able to provide status change indications to the
+virtio CAN driver.
+
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
+
+A device operation has an outcome which is described by one of the
+following values:
+
+\begin{lstlisting}
+#define VIRTIO_CAN_RESULT_OK     0u
+#define VIRTIO_CAN_RESULT_NOT_OK 1u
+\end{lstlisting}
+
+Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
+
+The type of a CAN message identifier is determined by \field{flags}. The
+3 most significant bits of
+\field{can_id} do not bear the information about the type of the CAN
+message identifier and are 0.
+
+\begin{lstlisting}
+#define VIRTIO_CAN_FLAGS_FD            0x4000U
+#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000U
+#define VIRTIO_CAN_FLAGS_RTR           0x2000U
+\end{lstlisting}
+
+\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
+
+The general format of a request in the \field{Controlq} is
+
+\begin{lstlisting}
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
+        le16 msg_type; 
+};
+\end{lstlisting}
+
+To participate in bus communication the CAN controller is started by
+sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
+participating in bus communication it is stopped by sending a
+VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
+confirmed by the result of the operation.
+
+\begin{lstlisting}
+struct virtio_can_control_in {
+        u8 result;
+};
+\end{lstlisting}
+
+If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
+otherwise it is VIRTIO_CAN_RESULT_NOT_OK. The device marks the request
+used when the CAN controller has finalized the transition to the
+requested controller mode.
+
+On transition to the STOPPED state the device cancels all CAN messages
+already pending for transmission and marks them as used with
+\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
+device marks messages received from the
+\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
+transmitting them to the CAN bus.
+
+Initially the CAN controller is in the STOPPED state.
+
+Control queue messages are processed in order.
+
+\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}
+
+Messages are transmitted by placing outgoing CAN messages in the
+\field{Txq} virtqueue.
+
+\begin{lstlisting}
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX 0x0001u
+        le16 msg_type;
+        le16 reserved;
+        le32 flags;
+        le32 can_id;
+        u8 sdu[];
+};
+
+struct virtio_can_tx_in {
+        u8 result;
+};
+\end{lstlisting}
+
+The length of \field{sdu} is implicit in the length of the device
+read-only descriptors.
+
+If transmission of a CAN frame type is requested for which support has
+not been negotiated \field{result} shall be set to
+VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
+transmission.
+
+If \field{can_id} or field{sdu} length are out of range or the CAN
+controller is in an invalid state \field{result} shall be set to
+VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
+transmission.
+
+If the parameters are valid the message is scheduled for transmission.
+
+If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
+transmission request MUST be marked as used with \field{result} set to
+VIRTIO_CAN_OK after the CAN controller acknowledged the successful
+transmission on the CAN bus. Without feature
+VIRTIO_CAN_F_CAN_LATE_TX_ACK negotiated the transmission request MAY
+already be marked as used with \field{result} set to VIRTIO_CAN_OK when
+the transmission request has been processed by the virtio CAN device and
+send down the protocol stack being scheduled for transmission.
+
+\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
+
+Messages can be received by providing empty incoming buffers to the
+virtqueue \field{Rxq}.
+
+\begin{lstlisting}
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX 0x0101u
+        le16 msg_type;
+        le16 reserved;
+        le32 flags;
+        le32 can_id;
+        u8 sdu[];
+};
+\end{lstlisting}
+
+If the feature VIRTIO_CAN_F_CAN_FD has been negotiated the maximal
+possible \field{sdu} length is 64, if the feature has not been
+negotiated the maximal possible \field{sdu} length is 8.
+
+The actual length of the \field{sdu} is calculated from the length of the
+driver read-only descriptors.
+
+\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
+
+There are certain error conditions so that the physical CAN controller
+has to stop participating in CAN communication on the bus. If such an
+error condition occurs the device informs the driver about the
+unsolicited CAN controller state change by a CAN BusOff indication.
+
+\begin{lstlisting}
+struct virtio_can_event_ind {
+#define VIRTIO_CAN_BUSOFF_IND 0x0301u
+        le16 msg_type;
+};
+\end{lstlisting}
+
+After bus-off detection the CAN controller is in STOPPED state. The CAN
+module does not participate in bus communication any more so all CAN
+messages pending for transmission are put into the used queue with
+\field{result} VIRTIO_CAN_RESULT_NOT_OK.
-- 
2.17.1


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

