Return-Path: <virtio-dev-return-13346-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE193EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 11:54:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 226C9157EEC
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 11:54:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D972C9867B4
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 11:54:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF12D986663; Wed, 12 Jul 2023 11:54:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC5B9986682
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 11:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ADsksLl8OMi649igvFDLAw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162851; x=1691754851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhvkhZajkBHXABvKfCGoYT5Jm+UzVF+RBxvbxo7ZMBA=;
        b=b2ikeGmJMZSsoXtWsLC3GYHy49TjUydbbATpzlKDNCyZC8/T/SXqMoNocKEhqKE7fb
         Za2tJYIHYcavk7gYp6XFgCzHKOG8nfP4s9EFkabLuqtnRj0j6NnP5OD6nRAOeR4OdyKN
         cYfEAHWPuguJiHNdCL0bYCc3Qd3UCho5uVpKUu25cbMTXyws9sVGpr2NYexlZ9K0BuZ+
         SzRd/mlkKT0udFD8sppw/Fchf801Z91bMJ8AnVLGWEQNPm9IwRKF73jFU68jvhLEAzgw
         R/73hfZ4KVREJZfHHGGc7VyCaaO5M+rWniXesA/6NkTVnmresWfoHSFFiZ2seaWH8Z6T
         5LVA==
X-Gm-Message-State: ABy/qLa4wduVbHzTtrYmmrzG2jXupYKjiKLhCBqjjVXzOamX1Id1nihC
	uFYmbjkw9Ah8FMDjl2qbbvvq4Ta2N8dID60XXvw54vuERnQlxEiwtMcc5Ea6iujNu/1yoBf/6OP
	L+cIobFI9BacnVhaFD4IQoGeh2RrG
X-Received: by 2002:adf:ee0f:0:b0:315:9d61:6e66 with SMTP id y15-20020adfee0f000000b003159d616e66mr8806714wrn.9.1689162851568;
        Wed, 12 Jul 2023 04:54:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmEE7e5lKnmRH/wD7tytr859vcFzTGKG6p6vWbBcyq+zmFxjyAjXw8ALzqyPLAsRa6bDbldg==
X-Received: by 2002:adf:ee0f:0:b0:315:9d61:6e66 with SMTP id y15-20020adfee0f000000b003159d616e66mr8806693wrn.9.1689162851123;
        Wed, 12 Jul 2023 04:54:11 -0700 (PDT)
Date: Wed, 12 Jul 2023 07:54:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230712075319-mutt-send-email-mst@kernel.org>
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12] virtio-net: support device stats

On Wed, Jul 12, 2023 at 07:44:01PM +0800, Xuan Zhuo wrote:
> On Wed, 12 Jul 2023 07:34:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Mar 15, 2022 at 11:24:02AM +0800, Xuan Zhuo wrote:
> > > This patch allows the driver to obtain some statistics from the device.
> > >
> > > In the back-end implementation, we can count a lot of such information,
> > > which can be used for debugging and judging the running status of the
> > > back-end. We hope to directly display it to the user through ethtool.
> > >
> > > To get stats atomically, try to get stats for all queue pairs in one
> > > command.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Functionally, I think this is close to ok now.  But the text needs
> > of work.  Are you trying to target 1.3 with this?
> 
> I personally worry about that 1.3 may be too late, if possible, I would like to
> respond as soon as possible.
> 
> I really don't really care if it can get into 1.3 or not but I do hope that this
> can be done as soon as possible.
> 
> Thanks.

Yes we were supposed to freeze for 1.3. This change can be merged on a
main branch after 1.3 forks and is under review.


> 
> >
> > Feedback from other hw vendors would be nice. Parav could you take
> > a look and say whether the list of counters seems rich enough for
> > you? Any counters you'd like to add?
> >
> >
> > > ---
> > >  conformance.tex |   2 +
> > >  content.tex     | 406 +++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 405 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 42f8537..c67f877 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> > >  \end{itemize}
> > >
> > >  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> > > @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> > > +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> > >  \end{itemize}
> > >
> > >  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> > > diff --git a/content.tex b/content.tex
> > > index c6f116c..81f325d 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > >      channel.
> > >
> > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
> > > +    to the driver through the control channel.
> > > +
> > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
> > >   (fragmenting the packet) the USO splits large UDP packet
> > >   to several segments when each of these smaller packets has UDP header.
> > > @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> > >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \end{description}
> > > @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >          u8 command;
> > >          u8 command-specific-data[];
> > >          u8 ack;
> > > +        u8 command-specific-data-reply[];
> > >  };
> > >
> > >  /* ack values */
> > > @@ -4023,9 +4028,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >  \end{lstlisting}
> > >
> > >  The \field{class}, \field{command} and command-specific-data are set by the
> > > -driver, and the device sets the \field{ack} byte. There is little it can
> > > -do except issue a diagnostic if \field{ack} is not
> > > -VIRTIO_NET_OK.
> > > +driver, and the device sets the \field{ack} byte and optionally
> > > +\field{command-specific-data-reply}. There is little the driver can
> > > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > > +
> > > +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specific-data-reply}.
> > >
> > >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> > >  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > @@ -4471,6 +4478,399 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >  according to the native endian of the guest rather than
> > >  (necessarily when not using the legacy interface) little-endian.
> > >
> > > +\paragraph{Device Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> > > +
> > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> > > +get the device stats from the device in \field{command-specific-data-reply}.
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
> > > +Use the command VIRTIO_NET_CTRL_STATS_GET and \field{command-specific-data}
> > > +containing struct virtio_net_ctrl_queue_stats to get the device stats.
> > > +The result is returned by \field{command-specific-data-reply}.
> > > +The stats ware returned in the order of the type specified in the
> > > +\field{virtio_net_ctrl_queue_stats}.
> > > +
> > > +The following layout structures are used:
> > > +
> > > +\field{command-specific-data}
> > > +\begin{lstlisting}
> > > +struct virtio_net_ctrl_queue_stats {
> > > +	u16 nstats;
> > > +	struct {
> > > +	    u16 queue_num;
> > > +	    u16 type;
> > > +	} stats[];
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
> > > +    le64 rx_gso_packets_coalesced;
> > > +    le64 rx_gso_bytes_coalesced;
> > > +    le64 rx_gso_segments;
> > > +    le64 rx_gso_segments_bytes;
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
> > > +    le64 tx_gso_packets_split;
> > > +    le64 tx_gso_bytes_split;
> > > +    le64 tx_gso_segments;
> > > +    le64 tx_gso_segments_bytes;
> > > +};
> > > +
> > > +struct virtio_net_stats_tx_reset {
> > > +    le64 tx_reset;
> > > +};
> > > +
> > > +\end{lstlisting}
> > > +
> > > +\begin{description}
> > > +    \item [nstats]
> > > +        The number of \field{stats}.
> > > +
> > > +    \item [queue_num]
> > > +        The number of the virtqueue to obtain the statistics.
> > > +
> > > +    \item [type]
> > > +        The type of the stats to be obtained.
> > > +
> > > +\end{description}
> > > +
> > > +Correspondence between the vq type, the stats type, the stats structure and the
> > > +required features.
> > > +\begin{tabular}{ |l|l|l|l| }
> > > +    \hline
> > > +    VQ Type                  & Stats Type                     & Stats Structure           & Features \\ \hline
> > > +
> > > +    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      & virtio_net_stats_cvq      & \\ \hline
> > > +
> > > +    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC & virtio_net_stats_rx_basic & \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  & virtio_net_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_GSO   & virtio_net_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4 or\newline
> > > +                                                                                            VIRTIO_NET_F_GUEST_TSO6 or\newline
> > > +                                                                                            VIRTIO_NET_F_GUEST_UFO    \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_RX_RESET & virtio_net_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
> > > +
> > > +    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC & virtio_net_stats_tx_basic & \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  & virtio_net_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_GSO   & virtio_net_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4 or\newline
> > > +                                                                                            VIRTIO_NET_F_HOST_TSO6 or\newline
> > > +                                                                                            VIRTIO_NET_F_HOST_USO  or\newline
> > > +                                                                                            VIRTIO_NET_F_HOST_UFO  \\ \cline{2-4}
> > > +                             & VIRTIO_NET_STATS_TYPE_TX_RESET & virtio_net_stats_tx_reset & VIRTIO_F_RING_RESET \\
> > > +    \hline
> > > +\end{tabular}
> > > +
> > > +
> > > +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> > > +
> > > +The structure corresponding to the controlq stats is virtio_net_stats_cvq.
> > > +
> > > +\begin{description}
> > > +    \item [command_num]
> > > +        The number of commands, including the current command.
> > > +
> > > +    \item [ok_num]
> > > +        The number of commands (including the current command) where the ack was VIRTIO_NET_OK.
> > > +\end{description}
> > > +
> > > +
> > > +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Basic Stats}
> > > +
> > > +The structure corresponding to the receiveq basic stats is virtio_net_stats_rx_basic.
> > > +
> > > +Receiveq basic stats doesn't need any features, as long as the device supports
> > > +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stats.
> > > +
> > > +\begin{description}
> > > +    \item [rx_packets]
> > > +        The number of packets received by device (not the packets passed to the
> > > +        guest), including the dropped packets by device.
> > > +
> > > +    \item [rx_bytes]
> > > +        The number of bytes received by device (not the packets passed to the
> > > +        guest), including the dropped packets by device.
> > > +
> > > +    \item [rx_notification]
> > > +        The number of driver notifications.
> > > +
> > > +    \item [rx_interrupt]
> > > +        The number of device interrupts.
> > > +
> > > +    \item [rx_drop]
> > > +        The number of packets dropped by the receiveq. Contains all kinds of
> > > +        packet drop.
> > > +
> > > +    \item [rx_drop_overruns]
> > > +        The number of packets dropped by the receiveq when no more descriptors
> > > +        were available.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq Basic Stats}
> > > +
> > > +The structure corresponding to the transmitq basic stats is virtio_net_stats_tx_basic.
> > > +
> > > +Transmitq basic stats doesn't need any features, as long as the device supports
> > > +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic stats.
> > > +
> > > +\begin{description}
> > > +    \item [tx_packets]
> > > +        The number of packets sent by device (not the packets got from the
> > > +        guest), excluding the dropped packets by device.
> > > +
> > > +    \item [tx_bytes]
> > > +        The number of bytes sent by device (not the packets got from the
> > > +        guest), excluding the dropped packets by device.
> > > +
> > > +    \item [tx_notification]
> > > +        The number of driver notifications.
> > > +
> > > +    \item [tx_interrupt]
> > > +        The number of device interrupts.
> > > +
> > > +    \item [tx_drop]
> > > +        The number of packets dropped by the transmitq. Contains all kinds of
> > > +        packet drop.
> > > +
> > > +    \item [tx_drop_malformed]
> > > +        The number of packets dropped when the descriptor is in an error state.
> > > +        For example, the buffer is too short.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq CSUM Stats}
> > > +
> > > +The structure corresponding to the receiveq csum stats is virtio_net_stats_rx_csum.
> > > +
> > > +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the receiveq
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
> > > +        The number of packets without hardware csum. The packet here refers to
> > > +        the non-TCP/UDP packet that the backend cannot recognize.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq CSUM Stats}
> > > +
> > > +The structure corresponding to the transmitq csum stats is virtio_net_stats_tx_csum.
> > > +
> > > +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the transmitq csum
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
> > > +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq GSO Stats}
> > > +
> > > +The structure corresponding to the receiveq gso stats is virtio_net_stats_rx_gso.
> > > +
> > > +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> > > +been negotiated, the receiveq gso stats can be obtained.
> > > +
> > > +Rx gso packets refer to packets passed by the device to the driver where
> > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > +
> > > +\begin{description}
> > > +    \item [rx_gso_packets]
> > > +        The number of the rx gso packets.
> > > +
> > > +    \item [rx_gso_bytes]
> > > +        The number of bytes(excluding the virtio net header) of the rx gso packets.
> > > +
> > > +    \item [rx_gso_packets_coalesced]
> > > +        The number of the rx gso packages generated by coalescing.
> > > +
> > > +    \item [rx_gso_bytes_coalesced]
> > > +        The number of bytes(excluding the virtio net header) of the rx gso packets generated by coalescing.
> > > +
> > > +    \item [rx_gso_segments]
> > > +        The number of coalesced segments.
> > > +
> > > +    \item [rx_gso_segments_bytes]
> > > +        The number of bytes of coalesced segments.
> > > +
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq GSO Stats}
> > > +
> > > +The structure corresponding to the transmitq gso stats is virtio_net_stats_tx_gso.
> > > +
> > > +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> > > +been negotiated, the transmitq gso stats can be obtained.
> > > +
> > > +Tx gso packets refer to packets passed by the driver to the device where
> > > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > > +
> > > +\begin{description}
> > > +    \item [tx_gso_packets]
> > > +        The number of the tx gso packets.
> > > +
> > > +    \item [tx_gso_bytes]
> > > +        The number of bytes(excluding the virtio net header) of the tx gso packets.
> > > +
> > > +    \item [tx_gso_packets_split]
> > > +        The number of the tx gso packets that been split.
> > > +
> > > +    \item [tx_gso_bytes_split]
> > > +        The number of bytes(excluding the virtio net header) of the tx gso packets that been split.
> > > +
> > > +    \item [tx_gso_segments]
> > > +        The number of segments split from the gso package.
> > > +
> > > +    \item [tx_gso_segments_bytes]
> > > +        The number of bytes(excluding the virtio net header) of segments split from the gso package.
> > > +\end{description}
> > > +
> > > +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Reset Stats}
> > > +
> > > +The structure corresponding to the receiveq reset stats is virtio_net_stats_rx_reset.
> > > +
> > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the receiveq reset stats
> > > +can be obtained.
> > > +
> > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}
> > > +for more about \field{rx_reset}.
> > > +
> > > +\begin{description}
> > > +    \item [rx_reset]
> > > +        The number of receiveq resets.
> > > +\end{description}
> > > +
> > > +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats / Transmitq Reset Stats}
> > > +
> > > +The structure corresponding to the transmitq reset stats is virtio_net_stats_tx_reset.
> > > +
> > > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the transmitq reset stats
> > > +can be obtained.
> > > +
> > > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}
> > > +for more about \field{tx_reset}.
> > > +
> > > +\begin{description}
> > > +    \item [tx_reset]
> > > +        The number of transmitq resets.
> > > +\end{description}
> > > +
> > > +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> > > +
> > > +If virtio_net_ctrl_queue_stats is incorrect (such as the following), the device
> > > +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one error,
> > > +the device MUST abort the entire command.
> > > +\begin{itemize}
> > > +    \item \field{queue_num} exceeds the queue range.
> > > +    \item \field{type} is not a known value.
> > > +    \item The type of vq does not match \field{type}. E.g. the driver tries to query
> > > +        RX stats through a TX index.
> > > +    \item The feature corresponding to the specified \field{type} was not successfully
> > > +        negotiated.
> > > +    \item The size of the buffer allocated by the driver for \field{command-specific-data-reply}
> > > +        is less than the total size of the stats specialed by
> > > +        \field{virtio_net_ctrl_queue_stats}.
> > > +\end{itemize}
> > > +
> > > +The device MUST write the requested stats structures in
> > > +\field{command-specific-data-reply} in the order specified by the structure
> > > +virtio_net_ctrl_queue_stats.
> > > +
> > > +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device Stats}
> > > +
> > > +When a driver tries to obtain a certain stats, it MUST confirm that the relevant
> > > +feature negotiation is successful.
> > > +
> > > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond to the vq
> > > +specified by \field{queue_num}.
> > > +
> > > +The \field{command-specific-data-reply} buffer allocated by the driver MUST be
> > > +able to hold all the stats specified by virtio_net_ctrl_queue_stats.
> > > +
> > > +When the driver reads the response, it MUST read
> > > +\field{command-specific-data-reply} one by one based on the \field{type}.
> > >
> > >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> > >  Types / Network Device / Legacy Interface: Framing Requirements}
> > > --
> > > 2.31.0
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

