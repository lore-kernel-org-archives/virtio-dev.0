Return-Path: <virtio-dev-return-8610-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B032A98657D
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Aug 2021 03:46:07 +0000 (UTC)
References: <1630034558.0759337-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b0c7217a-11f0-cf5f-6acc-08f466d71026@redhat.com>
Date: Fri, 27 Aug 2021 11:45:55 +0800
MIME-Version: 1.0
In-Reply-To: <1630034558.0759337-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio-net: support device stats
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2021/8/27 =E4=B8=8A=E5=8D=8811:22, Xuan Zhuo =E5=86=99=E9=81=93:
> On Thu, 26 Aug 2021 12:22:25 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
>> =E5=9C=A8 2021/8/23 =E4=B8=8B=E5=8D=884:27, Xuan Zhuo =E5=86=99=E9=81=93=
:
>>> This patch allows the driver to obtain some statistics from the device.
>>>
>>> In the back-end implementation, we can count a lot of such information,
>>> which can be used for debugging and judging the running status of the
>>> back-end. We hope to directly display it to the user through ethtool.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>> v2: All keys define by this patch. Not defined by each backend.
>>>
>>>    content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>>    1 file changed, 117 insertions(+)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index 70a9765..b9fd10a 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -2978,6 +2978,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contro=
l
>>>        channel.
>>>
>>> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level sta=
tistics
>>> +    to the driver through the control channel.
>>> +
>>>    \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Un=
like UFO
>>>     (fragmenting the packet) the USO splits large UDP packet
>>>     to several segments when each of these smaller packets has UDP head=
er.
>>> @@ -3023,6 +3026,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
>>>    \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTI=
O_NET_F_HOST_TSO6.
>>>    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \end{description}
>>> @@ -3901,6 +3905,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>>            u8 command;
>>>            u8 command-specific-data[];
>>>            u8 ack;
>>> +        u8 command-specific-data-reply[];
>>>    };
>>>
>>>    /* ack values */
>>> @@ -3912,6 +3917,9 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>>    driver, and the device sets the \field{ack} byte. There is little it=
 can
>>>    do except issue a diagnostic if \field{ack} is not
>>>    VIRTIO_NET_OK.
>>> +\field{command-specific-data-reply} is alloced by driver, then pass to=
 device.
>>> +It is filled by the device. It is optional. These commands need to get=
 some
>>> +information from the device.
>>>
>>>    \paragraph{Packet Receive Filtering}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>>>    \label{sec:Device Types / Network Device / Device Operation / Contro=
l Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
>>> @@ -4390,6 +4398,115 @@ \subsubsection{Legacy Interface: Framing Requir=
ements}\label{sec:Device
>>>    See \ref{sec:Basic
>>>    Facilities of a Virtio Device / Virtqueues / Message Framing}.
>>>
>>> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Device stats}
>>> +
>>> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
>>> +get device stats from the device by \field{command-specific-data-reply=
}.
>>> +
>>> +\subparagraph{Device stats keys}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Device stats keys / Device stat=
s keys}
>>> +
>>> +The keys of the device stats are defined as follows. When the device f=
ills in
>>> +\field{command-specific-data-reply}, it MUST be written in the followi=
ng order.
>>> +Subsequent newly added keys MUST be added at the end of each category.
>>> +These keys will eventually be shown to the user.
>>> +
>>> +All stats are divided into three categories:
>>> +
>>> +\begin{itemize}
>>> +    \item dev stats: the stats of the device
>>> +        \begin{itemize}
>>> +            \item dev_freeze: The number of device freezes.
>>> +            \item dev_restore: The number of device restore.
>>
>> Have we defined freezes/restore function int the spec?
>>
>> And I think the key should be defined like a C macro as others in the sp=
ec.
> Yes, I think these two should be deleted, adding a "dev_reset" would be m=
ore
> appropriate.
>
>>
>>> +        \end{itemize}
>>> +
>>> +    \item rx stats: the stats of the rx queue
>>> +        \begin{itemize}
>>> +            \item rx[N]_inter: The number of interrupts sent by the rx=
 queue.
>>> +            \item rx[N]_drop: The number of packets dropped by the rx =
queue. Contains all kinds of packet loss.
>>> +            \item rx[N]_drop_overruns: The number of packets dropped b=
y the rx queue when no more avail desc.
>>> +            \item rx[N]_csum_bad: The number of packets with abnormal =
csum in the rx queue.
>>> +            \item rx[N]_lro_packets: The number of lro packets receive=
d by rx.
>>> +            \item rx[N]_lro_bytes: The number of lro bytes received by=
 rx.
>>
>> Let's use gso instead of lro since lro is never defined in the spec.
> OK.
>
>>
>>> +            \item rx[N]_oversize_pkts: The number of oversized packets=
 received by the rx queue.
>>> +        \end{itemize}
>>> +
>>> +    \item tx stats: the stats of the tx queue
>>> +        \begin{itemize}
>>> +            \item tx[N]_inter: The number of interrupts sent by the tx=
 queue.
>>> +            \item tx[N]_drop: The number of packets dropped by the tx =
queue. Contains all kinds of packet loss.
>>> +            \item tx[N]_csum: The number of packets that completes csu=
m by the device.
>>> +            \item tx[N]_tso_packets: The number of TSO packets transmi=
tted.
>>
>> Let's use gso instead.
>>
>>
>>> +            \item tx[N]_tso_bytes: The number of TSO bytes transmitted=
.
>>> +        \end{itemize}
>>> +\end{itemize}
>>> +
>>> +\subparagraph{Device stats get}\label{sec:Device Types / Network Devic=
e / Device Operation / Control Virtqueue / Device stats keys / Device stats=
 get}
>>> +
>>> +To get the stats, the following definitions are used:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_CTRL_STATS        6
>>> +#define VIRTIO_NET_CTRL_STATS_GET    0
>>> +\end{lstlisting}
>>> +
>>> +The following layout structure are used:
>>> +
>>> +\field{command-specific-data}
>>> +\begin{lstlisting}
>>> +le64 version;
>>> +le64 dev_stats_num;
>>> +le64 rx_num;
>>> +le64 tx_num;
>>> +le64 rx_stats_num;
>>> +le64 tx_stats_num;
>>> +\end{lstlisting}
>>> +
>>> +\field{command-specific-data-reply}
>>> +\begin{lstlisting}
>>> +le64 dev_stats_num;
>>> +le64 rx_num;
>>> +le64 tx_num;
>>
>> Any reason for having this, can we simply use max_virtqueue_pairs?
>>
> Theoretically, rx_num and tx_num can be removed, and all use
> max_virtqueue_pairs.
> The reason for not doing this are:
>
> 1. Explicitly specify rx_num, tx_num in the command-specific-data, rather=
 than
> implicitly use max_virtqueue_pairs because this is related to the size of=
 the
> command-specific-data-reply allocated by the driver.


I'm not quite sure how useful for this. E.g the device can fail if the=20
buffer doesn't have sufficient space in this case.


>
> 2. The number of queues that the driver may actually use is less than
> max_virtqueue_pairs, so you don't need to get the stats of all the queues=
.


Yes, but it doesn't harm. E.g we have 4 max virtqueue pairs. And we do=20
the following changes:

1) use 2 qp
2) use 4 qp
3) use 2 qp

After those steps we may still need to know the stats of all qps.


>
> 3. In addition, I am not sure, whether to add rx_index, tx_index used to
> specify which rx/tx to start from. Then we can specify to obtain certain =
rx
> or tx information. I am not sure whether to add such a function.


I think if a simple interface work we probably don't want a complicated=20
one. E.g the software (ethtool) can choose to expose partial stats.


>
>
>
>
> The addition of tx_num and rx_num in the command-specific-data-reply is t=
o
> consider that the driver may set rx_num and tx_num in the command-specifi=
c-data
> to be too large or too small. So the reply clearly pointed out that the a=
ctual
> number of rx and tx replies .
>
>>> +le64 rx_stats_num;
>>> +le64 tx_stats_num;
>>> +le64 dev_stats[dev_stats_num];
>>> +le64 rx_stats[rx_stats_num][rx_num];
>>> +le64 tx_stats[tx_stats_num][tx_num];
>>
>> I guess the version implies rx_stats_num?
>>
> Sorry, I didn't understand the meaning.


I meant, e.g the device/drivers should know how many stats that will be=20
fetched if a version is specified.

Or is there a chance that we may have different rx_stats_num for one=20
version?

Thanks


>
>>> +\end{lstlisting}
>>> +
>>> +The command VIRTIO_NET_CTRL_STATS_GET is used to obtain this informati=
on.
>>> +
>>> +Regarding the variables in \field{command-specific-data}:
>>> +\begin{itemize}
>>> +    \item \field{version}: This is used to specify the version of the =
layout used. The current value MUST been 0.
>>
>> I wonder if it's better to just extend the command instead of using
>> version here. E.g VIRTIO_NET_CTRL_STATS_GET_EXTRA etc.
> Yes, the new command is better than "version".
>
>>
>>> +    \item \field{dev_stats_num}: Indicates the number of dev stats sup=
ported by the driver.
>>> +    \item \field{rx_num}: Indicates how many rx queue information the =
driver wants to receive.
>>> +    \item \field{tx_num}: Indicates how many tx queue information the =
driver wants to receive.
>>> +    \item \field{rx_stats_num}: Indicates the number of stats informat=
ion the driver wants for each rx queue.
>>> +    \item \field{tx_stats_num}: Indicates the number of stats informat=
ion the driver wants for each tx queue.
>>> +\end{itemize}
>>> +
>>> +When the driver allocates \field{command-specific-data-reply}, it shou=
ld set the
>>> +size of \field{command-specific-data-reply} based on the above values.
>>> +
>>> +\begin{lstlisting}
>>> +size =3D 5 * 8 + 8 * dev_stats_num + 8 * rx_num * rx_stats_num + 8 * t=
x_num * tx_stats_num;
>>> +\end{lstlisting}
>>> +
>>> +Regarding the variables in \field{command-specific-data-reply},
>>> +these variables(\field{dev_stats_num}, \field{rx_num}, \field{tx_num},
>>> +\field{rx_stats_num}, \field{tx_stats_num}) are set by the device and =
MUST be
>>> +less than or equal to the variables with the same name in
>>> +\field{command-specific-data}.  These values indicate the amount actua=
lly filled
>>> +in. And the number of these implementations in
>>> +\field{command-specific-data-reply} is used as the size of the array d=
ev_stats
>>> +and rx_stats and tx_stats.
>>> +
>>> +\field{command-specific-data-reply} is meaningful only when \field{ack=
} is equal to VIRTIO_NET_OK.
>>> +
>>> +\subparagraph{Legacy Interface: Device stats}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue / Device stats / Leg=
acy Interface: Device stats}
>>> +When using the legacy interface, transitional devices and drivers
>>> +MUST format the all variables according to the native endian of the gu=
est rather
>>> +than (necessarily when not using the legacy interface) little-endian.
>>
>> I'm not sure it's worth to add the support for legacy driver. Since it
>> can't support VIRTIO_NET_F_CTRL_STATS because it has only 32 bit feature=
s.
> OK. I will remove this in the next version.
>
> Thanks.
>
>> Thanks
>>
>>
>>> +
>>>    \section{Block Device}\label{sec:Device Types / Block Device}
>>>
>>>    The virtio block device is a simple virtual block device (ie.
>>> --
>>> 2.31.0
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

