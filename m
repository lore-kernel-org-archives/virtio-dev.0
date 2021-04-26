Return-Path: virtio-comment-return-1833-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 26 Apr 2021 11:05:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YIaQUdRjndmrBK2l@stefanha-x1.localdomain>
References: <20210401152013.17980-1-harald.mommer@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20210401152013.17980-1-harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [PATCH 1/1] [RFC] virtio-can: Add the device
 specification.
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LbpBrJAxJACBswYl"
Content-Disposition: inline
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--LbpBrJAxJACBswYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 05:20:13PM +0200, Harald Mommer wrote:
> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.

Hi,
I'm not familiar with CAN but have tried to give general feedback since
no one else has replied yet.

The commit description isn't completely clear about what this new VIRTIO
device is. I guess it's a virtual CAN controller rather than a CAN
device. The "give access to a CAN controller" wording suggests that it's
for passthrough, but the CAN controller could probably be purely
software too. I'm sure this will become clearer from the diff below, but
wanted to mention it since others may also find it ambiguous.

> ---
>  content.tex      |   1 +
>  introduction.tex |   3 +
>  virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 virtio-can.tex
>=20
> diff --git a/content.tex b/content.tex
> index e536fd4..c1604db 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
>  \input{virtio-mem.tex}
>  \input{virtio-i2c.tex}
>  \input{virtio-scmi.tex}
> +\input{virtio-can.tex}
> =20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
> diff --git a/introduction.tex b/introduction.tex
> index 7204b24..84ea5c0 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative Refe=
rences}
>  =09\phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
>  =09Arm System Control and Management Interface, DEN0056,
>  =09\newline\url{https://developer.arm.com/docs/den0056/c}, version C and=
 any future revisions\\
> +=09\phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
> +=09Specification of CAN Driver -- AUTOSAR CP R20-11,
> +=09\newline\url{https://www.autosar.org/fileadmin/user_upload/standards/=
classic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\

"The commercial exploitation of the material contained in this work
requires a license to such intellectual property rights."?

CAN is an ISO standard. What is the relationship to AUTOSAR and why not
reference the ISO standard? The CAN Wikipedia page
(https://en.wikipedia.org/wiki/CAN_bus) only mentions ISO, not AUTOSAR.

Also, does the AUTOSAR reference mean that this is a specific flavor of
CAN that may not be compatible with other CAN variants?

> =20
>  \end{longtable}
> =20
> diff --git a/virtio-can.tex b/virtio-can.tex
> new file mode 100644
> index 0000000..c343759
> --- /dev/null
> +++ b/virtio-can.tex
> @@ -0,0 +1,245 @@
> +\section{CAN Device}\label{sec:Device Types / CAN Device}
> +
> +virtio-can is a virtio based CAN (Controller Area Network) device. It is

s/device/controller/ ?

> +used to give a virtual machine access to a CAN bus. The CAN bus may
> +either be a physical CAN bus or a virtual CAN bus between virtual
> +machines or a combination of both.
> +
> +This section relies on definitions made by the AUTOSAR
> +\hyperref[intro:CAN_Driver]{CAN Driver} specification.
> +
> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
> +
> +36
> +
> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues=
}
> +
> +\begin{description}
> +\item[0] Txq
> +\item[1] Rxq
> +\item[2] Controlq
> +\item[3] Indicationq
> +\end{description}
> +
> +The \field{Txq} is used to send CAN packets to the CAN bus.
> +
> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> +
> +The \field{Controlq} is used to control the state of the CAN controller.
> +
> +The \field{Indicationq} is used to receive unsolicited indications of
> +CAN controller state changes.
> +
> +\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feature =
Bits}
> +
> +The virtio-can device always supports classic CAN frames with a maximum
> +payload size of 8 bytes.
> +
> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> +specification.

Please state this in a devicenormative section:

  \devicenormative{\subsection}{...}
  The device MUST support CAN~2.0B Extended CAN IDs.

The general spec text is informative and then specific statements about
what MUST, MUST NOT, SHOULD, etc are made in drivernormative and
devicenormative sections. You can find examples of this in the specs for
other devices.

> +
> +\begin{description}
> +
> +\item[VIRTIO_CAN_F_CAN_FD (0)]
> +
> +In addition to classic CAN frames the device supports CAN FD frames with
> +a maximum payload size of 64 bytes.

Is there a link for CAN FD? I found "CAN with Flexible Data-Rate" but
it's just a Wayback Machine link and not the official location:
https://web.archive.org/web/20151211125301/http://www.bosch-semiconductors.=
de/media/ubk_semiconductors/pdf_1/canliteratur/can_fd_spec.pdf

> +
> +\end{description}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / CAN De=
vice / Device configuration layout}
> +
> +All fields of this configuration are always available and read-only for
> +the driver.
> +
> +\begin{lstlisting}
> +struct virtio_can_config {
> +        le16 lo_prio_count;=20
> +        le16 hi_prio_count;
> +};
> +\end{lstlisting}
> +
> +To operate the Virtio CAN device it may be necessary to know some basic
> +properties of the underlying physical CAN controller hardware and its
> +configuration.
> +
> +Physical CAN controllers may support transmission by putting messages

"may", "should", "can", "must", etc are not used in the informative
sections of the spec. Those kinds of statements go in the
drivernormative and devicenormative sections.

> +into FIFOs first and / or by using transmit buffers directly. The user
> +of the Virtio CAN driver may need to know

This can be rewritten without the concept of a "physical CAN
controller". Simply describe lo_prio_count/hi_prio_count as properties
of the virtio-can device itself and then the physical CAN controller
concept isn't needed. This is makes the spec more general since emulated
CAN controllers might have their own constraints even though there is no
physical CAN controller.

> +
> +\begin{itemize}
> +\item Number of TX FIFO places for non time critical CAN messages
> +\item Number of TX buffers for high priority CAN messages

Inconsistencies:
- FIFO places =3D=3D buffers?
- non time critical =3D=3D low priority?

Please use terminology consistently. Don't introduce multiple terms for
the same thing.

> +\end{itemize}
> +
> +to schedule an optimal transmission of CAN messages. Non time critical
> +messages may be sent via a FIFO where they may suffer "Inner Priority
> +Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). High
> +priority messages are preferably sent directly to a transmit buffer
> +where they immediately participate in CAN bus arbitration.

Please mention lo_prio_count and hi_prio_count so their meaning is
unambiguous and they can easily be searched by name in the document. The
\begin{itemize} above should explicitly mention lo_prio_count and
hi_prio_count.

> +
> +\subsection{Device Initialization}\label{sec:Device Types / CAN Device /=
 Device Initialization}
> +
> +\begin{enumerate}
> +
> +\item Read the feature bits and negotiate with the device.
> +
> +\item Fill the virtqueue \field{Rxq} with empty buffers to be ready for
> +the reception of CAN messages.

How large do the buffers need to be? A drivernormative "MUST" statement
is probably needed for this.

> +
> +\item Fill the virtqueue \field{Indicationq} with empty buffers so that
> +the CAN device is able to provide status change indications to the
> +virtio CAN driver.

Do these buffers have a specific structure/size? I see struct
virtio_can_busoff_ind below but maybe a more general type is needed. If
the indication message types depend on the virtio-can device then it
could expose a configuration field so the driver knows how large
Indicationq buffers need to be.

> +
> +\item Read the CAN controller properties using the \field{Controlq}.
> +
> +\item Start the CAN controller using the \field{Controlq}.
> +
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Devi=
ce Operation}
> +
> +A device operation has an outcome which is described by one of the
> +following values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_RESULT_OK     0u
> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
> +\end{lstlisting}
> +
> +The type of a CAN message identifier is identified by the most
> +significant 2 bits of the internally used 32 bit value. This matches the
> +definition for Can_IdType in
> +\hyperref[intro:CAN_Driver]{CAN Driver} chapter 8.2.3.
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_ID_TYPE_STANDARD    0x00000000U
> +#define VIRTIO_CAN_ID_TYPE_STANDARD_FD 0x40000000U
> +#define VIRTIO_CAN_ID_TYPE_EXTENDED    0x80000000U
> +#define VIRTIO_CAN_ID_TYPE_EXTENDED_FD 0xC0000000U
> +\end{lstlisting}
> +
> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / De=
vice Operation / Controller Mode}
> +
> +The general format of a request in the \field{Controlq} is
> +
> +\begin{lstlisting}
> +struct virtio_can_control_out {
> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
> +        le16 msg_type;=20
> +};
> +\end{lstlisting}
> +
> +To participate in bus communication the CAN controller must be started
> +by sending a VIRTIO_CAN_SET_CTRL_MODE_START control message,
> +to stop participating in bus communication it must be stopped by sending
> +a VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> +confirmed by the result of the operation.
> +
> +\begin{lstlisting}
> +struct virtio_can_set_ctrl_mode_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +If the transition succeeded the result shall be VIRTIO_CAN_RESULT_OK
> +otherwise it shall be VIRTIO_CAN_RESULT_NOT_OK. The request shall be put
> +into the used queue when the CAN controller finalized the transition to
> +the requested controller mode.

"shall" is not for drivernormative/devicenormative sections. Simply
using "is" instead of "shall be" works here.

"the used queue" is specific to Split Virtqueues. Packed Virtqueues are
organized differently. I suggest rewording this sentence:

  The device marks the request used when the CAN controller has
  finalized the transition to the requested controller mode.

("2.7.9 Multi-buffer requests" uses the "mark used" language. Another
option is "the device uses the request when ...".)

> +
> +A transition to STOPPED state cancels all CAN messages pending for
> +transmission. A state transition to STOPPED state shall trigger to put
> +all CAN messages pending for transmission into the used queue with
> +result VIRTIO_CAN_RESULT_NOT_OK.

The exact behavior is not clear to me. There are several cases:

1. A tx message that was being transmitted when the
   VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.
2. A tx message that was on the Txq but not yet transmitted when the
   VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.
3. A tx message that was added to the Txq after the
   VIRTIO_CAN_SET_CTRL_MODE_STOP control message was submitted.

I guess they behave as follows:

1. The message might finish transmitting successfully or the message
   might complete with VIRTIO_CAN_RESULT_NOT_OK.
2. These messages complete with VIRTIO_CAN_RESULT_NOT_OK.
3. These messages might complete with VIRTIO_CAN_RESULT_NOT_OK or they
   might transmit successfully.

Another thought: the text is clearer when it explicitly mentions the
entity (driver or device) and the virtqueue (Txq or Controlq) involved:

  When the device transitions to the STOPPED state all CAN messages on
  the Txq complete with VIRTIO_CAN_RESULT_NOT_OK.

That makes it clear that the device needs to do this, not the driver. It
also makes it clear that we're describing effects on the Txq, not the
Controlq where the VIRTIO_CAN_SET_CTRL_MODE_STOP was submitted.

> +
> +Initially the CAN controller is in STOPPED state.

s/in STOPPED state/in the STOPPED state/

> +
> +\subsubsection{CAN Message Transmission}\label{sec:Device Types / CAN De=
vice / Device Operation / CAN Message Transmission}
> +
> +Messages may be transmitted by placing outgoing CAN messages in the

s/may be/are/

(To avoid using shall/may/should/etc language outside
drivernormative/devicenormative sections.)

> +virtqueue \field{Txq}.

Grammar tweak:
s/virtqueue \field{Txq}/\field{Txq} virtqueue/

> +
> +\begin{lstlisting}
> +struct virtio_can_tx_out {
> +#define VIRTIO_CAN_TX 0x0001u
> +        le16 msg_type;
> +        le16 priority;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +
> +struct virtio_can_tx_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +Priority is 0 for low priority and 1 for high priority CAN messages.

Please use /field{priority} to make it clear which field is being
described.

> +
> +The actual length of the SDU can be calculated from the length of the de=
vice
> +read-only descriptor.

  The length of \field{sdu} is implicit in the length of the device
  read-only descriptors.

I used "descriptors" here because "2.6.4 Message Framing" says that
drivers can choose arbitrary descriptor lengths. The device cannot
assume struct virtio_can_tx_out will be in a single descriptor.

> +
> +To avoid internal priority inversion in the \field{Txq} the user of the
> +driver may do a book keeping of in flight transmission requests and
> +defer sending of TX messages until the chosen transmission resource
> +becomes available.
> +
> +If priority, can_id or SDU length are out of range or the CAN controller

\field is missing for priority and can_id.

> +is in an invalid state result shall be set to VIRTIO_CAN_RESULT_NOT_OK
> +and the message shall not be scheduled for transmission. Sending a CAN
> +message with a priority with 0 transmission places configured shall
> +be considered as priority being out of range.
> +
> +If the parameters are valid the message is scheduled for transmission
> +and result is set to VIRTIO_CAN_OK. The transmission request should be

\field{result}

> +put into the used queue after the physical CAN controller acknowledged
> +the transmission on the CAN bus (may have to be put under a feature flag
> +as there may be non AUTOSAR CAN driver backends which don't provide a
> +trigger to do this correctly).

There is a TODO item here.

--LbpBrJAxJACBswYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCGkE8ACgkQnKSrs4Gr
c8iSGgf/f0ccR+APyp46/9MpNkIddAQr83ZnAYwG6avqb8dxr3URuiyrYC3sabda
SDnB3tr6Twuqkw3qzbfUuYgXBcnC6Nh1Z8QnQMBFpPMAP+0HuaeG1dXsJ/i7vRld
5hZ5TUlU4Os+EkOgcCSt3fE50zXMYkxdZOP60uyLg31DBmS0wl2czq+yqg9fpRoJ
1NoqGevTIQAm0G6dllmqQz1GI7a6woh725y8c9mY+1yvZufH3eF/PPq0KudJaqIv
oxgPUeZ20TxxVCmCP7BoIFyKgYrVBtSTjrGhNnJiHLP5Q9/69LOWA2hxhaLmm8d8
QZfGaqvNzOcfJx7qgfTJDw0J0VfToA==
=Poy7
-----END PGP SIGNATURE-----

--LbpBrJAxJACBswYl--

