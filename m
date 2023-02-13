Return-Path: <virtio-comment-return-4199-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 13 Feb 2023 06:12:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230213055946-mutt-send-email-mst@kernel.org>
References: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230213083019.826388-1-alvaro.karsz@solid-run.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 13, 2023 at 10:30:19AM +0200, Alvaro Karsz wrote:
> This patch makes several improvements to the notification coalescing
> feature, including:
> 
> - Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
>   into a single struct, virtio_net_ctrl_coal, as they are identical.
> - Emphasizing that the coalescing commands are best-effort.
> - Defining the behavior of coalescing with regards to delivering
>   notifications when a change occur.
> - Stating that the commands should apply to all the receive/transmit
>   virtqueues.
> - Stating that every receive/transmit virtqueue should count it's own
>   packets.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
> v2:
> 	- Add the last 2 points to the patch.
> 	- Rephrase the "commands are best-effort" note.
> 	- Replace "notification" with "used buffer notification" to be
> 	  more consistent.
> 
>  device-types/net/description.tex | 49 ++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 1741c79..74144fc 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1514,15 +1514,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>  send control commands for dynamically changing the coalescing parameters.
>  
> -\begin{lstlisting}
> -struct virtio_net_ctrl_coal_rx {
> -    le32 rx_max_packets;
> -    le32 rx_usecs;
> -};
> +\begin{note}
> +In general, these commands are best-effort: spurious notifications could still arrive.
> +\end{note}
>  
> -struct virtio_net_ctrl_coal_tx {
> -    le32 tx_max_packets;
> -    le32 tx_usecs;
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal {
> +    le32 max_packets;
> +    le32 usecs;
>  };
>  
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> @@ -1532,28 +1531,29 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Coalescing parameters:
>  \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> -\item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> +\item \field{usecs} for RX: Maximum number of usecs to delay a RX notification.
> +\item \field{usecs} for TX: Maximum number of usecs to delay a TX notification.
> +\item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
> +\item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>  \end{itemize}
>  
> -
>  The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and \field{max_packets} parameters for all the transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and \field{max_packets} parameters for all the receive virtqueues.
>  \end{enumerate}
>  
> +Every transmit and receive virtqueue needs to count its own packets and should not be affected by notifications sent by other virtqueues.

I find this slightly confusing in that it describes counting
which we did not previously mention. and it is not virtqueue iself
counting of course it is the device. We also need to
rewrite to avoid "should" outside conformance sections.
Also we do not have to count for each queue only
where coalescing is enabled.

I came up with

Packets are counted separately for each transmit or receive virtqueue
until max_packets is reached or until usecs elapsed since ....


and here I am stuck. What does usecs mean exactly? since when?
we also have vring notication suppression we should
explain it is kind of on top.

I also feel it would be helpful to say that e get 1 notification per
max_packets or per usecs which ever is the smallest.



> +
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
> -The device will operate as follows:
> +A device with a single receive virtqueue will operate as follows:
>  
>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.
> @@ -1564,17 +1564,24 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  If, for example:
>  \begin{itemize}
> -\item \field{tx_usecs} = 10.
> -\item \field{tx_max_packets} = 15.
> +\item \field{usecs} = 10.
> +\item \field{max_packets} = 15.
>  \end{itemize}
>  
> -The device will operate as follows:
> +A device with a single transmit virtqueue will operate as follows:
>  
>  \begin{itemize}
>  \item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When a device changes the coalescing parameters, it needs to check if the new coalescing parameters are met and send a used buffer notification if so.

I feel we still need to clarify "met" here please. Or add a conformance
statement defining this more formally.

> +
> +For example, \field{max_packets} = 15 for a device with a single transmit virtqueue.
> +If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} = 8, the device needs to immediately send a used buffer notification, if the notifications are not suppressed by the driver.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> -- 
> 2.34.1


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

