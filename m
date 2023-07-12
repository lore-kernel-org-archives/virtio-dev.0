Return-Path: <virtio-dev-return-13340-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228D5EB64D9
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 08:09:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3992E190908
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 08:09:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1407B9867AF
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 08:09:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E718F986660; Wed, 12 Jul 2023 08:09:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C50ED986661
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 08:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xgzN3WzHMUSv3FTv-v9LkQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689149341; x=1691741341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dDN008qKjph1NisHgQ+qzZ/k79n6NB/6Z0q8Dlekb0=;
        b=Ra5mMQLrPy9fXE9QZUjbeXRzy2He1ChPFaDi4ncFbY6O4kJbYCzPBIkQNL4CmMVxQh
         gf2bD4BIUJIhRrh6te/bBbttHXz54/ozglCXnkYNwS3XiWr6PbIqYm/iyUImxiFXyyqu
         tb2CXNjNE8fBRWbBmRhAMbkFgXP9BPkndXWyDF0mGtSqn0DF1WMnq+OeLbgbikld0H2W
         uDQERSNqLJPSuDpA9QC7DIykbUk0vYuJRniLF2tf2EDiW9buJvXDqIntOjSxdnchB0Sh
         rPirzmK/WJHGxXvvE+p04AP7GsfR2ExBpFGLSZWm3W0SWfvf8Xa2JFhiYujQrWGDCC8r
         VMrw==
X-Gm-Message-State: ABy/qLb7Q72PfynLAETMxJ/PDrUToqIV4L1O1d0HTXpF6csOcbGx981l
	Zp6rtEp6DkAfCMg79NzbFTtYm1ZXBHXSZK5zPezhTNwTEjh7WiXER9NBQYaa3JnMxs9KvoSYlJM
	N+rEa4PpxF9t/AK014itRE1la11KZXTpuqYpUwnn1Co7C
X-Received: by 2002:a2e:7211:0:b0:2b6:ec2b:7d77 with SMTP id n17-20020a2e7211000000b002b6ec2b7d77mr15238833ljc.6.1689149341036;
        Wed, 12 Jul 2023 01:09:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECy1OSEPPdpWZPZXb1V0yDHQlBcUJyfsw9l7uWObskt748Nlc+LcKt8gaxNgfv9koRFxvjL09dCMTfPxIlhCA=
X-Received: by 2002:a2e:7211:0:b0:2b6:ec2b:7d77 with SMTP id
 n17-20020a2e7211000000b002b6ec2b7d77mr15238784ljc.6.1689149340532; Wed, 12
 Jul 2023 01:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com> <1688974120.7019765-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1688974120.7019765-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:08:48 +0800
Message-ID: <CACGkMEshsX6qFk6ZaeugcBarPm5Xi7P71Xri+mKd+R2MgXt74w@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, 
	Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000006a597e060045baf2"
Subject: Re: [virtio-dev] [PATCH v12] virtio-net: support device stats

--0000000000006a597e060045baf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om>
wrote:

> hi, guys
>
> After a lot of internal discussions, I removed some unimportant counters.
> Based
> on this v12 patch I am repling to, most of the requirements have been met=
.
>
> The patch link
> https://lore.kernel.org/all/20220315032402.6088-1-xuanzhuo@linux.alibaba.=
com/
>
> We still have these counters, let's see if they can be standardized.
>
> ## limit
>
> * tx_bps_limit_drops
> * tx_pps_limit_drops
> * rx_bps_limit_drops
> * rx_pps_limit_drops
>
> In a cloud scenario, multiple users purchase different VMs, and these VMs
> share
> the capabilities of the same host. In order to ensure that each VM will n=
ot
> affect others, the network card(virtio-net) capability of each VM is
> limited.
> These users purchase VMs, this limit has already been determined.
>

This seems a feature beyond the counters but QOS. I think we virtio spec
need to support QOS before we can discuss any QOS related counters.


>
> So if the network card traffic of a vm exceeds the upper limit, packet
> loss will
> occur. It is necessary for us to count these packet losses. And the devic=
e
> should expose to the user.
>
> ## session
>
> * tx_session_full_drops The number of packet drops in the sending
> direction when
>                         the session is full
> * rx_session_full_drops The number of packets lost when the session is
> full in the receiving direction
>
> Our dpu supports tcp connection tracking, but there is an upper limit to
> the
> number of connections, and if it exceeds, packet loss will also occur.
>

Similarly, if connect tracking offload is supported, it needs to be
implemented in the spec first then we can have related counters.


>
> ## ACL
>
> * tx_acl_drops ACL packet loss in the sending direction
> * rx_acl_drops The number of ACL packets lost in the receiving direction
>
> In our cloud service, for network cards, users are allowed to configure
> security
> rules,such as which IPs can access which ports of this machine.
>

Same as above, ACL should be supported by the spec first then the counters.

In conclusion, the features must be self contained. Otherwise you are doing
vDPA actually and those counters need to be accessed in a vendor specific
way.

Thanks


>
>
> Thanks
>
>
> On Tue, 15 Mar 2022 11:24:02 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
>
> wrote:
> > This patch allows the driver to obtain some statistics from the device.
> >
> > In the back-end implementation, we can count a lot of such information,
> > which can be used for debugging and judging the running status of the
> > back-end. We hope to directly display it to the user through ethtool.
> >
> > To get stats atomically, try to get stats for all queue pairs in one
> > command.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  conformance.tex |   2 +
> >  content.tex     | 406 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 405 insertions(+), 3 deletions(-)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 42f8537..c67f877 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
> >  \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Automatic receive steering in multiqueue
> mode}
> >  \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Offloads State Configuration / Setting
> Offloads State}
> >  \item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > +\item \ref{drivernormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Device Stats}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{Block Driver
> Conformance}\label{sec:Conformance / Driver Conformance / Block Driver
> Conformance}
> > @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance
> / Conformance Targets}
> >  \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Gratuitous Packet Sending}
> >  \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Automatic receive steering in multiqueue
> mode}
> >  \item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processi=
ng}
> > +\item \ref{devicenormative:Device Types / Network Device / Device
> Operation / Control Virtqueue / Device Stats}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{Block Device
> Conformance}\label{sec:Conformance / Device Conformance / Block Device
> Conformance}
> > diff --git a/content.tex b/content.tex
> > index c6f116c..81f325d 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/
> Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level
> statistics
> > +    to the driver through the control channel.
> > +
> >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets.
> Unlike UFO
> >   (fragmenting the packet) the USO splits large UDP packet
> >   to several segments when each of these smaller packets has UDP header=
.
> > @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit
> requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or
> VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> > @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e
> Types / Network Device / Devi
> >          u8 command;
> >          u8 command-specific-data[];
> >          u8 ack;
> > +        u8 command-specific-data-reply[];
> >  };
> >
> >  /* ack values */
> > @@ -4023,9 +4028,11 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  \end{lstlisting}
> >
> >  The \field{class}, \field{command} and command-specific-data are set b=
y
> the
> > -driver, and the device sets the \field{ack} byte. There is little it c=
an
> > -do except issue a diagnostic if \field{ack} is not
> > -VIRTIO_NET_OK.
> > +driver, and the device sets the \field{ack} byte and optionally
> > +\field{command-specific-data-reply}. There is little the driver can
> > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > +
> > +The command VIRTIO_NET_CTRL_STATS_GET contains
> \field{command-specific-data-reply}.
> >
> >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> >  \label{sec:Device Types / Network Device / Device Operation / Control
> Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > @@ -4471,6 +4478,399 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  according to the native endian of the guest rather than
> >  (necessarily when not using the legacy interface) little-endian.
> >
> > +\paragraph{Device Stats}\label{sec:Device Types / Network Device /
> Device Operation / Control Virtqueue / Device Stats}
> > +
> > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> > +get the device stats from the device in
> \field{command-specific-data-reply}.
> > +
> > +To get the stats, the following definitions are used:
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_CTRL_STATS         6
> > +#define VIRTIO_NET_CTRL_STATS_GET     0
> > +
> > +#define VIRTIO_NET_STATS_TYPE_CVQ      0
> > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1
> > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM  2
> > +#define VIRTIO_NET_STATS_TYPE_RX_GSO   3
> > +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4
> > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5
> > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM  6
> > +#define VIRTIO_NET_STATS_TYPE_TX_GSO   7
> > +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8
> > +
> > +\end{lstlisting}
> > +
> > +Use the command VIRTIO_NET_CTRL_STATS_GET and
> \field{command-specific-data}
> > +containing struct virtio_net_ctrl_queue_stats to get the device stats.
> > +The result is returned by \field{command-specific-data-reply}.
> > +The stats ware returned in the order of the type specified in the
> > +\field{virtio_net_ctrl_queue_stats}.
> > +
> > +The following layout structures are used:
> > +
> > +\field{command-specific-data}
> > +\begin{lstlisting}
> > +struct virtio_net_ctrl_queue_stats {
> > +     u16 nstats;
> > +     struct {
> > +         u16 queue_num;
> > +         u16 type;
> > +     } stats[];
> > +};
> > +\end{lstlisting}
> > +
> > +\field{command-specific-data-reply}
> > +\begin{lstlisting}
> > +struct virtio_net_stats_cvq {
> > +    le64 command_num;
> > +    le64 ok_num;
> > +};
> > +
> > +struct virtio_net_stats_rx_basic {
> > +    le64 rx_packets;
> > +    le64 rx_bytes;
> > +
> > +    le64 rx_notification;
> > +    le64 rx_interrupt;
> > +
> > +    le64 rx_drop;
> > +    le64 rx_drop_overruns;
> > +};
> > +
> > +struct virtio_net_stats_rx_csum {
> > +    le64 rx_csum_valid;
> > +    le64 rx_needs_csum;
> > +    le64 rx_csum_bad;
> > +    le64 rx_csum_none;
> > +};
> > +
> > +struct virtio_net_stats_rx_gso {
> > +    le64 rx_gso_packets;
> > +    le64 rx_gso_bytes;
> > +    le64 rx_gso_packets_coalesced;
> > +    le64 rx_gso_bytes_coalesced;
> > +    le64 rx_gso_segments;
> > +    le64 rx_gso_segments_bytes;
> > +};
> > +
> > +struct virtio_net_stats_rx_reset {
> > +    le64 rx_reset;
> > +};
> > +
> > +struct virtio_net_stats_tx_basic {
> > +    le64 tx_packets;
> > +    le64 tx_bytes;
> > +
> > +    le64 tx_notification;
> > +    le64 tx_interrupt;
> > +
> > +    le64 tx_drop;
> > +    le64 tx_drop_malformed;
> > +};
> > +
> > +struct virtio_net_stats_tx_csum {
> > +    le64 tx_csum_none;
> > +    le64 tx_needs_csum;
> > +};
> > +
> > +struct virtio_net_stats_tx_gso {
> > +    le64 tx_gso_packets;
> > +    le64 tx_gso_bytes;
> > +    le64 tx_gso_packets_split;
> > +    le64 tx_gso_bytes_split;
> > +    le64 tx_gso_segments;
> > +    le64 tx_gso_segments_bytes;
> > +};
> > +
> > +struct virtio_net_stats_tx_reset {
> > +    le64 tx_reset;
> > +};
> > +
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +    \item [nstats]
> > +        The number of \field{stats}.
> > +
> > +    \item [queue_num]
> > +        The number of the virtqueue to obtain the statistics.
> > +
> > +    \item [type]
> > +        The type of the stats to be obtained.
> > +
> > +\end{description}
> > +
> > +Correspondence between the vq type, the stats type, the stats structur=
e
> and the
> > +required features.
> > +\begin{tabular}{ |l|l|l|l| }
> > +    \hline
> > +    VQ Type                  & Stats Type                     & Stats
> Structure           & Features \\ \hline
> > +
> > +    controlq                 & VIRTIO_NET_STATS_TYPE_CVQ      &
> virtio_net_stats_cvq      & \\ \hline
> > +
> > +    \multirow{4}*{receiveq}  & VIRTIO_NET_STATS_TYPE_RX_BASIC &
> virtio_net_stats_rx_basic & \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_RX_CSUM  &
> virtio_net_stats_rx_csum  & VIRTIO_NET_F_GUEST_CSUM \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_RX_GSO   &
> virtio_net_stats_rx_gso   & VIRTIO_NET_F_GUEST_TSO4 or\newline
> > +
>                     VIRTIO_NET_F_GUEST_TSO6 or\newline
> > +
>                     VIRTIO_NET_F_GUEST_UFO    \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_RX_RESET &
> virtio_net_stats_rx_reset & VIRTIO_F_RING_RESET \\ \hline
> > +
> > +    \multirow{4}*{transmitq} & VIRTIO_NET_STATS_TYPE_TX_BASIC &
> virtio_net_stats_tx_basic & \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_TX_CSUM  &
> virtio_net_stats_tx_csum  & VIRTIO_NET_F_CSUM \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_TX_GSO   &
> virtio_net_stats_tx_gso   & VIRTIO_NET_F_HOST_TSO4 or\newline
> > +
>                     VIRTIO_NET_F_HOST_TSO6 or\newline
> > +
>                     VIRTIO_NET_F_HOST_USO  or\newline
> > +
>                     VIRTIO_NET_F_HOST_UFO  \\ \cline{2-4}
> > +                             & VIRTIO_NET_STATS_TYPE_TX_RESET &
> virtio_net_stats_tx_reset & VIRTIO_F_RING_RESET \\
> > +    \hline
> > +\end{tabular}
> > +
> > +
> > +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device =
/
> Device Operation / Control Virtqueue / Device Stats / Controlq Stats}
> > +
> > +The structure corresponding to the controlq stats is
> virtio_net_stats_cvq.
> > +
> > +\begin{description}
> > +    \item [command_num]
> > +        The number of commands, including the current command.
> > +
> > +    \item [ok_num]
> > +        The number of commands (including the current command) where
> the ack was VIRTIO_NET_OK.
> > +\end{description}
> > +
> > +
> > +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq
> Basic Stats}
> > +
> > +The structure corresponding to the receiveq basic stats is
> virtio_net_stats_rx_basic.
> > +
> > +Receiveq basic stats doesn't need any features, as long as the device
> supports
> > +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stats.
> > +
> > +\begin{description}
> > +    \item [rx_packets]
> > +        The number of packets received by device (not the packets
> passed to the
> > +        guest), including the dropped packets by device.
> > +
> > +    \item [rx_bytes]
> > +        The number of bytes received by device (not the packets passed
> to the
> > +        guest), including the dropped packets by device.
> > +
> > +    \item [rx_notification]
> > +        The number of driver notifications.
> > +
> > +    \item [rx_interrupt]
> > +        The number of device interrupts.
> > +
> > +    \item [rx_drop]
> > +        The number of packets dropped by the receiveq. Contains all
> kinds of
> > +        packet drop.
> > +
> > +    \item [rx_drop_overruns]
> > +        The number of packets dropped by the receiveq when no more
> descriptors
> > +        were available.
> > +
> > +\end{description}
> > +
> > +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Transmitq
> Basic Stats}
> > +
> > +The structure corresponding to the transmitq basic stats is
> virtio_net_stats_tx_basic.
> > +
> > +Transmitq basic stats doesn't need any features, as long as the device
> supports
> > +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic stats.
> > +
> > +\begin{description}
> > +    \item [tx_packets]
> > +        The number of packets sent by device (not the packets got from
> the
> > +        guest), excluding the dropped packets by device.
> > +
> > +    \item [tx_bytes]
> > +        The number of bytes sent by device (not the packets got from t=
he
> > +        guest), excluding the dropped packets by device.
> > +
> > +    \item [tx_notification]
> > +        The number of driver notifications.
> > +
> > +    \item [tx_interrupt]
> > +        The number of device interrupts.
> > +
> > +    \item [tx_drop]
> > +        The number of packets dropped by the transmitq. Contains all
> kinds of
> > +        packet drop.
> > +
> > +    \item [tx_drop_malformed]
> > +        The number of packets dropped when the descriptor is in an
> error state.
> > +        For example, the buffer is too short.
> > +
> > +\end{description}
> > +
> > +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq
> CSUM Stats}
> > +
> > +The structure corresponding to the receiveq csum stats is
> virtio_net_stats_rx_csum.
> > +
> > +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the
> receiveq
> > +csum stats can be obtained.
> > +
> > +The following are the receiveq csum stats:
> > +
> > +\begin{description}
> > +    \item [rx_csum_valid]
> > +        The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
> > +
> > +    \item [rx_needs_csum]
> > +        The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> > +
> > +    \item [rx_csum_bad]
> > +        The number of packets with abnormal csum.
> > +
> > +    \item [rx_csum_none]
> > +        The number of packets without hardware csum. The packet here
> refers to
> > +        the non-TCP/UDP packet that the backend cannot recognize.
> > +
> > +\end{description}
> > +
> > +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Transmitq
> CSUM Stats}
> > +
> > +The structure corresponding to the transmitq csum stats is
> virtio_net_stats_tx_csum.
> > +
> > +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the
> transmitq csum
> > +stats can be obtained.
> > +
> > +The following are the transmitq csum stats:
> > +
> > +\begin{description}
> > +    \item [tx_csum_none]
> > +        The number of packets that didn't require hardware csum.
> > +
> > +    \item [tx_needs_csum]
> > +        The number of packets that required hardware csum.
> > +
> > +\end{description}
> > +
> > +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq G=
SO
> Stats}
> > +
> > +The structure corresponding to the receiveq gso stats is
> virtio_net_stats_rx_gso.
> > +
> > +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have
> > +been negotiated, the receiveq gso stats can be obtained.
> > +
> > +Rx gso packets refer to packets passed by the device to the driver whe=
re
> > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > +
> > +\begin{description}
> > +    \item [rx_gso_packets]
> > +        The number of the rx gso packets.
> > +
> > +    \item [rx_gso_bytes]
> > +        The number of bytes(excluding the virtio net header) of the rx
> gso packets.
> > +
> > +    \item [rx_gso_packets_coalesced]
> > +        The number of the rx gso packages generated by coalescing.
> > +
> > +    \item [rx_gso_bytes_coalesced]
> > +        The number of bytes(excluding the virtio net header) of the rx
> gso packets generated by coalescing.
> > +
> > +    \item [rx_gso_segments]
> > +        The number of coalesced segments.
> > +
> > +    \item [rx_gso_segments_bytes]
> > +        The number of bytes of coalesced segments.
> > +
> > +\end{description}
> > +
> > +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Transmitq
> GSO Stats}
> > +
> > +The structure corresponding to the transmitq gso stats is
> virtio_net_stats_tx_gso.
> > +
> > +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> > +been negotiated, the transmitq gso stats can be obtained.
> > +
> > +Tx gso packets refer to packets passed by the driver to the device whe=
re
> > +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.
> > +
> > +\begin{description}
> > +    \item [tx_gso_packets]
> > +        The number of the tx gso packets.
> > +
> > +    \item [tx_gso_bytes]
> > +        The number of bytes(excluding the virtio net header) of the tx
> gso packets.
> > +
> > +    \item [tx_gso_packets_split]
> > +        The number of the tx gso packets that been split.
> > +
> > +    \item [tx_gso_bytes_split]
> > +        The number of bytes(excluding the virtio net header) of the tx
> gso packets that been split.
> > +
> > +    \item [tx_gso_segments]
> > +        The number of segments split from the gso package.
> > +
> > +    \item [tx_gso_segments_bytes]
> > +        The number of bytes(excluding the virtio net header) of
> segments split from the gso package.
> > +\end{description}
> > +
> > +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Receiveq
> Reset Stats}
> > +
> > +The structure corresponding to the receiveq reset stats is
> virtio_net_stats_rx_reset.
> > +
> > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the receiveq
> reset stats
> > +can be obtained.
> > +
> > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> Virtqueue Reset}
> > +for more about \field{rx_reset}.
> > +
> > +\begin{description}
> > +    \item [rx_reset]
> > +        The number of receiveq resets.
> > +\end{description}
> > +
> > +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats / Transmitq
> Reset Stats}
> > +
> > +The structure corresponding to the transmitq reset stats is
> virtio_net_stats_tx_reset.
> > +
> > +Only when VIRTIO_F_RING_RESET is successfully negotiated, the transmit=
q
> reset stats
> > +can be obtained.
> > +
> > +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
> Virtqueue Reset}
> > +for more about \field{tx_reset}.
> > +
> > +\begin{description}
> > +    \item [tx_reset]
> > +        The number of transmitq resets.
> > +\end{description}
> > +
> > +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats}
> > +
> > +If virtio_net_ctrl_queue_stats is incorrect (such as the following),
> the device
> > +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one erro=
r,
> > +the device MUST abort the entire command.
> > +\begin{itemize}
> > +    \item \field{queue_num} exceeds the queue range.
> > +    \item \field{type} is not a known value.
> > +    \item The type of vq does not match \field{type}. E.g. the driver
> tries to query
> > +        RX stats through a TX index.
> > +    \item The feature corresponding to the specified \field{type} was
> not successfully
> > +        negotiated.
> > +    \item The size of the buffer allocated by the driver for
> \field{command-specific-data-reply}
> > +        is less than the total size of the stats specialed by
> > +        \field{virtio_net_ctrl_queue_stats}.
> > +\end{itemize}
> > +
> > +The device MUST write the requested stats structures in
> > +\field{command-specific-data-reply} in the order specified by the
> structure
> > +virtio_net_ctrl_queue_stats.
> > +
> > +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network
> Device / Device Operation / Control Virtqueue / Device Stats}
> > +
> > +When a driver tries to obtain a certain stats, it MUST confirm that th=
e
> relevant
> > +feature negotiation is successful.
> > +
> > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond to
> the vq
> > +specified by \field{queue_num}.
> > +
> > +The \field{command-specific-data-reply} buffer allocated by the driver
> MUST be
> > +able to hold all the stats specified by virtio_net_ctrl_queue_stats.
> > +
> > +When the driver reads the response, it MUST read
> > +\field{command-specific-data-reply} one by one based on the
> \field{type}.
> >
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Devic=
e
> >  Types / Network Device / Legacy Interface: Framing Requirements}
> > --
> > 2.31.0
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
>

--0000000000006a597e060045baf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 10, 2023 at 3:32=E2=80=AF=
PM Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.com">xuanzhuo@lin=
ux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">hi, guys<br>
<br>
After a lot of internal discussions, I removed some unimportant counters. B=
ased<br>
on this v12 patch I am repling to, most of the requirements have been met.<=
br>
<br>
The patch link <a href=3D"https://lore.kernel.org/all/20220315032402.6088-1=
-xuanzhuo@linux.alibaba.com/" rel=3D"noreferrer" target=3D"_blank">https://=
lore.kernel.org/all/20220315032402.6088-1-xuanzhuo@linux.alibaba.com/</a><b=
r>
<br>
We still have these counters, let&#39;s see if they can be standardized.<br=
>
<br>
## limit<br>
<br>
* tx_bps_limit_drops<br>
* tx_pps_limit_drops<br>
* rx_bps_limit_drops<br>
* rx_pps_limit_drops<br>
<br>
In a cloud scenario, multiple users purchase different VMs, and these VMs s=
hare<br>
the capabilities of the same host. In order to ensure that each VM will not=
<br>
affect others, the network card(virtio-net) capability of each VM is limite=
d.<br>
These users purchase VMs, this limit has already been determined.<br></bloc=
kquote><div><br></div><div>This seems a feature beyond the counters but QOS=
. I think we virtio spec need to support QOS before we can discuss any QOS =
related counters.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
So if the network card traffic of a vm exceeds the upper limit, packet loss=
 will<br>
occur. It is necessary for us to count these packet losses. And the device<=
br>
should expose to the user.<br>
<br>
## session<br>
<br>
* tx_session_full_drops The number of packet drops in the sending direction=
 when<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 the session is full<br>
* rx_session_full_drops The number of packets lost when the session is full=
 in the receiving direction<br>
<br>
Our dpu supports tcp connection tracking, but there is an upper limit to th=
e<br>
number of connections, and if it exceeds, packet loss will also occur.<br><=
/blockquote><div><br></div><div>Similarly, if connect tracking offload is s=
upported, it needs to be implemented in the spec first then we can have rel=
ated counters.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
## ACL<br>
<br>
* tx_acl_drops ACL packet loss in the sending direction<br>
* rx_acl_drops The number of ACL packets lost in the receiving direction<br=
>
<br>
In our cloud service, for network cards, users are allowed to configure sec=
urity<br>
rules,such as which IPs can access which ports of this machine.<br></blockq=
uote><div><br></div><div>Same as above, ACL should be supported by the spec=
 first then the counters.</div><div><br></div><div>In conclusion, the featu=
res must be self contained. Otherwise you are doing vDPA actually and those=
 counters need to be accessed in a vendor specific way.</div><div><br></div=
><div>Thanks</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
Thanks<br>
<br>
<br>
On Tue, 15 Mar 2022 11:24:02 +0800, Xuan Zhuo &lt;<a href=3D"mailto:xuanzhu=
o@linux.alibaba.com" target=3D"_blank">xuanzhuo@linux.alibaba.com</a>&gt; w=
rote:<br>
&gt; This patch allows the driver to obtain some statistics from the device=
.<br>
&gt;<br>
&gt; In the back-end implementation, we can count a lot of such information=
,<br>
&gt; which can be used for debugging and judging the running status of the<=
br>
&gt; back-end. We hope to directly display it to the user through ethtool.<=
br>
&gt;<br>
&gt; To get stats atomically, try to get stats for all queue pairs in one<b=
r>
&gt; command.<br>
&gt;<br>
&gt; Signed-off-by: Xuan Zhuo &lt;<a href=3D"mailto:xuanzhuo@linux.alibaba.=
com" target=3D"_blank">xuanzhuo@linux.alibaba.com</a>&gt;<br>
&gt; Suggested-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com"=
 target=3D"_blank">mst@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 conformance.tex |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 content.tex=C2=A0 =C2=A0 =C2=A0| 406 +++++++++++++++++++++++++++=
++++++++++++++++++++-<br>
&gt;=C2=A0 2 files changed, 405 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/conformance.tex b/conformance.tex<br>
&gt; index 42f8537..c67f877 100644<br>
&gt; --- a/conformance.tex<br>
&gt; +++ b/conformance.tex<br>
&gt; @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformanc=
e / Conformance Targets}<br>
&gt;=C2=A0 \item \ref{drivernormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Automatic receive steering in multiqueue =
mode}<br>
&gt;=C2=A0 \item \ref{drivernormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Offloads State Configuration / Setting Of=
floads State}<br>
&gt;=C2=A0 \item \ref{drivernormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Receive-side scaling (RSS) }<br>
&gt; +\item \ref{drivernormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Device Stats}<br>
&gt;=C2=A0 \end{itemize}<br>
&gt;<br>
&gt;=C2=A0 \conformance{\subsection}{Block Driver Conformance}\label{sec:Co=
nformance / Driver Conformance / Block Driver Conformance}<br>
&gt; @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformanc=
e / Conformance Targets}<br>
&gt;=C2=A0 \item \ref{devicenormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Gratuitous Packet Sending}<br>
&gt;=C2=A0 \item \ref{devicenormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Automatic receive steering in multiqueue =
mode}<br>
&gt;=C2=A0 \item \ref{devicenormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processi=
ng}<br>
&gt; +\item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Device Stats}<br>
&gt;=C2=A0 \end{itemize}<br>
&gt;<br>
&gt;=C2=A0 \conformance{\subsection}{Block Device Conformance}\label{sec:Co=
nformance / Device Conformance / Block Device Conformance}<br>
&gt; diff --git a/content.tex b/content.tex<br>
&gt; index c6f116c..81f325d 100644<br>
&gt; --- a/content.tex<br>
&gt; +++ b/content.tex<br>
&gt; @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through co=
ntrol<br>
&gt;=C2=A0 =C2=A0 =C2=A0 channel.<br>
&gt;<br>
&gt; +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level st=
atistics<br>
&gt; +=C2=A0 =C2=A0 to the driver through the control channel.<br>
&gt; +<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets=
. Unlike UFO<br>
&gt;=C2=A0 =C2=A0(fragmenting the packet) the USO splits large UDP packet<b=
r>
&gt;=C2=A0 =C2=A0to several segments when each of these smaller packets has=
 UDP header.<br>
&gt; @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{s=
ec:Device Types / Network Device<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ=
.<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.=
<br>
&gt; +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or V=
IRTIO_NET_F_HOST_TSO6.<br>
&gt;=C2=A0 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.<br>
&gt;=C2=A0 \end{description}<br>
&gt; @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 command;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 command-specific-data[];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 ack;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 command-specific-data-reply[];<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 /* ack values */<br>
&gt; @@ -4023,9 +4028,11 @@ \subsubsection{Control Virtqueue}\label{sec:Dev=
ice Types / Network Device / Devi<br>
&gt;=C2=A0 \end{lstlisting}<br>
&gt;<br>
&gt;=C2=A0 The \field{class}, \field{command} and command-specific-data are=
 set by the<br>
&gt; -driver, and the device sets the \field{ack} byte. There is little it =
can<br>
&gt; -do except issue a diagnostic if \field{ack} is not<br>
&gt; -VIRTIO_NET_OK.<br>
&gt; +driver, and the device sets the \field{ack} byte and optionally<br>
&gt; +\field{command-specific-data-reply}. There is little the driver can<b=
r>
&gt; +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.<br>
&gt; +<br>
&gt; +The command VIRTIO_NET_CTRL_STATS_GET contains \field{command-specifi=
c-data-reply}.<br>
&gt;<br>
&gt;=C2=A0 \paragraph{Packet Receive Filtering}\label{sec:Device Types / Ne=
twork Device / Device Operation / Control Virtqueue / Packet Receive Filter=
ing}<br>
&gt;=C2=A0 \label{sec:Device Types / Network Device / Device Operation / Co=
ntrol Virtqueue / Setting Promiscuous Mode}%old label for latexdiff<br>
&gt; @@ -4471,6 +4478,399 @@ \subsubsection{Control Virtqueue}\label{sec:De=
vice Types / Network Device / Devi<br>
&gt;=C2=A0 according to the native endian of the guest rather than<br>
&gt;=C2=A0 (necessarily when not using the legacy interface) little-endian.=
<br>
&gt;<br>
&gt; +\paragraph{Device Stats}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Device Stats}<br>
&gt; +<br>
&gt; +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can<=
br>
&gt; +get the device stats from the device in \field{command-specific-data-=
reply}.<br>
&gt; +<br>
&gt; +To get the stats, the following definitions are used:<br>
&gt; +\begin{lstlisting}<br>
&gt; +#define VIRTIO_NET_CTRL_STATS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt; +#define VIRTIO_NET_CTRL_STATS_GET=C2=A0 =C2=A0 =C2=A00<br>
&gt; +<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_CVQ=C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_RX_BASIC 1<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_RX_CSUM=C2=A0 2<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_RX_GSO=C2=A0 =C2=A03<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_RX_RESET 4<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_TX_BASIC 5<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_TX_CSUM=C2=A0 6<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_TX_GSO=C2=A0 =C2=A07<br>
&gt; +#define VIRTIO_NET_STATS_TYPE_TX_RESET 8<br>
&gt; +<br>
&gt; +\end{lstlisting}<br>
&gt; +<br>
&gt; +Use the command VIRTIO_NET_CTRL_STATS_GET and \field{command-specific=
-data}<br>
&gt; +containing struct virtio_net_ctrl_queue_stats to get the device stats=
.<br>
&gt; +The result is returned by \field{command-specific-data-reply}.<br>
&gt; +The stats ware returned in the order of the type specified in the<br>
&gt; +\field{virtio_net_ctrl_queue_stats}.<br>
&gt; +<br>
&gt; +The following layout structures are used:<br>
&gt; +<br>
&gt; +\field{command-specific-data}<br>
&gt; +\begin{lstlisting}<br>
&gt; +struct virtio_net_ctrl_queue_stats {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 nstats;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 queue_num;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} stats[];<br>
&gt; +};<br>
&gt; +\end{lstlisting}<br>
&gt; +<br>
&gt; +\field{command-specific-data-reply}<br>
&gt; +\begin{lstlisting}<br>
&gt; +struct virtio_net_stats_cvq {<br>
&gt; +=C2=A0 =C2=A0 le64 command_num;<br>
&gt; +=C2=A0 =C2=A0 le64 ok_num;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_rx_basic {<br>
&gt; +=C2=A0 =C2=A0 le64 rx_packets;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_bytes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 le64 rx_notification;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_interrupt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 le64 rx_drop;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_drop_overruns;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_rx_csum {<br>
&gt; +=C2=A0 =C2=A0 le64 rx_csum_valid;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_needs_csum;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_csum_bad;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_csum_none;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_rx_gso {<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_packets;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_bytes;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_packets_coalesced;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_bytes_coalesced;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_segments;<br>
&gt; +=C2=A0 =C2=A0 le64 rx_gso_segments_bytes;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_rx_reset {<br>
&gt; +=C2=A0 =C2=A0 le64 rx_reset;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_tx_basic {<br>
&gt; +=C2=A0 =C2=A0 le64 tx_packets;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_bytes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 le64 tx_notification;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_interrupt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 le64 tx_drop;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_drop_malformed;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_tx_csum {<br>
&gt; +=C2=A0 =C2=A0 le64 tx_csum_none;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_needs_csum;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_tx_gso {<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_packets;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_bytes;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_packets_split;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_bytes_split;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_segments;<br>
&gt; +=C2=A0 =C2=A0 le64 tx_gso_segments_bytes;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_net_stats_tx_reset {<br>
&gt; +=C2=A0 =C2=A0 le64 tx_reset;<br>
&gt; +};<br>
&gt; +<br>
&gt; +\end{lstlisting}<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [nstats]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of \field{stats}.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [queue_num]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the virtqueue to obtain the=
 statistics.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [type]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The type of the stats to be obtained.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +Correspondence between the vq type, the stats type, the stats structu=
re and the<br>
&gt; +required features.<br>
&gt; +\begin{tabular}{ |l|l|l|l| }<br>
&gt; +=C2=A0 =C2=A0 \hline<br>
&gt; +=C2=A0 =C2=A0 VQ Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &amp; Stats Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; Stats Structure=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&amp; Features \\ \hline<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 controlq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_CVQ=C2=A0 =C2=A0 =C2=A0 &amp; =
virtio_net_stats_cvq=C2=A0 =C2=A0 =C2=A0 &amp; \\ \hline<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \multirow{4}*{receiveq}=C2=A0 &amp; VIRTIO_NET_STATS_TY=
PE_RX_BASIC &amp; virtio_net_stats_rx_basic &amp; \\ \cline{2-4}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX_CSUM=C2=
=A0 &amp; virtio_net_stats_rx_csum=C2=A0 &amp; VIRTIO_NET_F_GUEST_CSUM \\ \=
cline{2-4}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX_GSO=C2=A0=
 =C2=A0&amp; virtio_net_stats_rx_gso=C2=A0 =C2=A0&amp; VIRTIO_NET_F_GUEST_T=
SO4 or\newline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_TSO6 or\newline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_GUEST_UFO=C2=A0 =C2=A0 \\ \cli=
ne{2-4}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_RX_RESET &am=
p; virtio_net_stats_rx_reset &amp; VIRTIO_F_RING_RESET \\ \hline<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \multirow{4}*{transmitq} &amp; VIRTIO_NET_STATS_TYPE_TX=
_BASIC &amp; virtio_net_stats_tx_basic &amp; \\ \cline{2-4}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX_CSUM=C2=
=A0 &amp; virtio_net_stats_tx_csum=C2=A0 &amp; VIRTIO_NET_F_CSUM \\ \cline{=
2-4}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX_GSO=C2=A0=
 =C2=A0&amp; virtio_net_stats_tx_gso=C2=A0 =C2=A0&amp; VIRTIO_NET_F_HOST_TS=
O4 or\newline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_TSO6 or\newline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_USO=C2=A0 or\newline<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_NET_F_HOST_UFO=C2=A0 \\ \cline{2-4}<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; VIRTIO_NET_STATS_TYPE_TX_RESET &am=
p; virtio_net_stats_tx_reset &amp; VIRTIO_F_RING_RESET \\<br>
&gt; +=C2=A0 =C2=A0 \hline<br>
&gt; +\end{tabular}<br>
&gt; +<br>
&gt; +<br>
&gt; +\subparagraph{Controlq Stats}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Device Stats / Controlq Stats}<br=
>
&gt; +<br>
&gt; +The structure corresponding to the controlq stats is virtio_net_stats=
_cvq.<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [command_num]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of commands, including the cur=
rent command.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [ok_num]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of commands (including the cur=
rent command) where the ack was VIRTIO_NET_OK.<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +<br>
&gt; +\subparagraph{Receiveq Basic Stats}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Bas=
ic Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the receiveq basic stats is virtio_net=
_stats_rx_basic.<br>
&gt; +<br>
&gt; +Receiveq basic stats doesn&#39;t need any features, as long as the de=
vice supports<br>
&gt; +VIRTIO_NET_F_CTRL_STATS. The following are the receiveq basic stats.<=
br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [rx_packets]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets received by device =
(not the packets passed to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), including the dropped packets by =
device.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes received by device (n=
ot the packets passed to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), including the dropped packets by =
device.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_notification]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of driver notifications.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_interrupt]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of device interrupts.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_drop]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped by the rece=
iveq. Contains all kinds of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet drop.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_drop_overruns]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped by the rece=
iveq when no more descriptors<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 were available.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Transmitq Basic Stats}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats / Transmitq B=
asic Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the transmitq basic stats is virtio_ne=
t_stats_tx_basic.<br>
&gt; +<br>
&gt; +Transmitq basic stats doesn&#39;t need any features, as long as the d=
evice supports<br>
&gt; +VIRTIO_NET_F_CTRL_STATS. The following are the transmitq basic stats.=
<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [tx_packets]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets sent by device (not=
 the packets got from the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), excluding the dropped packets by =
device.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes sent by device (not t=
he packets got from the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest), excluding the dropped packets by =
device.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_notification]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of driver notifications.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_interrupt]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of device interrupts.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_drop]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped by the tran=
smitq. Contains all kinds of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet drop.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_drop_malformed]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets dropped when the de=
scriptor is in an error state.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 For example, the buffer is too short.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Receiveq CSUM Stats}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Device Stats / Receiveq CSUM=
 Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the receiveq csum stats is virtio_net_=
stats_rx_csum.<br>
&gt; +<br>
&gt; +Only after the VIRTIO_NET_F_GUEST_CSUM negotiation is successful, the=
 receiveq<br>
&gt; +csum stats can be obtained.<br>
&gt; +<br>
&gt; +The following are the receiveq csum stats:<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [rx_csum_valid]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with VIRTIO_NET_HDR=
_F_DATA_VALID.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_needs_csum]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with VIRTIO_NET_HDR=
_F_NEEDS_CSUM.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_csum_bad]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets with abnormal csum.=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_csum_none]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets without hardware cs=
um. The packet here refers to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 the non-TCP/UDP packet that the backend c=
annot recognize.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Transmitq CSUM Stats}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Transmitq CS=
UM Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the transmitq csum stats is virtio_net=
_stats_tx_csum.<br>
&gt; +<br>
&gt; +Only after the VIRTIO_NET_F_CSUM negotiation is successful, the trans=
mitq csum<br>
&gt; +stats can be obtained.<br>
&gt; +<br>
&gt; +The following are the transmitq csum stats:<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [tx_csum_none]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets that didn&#39;t req=
uire hardware csum.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_needs_csum]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of packets that required hardw=
are csum.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Receiveq GSO Stats}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue / Device Stats / Receiveq GSO S=
tats}<br>
&gt; +<br>
&gt; +The structure corresponding to the receiveq gso stats is virtio_net_s=
tats_rx_gso.<br>
&gt; +<br>
&gt; +If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, or UFO options have<br>
&gt; +been negotiated, the receiveq gso stats can be obtained.<br>
&gt; +<br>
&gt; +Rx gso packets refer to packets passed by the device to the driver wh=
ere<br>
&gt; +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_packets]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the rx gso packets.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding the virtio =
net header) of the rx gso packets.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_packets_coalesced]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the rx gso packages generat=
ed by coalescing.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_bytes_coalesced]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding the virtio =
net header) of the rx gso packets generated by coalescing.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_segments]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of coalesced segments.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [rx_gso_segments_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes of coalesced segments=
.<br>
&gt; +<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Transmitq GSO Stats}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Device Stats / Transmitq GSO=
 Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the transmitq gso stats is virtio_net_=
stats_tx_gso.<br>
&gt; +<br>
&gt; +If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have<b=
r>
&gt; +been negotiated, the transmitq gso stats can be obtained.<br>
&gt; +<br>
&gt; +Tx gso packets refer to packets passed by the driver to the device wh=
ere<br>
&gt; +\field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE.<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_packets]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the tx gso packets.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding the virtio =
net header) of the tx gso packets.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_packets_split]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of the tx gso packets that bee=
n split.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_bytes_split]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding the virtio =
net header) of the tx gso packets that been split.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_segments]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of segments split from the gso=
 package.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 \item [tx_gso_segments_bytes]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of bytes(excluding the virtio =
net header) of segments split from the gso package.<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Receiveq Reset Stats}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats / Receiveq Res=
et Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the receiveq reset stats is virtio_net=
_stats_rx_reset.<br>
&gt; +<br>
&gt; +Only when VIRTIO_F_RING_RESET is successfully negotiated, the receive=
q reset stats<br>
&gt; +can be obtained.<br>
&gt; +<br>
&gt; +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtq=
ueue Reset}<br>
&gt; +for more about \field{rx_reset}.<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [rx_reset]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of receiveq resets.<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\subparagraph{Transmitq Reset Stats}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Device Stats / Transmitq R=
eset Stats}<br>
&gt; +<br>
&gt; +The structure corresponding to the transmitq reset stats is virtio_ne=
t_stats_tx_reset.<br>
&gt; +<br>
&gt; +Only when VIRTIO_F_RING_RESET is successfully negotiated, the transmi=
tq reset stats<br>
&gt; +can be obtained.<br>
&gt; +<br>
&gt; +See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtq=
ueue Reset}<br>
&gt; +for more about \field{tx_reset}.<br>
&gt; +<br>
&gt; +\begin{description}<br>
&gt; +=C2=A0 =C2=A0 \item [tx_reset]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 The number of transmitq resets.<br>
&gt; +\end{description}<br>
&gt; +<br>
&gt; +\devicenormative{\subparagraph}{Device Stats}{Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats}<br>
&gt; +<br>
&gt; +If virtio_net_ctrl_queue_stats is incorrect (such as the following), =
the device<br>
&gt; +MUST set \field{ack} to VIRTIO_NET_ERR. Even if there is only one err=
or,<br>
&gt; +the device MUST abort the entire command.<br>
&gt; +\begin{itemize}<br>
&gt; +=C2=A0 =C2=A0 \item \field{queue_num} exceeds the queue range.<br>
&gt; +=C2=A0 =C2=A0 \item \field{type} is not a known value.<br>
&gt; +=C2=A0 =C2=A0 \item The type of vq does not match \field{type}. E.g. =
the driver tries to query<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX stats through a TX index.<br>
&gt; +=C2=A0 =C2=A0 \item The feature corresponding to the specified \field=
{type} was not successfully<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 negotiated.<br>
&gt; +=C2=A0 =C2=A0 \item The size of the buffer allocated by the driver fo=
r \field{command-specific-data-reply}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 is less than the total size of the stats =
specialed by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 \field{virtio_net_ctrl_queue_stats}.<br>
&gt; +\end{itemize}<br>
&gt; +<br>
&gt; +The device MUST write the requested stats structures in<br>
&gt; +\field{command-specific-data-reply} in the order specified by the str=
ucture<br>
&gt; +virtio_net_ctrl_queue_stats.<br>
&gt; +<br>
&gt; +\drivernormative{\subparagraph}{Device Stats}{Device Types / Network =
Device / Device Operation / Control Virtqueue / Device Stats}<br>
&gt; +<br>
&gt; +When a driver tries to obtain a certain stats, it MUST confirm that t=
he relevant<br>
&gt; +feature negotiation is successful.<br>
&gt; +<br>
&gt; +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond to=
 the vq<br>
&gt; +specified by \field{queue_num}.<br>
&gt; +<br>
&gt; +The \field{command-specific-data-reply} buffer allocated by the drive=
r MUST be<br>
&gt; +able to hold all the stats specified by virtio_net_ctrl_queue_stats.<=
br>
&gt; +<br>
&gt; +When the driver reads the response, it MUST read<br>
&gt; +\field{command-specific-data-reply} one by one based on the \field{ty=
pe}.<br>
&gt;<br>
&gt;=C2=A0 \subsubsection{Legacy Interface: Framing Requirements}\label{sec=
:Device<br>
&gt;=C2=A0 Types / Network Device / Legacy Interface: Framing Requirements}=
<br>
&gt; --<br>
&gt; 2.31.0<br>
&gt;<br>
&gt;<br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.=
org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</=
a><br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000006a597e060045baf2--

