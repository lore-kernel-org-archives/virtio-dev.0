Return-Path: <virtio-comment-return-4004-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 8 Feb 2023 09:45:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207090019-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 7 Feb 2023 09:06:19 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Feb 07, 2023 at 07:16:34PM +0800, Heng Qi wrote:
> > Currently, the coalescing profile is directly applied to all queues.
> > This patch supports configuring the parameters for a specified queue.
> >
> > When the traffic between queues is unbalanced, for example, one queue
> > is busy and another queue is idle, then it will be very useful to
> > control coalescing parameters at the queue granularity.
>
> ethtool does not support this though, does it? what's the plan?


Although it can be done, I think it is difficult to let users use ethtool to
modify the parameters of each queue.

At present ethtool supports adaptive-rx/adaptive-tx. This is that the driver
automatically adapted to the appropriate parameter. Generally, it is implemented
using netdim in the driver. At this time, this interface is needed.

>
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> What I dislike about this interface is that if
> VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, then
> in the common case of same parameters for all queues
> driver has to issue multiple commands.
> I can see either a special vq index (0xffff ?) or a special
> command used to set it for all queues.

Although the structure is very similar, in fact, adding a new command may be
clearer.

Thanks.

>
>
> > ---
> >  content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index e863709..049c0e4 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-queue
> > +	notifications coalescing.
> > +
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> >
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> > @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ and VIRTIO_NET_F_NOTF_COAL.
> >  \end{description}
> >
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -4488,16 +4492,21 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  If the VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can
> >  send control commands for dynamically changing the coalescing parameters.
> > +If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, the driver
> > +can send control commands to configure the coalescing parameters of a
> > +specified receiveq or transmitq.
> >
> >  \begin{lstlisting}
> >  struct virtio_net_ctrl_coal_rx {
> >      le32 rx_max_packets;
> >      le32 rx_usecs;
> > +    le16 rx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated)
> >  };
> >
> >  struct virtio_net_ctrl_coal_tx {
> >      le32 tx_max_packets;
> >      le32 tx_usecs;
> > +    le16 tx_qid;  (Only if VIRTIO_NET_F_PERQUEUE_NOTF_COAL negotiated)
> >  };
> >
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
>
> I think it's a good idea to do this on top of Alvaro's patch
> unifying these two structures.
>
> > @@ -4507,17 +4516,34 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  Coalescing parameters:
> >  \begin{itemize}
> > -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> > -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> > +\item \field{rx_qid}: Index of which receiveq to change the coalescing parameters.
> > +	If the value is between 0 and 0x7FFF, it represents the index of the specified
> > +	receiveq. Otherwise, if the value is 0xFFFF, it indicates to change the
> > +	coalescing parameters for all receiveqs.
>
> what if the index does not map to a receive queue?
>
> > +\item \field{tx_qid}: Index of which transmitq to change the coalescing parameters.
> > +	If the value is between 0 and 0x7FFF, it represents the index of the specified
> > +	transmitq. Otherwise, if the value is 0xFFFF, it indicates to change the
> > +	coalescing parameters for all transmitqs.
> > +\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification. If additionally
> > +	VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the specified recieveq
> > +	or all receieveqs.
> > +\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification. If additionally
> > +	VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the specified transmitq
> > +	or all transmitqs.
> >  \item \field{rx_max_packets}: Maximum number of packets to receive before a RX notification.
> > +	If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the
> > +	specified receiveq or all receiveqs.
> >  \item \field{tx_max_packets}: Maximum number of packets to send before a TX notification.
> > +	If additionally VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated, it works for the
> > +	specified transmitq or all transmitqs.
> >  \end{itemize}
> >
> > -
> >  The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and \field{tx_max_packets} parameters,
> > +	and set the \field{tx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and \field{rx_max_packets} parameters,
> > +	and set the \field{rx_qid} if VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated.
> >  \end{enumerate}
> >
> >  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / RX Notifications}
> > @@ -4531,7 +4557,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  The device will operate as follows:
> >
> >  \begin{itemize}
> > -\item The device will count received packets until it accumulates 15, or until 10 usecs elapsed since the first one was received.
> > +\item The device will count received packets until it accumulates 15, or until
> > +	10 usecs elapsed since the first one was received. If additionally
> > +	VIRTIO_NET_F_PERQUEUE_NOTF_COAL	is negotiated: when \field{rx_qid} is set
> > +	to 0, the accumulation was only from the receiveq1; when \field{rx_qid} is
> > +	set to 0xFFFF, the accumulation was from all receiveqs.
> >  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
> >  \end{itemize}
> >
> > @@ -4546,7 +4576,12 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  The device will operate as follows:
> >
> >  \begin{itemize}
> > -\item The device will count sent packets until it accumulates 15, or until 10 usecs elapsed since the first one was sent.
> > +\item The device will count sent packets on the transmitq1 until it accumulates 15,
> > +	or until 10 usecs elapsed since the first one was sent. If additionally
> > +	VIRTIO_NET_F_PERQUEUE_NOTF_COAL is negotiated: when \field{tx_qid} is set
> > +	to 0, the accumulation was only from the transmitq1; when \field{tx_qid} is
> > +	set to 0xFFFF, the accumulation was from all transmitqs.
> > +
> >  \item If the notifications are not suppressed by the driver, the device will send an used buffer notification, otherwise, the device will not send an used buffer notification as long as the notifications are suppressed.
> >  \end{itemize}
> >
> > --
> > 2.19.1.6.gb485710b
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
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

