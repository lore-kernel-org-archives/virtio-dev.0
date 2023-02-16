Return-Path: <mst@redhat.com>
Date: Thu, 16 Feb 2023 11:08:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Message-ID: <20230216105600-mutt-send-email-mst@kernel.org>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <bc5776d7-dda2-0e5f-be75-8ee044d93cb7@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <bc5776d7-dda2-0e5f-be75-8ee044d93cb7@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16, 2023 at 10:49:25PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/2/16 下午10:43, Heng Qi 写道:
> > Currently coalescing parameters are grouped for all transmit and receive
> > virtqueues. This patch supports setting or getting the parameters for a
> > specified virtqueue, and a typical application of this function is netdim[1].
> > 
> > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > is busy and another virtqueue is idle, then it will be very useful to
> > control coalescing parameters at the virtqueue granularity.
> > 
> > [1] https://docs.kernel.org/networking/net_dim.html
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> > v2->v3:
> >      1. Add the netdim link. @Parav Pandit
> >      2. VIRTIO_NET_F_VQ_NOTF_COAL no longer depends on VIRTIO_NET_F_NOTF_COAL. @Michael S. Tsirkin, @Alvaro Karsz
> >      3. _VQ_GET is explained more. @Michael S. Tsirkin
> >      4. Add more examples to avoid misunderstandings. @Michael S. Tsirkin
> >      5. Clarify some statements. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
> >      6. Adjust the virtio_net_ctrl_coal_vq structure. @Michael S. Tsirkin
> >      7. Fix some typos. @Michael S. Tsirkin
> 
> Hi Michael.
> 
> I know you suggested in v2 that I split the virtqueue SET and GET commands
> in series,
> but I have a bit of a problem trying to split because there are some
> statements where SET and GET are glued together.
> Please see the following places.
> 
> If you think the split is better, I'll split it again and send it right
> away.
> 
> Thanks.


I don't mind that much. Lots of tiny patches are annoying too. Parav
seems to want this though.

> > 
> > v1->v2:
> >      1. Rename VIRTIO_NET_F_PERQUEUE_NOTF_COAL to VIRTIO_NET_F_VQ_NOTF_COAL. @Michael S. Tsirkin
> >      2. Use the \field{vqn} instead of the qid. @Michael S. Tsirkin
> >      3. Unify tx and rx control structres into one structure virtio_net_ctrl_coal_vq. @Michael S. Tsirkin
> >      4. Add a new control command VIRTIO_NET_CTRL_NOTF_COAL_VQ. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
> >      5. The special value 0xFFF is removed because VIRTIO_NET_CTRL_NOTF_COAL can be used. @Alvaro Karsz
> >      6. Clarify some special scenarios. @Michael S. Tsirkin, @Parav Pandit, @Alvaro Karsz
> > 
> >   content.tex | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 126 insertions(+), 4 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index e863709..7f99503 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >       channel.
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports the virtqueue
> > +    notifications coalescing.
> > +
> >   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> >   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >   \end{description}
> >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -4501,8 +4505,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   };
> >   #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > - #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET 0
> >    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> 
> here
> 
> > +
> >   \end{lstlisting}
> >   Coalescing parameters:
> > @@ -4514,12 +4521,67 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   \end{itemize}
> > -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> > +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
> 
> here
> 
> >   \begin{enumerate}
> >   \item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> >   \item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_packets} and \field{max_usecs} parameters for a enabled
> > +                                        transmit/receive virtqueue whose number is \field{vqn}.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device gets the \field{max_packets} and \field{max_usecs} parameters of
> > +                                        a enabled transmit/receive virtqueue whose number is \field{vqn}, and then
> > +                                        responds them to the driver.
> >   \end{enumerate}
> > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated:
> > +1. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command to set the coalescing
> > +   parameters of a enabled transmit/receive virtqueue.

an enabled

> > +2. a driver can send a VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command to a device, and the device
> > +   responds to the driver with the coalescing parameters of a enabled transmit/receive virtqueue.

an enabled

> > +
> > +\begin{lstlisting}
> > +struct virtio_net_ctrl_coal_vq {
> > +    le16 vqn;
> > +    le16 reserved;
> > +    le32 max_packets;
> > +    le32 max_usecs;
> > +};
> > +\end{lstlisting}
> > +
> > +Virtqueue coalescing parameters:
> > +\begin{itemize}
> > +\item \field{vqn}: The virtqueue number of the enabled transmit or receive virtqueue, excluding the control virtqueue.
> > +\item \field{max_packets}: The maximum number of packets sent/received by the specified virtqueue before a TX/RX notification.
> > +\item \field{max_usecs}: The maximum number of TX/RX usecs that the specified virtqueue delays a TX/RX notification.
> > +\end{itemize}
> > +
> > +\field{reserved} is reserved and it is ignored by the device.
> > +
> > +THe value of \field{vqn} satisfies $ 0 \leq vqn < max_virtqueue_pairs \ast 2 $.
> > +The conversion between \field{vqn} and transmitq/receiveq index:
> > +\begin{itemize}
> > +$ \lfloor vqn / 2 \rfloor $ is the index of the corresponding receiveq.
> > +$ \lfloor (vqn / 2) + 1 \rfloor $ is the index of the corresponding tranmitq.
> > +\end{itemize}
> > +
> > +The VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command is the same as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET

has the same effect

> > +command repeated for each virtqueue of receiveq1\ldots receiveqN.
> > +
> > +The VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command is the same as the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET


has the same effect

> > +command repeated for each virtqueue of transmitq1\ldots transmitqN.
> > +
> > +If coalescing parameters are being set, the device applies the last coalescing parameters received for a
> > +virtqueue, regardless of the command used to deliver the parameters. For example:
> > +# Command sequence 1:
> > +1. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets} = 15 $ and $ \field{max_usecs} = 10 $
> > +2. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} = 0 $, $ \field{max_packets} = 12 $ and $ \field{max_usecs} = 8 $
> > +After #2 command is applied by the device, the coalescing parameters of receiveq1 are $ \field{max_packets} = 12 $ and $ \field{max_usecs} = 8 $,
> > +and the coalescing parameters of receiveq2\ldots receiveqN are $ \field{max_packets} = 15 $ and $ \field{max_usecs} = 10 $.
> > +
> > +# Command sequence 2:
> > +1. VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with $ \field{vqn} = 0 $, $ \field{max_packets} = 12 $ and $ \field{max_usecs} = 8 $
> > +2. VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command with $ \field{max_packets} = 15 $ and $ \field{max_usecs} = 10 $
> > +After #2 command is applied by the device, the coalescing parameters of receiveq1\ldots receiveqN are $ \field{max_packets} = 15 $ and $ \field{max_usecs} = 10 $.
> > +
> >   \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> >   If, for example:
> > @@ -4532,9 +4594,33 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   \begin{itemize}
> >   \item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.
> > -\item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
> > +\item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise,
> > +      the device will not send an used buffer notification as long as the notifications are suppressed.
> > +\end{itemize}
> > +
> > +Example of setting coalescing parameters for a receive virtqueue:
> > +\begin{itemize}
> > +\item \field{max_packets} = 15
> > +\item \field{max_usecs} = 10
> > +\item \field{vqn} = 0
> > +\end{itemize}
> > +
> > +The device will operate as follows:
> > +\begin{itemize}
> > +\item The device applies the coalescing parameters to receiveq1 because its virtqueue number is 0.
> > +\item The device will count received packets on receiveq1 until it accumulates 15, or until 10 usecs elapsed since the first one was received.

use tense consistently:
elapsed -> elapse,
was -> is

one refers to packets I guess but technically could refer to usecs.

one -> packet

usecs -> microsecons , eschew abbreviation


> > +\item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise,
> > +      the device will not send an used buffer notification as long as the notifications are suppressed.
> > +\end{itemize}
> > +
> > +Example of getting coalescing parameters from a receive virtqueue:
> > +\begin{itemize}
> > +\item \field{vqn} = 0.
> >   \end{itemize}
> > +The device gets the values of the \field{max_packets} and \field{max_usecs} parameters from the receiveq1 whose virtqueue number is 0,
> > +and then responds them to the driver.

respond is not a transitive verb
responds -> reports?

> > +
> >   \subparagraph{TX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / TX Notifications}
> >   If, for example:
> > @@ -4550,14 +4636,50 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >   \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
> >   \end{itemize}
> > +Example of setting coalescing parameters for a transmit virtqueue:
> > +\begin{itemize}
> > +\item \field{max_packets} = 15
> > +\item \field{max_usecs} = 10
> > +\item \field{vqn} = 1
> > +\end{itemize}
> > +
> > +The device will operate as follows:
> > +
> > +\begin{itemize}
> > +\item The device applies the coalescing parameters to transmitq1 because its virtqueue number is 1.
> > +\item The device will count sent packets on transmitq1 until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
> > +\item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise,
> > +      the device will not send an used buffer notification as long as the notifications are suppressed.
> > +\end{itemize}
> > +
> > +Example of getting coalescing parameters from a transmit virtqueue:
> > +\begin{itemize}
> > +\item \field{vqn} = 1.
> > +\end{itemize}
> > +
> > +The device gets the values of the \field{max_packets} and \field{max_usecs} parameters from the transmitq1 whose virtqueue number is 1,
> > +and then responds them to the driver.

same

> > +
> >   \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +If neither the VIRTIO_NET_F_NOTF_COAL nor the VIRTIO_NET_F_VQ_NOTF_COAL feature
> > +has not been negotiated, the driver MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > +
> > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the driver MUST set \field{vqn}
> > +to a legal value, that is, \field{vqn} points to an enabled transmit/receive virtqueue.

either all perfect or all in simple tense
and maybe just put the formula here.


> > +
> > +A driver MAY NOT get exactly the same value as the coalescing
> > parameter it was set to,



This is really a device conformance statement not a driver one.
And MAY NOT means it is not allowed.
just drop this here. or write that driver MUST NOT rely on getting same
# back.

> for example it MAY get a value that is a
> > power of 2.

this confuses more than it clarifies.

> >   \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> >   A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > +When a device receives a virtqueue command to set/get coalescing parameters for a virtqueue with number \field{vqn},

virtqueue number, not virtqueue with number.

> > +if the virtqueue is not enabled, the device SHOULD respond to the command with VIRTIO_NET_ERR.
> 
> here
> 
> > +
> > +A device MAY NOT set the coalescing parameter to the exact same value as the one passed in by a driver. For example,
> > +the value of \field{max_packets} set by the driver is 15, but the device MAY store a value that is a power of 2, that is, 16.
> > +

same as driver. MAY NOT means not allowed. should be MAY.
going overvoard with examples. keep them out of conformance sections
these must be clear by themselves.

> >   A device SHOULD NOT send used buffer notifications to the driver, if the notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, even if the coalescing counters expired.
> >   Upon reset, a device MUST initialize all coalescing parameters to 0.

