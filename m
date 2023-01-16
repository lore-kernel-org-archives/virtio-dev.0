Return-Path: <virtio-dev-return-10625-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E027986399
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Jan 2023 15:59:52 +0000 (UTC)
Date: Mon, 16 Jan 2023 10:59:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230116103009-mutt-send-email-mst@kernel.org>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio_net: support low and high rate of notification
 coalescing
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 05:21:23PM +0200, Alvaro Karsz wrote:
> This patch adds a new feature, VIRTIO_NET_F_NOTF_COAL_LOW_HIGH, while
> clarifying/fixing existing coalescing concepts.
> 
> The new feature adds 4 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
> 	- VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET - coalescing parameters
> 	  to use when the packet rate is equal or lower then the low
> 	  threshold for TX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET - coalescing parameters
>           to use when the packet rate is equal or lower then the low
>           threshold for RX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for TX.
>         - VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET - coalescing parameters
>           to use when the packet rate is equal or higher then the high
>           threshold for RX.
> 
> On top of the new feature, this patch:
> 	- Unifies the virtio_net_ctrl_coal structs, since the one for tx
> 	  and the one for rx are identical.
> 	- Clarifies that the coalescing commands are best-effort.
> 	- Specifies coalescing in respect to delivering interrupts when config
>           changes.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
> v2:
> 	- Remove the "set of coalescing parameters" concept, use
> 	  "coalescing parameters" instead.
> 	- Unify struct virtio_net_ctrl_coal_rx and strcut virtio_net_ctrl_coal_tx
> 	  to struct virtio_net_ctrl_coal.
> 	- Separate the commands to tx and rx, so devices could have
> 	  different low/high rate coalescing parameters for tx and rx.
> 	- Unify struct virtio_net_ctrl_coal_high and struct
> 	  virtio_net_ctrl_coal_low to struct virtio_net_ctrl_coal_threshold.
> 	- Clarify that the packet rate is in packet per second units.
> 	- Clarify that any notification coalescing command is best-effort.
> 	- Specify coalescing in respect to delivering interrupts when config
> 	  changes.
> ---
>  content.tex | 105 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 18 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 96f4723..82b2597 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3088,6 +3088,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports notifications coalescing low rate and high rate sets.
> +
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>  
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3142,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH] Requires VIRTIO_NET_F_NOTF_COAL.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
> @@ -4493,43 +4496,62 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>  send control commands for dynamically changing the coalescing parameters.
>  
> +Note: In general, these commands are best-effort: A device could send a notification even if it is not supposed to.
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
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET 2 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET 3 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET 4 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET 5 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated

add conformance statements for this requirement of
VIRTIO_NET_F_NOTF_COAL_LOW_HIGH too?

>  \end{lstlisting}
>  
> -Coalescing parameters:
> +TX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a TX notification.
> +\item \field{max_packets}: Maximum number of packets to send before a TX notification.
> +\end{itemize}
> +
> +RX Coalescing parameters:
> +\begin{itemize}
> +\item \field{usecs}: Maximum number of usecs to delay a RX notification.
> +\item \field{max_packets}: Maximum number of packets to receive before a RX notification.
> +\end{itemize}

just unify these - TX/RX notification?


> +
> +General Coalescing parameters:
>  \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> -\item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> +\item \field{pkt_rate}: Threshold for low/high packet rate coalescing parameters, in units of packets per second.

This isn't really clear. Besides it seems that with 100GB/s we can thinkably begin to
overflow a 32 bit value pretty soon.

Also, how is this measured?
Do you expect device to average the rate over a whole second to decide?
Ethernet speeds start at 1MBit/sec right? I think these days if
we ask for # of packets in the last N usecs we won't go far
off the field. How much is N so as not to incur too much latency?
100?

Or are we measuring X latest packets and testing how long it takes
to get them?




>  \end{itemize}
>  
>  
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 6 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for RX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or lower, for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or lower, for RX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or higher, for TX.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET: set the \field{usecs} and \field{max_packets} coalescing parameters for packet rate of \field{pkt_rate} or higher, for RX.


how is 

>  \end{enumerate}
>

What is missing here is the theory of operation.

when are parameters set by VIRTIO_NET_CTRL_NOTF_COAL_RX_SET/VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
used?

Am I guessing right that with VIRTIO_NET_F_NOTF_COAL_LOW_HIGH there
are 3 sets of parameters high medium and low, for rx and tx?



  
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
>  
>  If, for example:
>  \begin{itemize}
> -\item \field{rx_usecs} = 10.
> -\item \field{rx_max_packets} = 15.
> +\item \field{usecs} = 10.
> +\item \field{max_packets} = 15.
>  \end{itemize}
>  
>  The device will operate as follows:
> @@ -4543,8 +4565,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  If, for example:
>  \begin{itemize}
> -\item \field{tx_usecs} = 10.
> -\item \field{tx_max_packets} = 15.
> +\item \field{usecs} = 10.
> +\item \field{max_packets} = 15.
>  \end{itemize}
>  
>  The device will operate as follows:
> @@ -4554,18 +4576,65 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When a device changes the coalescing parameters, the device needs to check if the new parameters are met and issue a notification if so.
> +
> +For example, \field{max_packets} = 15 for TX.
> +

drop empty line here pls.

> +If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} = 8, the device needs to immediately send a TX notification, if the notifications are not suppressed by the driver.
> +
> +\subparagraph{Low/High Rate Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Low/High Rate Notifications}
> +
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver can send the following low/high rate coalescing commands to the device:
> +
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET.
> +\end{itemize}
> +

pls explain here how these commands all use
virtio_net_ctrl_coal_threshold.
and maybe rearrange so the explanation is closer to the definition.


> +For VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing parameters to use when the packet rate is \field{pkt_rate} or lower.
> +
> +For VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET, struct virtio_net_ctrl_coal_threshold specifies the coalescing parameters to use when the packet rate is \field{pkt_rate} or higher.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>  
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, the driver MUST NOT issue low/high rate coalescing commands.
> +
> +The driver SHOULD issue a low/high rate coalescing command with \field{pkt_rate} 0 in order to remove the low/high rate coalescing parameters.

and presumably this 0 is an exception to the "packet rate for high
threshold must not be lower than low threshold"?


> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously sent with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command.
> +

actually these rules are annoying.
if i want to lower packet rate for both high and low,
and i happen to start with high, command may fail.
possible to fix but really just introducing more code for
now good reason.

what is the problem? if the rules make more than one set apply
let's allow device whatever set it wants?

>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>  
>  A device SHOULD NOT send used buffer notifications to the driver, if the notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if the coalescing counters expired.
>  
> +A device MUST remove the low/high rate coalescing parameters, if a low/high rate coalescing command is received with \field{pkt_rate} 0.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command with \field{pkt_rate} equal or higher than a \field{pkt_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_TX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_TX_SET command.
> +
> +A device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_RX_SET command with \field{pkt_rate} equal or lower than a \field{pkt_rate} previously received with a VIRTIO_NET_CTRL_NOTF_COAL_LOW_RX_SET command.
> +
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>  
> +Upon reset, a device MUST not have a low/high rate coalescing parameters.
> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
>  
> -- 
> 2.32.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

