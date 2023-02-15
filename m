Return-Path: <virtio-comment-return-4257-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 15 Feb 2023 13:43:32 +0000
In-reply-to: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
Message-ID: <m25yc3xcch.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Wednesday, 2023-02-15 at 11:54:09 +02, Alvaro Karsz wrote:
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

This is quite vague. How about:

The behaviour of the device in response to these commands is
best-effort: the device may generate notifications more frequently than
specified, for example after less than \field{max_packets} packets have
been processed or less than \field{usecs} usecs time has elapsed.

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
>  
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
>  \begin{itemize}
>  \item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When a device changes the coalescing parameters, it needs to check if the new notification conditions are met and send a used buffer notification if so.
> +
> +For example, \field{max_packets} = 15 for a device with a single transmit virtqueue.
> +If the device sends 10 packets, then it receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} = 8, the device needs to immediately send a used buffer notification, if the notifications are not suppressed by the driver.
> +
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
-- 
Freedom is just a song by Wham!.

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

