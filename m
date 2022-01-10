Return-Path: <virtio-dev-return-9012-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAC06986254
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jan 2022 11:58:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220105024904.61740-1-xuanzhuo@linux.alibaba.com>
References: <20220105024904.61740-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 10 Jan 2022 12:57:53 +0100
Message-ID: <875yqrx0ou.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v7] virtio-net: support device stats
Content-Type: text/plain
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 05 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> This patch allows the driver to obtain some statistics from the device.
>
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
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
>  content.tex | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index cf20570..f99d663 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
> +    to the driver through the control channel.
> +

[More of a curiousity question. Is there any pattern to the feature bit
numbering for virtio-net? It seems that it is counting down from 63, but
bit 58 has been omitted? 55 is fine, though, I'm not asking to change it
:)]

>  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
>   (fragmenting the packet) the USO splits large UDP packet
>   to several segments when each of these smaller packets has UDP header.

> @@ -4504,6 +4510,121 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  See \ref{sec:Basic
>  Facilities of a Virtio Device / Virtqueues / Message Framing}.
>
> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +
> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> +get device stats from the device by \field{command-specific-data-reply}.

s/by/in/ ?

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

s/structure/structures/

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

s/device reset/device resets/

> +}
> +
> +struct virtio_net_ctrl_reply_stats_cvq {
> +    le64 request_num; // The number of requests.
> +    le64 ok_num;      // The number of ok ack.
> +    le64 err_num;     // The number of err ack.

s/ack/acks/ (x2)

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
> +    le64 rx_packets;          // The number of packets recived by device, include the droped packets by device.
> +    le64 rx_bytes;            // The number of bytes recived by device, include the droped packets by device.

s/include/including/ (x2)
s/droped/dropped/ (x2)

> +
> +    le64 rx_notification;     // The number of notifications from driver.
> +    le64 rx_interrupt;        // The number of interrupts generated by device.
> +
> +    le64 rx_drop;             // The number of packets dropped by the rx queue. Contains all kinds of packet drop.
> +    le64 rx_drop_overruns;    // The number of packets dropped by the rx queue when no more avail desc.

"...when no more descriptors were available" ?

> +    le64 rx_drop_oversize;    // The number of oversized packets received by the rx queue.
> +
> +    le64 rx_csum_valid;       // The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> +    le64 rx_csum_partial;     // The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> +    le64 rx_csum_bad;         // The number of packets with abnormal csum.
> +    le64 rx_csum_none;        // The number of packets without hardware csum.
> +
> +    le64 rx_gso_packets;      // The number of gso packets received by rx.
> +    le64 rx_gso_bytes;        // The number of gso bytes received by rx.
> +    le64 rx_reset;            // The number of queue resets.
> +
> +    /* tx stats */
> +    le64 tx_packets;          // The number of packets sent by device, excluding the droped packets by device.
> +    le64 tx_bytes;            // The number of bytes sent by device, excluding the droped packets by device.

s/droped/dropped/ (x2)

> +
> +    le64 tx_notification;     // The number of notifications from driver.
> +    le64 tx_interrupt;        // The number of interrupts generated by device.
> +
> +    le64 tx_drop;             // The number of packets dropped by the tx queue. Contains all kinds of packet drop.
> +    le64 tx_drop_desc_err;    // The number of packets dropped when desc is error.

"...when the descriptor is in an error state" ?

> +
> +    le64 tx_csum_none;        // The number of packets that doesn't require hardware csum.
> +    le64 tx_csum_partial;     // The number of packets that requires hardware csum.
> +
> +    le64 tx_gso_packets;      // The number of gso packets transmitted.
> +    le64 tx_gso_bytes;        // The number of gso bytes transmitted.
> +    le64 tx_reset;            // The number of queue resets.
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

I would list the corresponding structures for each category as well.

> +
> +\devicenormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +If VIRTIO_NET_F_CTRL_VQ is not negotiated, device MUST set the ack of
> +\field{virtio_net_ctrl} to VIRTIO_NET_ERR to reply VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.

If usage of the control vq has not been negotiated, where would the
driver send this command in the first place? I think we should drop this
statement.

> +
> +If the requested queue_pair_index is out of range, device MUST set the ack of \field{virtio_net_ctrl} to VIRTIO_NET_ERR;

"If \field{queue_pair_index} is out of range for a
VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command, the device MUST set
\field{ack} in virtio_net_ctrl to VIRTIO_NET_ERR." ?

Do we want to mandate that a device needs to support all three commands?
I.e. something like

"If VIRTIO_NET_F_CTRL_STATS has been negotiated, the device MUST support
the VIRTIO_NET_CTRL_STATS_GET_DEV, VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ,
and VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR commands."

> +
> +\drivernormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> +When driver sends a VIRTIO_NET_CTRL_STATS_GET_DEV command, \field{command-specific-data} MUST be empty.

s/driver/the driver/

> +The structure \field{virtio_net_ctrl_reply_stats_dev} MUST be used for \field{command-specific-data-reply}.

I don't think we need to put that into the normative sections; it should
be enough listing the command and the related structure together above.

> +
> +When driver sends a VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ command, \field{command-specific-data} MUST be empty.
> +The structure \field{virtio_net_ctrl_reply_stats_cvq} MUST be used for \field{command-specific-data-reply}.

Same here.

> +
> +Driver sends a VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command using \field{virtio_net_ctrl_stats_queue_pair} for \field{command-specific-data}.
> +At the same time, the structure \field{virtio_net_ctrl_reply_stats_queue_pair} MUST be used for \field{command-specific-data-reply}.
> +\field{queue_pair_index} specify the queue pair index of the queue that the driver wants to get stats.

Here as well; specifying which structures are used for each command does
not really need to be in a normative section, I believe.

This would collapse this whole normative section to a statement that
command-specific-data needs to be empty for GET_DEV and
GET_CTRL_VQ.

I believe you need to add references to these sections in
conformance.tex as well.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

