Return-Path: <virtio-comment-return-3596-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1671620897.6449997-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 21 Dec 2022 19:08:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio_net: support low and high rate of notification coalescing sets
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 21 Dec 2022 12:17:29 +0200, Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
> This patch adds a new feature VIRTIO_NET_F_NOTF_COAL_LOW_HIGH,
> and adds 2 new commands to VIRTIO_NET_CTRL_NOTF_COAL class:
> 	* VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET - create a low-rate set of
> 	  coalescing parameters. the device should switch to this set when
> 	  the packet rate (packets per second) reaches the pkt_rate_low threshold.
>
> 	* VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET - create a high-rate set of
>           coalescing parameters. the device should switch to this set when
>           the packet rate (packets per second) reaches the pkt_rate_high threshold.
>
> A device may have up to 3 sets, and should switch between them based on
> the packet rate.


I want to know which one is better than NetDim(Coalesce Adaptive) in driver.

I know Heng Qi's work in this.

Thanks


>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
>  content.tex | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 96f4723..969f945 100644
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
> @@ -4504,9 +4507,25 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      le32 tx_usecs;
>  };
>
> +//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> +struct virtio_net_ctrl_coal_low {
> +        le32 pkt_rate_low;
> +        struct virtio_net_ctrl_coal_tx tx;
> +        struct virtio_net_ctrl_coal_rx rx;
> +};
> +
> +//Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> +struct virtio_net_ctrl_coal_high {
> +        le32 pkt_rate_high;
> +        struct virtio_net_ctrl_coal_tx tx;
> +        struct virtio_net_ctrl_coal_rx rx;
> +};
> +
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET 2 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
> + #define VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET 3 //Only if VIRTIO_NET_F_NOTF_COAL_LOW_HIGH negotiated
>  \end{lstlisting}
>
>  Coalescing parameters:
> @@ -4515,13 +4534,17 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
>  \item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
>  \item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> +\item \field{pkt_rate_low}: Threshold for low packet rate set (packets per second).
> +\item \field{pkt_rate_high}: Threshold for high packet rate set (packets per second).
>  \end{itemize}
>
>
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
>  \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
>  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET: set the \field{rx_usecs}, \field{rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a rate of \field{pkt_rate_low} or less packets per second.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET: set the \field{rx_usecs}, \field{rx_max_packets}, \field{tx_usecs} and \field{tx_max_packets} set for a rate of \field{pkt_rate_high} or more packets per second.
>  \end{enumerate}
>
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> @@ -4554,18 +4577,54 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>
> +\subparagraph{Low/High Rate Notifications Sets}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Low/High Rate Notifications Sets}
> +
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature is negotiated, the driver may send VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET commands to the device.
> +
> +The virtio_net_ctrl_coal_low struct defines a set of coalescing parameters (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \field{tx_max_packets}) that should be used when the packets rate is equal or lower than \field{pkt_rate_low} packets per second.
> +
> +The virtio_net_ctrl_coal_high struct defines a set of coalescing parameters (\field{rx_usecs}, \field{tx_usecs}, \field{rx_max_packets} and \field{tx_max_packets}) that should be used when the packets rate is equal or higher than \field{pkt_rate_high} packets per second.
> +
> +A device may have up to 3 sets of coalescing parameters, and should switch between the sets based on the packet rate.
> +
> +A device may have only a low rate set, in this case, it should coalesce notifications only when the packet rate crosses down the \field{pkt_rate_low} threshold.
> +
> +A device may have only a high rate set, in this case, it should coalesce notifications only when the packet rate crosses up the \field{pkt_rate_high} threshold.
> +
> +A device may have only a high rate set and a low rate set, in this case, it should coalesce notifications only when the packet rate crosses up the \field{pkt_rate_high} threshold, or crosses down the \field{pkt_rate_low} threshold.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
>
> +If the VIRTIO_NET_F_NOTF_COAL_LOW_HIGH feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET/VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET commands.
> +
> +The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with \field{pkt_rate_low} 0 in order to remove the low rate set.
> +
> +The driver SHOULD issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command with \field{pkt_rate_high} 0 in order to remove the high rate set.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with \field{pkt_rate_low} equal or higher than \field{pkt_rate_high}, if VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET was issued.
> +
> +The driver MUST NOT issue a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command with \field{pkt_rate_high} equal or lower than \field{pkt_rate_low}, if VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET was issued.
> +
>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>
>  A device SHOULD NOT send used buffer notifications to the driver, if the notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if the coalescing counters expired.
>
> +The device MUST remove the low rate set if a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with \field{pkt_rate_low} 0 is received.
> +
> +The device MUST remove the high rate set if a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command with \field{pkt_rate_high} 0 is received.
> +
> +The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_LOW_SET command with \field{pkt_rate_low} equal or higher than \field{pkt_rate_high}, if a high rate set is being used.
> +
> +The device MUST respond with VIRTIO_NET_ERR to a VIRTIO_NET_CTRL_NOTF_COAL_HIGH_SET command with \field{pkt_rate_high} equal or lower than \field{pkt_rate_low}, if a low rate set is being used.
> +
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>
> +Upon reset, a device MUST not have a low rate and high rate sets.
> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
>
> --
> 2.32.0
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

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

