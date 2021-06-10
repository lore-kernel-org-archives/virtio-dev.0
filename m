Return-Path: virtio-dev-return-8189-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10EB398663F
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Jun 2021 23:20:48 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF-Oa52Hq9U+-4zOY7+aL-mrf6+DmhSG51WRnLPjFsdXUA@mail.gmail.com>
 <20210610231954.2937837-1-chenhaosjtuacm@google.com>
In-Reply-To: <20210610231954.2937837-1-chenhaosjtuacm@google.com>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Thu, 10 Jun 2021 16:20:34 -0700
Message-ID: <CABATKF_W_J23ht9o9qH0DFkrujGRqm1W8gZPP1vGrkWSyfsJNQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v4] Add virtio parameter server device specification
Content-Type: multipart/alternative; boundary="00000000000003a09c05c471a47d"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000003a09c05c471a47d
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 10, 2021 at 4:19 PM Hao Chen <chenhaosjtuacm@google.com> wrote:

> This patch introduces a new type of device: parameter server. The device
> acts as a key-value store and the driver can read from, write to or
> subscribe to the properties in the server.
>
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  conformance.tex |  26 +++++-
>  content.tex     |   1 +
>  virtio-ps.tex   | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-ps.tex
>
> diff --git a/conformance.tex b/conformance.tex
> index a164cbb..0d6b1a5 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver
> Conformance} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver
> Conformance},
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
> Conformance}.
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional
> Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> -\ref{sec:Conformance / Device Conformance / I2C Adapter Device
> Conformance} or
> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / I2C Adapter Device
> Conformance},
> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}or
> +\ref{sec:Conformance / Device Conformance / Parameter Server Device
> Conformance}.
>
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional
> Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -288,6 +290,14 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \item \ref{drivernormative:Device Types / SCMI Device / Device Operation
> / Setting Up eventq Buffers}
>  \end{itemize}
>
> +\conformance{\subsection}{Parameter Server Driver
> Conformance}\label{sec:Conformance / Driver Conformance / Parameter Server
> Driver Conformance}
> +
> +A parameter server driver MUST conform to the following normative
> statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / Parameter Server / Device
> Operation}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device
> Conformance}
>
>  A device MUST conform to the following normative statements:
> @@ -527,6 +537,14 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}
>  \item \ref{devicenormative:Device Types / SCMI Device / Device Operation
> / Shared Memory Operation}
>  \end{itemize}
>
> +\conformance{\subsection}{Parameter Server Device
> Conformance}\label{sec:Conformance / Device Conformance / Parameter Server
> Device Conformance}
> +
> +A parameter server device MUST conform to the following normative
> statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / Parameter Server / Device
> Operation}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and
> Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index 9232d5c..b980a93 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing
> Requirements}\label{sec:Device
>  \input{virtio-mem.tex}
>  \input{virtio-i2c.tex}
>  \input{virtio-scmi.tex}
> +\input{virtio-ps.tex}
>
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>
> diff --git a/virtio-ps.tex b/virtio-ps.tex
> new file mode 100644
> index 0000000..2a226c4
> --- /dev/null
> +++ b/virtio-ps.tex
> @@ -0,0 +1,216 @@
> +\section{Parameter Server}\label{sec:Device Types / Parameter Server}
> +
> +The parameter server device manages a set of values with unique property
> IDs. These values may
> +either be static (i.e. have a constant value) or be dynamic (i.e. value
> may change over time).
> +The driver can get and set values, get value configurations, subscribe
> and unsubscribe dynamic
> +properties from the device. The driver will get updates when subscribed
> value changes. The device
> +processes the requests from the driver, enforces the value access rules,
> and may potentially alter
> +the behavior of external systems as a result of driver operations.
> +
> +\subsection{Device ID}\label{sec:Device Types / Parameter Server / Device
> ID}
> +
> +38
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Parameter Server /
> Virtqueues}
> +
> +\begin{description}
> +\item[0] cmdq
> +\item[1] eventq
> +\end{description}
> +
> +\subsection{Feature Bits}\label{sec:Device Types / Parameter Server /
> Feature Bits}
> +
> +None currently defined.
> +
> +\subsection{Device Configuration Layout}\label{sec:Device Types /
> Parameter Server / Device Configuration Layout}
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_config {
> +    char name[128];
> +};
> +\end{lstlisting}
> +
> +A device configuration space only contains the name of the device, which
> can be used by the
> +userspace for identification. \field{name} is a zero-terminated char
> string. The maximum length
> +of \field{name} is 127.
> +
> +\subsection{Device Initialization}
> +
> +\begin{enumerate}
> +\item The virtqueues are initialized.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / Parameter Server /
> Device Operation}
> +
> +The driver puts requests to read, write, subscribe to, or unsubscribe
> from, parameters onto the
> +cmdq virtqueue. The device also puts its responses to the driver's
> requests onto the cmdq
> +virtqueue. The device puts any updates to values that the driver has
> subscribed to onto the
> +eventq virtqueue. The
> +\field{prop_id}, \field{prop_item_id} pair is the primary key for the
> values stored in the
> +parameter server, while the values with the same \field{prop_id} share
> the same configuration.
> +For example, \field{prop_id} 12 with \field{prop_item_id} 0, 1 and 2
> represent 3 different values
> +sharing the same \field{virtio_parameter_server_config}. \field{prop_id}
> is also used for
> +subscriptions, meaning that if you subscribe on a prop_id, you will
> receive every updates on that
> +prop_id regardless of what prop_item_id it contains. \field{prop_item_id}
> is not used in
> +subscription.
> +
> +The layout of requests and responses are defined below:
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_request {
> +    le64 timestamp;
> +    le32 prop_id;
> +    le32 prop_item_id;
> +    u8 op;
> +    u8 payload[<actual payload size>];
> +};
> +
> +struct virtio_parameter_server_response {
> +    le64 timestamp;
> +    le32 prop_id;
> +    le32 prop_item_id;
> +    u16 op;
> +    u16 ret_value;
> +    u8 payload[<actual payload size>];
> +};
> +
> +/* Reserved prop_id and prop_item_id */
> +#define VIRTIO_PARAMETER_SERVER_OP_ALL_PROP INT_MAX
> +
> +/* Supported operations */
> +#define VIRTIO_PARAMETER_SERVER_OP_INVALID 0
> +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG 1
> +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_VALUE 2
> +#define VIRTIO_PARAMETER_SERVER_OP_SET_PROP_VALUE 3
> +#define VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP 4
> +#define VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP 5
> +\end{lstlisting}
> +
> +The layout of messages in eventq is defined below:
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_event_msg {
> +    le64 timestamp;
> +    le32 prop_id;
> +    le32 prop_item_id;
> +    u8 payload[<actual payload size>];
> +};
> +\end{lstlisting}
> +
> +There will be exactly one response for each request in the cmdq, even if
> \field{op} is invalid. For some operations,
> +the \field{payload} of requests and/or responses may be empty. The
> content of the payload depend on the operation.
> +
> +\subsubsection{Property Configuration Layout}\label{sec:Device Types /
> Parameter Server / Device Operation / Property Configuration Layout}
> +
> +\begin{lstlisting}
> +// The max size of virtio_parameter_server_config, including
> +// fixed-length members and params
> +#define VIRTIO_PARAMETER_SERVER_CONFIG_MAX_SIZE_BYTE 4096
> +
> +struct virtio_parameter_server_prop_config {
> +    le32 prop_id;
> +    le32 mode;
> +    le32 min_sample_freq;
> +    le32 max_sample_freq;
> +    le32 encoding[5];
> +    le32 param_size;
> +    char desc[256];
> +    u8 params[<actual param size>];
> +};
> +\end{lstlisting}
> +
> +while \field{mode} is the bitwise-or-combination of the following:
> +
> +\begin{lstlisting}
> +enum virtio_parameter_server_prop_mode {
> +    /* access */
> +    VIRTIO_PARAMETER_SERVER_M_READ = 0x1,
> +    VIRTIO_PARAMETER_SERVER_M_WRITE = 0x2,
> +    VIRTIO_PARAMETER_SERVER_M_READ_WRITE = 0x3,
> +
> +    /* change */
> +    VIRTIO_PARAMETER_SERVER_M_STATIC = 0x4,
> +    VIRTIO_PARAMETER_SERVER_M_MUTABLE = 0x8,
> +    VIRTIO_PARAMETER_SERVER_M_CONTINUOUS = 0xc,
> +};
> +\end{lstlisting}
> +
> +Both VIRTIO_PARAMETER_SERVER_M_MUTABLE and
> VIRTIO_PARAMETER_SERVER_M_CONTINUOUS are dynamic
> +properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will change due to
> the set value operation
> +from the driver, or actions of the external system; a
> VIRTIO_PARAMETER_SERVER_M_CONTINUOUS value
> +is expected to be generated by means of a sensor updating at a steady
> frequency.
> +
> +The reason we want to handle "MUTABLE" and "CONTNUOUS" differently is,
> the MUTABLE values are not
> +constantly changing, so the device may be able to send every updates of
> it to the driver; while
> +CONTINUOUS values are changing frequently (e.g., sensor outputs) and the
> device should decide how
> +to sample it and provide a sample rate range (\field{min_sample_freq} and
> \field{max_sample_freq})
> +
> +The properties with the same \field{prop_id} share the configuration.
> \field{min_sample_freq} and
> +\field{max_sample_freq} are the sampling rate range for the
> +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc} is the
> optional zero-terminated
> +char string description. \field{params} are for the customized
> configuration parameters.
> +
> +The integer array \field{encoding} specifies the number of different
> primitive value in the
> +property value.
> +
> +\begin{lstlisting}
> +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT64 0
> +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_FLOAT64 1
> +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT32 2
> +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_BYTE 3
> +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING 4
> +\end{lstlisting}
> +
> +If the driver asks for ALL property configurations by setting the
> \field{prop_id} of the request to
> +VIRTIO_PARAMETER_SERVER_OP_ALL_PROP, then the \field{payload} of
> virtio_parameter_server_response
> +will be multiple property configurations, serialized 1-by-1.
> +
> +\subsubsection{Property Value Layout}\label{sec:Device Types / Parameter
> Server / Device Operation / Property Value Layout}
> +
> +The property value payload begins with 5 arrays. The order is the same as
> the \field{encoding} array defined above.
> +For each array, it begins with a 32-bit integer for length (number of
> elements). Empty array will be a 32-bit 0, while
> +-1 means the array does not exist. The elements follows the length, and
> the size of the encoded array will be padded
> +to 4 bytes. String is encoded as a zero-terminated char array,
> +\field{encoding[VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING]}
> indicates the existence of the string.
> +
> +After the arrays, there may be customized data, which is encoded as a
> byte array.
> +
> +For example, if \field{encoding} of virtio_parameter_server_prop_config
> of property A is \field{[2, 0, 0, 0, 1]},
> +then property A contains two 64-bit integers and a string. The encoded
> value consists of the following (from top to bottom):
> +
> +\begin{lstlisting}
> +2 (32-bit, meaning 2 64-bit integers)
> +64-bit integer
> +64-bit integer
> +-1 (32-bit, meaning no 64-bit float number array)
> +-1 (32-bit, meaning no 32-bit integer array)
> +-1 (32-bit, meaning no byte array)
> +14 (32-bit integer, length of the char string, including trailing zero,
> excluding padding zeros)
> +"sample string\0"
> +padding zeros to 4 bytes. In this case there will be 2 zero bytes.
> +(optional) byte array length + data if there are customized data
> +\end{lstlisting}
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types /
> Parameter Server / Device Operation}
> +
> +The driver MUST NOT send undefined ops.
> +
> +The driver MUST NOT put descriptors into the eventq.
> +
> +The payload size of requests MUST be padded to 4 bytes.
> +
> +\devicenormative{\subsubsection}{Device Operation}{Device Types /
> Parameter Server / Device Operation}
> +
> +\field{name} of the device configuration MUST be non-empty.
> +
> +The unused bits of the message header MUST be 0.
> +
> +The \field{prop_item_id} of VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG,
> +VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP and
> VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP requests
> +MUST be ignored.
> +
> +The device MUST send exact 1 response for every received request.
> +
> +The payload size of responses and event messages MUST be padded to 4
> bytes.
> +
> +The param size of property configurations MUST be padded to 4 bytes.
> --
> 2.32.0.272.g935e593368-goog
>
>

--00000000000003a09c05c471a47d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 10, 2021 at 4:19 PM Hao Chen &lt;<a href=
=3D"mailto:chenhaosjtuacm@google.com">chenhaosjtuacm@google.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This patch i=
ntroduces a new type of device: parameter server. The device<br>
acts as a key-value store and the driver can read from, write to or<br>
subscribe to the properties in the server.<br>
<br>
Signed-off-by: Hao Chen &lt;<a href=3D"mailto:chenhaosjtuacm@google.com" ta=
rget=3D"_blank">chenhaosjtuacm@google.com</a>&gt;<br>
---<br>
=C2=A0conformance.tex |=C2=A0 26 +++++-<br>
=C2=A0content.tex=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0virtio-ps.tex=C2=A0 =C2=A0| 216 +++++++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A03 files changed, 239 insertions(+), 4 deletions(-)<br>
=C2=A0create mode 100644 virtio-ps.tex<br>
<br>
diff --git a/conformance.tex b/conformance.tex<br>
index a164cbb..0d6b1a5 100644<br>
--- a/conformance.tex<br>
+++ b/conformance.tex<br>
@@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance}=
,<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / Sound Driver Conformance}=
,<br>
=C2=A0\ref{sec:Conformance / Driver Conformance / Memory Driver Conformance=
},<br>
-\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
} or<br>
-\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.<br>
+\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance=
},<br>
+\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or<br=
>
+\ref{sec:Conformance / Driver Conformance / Parameter Server Driver Confor=
mance}.<br>
<br>
=C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conformance / Legacy Interface: T=
ransitional Device and Transitional Driver Conformance}.<br>
=C2=A0 =C2=A0\end{itemize}<br>
@@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance / Con=
formance Targets}<br>
=C2=A0\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}=
,<br>
=C2=A0\ref{sec:Conformance / Device Conformance / Sound Device Conformance}=
,<br>
=C2=A0\ref{sec:Conformance / Device Conformance / Memory Device Conformance=
},<br>
-\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
} or<br>
-\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.<br>
+\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance=
},<br>
+\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}or<br>
+\ref{sec:Conformance / Device Conformance / Parameter Server Device Confor=
mance}.<br>
<br>
=C2=A0 =C2=A0 =C2=A0\item Clause \ref{sec:Conformance / Legacy Interface: T=
ransitional Device and Transitional Driver Conformance}.<br>
=C2=A0 =C2=A0\end{itemize}<br>
@@ -288,6 +290,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}<br>
=C2=A0\item \ref{drivernormative:Device Types / SCMI Device / Device Operat=
ion / Setting Up eventq Buffers}<br>
=C2=A0\end{itemize}<br>
<br>
+\conformance{\subsection}{Parameter Server Driver Conformance}\label{sec:C=
onformance / Driver Conformance / Parameter Server Driver Conformance}<br>
+<br>
+A parameter server driver MUST conform to the following normative statemen=
ts:<br>
+<br>
+\begin{itemize}<br>
+\item \ref{drivernormative:Device Types / Parameter Server / Device Operat=
ion}<br>
+\end{itemize}<br>
+<br>
=C2=A0\conformance{\section}{Device Conformance}\label{sec:Conformance / De=
vice Conformance}<br>
<br>
=C2=A0A device MUST conform to the following normative statements:<br>
@@ -527,6 +537,14 @@ \section{Conformance Targets}\label{sec:Conformance / =
Conformance Targets}<br>
=C2=A0\item \ref{devicenormative:Device Types / SCMI Device / Device Operat=
ion / Shared Memory Operation}<br>
=C2=A0\end{itemize}<br>
<br>
+\conformance{\subsection}{Parameter Server Device Conformance}\label{sec:C=
onformance / Device Conformance / Parameter Server Device Conformance}<br>
+<br>
+A parameter server device MUST conform to the following normative statemen=
ts:<br>
+<br>
+\begin{itemize}<br>
+\item \ref{devicenormative:Device Types / Parameter Server / Device Operat=
ion}<br>
+\end{itemize}<br>
+<br>
=C2=A0\conformance{\section}{Legacy Interface: Transitional Device and Tran=
sitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Tran=
sitional Device and Transitional Driver Conformance}<br>
=C2=A0A conformant implementation MUST be either transitional or<br>
=C2=A0non-transitional, see \ref{intro:Legacy<br>
diff --git a/content.tex b/content.tex<br>
index 9232d5c..b980a93 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing Requirements=
}\label{sec:Device<br>
=C2=A0\input{virtio-mem.tex}<br>
=C2=A0\input{virtio-i2c.tex}<br>
=C2=A0\input{virtio-scmi.tex}<br>
+\input{virtio-ps.tex}<br>
<br>
=C2=A0\chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}<br>
<br>
diff --git a/virtio-ps.tex b/virtio-ps.tex<br>
new file mode 100644<br>
index 0000000..2a226c4<br>
--- /dev/null<br>
+++ b/virtio-ps.tex<br>
@@ -0,0 +1,216 @@<br>
+\section{Parameter Server}\label{sec:Device Types / Parameter Server}<br>
+<br>
+The parameter server device manages a set of values with unique property I=
Ds. These values may<br>
+either be static (i.e. have a constant value) or be dynamic (i.e. value ma=
y change over time).<br>
+The driver can get and set values, get value configurations, subscribe and=
 unsubscribe dynamic<br>
+properties from the device. The driver will get updates when subscribed va=
lue changes. The device<br>
+processes the requests from the driver, enforces the value access rules, a=
nd may potentially alter<br>
+the behavior of external systems as a result of driver operations.<br>
+<br>
+\subsection{Device ID}\label{sec:Device Types / Parameter Server / Device =
ID}<br>
+<br>
+38<br>
+<br>
+\subsection{Virtqueues}\label{sec:Device Types / Parameter Server / Virtqu=
eues}<br>
+<br>
+\begin{description}<br>
+\item[0] cmdq<br>
+\item[1] eventq<br>
+\end{description}<br>
+<br>
+\subsection{Feature Bits}\label{sec:Device Types / Parameter Server / Feat=
ure Bits}<br>
+<br>
+None currently defined.<br>
+<br>
+\subsection{Device Configuration Layout}\label{sec:Device Types / Paramete=
r Server / Device Configuration Layout}<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_parameter_server_config {<br>
+=C2=A0 =C2=A0 char name[128];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+A device configuration space only contains the name of the device, which c=
an be used by the<br>
+userspace for identification. \field{name} is a zero-terminated char strin=
g. The maximum length<br>
+of \field{name} is 127.<br>
+<br>
+\subsection{Device Initialization}<br>
+<br>
+\begin{enumerate}<br>
+\item The virtqueues are initialized.<br>
+\end{enumerate}<br>
+<br>
+\subsection{Device Operation}\label{sec:Device Types / Parameter Server / =
Device Operation}<br>
+<br>
+The driver puts requests to read, write, subscribe to, or unsubscribe from=
, parameters onto the<br>
+cmdq virtqueue. The device also puts its responses to the driver&#39;s req=
uests onto the cmdq<br>
+virtqueue. The device puts any updates to values that the driver has subsc=
ribed to onto the<br>
+eventq virtqueue. The<br>
+\field{prop_id}, \field{prop_item_id} pair is the primary key for the valu=
es stored in the<br>
+parameter server, while the values with the same \field{prop_id} share the=
 same configuration.<br>
+For example, \field{prop_id} 12 with \field{prop_item_id} 0, 1 and 2 repre=
sent 3 different values<br>
+sharing the same \field{virtio_parameter_server_config}. \field{prop_id} i=
s also used for<br>
+subscriptions, meaning that if you subscribe on a prop_id, you will receiv=
e every updates on that<br>
+prop_id regardless of what prop_item_id it contains. \field{prop_item_id} =
is not used in<br>
+subscription.<br>
+<br>
+The layout of requests and responses are defined below:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_parameter_server_request {<br>
+=C2=A0 =C2=A0 le64 timestamp;<br>
+=C2=A0 =C2=A0 le32 prop_id;<br>
+=C2=A0 =C2=A0 le32 prop_item_id;<br>
+=C2=A0 =C2=A0 u8 op;<br>
+=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
+};<br>
+<br>
+struct virtio_parameter_server_response {<br>
+=C2=A0 =C2=A0 le64 timestamp;<br>
+=C2=A0 =C2=A0 le32 prop_id;<br>
+=C2=A0 =C2=A0 le32 prop_item_id;<br>
+=C2=A0 =C2=A0 u16 op;<br>
+=C2=A0 =C2=A0 u16 ret_value;<br>
+=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
+};<br>
+<br>
+/* Reserved prop_id and prop_item_id */<br>
+#define VIRTIO_PARAMETER_SERVER_OP_ALL_PROP INT_MAX<br>
+<br>
+/* Supported operations */<br>
+#define VIRTIO_PARAMETER_SERVER_OP_INVALID 0<br>
+#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG 1<br>
+#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_VALUE 2<br>
+#define VIRTIO_PARAMETER_SERVER_OP_SET_PROP_VALUE 3<br>
+#define VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP 4<br>
+#define VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP 5<br>
+\end{lstlisting}<br>
+<br>
+The layout of messages in eventq is defined below:<br>
+<br>
+\begin{lstlisting}<br>
+struct virtio_parameter_server_event_msg {<br>
+=C2=A0 =C2=A0 le64 timestamp;<br>
+=C2=A0 =C2=A0 le32 prop_id;<br>
+=C2=A0 =C2=A0 le32 prop_item_id;<br>
+=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+There will be exactly one response for each request in the cmdq, even if \=
field{op} is invalid. For some operations,<br>
+the \field{payload} of requests and/or responses may be empty. The content=
 of the payload depend on the operation.<br>
+<br>
+\subsubsection{Property Configuration Layout}\label{sec:Device Types / Par=
ameter Server / Device Operation / Property Configuration Layout}<br>
+<br>
+\begin{lstlisting}<br>
+// The max size of virtio_parameter_server_config, including<br>
+// fixed-length members and params<br>
+#define VIRTIO_PARAMETER_SERVER_CONFIG_MAX_SIZE_BYTE 4096<br>
+<br>
+struct virtio_parameter_server_prop_config {<br>
+=C2=A0 =C2=A0 le32 prop_id;<br>
+=C2=A0 =C2=A0 le32 mode;<br>
+=C2=A0 =C2=A0 le32 min_sample_freq;<br>
+=C2=A0 =C2=A0 le32 max_sample_freq;<br>
+=C2=A0 =C2=A0 le32 encoding[5];<br>
+=C2=A0 =C2=A0 le32 param_size;<br>
+=C2=A0 =C2=A0 char desc[256];<br>
+=C2=A0 =C2=A0 u8 params[&lt;actual param size&gt;];<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+while \field{mode} is the bitwise-or-combination of the following:<br>
+<br>
+\begin{lstlisting}<br>
+enum virtio_parameter_server_prop_mode {<br>
+=C2=A0 =C2=A0 /* access */<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_READ =3D 0x1,<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_WRITE =3D 0x2,<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_READ_WRITE =3D 0x3,<br>
+<br>
+=C2=A0 =C2=A0 /* change */<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_STATIC =3D 0x4,<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_MUTABLE =3D 0x8,<br>
+=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_CONTINUOUS =3D 0xc,<br>
+};<br>
+\end{lstlisting}<br>
+<br>
+Both VIRTIO_PARAMETER_SERVER_M_MUTABLE and VIRTIO_PARAMETER_SERVER_M_CONTI=
NUOUS are dynamic<br>
+properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will change due to t=
he set value operation<br>
+from the driver, or actions of the external system; a VIRTIO_PARAMETER_SER=
VER_M_CONTINUOUS value<br>
+is expected to be generated by means of a sensor updating at a steady freq=
uency.<br>
+<br>
+The reason we want to handle &quot;MUTABLE&quot; and &quot;CONTNUOUS&quot;=
 differently is, the MUTABLE values are not<br>
+constantly changing, so the device may be able to send every updates of it=
 to the driver; while<br>
+CONTINUOUS values are changing frequently (e.g., sensor outputs) and the d=
evice should decide how<br>
+to sample it and provide a sample rate range (\field{min_sample_freq} and =
\field{max_sample_freq})<br>
+<br>
+The properties with the same \field{prop_id} share the configuration. \fie=
ld{min_sample_freq} and<br>
+\field{max_sample_freq} are the sampling rate range for the<br>
+\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc} is the o=
ptional zero-terminated<br>
+char string description. \field{params} are for the customized configurati=
on parameters.<br>
+<br>
+The integer array \field{encoding} specifies the number of different primi=
tive value in the<br>
+property value.<br>
+<br>
+\begin{lstlisting}<br>
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT64 0<br>
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_FLOAT64 1<br>
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT32 2<br>
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_BYTE 3<br>
+#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING 4<br>
+\end{lstlisting}<br>
+<br>
+If the driver asks for ALL property configurations by setting the \field{p=
rop_id} of the request to<br>
+VIRTIO_PARAMETER_SERVER_OP_ALL_PROP, then the \field{payload} of virtio_pa=
rameter_server_response<br>
+will be multiple property configurations, serialized 1-by-1.<br>
+<br>
+\subsubsection{Property Value Layout}\label{sec:Device Types / Parameter S=
erver / Device Operation / Property Value Layout}<br>
+<br>
+The property value payload begins with 5 arrays. The order is the same as =
the \field{encoding} array defined above.<br>
+For each array, it begins with a 32-bit integer for length (number of elem=
ents). Empty array will be a 32-bit 0, while<br>
+-1 means the array does not exist. The elements follows the length, and th=
e size of the encoded array will be padded<br>
+to 4 bytes. String is encoded as a zero-terminated char array,<br>
+\field{encoding[VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING]} indica=
tes the existence of the string.<br>
+<br>
+After the arrays, there may be customized data, which is encoded as a byte=
 array.<br>
+<br>
+For example, if \field{encoding} of virtio_parameter_server_prop_config of=
 property A is \field{[2, 0, 0, 0, 1]},<br>
+then property A contains two 64-bit integers and a string. The encoded val=
ue consists of the following (from top to bottom):<br>
+<br>
+\begin{lstlisting}<br>
+2 (32-bit, meaning 2 64-bit integers)<br>
+64-bit integer<br>
+64-bit integer<br>
+-1 (32-bit, meaning no 64-bit float number array)<br>
+-1 (32-bit, meaning no 32-bit integer array)<br>
+-1 (32-bit, meaning no byte array)<br>
+14 (32-bit integer, length of the char string, including trailing zero, ex=
cluding padding zeros)<br>
+&quot;sample string\0&quot;<br>
+padding zeros to 4 bytes. In this case there will be 2 zero bytes.<br>
+(optional) byte array length + data if there are customized data<br>
+\end{lstlisting}<br>
+<br>
+\drivernormative{\subsubsection}{Device Operation}{Device Types / Paramete=
r Server / Device Operation}<br>
+<br>
+The driver MUST NOT send undefined ops.<br>
+<br>
+The driver MUST NOT put descriptors into the eventq.<br>
+<br>
+The payload size of requests MUST be padded to 4 bytes.<br>
+<br>
+\devicenormative{\subsubsection}{Device Operation}{Device Types / Paramete=
r Server / Device Operation}<br>
+<br>
+\field{name} of the device configuration MUST be non-empty.<br>
+<br>
+The unused bits of the message header MUST be 0.<br>
+<br>
+The \field{prop_item_id} of VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG,<br=
>
+VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP and VIRTIO_PARAMETER_SERVER_OP_U=
NSUBSCRIBE_PROP requests<br>
+MUST be ignored.<br>
+<br>
+The device MUST send exact 1 response for every received request.<br>
+<br>
+The payload size of responses and event messages MUST be padded to 4 bytes=
.<br>
+<br>
+The param size of property configurations MUST be padded to 4 bytes.<br>
-- <br>
2.32.0.272.g935e593368-goog<br>
<br>
</blockquote></div>

--00000000000003a09c05c471a47d--

