Return-Path: <virtio-dev-return-9358-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D644B98658B
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Mar 2022 09:16:04 +0000 (UTC)
MIME-Version: 1.0
References: <20220302085217.16546-1-xuanzhuo@linux.alibaba.com>
 <fbb699b3-7f20-5acc-dd94-9a1164411e3c@redhat.com> <1646814326.7522051-1-xuanzhuo@linux.alibaba.com>
 <20220309040741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220309040741-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Mar 2022 17:15:46 +0800
Message-ID: <CACGkMEskqM20XGNkP3nB2MAraiP6Yc0XUhpXZszY6HgCm=ud5w@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v11] virtio-net: support device stats
Content-Type: multipart/alternative; boundary="00000000000096e64f05d9c58b13"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000096e64f05d9c58b13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 9, 2022 at 5:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 09, 2022 at 04:25:26PM +0800, Xuan Zhuo wrote:
> > On Mon, 7 Mar 2022 15:58:03 +0800, Jason Wang <jasowang@redhat.com>
> wrote:
> > >
> > > =E5=9C=A8 2022/3/2 =E4=B8=8B=E5=8D=884:52, Xuan Zhuo =E5=86=99=E9=81=
=93:
> > > > This patch allows the driver to obtain some statistics from the
> device.
> > > >
> > > > In the back-end implementation, we can count a lot of such
> information,
> > > > which can be used for debugging and judging the running status of t=
he
> > > > back-end. We hope to directly display it to the user through ethtoo=
l.
> > > >
> > > > To get stats atomically, try to get stats for all queue pairs in on=
e
> > > > command.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > v11:
> > > > 1. Use michael's advice to introduce virtio_net_ctrl_queue_stats to
> get vq stats
> > > >     based on vq num and type
> > > > 2. split stats structure
> > > >
> > > > v10:
> > > > 1. use description/item for the item of the queue pair
> > > > 2. use one command to get the stats of all queue pairs
> > > >
> > > > v8:
> > > > 1. Modified based on comments by Cornelia Huck
> > > >
> > > > v7:
> > > > 1. add rx_reset, tx_reset
> > > > 2. add device normative and dirver normative
> > > > 3. add comments for *_packets, *_bytres
> > > >
> > > > v6:
> > > > 1. correct the names and descriptions of some stats items
> > > >
> > > > v5:
> > > > 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
> > > > 2. more item for virtio_net_ctrl_reply_stats_queue_pair
> > > >
> > > > v4:
> > > > 1. remove dev_stats_num, {rx|tx}_stats_num
> > > > 2. Use two commands to get the stats of queue pair and dev
> respectively
> > > >
> > > > v3 changes:
> > > > 1. add dev_version
> > > > 2. use queue_pair_index replace rx_num, tx_num
> > > > 3. Explain the processing when the device and driver support
> different numbers
> > > > of stats
> > > >
> > > >   conformance.tex |   2 +
> > > >   content.tex     | 391
> +++++++++++++++++++++++++++++++++++++++++++++++-
> > > >   2 files changed, 390 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/conformance.tex b/conformance.tex
> > > > index 42f8537..c67f877 100644
> > > > --- a/conformance.tex
> > > > +++ b/conformance.tex
> > > > @@ -142,6 +142,7 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
> > > >   \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Automatic receive steering in multiqueue
> mode}
> > > >   \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Offloads State Configuration / Setting
> Offloads State}
> > > >   \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > > +\item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Device Stats}
> > > >   \end{itemize}
> > > >
> > > >   \conformance{\subsection}{Block Driver
> Conformance}\label{sec:Conformance / Driver Conformance / Block Driver
> Conformance}
> > > > @@ -401,6 +402,7 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}
> > > >   \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Gratuitous Packet Sending}
> > > >   \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Automatic receive steering in multiqueue
> mode}
> > > >   \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processi=
ng}
> > > > +\item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Device Stats}
> > > >   \end{itemize}
> > > >
> > > >   \conformance{\subsection}{Block Device
> Conformance}\label{sec:Conformance / Device Conformance / Block Device
> Conformance}
> > > > diff --git a/content.tex b/content.tex
> > > > index c6f116c..5746f49 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device
> Types / Network Device / Feature bits
> > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through
> control
> > > >       channel.
> > > >
> > > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level
> statistics
> > > > +    to the driver through the control channel.
> > > > +
> > > >   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets.
> Unlike UFO
> > > >    (fragmenting the packet) the USO splits large UDP packet
> > > >    to several segments when each of these smaller packets has UDP
> header.
> > > > @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit
> requirements}\label{sec:Device Types / Network Device
> > > >   \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >   \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> VIRTIO_NET_F_HOST_TSO6.
> > > >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >   \end{description}
> > > > @@ -4015,6 +4019,7 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > >           u8 command;
> > > >           u8 command-specific-data[];
> > > >           u8 ack;
> > > > +        u8 command-specific-data-reply[];
> > > >   };
> > > >
> > > >   /* ack values */
> > > > @@ -4023,9 +4028,11 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > >   \end{lstlisting}
> > > >
> > > >   The \field{class}, \field{command} and command-specific-data are
> set by the
> > > > -driver, and the device sets the \field{ack} byte. There is little
> it can
> > > > -do except issue a diagnostic if \field{ack} is not
> > > > -VIRTIO_NET_OK.
> > > > +driver, and the device sets the \field{ack} byte and optionally
> > > > +\field{command-specific-data-reply}. There is little the driver ca=
n
> > > > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > > +
> > > > +The command VIRTIO_NET_CTRL_STATS_GET contains
> \field{command-specific-data-reply}.
> > > >
> > > >   \paragraph{Packet Receive Filtering}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Packet Receive
> Filtering}
> > > >   \label{sec:Device Types / Network Device / Device Operation /
> Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > > @@ -4471,6 +4478,384 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > >   according to the native endian of the guest rather than
> > > >   (necessarily when not using the legacy interface) little-endian.
> > > >
> > > > +\paragraph{Device Stats}\label{sec:Device Types / Network Device /
> Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver c=
an
> > > > +get the device stats from the device in
> \field{command-specific-data-reply}.
> > > > +
> > > > +To get the stats, the following definitions are used:
> > > > +\begin{lstlisting}
> > > > +#define VIRTIO_NET_CTRL_STATS         6
> > > > +#define VIRTIO_NET_CTRL_STATS_GET     0
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_CVQ      0
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM  2
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO   3
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM  6
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO   7
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8
> > > > +
> > > > +\end{lstlisting}
> > > > +
> > > > +The following layout structures are used:
> > > > +
> > > > +\field{command-specific-data}
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_ctrl_queue_stats {
> > > > + u16 nstats;
> > > > + struct {
> > > > +     u16 queue_num;
> > > > +     u16 type;
> > > > +     u16 length;
> > > > + } stats[];
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\field{command-specific-data-reply}
> > > > +\begin{lstlisting}
> > > > +struct virtio_net_stats_cvq {
> > > > +    le64 command_num;
> > > > +    le64 ok_num;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_basic {
> > > > +    le64 rx_packets;
> > > > +    le64 rx_bytes;
> > > > +
> > > > +    le64 rx_notification;
> > > > +    le64 rx_interrupt;
> > > > +
> > > > +    le64 rx_drop;
> > > > +    le64 rx_drop_overruns;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_csum {
> > > > +    le64 rx_csum_valid;
> > > > +    le64 rx_needs_csum;
> > > > +    le64 rx_csum_bad;
> > > > +    le64 rx_csum_none;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_gso {
> > > > +    le64 rx_gso_packets;
> > > > +    le64 rx_gso_bytes;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_reset {
> > > > +    le64 rx_reset;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_basic {
> > > > +    le64 tx_packets;
> > > > +    le64 tx_bytes;
> > > > +
> > > > +    le64 tx_notification;
> > > > +    le64 tx_interrupt;
> > > > +
> > > > +    le64 tx_drop;
> > > > +    le64 tx_drop_malformed;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_csum {
> > > > +    le64 tx_csum_none;
> > > > +    le64 tx_needs_csum;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_gso {
> > > > +    le64 tx_gso_packets;
> > > > +    le64 tx_gso_bytes;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_reset {
> > > > +    le64 tx_reset;
> > > > +};
> > > > +
> > > > +\end{lstlisting}
> > > > +
> > > > +Use the command VIRTIO_NET_CTRL_STATS_GET and
> \field{command-specific-data}
> > > > +containing struct virtio_net_ctrl_queue_stats to get the device
> stats.
> > > > +The result is returned by \field{command-specific-data-reply}.
> > >
> > >
> > > It's better to move this sentence after the description above. And we
> > > need explain the result a little bit more, e.g the stats ware returne=
d
> > > in the order of the type specified in the virtio_net_ctrl_queue_stats=
.
> > >
> > >
> > > > +
> > > > +\begin{description}
> > > > +    \item [nstats]
> > > > +        The number of \field{stats}.
> > > > +
> > > > +    \item [queue_num]
> > > > +        The queue num of the vq to be obtained. The vq can be
> receiveq,
> > > > +        transmitq or controlq.
> > >
> > >
> > > This could be simplified as "The number of the virtqueue to obtain th=
e
> > > statistics"
> > >
> > >
> > > > +
> > > > +    \item [type]
> > > > +        The type of the stats to be obtained.
> > > > +
> > > > +    \item [length]
> > > > +        Limits the size of the memory space occupied by the
> returned stats.
> > >
> > >
> > > What's the value of having this? Or how can driver know which value
> > > should it use?
> > >
> > >
> > > > +
> > > > +\end{description}
> > > > +
> > > > +Correspondence between the vq type, the stats type, the stats
> structure and the
> > > > +required features.
> > > > +\begin{tabular}{ |l|l|l|l| }
> > > > +    \hline
> > > > +    VQ Type                  & Stats Type                     &
> Stats Structure           & Features \\ \hline
> > > > +
> > > > +    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      &
> virtio_net_stats_cvq      & \\ \hline
> > >
> > >
> > > I think CVQ should require CVQ feature to be negotiated.
> > >
> > >
> > > > +
> > > > +    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC &
> virtio_net_stats_rx_basic & \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  &
> virtio_net_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_GSO   &
> virtio_net_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO \\
> \cline{2-4}
> > >
> > >
> > > It's better to aovid abbrev for features like TSO6.
> > >
> > >
> > > > +                             & VIRTIO_NET_STATS_TYPE_RX_RESET &
> virtio_net_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
> > > > +
> > > > +    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC &
> virtio_net_stats_tx_basic & \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  &
> virtio_net_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_GSO   &
> virtio_net_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO \\
> \cline{2-4}
> > > > +                             & VIRTIO_NET_STATS_TYPE_TX_RESET &
> virtio_net_stats_tx_reset & VIRTIO_F_RING_RESET \\
> > > > +    \hline
> > > > +\end{tabular}
> > > > +
> > > > +
> > > > +\subparagraph{Controlq Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Controlq
> Stats}
> > > > +
> > > > +The structure corresponding to the controlq stats is
> virtio_net_stats_cvq.
> > > > +
> > > > +\begin{description}
> > > > +    \item [command_num]
> > > > +        The number of commands, including the current command.
> > > > +
> > > > +    \item [ok_num]
> > > > +        The number of commands (including the current command)
> where the ack was VIRTIO_NET_OK.
> > > > +\end{description}
> > > > +
> > > > +
> > > > +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats /
> Receiveq Basic Stats}
> > > > +
> > > > +The structure corresponding to the receiveq basic stats is
> virtio_net_stats_rx_basic.
> > > > +
> > > > +Receiveq basic stats doesn't need any features, as long as the
> device supports
> > > > +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stat=
s.
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_packets]
> > > > +        The number of packets received by device (not the packets
> passed to the
> > > > +        guest), including the dropped packets by device.
> > > > +
> > > > +    \item [rx_bytes]
> > > > +        The number of bytes received by device (not the packets
> passed to the
> > > > +        guest), including the dropped packets by device.
> > > > +
> > > > +    \item [rx_notification]
> > > > +        The number of driver notifications.
> > > > +
> > > > +    \item [rx_interrupt]
> > > > +        The number of device interrupts.
> > > > +
> > > > +    \item [rx_drop]
> > > > +        The number of packets dropped by the receiveq. Contains al=
l
> kinds of
> > > > +        packet drop.
> > > > +
> > > > +    \item [rx_drop_overruns]
> > > > +        The number of packets dropped by the receiveq when no more
> descriptors
> > > > +        were available.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats /
> Transmitq Basic Stats}
> > > > +
> > > > +The structure corresponding to the transmitq basic stats is
> virtio_net_stats_tx_basic.
> > > > +
> > > > +Transmitq basic stats doesn't need any features, as long as the
> device supports
> > > > +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic
> stats.
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_packets]
> > > > +        The number of packets sent by device (not the packets
> received from the
> > >
> > >
> > > s/received/sent/?
> > >
> > >
> > > > +        guest), excluding the dropped packets by device.
> > > > +
> > > > +    \item [tx_bytes]
> > > > +        The number of bytes sent by device (not the packets
> received from the
> > > > +        guest), excluding the dropped packets by device.
> > > > +
> > > > +    \item [tx_notification]
> > > > +        The number of driver notifications.
> > > > +
> > > > +    \item [tx_interrupt]
> > > > +        The number of device interrupts.
> > > > +
> > > > +    \item [tx_drop]
> > > > +        The number of packets dropped by the transmitq. Contains
> all kinds of
> > > > +        packet drop.
> > > > +
> > > > +    \item [tx_drop_malformed]
> > > > +        The number of packets dropped when the descriptor is in an
> error state.
> > > > +        For example, the buffer is too short.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Networ=
k
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq
> CSUM Stats}
> > > > +
> > > > +The structure corresponding to the receiveq csum stats is
> virtio_net_stats_rx_csum.
> > > > +
> > > > +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful,
> the receiveq
> > > > +csum stats can be obtained.
> > > > +
> > > > +The following are the receiveq csum stats:
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_csum_valid]
> > > > +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> > > > +
> > > > +    \item [rx_needs_csum]
> > > > +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> > > > +
> > > > +    \item [rx_csum_bad]
> > > > +        The number of packets with abnormal csum.
> > > > +
> > > > +    \item [rx_csum_none]
> > > > +        The number of packets without hardware csum. The packet
> here refers to
> > > > +        the non-TCP/UDP packet that the backend cannot recognize.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats /
> Transmitq CSUM Stats}
> > > > +
> > > > +The structure corresponding to the transmitq csum stats is
> virtio_net_stats_tx_csum.
> > > > +
> > > > +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the
> transmitq csum
> > > > +stats can be obtained.
> > > > +
> > > > +The following are the transmitq csum stats:
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_csum_none]
> > > > +        The number of packets that didn't require hardware csum.
> > > > +
> > > > +    \item [tx_needs_csum]
> > > > +        The number of packets that required hardware csum.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq G=
SO
> Stats}
> > > > +
> > > > +The structure corresponding to the receiveq gso stats is
> virtio_net_stats_rx_gso.
> > > > +
> > > > +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> > > > +been negotiated, the receiveq gso stats can be obtained.
> > > > +
> > > > +Rx gso packets refer to packets passed by the device to the driver
> where
> > > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > > +
> > > > +The statistics of the following receiveq gso stats are based on th=
e
> rx gso
> > > > +packet. The device may receive multiple small packets, and finally
> combine them
> > > > +into one rx gso packet and pass it to the driver. It is also
> possible to receive
> > > > +a gso packet and pass it directly to the driver. We should count
> the information
> > > > +of the rx gso packet that is finally passed to the driver (such as
> number and
> > > > +bytes). Instead of the information of the small packet.
> > >
> > >
> > > If we don't want to explain why we use a single counter for those two
> > > cases, we probably can drop the above paragraph and simply say the
> > > rx_gso_packets is the number of gso packet produced by the device.
> > >
> > > Btw, we had VIRTIO_NET_GUEST_RSC{4|6}, is it better to use different
> > > counters?
> >
> >
> > RSC information doesn't seem to be very comprehensive in the spec.
>
> CC Yuri.
> Yuri do you feel we need to clarify things in the spec?
> If yes please create a github issue. Thanks!
>

I agree, it looks to me RSC may make sense for harware virtio devices so
it's probably not a feature just for WHQL.

Thanks


>
> > I'm not sure,
> > is the gso_type of the RSC package also VIRTIO_NET_HDR_GSO_TCPV4 or
> VIRTIO_NET_HDR_GSO_TCPV6?
> >
> > If yes, I plan to modify gso's stats to the following form to record
> gso's
> > stats. In this case include the RSC package.
> >
> > \begin{description}
> >     \item [rx_gso_packets]
> >         The number of the rx gso packets.
> >
> >     \item [rx_gso_bytes]
> >         The number of bytes(excluding the virtio net header) of the rx
> gso packets.
> >
> >     \item [rx_gso_packets_coalesced]
> >         The number of the rx gso packages generated by merging.
> >
> >     \item [rx_gso_bytes_coalesced]
> >         The number of bytes(excluding the virtio net header) of the rx
> gso packets generated by merging.
> >
> >     \item [rx_gso_segments]
> >         The number of coalesced segments.
> >
> >     \item [rx_gso_segments_bytes]
> >         The number of bytes of coalesced segments.
> >
> > \end{description}
> >
> > \begin{description}
> >     \item [tx_gso_packets]
> >         The number of the tx gso packets.
> >
> >     \item [tx_gso_bytes]
> >         The number of bytes(excluding the virtio net header) of the tx
> gso packets.
> >
> >     \item [tx_gso_packets_split]
> >         The number of the tx gso packets that been split.
> >
> >     \item [tx_gso_bytes_split]
> >         The number of bytes(excluding the virtio net header) of the tx
> gso packets that been split.
> >
> >     \item [tx_gso_segments]
> >         The number of segments split from the gso package.
> >
> >     \item [tx_gso_segments_bytes]
> >         The number of bytes(excluding the virtio net header) of segment=
s
> split from the gso package.
> > \end{description}
> >
> > Thanks.
> >
> > >
> > >
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_gso_packets]
> > > > +        The number of the rx gso packets.
> > > > +
> > > > +    \item [rx_gso_bytes]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e
> rx gso packets.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Networ=
k
> Device / Device Operation / Control Virtqueue / Device Stats / Transmitq
> GSO Stats}
> > > > +
> > > > +The structure corresponding to the receiveq gso stats is
> virtio_net_stats_tx_gso.
> > > > +
> > > > +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options hav=
e
> > > > +been negotiated, the transmitq gso stats can be obtained.
> > > > +
> > > > +Tx gso packets refer to packets passed by the driver to the device
> where
> > > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > > +
> > > > +The statistics of the following transmitq gso stats are based on
> the tx gso
> > > > +packet. The device may receive a tx gso packet from the driver, an=
d
> then may split
> > > > +it into multiple small packets or send the tx gso packet directly.
> But the device
> > > > +counts the information of the gso packet received from the driver
> (such as the
> > > > +number and bytes). Instead of the packet information after
> splitting.
> > >
> > >
> > > Similar to rx gso, is it better to use two counters?
> > >
> > >
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_gso_packets]
> > > > +        The number of the tx gso packets.
> > > > +
> > > > +    \item [tx_gso_bytes]
> > > > +        The number of bytes(excluding the virtio net header) of th=
e
> tx gso packets.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats /
> Receiveq Reset Stats}
> > > > +
> > > > +The structure corresponding to the receiveq reset stats is
> virtio_net_stats_rx_reset.
> > > > +
> > > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the
> receiveq reset stats
> > > > +can be obtained.
> > > > +
> > > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> Virtqueue Reset}
> > > > +for more about \field{rx_reset}.
> > > > +
> > > > +\begin{description}
> > > > +    \item [rx_reset]
> > > > +        The number of queue resets.
> > > > +\end{description}
> > > > +
> > > > +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats /
> Transmitq Reset Stats}
> > > > +
> > > > +The structure corresponding to the transmitq reset stats is
> virtio_net_stats_tx_reset.
> > > > +
> > > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the
> transmitq reset stats
> > > > +can be obtained.
> > > > +
> > > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> Virtqueue Reset}
> > > > +for more about \field{tx_reset}.
> > > > +
> > > > +\begin{description}
> > > > +    \item [tx_reset]
> > > > +        The number of queue resets.
> > > > +\end{description}
> > > > +
> > > > +\devicenormative{\subparagraph}{Device Stats}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +If virtio_net_ctrl_queue_stats is incorrect (such as the
> following), the device
> > > > +MUST set \field{ack} to VIRTIO_NET_ERR.
> > > > +\begin{itemize}
> > > > +    \item \field{queue_num} exceeds the queue range.
> > > > +    \item \field{type} is not a known value.
> > >
> > >
> > > What happens if driver tries to query RX stats through a TX index?
> > >
> > >
> > > > +    \item The type of vq does not match \field{type}.
> > > > +    \item The feature corresponding to the specified \field{type}
> was not successfully
> > > > +        negotiated.
> > > > +    \item The size of \field{command-specific-data-reply} is less
> than the sum
> > > > +        of \field{length}.
> > >
> > >
> > > I'm not sure I get here, I guess this proposal allows the driver to
> > > query an array of stats. So I guess it means the size of required sta=
ts
> > > instead of the size of \field{command-specific-data-reply}.
> > >
> > >
> > > > +\end{itemize}
> > > > +
> > > > +The device MUST write the requested stats structures in
> > > > +\field{command-specific-data-reply} in the order specified by the
> structure
> > > > +virtio_net_ctrl_queue_stats.
> > >
> > >
> > > Do we need per stat error code here? Or device can simply fail a batc=
h
> > > of query if one of those fails?
> > >
> > >
> > > > +
> > > > +The size of each stats MUST be less than or equal to the
> corresponding
> > > > +\field{length}, but the space it occupies MUST be equal to the
> corresponding
> > > > +\field{length}.
> > >
> > >
> > > I wonder how the length trick can work here. Is this used for
> extension?
> > > If yes, how can driver know a suitable length? What happens if device
> > > support more stats?
> > >
> > >
> > > > +
> > > > +\drivernormative{\subparagraph}{Device Stats}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +When a driver tries to obtain a certain stats, it MUST confirm tha=
t
> the relevant
> > > > +feature negotiation is successful.
> > > > +
> > > > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond
> to the vq
> > > > +specified by \field{queue_num}.
> > > > +
> > > > +\field{length} in struct virtio_net_ctrl_queue_stats MUST be
> greater than or
> > > > +equal to the size of the structure corresponding to \field{type}.
> It MUST be a
> > > > +multiple of 8.
> > >
> > >
> > > Why do we need the padding here?
> > >
> > >
> > > > +
> > > > +The size of \field{command-specific-data-reply} allocated by the
> driver MUST be
> > > > +greater than or equal to the sum of \field{legnth} in struct
> > >
> > >
> > > typo.
> > >
> > >
> > > > +virtio_net_ctrl_queue_stats.
> > >
> > >
> > > Any value that we can allocate more than the sum of the length?
> > >
> > > Thanks
> > >
> > >
> > > > +
> > > > +When the driver reads the response, it MUST read
> > > > +\field{command-specific-data-reply} one by one based on the set
> \field{length}
> > > > +and \field{type}.
> > > >
> > > >   \subsubsection{Legacy Interface: Framing
> Requirements}\label{sec:Device
> > > >   Types / Network Device / Legacy Interface: Framing Requirements}
> > > > --
> > > > 2.31.0
> > > >
> > >
>
>

--00000000000096e64f05d9c58b13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 9, 2022 at 5:08 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Ma=
r 09, 2022 at 04:25:26PM +0800, Xuan Zhuo wrote:<br>
&gt; On Mon, 7 Mar 2022 15:58:03 +0800, Jason Wang &lt;<a href=3D"mailto:ja=
sowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; =E5=9C=A8 2022/3/2 =E4=B8=8B=E5=8D=884:52, Xuan Zhuo =E5=86=99=E9=
=81=93:<br>
&gt; &gt; &gt; This patch allows the driver to obtain some statistics from =
the device.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In the back-end implementation, we can count a lot of such i=
nformation,<br>
&gt; &gt; &gt; which can be used for debugging and judging the running stat=
us of the<br>
&gt; &gt; &gt; back-end. We hope to directly display it to the user through=
 ethtool.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; To get stats atomically, try to get stats for all queue pair=
s in one<br>
&gt; &gt; &gt; command.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linu=
x.alibaba.com" target=3D"_blank">xuanzhuo@linux.alibaba.com</a>&gt;<br>
&gt; &gt; &gt; Suggested-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@r=
edhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; v11:<br>
&gt; &gt; &gt; 1. Use michael&#39;s advice to introduce virtio_net_ctrl_que=
ue_stats to get vq stats<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0based on vq num and type<br>
&gt; &gt; &gt; 2. split stats structure<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v10:<br>
&gt; &gt; &gt; 1. use description/item for the item of the queue pair<br>
&gt; &gt; &gt; 2. use one command to get the stats of all queue pairs<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v8:<br>
&gt; &gt; &gt; 1. Modified based on comments by Cornelia Huck<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v7:<br>
&gt; &gt; &gt; 1. add rx_reset, tx_reset<br>
&gt; &gt; &gt; 2. add device normative and dirver normative<br>
&gt; &gt; &gt; 3. add comments for *_packets, *_bytres<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v6:<br>
&gt; &gt; &gt; 1. correct the names and descriptions of some stats items<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v5:<br>
&gt; &gt; &gt; 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ<br>
&gt; &gt; &gt; 2. more item for virtio_net_ctrl_reply_stats_queue_pair<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v4:<br>
&gt; &gt; &gt; 1. remove dev_stats_num, {rx|tx}_stats_num<br>
&gt; &gt; &gt; 2. Use two commands to get the stats of queue pair and dev r=
espectively<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; v3 changes:<br>
&gt; &gt; &gt; 1. add dev_version<br>
&gt; &gt; &gt; 2. use queue_pair_index replace rx_num, tx_num<br>
&gt; &gt; &gt; 3. Explain the processing when the device and driver support=
 different numbers<br>
&gt; &gt; &gt; of stats<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0conformance.tex |=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0content.tex=C2=A0 =C2=A0 =C2=A0| 391 +++++++++++=
++++++++++++++++++++++++++++++++++++-<br>
&gt; &gt; &gt;=C2=A0 =C2=A02 files changed, 390 insertions(+), 3 deletions(=
-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/conformance.tex b/conformance.tex<br>
&gt; &gt; &gt; index 42f8537..c67f877 100644<br>
&gt; &gt; &gt; --- a/conformance.tex<br>
&gt; &gt; &gt; +++ b/conformance.tex<br>
&gt; &gt; &gt; @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:=
Conformance / Conformance Targets}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{drivernormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Automatic receive steerin=
g in multiqueue mode}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{drivernormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Offloads State Configurat=
ion / Setting Offloads State}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{drivernormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS=
) }<br>
&gt; &gt; &gt; +\item \ref{drivernormative:Device Types / Network Device / =
Device Operation / Control Virtqueue / Device Stats}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\end{itemize}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\conformance{\subsection}{Block Driver Conforman=
ce}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}<=
br>
&gt; &gt; &gt; @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:=
Conformance / Conformance Targets}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{devicenormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending=
}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{devicenormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Automatic receive steerin=
g in multiqueue mode}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item \ref{devicenormative:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS=
) / RSS processing}<br>
&gt; &gt; &gt; +\item \ref{devicenormative:Device Types / Network Device / =
Device Operation / Control Virtqueue / Device Stats}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\end{itemize}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\conformance{\subsection}{Block Device Conforman=
ce}\label{sec:Conformance / Device Conformance / Block Device Conformance}<=
br>
&gt; &gt; &gt; diff --git a/content.tex b/content.tex<br>
&gt; &gt; &gt; index c6f116c..5746f49 100644<br>
&gt; &gt; &gt; --- a/content.tex<br>
&gt; &gt; &gt; +++ b/content.tex<br>
&gt; &gt; &gt; @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:De=
vice Types / Network Device / Feature bits<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC ad=
dress through control<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0channel.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide devic=
e-level statistics<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 to the driver through the control channel.<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_HOST_USO (56)] Device can rec=
eive USO packets. Unlike UFO<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 (fragmenting the packet) the USO splits large U=
DP packet<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 to several segments when each of these smaller =
packets has UDP header.<br>
&gt; &gt; &gt; @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirement=
s}\label{sec:Device Types / Network Device<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRT=
IO_NET_F_CTRL_VQ.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTR=
L_VQ.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTI=
O_NET_F_CTRL_VQ.<br>
&gt; &gt; &gt; +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_V=
Q.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_=
F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CT=
RL_VQ.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\end{description}<br>
&gt; &gt; &gt; @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\labe=
l{sec:Device Types / Network Device / Devi<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 command;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 command-specific-=
data[];<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 ack;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 command-specific-data-reply[=
];<br>
&gt; &gt; &gt;=C2=A0 =C2=A0};<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0/* ack values */<br>
&gt; &gt; &gt; @@ -4023,9 +4028,11 @@ \subsubsection{Control Virtqueue}\lab=
el{sec:Device Types / Network Device / Devi<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\end{lstlisting}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0The \field{class}, \field{command} and command-s=
pecific-data are set by the<br>
&gt; &gt; &gt; -driver, and the device sets the \field{ack} byte. There is =
little it can<br>
&gt; &gt; &gt; -do except issue a diagnostic if \field{ack} is not<br>
&gt; &gt; &gt; -VIRTIO_NET_OK.<br>
&gt; &gt; &gt; +driver, and the device sets the \field{ack} byte and option=
ally<br>
&gt; &gt; &gt; +\field{command-specific-data-reply}. There is little the dr=
iver can<br>
&gt; &gt; &gt; +do except issue a diagnostic if \field{ack} is not VIRTIO_N=
ET_OK.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The command VIRTIO_NET_CTRL_STATS_GET contains \field{comma=
nd-specific-data-reply}.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\paragraph{Packet Receive Filtering}\label{sec:D=
evice Types / Network Device / Device Operation / Control Virtqueue / Packe=
t Receive Filtering}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\label{sec:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for l=
atexdiff<br>
&gt; &gt; &gt; @@ -4471,6 +4478,384 @@ \subsubsection{Control Virtqueue}\la=
bel{sec:Device Types / Network Device / Devi<br>
&gt; &gt; &gt;=C2=A0 =C2=A0according to the native endian of the guest rath=
er than<br>
&gt; &gt; &gt;=C2=A0 =C2=A0(necessarily when not using the legacy interface=
) little-endian.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +\paragraph{Device Stats}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Device Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the d=
river can<br>
&gt; &gt; &gt; +get the device stats from the device in \field{command-spec=
ific-data-reply}.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +To get the stats, the following definitions are used:<br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +#define VIRTIO_NET_CTRL_STATS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A06<br>
&gt; &gt; &gt; +#define VIRTIO_NET_CTRL_STATS_GET=C2=A0 =C2=A0 =C2=A00<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_CVQ=C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_RX_CSUM=C2=A0 2<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_RX_GSO=C2=A0 =C2=A03<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_TX_CSUM=C2=A0 6<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_TX_GSO=C2=A0 =C2=A07<br>
&gt; &gt; &gt; +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{lstlisting}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The following layout structures are used:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\field{command-specific-data}<br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +struct virtio_net_ctrl_queue_stats {<br>
&gt; &gt; &gt; + u16 nstats;<br>
&gt; &gt; &gt; + struct {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u16 queue_num;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u16 type;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u16 length;<br>
&gt; &gt; &gt; + } stats[];<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +\end{lstlisting}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\field{command-specific-data-reply}<br>
&gt; &gt; &gt; +\begin{lstlisting}<br>
&gt; &gt; &gt; +struct virtio_net_stats_cvq {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 command_num;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 ok_num;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_rx_basic {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_packets;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_bytes;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_notification;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_interrupt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_drop;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_drop_overruns;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_rx_csum {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_csum_valid;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_needs_csum;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_csum_bad;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_csum_none;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_rx_gso {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_gso_packets;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_gso_bytes;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_rx_reset {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 rx_reset;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_tx_basic {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_packets;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_bytes;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_notification;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_interrupt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_drop;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_drop_malformed;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_tx_csum {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_csum_none;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_needs_csum;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_tx_gso {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_gso_packets;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_gso_bytes;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct virtio_net_stats_tx_reset {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 le64 tx_reset;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{lstlisting}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Use the command VIRTIO_NET_CTRL_STATS_GET and \field{comman=
d-specific-data}<br>
&gt; &gt; &gt; +containing struct virtio_net_ctrl_queue_stats to get the de=
vice stats.<br>
&gt; &gt; &gt; +The result is returned by \field{command-specific-data-repl=
y}.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s better to move this sentence after the description above=
. And we<br>
&gt; &gt; need explain the result a little bit more, e.g the stats ware ret=
urned<br>
&gt; &gt; in the order of the type specified in the virtio_net_ctrl_queue_s=
tats.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [nstats]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of \field{stats}.<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [queue_num]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The queue num of the vq to be o=
btained. The vq can be receiveq,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 transmitq or controlq.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; This could be simplified as &quot;The number of the virtqueue to =
obtain the<br>
&gt; &gt; statistics&quot;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [type]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The type of the stats to be obt=
ained.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [length]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Limits the size of the memory s=
pace occupied by the returned stats.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; What&#39;s the value of having this? Or how can driver know which=
 value<br>
&gt; &gt; should it use?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Correspondence between the vq type, the stats type, the sta=
ts structure and the<br>
&gt; &gt; &gt; +required features.<br>
&gt; &gt; &gt; +\begin{tabular}{ |l|l|l|l| }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \hline<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 VQ Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp; Stats Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; Stats Structure=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; Features \\ \hline<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 controlq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_CVQ=C2=A0 =C2=A0 =C2=
=A0 &amp; virtio_net_stats_cvq=C2=A0 =C2=A0 =C2=A0 &amp; \\ \hline<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I think CVQ should require CVQ feature to be negotiated.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \multirow{4}*{receiveq}=C2=A0 &amp; VIRTIO_NE=
T_STATS_TYPE_RX_BASIC &amp; virtio_net_stats_rx_basic &amp; \\ \cline{2-4}<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX=
_CSUM=C2=A0 &amp; virtio_net_stats_rx_csum=C2=A0 &amp; VIRTIO_NET_F_GUEST_C=
SUM \\ \cline{2-4}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX=
_GSO=C2=A0 =C2=A0&amp; virtio_net_stats_rx_gso=C2=A0 =C2=A0&amp; VIRTIO_NET=
_F_GUEST_TSO4, TSO6, or UFO \\ \cline{2-4}<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s better to aovid abbrev for features like TSO6.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX=
_RESET &amp; virtio_net_stats_rx_reset &amp; VIRTIO_F_RING_RESET \\ \hline<=
br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \multirow{4}*{transmitq} &amp; VIRTIO_NET_STA=
TS_TYPE_TX_BASIC &amp; virtio_net_stats_tx_basic &amp; \\ \cline{2-4}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX=
_CSUM=C2=A0 &amp; virtio_net_stats_tx_csum=C2=A0 &amp; VIRTIO_NET_F_CSUM \\=
 \cline{2-4}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX=
_GSO=C2=A0 =C2=A0&amp; virtio_net_stats_tx_gso=C2=A0 =C2=A0&amp; VIRTIO_NET=
_F_HOST_TSO4, TSO6, USO or UFO \\ \cline{2-4}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX=
_RESET &amp; virtio_net_stats_tx_reset &amp; VIRTIO_F_RING_RESET \\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \hline<br>
&gt; &gt; &gt; +\end{tabular}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Controlq Stats}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Device Stats / Controlq=
 Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the controlq stats is virtio=
_net_stats_cvq.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [command_num]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of commands, includi=
ng the current command.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [ok_num]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of commands (includi=
ng the current command) where the ack was VIRTIO_NET_OK.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device Stats / Re=
ceiveq Basic Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the receiveq basic stats is =
virtio_net_stats_rx_basic.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Receiveq basic stats doesn&#39;t need any features, as long=
 as the device supports<br>
&gt; &gt; &gt; +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq bas=
ic stats.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_packets]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets received =
by device (not the packets passed to the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), including the dropped p=
ackets by device.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_bytes]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes received by=
 device (not the packets passed to the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), including the dropped p=
ackets by device.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_notification]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of driver notificati=
ons.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_interrupt]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of device interrupts=
.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_drop]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped b=
y the receiveq. Contains all kinds of<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet drop.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_drop_overruns]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped b=
y the receiveq when no more descriptors<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 were available.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types=
 / Network Device / Device Operation / Control Virtqueue / Device Stats / T=
ransmitq Basic Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the transmitq basic stats is=
 virtio_net_stats_tx_basic.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Transmitq basic stats doesn&#39;t need any features, as lon=
g as the device supports<br>
&gt; &gt; &gt; +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq ba=
sic stats.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_packets]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets sent by d=
evice (not the packets received from the<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; s/received/sent/?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), excluding the dropped p=
ackets by device.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_bytes]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes sent by dev=
ice (not the packets received from the<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), excluding the dropped p=
ackets by device.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_notification]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of driver notificati=
ons.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_interrupt]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of device interrupts=
.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_drop]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped b=
y the transmitq. Contains all kinds of<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet drop.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_drop_malformed]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped w=
hen the descriptor is in an error state.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 For example, the buffer is too =
short.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue / Device Stats / Rec=
eiveq CSUM Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the receiveq csum stats is v=
irtio_net_stats_rx_csum.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is succe=
ssful, the receiveq<br>
&gt; &gt; &gt; +csum stats can be obtained.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The following are the receiveq csum stats:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_csum_valid]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with VIRT=
IO_NET_HDR_F_DATA_VALID.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_needs_csum]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with VIRT=
IO_NET_HDR_F_NEEDS_CSUM.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_csum_bad]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with abno=
rmal csum.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_csum_none]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets without h=
ardware csum. The packet here refers to<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 the non-TCP/UDP packet that the=
 backend cannot recognize.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device Stats / Tr=
ansmitq CSUM Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the transmitq csum stats is =
virtio_net_stats_tx_csum.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Only after the VIRTIO_NET_F_CSUM negotiation is successful,=
 the transmitq csum<br>
&gt; &gt; &gt; +stats can be obtained.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The following are the transmitq csum stats:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_csum_none]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets that didn=
&#39;t require hardware csum.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_needs_csum]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets that requ=
ired hardware csum.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / =
Network Device / Device Operation / Control Virtqueue / Device Stats / Rece=
iveq GSO Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the receiveq gso stats is vi=
rtio_net_stats_rx_gso.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options=
 have<br>
&gt; &gt; &gt; +been negotiated, the receiveq gso stats can be obtained.<br=
>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Rx gso packets refer to packets passed by the device to the=
 driver where<br>
&gt; &gt; &gt; +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The statistics of the following receiveq gso stats are base=
d on the rx gso<br>
&gt; &gt; &gt; +packet. The device may receive multiple small packets, and =
finally combine them<br>
&gt; &gt; &gt; +into one rx gso packet and pass it to the driver. It is als=
o possible to receive<br>
&gt; &gt; &gt; +a gso packet and pass it directly to the driver. We should =
count the information<br>
&gt; &gt; &gt; +of the rx gso packet that is finally passed to the driver (=
such as number and<br>
&gt; &gt; &gt; +bytes). Instead of the information of the small packet.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; If we don&#39;t want to explain why we use a single counter for t=
hose two<br>
&gt; &gt; cases, we probably can drop the above paragraph and simply say th=
e<br>
&gt; &gt; rx_gso_packets is the number of gso packet produced by the device=
.<br>
&gt; &gt;<br>
&gt; &gt; Btw, we had VIRTIO_NET_GUEST_RSC{4|6}, is it better to use differ=
ent<br>
&gt; &gt; counters?<br>
&gt; <br>
&gt; <br>
&gt; RSC information doesn&#39;t seem to be very comprehensive in the spec.=
<br>
<br>
CC Yuri.<br>
Yuri do you feel we need to clarify things in the spec?<br>
If yes please create a github issue. Thanks!<br></blockquote><div><br></div=
><div>I agree, it looks to me RSC may make sense for harware virtio devices=
 so it&#39;s probably not a feature just for WHQL.</div><div><br></div><div=
>Thanks</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; I&#39;m not sure,<br>
&gt; is the gso_type of the RSC package also VIRTIO_NET_HDR_GSO_TCPV4 or VI=
RTIO_NET_HDR_GSO_TCPV6?<br>
&gt; <br>
&gt; If yes, I plan to modify gso&#39;s stats to the following form to reco=
rd gso&#39;s<br>
&gt; stats. In this case include the RSC package.<br>
&gt; <br>
&gt; \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_packets]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of the rx gso packets.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_bytes]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes(excluding the vir=
tio net header) of the rx gso packets.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_packets_coalesced]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of the rx gso packages gen=
erated by merging.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_bytes_coalesced]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes(excluding the vir=
tio net header) of the rx gso packets generated by merging.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_segments]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of coalesced segments.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [rx_gso_segments_bytes]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes of coalesced segm=
ents.<br>
&gt; <br>
&gt; \end{description}<br>
&gt; <br>
&gt; \begin{description}<br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_packets]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of the tx gso packets.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_bytes]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes(excluding the vir=
tio net header) of the tx gso packets.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_packets_split]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of the tx gso packets that=
 been split.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_bytes_split]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes(excluding the vir=
tio net header) of the tx gso packets that been split.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_segments]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of segments split from the=
 gso package.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0\item [tx_gso_segments_bytes]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The number of bytes(excluding the vir=
tio net header) of segments split from the gso package.<br>
&gt; \end{description}<br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_gso_packets]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the rx gso packet=
s.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_gso_bytes]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding t=
he virtio net header) of the rx gso packets.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue / Device Stats / Tra=
nsmitq GSO Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the receiveq gso stats is vi=
rtio_net_stats_tx_gso.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO opti=
ons have<br>
&gt; &gt; &gt; +been negotiated, the transmitq gso stats can be obtained.<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Tx gso packets refer to packets passed by the driver to the=
 device where<br>
&gt; &gt; &gt; +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The statistics of the following transmitq gso stats are bas=
ed on the tx gso<br>
&gt; &gt; &gt; +packet. The device may receive a tx gso packet from the dri=
ver, and then may split<br>
&gt; &gt; &gt; +it into multiple small packets or send the tx gso packet di=
rectly. But the device<br>
&gt; &gt; &gt; +counts the information of the gso packet received from the =
driver (such as the<br>
&gt; &gt; &gt; +number and bytes). Instead of the packet information after =
splitting.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Similar to rx gso, is it better to use two counters?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_gso_packets]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the tx gso packet=
s.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_gso_bytes]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding t=
he virtio net header) of the tx gso packets.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device Stats / Re=
ceiveq Reset Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the receiveq reset stats is =
virtio_net_stats_rx_reset.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Only when VIRTIO_F_RING_RESET is successfully negotiated, t=
he receiveq reset stats<br>
&gt; &gt; &gt; +can be obtained.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueu=
es / Virtqueue Reset}<br>
&gt; &gt; &gt; +for more about \field{rx_reset}.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [rx_reset]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of queue resets.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types=
 / Network Device / Device Operation / Control Virtqueue / Device Stats / T=
ransmitq Reset Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The structure corresponding to the transmitq reset stats is=
 virtio_net_stats_tx_reset.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +Only when VIRTIO_F_RING_RESET is successfully negotiated, t=
he transmitq reset stats<br>
&gt; &gt; &gt; +can be obtained.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueu=
es / Virtqueue Reset}<br>
&gt; &gt; &gt; +for more about \field{tx_reset}.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\begin{description}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item [tx_reset]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of queue resets.<br>
&gt; &gt; &gt; +\end{description}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\devicenormative{\subparagraph}{Device Stats}{Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +If virtio_net_ctrl_queue_stats is incorrect (such as the fo=
llowing), the device<br>
&gt; &gt; &gt; +MUST set \field{ack} to VIRTIO_NET_ERR.<br>
&gt; &gt; &gt; +\begin{itemize}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item \field{queue_num} exceeds the queue ran=
ge.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item \field{type} is not a known value.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; What happens if driver tries to query RX stats through a TX index=
?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item The type of vq does not match \field{ty=
pe}.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item The feature corresponding to the specif=
ied \field{type} was not successfully<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 negotiated.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 \item The size of \field{command-specific-dat=
a-reply} is less than the sum<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 of \field{length}.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m not sure I get here, I guess this proposal allows the dri=
ver to<br>
&gt; &gt; query an array of stats. So I guess it means the size of required=
 stats<br>
&gt; &gt; instead of the size of \field{command-specific-data-reply}.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +\end{itemize}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The device MUST write the requested stats structures in<br>
&gt; &gt; &gt; +\field{command-specific-data-reply} in the order specified =
by the structure<br>
&gt; &gt; &gt; +virtio_net_ctrl_queue_stats.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Do we need per stat error code here? Or device can simply fail a =
batch<br>
&gt; &gt; of query if one of those fails?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The size of each stats MUST be less than or equal to the co=
rresponding<br>
&gt; &gt; &gt; +\field{length}, but the space it occupies MUST be equal to =
the corresponding<br>
&gt; &gt; &gt; +\field{length}.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I wonder how the length trick can work here. Is this used for ext=
ension?<br>
&gt; &gt; If yes, how can driver know a suitable length? What happens if de=
vice<br>
&gt; &gt; support more stats?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\drivernormative{\subparagraph}{Device Stats}{Device Types =
/ Network Device / Device Operation / Control Virtqueue / Device Stats}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +When a driver tries to obtain a certain stats, it MUST conf=
irm that the relevant<br>
&gt; &gt; &gt; +feature negotiation is successful.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\field{type} in struct virtio_net_ctrl_queue_stats MUST cor=
respond to the vq<br>
&gt; &gt; &gt; +specified by \field{queue_num}.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +\field{length} in struct virtio_net_ctrl_queue_stats MUST b=
e greater than or<br>
&gt; &gt; &gt; +equal to the size of the structure corresponding to \field{=
type}. It MUST be a<br>
&gt; &gt; &gt; +multiple of 8.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Why do we need the padding here?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +The size of \field{command-specific-data-reply} allocated b=
y the driver MUST be<br>
&gt; &gt; &gt; +greater than or equal to the sum of \field{legnth} in struc=
t<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; typo.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +virtio_net_ctrl_queue_stats.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Any value that we can allocate more than the sum of the length?<b=
r>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +When the driver reads the response, it MUST read<br>
&gt; &gt; &gt; +\field{command-specific-data-reply} one by one based on the=
 set \field{length}<br>
&gt; &gt; &gt; +and \field{type}.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0\subsubsection{Legacy Interface: Framing Require=
ments}\label{sec:Device<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Types / Network Device / Legacy Interface: Frami=
ng Requirements}<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.31.0<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--00000000000096e64f05d9c58b13--

