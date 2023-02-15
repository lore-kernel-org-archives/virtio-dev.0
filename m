Return-Path: <virtio-dev-return-11003-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68DBE9865E1
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Feb 2023 11:42:47 +0000 (UTC)
Date: Wed, 15 Feb 2023 06:42:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230215063740-mutt-send-email-mst@kernel.org>
References: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15, 2023 at 11:54:09AM +0200, Alvaro Karsz wrote:
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
> - A new intro explaining the entire coalescing operation.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>


Looks good. Minor wording tweaks but mostly ready. Thanks!

> ---
> v2:
> 	- Add the last 2 points to the patch.
> 	- Rephrase the "commands are best-effort" note.
> 	- Replace "notification" with "used buffer notification" to be
> 	  more consistent.
> v3:
> 	- Add an intro explaining the entire coalescing operation.
> 
>  device-types/net/description.tex | 63 ++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 1741c79..2f4835e 100644
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
> @@ -1532,49 +1531,65 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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
> -\subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> +\subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
> +
> +The device sends a used buffer notification once the notification conditions are met, if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> +
> +When the device has non-zero \field{usecs} and non-zero \field{max_packets}, it starts counting usecs and packets upon receiving/sending a packet.
> +The device counts packets and usecs for each receive virtqueue and transmit virtqueue separately.
> +In this case, the notification conditions are met when \field{usecs} usecs elapses, or upon sending/receiving \field{max_packets} packets, whichever happens first.
> +
> +When the device has \field{usecs} = 0 or \field{max_packets} = 0, the notification conditions are met after every packet received/sent.
> +
> +\subparagraph{RX Example}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Example}
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

I think this should be
"then a device"

and do not make it a new paragraph - what we have is continuation of the
example.

>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> -\subparagraph{TX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / TX Notifications}
> +\subparagraph{TX Example}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / TX Example}
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


same

>  \begin{itemize}
>  \item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When a device changes the coalescing parameters, it needs to check if the new notification conditions are met and send a used buffer notification if so.

actually it is the driver changing them no?
maybe better in a neutral voice:

	when the coalescing parameters of a device change ....


> +For example, \field{max_packets} = 15 for a device with a single transmit virtqueue.

the sentence ends abruptly. maybe merge with next one:
	a single transmit virtqueue: if the device ....

> +If the device sends 10 packets, then

then -> and afterwards

> it receives a
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} = 8,
> the device needs to immediately send a used buffer notification, if
> the notifications are not suppressed by the driver.

maybe here "then the notification condition is immediately considered to
be met; the device needs ... 

>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> @@ -1583,7 +1598,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
>  
> -A device SHOULD NOT send used buffer notifications to the driver, if the notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if the coalescing counters expired.
> +A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
>  
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>  
> -- 
> 2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

