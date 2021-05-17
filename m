Return-Path: virtio-dev-return-8168-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 431E2985E64
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 May 2021 19:37:44 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF8SvvObHWu3OCuSG6goXHJL1R_XxxrnQ9p-9DsLEms6cg@mail.gmail.com>
 <20210517193617.1576401-1-chenhaosjtuacm@google.com>
In-Reply-To: <20210517193617.1576401-1-chenhaosjtuacm@google.com>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, 17 May 2021 12:37:30 -0700
Message-ID: <CABATKF9BoZQJenux4ju8TpZAmgeoMNGLPj_Dq8YZf6YwGfD8wg@mail.gmail.com>
Subject: [virtio-dev] Fwd: [PATCH v3] Add virtio parameter server device specification
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
Cc: Enrico Granata <egranata@google.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces a new type of device: parameter server. The device
acts as a key-value store and the driver can read from, write to or
subscribe to the properties in the server.

Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
---
 conformance.tex |  26 ++++++-
 content.tex     |   1 +
 virtio-ps.tex   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 4 deletions(-)
 create mode 100644 virtio-ps.tex

diff --git a/conformance.tex b/conformance.tex
index a164cbb..0d6b1a5 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance
/ Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
-\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
+\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
Conformance}.

     \item Clause \ref{sec:Conformance / Legacy Interface:
Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance
/ Conformance Targets}
 \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
 \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
-\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
-\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
+\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}or
+\ref{sec:Conformance / Device Conformance / Parameter Server Device
Conformance}.

     \item Clause \ref{sec:Conformance / Legacy Interface:
Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -288,6 +290,14 @@ \section{Conformance
Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device
Operation / Setting Up eventq Buffers}
 \end{itemize}

+\conformance{\subsection}{Parameter Server Driver
Conformance}\label{sec:Conformance / Driver Conformance / Parameter
Server Driver Conformance}
+
+A parameter server driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Parameter Server / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance /
Device Conformance}

 A device MUST conform to the following normative statements:
@@ -527,6 +537,14 @@ \section{Conformance
Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / SCMI Device / Device
Operation / Shared Memory Operation}
 \end{itemize}

+\conformance{\subsection}{Parameter Server Device
Conformance}\label{sec:Conformance / Device Conformance / Parameter
Server Device Conformance}
+
+A parameter server device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Parameter Server / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and
Transitional Driver Conformance}\label{sec:Conformance / Legacy
Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 9232d5c..b980a93 100644
--- a/content.tex
+++ b/content.tex
@@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing
Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-ps.tex}

 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}

diff --git a/virtio-ps.tex b/virtio-ps.tex
new file mode 100644
index 0000000..f84b211
--- /dev/null
+++ b/virtio-ps.tex
@@ -0,0 +1,197 @@
+\section{Parameter Server}\label{sec:Device Types / Parameter Server}
+
+The parameter server device manages a set of values with unique
property IDs. These values may
+either be static (i.e. have a constant value) or be dynamic (i.e.
value may change over time).
+The driver can get and set values, get value configurations,
subscribe and unsubscribe dynamic
+properties from the device. The driver will get updates when
subscribed value changes. The device
+processes the requests from the driver, enforces the value access
rules, and may potentially alter
+the behavior of external systems as a result of driver operations.
+
+\subsection{Device ID}\label{sec:Device Types / Parameter Server / Device ID}
+
+38
+
+\subsection{Virtqueues}\label{sec:Device Types / Parameter Server / Virtqueues}
+
+\begin{description}
+\item[0] cmdq
+\item[1] eventq
+\end{description}
+
+\subsection{Feature Bits}\label{sec:Device Types / Parameter Server /
Feature Bits}
+
+None currently defined.
+
+\subsection{Device Configuration Layout}\label{sec:Device Types /
Parameter Server / Device Configuration Layout}
+
+\begin{lstlisting}
+struct virtio_parameter_server_config {
+    char name[128];
+};
+\end{lstlisting}
+
+A device configuration space only contains the name of the device,
which can be used by the
+userspace for identification.
+
+\subsection{Device Initialization}
+
+\begin{enumerate}
+\item The virtqueues are initialized.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / Parameter
Server / Device Operation}
+
+The driver puts requests to read, write, subscribe to, or unsubscribe
from, parameters onto the
+cmdq virtqueue. The device also puts its responses to the driver's
requests onto the cmdq
+virtqueue. The device puts any updates to values that the driver has
subscribed to onto the
+eventq virtqueue. The
+\field{prop_id}, \field{prop_item_id} pair is the primary key for the
values stored in the
+parameter server, while the values with the same \field{prop_id}
share the same configuration.
+For example, \field{prop_id} 12 with \field{prop_item_id} 0, 1 and 2
represent 3 different values
+sharing the same \field{virtio_parameter_server_config}.
Subscriptions are also on \field{prop_id},
+so if \field{prop_id} 12 is subscribed, the driver will receive
updates on (12, 0), (12, 1) and
+(12, 2).
+
+The layout of requests and responses are defined below:
+
+\begin{lstlisting}
+struct virtio_parameter_server_request {
+    le64 timestamp;
+    le32 prop_id;
+    le32 prop_item_id;
+    le32 payload_size;
+    u8 op;
+    u8 payload[<actual payload size>];
+};
+
+struct virtio_parameter_server_response {
+    le64 timestamp;
+    le32 prop_id;
+    le32 prop_item_id;
+    le32 payload_size;
+    u16 op;
+    u16 ret_value;
+    u8 payload[<actual payload size>];
+};
+
+/* Reserved prop_id and prop_item_id */
+#define VIRTIO_PARAMETER_SERVER_OP_ALL_PROP INT_MAX
+
+/* Supported operations */
+#define VIRTIO_PARAMETER_SERVER_OP_INVALID 0
+#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG 1
+#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_VALUE 2
+#define VIRTIO_PARAMETER_SERVER_OP_SET_PROP_VALUE 3
+#define VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP 4
+#define VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP 5
+\end{lstlisting}
+
+The layout of messages in eventq is defined below:
+
+\begin{lstlisting}
+struct virtio_parameter_server_event_msg {
+    le64 timestamp;
+    le32 prop_id;
+    le32 prop_item_id;
+    le32 payload_size;
+    u8 payload[<actual payload size>];
+};
+\end{lstlisting}
+
+There will be exactly one response for each request in the cmdq, even
if \field{op} is invalid. For some operations,
+the \field{payload} of requests and/or responses may be empty. The
content of the payload depend on the operation.
+
+\subsubsection{Property Configuration Layout}\label{sec:Device Types
/ Parameter Server / Device Operation / Property Configuration Layout}
+
+\begin{lstlisting}
+struct virtio_parameter_server_prop_config {
+    le32 prop_id;
+    le32 mode;
+    le32 min_sample_freq;
+    le32 max_sample_freq;
+    le32 encoding[5];
+    le32 param_size;
+    char desc[256];
+    u8 params[<actual param size>];
+};
+\end{lstlisting}
+
+while \field{mode} is the bitwise-or-combination of the following:
+
+\begin{lstlisting}
+enum virtio_parameter_server_prop_mode {
+    /* access */
+    VIRTIO_PARAMETER_SERVER_M_READ = 0x1,
+    VIRTIO_PARAMETER_SERVER_M_WRITE = 0x2,
+    VIRTIO_PARAMETER_SERVER_M_READ_WRITE = 0x3,
+
+    /* change */
+    VIRTIO_PARAMETER_SERVER_M_STATIC = 0x4,
+    VIRTIO_PARAMETER_SERVER_M_MUTABLE = 0x8,
+    VIRTIO_PARAMETER_SERVER_M_CONTINUOUS = 0xc,
+};
+\end{lstlisting}
+
+Both VIRTIO_PARAMETER_SERVER_M_MUTABLE and
VIRTIO_PARAMETER_SERVER_M_CONTINUOUS are dynamic
+properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will change due
to the set value operation
+from the driver, or actions of the external system; a
VIRTIO_PARAMETER_SERVER_M_CONTINUOUS value
+is expected to be generated by means of a sensor updating at a steady
frequency.
+
+The reason we want to handle "MUTABLE" and "CONTNUOUS" differently
is, the MUTABLE values are not
+constantly changing, so the device may be able to send every updates
of it to the driver; while
+CONTINUOUS values are changing frequently (e.g., sensor outputs) and
the device should decide how
+to sample it and provide a sample rate range (\field{min_sample_freq}
and \field{max_sample_freq})
+
+The properties with the same \field{prop_id} share the configuration.
\field{min_sample_freq} and
+\field{max_sample_freq} are the sampling rate range for the
+\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc} is
the optional string
+description. \field{params} are for the customized configuration parameters.
+
+The integer array \field{encoding} specifies the number of different
primitive value in the
+property value.
+
+\begin{lstlisting}
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT64 0
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_FLOAT64 1
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT32 2
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_BYTE 3
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING 4
+\end{lstlisting}
+
+If the driver asks for ALL property configurations by setting the
\field{prop_id} of the request to
+VIRTIO_PARAMETER_SERVER_OP_ALL_PROP, then the \field{payload} of
virtio_parameter_server_response
+will be multiple property configurations, serialized 1-by-1.
+
+\subsubsection{Property Value Layout}\label{sec:Device Types /
Parameter Server / Device Operation / Property Value Layout}
+
+The property value payload begins with 5 arrays. The order is the
same as the \field{encoding} array defined above.
+For each array, it begins with a 32-bit integer for length (number of
elements). Empty array will be a 32-bit 0, while
+-1 means the array does not exist. The elements follows the length,
and the size of the encoded array will be padded
+to 4 bytes. String is encoded as char, zero-terminated array,
+\field{encoding[VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING]}
indicates the existence of the string.
+
+After the arrays, there may be customized data, which is encoded as a
byte array.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types /
Parameter Server / Device Operation}
+
+The driver MUST NOT send undefined ops.
+
+The driver MUST NOT put descriptors into the eventq.
+
+The payload size of requests MUST be padded to 4 bytes.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types /
Parameter Server / Device Operation}
+
+\field{name} of the device configuration MUST be non-empty.
+
+The unused bits of the message header MUST be 0.
+
+The \field{prop_item_id} of VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG,
+VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP and
VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP requests
+MUST be ignored.
+
+The device MUST send exact 1 response for every received request.
+
+The payload size of responses and event messages MUST be padded to 4 bytes.
+
+The param size of property configurations MUST be padded to 4 bytes.
--
2.31.1.751.gd2f1c929bd-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

