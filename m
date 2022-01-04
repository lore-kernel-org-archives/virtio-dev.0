Return-Path: <virtio-dev-return-9004-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FC84986255
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jan 2022 04:00:09 +0000 (UTC)
MIME-Version: 1.0
References: <20211224033028.87307-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20211224033028.87307-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jan 2022 11:59:53 +0800
Message-ID: <CACGkMEur9pSn8ZqaKKH-V2cmhc9tVtfAQ3VRXd0HVaeBatJovg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v6] virtio-net: support device stats
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 24, 2021 at 11:30 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> This patch allows the driver to obtain some statistics from the device.
>
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
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
>  content.tex | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index cf20570..667f006 100644
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
> @@ -4023,7 +4028,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \end{lstlisting}
>
>  The \field{class}, \field{command} and command-specific-data are set by the
> -driver, and the device sets the \field{ack} byte. There is little it can
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}. There is little it can
>  do except issue a diagnostic if \field{ack} is not
>  VIRTIO_NET_OK.
>
> @@ -4504,6 +4510,114 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  See \ref{sec:Basic
>  Facilities of a Virtio Device / Virtqueues / Message Framing}.
>
> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +
> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> +get device stats from the device by \field{command-specific-data-reply}.
> +
> +To get the stats, the following definitions are used:
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS                  6
> +#define VIRTIO_NET_CTRL_STATS_GET_DEV          0
> +#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ      1
> +#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   2
> +\end{lstlisting}
> +
> +The following layout structure are used:
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
> +    le64 dev_reset;         // The number of device reset.
> +}
> +
> +struct virtio_net_ctrl_reply_stats_cvq {
> +    le64 request_num; // The number of requests.
> +    le64 ok_num;      // The number of ok ack.
> +    le64 err_num;     // The number of err ack.
> +
> +    le64 req_rx_promisc;         // The number of requests with command VIRTIO_NET_CTRL_RX_PROMISC.
> +    le64 req_rx_allmulti;        // The number of requests with command VIRTIO_NET_CTRL_RX_ALLMULTI.
> +    le64 req_rx_alluni;          // The number of requests with command VIRTIO_NET_CTRL_RX_ALLUNI.
> +    le64 req_rx_nomulti;         // The number of requests with command VIRTIO_NET_CTRL_RX_NOMULTI.
> +    le64 req_rx_nouni;           // The number of requests with command VIRTIO_NET_CTRL_RX_NOUNI.
> +    le64 req_rx_nobcast;         // The number of requests with command VIRTIO_NET_CTRL_RX_NOBCAST.
> +    le64 req_mac_table_set;      // The number of requests with command VIRTIO_NET_CTRL_MAC_TABLE_SET.
> +    le64 req_mac_addr_set;       // The number of requests with command VIRTIO_NET_CTRL_MAC_ADDR_SET.
> +    le64 req_vlan_add;           // The number of requests with command VIRTIO_NET_CTRL_VLAN_ADD.
> +    le64 req_vlan_del;           // The number of requests with command VIRTIO_NET_CTRL_VLAN_DEL.
> +    le64 req_announce_ack;       // The number of requests with command VIRTIO_NET_CTRL_ANNOUNCE_ACK.
> +    le64 req_mq_vq_pairs_set;    // The number of requests with command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
> +    le64 req_mq_rss_config;      // The number of requests with command VIRTIO_NET_CTRL_MQ_RSS_CONFIG.
> +    le64 req_mq_hash_config;     // The number of requests with command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> +    le64 req_guest_offloads_set; // The number of requests with command VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET.
> +}
> +
> +struct virtio_net_ctrl_reply_stats_queue_pair {
> +    /* rx stats */
> +    le64 rx_packets;
> +    le64 rx_bytes;

To be consistent I think we need comments for those two. E.g do we
count dropped packets/bytes there?

> +
> +    le64 rx_notification;     // The number of notification from driver.

"notifications from the driver"

> +    le64 rx_interrupt;        // The number of interrupt generated by device.

"interrupts generated by the device"

> +
> +    le64 rx_drop;             // The number of packets dropped by the rx queue. Contains all kinds of packet drop.
> +    le64 rx_drop_overruns;    // The number of packets dropped by the rx queue when no more avail desc.
> +    le64 rx_drop_oversize;    // The number of oversized packets received by the rx queue.
> +
> +    le64 rx_csum_valid;       // The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> +    le64 rx_csum_partial;     // The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> +    le64 rx_csum_bad;         // The number of packets with abnormal csum.
> +    le64 rx_csum_none;        // The number of packets without hardware csum.
> +
> +    le64 rx_gso_packets;      // The number of gso packets received by rx.
> +    le64 rx_gso_bytes;        // The number of gso bytes received by rx.
> +
> +    /* tx stats */
> +    le64 tx_packets;
> +    le64 tx_bytes;

Need comments here.

> +
> +    le64 tx_notification;     // The number of notification from driver.

"notification from the driver"

> +    le64 tx_interrupt;        // The number of interrupt generated by device.

"interrupts generated by the device"

> +
> +    le64 tx_drop;             // The number of packets dropped by the tx queue. Contains all kinds of packet drop.
> +    le64 tx_drop_desc_err;    // The number of packets dropped when desc is error.
> +
> +    le64 tx_csum_none;        // The number of packets that doesn't require hardware csum.
> +    le64 tx_csum_partial;     // The number of packets that requires hardware csum.
> +
> +    le64 tx_gso_packets;      // The number of gso packets transmitted.
> +    le64 tx_gso_bytes;        // The number of gso bytes transmitted.
> +}
> +\end{lstlisting}
> +
> +All device stats are divided into three categories:
> +\begin{itemize}
> +    \item the stats of the device. (command: VIRTIO_NET_CTRL_STATS_GET_DEV)
> +    \item the stats of the controlq. (command: VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ)
> +    \item the stats of the queue pair. This contains the stats of rx and tx.
> +        (command: VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR)
> +\end{itemize}
> +
> +When driver sends a VIRTIO_NET_CTRL_STATS_GET_DEV command, \field{command-specific-data} MUST be empty.
> +The structure \field{virtio_net_ctrl_reply_stats_dev} MUST be used for \field{command-specific-data-reply}.

keywords like "MUST" should be used in the device normative or driver
normative part.

> +
> +When driver sends a VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ command, \field{command-specific-data} MUST be empty.
> +The structure \field{virtio_net_ctrl_reply_stats_cvq} MUST be used for \field{command-specific-data-reply}.
> +If VIRTIO_NET_F_CTRL_VQ is not negotiated, device MUST set the ack of \field{virtio_net_ctrl} to VIRTIO_NET_ERR;
> +
> +Driver sends a VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command using \field{virtio_net_ctrl_stats_queue_pair} for \field{command-specific-data}.
> +At the same time, the structure \field{virtio_net_ctrl_reply_stats_queue_pair} MUST be used for \field{command-specific-data-reply}.
> +\field{queue_pair_index} specify the queue pair index of the queue that the driver wants to get stats.
> +If the requested queue_pair_index is out of range, device MUST set the ack of \field{virtio_net_ctrl} to VIRTIO_NET_ERR;
> +

So I suggest moving the case where VIRTIO_NET_ERR to device normative.
And tweak the rest as guidance by not using "MUST" keywords.

Thanks

>  \section{Block Device}\label{sec:Device Types / Block Device}
>
>  The virtio block device is a simple virtual block device (ie.
> --
> 2.31.0
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

