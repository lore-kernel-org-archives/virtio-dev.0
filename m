Return-Path: virtio-dev-return-8145-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A64B98653B
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Apr 2021 10:55:14 +0000 (UTC)
Date: Fri, 30 Apr 2021 12:55:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210430125502.43535749.cohuck@redhat.com>
In-Reply-To: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 20 Apr 2021 17:33:17 -0700
Hao Chen <chenhaosjtuacm@google.com> wrote:

> This patch introduces a new type of device: parameter server. The device
> acts as a key-value store and the driver can read from, write to or
> subscribe to the properties in the server.
> 
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  conformance.tex |  26 +++++--
>  content.tex     |   1 +
>  virtio-ps.tex   | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-ps.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index a164cbb..0d6b1a5 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
> Conformance}.

Your client seems to introduce line wraps, which means the patch cannot
be applied without extra massaging by the committer, which is simply
not feasible for a larger patch. Can you please check why it breaks,
and try to fix it?

> 
>      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}

(...)

> diff --git a/virtio-ps.tex b/virtio-ps.tex
> new file mode 100644
> index 0000000..fa0930a
> --- /dev/null
> +++ b/virtio-ps.tex
> @@ -0,0 +1,188 @@
> +\section{Parameter Server}\label{sec:Device Types / Parameter Server}
> +
> +The parameter server device manages a set of values with unique
> property IDs. These values may
> +either be static (i.e. have a constant value) or be dynamic (i.e.
> value may change over time).
> +The driver can get and set values, get value configurations,
> subscribe and unsubscribe dynamic
> +properties from the device. The device processes the requests from

What does 'subscribe' mean? Does the driver get notifications from the
device when a subscribed value changes?

> the driver, enforces the value
> +access rules, and may potentially alter the behavior of external
> systems as a result of driver
> +operations.
> +
> +\subsection{Device ID}\label{sec:Device Types / Parameter Server / Device ID}
> +
> +38
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Parameter Server / Virtqueues}
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
> +A device configuration space only contains the name of the device,
> which can be used by the
> +userspace for identification.
> +
> +\subsection{Device Initialization}
> +
> +\begin{enumerate}
> +\item The virtqueues are initialized.
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / Parameter
> Server / Device Operation}
> +
> +The driver puts the requests to the cmdq virtqueue. The responses

Maybe "The driver puts requests to read, write, subscribe to, or
unsubscribe from, parameters onto the cmdq virtqueue."?

> from the device also go into
> +the cmdq virtqueue. Updates on the subscribed values are put into the

"The device also puts its responses to the driver's requests onto the
cmdq virtqueue. The device puts any updates to values that the driver
has subscribed to onto the eventq virtqueue."

?

> eventq virtqueue. The
> +\field{prop_id}, \field{prop_item_id} pair is the primary key for the
> values stored in the
> +parameter server, while the values with the same \field{prop_id}
> share the same configuration.

I don't quite understand what the second part of the sentence means. Do
you have e.g. a prop_id 42 for a certain property foo, and
prop_item_ids 0, 1, 2, so that (42, 0), (42, 1), (42, 2) are of the
same kind?

> +Subscriptions are also on \field{prop_id}.

Does that mean that if the driver subscribes to prop_id 42, it gets
updates for any of (42, 0), (42, 1), (42, 2)?

> +
> +The layout of requests and responses are defined below:
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_request {
> +    le64 timestamp;
> +    le32 prop_id;
> +    le32 prop_item_id;
> +    le32 payload_size;
> +    u8 op;
> +    u8 payload[<actual payload size>];
> +};
> +
> +struct virtio_parameter_server_response {
> +    le64 timestamp;
> +    le32 prop_id;
> +    le32 prop_item_id;
> +    le32 payload_size;
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
> +    le32 payload_size;
> +    u8 payload[<actual payload size>];
> +};
> +\end{lstlisting}
> +
> +There will be exactly one response for each request in the cmdq, even
> if \field{op} is invalid. For some operations,
> +the \field{payload} of requests and/or responses may be empty. If the
> \field{payload} is non-empty, it can be either
> +property configuration(s) or value. The \field{payload} of messages

I'd simply say that the contents of the payload depend on the operation?

> in the eventq virtqueue is always value.
> +
> +\subsubsection{Property Configuration Layout}\label{sec:Device Types
> / Parameter Server / Device Operation / Property Configuration Layout}
> +
> +\begin{lstlisting}
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
> +properties. A VIRTIO_PARAMETER_SERVER_M_MUTABLE value will change due
> to the set value operation
> +from the driver, or actions of the external system; a
> VIRTIO_PARAMETER_SERVER_M_CONTINUOUS value
> +is expected to be generated by means of a sensor updating at a steady
> frequency.

Do these two types need to be handled differently? If I set up a
subscription "poll this parameter every n ms", it doesn't really matter
why the parameter changes, does it? In any case, it is not under
control of the driver, as "actions of the external system" may also
change a mutable parameter.

> +
> +The properties with the same \field{prop_id} share the configuration.
> \field{min_sample_freq} and
> +\field{max_sample_freq} are the sampling rate range for the
> +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values. \field{desc} is
> the optional string
> +description. \field{params} are for the customized configuration parameters.
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
> +
> +#define VIRTIO_PARAMETER_SERVER_VARIABLE_LENGTH -2

What does that '-2' mean?

> +\end{lstlisting}
> +
> +If the driver asks for ALL property configurations, then the \field{payload} of
> +virtio_parameter_server_response will be multiple property
> configurations, serialized 1-by-1.

How does it ask for all configurations?

> +
> +\subsubsection{Property Value Layout}\label{sec:Device Types /
> Parameter Server / Device Operation / Property Value Layout}
> +
> +The property value payload begins with 5 arrays. The order is the
> same as the \field{encoding} array defined above.
> +For each array, it begins with a 32-bit integer for length (number of
> elements). Empty array will be a 32-bit 0, while
> +-1 means the array does not exist. The elements follows the length,
> and the size of the encoded array will be padded
> +to 4 bytes. String is encoded as char16_t, zero-terminated array.

I don't think we've specified what a char16_t is.


To check whether I understand this correctly, each 'array' seems to be
of the form

<u32 length> <list of data types as specified by length>

and is succeeded by further 'arrays' in the int64..string order
outlined above.

So, does the 'length' correspond to the values specified in the
encoding? Is HAS_STRING indicating the presence of a string or its
length?

> +
> +After the arrays, there may be customized data, which is encoded as a
> byte array.
> +
> +\drivernormative{\subsubsection}{Device Operation}{Device Types /
> Parameter Server / Device Operation}
> +
> +The driver MUST NOT send undefined ops.
> +
> +The driver MUST NOT put device-readable descriptors into the eventq.

s/device-readable// ?

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
> +The payload size of responses and event messages MUST be padded to 4 bytes.
> +
> +The param size of property configurations MUST be padded to 4 bytes.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

