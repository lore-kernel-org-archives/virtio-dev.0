Return-Path: <virtio-comment-return-3978-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com> <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 7 Feb 2023 12:05:06 +0200
Message-ID: <CAJs=3_Cqbj1B2DQ3XL4_GFZq6pkUJiw8MQGTgb-SVYzffyq+Xg@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Parav, thanks for the comments.

> > +Note: In general, these commands are best-effort: A device could send a
> > notification even if it is not supposed to.
> >
> Please remove this note from this patch.
> Instead of Note, we need to describe this device requirements description.
> We better need to describe the motivation for it.
> We may want to say there may be jitter in notification, but device should not be sending when it is not supposed to.

I don't think that this note welcomes devices to send notifications
when not supposed to, but alert drivers that spurious notifications
may arrive.
It seems pointless to me writing that the device should not be sending
when it is not supposed to, it's obvious.

> > -struct virtio_net_ctrl_coal_tx {
> > -    le32 tx_max_packets;
> > -    le32 tx_usecs;
> > +\begin{lstlisting}
> > +struct virtio_net_ctrl_coal {
> > +    le32 max_packets;
> > +    le32 usecs;
> >  };
> >
> This is one good change to go as separate patch.
>
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > @@ -1532,25 +1529,25 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  Coalescing parameters:
> >  \begin{itemize}
> > -\item \field{rx_usecs}: Maximum number of usecs to delay a RX notification.
> > -\item \field{tx_usecs}: Maximum number of usecs to delay a TX notification.
> > -\item \field{rx_max_packets}: Maximum number of packets to receive before
> > a RX notification.
> > -\item \field{tx_max_packets}: Maximum number of packets to send before a
> > TX notification.
> > +\item \field{usecs} for RX: Maximum number of usecs to delay a RX
> > notification.
> > +\item \field{usecs} for TX: Maximum number of usecs to delay a TX
> > notification.
> > +\item \field{max_packets} for RX: Maximum number of packets to receive
> > before a RX notification.
> > +\item \field{max_packets} for TX: Maximum number of packets to send before
> > a TX notification.
> >  \end{itemize}
> >
> s/for Rx/For receive virtqueue
> s/for Tx/For transmit virtqueue
> >
> >  The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> >  \begin{enumerate}
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{tx_usecs} and
> > \field{tx_max_packets} parameters.
> > -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{rx_usecs} and
> > \field{rx_max_packets} parameters.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{usecs} and
> > \field{max_packets} parameters for TX.
> > +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{usecs} and
> > \field{max_packets} parameters for RX.
> >  \end{enumerate}
> >
> >  \subparagraph{RX Notifications}\label{sec:Device Types / Network Device /
> > Device Operation / Control Virtqueue / Notifications Coalescing / RX
> > Notifications}
> >
> >  If, for example:
> >  \begin{itemize}
> > -\item \field{rx_usecs} = 10.
> > -\item \field{rx_max_packets} = 15.
> > +\item \field{usecs} = 10.
> > +\item \field{max_packets} = 15.
> >  \end{itemize}
> >
> >  The device will operate as follows:
> > @@ -1564,8 +1561,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> > Types / Network Device / Devi
> >
> >  If, for example:
> >  \begin{itemize}
> > -\item \field{tx_usecs} = 10.
> > -\item \field{tx_max_packets} = 15.
> > +\item \field{usecs} = 10.
> > +\item \field{max_packets} = 15.
> >  \end{itemize}
> >
> >  The device will operate as follows:
> > @@ -1575,6 +1572,13 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi  \item If the
> > notifications are not suppressed by the driver, the device will send an used
> > buffer notification, otherwise, the device will not send an used buffer
> > notification as long as the notifications are suppressed.
> >  \end{itemize}
> >
> > +\subparagraph{Notifications When Coalescing Parameters
> > +Change}\label{sec:Device Types / Network Device / Device Operation /
> > +Control Virtqueue / Notifications Coalescing / Notifications When
> > +Coalescing Parameters Change}
> > +
> > +When a device changes the coalescing parameters, the device needs to check
> > if the new parameters are met and issue a notification if so.
> > +
> > +For example, \field{max_packets} = 15 for TX.
> > +If the device sends 10 packets, then it receives a
> > VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command with \field{max_packets} =
> > 8, the device needs to immediately send a TX notification, if the notifications
> > are not suppressed by the driver.
> > +
> Its better written as,
> When device applies new coalescing parameters, if the new parameters already meet the current packet counters, device SHOULD generate immediate notification.

The command may change the usecs field, so "packet counters" is
not general enough.




> For example, current \field{max_packets} is 15 for transmit virtqueue, and device already sent 10 packets.
> When device receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, the device SHOULD immediately send a TX notification.
>
> Above clarification also should be in same patch series as second patch.
>
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> >
> >  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
> > MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.

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

