Return-Path: <virtio-comment-return-4381-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230219144507.22932-1-hengqi@linux.alibaba.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Mon, 20 Feb 2023 15:09:04 +0000
In-reply-to: <20230219144507.22932-1-hengqi@linux.alibaba.com>
Message-ID: <m24jrge57m.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v4] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Sunday, 2023-02-19 at 22:45:07 +08, Heng Qi wrote:
> Currently coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch supports setting or getting the parameters for a
> specified virtqueue, and a typical application of this function is netdim[1].
>
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
>
> [1] https://docs.kernel.org/networking/net_dim.html
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> This patch is on top of Alvaro's latest v7 patch: https://lists.oasis-open.org/archives/virtio-dev/202302/msg00431.html .
>
> v3->v4:
>     1. Include virtio_net_ctrl_coal in the virtio_net_ctrl_coal_vq structure. @Alvaro Karsz
>     2. Add consideration of vq reset. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>     3. Avoid too many examples by giving a comprehensive example. @Michael S. Tsirkin
>     4. Fix typos and streamline clarifications. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>
> v2->v3:
>     1. Add the netdim link. @Parav Pandit
>     2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
>     3. _VQ_GET is explained more. @Michael S. Tsirkin
>     4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
>     5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>     6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
>     7. Fix some typos. @Michael S. Tsirkin
>
> v1->v2:
>     1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
>     2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
>     3. Unify tx and rx control structres into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
>     4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>     5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
>     6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
>
>  device-types/net/description.tex | 64 ++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index e71e33b..fa8bd26 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -83,6 +83,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> +
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>  
>  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -139,6 +141,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -1508,6 +1511,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
>  send control commands for dynamically changing the coalescing parameters.
>  
> +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set the coalescing
> +   parameters of an enabled transmit/receive virtqueue.
> +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a device, and the device
> +   returns the coalescing parameters of an enabled transmit/receive
> virtqueue.

Use an enumeration.

> +
>  \begin{note}
>  The behavior of the device in response to these commands is best-effort:
>  the device may generate notifications more or less frequently than specified.
> @@ -1519,25 +1528,55 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      le32 max_usecs;
>  };
>  
> +struct virtio_net_ctrl_coal_vq {
> +    le16 vqn;
> +    le16 reserved;
> +    struct virtio_net_ctrl_coal coal;
> +};
> +
>  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
>   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
>  \end{lstlisting}
>  
>  Coalescing parameters:
>  \begin{itemize}
> +\item \field{vqn}: The virtqueue number of an enabled transmit or receive virtqueue.
>  \item \field{max_usecs} for RX: Maximum number of microseconds to delay a RX notification.
>  \item \field{max_usecs} for TX: Maximum number of microseconds to delay a TX notification.
>  \item \field{max_packets} for RX: Maximum number of packets to receive before a RX notification.
>  \item \field{max_packets} for TX: Maximum number of packets to send before a TX notification.
>  \end{itemize}
>  
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +\field{vqn} points to an enabled transmit/receive virtqueue, and its value satisfies $ 0 \leq vqn < max_virtqueue_pairs \ast 2 $.
> +
> +\field{reserved} is reserved and it is ignored by the device.
> +
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all transmit virtqueues.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and \field{max_packets} parameters for an enabled transmit/receive
> +                                        virtqueue whose number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the \field{max_usecs} and \field{max_packets} parameters for an enabled
> +                                        transmit/receive virtqueue whose number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: have the same effect as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each virtqueue of transmitq1\ldots transmitqN.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: have the same effect as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command repeated for each virtqueue of receiveq1\ldots receiveqN.
>  \end{enumerate}
>  
> +If coalescing parameters are being set, the device applies the last coalescing parameters received for a
> +virtqueue, regardless of the command used to set the parameters. For example with 2 pairs of virtqueues:
> +# Command sequece

"sequence"

> +Each of the following commands sets \field{max_usecs} and \field{max_packets} parameters for virtqueues.
> +\begin{itemize}
> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3 retain their previous parameter values.
> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 0 sets parameters for virtqueue0, and virtqueue2 retains the values from command1.
> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn}= 0, the device returns paramters of virtqueue0 set by command2.

Missing space before =.

> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} = 1 sets parameters for virtqueue1, and virtqueue3 retains its previous values.
> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets parameters for virtqueue1 and virtqueue3, and overrides the values set by command4.
> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn}= 1, the device returns paramters of virtqueue1 set by command5.

Missing space before =.

> +\end{itemize}
> +
>  \subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}
>  
>  The device sends a used buffer notification once the notification conditions are met and if the notifications are not suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
> @@ -1585,14 +1624,31 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL feature
> +has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.

Too many negatives here. Just "have been negotiated".

> +
> +A driver MUST ignore the values of coalescing paramters received from VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET,

"parameters"

Remove the comma?

> +if the device returns with VIRTIO_NET_ERR.
>  
>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  
>  A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> +Note: VIRTIO_NET_CTRL_NOTF_COAL_VQ_{SET, GET} are exception to it, which must return VIRTIO_NET_ERR if the device was unable to change the parameters.

"an exception"

>  
>  A device SHOULD NOT send used buffer notifications to the driver if the notifications are suppressed, even if the notification conditions are met.
>  
> +If a virtqueue is disabled, the device MUST clear its parameters configuration, and:
> +1. if the device has received a global parameter values sent by VIRTIO_NET_CTRL_NOTF_{RX, TX}_SET:
> +after the virtqueue is enabled, its parameters SHOULD be set to the global values.
> +2. if the device hasn't received the VIRTIO_NET_CTRL_NOTF_{RX, TX}_SET commands:
> +regardless of whether the device has received a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command, after the
> +virtqueue is enabled, its parameters SHOULD be set to 0.

Use an enumeration.

> +
> +When a device receives a virtqueue command to set or return coalescing parameters for the supplied \field{vqn},
> +if the virtqueue is not enabled, the device MUST respond to the command with VIRTIO_NET_ERR.
> +
> +A device MAY set the coalescing parameter to a value close to a power of 2 value.
> +
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>  
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
-- 
We're deep in discussion, the party's on mute.

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

