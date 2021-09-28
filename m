Return-Path: <virtio-dev-return-8722-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0BC398644C
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Sep 2021 03:25:57 +0000 (UTC)
MIME-Version: 1.0
References: <CACGkMEurV0RvUupkFO4Ogeo4jF=yLbNJ=9EWkMEKsKe2UZ9oGQ@mail.gmail.com>
 <1632724210.6422126-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1632724210.6422126-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 11:25:40 +0800
Message-ID: <CACGkMEv9HCDKKqz7-3=217RZ6g0vuocdJWLK4c4H4Y8GCbeunA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-net: support device stats
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 27, 2021 at 2:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 27 Sep 2021 11:50:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Sep 16, 2021 at 5:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > This patch allows the driver to obtain some statistics from the device.
> > >
> > > In the back-end implementation, we can count a lot of such information,
> > > which can be used for debugging and judging the running status of the
> > > back-end. We hope to directly display it to the user through ethtool.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >
> > > v3 changes:
> > > 1. add dev_version
> > > 2. use queue_pair_index replace rx_num, tx_num
> > > 3. Explain the processing when the device and driver support different numbers
> > > of stats
> > >
> > >  content.tex | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 7cec1c3..2e45a55 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -2972,6 +2972,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > >      channel.
> > >
> > > +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
> > > +    to the driver through the control channel.
> > > +
> > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
> > >   (fragmenting the packet) the USO splits large UDP packet
> > >   to several segments when each of these smaller packets has UDP header.
> > > @@ -3017,6 +3020,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> > >  \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \end{description}
> > > @@ -3895,6 +3899,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >          u8 command;
> > >          u8 command-specific-data[];
> > >          u8 ack;
> > > +        u8 command-specific-data-reply[];
> > >  };
> > >
> > >  /* ack values */
> > > @@ -3906,6 +3911,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >  driver, and the device sets the \field{ack} byte. There is little it can
> > >  do except issue a diagnostic if \field{ack} is not
> > >  VIRTIO_NET_OK.
> > > +\field{command-specific-data-reply} is alloced by driver, then pass to device.
> > > +It is filled by the device. It is optional. Some commands need to get some
> > > +information from the device.
> >
> > Let's just reuse the "sets" as above.
> >
> > E.g "and the device set the \field{ack} and optionally
> > \field{command-specific-data-reply}"
>
> OK.
>
> >
> > >
> > >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> > >  \label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > > @@ -4384,6 +4392,113 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> > >  See \ref{sec:Basic
> > >  Facilities of a Virtio Device / Virtqueues / Message Framing}.
> > >
> > > +\paragraph{Device stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
> > > +
> > > +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> > > +get device stats from the device by \field{command-specific-data-reply}.
> > > +
> > > +\subparagraph{Device stats keys}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats keys / Device stats keys}
> > > +
> > > +The keys of the device stats are defined as follows. When the device fills in
> > > +\field{command-specific-data-reply}, it MUST be written in the following order.
> > > +Subsequent newly added keys MUST be added at the end of each category.
> > > +These keys will eventually be shown to the user.
> > > +
> > > +All stats are divided into three categories:
> > > +
> > > +\begin{itemize}
> > > +    \item dev stats: the stats of the device
> > > +        \begin{itemize}
> > > +            \item dev_version: The number of device version.
> > > +            \item dev_reset: The number of device reset.
> > > +        \end{itemize}
> > > +
> > > +    \item rx stats: the stats of the rx queue
> > > +        \begin{itemize}
> > > +            \item rx[N]_inter: The number of interrupts sent by the rx queue.
> > > +            \item rx[N]_drop: The number of packets dropped by the rx queue. Contains all kinds of packet loss.
> > > +            \item rx[N]_drop_overruns: The number of packets dropped by the rx queue when no more avail desc.
> > > +            \item rx[N]_csum_bad: The number of packets with abnormal csum in the rx queue.
> > > +            \item rx[N]_gso_packets: The number of gso packets received by rx.
> > > +            \item rx[N]_gso_bytes: The number of gso bytes received by rx.
> > > +            \item rx[N]_oversize_pkts: The number of oversized packets received by the rx queue.
> > > +        \end{itemize}
> > > +
> > > +    \item tx stats: the stats of the tx queue
> > > +        \begin{itemize}
> > > +            \item tx[N]_inter: The number of interrupts sent by the tx queue.
> > > +            \item tx[N]_drop: The number of packets dropped by the tx queue. Contains all kinds of packet loss.
> > > +            \item tx[N]_csum: The number of packets that completes csum by the device.
> > > +            \item tx[N]_gso_packets: The number of gso packets transmitted.
> > > +            \item tx[N]_gso_bytes: The number of gso bytes transmitted.
> > > +        \end{itemize}
> > > +\end{itemize}
> >
> > Let's use C stcture for this.
>
> The main purpose here is to define the order of these keys.
>
> This issue will be discussed below.
>
>
> >
> > > +
> > > +\subparagraph{Device stats get}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats keys / Device stats get}
> > > +
> > > +To get the stats, the following definitions are used:
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_CTRL_STATS        6
> > > +#define VIRTIO_NET_CTRL_STATS_GET    0
> > > +\end{lstlisting}
> > > +
> > > +The following layout structure are used:
> > > +
> > > +\field{command-specific-data}
> > > +\begin{lstlisting}
> > > +le64 queue_pair_index
> > > +le64 dev_stats_num;
> > > +le64 rx_stats_num;
> > > +le64 tx_stats_num;
> > > +\end{lstlisting}
> > > +
> > > +\field{command-specific-data-reply}
> > > +\begin{lstlisting}
> > > +le64 queue_pair_index
> > > +le64 dev_stats_num;
> > > +le64 rx_stats_num;
> > > +le64 tx_stats_num;
> > > +le64 dev_stats[dev_stats_num];
> > > +le64 rx_stats[rx_stats_num];
> > > +le64 tx_stats[tx_stats_num];
> > > +\end{lstlisting}
> > > +
> > > +The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this information.
> > > +
> > > +Regarding the variables in \field{command-specific-data}:
> > > +\begin{itemize}
> > > +    \item \field{queue_pair_index}: Specify the queue pair index of the queue that the driver wants to get stats.
> > > +    \item \field{dev_stats_num}: Indicates the number of dev stats supported by the driver.
> > > +    \item \field{rx_stats_num}: Indicates the number of stats information the driver wants for rx queue.
> > > +    \item \field{tx_stats_num}: Indicates the number of stats information the driver wants for tx queue.
> >
> > We have feature negotiation mechanism, so I think we don't need
> > dev_stats_num, {rx|tx}_stats_num here. Instead, all of those should be
> > inferred from the features.
>
> The feature just indicates that the driver can obtain status information from
> the device. But with the development, it is difficult for the device and the
> driver to support the new key synchronously. The feature is also difficult to
> sense how many new keys the driver and the device support respectively.

So I think the feature works fine for this.

VIRTIO_NET_F_CTRL_STATS -> stats set A
VIRTIO_NET_F_CTRL_STATS_X -> stats set A + stats set X
...

The point is to unbreak the migration. We don't want to surprise the
user if some of the keys were added or deleted after migration.

>
> For example, there are currently only two dev_stats, and both the device and the
> driver only support two keys. If the virtio spec adds a new dev stats, the
> driver may first support three keys, but the device still supports only two. The
> number of keys supported by both parties is needed to negotiate.

So let's say VIRTIO_NET_F_CTRL_STATS (two keys) but
VIRTIO_NET_F_CTRL_STATS_X has three keys.
In this case if VIRTIO_NET_F_CTRL_STATS_X is not supported by the
device (only two keys), it won't be negotiated and the driver knows
the device will only return 2 keys.

>
> dev_stats_num, (rx|tx)_stats_num exists for this purpose.
>
> I think the increase of these keys is a relatively frequent thing.

Probably not, looking at other NIC drivers the "keys" are pretty
stable. We can start from a large set anyhow.

Thanks

> It is also
> difficult to synchronize the support for new keys between drivers and devices.
>
> Thanks.
>
>
> >
> > Thanks
> >
> > > +\end{itemize}
> > > +
> > > +Regarding the variables in \field{command-specific-data-reply}:
> > > +\begin{itemize}
> > > +    \item All variables of \field{command-specific-data-reply} are set by the device.
> > > +    \item \field{queue_pair_index} MUST be equal to the variable with the same name in \field{command-specific-data}.
> > > +    \item These variables(\field{dev_stats_num}, \field{rx_stats_num}, \field{tx_stats_num}) MUST be
> > > +            less than or equal to the variables with the same name in \field{command-specific-data}.
> > > +            These values indicate the amount of stats actually filled in.
> > > +    \item \field{command-specific-data-reply} is meaningful only when \field{ack} is equal to VIRTIO_NET_OK.
> > > +\end{itemize}
> > > +
> > > +The variables \field{dev_stats_num}, \field{rx_stats_num}, \field{tx_stats_num} in \field{command-specific-data}
> > > +specify which stats the driver wants to get, but in fact the device may support
> > > +more or fewer stats.
> > > +
> > > +If the actual number of stats supported by the device is equal to or less than
> > > +the number that the driver wants to obtain, then the device MUST write all the
> > > +stats to the corresponding position of \field{command-specific-data-reply}.
> > > +
> > > +And if the number of stats actually supported by the device is more than the
> > > +driver requires, then the device MUST only write the number supported by the
> > > +driver.
> > > +
> > > +If the some of the variables \field{dev_stats_num}, \field{rx_stats_num}, \field{tx_stats_num} in \field{command-specific-data} are 0,
> > > +that means that the driver does not want to obtain this type of stats,
> > > +then the device MUST set the same name field in \field{command-specific-data-reply} to 0, and skip this type of stats.
> > > +
> > >  \section{Block Device}\label{sec:Device Types / Block Device}
> > >
> > >  The virtio block device is a simple virtual block device (ie.
> > > --
> > > 2.31.0
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

