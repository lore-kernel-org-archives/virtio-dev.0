Return-Path: <virtio-comment-return-4320-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 17 Feb 2023 04:44:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230217043305-mutt-send-email-mst@kernel.org>
References: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230216145611.1361327-1-alvaro.karsz@solid-run.com>
Subject: [virtio-comment] Re: [PATCH v5] virtio-net: Fix and update VIRTIO_NET_F_NOTF_COAL
 feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, david.edmondson@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 04:56:11PM +0200, Alvaro Karsz wrote:
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

Looks good, thanks! Yet something to improve, see below:

> ---
> v2:
> 	- Add the last 2 points to the patch.
> 	- Rephrase the "commands are best-effort" note.
> 	- Replace "notification" with "used buffer notification" to be
> 	  more consistent.
> v3:
> 	- Add an intro explaining the entire coalescing operation.
> v4:
> 	- Minor wording fixes.
> 	- Rephrase the general note.
> v5:
> 	- Replace virtio_net_ctrl_coal->usecs with
> 	  virtio_net_ctrl_coal->max_usecs
> 
>  device-types/net/description.tex | 69 +++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 1741c79..a4cff05 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1514,15 +1514,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>  send control commands for dynamically changing the coalescing parameters.
>  
> -\begin{lstlisting}
> -struct virtio_net_ctrl_coal_rx {
> -    le32 rx_max_packets;
> -    le32 rx_usecs;
> -};
> +\begin{note}
> +The behavior of the device in response to these commands is best-effort:
> +the device may generate notifications more or less frequently than specified.
> +\end{note}
>  
> -struct virtio_net_ctrl_coal_tx {
> -    le32 tx_max_packets;
> -    le32 tx_usecs;
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal {
> +    le32 max_packets;
> +    le32 max_usecs;
>  };
>  
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> @@ -1532,49 +1532,62 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Coalescing parameters:
>  \begin{itemize}
> -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> -\item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
> -\item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> +\item \field{max_usecs} for RX: Maximum number of usecs to delay a RX notification.
> +\item \field{max_usecs} for TX: Maximum number of usecs to delay a TX notification.

we really should not abbreviate the description (field name is ok). usecs to delay -> microseconds
to delay, right? same elsewhere.

> +\item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
> +\item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>  \end{itemize}
>  
> -
>  The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all the transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all the receive virtqueues.
>  \end{enumerate}
>  
> -\subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> +\subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
> +
> +The device sends a used buffer notification once the notification conditions are met, if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> +
> +When the device has non-zero \field{max_usecs} and non-zero \field{max_packets}, it starts counting usecs and packets upon receiving/sending a packet.
> +The device counts packets and usecs for each receive virtqueue and transmit virtqueue separately.
> +In this case, the notification conditions are met when \field{max_usecs} usecs elapses, or upon sending/receiving \field{max_packets} packets, whichever happens first.

and should we maybe add: "both the timer and the packet counter then
reset until the next packet"?

> +
> +When the device has \field{max_usecs} = 0 or \field{max_packets} = 0, the notification conditions are met after every packet received/sent.
> +
> +\subparagraph{RX Example}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Example}
>  
>  If, for example:
>  \begin{itemize}
> -\item \field{rx_usecs} = 10.
> -\item \field{rx_max_packets} = 15.
> +\item \field{max_usecs} = 10.
> +\item \field{max_packets} = 15.
>  \end{itemize}
> -

in fact the below is true for each queue separately even for an MQ device
right? So I feel it's helpful if we include this in the example too. S:

> -The device will operate as follows:
> -
> +then a device with a single receive virtqueue will operate as follows:

we could make it e.g. s/a device/each receive virtqueue of a device/


>  \begin{itemize}
>  \item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.

s/received packets/packets received on each virtqueue/



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
> +\item \field{max_usecs} = 10.
> +\item \field{max_packets} = 15.
>  \end{itemize}
> -
> -The device will operate as follows:
> -
> +then a device with a single transmit virtqueue will operate as follows:
>  \begin{itemize}
>  \item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +\subparagraph{Notifications When Coalescing Parameters Change}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Notifications When Coalescing Parameters Change}
> +
> +When the coalescing parameters of a device change, the device needs to check if the new notification conditions are met and send a used buffer notification if so.
> +
> +For example, \field{max_packets} = 15 for a device with a single transmit virtqueue: if the device sends 10 packets and afterwards receives a
> +VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} = 8, then the notification condition is immediately considered to be met;
> +the device needs to immediately send a used buffer notification, if the notifications are not suppressed by the driver.
> +
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> @@ -1583,7 +1596,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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

