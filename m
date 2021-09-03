Return-Path: <virtio-dev-return-8632-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D22999865D6
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Sep 2021 02:11:52 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <1630634768.0678208-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 03 Sep 2021 10:06:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
In-Reply-To: <add004a7-c0f5-8800-54a6-9f1bc01050e7@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio-net: support device stats
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 2 Sep 2021 15:39:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2021/8/27 =E4=B8=8B=E5=8D=882:58, Xuan Zhuo =E5=86=99=E9=81=93:
> > On Fri, 27 Aug 2021 11:45:55 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> >> =E5=9C=A8 2021/8/27 =E4=B8=8A=E5=8D=8811:22, Xuan Zhuo =E5=86=99=E9=81=
=93:
> >>> On Thu, 26 Aug 2021 12:22:25 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> >>>> =E5=9C=A8 2021/8/23 =E4=B8=8B=E5=8D=884:27, Xuan Zhuo =E5=86=99=E9=
=81=93:
> >>>>> This patch allows the driver to obtain some statistics from the dev=
ice.
> >>>>>
> >>>>> In the back-end implementation, we can count a lot of such informat=
ion,
> >>>>> which can be used for debugging and judging the running status of t=
he
> >>>>> back-end. We hope to directly display it to the user through ethtoo=
l.
> >>>>>
> >>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>> ---
> >>>>> v2: All keys define by this patch. Not defined by each backend.
> >>>>>
> >>>>>     content.tex | 117 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> >>>>>     1 file changed, 117 insertions(+)
> >>>>>
> >>>>> diff --git a/content.tex b/content.tex
> >>>>> index 70a9765..b9fd10a 100644
> >>>>> --- a/content.tex
> >>>>> +++ b/content.tex
> >>>>> @@ -2978,6 +2978,9 @@ \subsection{Feature bits}\label{sec:Device Ty=
pes / Network Device / Feature bits
> >>>>>     \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through c=
ontrol
> >>>>>         channel.
> >>>>>
> >>>>> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level=
 statistics
> >>>>> +    to the driver through the control channel.
> >>>>> +
> >>>>>     \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packet=
s. Unlike UFO
> >>>>>      (fragmenting the packet) the USO splits large UDP packet
> >>>>>      to several segments when each of these smaller packets has UDP=
 header.
> >>>>> @@ -3023,6 +3026,7 @@ \subsubsection{Feature bit requirements}\labe=
l{sec:Device Types / Network Device
> >>>>>     \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_V=
Q.
> >>>>>     \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
> >>>>>     \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ=
.
> >>>>> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
> >>>>>     \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or =
VIRTIO_NET_F_HOST_TSO6.
> >>>>>     \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >>>>>     \end{description}
> >>>>> @@ -3901,6 +3905,7 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> >>>>>             u8 command;
> >>>>>             u8 command-specific-data[];
> >>>>>             u8 ack;
> >>>>> +        u8 command-specific-data-reply[];
> >>>>>     };
> >>>>>
> >>>>>     /* ack values */
> >>>>> @@ -3912,6 +3917,9 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> >>>>>     driver, and the device sets the \field{ack} byte. There is litt=
le it can
> >>>>>     do except issue a diagnostic if \field{ack} is not
> >>>>>     VIRTIO_NET_OK.
> >>>>> +\field{command-specific-data-reply} is alloced by driver, then pas=
s to device.
> >>>>> +It is filled by the device. It is optional. These commands need to=
 get some
> >>>>> +information from the device.
> >>>>>
> >>>>>     \paragraph{Packet Receive Filtering}\label{sec:Device Types / N=
etwork Device / Device Operation / Control Virtqueue / Packet Receive Filte=
ring}
> >>>>>     \label{sec:Device Types / Network Device / Device Operation / C=
ontrol Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> >>>>> @@ -4390,6 +4398,115 @@ \subsubsection{Legacy Interface: Framing Re=
quirements}\label{sec:Device
> >>>>>     See \ref{sec:Basic
> >>>>>     Facilities of a Virtio Device / Virtqueues / Message Framing}.
> >>>>>
> >>>>> +\paragraph{Device stats}\label{sec:Device Types / Network Device /=
 Device Operation / Control Virtqueue / Device stats}
> >>>>> +
> >>>>> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver c=
an
> >>>>> +get device stats from the device by \field{command-specific-data-r=
eply}.
> >>>>> +
> >>>>> +\subparagraph{Device stats keys}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Device stats keys / Device =
stats keys}
> >>>>> +
> >>>>> +The keys of the device stats are defined as follows. When the devi=
ce fills in
> >>>>> +\field{command-specific-data-reply}, it MUST be written in the fol=
lowing order.
> >>>>> +Subsequent newly added keys MUST be added at the end of each categ=
ory.
> >>>>> +These keys will eventually be shown to the user.
> >>>>> +
> >>>>> +All stats are divided into three categories:
> >>>>> +
> >>>>> +\begin{itemize}
> >>>>> +    \item dev stats: the stats of the device
> >>>>> +        \begin{itemize}
> >>>>> +            \item dev_freeze: The number of device freezes.
> >>>>> +            \item dev_restore: The number of device restore.
> >>>> Have we defined freezes/restore function int the spec?
> >>>>
> >>>> And I think the key should be defined like a C macro as others in th=
e spec.
> >>> Yes, I think these two should be deleted, adding a "dev_reset" would =
be more
> >>> appropriate.
> >>>
> >>>>> +        \end{itemize}
> >>>>> +
> >>>>> +    \item rx stats: the stats of the rx queue
> >>>>> +        \begin{itemize}
> >>>>> +            \item rx[N]_inter: The number of interrupts sent by th=
e rx queue.
> >>>>> +            \item rx[N]_drop: The number of packets dropped by the=
 rx queue. Contains all kinds of packet loss.
> >>>>> +            \item rx[N]_drop_overruns: The number of packets dropp=
ed by the rx queue when no more avail desc.
> >>>>> +            \item rx[N]_csum_bad: The number of packets with abnor=
mal csum in the rx queue.
> >>>>> +            \item rx[N]_lro_packets: The number of lro packets rec=
eived by rx.
> >>>>> +            \item rx[N]_lro_bytes: The number of lro bytes receive=
d by rx.
> >>>> Let's use gso instead of lro since lro is never defined in the spec.
> >>> OK.
> >>>
> >>>>> +            \item rx[N]_oversize_pkts: The number of oversized pac=
kets received by the rx queue.
> >>>>> +        \end{itemize}
> >>>>> +
> >>>>> +    \item tx stats: the stats of the tx queue
> >>>>> +        \begin{itemize}
> >>>>> +            \item tx[N]_inter: The number of interrupts sent by th=
e tx queue.
> >>>>> +            \item tx[N]_drop: The number of packets dropped by the=
 tx queue. Contains all kinds of packet loss.
> >>>>> +            \item tx[N]_csum: The number of packets that completes=
 csum by the device.
> >>>>> +            \item tx[N]_tso_packets: The number of TSO packets tra=
nsmitted.
> >>>> Let's use gso instead.
> >>>>
> >>>>
> >>>>> +            \item tx[N]_tso_bytes: The number of TSO bytes transmi=
tted.
> >>>>> +        \end{itemize}
> >>>>> +\end{itemize}
> >>>>> +
> >>>>> +\subparagraph{Device stats get}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Device stats keys / Device s=
tats get}
> >>>>> +
> >>>>> +To get the stats, the following definitions are used:
> >>>>> +\begin{lstlisting}
> >>>>> +#define VIRTIO_NET_CTRL_STATS        6
> >>>>> +#define VIRTIO_NET_CTRL_STATS_GET    0
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +The following layout structure are used:
> >>>>> +
> >>>>> +\field{command-specific-data}
> >>>>> +\begin{lstlisting}
> >>>>> +le64 version;
> >>>>> +le64 dev_stats_num;
> >>>>> +le64 rx_num;
> >>>>> +le64 tx_num;
> >>>>> +le64 rx_stats_num;
> >>>>> +le64 tx_stats_num;
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +\field{command-specific-data-reply}
> >>>>> +\begin{lstlisting}
> >>>>> +le64 dev_stats_num;
> >>>>> +le64 rx_num;
> >>>>> +le64 tx_num;
> >>>> Any reason for having this, can we simply use max_virtqueue_pairs?
> >>>>
> >>> Theoretically, rx_num and tx_num can be removed, and all use
> >>> max_virtqueue_pairs.
> >>> The reason for not doing this are:
> >>>
> >>> 1. Explicitly specify rx_num, tx_num in the command-specific-data, ra=
ther than
> >>> implicitly use max_virtqueue_pairs because this is related to the siz=
e of the
> >>> command-specific-data-reply allocated by the driver.
> >>
> >> I'm not quite sure how useful for this. E.g the device can fail if the
> >> buffer doesn't have sufficient space in this case.
> >>
> >>
> >>> 2. The number of queues that the driver may actually use is less than
> >>> max_virtqueue_pairs, so you don't need to get the stats of all the qu=
eues.
> >>
> >> Yes, but it doesn't harm. E.g we have 4 max virtqueue pairs. And we do
> >> the following changes:
> >>
> >> 1) use 2 qp
> >> 2) use 4 qp
> >> 3) use 2 qp
> >>
> >> After those steps we may still need to know the stats of all qps.
> > I think, I have complicated the problem. I will delete rx_num, tx_num f=
rom
> > command-specific-data and command-specific-data-reply in the next versi=
on.
> >
> > But I still think that a queue_pairs should be added to the
> > command-specific-data to display the information indicating the maximum=
 number
> > of queues that can be placed in the command-specific-data-reply. Althou=
gh this
> > value should be equal to max_virtqueue_pairs. This is related to the si=
ze
> > of command-specific-data-reply.
>
>
> Re-think about this. I think we probably need to do something even more
> simpler.
>
> Fetch the stats once per queue pair.
>
> E.g specify the queue pair index as command-specific data. And then
> software can choose how many queue pairs it want to read?

The following is the last time I replied to you, it is to use queue_pairs
instead of rx_num, tx_num.

\field{command-specific-data}
\begin{lstlisting}
le64 dev_stats_num;
le64 rx_stats_num;
le64 tx_stats_num;
le64 queue_pairs;
\end{lstlisting}

\field{command-specific-data-reply}
\begin{lstlisting}
le64 dev_stats_num;
le64 rx_stats_num;
le64 tx_stats_num;
le64 dev_stats[dev_stats_num];
le64 rx_stats[rx_stats_num][queue_pairs];
le64 tx_stats[tx_stats_num][queue_pairs];
\end{lstlisting}


I don't know if I understand it right, do you mean to use the following
structure to get the information of the specified number of queue pairs bas=
ed on
queue_pair_index/queue_pair_num?

queue_pair_index
\field{command-specific-data}
\begin{lstlisting}
le64 dev_stats_num;
le64 rx_stats_num;
le64 tx_stats_num;
le64 queue_pair_index;
le64 queue_pair_num;
\end{lstlisting}

Thanks.

>
> Thanks
>
>
> >
> >>
> >>> 3. In addition, I am not sure, whether to add rx_index, tx_index used=
 to
> >>> specify which rx/tx to start from. Then we can specify to obtain cert=
ain rx
> >>> or tx information. I am not sure whether to add such a function.
> >>
> >> I think if a simple interface work we probably don't want a complicate=
d
> >> one. E.g the software (ethtool) can choose to expose partial stats.
> > Yes.
> >
> >>
> >>>
> >>>
> >>>
> >>> The addition of tx_num and rx_num in the command-specific-data-reply =
is to
> >>> consider that the driver may set rx_num and tx_num in the command-spe=
cific-data
> >>> to be too large or too small. So the reply clearly pointed out that t=
he actual
> >>> number of rx and tx replies .
> >>>
> >>>>> +le64 rx_stats_num;
> >>>>> +le64 tx_stats_num;
> >>>>> +le64 dev_stats[dev_stats_num];
> >>>>> +le64 rx_stats[rx_stats_num][rx_num];
> >>>>> +le64 tx_stats[tx_stats_num][tx_num];
> >>>> I guess the version implies rx_stats_num?
> >>>>
> >>> Sorry, I didn't understand the meaning.
> >>
> >> I meant, e.g the device/drivers should know how many stats that will b=
e
> >> fetched if a version is specified.
> >>
> >> Or is there a chance that we may have different rx_stats_num for one
> >> version?
> > First of all, as we discussed before, the "version" has been removed. I=
f the
> > structure of the later command-specific-data or command-specific-data-r=
eply
> > changes, we should add a new command.
> >
> > And considering that the change of stats keys is relatively a frequent =
event. So
> > I consider using rx_stats_num/tx_stats_num to negotiate the number of s=
tats
> > between the driver and the device. Because the order of stats is fixed,=
 and the
> > newly added keys are always maintained at the end, so as long as we kno=
w the
> > number of stats supported by the driver or device, we can know which ke=
ys the
> > other party supports.
> >
> > Therefore, the rx_stats_num/tx_stats_num in the command-specific-data i=
s used to
> > inform the device, the number of stats supported by the driver, and how=
 much
> > space is allocated.
> >
> > The rx_stats_num/tx_stats_num in the command-specific-data-reply is use=
d to tell
> > the driver the number of stats actually supported by the device.
> >
> > The function of dev_stats_num is similar.
> >
> > \field{command-specific-data}
> > \begin{lstlisting}
> > le64 dev_stats_num;
> > le64 rx_stats_num;
> > le64 tx_stats_num;
> > le64 queue_pairs;
> > \end{lstlisting}
> >
> > \field{command-specific-data-reply}
> > \begin{lstlisting}
> > le64 dev_stats_num;
> > le64 rx_stats_num;
> > le64 tx_stats_num;
> > le64 dev_stats[dev_stats_num];
> > le64 rx_stats[rx_stats_num][queue_pairs];
> > le64 tx_stats[tx_stats_num][queue_pairs];
> > \end{lstlisting}
> >
> >
> > Thanks.
> >
> >> Thanks
> >>
> >>
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this infor=
mation.
> >>>>> +
> >>>>> +Regarding the variables in \field{command-specific-data}:
> >>>>> +\begin{itemize}
> >>>>> +    \item \field{version}: This is used to specify the version of =
the layout used. The current value MUST been 0.
> >>>> I wonder if it's better to just extend the command instead of using
> >>>> version here. E.g VIRTIO_NET_CTRL_STATS_GET_EXTRA etc.
> >>> Yes, the new command is better than "version".
> >>>
> >>>>> +    \item \field{dev_stats_num}: Indicates the number of dev stats=
 supported by the driver.
> >>>>> +    \item \field{rx_num}: Indicates how many rx queue information =
the driver wants to receive.
> >>>>> +    \item \field{tx_num}: Indicates how many tx queue information =
the driver wants to receive.
> >>>>> +    \item \field{rx_stats_num}: Indicates the number of stats info=
rmation the driver wants for each rx queue.
> >>>>> +    \item \field{tx_stats_num}: Indicates the number of stats info=
rmation the driver wants for each tx queue.
> >>>>> +\end{itemize}
> >>>>> +
> >>>>> +When the driver allocates \field{command-specific-data-reply}, it =
should set the
> >>>>> +size of \field{command-specific-data-reply} based on the above val=
ues.
> >>>>> +
> >>>>> +\begin{lstlisting}
> >>>>> +size =3D 5 * 8 + 8 * dev_stats_num + 8 * rx_num * rx_stats_num + 8=
 * tx_num * tx_stats_num;
> >>>>> +\end{lstlisting}
> >>>>> +
> >>>>> +Regarding the variables in \field{command-specific-data-reply},
> >>>>> +these variables(\field{dev_stats_num}, \field{rx_num}, \field{tx_n=
um},
> >>>>> +\field{rx_stats_num}, \field{tx_stats_num}) are set by the device =
and MUST be
> >>>>> +less than or equal to the variables with the same name in
> >>>>> +\field{command-specific-data}.  These values indicate the amount a=
ctually filled
> >>>>> +in. And the number of these implementations in
> >>>>> +\field{command-specific-data-reply} is used as the size of the arr=
ay dev_stats
> >>>>> +and rx_stats and tx_stats.
> >>>>> +
> >>>>> +\field{command-specific-data-reply} is meaningful only when \field=
{ack} is equal to VIRTIO_NET_OK.
> >>>>> +
> >>>>> +\subparagraph{Legacy Interface: Device stats}\label{sec:Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Device stats /=
 Legacy Interface: Device stats}
> >>>>> +When using the legacy interface, transitional devices and drivers
> >>>>> +MUST format the all variables according to the native endian of th=
e guest rather
> >>>>> +than (necessarily when not using the legacy interface) little-endi=
an.
> >>>> I'm not sure it's worth to add the support for legacy driver. Since =
it
> >>>> can't support VIRTIO_NET_F_CTRL_STATS because it has only 32 bit fea=
tures.
> >>> OK. I will remove this in the next version.
> >>>
> >>> Thanks.
> >>>
> >>>> Thanks
> >>>>
> >>>>
> >>>>> +
> >>>>>     \section{Block Device}\label{sec:Device Types / Block Device}
> >>>>>
> >>>>>     The virtio block device is a simple virtual block device (ie.
> >>>>> --
> >>>>> 2.31.0
> >>>>>
> >>>>>
> >>>>> -------------------------------------------------------------------=
--
> >>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
> >>>>>
> >>>> --------------------------------------------------------------------=
-
> >>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g
> >>>>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

