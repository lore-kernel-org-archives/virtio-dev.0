Return-Path: <virtio-dev-return-10723-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F9E6986423
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Feb 2023 21:08:57 +0000 (UTC)
Date: Mon, 6 Feb 2023 16:08:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230206160206-mutt-send-email-mst@kernel.org>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 06, 2023 at 07:13:43PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Alvaro Karsz
> > 
> > This patch makes several improvements to the notification coalescing feature,
> > including:
> > 
> > - Consolidating virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx
> >   into a single struct, virtio_net_ctrl_coal, as they are identical.
> > - Emphasizing that the coalescing commands are best-effort.
> > - Defining the behavior of coalescing with regards to delivering
> >   notifications when a change occur.
> >
> Patch needs to do one thing at a time.
> Please split above into three patches.
>  
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > ---
> >  device-types/net/description.tex | 40 ++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> > 
> > diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> > index 1741c79..2a98411 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -1514,15 +1514,12 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi  If the
> > VIRTIO_NET_F_NOTF_COAL feature is negotiated, the driver can  send control
> > commands for dynamically changing the coalescing parameters.
> > 
> > -\begin{lstlisting}
> > -struct virtio_net_ctrl_coal_rx {
> > -    le32 rx_max_packets;
> > -    le32 rx_usecs;
> > -};
> > +Note: In general, these commands are best-effort: A device could send a
> > notification even if it is not supposed to.
> >
> Please remove this note from this patch.
> Instead of Note, we need to describe this device requirements description.
> We better need to describe the motivation for it.
> We may want to say there may be jitter in notification, but device should not be sending when it is not supposed to.

It's explicitly allowed:

split-ring.tex:The driver MUST handle spurious notifications from the device.
split-ring.tex:The device MUST handle spurious notifications from the driver.



> I also have more description to add in this area with regards to GSO and LRO.
> I make humble suggestion that we draft is jointly in separate patch combining these clarifications.
>  
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

Which virtqueue? It says TX/RX pretty consistently in this text.
Changing to receive virtqueue/transmit virtqueue would be a big
change and frankly for a very modest gain in readability.
Rather maybe just say RX/TX where we describe virtqueue.

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

what are packet counters though? they aren't defined anywhere.

> For example, current \field{max_packets} is 15 for transmit virtqueue, and device already sent 10 packets.

I assume it is all per virtqueue? Makes sense but it does not actually
say anywhere.

> When device receives a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, the device SHOULD immediately send a TX notification.

always? why?

> Above clarification also should be in same patch series as second patch.
> 
> >  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> > Network Device / Device Operation / Control Virtqueue / Notifications
> > Coalescing}
> > 
> >  If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the driver
> > MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> > --
> > 2.34.1
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

