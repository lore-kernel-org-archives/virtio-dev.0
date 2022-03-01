Return-Path: <virtio-dev-return-9332-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 089B798646D
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 11:06:06 +0000 (UTC)
Date: Tue, 1 Mar 2022 06:05:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220301054557-mutt-send-email-mst@kernel.org>
References: <20220301083446.55424-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220301083446.55424-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support device stats
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 01, 2022 at 04:34:46PM +0800, Xuan Zhuo wrote:
> This patch allows the driver to obtain some statistics from the device.
> 
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
> 
> To get stats atomically, try to get stats for all queue pairs in one
> command.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v10:
> 1. use description/item for the item of the queue pair
> 2. use one command to get the stats of all queue pairs

This didn't really address extensibility concerns.
Pls look them up in previous version review.
Additional comments below but I'm not repeating what I
already said there.

> 
> v8:
> 1. Modified based on comments by Cornelia Huck
> 
> v7:
> 1. add rx_reset, tx_reset
> 2. add device normative and dirver normative
> 3. add comments for *_packets, *_bytres
> 
> v6:
> 1. correct the names and descriptions of some stats items
> 
> v5:
> 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
> 2. more item for virtio_net_ctrl_reply_stats_queue_pair
> 
> v4:
> 1. remove dev_stats_num, {rx|tx}_stats_num
> 2. Use two commands to get the stats of queue pair and dev respectively
> 
> v3 changes:
> 1. add dev_version
> 2. use queue_pair_index replace rx_num, tx_num
> 3. Explain the processing when the device and driver support different numbers
> of stats
> 
>  conformance.tex |   2 +
>  content.tex     | 289 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 288 insertions(+), 3 deletions(-)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 42f8537..c67f877 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> 
>  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> 
>  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index c6f116c..2363b74 100644
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
> +These commands VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ and
> +VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR contain
> +\field{command-specific-data-reply}.
> 
>  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> @@ -4471,6 +4480,280 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  according to the native endian of the guest rather than
>  (necessarily when not using the legacy interface) little-endian.
> 
> +\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> +get device stats from the device in \field{command-specific-data-reply}.




> +
> +To get the stats, the following definitions are used:
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS                 6
> +#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ     0

CTRL twice is confusing.

> +#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR  1
> +\end{lstlisting}
> +
> +The following layout structures are used:
> +
> +\field{command-specific-data}
> +\begin{lstlisting}
> +struct virtio_net_ctrl_stats_queue_pair {
> +    le64 length;
> +}
> +\end{lstlisting}
> +
> +\field{command-specific-data-reply}
> +\begin{lstlisting}
> +struct virtio_net_ctrl_reply_stats_cvq {
> +    le64 command_num;
> +    le64 ok_num;
> +}
> +
> +struct virtio_net_stats_queue_pair {
> +    le64 queue_pair_index;
> +
> +    /* rx stats */

Please eschew abbreviation especially in comments.

> +    le64 rx_packets;
> +    le64 rx_bytes;
> +
> +    le64 rx_notification;
> +    le64 rx_interrupt;
> +
> +    le64 rx_drop;
> +    le64 rx_drop_overruns;
> +
> +    /* rx csum stats */

same as rx csum counters below?

same comment elsewhere.

> +    le64 rx_csum_valid;
> +    le64 rx_needs_csum;
> +    le64 rx_csum_bad;
> +    le64 rx_csum_none;
> +
> +    /* rx gso stats */
> +    le64 rx_gso_packets;
> +    le64 rx_gso_bytes;
> +
> +    /* rx reset */
> +    le64 rx_reset;
> +
> +    /* tx stats */
> +    le64 tx_packets;
> +    le64 tx_bytes;
> +
> +    le64 tx_notification;
> +    le64 tx_interrupt;
> +
> +    le64 tx_drop;
> +    le64 tx_drop_malformed;
> +
> +    /* tx csum stats */
> +    le64 tx_csum_none;
> +    le64 tx_needs_csum;
> +
> +    /* rx gso stats */


how are these rx gso stats?

> +    le64 tx_gso_packets;
> +    le64 tx_gso_bytes;
> +
> +    /* rx stats */
> +    le64 tx_reset;
> +}

So now that we get multiple stats in one go, why handle queues
in pairs?

> +
> +struct virtio_net_ctrl_reply_stats_queue_pair {
> +    struct virtio_net_stats_queue_pair stats[];
> +}

I would probably just do something like the following:


struct virtio_net_ctrl_queue_stats {
	u32 nstats;
	struct {
	    u16 queue_num;
	    u16 type;
	} stats[];
};

and just make all stats be the same size.

device then just takes length and divides by nstats.

or an alternative:

struct virtio_net_ctrl_queue_stats {
	u16 nstats;
	struct {
	    u16 queue_num;
	    u16 type;
	    u16 length;
	} stats[];
};

the disadvantage here is that sum of lengths needs to equal buffer size
then, and there's an interplay between length and struct alignment.
Maybe we should ask that length is a multiple of 8? All of this is
something drivers can get wrong :(.

we also need to document that length can extend structure size,
and then specify what should device and driver do with extra data.


After this, type can group things together, e.g. drop stats,
gso stats, etc. we also do not need to duplicate tx and rx
since it is implicit in queue number. control queue
stats can also use control vq number.


> +
> +\end{lstlisting}
> +
> +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> +
> +To get controlq stats use command VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
> +The result is returned as struct virtio_net_ctrl_reply_stats_cvq in \field{command-specific-data-reply}.
> +
> +\begin{description}
> +    \item [command_num]
> +        The number of commands, including the current command.
> +
> +    \item [ok_num]
> +        The number of commands (including the current command) where the ack was VIRTIO_NET_OK.
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: Get}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: Get}
> +
> +Get queue pair stats using command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR and
> +\field{command-specific-data} filled by struct virtio_net_ctrl_stats_queue_pair.
> +
> +The result is returned as struct virtio_net_ctrl_reply_stats_queue_pair in \field{command-specific-data-reply}.
> +
> +The \field{length} in virtio_net_ctrl_stats_queue_pair is used to tell the backend the
> +size of the \field{command-specific-data-reply}.

First please do not come up with your own terminology. There's no
backend in the spec, there's a device and a driver.

Second I don't see why this is necessary.


> +
> +\subparagraph{Virtqueue Pair Stats: Basic}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: Basic}
> +
> +Basic stats doesn't need any features, as long as the device supports
> +VIRTIO_NET_F_CTRL_STATS. The following are the basic stats.
> +
> +\begin{description}
> +    \item [queue_pair_index]
> +        The index of the current queue pair.
> +
> +    \item [rx_packets]
> +        The number of packets received by device (not the packets passed to the
> +        guest), including the dropped packets by device.
> +
> +    \item [rx_bytes]
> +        The number of bytes received by device (not the packets passed to the
> +        guest), including the dropped packets by device.
> +
> +    \item [rx_notification]
> +        The number of driver notifications.
> +
> +    \item [rx_interrupt]
> +        The number of device interrupts.
> +
> +    \item [rx_drop]
> +        The number of packets dropped by the rx queue. Contains all kinds of
> +        packet drop.
> +
> +    \item [rx_drop_overruns]
> +        The number of packets dropped by the rx queue when no more descriptors
> +        were available.
> +
> +    \item [tx_packets]
> +        The number of packets sent by device (not the packets received from the
> +        guest), excluding the dropped packets by device.
> +
> +    \item [tx_bytes]
> +        The number of bytes sent by device (not the packets received from the
> +        guest), excluding the dropped packets by device.
> +
> +    \item [tx_notification]
> +        The number of driver notifications.
> +
> +    \item [tx_interrupt]
> +        The number of device interrupts.
> +
> +    \item [tx_drop]
> +        The number of packets dropped by the tx queue. Contains all kinds of
> +        packet drop.
> +
> +    \item [tx_drop_malformed]
> +        The number of packets dropped when the descriptor is in an error state.
> +        For example, the buffer is too short.
> +
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: RX CSUM}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: RX CSUM}
> +
> +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the rx csum
> +counters are meaningful.
> +
> +The following are the rx csum counters:
> +
> +\begin{description}
> +    \item [rx_csum_valid]
> +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> +
> +    \item [rx_needs_csum]
> +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> +
> +    \item [rx_csum_bad]
> +        The number of packets with abnormal csum.
> +
> +    \item [rx_csum_none]
> +        The number of packets without hardware csum. The packet here refers to
> +        the non-TCP/UDP packet that the backend cannot recognize.
> +
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: TX CSUM}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: TX CSUM}
> +
> +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the tx csum
> +counters are meaningful.
> +
> +The following are the tx csum counters:
> +
> +\begin{description}
> +    \item [tx_csum_none]
> +        The number of packets that didn't require hardware csum.
> +
> +    \item [tx_needs_csum]
> +        The number of packets that required hardware csum.
> +
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: RX GSO}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: RX GSO}
> +
> +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> +been negotiated, rx gso counters are meaningful.
> +
> +Rx gso packets refer to packets passed by the device to the driver where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The statistics of the following rx gso counters are based on the rx gso packet.
> +The device may receive multiple small packets, and finally combine them into one
> +rx gso packet and pass it to the driver. It is also possible to receive a gso
> +packet and pass it directly to the driver. We should count the information of
> +the rx gso packet that is finally passed to the driver (such as number and
> +bytes). Instead of the information of the small packet.
> +
> +\begin{description}
> +    \item [rx_gso_packets]
> +        The number of the rx gso packets.
> +
> +    \item [rx_gso_bytes]
> +        The number of bytes(excluding the virtio net header) of the rx gso packets.
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: TX GSO}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: TX GSO}
> +
> +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> +been negotiated, tx gso counters are meaningful.
> +
> +Rx gso packets refer to packets passed by the driver to the device where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The statistics of the following tx gso counters are based on the tx gso packet.
> +The device may receive a gso packet from the driver, and then may split it into
> +multiple small packets or send the gso packet directly. But the device counts
> +the information of the gso packet received from the driver (such as the number
> +and bytes). Instead of the packet information after splitting.
> +
> +\begin{description}
> +    \item [tx_gso_packets]
> +        The number of the rx gso packets.
> +
> +    \item [tx_gso_bytes]
> +        The number of bytes(excluding the virtio net header) of the rx gso packets.
> +\end{description}
> +
> +\subparagraph{Virtqueue Pair Stats: Queue Reset}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Virtqueue Pair Stats: Queue Reset}
> +
> +Only when VIRTIO_F_RING_RESET is successfully negotiated, the reset counters
> +are meaningful.
> +
> +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}
> +for more about \field{rx_reset} and \field{tx_reset}.
> +
> +\begin{description}
> +    \item [rx_reset]
> +        The number of queue resets.
> +
> +    \item [tx_reset]
> +        The number of queue resets.
> +\end{description}
> +
> +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +For the command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR, the device MUST fill in
> +\field{command-specific-data-reply} starting from the stats of the 0th
> +virtuqueue pair.
> +
> +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +\field{command-specific-data} MUST be empty for VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
> +
> +For the command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR, the size of the
> +\field{command-specific-data-reply} allocated by the driver SHOULD be the size
> +of the struct virtio_net_stats_queue_pair times the number of virtqueue pairs
> +currently in use.
> 
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
> --
> 2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

