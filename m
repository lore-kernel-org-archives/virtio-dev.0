Return-Path: <virtio-dev-return-10557-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10A239863E8
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 18:21:59 +0000 (UTC)
MIME-Version: 1.0
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 11 Jan 2023 20:21:20 +0200
Message-ID: <CAJs=3_DEsR3gqoQ2mq=r+LCo6n6ebZjheD2h0XCwGucB38omFA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio_net: support low and high rate of notification coalescing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

After another inspection, I found some typos in the patch, will be
fixed in the next version.

>
> This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
> clarifying/fixing existing coalescing concepts.
>
> The new feature adds 4 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
>         - VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET - coalescing parameters
>           to use when the packet rate is equal or lower then the low
>           threshold for TX.

s/then/than/

>         - VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET - coalescing parameters
>           to use when the packet rate is equal or lower then the low
>           threshold for RX.

s/then/than/

>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for TX.

s/then/than/

>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for RX.

s/then/than/

> On top of the new feature, this patch:
>         - Unifies the virtio_net_ctrl_coal structs, since the one for tx
>           and the one for rx are identical.
>         - Clarifies that the coalescing commands are best-effort.
>         - Specifies coalescing in respect to delivering interrupts when c=
onfig
>           changes.
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
> v2:
>         - Remove the "set of coalescing parameters" concept, use
>           "coalescing parameters" instead.
>         - Unify struct virtio_net_ctrl_coal_rx and strcut virtio_net_ctrl=
_coal_tx

s/strcut/struct

>           to struct virtio_net_ctrl_coal.
>         - Separate the commands to tx and rx, so devices could have
>           different low/high rate coalescing parameters for tx and rx.
>         - Unify struct virtio_net_ctrl_coal_high and struct
>           virtio_net_ctrl_coal_low to struct virtio_net_ctrl_coal_thresho=
ld.
>         - Clarify that the packet rate is in packet per second units.
>         - Clarify that any notification coalescing command is best-effort=
.
>         - Specify coalescing in respect to delivering interrupts when con=
fig
>           changes.
> ---
>  content.tex | 105 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 18 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 96f4723..82b2597 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3088,6 +3088,8 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports notifications=
 coalescing low rate and high rate sets.
> +

Replace with: Device supports low/high packet rate coalescing parameters.


>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesci=
ng.
>
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3142,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires VIRTIO_NET_F_NOTF_COAL.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NE=
T_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
> @@ -4493,43 +4496,62 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>  send control commands for dynamically changing the coalescing parameters=
.
>
> +Note: In general, these commands are best-effort: A device could send a =
notification even if it is not supposed to.
> +
>  \begin{lstlisting}
> -struct virtio_net_ctrl_coal_rx {
> -    le32 rx_max_packets;
> -    le32 rx_usecs;
> +struct virtio_net_ctrl_coal {
> +    le32 max_packets;
> +    le32 usecs;
>  };
>
> -struct virtio_net_ctrl_coal_tx {
> -    le32 tx_max_packets;
> -    le32 tx_usecs;
> +struct virtio_net_ctrl_coal_threshold {
> +    le32 pkt_rate;
> +    struct virtio_net_ctrl_coal params;
>  };
>
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if VIRTIO_NET_F_N=
OTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if VIRTIO_NET_F_N=
OTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if VIRTIO_NET_F_=
NOTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if VIRTIO_NET_F_=
NOTF_COAL_LOW_HIGH negotiated
>  \end{lstlisting}
>
> -Coalescing parameters:
> +TX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a TX notification.
> +\item \field{max_packets}: Maximum number of packets to send before a TX=
 notification.
> +\end{itemize}
> +
> +RX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a RX notification.
> +\item \field{max_packets}: Maximum number of packets to receive before a=
 RX notification.
> +\end{itemize}
> +
> +General Coalescing parameters:
>  \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notificati=
on.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notificati=
on.
> -\item \field{rx_max_packets}: Maximum number of packets to receive befor=
e a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a=
 TX notification.
> +\item \field{pkt_rate}: Threshold for low/high packet rate coalescing pa=
rameters, in units of packets per second.
>  \end{itemize}
>
>
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 6 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \fi=
eld{tx_max_packets} parameters.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \fi=
eld{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field=
{max_packets} coalescing parameters for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field=
{max_packets} coalescing parameters for RX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET: set the \field{usecs} and \f=
ield{max_packets} coalescing parameters for packet rate of \field{pkt_rate}=
 or lower, for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET: set the \field{usecs} and \f=
ield{max_packets} coalescing parameters for packet rate of \field{pkt_rate}=
 or lower, for RX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET: set the \field{usecs} and \=
field{max_packets} coalescing parameters for packet rate of \field{pkt_rate=
} or higher, for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET: set the \field{usecs} and \=
field{max_packets} coalescing parameters for packet rate of \field{pkt_rate=
} or higher, for RX.
>  \end{enumerate}
>
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Notifications Coalescing / RX Noti=
fications}
>
>  If, for example:
>  \begin{itemize}
> -\item \field{rx_usecs} =3D 10.
> -\item \field{rx_max_packets} =3D 15.
> +\item \field{usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>  \end{itemize}
>
>  The device will operate as follows:
> @@ -4543,8 +4565,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>
>  If, for example:
>  \begin{itemize}
> -\item \field{tx_usecs} =3D 10.
> -\item \field{tx_max_packets} =3D 15.
> +\item \field{usecs} =3D 10.
> +\item \field{max_packets} =3D 15.
>  \end{itemize}
>
>  The device will operate as follows:
> @@ -4554,18 +4576,65 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device =
will send an used buffer notification, otherwise, the device will not send =
an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec=
:Device Types / Network Device / Device Operation / Control Virtqueue / Not=
ifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When a device changes the coalescing parameters, the device needs to che=
ck if the new parameters are met and issue a notification if so.
> +
> +For example, \field{max_packets} =3D 15 for TX.
> +
> +If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_=
COAL_TX_SET command with \field{max_packets} =3D 8, the device needs to imm=
ediately send a TX notification, if the notifications are not suppressed by=
 the driver.
> +
> +\subparagraph{Low/High Rate Notifications}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Notifications Coalescin=
g / Low/High Rate Notifications}
> +
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver=
 can send the following low/high rate coalescing commands to the device:
> +
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET.
> +\end{itemize}
> +
> +For VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_L=
OW_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing p=
arameters to use when the packet rate is \field{pkt_rate} or lower.
> +
> +For VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_=
HIGH_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing=
 parameters to use when the packet rate is \field{pkt_rate} or higher.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /=
 Network Device / Device Operation / Control Virtqueue / Notifications Coal=
escing}
>
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, =
the driver MUST NOT issue low/high rate coalescing commands.
> +
> +The driver SHOULD issue a low/high rate coalescing command with \field{p=
kt_rate} 0 in order to remove the low/high rate coalescing parameters.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command=
 with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously s=
ent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command=
 with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously s=
ent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET comman=
d with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously s=
ent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET comman=
d with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously s=
ent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command.
> +
>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /=
 Network Device / Device Operation / Control Virtqueue / Notifications Coal=
escing}
>
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with V=
IRTIO_NET_ERR if it was not able to change the parameters.
>
>  A device SHOULD NOT send used buffer notifications to the driver, if the=
 notifications are suppressed as explained in \ref{sec:Basic Facilities of =
a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even =
if the coalescing counters expired.
>
> +A device MUST remove the low/high rate coalescing parameters, if a low/h=
igh rate coalescing command is received with \field{pkt_rate} 0.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_LOW_TX_SET command with \field{pkt_rate} equal or higher than a \field{pkt=
_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET com=
mand.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_LOW_RX_SET command with \field{pkt_rate} equal or higher than a \field{pkt=
_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET com=
mand.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_HIGH_TX_SET command with \field{pkt_rate} equal or lower than a \field{pkt=
_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET comm=
and.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL=
_HIGH_RX_SET command with \field{pkt_rate} equal or lower than a \field{pkt=
_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET comm=
and.
> +
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>
> +Upon reset, a device MUST not have a low/high rate coalescing parameters=
.
> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
>
> --
> 2.32.0
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

