Return-Path: <virtio-dev-return-8990-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7305C986338
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Dec 2021 03:07:41 +0000 (UTC)
MIME-Version: 1.0
message-id: <1638760027.206086-2-xuanzhuo@linux.alibaba.com>
date: Mon, 06 Dec 2021 11:07:07 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <20210928091340.78554-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v4] virtio-net: support device stats
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 28 Sep 2021 17:13:40 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

Hi, everybody, is there anything else I need to do with this patch? When will
this patch be merged into, so that I can carry out follow-up work.

Thanks.

> This patch allows the driver to obtain some statistics from the device.
>
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
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
>
>  content.tex | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/content.tex b/content.tex
> index 7cec1c3..ad8d781 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2972,6 +2972,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
> +    to the driver through the control channel.
> +
>  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
>   (fragmenting the packet) the USO splits large UDP packet
>   to several segments when each of these smaller packets has UDP header.
> @@ -3017,6 +3020,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \end{description}
> @@ -3895,6 +3899,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>          u8 command;
>          u8 command-specific-data[];
>          u8 ack;
> +        u8 command-specific-data-reply[];
>  };
>
>  /* ack values */
> @@ -3903,7 +3908,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \end{lstlisting}
>
>  The \field{class}, \field{command} and command-specific-data are set by the
> -driver, and the device sets the \field{ack} byte. There is little it can
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}. There is little it can
>  do except issue a diagnostic if \field{ack} is not
>  VIRTIO_NET_OK.
>
> @@ -4384,6 +4390,76 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
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
> +#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   1
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
> +    le64 dev_version;		// The number of device version.
> +    le64 dev_reset;			// The number of device reset.
> +}
> +
> +struct virtio_net_ctrl_reply_stats_queue_pair {
> +    le64 queue_pair_index;
> +    le64 rx_inter;			// The number of interrupts sent by the rx queue.
> +    le64 rx_drop;			// The number of packets dropped by the rx queue. Contains all kinds of packet loss.
> +    le64 rx_drop_overruns;	// The number of packets dropped by the rx queue when no more avail desc.
> +    le64 rx_csum_bad;		// The number of packets with abnormal csum in the rx queue.
> +    le64 rx_gso_packets;	// The number of gso packets received by rx.
> +    le64 rx_gso_bytes;		// The number of gso bytes received by rx.
> +    le64 rx_oversize_pkts;	// The number of oversized packets received by the rx queue.
> +    le64 tx_inter;			// The number of interrupts sent by the tx queue.
> +    le64 tx_drop;			// The number of packets dropped by the tx queue. Contains all kinds of packet loss.
> +    le64 tx_csum;			// The number of packets that completes csum by the device.
> +    le64 tx_gso_packets;	// The number of gso packets transmitted.
> +    le64 tx_gso_bytes;		// The number of gso bytes transmitted.
> +}
> +\end{lstlisting}
> +
> +All device stats is divided into two categories, one is the stats of the device,
> +and the other is the stats of the queue pair. The queue pair stats contains the
> +stats of rx and tx.
> +
> +The command VIRTIO_NET_CTRL_STATS_GET_DEV is used to obtain the stats of the device.
> +The command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR is used to obtain the stats of the queue pair.
> +
> +When the driver uses the command VIRTIO_NET_CTRL_STATS_GET_DEV,
> +\field{command-specific-data} MUST be empty. The structure
> +\field{virtio_net_ctrl_reply_stats_dev} MUST be used as
> +\field{command-specific-data-reply}.
> +
> +When the driver uses the command VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR,
> +\field{command-specific-data} MUST be \field{virtio_net_ctrl_stats_queue_pair}. At the same
> +time, the structure \field{virtio_net_ctrl_reply_stats_queue_pair} MUST be used as
> +\field{command-specific-data-reply}.
> +\field{virtio_net_ctrl_stats_queue_pair.queue_pair_index} specify the queue pair
> +index of the queue that the driver wants to get stats.
> +
> +The device MUST set \field{command-specific-data-reply} based on command.
> +
> +When the command is VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR, the device MUST set
> +\field{virtio_net_ctrl_reply_stats_queue_pair.queue_pair_index} equal to
> +\field{virtio_net_ctrl_stats_queue_pair.queue_pair_index}
> +
>  \section{Block Device}\label{sec:Device Types / Block Device}
>
>  The virtio block device is a simple virtual block device (ie.
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

