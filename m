Return-Path: <virtio-dev-return-9323-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 728E6986478
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Feb 2022 11:11:45 +0000 (UTC)
Message-ID: <1645700959.799065-1-xuanzhuo@linux.alibaba.com>
Date: Thu, 24 Feb 2022 19:09:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220215074743.35155-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220215074743.35155-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v9] virtio-net: support device stats
Content-Type: text/plain; charset="US-ASCII"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 15 Feb 2022 15:47:43 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> This patch allows the driver to obtain some statistics from the device.
>
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

hi Michael, Jason, any comment for this?

Thanks.

> ---
>  conformance.tex |   2 +
>  content.tex     | 135 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 134 insertions(+), 3 deletions(-)
>
> diff --git a/conformance.tex b/conformance.tex
> index 42f8537..950924e 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>  \end{itemize}
>
>  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>  \end{itemize}
>
>  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index c6f116c..818275d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
> +    to the driver through the control channel.
> +
>  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
>   (fragmenting the packet) the USO splits large UDP packet
>   to several segments when each of these smaller packets has UDP header.
> @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
> @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>          u8 command;
>          u8 command-specific-data[];
>          u8 ack;
> +        u8 command-specific-data-reply[];
>  };
>
>  /* ack values */
> @@ -4023,9 +4028,13 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \end{lstlisting}
>
>  The \field{class}, \field{command} and command-specific-data are set by the
> -driver, and the device sets the \field{ack} byte. There is little it can
> -do except issue a diagnostic if \field{ack} is not
> -VIRTIO_NET_OK.
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}. There is little the driver can
> +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> +
> +These commands VIRTIO_NET_CTRL_STATS_GET_DEV,
> +VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ, and VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR contain
> +\field{command-specific-data-reply}.
>
>  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> @@ -4471,6 +4480,126 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  according to the native endian of the guest rather than
>  (necessarily when not using the legacy interface) little-endian.
>
> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +
> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> +get device stats from the device in \field{command-specific-data-reply}.
> +
> +To get the stats, the following definitions are used:
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS                  6
> +#define VIRTIO_NET_CTRL_STATS_GET_DEV          0
> +#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ      1
> +#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   2
> +\end{lstlisting}
> +
> +The following layout structures are used:
> +
> +\field{command-specific-data}
> +\begin{lstlisting}
> +struct virtio_net_ctrl_stats_queue_pair {
> +    le64 queue_pair_index;
> +}
> +\end{lstlisting}
> +
> +\field{command-specific-data-reply}
> +\begin{lstlisting}
> +struct virtio_net_ctrl_reply_stats_dev {
> +    le64 mac_unicast_num;   /* The number of unicast mac addresses. */
> +    le64 mac_multicast_num; /* The number of multicast mac addresses. */
> +    le64 vlan_num;          /* The number of vlan. */
> +}
> +
> +struct virtio_net_ctrl_reply_stats_cvq {
> +    le64 command_num;            /* The number of commands, including the current command. */
> +    le64 ok_num;                 /* The number of commands (including the current command) where the ack was VIRTIO_NET_OK. */
> +}
> +
> +struct virtio_net_ctrl_reply_stats_queue_pair {
> +    /* rx stats */
> +    le64 rx_packets;          /* The number of packets received by device (not the packets passed to the guest), including the dropped packets by device. */
> +    le64 rx_bytes;            /* The number of bytes received by device (not the packets passed to the guest), including the dropped packets by device. */
> +
> +    le64 rx_notification;     /* The number of notifications from driver. */
> +    le64 rx_interrupt;        /* The number of interrupts generated by device. */
> +
> +    le64 rx_drop;             /* The number of packets dropped by the rx queue. Contains all kinds of packet drop. */
> +    le64 rx_drop_overruns;    /* The number of packets dropped by the rx queue when no more descriptors were available. */
> +
> +    le64 rx_csum_valid;       /* The number of packets with VIRTIO_NET_HDR_F_DATA_VALID. */
> +    le64 rx_csum_partial;     /* The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM. */
> +    le64 rx_csum_bad;         /* The number of packets with abnormal csum. */
> +    le64 rx_csum_none;        /* The number of packets without hardware csum. */
> +
> +    le64 rx_gso_packets;      /* The number of GSO packets written into the RX VQ buffers. */
> +    le64 rx_gso_bytes;        /* The number of bytes(excluding the virtio net header) of the GSO packets written into the RX VQ buffers. */
> +    le64 rx_reset;            /* The number of queue resets. */
> +
> +    /* tx stats */
> +    le64 tx_packets;          /* The number of packets sent by device (not the packets received from the guest), excluding the dropped packets by device. */
> +    le64 tx_bytes;            /* The number of bytes sent by device (not the packets received from the guest), excluding the dropped packets by device. */
> +
> +    le64 tx_notification;     /* The number of notifications from driver. */
> +    le64 tx_interrupt;        /* The number of interrupts generated by device. */
> +
> +    le64 tx_drop;             /* The number of packets dropped by the tx queue. Contains all kinds of packet drop. */
> +    le64 tx_drop_malformed;   /* The number of packets dropped when the descriptor is in an error state. */
> +
> +    le64 tx_csum_none;        /* The number of packets that doesn't require hardware csum. */
> +    le64 tx_csum_partial;     /* The number of packets that requires hardware csum. */
> +
> +    le64 tx_gso_packets;      /* The number of GSO packets that the device received from the driver. */
> +    le64 tx_gso_bytes;        /* The number of bytes(excluding the virtio net header) of GSO packets that the device received from the driver. */
> +    le64 tx_reset;            /* The number of queue resets. */
> +}
> +\end{lstlisting}
> +
> +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}
> +for more about \field{rx_reset} and \field{tx_reset}.
> +
> +All device stats are divided into three categories:
> +\begin{itemize}
> +    \item the stats of the device.
> +        \begin{description}
> +            \item[command] VIRTIO_NET_CTRL_STATS_GET_DEV
> +            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats_dev
> +        \end{description}
> +
> +    \item the stats of the controlq.
> +        \begin{description}
> +            \item[command] VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
> +            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats_cvq
> +        \end{description}
> +
> +    \item the stats of the queue pair. This contains the stats of rx and tx.
> +        \begin{description}
> +            \item[command] VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR
> +            \item[command-specific-data] virtio_net_ctrl_stats_queue_pair
> +            \item[command-specific-data-reply] virtio_net_ctrl_reply_stats_queue_pair
> +        \end{description}
> +\end{itemize}
> +
> +
> +\devicenormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +
> +If VIRTIO_NET_F_CTRL_STATS has been negotiated, the device MUST support the
> +VIRTIO_NET_CTRL_STATS_GET_DEV, VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ and
> +VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR commands.
> +
> +If \field{queue_pair_index} is out of range for a
> +VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command, the device MUST set \field{ack} in
> +virtio_net_ctrl to VIRTIO_NET_ERR.
> +
> +If VIRTIO_NET_F_GUEST_CSUM is not successfully negotiated, all csum related
> +metrics MUST be 0.
> +
> +GSO packet refers to the packet of gso_type != VIRTIO_NET_HDR_GSO_NONE.
> +All statistics on GSO MUST be based on the GSO packets.
> +
> +\drivernormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +
> +\field{command-specific-data} MUST be empty for VIRTIO_NET_CTRL_STATS_GET_DEV
> +and VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
>
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
> --
> 2.31.0
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

