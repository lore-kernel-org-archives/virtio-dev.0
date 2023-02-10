Return-Path: <virtio-comment-return-4123-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 10 Feb 2023 03:38:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230210031041-mutt-send-email-mst@kernel.org>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230210070130.21811-1-hengqi@linux.alibaba.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue coalescing
 moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 10, 2023 at 03:01:30PM +0800, Heng Qi wrote:
> Currently, the coalescing profile is directly applied to all queues.
> This patch supports setting or getting the parameters for a specified queue,
> and a typical application of this function is NetDIM.
> 
> When the traffic between queues is unbalanced, for example, one queue
> is busy and another queue is idle, then it will be very useful to
> control coalescing parameters at the queue granularity.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


I like this generally, thanks! Language needs to be tightened a bit.
> ---
> v1->v2:
>     1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
>     2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>     3. Unify tx and rx control structres into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
>     4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>     5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
>     6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
> 
>  content.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index e863709..2c497e1 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
> +    notifications coalescing.
> +
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>  
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ and VIRTIO_NET_F_NOTF_COAL.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4520,6 +4524,49 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
>  \end{enumerate}
>  
> +If additionally VIRTIO_NET_F_VQ_NOTF_COAL is negotiated, the driver can send
> +control commands to set or get the coalescing parameters of a specified
> +virtqueue (excluding the control virtqueue).
> +
> +\begin{lstlisting}
> +struct virtio_net_ctrl_coal_vq {
> +    le32 max_packets;
> +    le32 usecs;
> +    le16 vqn;

Add le16 reserved here, so keep things aligned naturally.
In fact if you want to support GET you need to re-order things
since write buffers come before read buffers:

 +    le16 vqn;
 +    le16 reserved;

 +    le32 max_packets;
 +    le32 usecs;

see below for more explanation.



> +};
> +
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ 7
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 0
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 1
> +\end{lstlisting}
> +
> +Virtqueue coalescing parameters:
> +\begin{itemize}
> +\item \field{max_packets}: The maximum number of packets sent/received by the
> +    specified virtqueue before a TX/RX notification.
> +\item \field{usecs}: The maximum number of TX/RX usecs that the specified
> +    virtqueue delays a TX/RX notification.
> +\item \field{vqn}: The virtqueue number of the specified virtqueue.
> +\end{itemize}
> +
> +The range of \filed{vqn} is between 0 and 0xFFFF inclusive,


No really because last vq is a cvq. Maybe just drop this?

> $ \lfloor vqn / 2 \rfloor $
> +is the index of the corresponding receiveq, and $\lfloor (vqn / 2) + 1 \rfloor $ is
> +the corresponding tranmitq.
> +
> +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as calling VIRTIO_NET_CTRL_NOTF_COAL_VQ

you don't "call" commands. driver sends them, device receives them.
But here you are talking about a command abstracty so I'd just drop 
a verb, or maybe "repeating".
And "same" is inexact in that it's not the same - takes more time - it
just has the same effect, or is equivalent to.


> +for virtqueues corresponding to all receiveqs.

receiveqs is confusing.

Also elsewhere we use the language receiveq1\ldots receiveqn
which seems clearer. Also you can not call VIRTIO_NET_CTRL_NOTF_COAL_VQ
for all vqs - it applies to one vq only. You mean each.
And virtqueues do not correspond to receiveqs - they
are receiveqs. If you like vqn corresponds to them.
Or better just "same as VIRTIO_NET_CTRL_NOTF_COAL_VQ repeated for
each of receiveq1\ldots receiveqn"

> +
> +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as calling VIRTIO_NET_CTRL_NOTF_COAL_VQ
> +for virtqueues corresponding to all transmitqs.
> +
> +Virtqueue coalescing will be disabled if all parameters are set to 0.

In fact, either usecs 0 or max_packets disables coalescing, no?

> +
> +The class VIRTIO_NET_CTRL_NOTF_COAL_VQ has 2 commands:
> +\begin{enumerate}
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets}, \field{usecs} and \filed{vqn} parameters.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: get the \field{max_packets}, \field{usecs} and \field{vqn} parameters.

How does VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET work then? For which vq?
I think you mean vqn is specified and you get back max_packets and
usecs. All this needs to be documented fully for each command.

I would also think it's a good idea to mention that VQ_GET does not have
to return exactly the same parameters - since it's best effort anyway,
it's ok for device to round down and store a smaller value for either
max_packets or usecs, e.g. to save space.

This kind of formalizes the best effort thing we discussed
previously.


Maybe make VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET a separate patch -
in the series,
at this point you did not make any effort to document it,
it needs more work.


> +\end{enumerate}
> +
>  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
>  
>  If, for example:
> @@ -4535,6 +4582,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +If, example of setting coalescing parameters for a receive virtqueue:

"If" without "then" is confusing. I'd just start with "Example".

> +\begin{itemize}
> +\item \field{max_packets} = 15.
> +\item \field{usecs} = 10.
> +\item \field{vqn} = 0;

why . above and ; here? I would just drop punctuation.

> +\end{itemize}
> +
> +The device will only operate on recieveq1 as VIRTIO_NET_CTRL_NOTF_COAL_RX_SET.

This really does not explain anything. Please just document exactly what
it does and does not do.


> +
>  \subparagraph{TX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / TX Notifications}
>  
>  If, for example:
> @@ -4550,13 +4606,24 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
>  \end{itemize}
>  
> +If, example of setting coalescing parameters for a transmit virtqueue:
> +\begin{itemize}
> +\item \field{max_packets} = 15.
> +\item \field{usecs} = 10.
> +\item \field{vqn} = 1;
> +\end{itemize}
> +
> +The device will only operate on transmitq1 as VIRTIO_NET_CTRL_NOTF_COAL_TX_SET.
> +

I feel it's the other way around. Document 



>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOFT_COAL_VQ commands.
>  

Don't we want to limit driver to legal values of vqn?


>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters or
> +was not able to find a virtqueue using the \field{vqn}.

First please create multiple statements not a single long one.
Second vqn only exists for per vq commands so create a statement
just for that.
Also more explicit please. What does this mean? I suspect that vq was not
enabled?
Also, we MUST have vqn < max_virtqueue_pairs.


>  
>  A device SHOULD NOT send used buffer notifications to the driver, if the notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if the coalescing counters expired.
>  
> -- 
> 2.19.1.6.gb485710b


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

