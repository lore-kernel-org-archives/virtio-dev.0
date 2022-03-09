Return-Path: <virtio-dev-return-9357-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04F8E98658B
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Mar 2022 09:08:33 +0000 (UTC)
Date: Wed, 9 Mar 2022 04:08:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220309040741-mutt-send-email-mst@kernel.org>
References: <20220302085217.16546-1-xuanzhuo@linux.alibaba.com>
 <fbb699b3-7f20-5acc-dd94-9a1164411e3c@redhat.com>
 <1646814326.7522051-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1646814326.7522051-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v11] virtio-net: support device stats
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 09, 2022 at 04:25:26PM +0800, Xuan Zhuo wrote:
> On Mon, 7 Mar 2022 15:58:03 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> >
> > =E5=9C=A8 2022/3/2 =E4=B8=8B=E5=8D=884:52, Xuan Zhuo =E5=86=99=E9=81=93=
:
> > > This patch allows the driver to obtain some statistics from the devic=
e.
> > >
> > > In the back-end implementation, we can count a lot of such informatio=
n,
> > > which can be used for debugging and judging the running status of the
> > > back-end. We hope to directly display it to the user through ethtool.
> > >
> > > To get stats atomically, try to get stats for all queue pairs in one
> > > command.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > v11:
> > > 1. Use michael's advice to introduce virtio_net_ctrl_queue_stats to g=
et vq stats
> > >     based on vq num and type
> > > 2. split stats structure
> > >
> > > v10:
> > > 1. use description/item for the item of the queue pair
> > > 2. use one command to get the stats of all queue pairs
> > >
> > > v8:
> > > 1. Modified based on comments by Cornelia Huck
> > >
> > > v7:
> > > 1. add rx_reset, tx_reset
> > > 2. add device normative and dirver normative
> > > 3. add comments for *_packets, *_bytres
> > >
> > > v6:
> > > 1. correct the names and descriptions of some stats items
> > >
> > > v5:
> > > 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
> > > 2. more item for virtio_net_ctrl_reply_stats_queue_pair
> > >
> > > v4:
> > > 1. remove dev_stats_num, {rx|tx}_stats_num
> > > 2. Use two commands to get the stats of queue pair and dev respective=
ly
> > >
> > > v3 changes:
> > > 1. add dev_version
> > > 2. use queue_pair_index replace rx_num, tx_num
> > > 3. Explain the processing when the device and driver support differen=
t numbers
> > > of stats
> > >
> > >   conformance.tex |   2 +
> > >   content.tex     | 391 +++++++++++++++++++++++++++++++++++++++++++++=
++-
> > >   2 files changed, 390 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 42f8537..c67f877 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conforman=
ce / Conformance Targets}
> > >   \item \ref{drivernormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Automatic receive steering in multiqueue mod=
e}
> > >   \item \ref{drivernormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Offloads State Configuration / Setting Offlo=
ads State}
> > >   \item \ref{drivernormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Receive-side scaling (RSS) }
> > > +\item \ref{drivernormative:Device Types / Network Device / Device Op=
eration / Control Virtqueue / Device Stats}
> > >   \end{itemize}
> > >
> > >   \conformance{\subsection}{Block Driver Conformance}\label{sec:Confo=
rmance / Driver Conformance / Block Driver Conformance}
> > > @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conforman=
ce / Conformance Targets}
> > >   \item \ref{devicenormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Gratuitous Packet Sending}
> > >   \item \ref{devicenormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Automatic receive steering in multiqueue mod=
e}
> > >   \item \ref{devicenormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> > > +\item \ref{devicenormative:Device Types / Network Device / Device Op=
eration / Control Virtqueue / Device Stats}
> > >   \end{itemize}
> > >
> > >   \conformance{\subsection}{Block Device Conformance}\label{sec:Confo=
rmance / Device Conformance / Block Device Conformance}
> > > diff --git a/content.tex b/content.tex
> > > index c6f116c..5746f49 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Type=
s / Network Device / Feature bits
> > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contr=
ol
> > >       channel.
> > >
> > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level s=
tatistics
> > > +    to the driver through the control channel.
> > > +
> > >   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. U=
nlike UFO
> > >    (fragmenting the packet) the USO splits large UDP packet
> > >    to several segments when each of these smaller packets has UDP hea=
der.
> > > @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{=
sec:Device Types / Network Device
> > >   \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRT=
IO_NET_F_HOST_TSO6.
> > >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >   \end{description}
> > > @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi
> > >           u8 command;
> > >           u8 command-specific-data[];
> > >           u8 ack;
> > > +        u8 command-specific-data-reply[];
> > >   };
> > >
> > >   /* ack values */
> > > @@ -4023,9 +4028,11 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi
> > >   \end{lstlisting}
> > >
> > >   The \field{class}, \field{command} and command-specific-data are se=
t by the
> > > -driver, and the device sets the \field{ack} byte. There is little it=
 can
> > > -do except issue a diagnostic if \field{ack} is not
> > > -VIRTIO_NET_OK.
> > > +driver, and the device sets the \field{ack} byte and optionally
> > > +\field{command-specific-data-reply}. There is little the driver can
> > > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > +
> > > +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specif=
ic-data-reply}.
> > >
> > >   \paragraph{Packet Receive Filtering}\label{sec:Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Packet Receive Filtering=
}
> > >   \label{sec:Device Types / Network Device / Device Operation / Contr=
ol Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > @@ -4471,6 +4478,384 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> > >   according to the native endian of the guest rather than
> > >   (necessarily when not using the legacy interface) little-endian.
> > >
> > > +\paragraph{Device Stats}\label{sec:Device Types / Network Device / D=
evice Operation / Control Virtqueue / Device Stats}
> > > +
> > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> > > +get the device stats from the device in \field{command-specific-data=
-reply}.
> > > +
> > > +To get the stats, the following definitions are used:
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_CTRL_STATS         6
> > > +#define VIRTIO_NET_CTRL_STATS_GET     0
> > > +
> > > +#define VIRTIO_NET_STATS_TYPE_CVQ      0
> > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1
> > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM  2
> > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO   3
> > > +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4
> > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5
> > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM  6
> > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO   7
> > > +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8
> > > +
> > > +\end{lstlisting}
> > > +
> > > +The following layout structures are used:
> > > +
> > > +\field{command-specific-data}
> > > +\begin{lstlisting}
> > > +struct virtio_net_ctrl_queue_stats {
> > > +=09u16 nstats;
> > > +=09struct {
> > > +=09    u16 queue_num;
> > > +=09    u16 type;
> > > +=09    u16 length;
> > > +=09} stats[];
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +\field{command-specific-data-reply}
> > > +\begin{lstlisting}
> > > +struct virtio_net_stats_cvq {
> > > +    le64 command_num;
> > > +    le64 ok_num;
> > > +};
> > > +
> > > +struct virtio_net_stats_rx_basic {
> > > +    le64 rx_packets;
> > > +    le64 rx_bytes;
> > > +
> > > +    le64 rx_notification;
> > > +    le64 rx_interrupt;
> > > +
> > > +    le64 rx_drop;
> > > +    le64 rx_drop_overruns;
> > > +};
> > > +
> > > +struct virtio_net_stats_rx_csum {
> > > +    le64 rx_csum_valid;
> > > +    le64 rx_needs_csum;
> > > +    le64 rx_csum_bad;
> > > +    le64 rx_csum_none;
> > > +};
> > > +
> > > +struct virtio_net_stats_rx_gso {
> > > +    le64 rx_gso_packets;
> > > +    le64 rx_gso_bytes;
> > > +};
> > > +
> > > +struct virtio_net_stats_rx_reset {
> > > +    le64 rx_reset;
> > > +};
> > > +
> > > +struct virtio_net_stats_tx_basic {
> > > +    le64 tx_packets;
> > > +    le64 tx_bytes;
> > > +
> > > +    le64 tx_notification;
> > > +    le64 tx_interrupt;
> > > +
> > > +    le64 tx_drop;
> > > +    le64 tx_drop_malformed;
> > > +};
> > > +
> > > +struct virtio_net_stats_tx_csum {
> > > +    le64 tx_csum_none;
> > > +    le64 tx_needs_csum;
> > > +};
> > > +
> > > +struct virtio_net_stats_tx_gso {
> > > +    le64 tx_gso_packets;
> > > +    le64 tx_gso_bytes;
> > > +};
> > > +
> > > +struct virtio_net_stats_tx_reset {
> > > +    le64 tx_reset;
> > > +};
> > > +
> > > +\end{lstlisting}
> > > +
> > > +Use the command VIRTIO_NET_CTRL_STATS_GET and \field{command-specifi=
c-data}
> > > +containing struct virtio_net_ctrl_queue_stats to get the device stat=
s.
> > > +The result is returned by \field{command-specific-data-reply}.
> >
> >
> > It's better to move this sentence after the description above. And we
> > need explain the result a little bit more, e.g the stats ware returned
> > in the order of the type specified in the virtio_net_ctrl_queue_stats.
> >
> >
> > > +
> > > +\begin{description}
> > > +    \item [nstats]
> > > +        The number of \field{stats}.
> > > +
> > > +    \item [queue_num]
> > > +        The queue num of the vq to be obtained. The vq can be receiv=
eq,
> > > +        transmitq or controlq.
> >
> >
> > This could be simplified as "The number of the virtqueue to obtain the
> > statistics"
> >
> >
> > > +
> > > +    \item [type]
> > > +        The type of the stats to be obtained.
> > > +
> > > +    \item [length]
> > > +        Limits the size of the memory space occupied by the returned=
 stats.
> >
> >
> > What's the value of having this? Or how can driver know which value
> > should it use?
> >
> >
> > > +
> > > +\end{description}
> > > +
> > > +Correspondence between the vq type, the stats type, the stats struct=
ure and the
> > > +required features.
> > > +\begin{tabular}{ |l|l|l|l| }
> > > +    \hline
> > > +    VQ Type                  & Stats Type                     & Stat=
s Structure           & Features \\ \hline
> > > +
> > > +    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      & virt=
io_net_stats_cvq      & \\ \hline
> >
> >
> > I think CVQ should require CVQ feature to be negotiated.
> >
> >
> > > +
> > > +    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC & virt=
io_net_stats_rx_basic & \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  & virt=
io_net_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_GSO   & virt=
io_net_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO \\ \cline{2-4=
}
> >
> >
> > It's better to aovid abbrev for features like TSO6.
> >
> >
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_RESET & virt=
io_net_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
> > > +
> > > +    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC & virt=
io_net_stats_tx_basic & \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  & virt=
io_net_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_GSO   & virt=
io_net_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO \\ \cline{=
2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_RESET & virt=
io_net_stats_tx_reset & VIRTIO_F_RING_RESET \\
> > > +    \hline
> > > +\end{tabular}
> > > +
> > > +
> > > +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> > > +
> > > +The structure corresponding to the controlq stats is virtio_net_stat=
s_cvq.
> > > +
> > > +\begin{description}
> > > +    \item [command_num]
> > > +        The number of commands, including the current command.
> > > +
> > > +    \item [ok_num]
> > > +        The number of commands (including the current command) where=
 the ack was VIRTIO_NET_OK.
> > > +\end{description}
> > > +
> > > +
> > > +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Ba=
sic Stats}
> > > +
> > > +The structure corresponding to the receiveq basic stats is virtio_ne=
t_stats_rx_basic.
> > > +
> > > +Receiveq basic stats doesn't need any features, as long as the devic=
e supports
> > > +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stats.
> > > +
> > > +\begin{description}
> > > +    \item [rx_packets]
> > > +        The number of packets received by device (not the packets pa=
ssed to the
> > > +        guest), including the dropped packets by device.
> > > +
> > > +    \item [rx_bytes]
> > > +        The number of bytes received by device (not the packets pass=
ed to the
> > > +        guest), including the dropped packets by device.
> > > +
> > > +    \item [rx_notification]
> > > +        The number of driver notifications.
> > > +
> > > +    \item [rx_interrupt]
> > > +        The number of device interrupts.
> > > +
> > > +    \item [rx_drop]
> > > +        The number of packets dropped by the receiveq. Contains all =
kinds of
> > > +        packet drop.
> > > +
> > > +    \item [rx_drop_overruns]
> > > +        The number of packets dropped by the receiveq when no more d=
escriptors
> > > +        were available.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Device Stats / Transmitq =
Basic Stats}
> > > +
> > > +The structure corresponding to the transmitq basic stats is virtio_n=
et_stats_tx_basic.
> > > +
> > > +Transmitq basic stats doesn't need any features, as long as the devi=
ce supports
> > > +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic stats=
.
> > > +
> > > +\begin{description}
> > > +    \item [tx_packets]
> > > +        The number of packets sent by device (not the packets receiv=
ed from the
> >
> >
> > s/received/sent/?
> >
> >
> > > +        guest), excluding the dropped packets by device.
> > > +
> > > +    \item [tx_bytes]
> > > +        The number of bytes sent by device (not the packets received=
 from the
> > > +        guest), excluding the dropped packets by device.
> > > +
> > > +    \item [tx_notification]
> > > +        The number of driver notifications.
> > > +
> > > +    \item [tx_interrupt]
> > > +        The number of device interrupts.
> > > +
> > > +    \item [tx_drop]
> > > +        The number of packets dropped by the transmitq. Contains all=
 kinds of
> > > +        packet drop.
> > > +
> > > +    \item [tx_drop_malformed]
> > > +        The number of packets dropped when the descriptor is in an e=
rror state.
> > > +        For example, the buffer is too short.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Receiveq CSU=
M Stats}
> > > +
> > > +The structure corresponding to the receiveq csum stats is virtio_net=
_stats_rx_csum.
> > > +
> > > +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, th=
e receiveq
> > > +csum stats can be obtained.
> > > +
> > > +The following are the receiveq csum stats:
> > > +
> > > +\begin{description}
> > > +    \item [rx_csum_valid]
> > > +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> > > +
> > > +    \item [rx_needs_csum]
> > > +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> > > +
> > > +    \item [rx_csum_bad]
> > > +        The number of packets with abnormal csum.
> > > +
> > > +    \item [rx_csum_none]
> > > +        The number of packets without hardware csum. The packet here=
 refers to
> > > +        the non-TCP/UDP packet that the backend cannot recognize.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats / Transmitq C=
SUM Stats}
> > > +
> > > +The structure corresponding to the transmitq csum stats is virtio_ne=
t_stats_tx_csum.
> > > +
> > > +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the tran=
smitq csum
> > > +stats can be obtained.
> > > +
> > > +The following are the transmitq csum stats:
> > > +
> > > +\begin{description}
> > > +    \item [tx_csum_none]
> > > +        The number of packets that didn't require hardware csum.
> > > +
> > > +    \item [tx_needs_csum]
> > > +        The number of packets that required hardware csum.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Device Stats / Receiveq GSO =
Stats}
> > > +
> > > +The structure corresponding to the receiveq gso stats is virtio_net_=
stats_rx_gso.
> > > +
> > > +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> > > +been negotiated, the receiveq gso stats can be obtained.
> > > +
> > > +Rx gso packets refer to packets passed by the device to the driver w=
here
> > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > +
> > > +The statistics of the following receiveq gso stats are based on the =
rx gso
> > > +packet. The device may receive multiple small packets, and finally c=
ombine them
> > > +into one rx gso packet and pass it to the driver. It is also possibl=
e to receive
> > > +a gso packet and pass it directly to the driver. We should count the=
 information
> > > +of the rx gso packet that is finally passed to the driver (such as n=
umber and
> > > +bytes). Instead of the information of the small packet.
> >
> >
> > If we don't want to explain why we use a single counter for those two
> > cases, we probably can drop the above paragraph and simply say the
> > rx_gso_packets is the number of gso packet produced by the device.
> >
> > Btw, we had VIRTIO_NET_GUEST_RSC{4|6}, is it better to use different
> > counters?
>=20
>=20
> RSC information doesn't seem to be very comprehensive in the spec.

CC Yuri.
Yuri do you feel we need to clarify things in the spec?
If yes please create a github issue. Thanks!

> I'm not sure,
> is the gso_type of the RSC package also VIRTIO_NET_HDR_GSO_TCPV4 or VIRTI=
O_NET_HDR_GSO_TCPV6?
>=20
> If yes, I plan to modify gso's stats to the following form to record gso'=
s
> stats. In this case include the RSC package.
>=20
> \begin{description}
>     \item [rx_gso_packets]
>         The number of the rx gso packets.
>=20
>     \item [rx_gso_bytes]
>         The number of bytes(excluding the virtio net header) of the rx gs=
o packets.
>=20
>     \item [rx_gso_packets_coalesced]
>         The number of the rx gso packages generated by merging.
>=20
>     \item [rx_gso_bytes_coalesced]
>         The number of bytes(excluding the virtio net header) of the rx gs=
o packets generated by merging.
>=20
>     \item [rx_gso_segments]
>         The number of coalesced segments.
>=20
>     \item [rx_gso_segments_bytes]
>         The number of bytes of coalesced segments.
>=20
> \end{description}
>=20
> \begin{description}
>     \item [tx_gso_packets]
>         The number of the tx gso packets.
>=20
>     \item [tx_gso_bytes]
>         The number of bytes(excluding the virtio net header) of the tx gs=
o packets.
>=20
>     \item [tx_gso_packets_split]
>         The number of the tx gso packets that been split.
>=20
>     \item [tx_gso_bytes_split]
>         The number of bytes(excluding the virtio net header) of the tx gs=
o packets that been split.
>=20
>     \item [tx_gso_segments]
>         The number of segments split from the gso package.
>=20
>     \item [tx_gso_segments_bytes]
>         The number of bytes(excluding the virtio net header) of segments =
split from the gso package.
> \end{description}
>=20
> Thanks.
>=20
> >
> >
> > > +
> > > +\begin{description}
> > > +    \item [rx_gso_packets]
> > > +        The number of the rx gso packets.
> > > +
> > > +    \item [rx_gso_bytes]
> > > +        The number of bytes(excluding the virtio net header) of the =
rx gso packets.
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Transmitq GS=
O Stats}
> > > +
> > > +The structure corresponding to the receiveq gso stats is virtio_net_=
stats_tx_gso.
> > > +
> > > +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> > > +been negotiated, the transmitq gso stats can be obtained.
> > > +
> > > +Tx gso packets refer to packets passed by the driver to the device w=
here
> > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > +
> > > +The statistics of the following transmitq gso stats are based on the=
 tx gso
> > > +packet. The device may receive a tx gso packet from the driver, and =
then may split
> > > +it into multiple small packets or send the tx gso packet directly. B=
ut the device
> > > +counts the information of the gso packet received from the driver (s=
uch as the
> > > +number and bytes). Instead of the packet information after splitting=
.
> >
> >
> > Similar to rx gso, is it better to use two counters?
> >
> >
> > > +
> > > +\begin{description}
> > > +    \item [tx_gso_packets]
> > > +        The number of the tx gso packets.
> > > +
> > > +    \item [tx_gso_bytes]
> > > +        The number of bytes(excluding the virtio net header) of the =
tx gso packets.
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Re=
set Stats}
> > > +
> > > +The structure corresponding to the receiveq reset stats is virtio_ne=
t_stats_rx_reset.
> > > +
> > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the receiv=
eq reset stats
> > > +can be obtained.
> > > +
> > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virt=
queue Reset}
> > > +for more about \field{rx_reset}.
> > > +
> > > +\begin{description}
> > > +    \item [rx_reset]
> > > +        The number of queue resets.
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Device Stats / Transmitq =
Reset Stats}
> > > +
> > > +The structure corresponding to the transmitq reset stats is virtio_n=
et_stats_tx_reset.
> > > +
> > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the transm=
itq reset stats
> > > +can be obtained.
> > > +
> > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virt=
queue Reset}
> > > +for more about \field{tx_reset}.
> > > +
> > > +\begin{description}
> > > +    \item [tx_reset]
> > > +        The number of queue resets.
> > > +\end{description}
> > > +
> > > +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats}
> > > +
> > > +If virtio_net_ctrl_queue_stats is incorrect (such as the following),=
 the device
> > > +MUST set \field{ack} to VIRTIO_NET_ERR.
> > > +\begin{itemize}
> > > +    \item \field{queue_num} exceeds the queue range.
> > > +    \item \field{type} is not a known value.
> >
> >
> > What happens if driver tries to query RX stats through a TX index?
> >
> >
> > > +    \item The type of vq does not match \field{type}.
> > > +    \item The feature corresponding to the specified \field{type} wa=
s not successfully
> > > +        negotiated.
> > > +    \item The size of \field{command-specific-data-reply} is less th=
an the sum
> > > +        of \field{length}.
> >
> >
> > I'm not sure I get here, I guess this proposal allows the driver to
> > query an array of stats. So I guess it means the size of required stats
> > instead of the size of \field{command-specific-data-reply}.
> >
> >
> > > +\end{itemize}
> > > +
> > > +The device MUST write the requested stats structures in
> > > +\field{command-specific-data-reply} in the order specified by the st=
ructure
> > > +virtio_net_ctrl_queue_stats.
> >
> >
> > Do we need per stat error code here? Or device can simply fail a batch
> > of query if one of those fails?
> >
> >
> > > +
> > > +The size of each stats MUST be less than or equal to the correspondi=
ng
> > > +\field{length}, but the space it occupies MUST be equal to the corre=
sponding
> > > +\field{length}.
> >
> >
> > I wonder how the length trick can work here. Is this used for extension=
?
> > If yes, how can driver know a suitable length? What happens if device
> > support more stats?
> >
> >
> > > +
> > > +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats}
> > > +
> > > +When a driver tries to obtain a certain stats, it MUST confirm that =
the relevant
> > > +feature negotiation is successful.
> > > +
> > > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond t=
o the vq
> > > +specified by \field{queue_num}.
> > > +
> > > +\field{length} in struct virtio_net_ctrl_queue_stats MUST be greater=
 than or
> > > +equal to the size of the structure corresponding to \field{type}. It=
 MUST be a
> > > +multiple of 8.
> >
> >
> > Why do we need the padding here?
> >
> >
> > > +
> > > +The size of \field{command-specific-data-reply} allocated by the dri=
ver MUST be
> > > +greater than or equal to the sum of \field{legnth} in struct
> >
> >
> > typo.
> >
> >
> > > +virtio_net_ctrl_queue_stats.
> >
> >
> > Any value that we can allocate more than the sum of the length?
> >
> > Thanks
> >
> >
> > > +
> > > +When the driver reads the response, it MUST read
> > > +\field{command-specific-data-reply} one by one based on the set \fie=
ld{length}
> > > +and \field{type}.
> > >
> > >   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:De=
vice
> > >   Types / Network Device / Legacy Interface: Framing Requirements}
> > > --
> > > 2.31.0
> > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

