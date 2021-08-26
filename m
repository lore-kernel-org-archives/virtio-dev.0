Return-Path: <virtio-dev-return-8605-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B41B89864EA
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Aug 2021 04:22:37 +0000 (UTC)
References: <20210823082733.128899-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dd115c74-ea1a-ac82-184b-c8d65e50c01a@redhat.com>
Date: Thu, 26 Aug 2021 12:22:25 +0800
MIME-Version: 1.0
In-Reply-To: <20210823082733.128899-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio-net: support device stats
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


=D4=DA 2021/8/23 =CF=C2=CE=E74:27, Xuan Zhuo =D0=B4=B5=C0:
> This patch allows the driver to obtain some statistics from the device.
>
> In the back-end implementation, we can count a lot of such information,
> which can be used for debugging and judging the running status of the
> back-end. We hope to directly display it to the user through ethtool.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v2: All keys define by this patch. Not defined by each backend.
>
>   content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 70a9765..b9fd10a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2978,6 +2978,9 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>
> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level stati=
stics
> +    to the driver through the control channel.
> +
>   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlik=
e UFO
>    (fragmenting the packet) the USO splits large UDP packet
>    to several segments when each of these smaller packets has UDP header.
> @@ -3023,6 +3026,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>   \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_N=
ET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>   \end{description}
> @@ -3901,6 +3905,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>           u8 command;
>           u8 command-specific-data[];
>           u8 ack;
> +        u8 command-specific-data-reply[];
>   };
>
>   /* ack values */
> @@ -3912,6 +3917,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>   driver, and the device sets the \field{ack} byte. There is little it ca=
n
>   do except issue a diagnostic if \field{ack} is not
>   VIRTIO_NET_OK.
> +\field{command-specific-data-reply} is alloced by driver, then pass to d=
evice.
> +It is filled by the device. It is optional. These commands need to get s=
ome
> +information from the device.
>
>   \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Packet Receive Filtering}
>   \label{sec:Device Types / Network Device / Device Operation / Control V=
irtqueue / Setting Promiscuous Mode}%old label for latexdiff
> @@ -4390,6 +4398,115 @@ \subsubsection{Legacy Interface: Framing Requirem=
ents}\label{sec:Device
>   See \ref{sec:Basic
>   Facilities of a Virtio Device / Virtqueues / Message Framing}.
>
> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Device stats}
> +
> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
> +get device stats from the device by \field{command-specific-data-reply}.
> +
> +\subparagraph{Device stats keys}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Device stats keys / Device stats =
keys}
> +
> +The keys of the device stats are defined as follows. When the device fil=
ls in
> +\field{command-specific-data-reply}, it MUST be written in the following=
 order.
> +Subsequent newly added keys MUST be added at the end of each category.
> +These keys will eventually be shown to the user.
> +
> +All stats are divided into three categories:
> +
> +\begin{itemize}
> +    \item dev stats: the stats of the device
> +        \begin{itemize}
> +            \item dev_freeze: The number of device freezes.
> +            \item dev_restore: The number of device restore.


Have we defined freezes/restore function int the spec?

And I think the key should be defined like a C macro as others in the spec.


> +        \end{itemize}
> +
> +    \item rx stats: the stats of the rx queue
> +        \begin{itemize}
> +            \item rx[N]_inter: The number of interrupts sent by the rx q=
ueue.
> +            \item rx[N]_drop: The number of packets dropped by the rx qu=
eue. Contains all kinds of packet loss.
> +            \item rx[N]_drop_overruns: The number of packets dropped by =
the rx queue when no more avail desc.
> +            \item rx[N]_csum_bad: The number of packets with abnormal cs=
um in the rx queue.
> +            \item rx[N]_lro_packets: The number of lro packets received =
by rx.
> +            \item rx[N]_lro_bytes: The number of lro bytes received by r=
x.


Let's use gso instead of lro since lro is never defined in the spec.


> +            \item rx[N]_oversize_pkts: The number of oversized packets r=
eceived by the rx queue.
> +        \end{itemize}
> +
> +    \item tx stats: the stats of the tx queue
> +        \begin{itemize}
> +            \item tx[N]_inter: The number of interrupts sent by the tx q=
ueue.
> +            \item tx[N]_drop: The number of packets dropped by the tx qu=
eue. Contains all kinds of packet loss.
> +            \item tx[N]_csum: The number of packets that completes csum =
by the device.
> +            \item tx[N]_tso_packets: The number of TSO packets transmitt=
ed.


Let's use gso instead.


> +            \item tx[N]_tso_bytes: The number of TSO bytes transmitted.
> +        \end{itemize}
> +\end{itemize}
> +
> +\subparagraph{Device stats get}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue / Device stats keys / Device stats g=
et}
> +
> +To get the stats, the following definitions are used:
> +\begin{lstlisting}
> +#define VIRTIO_NET_CTRL_STATS        6
> +#define VIRTIO_NET_CTRL_STATS_GET    0
> +\end{lstlisting}
> +
> +The following layout structure are used:
> +
> +\field{command-specific-data}
> +\begin{lstlisting}
> +le64 version;
> +le64 dev_stats_num;
> +le64 rx_num;
> +le64 tx_num;
> +le64 rx_stats_num;
> +le64 tx_stats_num;
> +\end{lstlisting}
> +
> +\field{command-specific-data-reply}
> +\begin{lstlisting}
> +le64 dev_stats_num;
> +le64 rx_num;
> +le64 tx_num;


Any reason for having this, can we simply use max_virtqueue_pairs?


> +le64 rx_stats_num;
> +le64 tx_stats_num;
> +le64 dev_stats[dev_stats_num];
> +le64 rx_stats[rx_stats_num][rx_num];
> +le64 tx_stats[tx_stats_num][tx_num];


I guess the version implies rx_stats_num?


> +\end{lstlisting}
> +
> +The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this information=
.
> +
> +Regarding the variables in \field{command-specific-data}:
> +\begin{itemize}
> +    \item \field{version}: This is used to specify the version of the la=
yout used. The current value MUST been 0.


I wonder if it's better to just extend the command instead of using=20
version here. E.g VIRTIO_NET_CTRL_STATS_GET_EXTRA etc.


> +    \item \field{dev_stats_num}: Indicates the number of dev stats suppo=
rted by the driver.
> +    \item \field{rx_num}: Indicates how many rx queue information the dr=
iver wants to receive.
> +    \item \field{tx_num}: Indicates how many tx queue information the dr=
iver wants to receive.
> +    \item \field{rx_stats_num}: Indicates the number of stats informatio=
n the driver wants for each rx queue.
> +    \item \field{tx_stats_num}: Indicates the number of stats informatio=
n the driver wants for each tx queue.
> +\end{itemize}
> +
> +When the driver allocates \field{command-specific-data-reply}, it should=
 set the
> +size of \field{command-specific-data-reply} based on the above values.
> +
> +\begin{lstlisting}
> +size =3D 5 * 8 + 8 * dev_stats_num + 8 * rx_num * rx_stats_num + 8 * tx_=
num * tx_stats_num;
> +\end{lstlisting}
> +
> +Regarding the variables in \field{command-specific-data-reply},
> +these variables(\field{dev_stats_num}, \field{rx_num}, \field{tx_num},
> +\field{rx_stats_num}, \field{tx_stats_num}) are set by the device and MU=
ST be
> +less than or equal to the variables with the same name in
> +\field{command-specific-data}.  These values indicate the amount actuall=
y filled
> +in. And the number of these implementations in
> +\field{command-specific-data-reply} is used as the size of the array dev=
_stats
> +and rx_stats and tx_stats.
> +
> +\field{command-specific-data-reply} is meaningful only when \field{ack} =
is equal to VIRTIO_NET_OK.
> +
> +\subparagraph{Legacy Interface: Device stats}\label{sec:Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Device stats / Legac=
y Interface: Device stats}
> +When using the legacy interface, transitional devices and drivers
> +MUST format the all variables according to the native endian of the gues=
t rather
> +than (necessarily when not using the legacy interface) little-endian.


I'm not sure it's worth to add the support for legacy driver. Since it=20
can't support VIRTIO_NET_F_CTRL_STATS because it has only 32 bit features.

Thanks


> +
>   \section{Block Device}\label{sec:Device Types / Block Device}
>
>   The virtio block device is a simple virtual block device (ie.
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

