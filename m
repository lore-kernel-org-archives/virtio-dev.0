Return-Path: virtio-comment-return-1812-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Harald Mommer <harald.mommer@opensynergy.com>
Date: Thu,  1 Apr 2021 17:20:13 +0200
Message-ID: <20210401152013.17980-1-harald.mommer@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 1/1] [RFC] virtio-can: Add the device specification.
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtio-can is a virtual CAN device. It provides a way to give access to
a CAN controller from a driver guest. The device is aimed to be used by
driver guests running a HLOS as well as by driver guests running a
typical RTOS as used in controller environments.
---
 content.tex      |   1 +
 introduction.tex |   3 +
 virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 virtio-can.tex

diff --git a/content.tex b/content.tex
index e536fd4..c1604db 100644
--- a/content.tex
+++ b/content.tex
@@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-can.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/introduction.tex b/introduction.tex
index 7204b24..84ea5c0 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
 	Arm System Control and Management Interface, DEN0056,
 	\newline\url{https://developer.arm.com/docs/den0056/c}, version C and any future revisions\\
+	\phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
+	Specification of CAN Driver -- AUTOSAR CP R20-11,
+	\newline\url{https://www.autosar.org/fileadmin/user_upload/standards/classic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\
 
 \end{longtable}
 
diff --git a/virtio-can.tex b/virtio-can.tex
new file mode 100644
index 0000000..c343759
--- /dev/null
+++ b/virtio-can.tex
@@ -0,0 +1,245 @@
+\section{CAN Device}\label{sec:Device Types / CAN Device}
+
+virtio-can is a virtio based CAN (Controller Area Network) device. It is
+used to give a virtual machine access to a CAN bus. The CAN bus may
+either be a physical CAN bus or a virtual CAN bus between virtual
+machines or a combination of both.
+
+This section relies on definitions made by the AUTOSAR
+\hyperref[intro:CAN_Driver]{CAN Driver} specification.
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
+\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feature Bits}
+
+The virtio-can device always supports classic CAN frames with a maximum
+payload size of 8 bytes.
+
+Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
+as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
+CAN~2.0B Extended CAN IDs is considered as mandatory for this
+specification.
+
+\begin{description}
+
+\item[VIRTIO_CAN_F_CAN_FD (0)]
+
+In addition to classic CAN frames the device supports CAN FD frames with
+a maximum payload size of 64 bytes.
+
+\end{description}
+
+\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
+
+All fields of this configuration are always available and read-only for
+the driver.
+
+\begin{lstlisting}
+struct virtio_can_config {
+        le16 lo_prio_count; 
+        le16 hi_prio_count;
+};
+\end{lstlisting}
+
+To operate the Virtio CAN device it may be necessary to know some basic
+properties of the underlying physical CAN controller hardware and its
+configuration.
+
+Physical CAN controllers may support transmission by putting messages
+into FIFOs first and / or by using transmit buffers directly. The user
+of the Virtio CAN driver may need to know
+
+\begin{itemize}
+\item Number of TX FIFO places for non time critical CAN messages
+\item Number of TX buffers for high priority CAN messages
+\end{itemize}
+
+to schedule an optimal transmission of CAN messages. Non time critical
+messages may be sent via a FIFO where they may suffer "Inner Priority
+Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). High
+priority messages are preferably sent directly to a transmit buffer
+where they immediately participate in CAN bus arbitration.
+
+\subsection{Device Initialization}\label{sec:Device Types / CAN Device / Device Initialization}
+
+\begin{enumerate}
+
+\item Read the feature bits and negotiate with the device.
+
+\item Fill the virtqueue \field{Rxq} with empty buffers to be ready for
+the reception of CAN messages.
+
+\item Fill the virtqueue \field{Indicationq} with empty buffers so that
+the CAN device is able to provide status change indications to the
+virtio CAN driver.
+
+\item Read the CAN controller properties using the \field{Controlq}.
+
+\item Start the CAN controller using the \field{Controlq}.
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
+The type of a CAN message identifier is identified by the most
+significant 2 bits of the internally used 32 bit value. This matches the
+definition for Can_IdType in
+\hyperref[intro:CAN_Driver]{CAN Driver} chapter 8.2.3.
+
+\begin{lstlisting}
+#define VIRTIO_CAN_ID_TYPE_STANDARD    0x00000000U
+#define VIRTIO_CAN_ID_TYPE_STANDARD_FD 0x40000000U
+#define VIRTIO_CAN_ID_TYPE_EXTENDED    0x80000000U
+#define VIRTIO_CAN_ID_TYPE_EXTENDED_FD 0xC0000000U
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
+To participate in bus communication the CAN controller must be started
+by sending a VIRTIO_CAN_SET_CTRL_MODE_START control message,
+to stop participating in bus communication it must be stopped by sending
+a VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
+confirmed by the result of the operation.
+
+\begin{lstlisting}
+struct virtio_can_set_ctrl_mode_in {
+        u8 result;
+};
+\end{lstlisting}
+
+If the transition succeeded the result shall be VIRTIO_CAN_RESULT_OK
+otherwise it shall be VIRTIO_CAN_RESULT_NOT_OK. The request shall be put
+into the used queue when the CAN controller finalized the transition to
+the requested controller mode.
+
+A transition to STOPPED state cancels all CAN messages pending for
+transmission. A state transition to STOPPED state shall trigger to put
+all CAN messages pending for transmission into the used queue with
+result VIRTIO_CAN_RESULT_NOT_OK.
+
+Initially the CAN controller is in STOPPED state.
+
+\subsubsection{CAN Message Transmission}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Transmission}
+
+Messages may be transmitted by placing outgoing CAN messages in the
+virtqueue \field{Txq}.
+
+\begin{lstlisting}
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX 0x0001u
+        le16 msg_type;
+        le16 priority;
+        le32 can_id;
+        u8 sdu[];
+};
+
+struct virtio_can_tx_in {
+        u8 result;
+};
+\end{lstlisting}
+
+Priority is 0 for low priority and 1 for high priority CAN messages.
+
+The actual length of the SDU can be calculated from the length of the device
+read-only descriptor.
+
+To avoid internal priority inversion in the \field{Txq} the user of the
+driver may do a book keeping of in flight transmission requests and
+defer sending of TX messages until the chosen transmission resource
+becomes available.
+
+If priority, can_id or SDU length are out of range or the CAN controller
+is in an invalid state result shall be set to VIRTIO_CAN_RESULT_NOT_OK
+and the message shall not be scheduled for transmission. Sending a CAN
+message with a priority with 0 transmission places configured shall
+be considered as priority being out of range.
+
+If the parameters are valid the message is scheduled for transmission
+and result is set to VIRTIO_CAN_OK. The transmission request should be
+put into the used queue after the physical CAN controller acknowledged
+the transmission on the CAN bus (may have to be put under a feature flag
+as there may be non AUTOSAR CAN driver backends which don't provide a
+trigger to do this correctly).
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
+        le32 can_id;
+        u8 sdu[];
+};
+\end{lstlisting}
+
+The structure element reserved may in the future be used to forward an
+AUTOSAR hoh, see (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 7.6).
+The value should be set to 0xFFFF.
+
+If the feature \field{VIRTIO_CAN_F_CAN_FD} has been negotiated the
+maximal possible SDU length is 64, if the feature has not been
+negotiated the maximal possible SDU length is 8.
+
+The actual length of the SDU can be calculated from the length of the
+driver read-only descriptor.
+
+\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
+
+There are certain error conditions so that the physical CAN controller
+has to stop participating in CAN communication on the bus. If such an
+error condition occurs the device informs the driver about the
+unsolicited CAN controller state change by a CAN BusOff indication.
+
+\begin{lstlisting}
+struct virtio_can_busoff_ind {
+#define VIRTIO_CAN_BUSOFF_IND 0x0301u
+        le16 msg_type;
+};
+\end{lstlisting}
+
+After bus-off detection the CAN controller is in STOPPED state. The CAN
+module does not participate in bus communication any more so all CAN
+messages pending for transmission must be put into the used queue with
+result VIRTIO_CAN_RESULT_NOT_OK.
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

