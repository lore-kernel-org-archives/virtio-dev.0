Return-Path: <virtio-dev-return-8775-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B86439862D5
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Oct 2021 18:30:59 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF-Oa52Hq9U+-4zOY7+aL-mrf6+DmhSG51WRnLPjFsdXUA@mail.gmail.com>
 <20210610231954.2937837-1-chenhaosjtuacm@google.com> <CABATKF-PYBmqW-GSy0c12FLDifanKgPRap1DuYbf3dJew5wMHA@mail.gmail.com>
 <CABATKF8JMFFUKb54w9oeuu-ykTXvN0K12=KCYM+b_V+wXmGK+Q@mail.gmail.com> <CABATKF9kqVOeR44vcTH_aw5Sx9geT0-gVpyqngcAwnkcxVN35Q@mail.gmail.com>
In-Reply-To: <CABATKF9kqVOeR44vcTH_aw5Sx9geT0-gVpyqngcAwnkcxVN35Q@mail.gmail.com>
From: Hao Chen <chenhaosjtuacm@android.com>
Date: Mon, 4 Oct 2021 11:30:45 -0700
Message-ID: <CADf7T3w-45Ca2SDZ5GTffr2G+onL_07SU_WO=KV8aPc8nHFEBw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v4] Add virtio parameter server device specification
Content-Type: multipart/alternative; boundary="00000000000025b70905cd8b1dab"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000025b70905cd8b1dab
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Could anyone please help us figure out how to allocate the buffer when the
size of the to-be-sent values are unknown?

Thanks!
Hao

On Mon, Oct 4, 2021 at 11:25 AM Hao Chen <chenhaosjtuacm@google.com> wrote:

> ---------- Forwarded message ---------
> From: Hao Chen <chenhaosjtuacm@google.com>
> Date: Wed, Sep 8, 2021 at 1:42 PM
> Subject: Re: [PATCH v4] Add virtio parameter server device specification
> To: <virtio-dev@lists.oasis-open.org>
>
>
> Hi folks,
>
> I had some issues when trying to implement the sample driver for this
> device proposal. When the device wants to send some values to the
> driver,
> the size of the values may vary a lot, and the size may not be
> determined when the driver allocates buffers for them. The device
> knows more about
> that. I think it will be great if the device can allocate buffers, but
> I didn't see that in the spec. I wonder what will be the current
> solution here.
>
> Thanks!
> Hao
>
> On Fri, Jun 11, 2021 at 11:44 AM Hao Chen <chenhaosjtuacm@google.com>
> wrote:
> >
> > On Thu, Jun 10, 2021 at 4:19 PM Hao Chen <chenhaosjtuacm@google.com>
> wrote:
> > >
> > > This patch introduces a new type of device: parameter server. The
> device
> > > acts as a key-value store and the driver can read from, write to or
> > > subscribe to the properties in the server.
> > >
> > > Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> > > ---
> > >  conformance.tex |  26 +++++-
> > >  content.tex     |   1 +
> > >  virtio-ps.tex   | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 239 insertions(+), 4 deletions(-)
> > >  create mode 100644 virtio-ps.tex
> > >
> > > diff --git a/conformance.tex b/conformance.tex
> > > index a164cbb..0d6b1a5 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
> > >  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
> > >  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
> > >  \ref{sec:Conformance / Driver Conformance / Memory Driver
> Conformance},
> > > -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver
> Conformance} or
> > > -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> > > +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver
> Conformance},
> > > +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}
> or
> > > +\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
> Conformance}.
> > >
> > >      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
> > >    \end{itemize}
> > > @@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
> > >  \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
> > >  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
> > >  \ref{sec:Conformance / Device Conformance / Memory Device
> Conformance},
> > > -\ref{sec:Conformance / Device Conformance / I2C Adapter Device
> Conformance} or
> > > -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> > > +\ref{sec:Conformance / Device Conformance / I2C Adapter Device
> Conformance},
> > > +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}or
> > > +\ref{sec:Conformance / Device Conformance / Parameter Server Device
> Conformance}.
> > >
> > >      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
> > >    \end{itemize}
> > > @@ -288,6 +290,14 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{drivernormative:Device Types / SCMI Device / Device
> Operation / Setting Up eventq Buffers}
> > >  \end{itemize}
> > >
> > > +\conformance{\subsection}{Parameter Server Driver
> Conformance}\label{sec:Conformance / Driver Conformance / Parameter Server
> Driver Conformance}
> > > +
> > > +A parameter server driver MUST conform to the following normative
> statements:
> > > +
> > > +\begin{itemize}
> > > +\item \ref{drivernormative:Device Types / Parameter Server / Device
> Operation}
> > > +\end{itemize}
> > > +
> > >  \conformance{\section}{Device Conformance}\label{sec:Conformance /
> Device Conformance}
> > >
> > >  A device MUST conform to the following normative statements:
> > > @@ -527,6 +537,14 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{devicenormative:Device Types / SCMI Device / Device
> Operation / Shared Memory Operation}
> > >  \end{itemize}
> > >
> > > +\conformance{\subsection}{Parameter Server Device
> Conformance}\label{sec:Conformance / Device Conformance / Parameter Server
> Device Conformance}
> > > +
> > > +A parameter server device MUST conform to the following normative
> statements:
> > > +
> > > +\begin{itemize}
> > > +\item \ref{devicenormative:Device Types / Parameter Server / Device
> Operation}
> > > +\end{itemize}
> > > +
> > >  \conformance{\section}{Legacy Interface: Transitional Device and
> Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}
> > >  A conformant implementation MUST be either transitional or
> > >  non-transitional, see \ref{intro:Legacy
> > > diff --git a/content.tex b/content.tex
> > > index 9232d5c..b980a93 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing
> Requirements}\label{sec:Device
> > >  \input{virtio-mem.tex}
> > >  \input{virtio-i2c.tex}
> > >  \input{virtio-scmi.tex}
> > > +\input{virtio-ps.tex}
> > >
> > >  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > >
> > > diff --git a/virtio-ps.tex b/virtio-ps.tex
> > > new file mode 100644
> > > index 0000000..2a226c4
> > > --- /dev/null
> > > +++ b/virtio-ps.tex
> > > @@ -0,0 +1,216 @@
> > > +\section{Parameter Server}\label{sec:Device Types / Parameter Server}
> > > +
> > > +The parameter server device manages a set of values with unique
> property IDs. These values may
> > > +either be static (i.e. have a constant value) or be dynamic (i.e.
> value may change over time).
> > > +The driver can get and set values, get value configurations,
> subscribe and unsubscribe dynamic
> > > +properties from the device. The driver will get updates when
> subscribed value changes. The device
> > > +processes the requests from the driver, enforces the value access
> rules, and may potentially alter
> > > +the behavior of external systems as a result of driver operations.
> > > +
> > > +\subsection{Device ID}\label{sec:Device Types / Parameter Server /
> Device ID}
> > > +
> > > +38
> > > +
> > > +\subsection{Virtqueues}\label{sec:Device Types / Parameter Server /
> Virtqueues}
> > > +
> > > +\begin{description}
> > > +\item[0] cmdq
> > > +\item[1] eventq
> > > +\end{description}
> > > +
> > > +\subsection{Feature Bits}\label{sec:Device Types / Parameter Server /
> Feature Bits}
> > > +
> > > +None currently defined.
> > > +
> > > +\subsection{Device Configuration Layout}\label{sec:Device Types /
> Parameter Server / Device Configuration Layout}
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_parameter_server_config {
> > > +    char name[128];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +A device configuration space only contains the name of the device,
> which can be used by the
> > > +userspace for identification. \field{name} is a zero-terminated char
> string. The maximum length
> > > +of \field{name} is 127.
> > > +
> > > +\subsection{Device Initialization}
> > > +
> > > +\begin{enumerate}
> > > +\item The virtqueues are initialized.
> > > +\end{enumerate}
> > > +
> > > +\subsection{Device Operation}\label{sec:Device Types / Parameter
> Server / Device Operation}
> > > +
> > > +The driver puts requests to read, write, subscribe to, or unsubscribe
> from, parameters onto the
> > > +cmdq virtqueue. The device also puts its responses to the driver's
> requests onto the cmdq
> > > +virtqueue. The device puts any updates to values that the driver has
> subscribed to onto the
> > > +eventq virtqueue. The
> > > +\field{prop_id}, \field{prop_item_id} pair is the primary key for the
> values stored in the
> > > +parameter server, while the values with the same \field{prop_id}
> share the same configuration.
> > > +For example, \field{prop_id} 12 with \field{prop_item_id} 0, 1 and 2
> represent 3 different values
> > > +sharing the same \field{virtio_parameter_server_config}.
> \field{prop_id} is also used for
> > > +subscriptions, meaning that if you subscribe on a prop_id, you will
> receive every updates on that
> > > +prop_id regardless of what prop_item_id it contains.
> \field{prop_item_id} is not used in
> > > +subscription.
> > > +
> > > +The layout of requests and responses are defined below:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_parameter_server_request {
> > > +    le64 timestamp;
> > > +    le32 prop_id;
> > > +    le32 prop_item_id;
> > > +    u8 op;
> > > +    u8 payload[<actual payload size>];
> > > +};
> > > +
> > > +struct virtio_parameter_server_response {
> > > +    le64 timestamp;
> > > +    le32 prop_id;
> > > +    le32 prop_item_id;
> > > +    u16 op;
> > > +    u16 ret_value;
> > > +    u8 payload[<actual payload size>];
> > > +};
> > > +
> > > +/* Reserved prop_id and prop_item_id */
> > > +#define VIRTIO_PARAMETER_SERVER_OP_ALL_PROP INT_MAX
> > > +
> > > +/* Supported operations */
> > > +#define VIRTIO_PARAMETER_SERVER_OP_INVALID 0
> > > +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG 1
> > > +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_VALUE 2
> > > +#define VIRTIO_PARAMETER_SERVER_OP_SET_PROP_VALUE 3
> > > +#define VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP 4
> > > +#define VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP 5
> > > +\end{lstlisting}
> > > +
> > > +The layout of messages in eventq is defined below:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_parameter_server_event_msg {
> > > +    le64 timestamp;
> > > +    le32 prop_id;
> > > +    le32 prop_item_id;
> > > +    u8 payload[<actual payload size>];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +There will be exactly one response for each request in the cmdq, even
> if \field{op} is invalid. For some operations,
> > > +the \field{payload} of requests and/or responses may be empty. The
> content of the payload depend on the operation.
> > > +
> > > +\subsubsection{Property Configuration Layout}\label{sec:Device Types
> / Parameter Server / Device Operation / Property Configuration Layout}
> > > +
> > > +\begin{lstlisting}
> > > +// The max size of virtio_parameter_server_config, including
> > > +// fixed-length members and params
> > > +#define VIRTIO_PARAMETER_SERVER_CONFIG_MAX_SIZE_BYTE 4096
> > > +
> > > +struct virtio_parameter_server_prop_config {
> > > +    le32 prop_id;
> > > +    le32 mode;
> > > +    le32 min_sample_freq;
> > > +    le32 max_sample_freq;
> > > +    le32 encoding[5];
> > > +    le32 param_size;
> > > +    char desc[256];
> > > +    u8 params[<actual param size>];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +while \field{mode} is the bitwise-or-combination of the following:
> > > +
> > > +\begin{lstlisting}
> > > +enum virtio_parameter_server_prop_mode {
> > > +    /* access */
> > > +    VIRTIO_PARAMETER_SERVER_M_READ = 0x1,
> > > +    VIRTIO_PARAMETER_SERVER_M_WRITE = 0x2,
> > > +    VIRTIO_PARAMETER_SERVER_M_READ_WRITE = 0x3,
> > > +
> > > +    /* change */
> > > +    VIRTIO_PARAMETER_SERVER_M_STATIC = 0x4,
> > > +    VIRTIO_PARAMETER_SERVER_M_MUTABLE = 0x8,
> > > +    VIRTIO_PARAMETER_SERVER_M_CONTINUOUS = 0xc,
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +Both VIRTIO_PARAMETER_SERVER_M_MUTABLE and
> VIRTIO_PARAMETER_SERVER_M_CONTINUOUS are dynamic
> > > +properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will change due
> to the set value operation
> > > +from the driver, or actions of the external system; a
> VIRTIO_PARAMETER_SERVER_M_CONTINUOUS value
> > > +is expected to be generated by means of a sensor updating at a steady
> frequency.
> > > +
> > > +The reason we want to handle "MUTABLE" and "CONTNUOUS" differently
> is, the MUTABLE values are not
> > > +constantly changing, so the device may be able to send every updates
> of it to the driver; while
> > > +CONTINUOUS values are changing frequently (e.g., sensor outputs) and
> the device should decide how
> > > +to sample it and provide a sample rate range (\field{min_sample_freq}
> and \field{max_sample_freq})
> > > +
> > > +The properties with the same \field{prop_id} share the configuration.
> \field{min_sample_freq} and
> > > +\field{max_sample_freq} are the sampling rate range for the
> > > +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc} is
> the optional zero-terminated
> > > +char string description. \field{params} are for the customized
> configuration parameters.
> > > +
> > > +The integer array \field{encoding} specifies the number of different
> primitive value in the
> > > +property value.
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT64 0
> > > +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_FLOAT64 1
> > > +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT32 2
> > > +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_BYTE 3
> > > +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING 4
> > > +\end{lstlisting}
> > > +
> > > +If the driver asks for ALL property configurations by setting the
> \field{prop_id} of the request to
> > > +VIRTIO_PARAMETER_SERVER_OP_ALL_PROP, then the \field{payload} of
> virtio_parameter_server_response
> > > +will be multiple property configurations, serialized 1-by-1.
> > > +
> > > +\subsubsection{Property Value Layout}\label{sec:Device Types /
> Parameter Server / Device Operation / Property Value Layout}
> > > +
> > > +The property value payload begins with 5 arrays. The order is the
> same as the \field{encoding} array defined above.
> > > +For each array, it begins with a 32-bit integer for length (number of
> elements). Empty array will be a 32-bit 0, while
> > > +-1 means the array does not exist. The elements follows the length,
> and the size of the encoded array will be padded
> > > +to 4 bytes. String is encoded as a zero-terminated char array,
> > > +\field{encoding[VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING]}
> indicates the existence of the string.
> > > +
> > > +After the arrays, there may be customized data, which is encoded as a
> byte array.
> > > +
> > > +For example, if \field{encoding} of
> virtio_parameter_server_prop_config of property A is \field{[2, 0, 0, 0,
> 1]},
> > > +then property A contains two 64-bit integers and a string. The
> encoded value consists of the following (from top to bottom):
> > > +
> > > +\begin{lstlisting}
> > > +2 (32-bit, meaning 2 64-bit integers)
> > > +64-bit integer
> > > +64-bit integer
> > > +-1 (32-bit, meaning no 64-bit float number array)
> > > +-1 (32-bit, meaning no 32-bit integer array)
> > > +-1 (32-bit, meaning no byte array)
> > > +14 (32-bit integer, length of the char string, including trailing
> zero, excluding padding zeros)
> > > +"sample string\0"
> > > +padding zeros to 4 bytes. In this case there will be 2 zero bytes.
> > > +(optional) byte array length + data if there are customized data
> > > +\end{lstlisting}
> > > +
> > > +\drivernormative{\subsubsection}{Device Operation}{Device Types /
> Parameter Server / Device Operation}
> > > +
> > > +The driver MUST NOT send undefined ops.
> > > +
> > > +The driver MUST NOT put descriptors into the eventq.
> > > +
> > > +The payload size of requests MUST be padded to 4 bytes.
> > > +
> > > +\devicenormative{\subsubsection}{Device Operation}{Device Types /
> Parameter Server / Device Operation}
> > > +
> > > +\field{name} of the device configuration MUST be non-empty.
> > > +
> > > +The unused bits of the message header MUST be 0.
> > > +
> > > +The \field{prop_item_id} of
> VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG,
> > > +VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP and
> VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP requests
> > > +MUST be ignored.
> > > +
> > > +The device MUST send exact 1 response for every received request.
> > > +
> > > +The payload size of responses and event messages MUST be padded to 4
> bytes.
> > > +
> > > +The param size of property configurations MUST be padded to 4 bytes.
> > > --
> > > 2.32.0.272.g935e593368-goog
> > >
>

--00000000000025b70905cd8b1dab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi folks,</div><div><br></div><div>Could anyone pleas=
e help us figure out how to allocate the buffer when the size of the to-be-=
sent values are unknown?</div><div><br></div><div>Thanks!</div><div>Hao</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Oct 4, 2021 at 11:25 AM Hao Chen &lt;<a href=3D"mailto:chenhaosjtuacm@g=
oogle.com">chenhaosjtuacm@google.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">---------- Forwarded message ---------<=
br>
From: Hao Chen &lt;<a href=3D"mailto:chenhaosjtuacm@google.com" target=3D"_=
blank">chenhaosjtuacm@google.com</a>&gt;<br>
Date: Wed, Sep 8, 2021 at 1:42 PM<br>
Subject: Re: [PATCH v4] Add virtio parameter server device specification<br=
>
To: &lt;<a href=3D"mailto:virtio-dev@lists.oasis-open.org" target=3D"_blank=
">virtio-dev@lists.oasis-open.org</a>&gt;<br>
<br>
<br>
Hi folks,<br>
<br>
I had some issues when trying to implement the sample driver for this<br>
device proposal. When the device wants to send some values to the<br>
driver,<br>
the size of the values may vary a lot, and the size may not be<br>
determined when the driver allocates buffers for them. The device<br>
knows more about<br>
that. I think it will be great if the device can allocate buffers, but<br>
I didn&#39;t see that in the spec. I wonder what will be the current<br>
solution here.<br>
<br>
Thanks!<br>
Hao<br>
<br>
On Fri, Jun 11, 2021 at 11:44 AM Hao Chen &lt;<a href=3D"mailto:chenhaosjtu=
acm@google.com" target=3D"_blank">chenhaosjtuacm@google.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; On Thu, Jun 10, 2021 at 4:19 PM Hao Chen &lt;<a href=3D"mailto:chenhao=
sjtuacm@google.com" target=3D"_blank">chenhaosjtuacm@google.com</a>&gt; wro=
te:<br>
&gt; &gt;<br>
&gt; &gt; This patch introduces a new type of device: parameter server. The=
 device<br>
&gt; &gt; acts as a key-value store and the driver can read from, write to =
or<br>
&gt; &gt; subscribe to the properties in the server.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Hao Chen &lt;<a href=3D"mailto:chenhaosjtuacm@goog=
le.com" target=3D"_blank">chenhaosjtuacm@google.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 conformance.tex |=C2=A0 26 +++++-<br>
&gt; &gt;=C2=A0 content.tex=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt;=C2=A0 virtio-ps.tex=C2=A0 =C2=A0| 216 +++++++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; &gt;=C2=A0 3 files changed, 239 insertions(+), 4 deletions(-)<br>
&gt; &gt;=C2=A0 create mode 100644 virtio-ps.tex<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/conformance.tex b/conformance.tex<br>
&gt; &gt; index a164cbb..0d6b1a5 100644<br>
&gt; &gt; --- a/conformance.tex<br>
&gt; &gt; +++ b/conformance.tex<br>
&gt; &gt; @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conform=
ance / Conformance Targets}<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Driver Conformance / IOMMU Driver Co=
nformance},<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Driver Conformance / Sound Driver Co=
nformance},<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Driver Conformance / Memory Driver C=
onformance},<br>
&gt; &gt; -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver C=
onformance} or<br>
&gt; &gt; -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conforma=
nce}.<br>
&gt; &gt; +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver C=
onformance},<br>
&gt; &gt; +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conforma=
nce} or<br>
&gt; &gt; +\ref{sec:Conformance / Driver Conformance / Parameter Server Dri=
ver Conformance}.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 \item Clause \ref{sec:Conformance / Legacy In=
terface: Transitional Device and Transitional Driver Conformance}.<br>
&gt; &gt;=C2=A0 =C2=A0 \end{itemize}<br>
&gt; &gt; @@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conform=
ance / Conformance Targets}<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Device Conformance / IOMMU Device Co=
nformance},<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Device Conformance / Sound Device Co=
nformance},<br>
&gt; &gt;=C2=A0 \ref{sec:Conformance / Device Conformance / Memory Device C=
onformance},<br>
&gt; &gt; -\ref{sec:Conformance / Device Conformance / I2C Adapter Device C=
onformance} or<br>
&gt; &gt; -\ref{sec:Conformance / Device Conformance / SCMI Device Conforma=
nce}.<br>
&gt; &gt; +\ref{sec:Conformance / Device Conformance / I2C Adapter Device C=
onformance},<br>
&gt; &gt; +\ref{sec:Conformance / Device Conformance / SCMI Device Conforma=
nce}or<br>
&gt; &gt; +\ref{sec:Conformance / Device Conformance / Parameter Server Dev=
ice Conformance}.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 \item Clause \ref{sec:Conformance / Legacy In=
terface: Transitional Device and Transitional Driver Conformance}.<br>
&gt; &gt;=C2=A0 =C2=A0 \end{itemize}<br>
&gt; &gt; @@ -288,6 +290,14 @@ \section{Conformance Targets}\label{sec:Conf=
ormance / Conformance Targets}<br>
&gt; &gt;=C2=A0 \item \ref{drivernormative:Device Types / SCMI Device / Dev=
ice Operation / Setting Up eventq Buffers}<br>
&gt; &gt;=C2=A0 \end{itemize}<br>
&gt; &gt;<br>
&gt; &gt; +\conformance{\subsection}{Parameter Server Driver Conformance}\l=
abel{sec:Conformance / Driver Conformance / Parameter Server Driver Conform=
ance}<br>
&gt; &gt; +<br>
&gt; &gt; +A parameter server driver MUST conform to the following normativ=
e statements:<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{itemize}<br>
&gt; &gt; +\item \ref{drivernormative:Device Types / Parameter Server / Dev=
ice Operation}<br>
&gt; &gt; +\end{itemize}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 \conformance{\section}{Device Conformance}\label{sec:Confor=
mance / Device Conformance}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 A device MUST conform to the following normative statements=
:<br>
&gt; &gt; @@ -527,6 +537,14 @@ \section{Conformance Targets}\label{sec:Conf=
ormance / Conformance Targets}<br>
&gt; &gt;=C2=A0 \item \ref{devicenormative:Device Types / SCMI Device / Dev=
ice Operation / Shared Memory Operation}<br>
&gt; &gt;=C2=A0 \end{itemize}<br>
&gt; &gt;<br>
&gt; &gt; +\conformance{\subsection}{Parameter Server Device Conformance}\l=
abel{sec:Conformance / Device Conformance / Parameter Server Device Conform=
ance}<br>
&gt; &gt; +<br>
&gt; &gt; +A parameter server device MUST conform to the following normativ=
e statements:<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{itemize}<br>
&gt; &gt; +\item \ref{devicenormative:Device Types / Parameter Server / Dev=
ice Operation}<br>
&gt; &gt; +\end{itemize}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 \conformance{\section}{Legacy Interface: Transitional Devic=
e and Transitional Driver Conformance}\label{sec:Conformance / Legacy Inter=
face: Transitional Device and Transitional Driver Conformance}<br>
&gt; &gt;=C2=A0 A conformant implementation MUST be either transitional or<=
br>
&gt; &gt;=C2=A0 non-transitional, see \ref{intro:Legacy<br>
&gt; &gt; diff --git a/content.tex b/content.tex<br>
&gt; &gt; index 9232d5c..b980a93 100644<br>
&gt; &gt; --- a/content.tex<br>
&gt; &gt; +++ b/content.tex<br>
&gt; &gt; @@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing Re=
quirements}\label{sec:Device<br>
&gt; &gt;=C2=A0 \input{virtio-mem.tex}<br>
&gt; &gt;=C2=A0 \input{virtio-i2c.tex}<br>
&gt; &gt;=C2=A0 \input{virtio-scmi.tex}<br>
&gt; &gt; +\input{virtio-ps.tex}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature =
Bits}<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/virtio-ps.tex b/virtio-ps.tex<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000..2a226c4<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/virtio-ps.tex<br>
&gt; &gt; @@ -0,0 +1,216 @@<br>
&gt; &gt; +\section{Parameter Server}\label{sec:Device Types / Parameter Se=
rver}<br>
&gt; &gt; +<br>
&gt; &gt; +The parameter server device manages a set of values with unique =
property IDs. These values may<br>
&gt; &gt; +either be static (i.e. have a constant value) or be dynamic (i.e=
. value may change over time).<br>
&gt; &gt; +The driver can get and set values, get value configurations, sub=
scribe and unsubscribe dynamic<br>
&gt; &gt; +properties from the device. The driver will get updates when sub=
scribed value changes. The device<br>
&gt; &gt; +processes the requests from the driver, enforces the value acces=
s rules, and may potentially alter<br>
&gt; &gt; +the behavior of external systems as a result of driver operation=
s.<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Device ID}\label{sec:Device Types / Parameter Server=
 / Device ID}<br>
&gt; &gt; +<br>
&gt; &gt; +38<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Virtqueues}\label{sec:Device Types / Parameter Serve=
r / Virtqueues}<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{description}<br>
&gt; &gt; +\item[0] cmdq<br>
&gt; &gt; +\item[1] eventq<br>
&gt; &gt; +\end{description}<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Feature Bits}\label{sec:Device Types / Parameter Ser=
ver / Feature Bits}<br>
&gt; &gt; +<br>
&gt; &gt; +None currently defined.<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Device Configuration Layout}\label{sec:Device Types =
/ Parameter Server / Device Configuration Layout}<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +struct virtio_parameter_server_config {<br>
&gt; &gt; +=C2=A0 =C2=A0 char name[128];<br>
&gt; &gt; +};<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +A device configuration space only contains the name of the devic=
e, which can be used by the<br>
&gt; &gt; +userspace for identification. \field{name} is a zero-terminated =
char string. The maximum length<br>
&gt; &gt; +of \field{name} is 127.<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Device Initialization}<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{enumerate}<br>
&gt; &gt; +\item The virtqueues are initialized.<br>
&gt; &gt; +\end{enumerate}<br>
&gt; &gt; +<br>
&gt; &gt; +\subsection{Device Operation}\label{sec:Device Types / Parameter=
 Server / Device Operation}<br>
&gt; &gt; +<br>
&gt; &gt; +The driver puts requests to read, write, subscribe to, or unsubs=
cribe from, parameters onto the<br>
&gt; &gt; +cmdq virtqueue. The device also puts its responses to the driver=
&#39;s requests onto the cmdq<br>
&gt; &gt; +virtqueue. The device puts any updates to values that the driver=
 has subscribed to onto the<br>
&gt; &gt; +eventq virtqueue. The<br>
&gt; &gt; +\field{prop_id}, \field{prop_item_id} pair is the primary key fo=
r the values stored in the<br>
&gt; &gt; +parameter server, while the values with the same \field{prop_id}=
 share the same configuration.<br>
&gt; &gt; +For example, \field{prop_id} 12 with \field{prop_item_id} 0, 1 a=
nd 2 represent 3 different values<br>
&gt; &gt; +sharing the same \field{virtio_parameter_server_config}. \field{=
prop_id} is also used for<br>
&gt; &gt; +subscriptions, meaning that if you subscribe on a prop_id, you w=
ill receive every updates on that<br>
&gt; &gt; +prop_id regardless of what prop_item_id it contains. \field{prop=
_item_id} is not used in<br>
&gt; &gt; +subscription.<br>
&gt; &gt; +<br>
&gt; &gt; +The layout of requests and responses are defined below:<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +struct virtio_parameter_server_request {<br>
&gt; &gt; +=C2=A0 =C2=A0 le64 timestamp;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_item_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 u8 op;<br>
&gt; &gt; +=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +struct virtio_parameter_server_response {<br>
&gt; &gt; +=C2=A0 =C2=A0 le64 timestamp;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_item_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 u16 op;<br>
&gt; &gt; +=C2=A0 =C2=A0 u16 ret_value;<br>
&gt; &gt; +=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +/* Reserved prop_id and prop_item_id */<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_ALL_PROP INT_MAX<br>
&gt; &gt; +<br>
&gt; &gt; +/* Supported operations */<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_INVALID 0<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_CONFIG 1<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_GET_PROP_VALUE 2<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_SET_PROP_VALUE 3<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP 4<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_OP_UNSUBSCRIBE_PROP 5<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +The layout of messages in eventq is defined below:<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +struct virtio_parameter_server_event_msg {<br>
&gt; &gt; +=C2=A0 =C2=A0 le64 timestamp;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_item_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 u8 payload[&lt;actual payload size&gt;];<br>
&gt; &gt; +};<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +There will be exactly one response for each request in the cmdq,=
 even if \field{op} is invalid. For some operations,<br>
&gt; &gt; +the \field{payload} of requests and/or responses may be empty. T=
he content of the payload depend on the operation.<br>
&gt; &gt; +<br>
&gt; &gt; +\subsubsection{Property Configuration Layout}\label{sec:Device T=
ypes / Parameter Server / Device Operation / Property Configuration Layout}=
<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +// The max size of virtio_parameter_server_config, including<br>
&gt; &gt; +// fixed-length members and params<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_CONFIG_MAX_SIZE_BYTE 4096<br>
&gt; &gt; +<br>
&gt; &gt; +struct virtio_parameter_server_prop_config {<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 prop_id;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 mode;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 min_sample_freq;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 max_sample_freq;<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 encoding[5];<br>
&gt; &gt; +=C2=A0 =C2=A0 le32 param_size;<br>
&gt; &gt; +=C2=A0 =C2=A0 char desc[256];<br>
&gt; &gt; +=C2=A0 =C2=A0 u8 params[&lt;actual param size&gt;];<br>
&gt; &gt; +};<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +while \field{mode} is the bitwise-or-combination of the followin=
g:<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +enum virtio_parameter_server_prop_mode {<br>
&gt; &gt; +=C2=A0 =C2=A0 /* access */<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_READ =3D 0x1,<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_WRITE =3D 0x2,<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_READ_WRITE =3D 0x3,<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* change */<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_STATIC =3D 0x4,<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_MUTABLE =3D 0x8,<br>
&gt; &gt; +=C2=A0 =C2=A0 VIRTIO_PARAMETER_SERVER_M_CONTINUOUS =3D 0xc,<br>
&gt; &gt; +};<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +Both VIRTIO_PARAMETER_SERVER_M_MUTABLE and VIRTIO_PARAMETER_SERV=
ER_M_CONTINUOUS are dynamic<br>
&gt; &gt; +properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will chang=
e due to the set value operation<br>
&gt; &gt; +from the driver, or actions of the external system; a VIRTIO_PAR=
AMETER_SERVER_M_CONTINUOUS value<br>
&gt; &gt; +is expected to be generated by means of a sensor updating at a s=
teady frequency.<br>
&gt; &gt; +<br>
&gt; &gt; +The reason we want to handle &quot;MUTABLE&quot; and &quot;CONTN=
UOUS&quot; differently is, the MUTABLE values are not<br>
&gt; &gt; +constantly changing, so the device may be able to send every upd=
ates of it to the driver; while<br>
&gt; &gt; +CONTINUOUS values are changing frequently (e.g., sensor outputs)=
 and the device should decide how<br>
&gt; &gt; +to sample it and provide a sample rate range (\field{min_sample_=
freq} and \field{max_sample_freq})<br>
&gt; &gt; +<br>
&gt; &gt; +The properties with the same \field{prop_id} share the configura=
tion. \field{min_sample_freq} and<br>
&gt; &gt; +\field{max_sample_freq} are the sampling rate range for the<br>
&gt; &gt; +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc=
} is the optional zero-terminated<br>
&gt; &gt; +char string description. \field{params} are for the customized c=
onfiguration parameters.<br>
&gt; &gt; +<br>
&gt; &gt; +The integer array \field{encoding} specifies the number of diffe=
rent primitive value in the<br>
&gt; &gt; +property value.<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT64 0<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_FLOAT64 1<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_INT32 2<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_NUM_BYTE 3<br>
&gt; &gt; +#define VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRING 4<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +If the driver asks for ALL property configurations by setting th=
e \field{prop_id} of the request to<br>
&gt; &gt; +VIRTIO_PARAMETER_SERVER_OP_ALL_PROP, then the \field{payload} of=
 virtio_parameter_server_response<br>
&gt; &gt; +will be multiple property configurations, serialized 1-by-1.<br>
&gt; &gt; +<br>
&gt; &gt; +\subsubsection{Property Value Layout}\label{sec:Device Types / P=
arameter Server / Device Operation / Property Value Layout}<br>
&gt; &gt; +<br>
&gt; &gt; +The property value payload begins with 5 arrays. The order is th=
e same as the \field{encoding} array defined above.<br>
&gt; &gt; +For each array, it begins with a 32-bit integer for length (numb=
er of elements). Empty array will be a 32-bit 0, while<br>
&gt; &gt; +-1 means the array does not exist. The elements follows the leng=
th, and the size of the encoded array will be padded<br>
&gt; &gt; +to 4 bytes. String is encoded as a zero-terminated char array,<b=
r>
&gt; &gt; +\field{encoding[VIRTIO_PARAMETER_SERVER_ENCODING_INDEX_HAS_STRIN=
G]} indicates the existence of the string.<br>
&gt; &gt; +<br>
&gt; &gt; +After the arrays, there may be customized data, which is encoded=
 as a byte array.<br>
&gt; &gt; +<br>
&gt; &gt; +For example, if \field{encoding} of virtio_parameter_server_prop=
_config of property A is \field{[2, 0, 0, 0, 1]},<br>
&gt; &gt; +then property A contains two 64-bit integers and a string. The e=
ncoded value consists of the following (from top to bottom):<br>
&gt; &gt; +<br>
&gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; +2 (32-bit, meaning 2 64-bit integers)<br>
&gt; &gt; +64-bit integer<br>
&gt; &gt; +64-bit integer<br>
&gt; &gt; +-1 (32-bit, meaning no 64-bit float number array)<br>
&gt; &gt; +-1 (32-bit, meaning no 32-bit integer array)<br>
&gt; &gt; +-1 (32-bit, meaning no byte array)<br>
&gt; &gt; +14 (32-bit integer, length of the char string, including trailin=
g zero, excluding padding zeros)<br>
&gt; &gt; +&quot;sample string\0&quot;<br>
&gt; &gt; +padding zeros to 4 bytes. In this case there will be 2 zero byte=
s.<br>
&gt; &gt; +(optional) byte array length + data if there are customized data=
<br>
&gt; &gt; +\end{lstlisting}<br>
&gt; &gt; +<br>
&gt; &gt; +\drivernormative{\subsubsection}{Device Operation}{Device Types =
/ Parameter Server / Device Operation}<br>
&gt; &gt; +<br>
&gt; &gt; +The driver MUST NOT send undefined ops.<br>
&gt; &gt; +<br>
&gt; &gt; +The driver MUST NOT put descriptors into the eventq.<br>
&gt; &gt; +<br>
&gt; &gt; +The payload size of requests MUST be padded to 4 bytes.<br>
&gt; &gt; +<br>
&gt; &gt; +\devicenormative{\subsubsection}{Device Operation}{Device Types =
/ Parameter Server / Device Operation}<br>
&gt; &gt; +<br>
&gt; &gt; +\field{name} of the device configuration MUST be non-empty.<br>
&gt; &gt; +<br>
&gt; &gt; +The unused bits of the message header MUST be 0.<br>
&gt; &gt; +<br>
&gt; &gt; +The \field{prop_item_id} of VIRTIO_PARAMETER_SERVER_OP_GET_PROP_=
CONFIG,<br>
&gt; &gt; +VIRTIO_PARAMETER_SERVER_OP_SUBSCRIBE_PROP and VIRTIO_PARAMETER_S=
ERVER_OP_UNSUBSCRIBE_PROP requests<br>
&gt; &gt; +MUST be ignored.<br>
&gt; &gt; +<br>
&gt; &gt; +The device MUST send exact 1 response for every received request=
.<br>
&gt; &gt; +<br>
&gt; &gt; +The payload size of responses and event messages MUST be padded =
to 4 bytes.<br>
&gt; &gt; +<br>
&gt; &gt; +The param size of property configurations MUST be padded to 4 by=
tes.<br>
&gt; &gt; --<br>
&gt; &gt; 2.32.0.272.g935e593368-goog<br>
&gt; &gt;<br>
</blockquote></div></div>

--00000000000025b70905cd8b1dab--

