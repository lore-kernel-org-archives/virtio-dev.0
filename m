Return-Path: virtio-dev-return-8182-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FAE6986229
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jun 2021 09:52:03 +0000 (UTC)
Date: Wed, 9 Jun 2021 10:12:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YMCF+yUx9y36q+JL@stefanha-x1.localdomain>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="idaf31ji9Gpsr8Md"
Content-Disposition: inline
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--idaf31ji9Gpsr8Md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 05:33:17PM -0700, Hao Chen wrote:
> This patch introduces a new type of device: parameter server. The device
> acts as a key-value store and the driver can read from, write to or
> subscribe to the properties in the server.
>=20
> Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
> ---
>  conformance.tex |  26 +++++--
>  content.tex     |   1 +
>  virtio-ps.tex   | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-ps.tex
>=20
> diff --git a/conformance.tex b/conformance.tex
> index a164cbb..0d6b1a5 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -29,8 +29,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
>  \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conforman=
ce} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conforman=
ce},
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / Parameter Server Driver
> Conformance}.
>=20
>      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -52,8 +53,9 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
>  \ref{sec:Conformance / Device Conformance / IOMMU Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> -\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conforman=
ce} or
> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / I2C Adapter Device Conforman=
ce},
> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}or
> +\ref{sec:Conformance / Device Conformance / Parameter Server Device
> Conformance}.
>=20
>      \item Clause \ref{sec:Conformance / Legacy Interface:
> Transitional Device and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -288,6 +290,14 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / SCMI Device / Device
> Operation / Setting Up eventq Buffers}
>  \end{itemize}
>=20
> +\conformance{\subsection}{Parameter Server Driver
> Conformance}\label{sec:Conformance / Driver Conformance / Parameter
> Server Driver Conformance}
> +
> +A parameter server driver MUST conform to the following normative statem=
ents:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / Parameter Server / Device Oper=
ation}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance /
> Device Conformance}
>=20
>  A device MUST conform to the following normative statements:
> @@ -527,6 +537,14 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / SCMI Device / Device
> Operation / Shared Memory Operation}
>  \end{itemize}
>=20
> +\conformance{\subsection}{Parameter Server Device
> Conformance}\label{sec:Conformance / Device Conformance / Parameter
> Server Device Conformance}
> +
> +A parameter server device MUST conform to the following normative statem=
ents:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / Parameter Server / Device Oper=
ation}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and
> Transitional Driver Conformance}\label{sec:Conformance / Legacy
> Interface: Transitional Device and Transitional Driver Conformance}
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
>=20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>=20
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
> the driver, enforces the value
> +access rules, and may potentially alter the behavior of external
> systems as a result of driver
> +operations.
>
> +\subsection{Device ID}\label{sec:Device Types / Parameter Server / Devic=
e ID}
> +
> +38
> +
> +\subsection{Virtqueues}\label{sec:Device Types / Parameter Server / Virt=
queues}
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

What is the character encoding?

Is this field NUL-terminated?

Can the name be 128 chars long (no NUL terminator)?

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
> from the device also go into
> +the cmdq virtqueue. Updates on the subscribed values are put into the
> eventq virtqueue. The
> +\field{prop_id}, \field{prop_item_id} pair is the primary key for the
> values stored in the
> +parameter server, while the values with the same \field{prop_id}
> share the same configuration.

What does "share the same configuration" mean? I guess prop_id might be
a unique system identifier like a DNS domain name, an IP address, or a
UUID and you're saying that all parameters associated with that system
are stored under the same prop_id? That's one convention for using this
device interface, but there may be others that are also valid and
useful. I'm not sure if the spec should mention this (unless you go into
more detail about the structure of the keys later).

> +Subscriptions are also on \field{prop_id}.

Does this mean

  "Subscriptions monitor all <prop_id, prop_item_id> pairs for a given
  prop_id. It is not possible to monitor an individual <prop_id,
  prop_item_id> pair without also monitoring all other pairs with the
  same prop_id."

or

  "Subscriptions can monitor individual <prop_id, prop_item_id> pairs or
  all <prop_id, prop_item_id> pairs for a given prop_id"

?

> +
> +The layout of requests and responses are defined below:
> +
> +\begin{lstlisting}
> +struct virtio_parameter_server_request {
> +    le64 timestamp;

What are the units of this timestamp (nanoseconds, milliseconds,
seconds)?

Is there a reference clock so the device and driver can expect to be
synchronized (e.g. time since the UNIX epoch)?

What is the purpose of this field? Is there a timeout/time-to-live
feature?

> +    le32 prop_id;
> +    le32 prop_item_id;
> +    le32 payload_size;

There is no need to include a payload_size field because the device can
infer it from the buffer length:

  payload_size =3D virtq_elem_length - sizeof(struct virtio_parameter_serve=
r_request)

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
> in the eventq virtqueue is always value.

A common request layout for devices is:

  struct request {
      struct request_header header;
      u8 data[];
      struct request_footer footer;
  };

The data[] field has a variable size depending on the payload being
transferred. It can even support bi-directional transfers where the data
being written to the device comes first, followed by the data being read
from the device.

I suggest using this layout since other devices are also designed like
this. A few notes compared to what you have described:
1. There is no need for payload_size fields because the payload size can
   be inferred from the buffer (virtqueue element) length.
2. The footer is filled in by the device. There's no need to explicitly
   mention that the footer (struct virtio_parameter_server_response) is
   placed on the cmdq since it's embedded in struct request.
3. There's a 1:1 relationship between header and footer. There is no
   need to mention that most requests have a response associated with
   them.

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
> +    VIRTIO_PARAMETER_SERVER_M_READ =3D 0x1,
> +    VIRTIO_PARAMETER_SERVER_M_WRITE =3D 0x2,
> +    VIRTIO_PARAMETER_SERVER_M_READ_WRITE =3D 0x3,
> +
> +    /* change */
> +    VIRTIO_PARAMETER_SERVER_M_STATIC =3D 0x4,
> +    VIRTIO_PARAMETER_SERVER_M_MUTABLE =3D 0x8,
> +    VIRTIO_PARAMETER_SERVER_M_CONTINUOUS =3D 0xc,
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

Can you rephrase the definition of MUTABLE? I don't understand what it
means, especially since there is already a WRITE permission that
indicates read-only parameters. Why is MUTABLE needed?

Does CONTINUOUS mean that the device expects to update the value? You
mentioned a "steady frequency", is that the key characteristic being
described here? If so, then PERIODIC might be a clearer name than
CONTINUOUS (which could have other meanings, like that the value will be
different every time it's read).

> +The properties with the same \field{prop_id} share the configuration.

It is not clear to mean what a "configuration" is.

> \field{min_sample_freq} and
> +\field{max_sample_freq} are the sampling rate range for the
> +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values.

Is this really needed since the device interface also supports pub/sub?
If the application/driver wants to monitor a parameter that's
periodically updated by the device it can just subscribe to be notified
rather than reading at the max sample frequency and discarding unchanged
values.

By the way, is there a "current sample frequency"? If not, then I guess
the application/driver needs to assume min/max, depending on its
requirement. This could be inefficient.

> \field{desc} is
> the optional string
> +description.

Please indicate the character encoding and NUL termination of this
string.

Is this the parameter's name ("temperature_sensor_4") or is it a
description ("Main board temperature sensor")?

> \field{params} are for the customized configuration parameters.

This looks like a vendor-specific extension mechanism. It's opaque so
there's no way for the driver to skip over parameters it doesn't
understand. That could be a problem for version compatibility if the
device/driver are updated and expect different param[] data formats.
Perhaps it would help to define the structure that allows the driver to
skip unknown parameters?

How does the driver know how large to make the struct
virtio_parameter_server_prop_config buffer? Maybe there should be a
max_params_len configuration space field.

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
> +\end{lstlisting}
> +
> +If the driver asks for ALL property configurations, then the \field{payl=
oad} of
> +virtio_parameter_server_response will be multiple property
> configurations, serialized 1-by-1.
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

Please include examples to illustrate this.

The character encoding of char16_t is implementation-defined in the C11
specification. So I guess it could be UCS-2, UTF-16, or any other 16-bit
encoding. Therefore char16_t is not enough to precisely describe
character encoding. Please state a character encoding (e.g. UTF-8,
UTF-16, etc).

--idaf31ji9Gpsr8Md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDAhfsACgkQnKSrs4Gr
c8h+/AgAlyRtq/rng0/hhgSEgEMF4kPhUBhqcluTm1uBEnoYNQTfLsSzxjIg36kP
kGZku3p4m2LabEbtIyKdOQirzkfRYjLszlH1Gr/8ghJUlI8HtkD4P5oWaOB2+EPI
Gaupt1Y/v/oAmWctA4RPep6OzW1XOQVYXb4qX4/tpdHUH9/F3Y4j1E0gCD1GkxD0
bs+ZUmULdbigQ56g70zRAHOAofbbtval9r6OzyiSigL2ROuQhCx+BeYGrgSse2ec
kxgBo64fMj4T4GTtC0oHEkqpmhD0SuOSJ5gBIwj4FWoT76BVv7b7EObvJ1XdzqJO
Fh4or2qvDexdy+61FOPxQw32F59TnA==
=Rwet
-----END PGP SIGNATURE-----

--idaf31ji9Gpsr8Md--

