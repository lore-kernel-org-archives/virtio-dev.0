Return-Path: <virtio-dev-return-13409-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D9C001DC
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 11:18:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1309BC612F
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 11:18:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 077979866B6
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 11:18:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EB0979866B5; Wed, 26 Jul 2023 11:18:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D6CBD9866B4
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jul 2023 11:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -k_37H3DN2eByLDQTJJBsg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370286; x=1690975086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zAtU4M22eM2E+fXXZ+PtKVjEMlOoyIQb+pFfCUU52o=;
        b=WB+oIiEyoJmPIL/xvt+4HbqyIGWUSclWWbDah5YynM3YcMw+TQGKT8t8/Nch7cgbMw
         uQFDUXknpf3gaFoovnjR86/quC5iDqbX24Xs4zsm42cA7Aevn6z2v55uhS1VmZaPWUTG
         wVC58X0Ic1qkyokcAov2YF7LQPjkV0qZ/rCLdYk8oSwmmVjeabddm14Gq0S9gmkVcIZV
         L8JyQBlGU0tTqEMZcSm1KVSKuNRS90iC8Eido5NP+xOmK8Fvh1hyTc9VXQ+QnfqHZtAV
         OFoi+Yuj54lpfKLo8xCjwk8M5LIK7h0OzejMejGItIzrgk42aFYCHFXbn3F4Ux0AMwWN
         vvqg==
X-Gm-Message-State: ABy/qLYqtqDs9joR1cJ7NAiLbuAlcTkr7Sw7xtIQvyAybc490gnK+ilz
	+WRTLUdHf9tJg+5J7or/3l95iQniIABIxYbokmum63nOk6734gMJWIguU3w5RI5JovQNc6y1mRL
	aOk9+pzm30rjHelOCz+ay8miE1qje
X-Received: by 2002:a17:907:a056:b0:99b:bc51:8ca7 with SMTP id gz22-20020a170907a05600b0099bbc518ca7mr1494869ejc.1.1690370286611;
        Wed, 26 Jul 2023 04:18:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnZEnruc0a98tldFHelbKuODtP5u6ulQ2u7erPgcKwLxOaN5gDj3cln/IPb+pSnXQ18BCsAw==
X-Received: by 2002:a17:907:a056:b0:99b:bc51:8ca7 with SMTP id gz22-20020a170907a05600b0099bbc518ca7mr1494844ejc.1.1690370286058;
        Wed, 26 Jul 2023 04:18:06 -0700 (PDT)
Date: Wed, 26 Jul 2023 07:17:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	Parav Pandit <parav@nvidia.com>,
	virtio-comment@lists.oasis-open.org
Message-ID: <20230726070801-mutt-send-email-mst@kernel.org>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v13] virtio-net: support device stats

On Wed, Jul 26, 2023 at 04:12:29PM +0800, Xuan Zhuo wrote:
> This patch allows the driver to obtain some statistics from the device.
> 
> In the device implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> device. We hope to directly display it to the user through ethtool.
> 
> To get stats atomically, try to get stats for all queue pairs in one
> command.
> 
> If the feature is negotiated, the device must support all the stats
> listed in this commit. If we want add new stats in future, one new
> feature should be introduced.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

ok this needs a bunch of work on grammar but let's
start with the interface.


> ---
>  device-types/net/description.tex        | 365 +++++++++++++++++++++++-
>  device-types/net/device-conformance.tex |   1 +
>  device-types/net/driver-conformance.tex |   1 +
>  3 files changed, 364 insertions(+), 3 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 76585b0..fd7160a 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_DEVICE_STATS(50)] Device can provide device-level statistics
> +    to the driver through the control channel.
> +
>  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
>  
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> @@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>          u8 command;
>          u8 command-specific-data[];
>          u8 ack;
> +        u8 command-specific-data-reply[];
>  };
>  
>  /* ack values */
> @@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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
> +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specific-data-reply}.
>  
>  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> @@ -1805,6 +1811,359 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Upon reset, a device MUST initialize all coalescing parameters to 0.
>  
> +\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +If the VIRTIO_NET_F_DEVICE_STATS feature is negotiated, the driver can obtain
> +device stats from the device by using the following command.
> +
> +Different types of virtqueues have different stats. The stats of the receiveq
> +are different from those of the transmitq.
> +
> +The stats of a certain type of virtqueue are also divided into multiple types
> +because different types require different features. This enables the expansion
> +of new stats.
> +
> +At one time, the driver can obtain the stats of one or multiple virtqueues.
> +Additionally, the driver can obtain multiple type stats of each virtqueue.
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS         7
> +#define VIRTIO_NET_CTRL_STATS_GET     0
> +\end{lstlisting}
> +
> +To obtain device stats, use the VIRTIO_NET_CTRL_STATS_GET command with the
> +\field{command-specific-data} containing the virtio_net_ctrl_queue_stats
> +structure. The result is returned in the \field{command-specific-data-reply}.
> +
> +The following structure is used in \field{command-specific-data}:
> +\begin{lstlisting}
> +struct virtio_net_ctrl_queue_stats {
> +       struct {
> +           u16 vq_index;
> +           u48 padding;

there's no u48, use u16 padding[3];

> +
> +#define VIRTIO_NET_STATS_TYPE_CVQ       (1 << 0)
> +
> +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> +
> +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 2)
> +
> +           u64 types;


why don't we have a config space field for supported types?
more straight forward than complex rules...

> +       } stats[];
> +};
> +\end{lstlisting}
> +
> +The following structures are used in \field{command-specific-data-reply}:
> +\begin{lstlisting}
> +struct virtio_net_stats_cvq {
> +    le64 command_num;
> +    le64 ok_num;
> +};
> +
> +struct virtio_net_stats_rx_basic {
> +    le64 rx_packets;
> +    le64 rx_bytes;
> +
> +    le64 rx_notification;
> +    le64 rx_interrupt;
> +
> +    le64 rx_drop;
> +    le64 rx_drop_overruns;
> +    le64 rx_drop_busy;
> +};
> +
> +struct virtio_net_stats_rx_csum {
> +    le64 rx_csum_valid;
> +    le64 rx_needs_csum;
> +    le64 rx_csum_bad;
> +    le64 rx_csum_none;
> +};
> +
> +struct virtio_net_stats_rx_gso {
> +    le64 rx_gso_packets;
> +    le64 rx_gso_bytes;
> +    le64 rx_gso_packets_coalesced;
> +    le64 rx_gso_bytes_coalesced;
> +    le64 rx_gso_segments;
> +    le64 rx_gso_segments_bytes;
> +};
> +
> +struct virtio_net_stats_tx_basic {
> +    le64 tx_packets;
> +    le64 tx_bytes;
> +
> +    le64 tx_notification;
> +    le64 tx_interrupt;
> +
> +    le64 tx_drop;
> +    le64 tx_drop_malformed;
> +
> +    le64 tx_drop_busy;
> +};
> +
> +struct virtio_net_stats_tx_csum {
> +    le64 tx_csum_none;
> +    le64 tx_needs_csum;
> +};
> +
> +struct virtio_net_stats_tx_gso {
> +    le64 tx_gso_packets;
> +    le64 tx_gso_bytes;
> +    le64 tx_gso_packets_split;
> +    le64 tx_gso_bytes_split;
> +    le64 tx_gso_segments;
> +    le64 tx_gso_segments_bytes;
> +};
> +
> +\end{lstlisting}

So these are just tacked one after another?
I think it is better to add a size field, will
make it less error prone.


> +
> +\begin{description}
> +    \item [vq_index]
> +        The index of the virtqueue to obtain the stats.
> +
> +    \item [types]
> +        This is a bitmask of the types of stats to be obtained. Therefore, a
> +        \field{struct stats} inside virtio_net_ctrl_queue_stats may instruct
> +        multiple stats replies for the virtqueue.
> +\end{description}
> +
> +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> +
> +The structure corresponding to the controlq stats is virtio_net_stats_cvq.
> +
> +\begin{description}
> +    \item [command_num]
> +        The number of commands including the current command.
> +
> +    \item [ok_num]
> +        The number of commands (including the current command) where the ack was VIRTIO_NET_OK.
> +\end{description}
> +
> +
> +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Basic Stats}
> +
> +The structure corresponding to the receiveq basic stats is virtio_net_stats_rx_basic.
> +
> +Receiveq basic stats doesn't require any feature. As long as the device supports
> +VIRTIO_NET_F_DEVICE_STATS, the following are the receiveq basic stats.
> +
> +The packets described below are all steered to a specific virtqueue.
> +\begin{description}
> +    \item [rx_packets]
> +        This is the number of packets received by the device (not the packets
> +        passed to the guest). The count includes the packets dropped by the
> +        device.
> +
> +    \item [rx_bytes]
> +        This is the bytes of packets received by the device (not the packets
> +        passed to the guest). The count includes the packets dropped by the
> +        device.
> +
> +    \item [rx_notification]
> +        The number of driver notifications received by device for this receiveq.
> +
> +    \item [rx_interrupt]
> +        The number of device interrupts for this receiveq.
> +
> +    \item [rx_drop]
> +        This is the number of packets dropped by the device. The count includes
> +        all types of packets dropped by the device.
> +
> +    \item [rx_drop_overruns]
> +        This is the number of packets dropped by the device when no more
> +        descriptors were available.
> +
> +    \item [rx_drop_busy]
> +        This is the number of packets dropped by the device when the device is
> +        busy.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq Basic Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_BASIC is virtio_net_stats_tx_basic.
> +
> +Transmitq basic stats doesn't require any feature. As long as the device supports
> +VIRTIO_NET_F_DEVICE_STATS, the following are the transmitq basic stats.
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_packets]
> +        This is the number of packets sent by the device (not the packets
> +        got from the driver).
> +
> +    \item [tx_bytes]
> +        This is the bytes of packets sent by the device (not the packets
> +        got from the driver).
> +
> +    \item [tx_notification]
> +        The number of driver notifications for this transmitq.
> +
> +    \item [tx_interrupt]
> +        The number of device interrupts for this transmitq.
> +
> +    \item [tx_drop]
> +        The number of packets dropped by the device. The count includes all
> +        types of packets dropped by the device.
> +
> +    \item [tx_drop_malformed]
> +        The number of packets dropped by the device, when the descriptor is in
> +        an error state. For example, the buffer is too short.
> +
> +    \item [tx_drop_busy]
> +        The number of packets dropped by the device, when the device is busy.
> +
> +\end{description}
> +
> +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq CSUM Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_RX_CSUM is virtio_net_stats_rx_csum.
> +
> +Only after the VIRTIO_NET_F_GUEST_CSUM is negotiated, the receiveq csum stats
> +can be obtained.
> +
> +The packets described below are all steered to a specific virtqueue.
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
> +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq CSUM Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_CSUM is virtio_net_stats_tx_csum.
> +
> +Only after the VIRTIO_NET_F_CSUM is negotiated, the transmitq csum stats can be
> +obtained.
> +
> +The following are the transmitq csum stats:
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_csum_none]
> +        The number of packets that didn't require hardware csum.
> +
> +    \item [tx_needs_csum]
> +        The number of packets that required hardware csum.
> +
> +\end{description}
> +
> +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq GSO Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_RX_GSO is virtio_net_stats_rx_gso.
> +
> +If one or more of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, or
> +VIRTIO_NET_F_GUEST_UFO have been negotiated, the receiveq GSO stats can be
> +obtained.
> +
> +GSO packets refer to packets passed by the device to the driver where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The packets described below are all steered to a specific virtqueue.
> +\begin{description}
> +    \item [rx_gso_packets]
> +        The number of the GSO packets received by device.
> +
> +    \item [rx_gso_bytes]
> +        The bytes of the GSO packets received by device.
> +
> +    \item [rx_gso_packets_coalesced]
> +        The number of the GSO packets coalesced by device.
> +
> +    \item [rx_gso_bytes_coalesced]
> +        The bytes of the GSO packets coalesced by device.
> +
> +    \item [rx_gso_segments]
> +        The number of the segments that make up GSO packets.
> +
> +    \item [rx_gso_segments_bytes]
> +        The bytes of the segments that make up GSO packets.
> +
> +\end{description}
> +
> +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq GSO Stats}
> +
> +The structure corresponding to VIRTIO_NET_STATS_TYPE_TX_GSO is virtio_net_stats_tx_gso.
> +
> +If one or more of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
> +VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have
> +been negotiated, the transmitq GSO stats can be obtained.
> +GSO packets refer to packets passed by the driver to the device where
> +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> +
> +The packets described below are all from a specific virtqueue.
> +\begin{description}
> +    \item [tx_gso_packets]
> +        The number of the GSO packets sent by device that are not split to small
> +        packets.
> +
> +    \item [tx_gso_bytes]
> +        The bytes of the GSO packets sent by device that are not split to small
> +        packets.
> +
> +    \item [tx_gso_packets_split]
> +        The number of the GSO packets that been split to small packets.
> +
> +    \item [tx_gso_bytes_split]
> +        The bytes of the GSO packets that been split to small packets.
> +
> +    \item [tx_gso_segments]
> +        The number of segments split from the GSO packets.
> +
> +    \item [tx_gso_segments_bytes]
> +        The bytes of segments split from the GSO packets.

I am not sure I follow what all these split things are.
Needs more documentation.

> +\end{description}
> +
> +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +If virtio_net_ctrl_queue_stats is incorrect (such as the following), the device
> +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one error,
> +the device MUST fail the entire command.
> +\begin{itemize}
> +    \item \field{vq_index} exceeds the queue range.
> +    \item \field{types} contains unknown types.
> +    \item The type of vq does not match \field{types}. E.g. the driver tries to query
> +        receiveq stats by the index of a transmitq.
> +    \item The feature corresponding to the specified \field{types} was not negotiated.
> +    \item The size of the buffer allocated by the driver for \field{command-specific-data-reply}
> +        is less than the total size of the stats specialed by
> +        \field{virtio_net_ctrl_queue_stats}.
> +\end{itemize}
> +
> +The device MUST write the requested stats structures in
> +\field{command-specific-data-reply} in the order specified by the structure
> +virtio_net_ctrl_queue_stats. If the \field{types} instructs multiple stats, the
> +replies order by the type value from small to large.
> +
> +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> +
> +When a driver tries to obtain a certain stats, it MUST confirm that the relevant
> +features are negotiated.
> +
> +\field{types} in struct virtio_net_ctrl_queue_stats MUST correspond to the vq
> +specified by \field{vq_index}.
> +
> +The \field{command-specific-data-reply} buffer allocated by the driver MUST be
> +able to hold all the stats specified by virtio_net_ctrl_queue_stats.
> +
> +When the driver reads the replies, it MUST read
> +\field{command-specific-data-reply} one by one based on the \field{types}.
> +
>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  Types / Network Device / Legacy Interface: Framing Requirements}
>  
> diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
> index f88f48b..a0c63d6 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/driver-conformance.tex
> index 9d853d9..2f1c674 100644
> --- a/device-types/net/driver-conformance.tex
> +++ b/device-types/net/driver-conformance.tex
> @@ -15,4 +15,5 @@
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
>  \end{itemize}
> -- 
> 2.32.0.3.g01195cf9f


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

