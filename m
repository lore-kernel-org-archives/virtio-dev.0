Return-Path: <jasowang@redhat.com>
Message-ID: <9b5cb95d-7d20-e2b0-b7e8-306106879753@redhat.com>
Date: Mon, 17 Jan 2022 15:06:52 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v8] virtio-net: support device stats
References: <1642385675.245206-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1642385675.245206-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/17 上午10:14, Xuan Zhuo 写道:
> On Sat, 15 Jan 2022 13:17:26 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Tue, Jan 11, 2022 at 12:01:25PM +0800, Xuan Zhuo wrote:
>>> This patch allows the driver to obtain some statistics from the device.
>>>
>>> In the back-end implementation, we can count a lot of such information,
>>> which can be used for debugging and judging the running status of the
>>> back-end. We hope to directly display it to the user through ethtool.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Reviewed-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>
>>> v8:
>>> 1. Modified based on comments by Cornelia Huck
>>>
>>> v7:
>>> 1. add rx_reset, tx_reset
>>> 2. add device normative and dirver normative
>>> 3. add comments for *_packets, *_bytres
>>>
>>> v6:
>>> 1. correct the names and descriptions of some stats items
>>>
>>> v5:
>>> 1. add VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
>>> 2. more item for virtio_net_ctrl_reply_stats_queue_pair
>>>
>>> v4:
>>> 1. remove dev_stats_num, {rx|tx}_stats_num
>>> 2. Use two commands to get the stats of queue pair and dev respectively
>>>
>>> v3 changes:
>>> 1. add dev_version
>>> 2. use queue_pair_index replace rx_num, tx_num
>>> 3. Explain the processing when the device and driver support different numbers
>>> of stats
>>>
>>>   conformance.tex |   2 +
>>>   content.tex     | 133 +++++++++++++++++++++++++++++++++++++++++++++++-
>>>   2 files changed, 134 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/conformance.tex b/conformance.tex
>>> index 42f8537..950924e 100644
>>> --- a/conformance.tex
>>> +++ b/conformance.tex
>>> @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>>> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>>>   \end{itemize}
>>>
>>>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
>>> @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>>> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>>>   \end{itemize}
>>>
>>>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
>>> diff --git a/content.tex b/content.tex
>>> index cf20570..fa385e2 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>       channel.
>>>
>>> +\item[VIRTIO_NET_F_CTRL_STATS(55)] Device can provide device-level statistics
>>> +    to the driver through the control channel.
>>> +
>>>   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
>>>    (fragmenting the packet) the USO splits large UDP packet
>>>    to several segments when each of these smaller packets has UDP header.
>>> @@ -3137,6 +3140,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>>   \item[VIRTIO_NET_F_GUEST_ANNOUNCE] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_MQ] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_CTRL_STATS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \end{description}
>>> @@ -4015,6 +4019,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>           u8 command;
>>>           u8 command-specific-data[];
>>>           u8 ack;
>>> +        u8 command-specific-data-reply[];
>>>   };
>>>
>>>   /* ack values */
>> we now need to document which commands include the reply,
>> otherwise reader will be confused.
> OK.
>
>>> @@ -4023,7 +4028,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>   \end{lstlisting}
>>>
>>>   The \field{class}, \field{command} and command-specific-data are set by the
>>> -driver, and the device sets the \field{ack} byte. There is little it can
>>> +driver, and the device sets the \field{ack} byte and optionally
>>> +\field{command-specific-data-reply}. There is little it can
>>>   do
>> Now "it" refers to device where it used to refer to the driver.
>      There is little it can except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
>
> I don't feel like this has changed or affected anything.
> Can you help me change it?
>
>
>>> except issue a diagnostic if \field{ack} is not
>>>   VIRTIO_NET_OK.
>>>
>>> @@ -4471,6 +4477,131 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>>   according to the native endian of the guest rather than
>>>   (necessarily when not using the legacy interface) little-endian.
>>>
>>> +\paragraph{Device stats}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>>> +
>>> +If the VIRTIO_NET_F_CTRL_STATS feature is negotiated, the driver can
>>> +get device stats from the device in \field{command-specific-data-reply}.
>>> +
>>> +To get the stats, the following definitions are used:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_CTRL_STATS                  6
>>> +#define VIRTIO_NET_CTRL_STATS_GET_DEV          0
>>> +#define VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ      1
>>> +#define VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR   2
>>> +\end{lstlisting}
>>> +
>>> +The following layout structures are used:
>>> +
>>> +\field{command-specific-data}
>>> +\begin{lstlisting}
>>> +struct virtio_net_ctrl_stats_queue_pair {
>>> +    le64 queue_pair_index;
>>> +}
>>> +\end{lstlisting}
>>> +
>>> +\field{command-specific-data-reply}
>>> +\begin{lstlisting}
>>> +struct virtio_net_ctrl_reply_stats_dev {
>>> +    le64 dev_reset;         // The number of device resets.
>> while we already have some places using // comments, they
>> are not used consistently. Better to use /* text */ for now.
> OK.
>
>>> +}
>>
>>
>> I am still worrying about this one. I think it's a bit vague.
>> Some types of reset will zero this counter, others will not.
>> Also, this looks more like a generic capability than anything
>> specific to net. And this raises questions about .
>
> I think, I should define that the device will not set this variable to 0 during
> reset.
>
> The purpose of adding this is to count the number of times the user deletes/adds
> the network card. The virtio-net device may be deleted/added by the user
> multiple times, and this is reflected in the device layer as the number of
> resets.
>
>>
>>
>>> +
>>> +struct virtio_net_ctrl_reply_stats_cvq {
>>> +    le64 request_num; // The number of requests.
>> We call them commands elsewhere. It is however unclear whether
>> the request for the stats itself is included in the counter.
>> Also, do these counters reset on device reset? I would
>> assume so but given dev_reset does not reset it's hard to be
>> sure.
>
> I will change request -> command.
>
> We should really define that the device should not reset these statistics during
> reset
>
>
>>> +    le64 ok_num;      // The number of ok acks.
>>> +    le64 err_num;     // The number of err acks.
>> A bit more precise pls: e.g. "the number of commands where ack was
>> VIRTIO_NET_OK"?
>
> OK
>
>>
>>> +
>>> +    le64 req_rx_promisc;         // The number of requests with command VIRTIO_NET_CTRL_RX_PROMISC.
>>> +    le64 req_rx_allmulti;        // The number of requests with command VIRTIO_NET_CTRL_RX_ALLMULTI.
>>> +    le64 req_rx_alluni;          // The number of requests with command VIRTIO_NET_CTRL_RX_ALLUNI.
>>> +    le64 req_rx_nomulti;         // The number of requests with command VIRTIO_NET_CTRL_RX_NOMULTI.
>>> +    le64 req_rx_nouni;           // The number of requests with command VIRTIO_NET_CTRL_RX_NOUNI.
>>> +    le64 req_rx_nobcast;         // The number of requests with command VIRTIO_NET_CTRL_RX_NOBCAST.
>>> +    le64 req_mac_table_set;      // The number of requests with command VIRTIO_NET_CTRL_MAC_TABLE_SET.
>>> +    le64 req_mac_addr_set;       // The number of requests with command VIRTIO_NET_CTRL_MAC_ADDR_SET.
>>> +    le64 req_vlan_add;           // The number of requests with command VIRTIO_NET_CTRL_VLAN_ADD.
>>> +    le64 req_vlan_del;           // The number of requests with command VIRTIO_NET_CTRL_VLAN_DEL.
>>> +    le64 req_announce_ack;       // The number of requests with command VIRTIO_NET_CTRL_ANNOUNCE_ACK.
>>> +    le64 req_mq_vq_pairs_set;    // The number of requests with command VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
>>> +    le64 req_mq_rss_config;      // The number of requests with command VIRTIO_NET_CTRL_MQ_RSS_CONFIG.
>>> +    le64 req_mq_hash_config;     // The number of requests with command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
>>> +    le64 req_guest_offloads_set; // The number of requests with command VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET.
>>> +}
>>
>> I just had an idea:
>> how about the query passes in the command we are debugging instead?
>> this way we do not need to extend this each time.
>>
> Do you mean command-specific-data uses a structure like this:
>
> {
> 	le64 class;
> 	le64 command;
> }
>
> This is indeed a really great idea.


This probably only work if we mandate the dependency to stats for any 
new added control vq features.


>
>
>>
>>
>>> +
>>> +struct virtio_net_ctrl_reply_stats_queue_pair {
>>> +    /* rx stats */
>>> +    le64 rx_packets;          // The number of packets recived by device, including the dropped packets by device.
>>> +    le64 rx_bytes;            // The number of bytes recived by device, including the dropped packets by device.
>> typos: received
>>
>>
>>> +
>>> +    le64 rx_notification;     // The number of notifications from driver.
>>> +    le64 rx_interrupt;        // The number of interrupts generated by device.
>>> +
>>> +    le64 rx_drop;             // The number of packets dropped by the rx queue. Contains all kinds of packet drop.
>>> +    le64 rx_drop_overruns;    // The number of packets dropped by the rx queue when no more descriptors were available.
>>> +    le64 rx_drop_oversize;    // The number of oversized packets received by the rx queue.
>> What does oversized mean in this context? does it apply to
>> mergeable buffers?
> For mergeable buffers this statistic is meaningless.


I guess not, we may run out of descriptors even in this case.


>
>>> +
>>> +    le64 rx_csum_valid;       // The number of packets with VIRTIO_NET_HDR_F_DATA_VALID.
>>> +    le64 rx_csum_partial;     // The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
>>> +    le64 rx_csum_bad;         // The number of packets with abnormal csum.
>>> +    le64 rx_csum_none;        // The number of packets without hardware csum.
>> I assume they are only incremented with VIRTIO_NET_F_GUEST_CSUM?
> Yes
>
>>> +
>>> +    le64 rx_gso_packets;      // The number of gso packets received by rx.
>> let's spell it out: I think this means any packet
>> put into VQ and with gso_type != VIRTIO_NET_HDR_GSO_NONE
> Yes
>
>
>>> +    le64 rx_gso_bytes;        // The number of gso bytes received by rx.
>> this one is a bit vague: I assume these are bytes written into the RX VQ buffers?
>> the difference is that multiple packets are combined into a
>> single gso packet.
>> and does this include the virtio net header?
> I think all *_bytes statistics do not include virtio net header, the packet
> bytes we care about does not include virtio net header.
>
> Multiple packets are combined into one, and some network headers, such as
> ip/tcp, etc., are also removed. The final count is the bytes that are finalized
> to the RV VQ buffers.
>
>
>>> +    le64 rx_reset;            // The number of queue resets.
>>> +
>>> +    /* tx stats */
>>> +    le64 tx_packets;          // The number of packets sent by device, excluding the dropped packets by device.
>>> +    le64 tx_bytes;            // The number of bytes sent by device, excluding the dropped packets by device.
>> same question: are we talking about bytes sent by device? or
>> received from guest for transmission?
> The number of bytes sent by device.
>
>>> +
>>> +    le64 tx_notification;     // The number of notifications from driver.
>>> +    le64 tx_interrupt;        // The number of interrupts generated by device.
>>> +
>>> +    le64 tx_drop;             // The number of packets dropped by the tx queue. Contains all kinds of packet drop.
>>> +    le64 tx_drop_desc_err;    // The number of packets dropped when the descriptor is in an error state.
>> what is a descriptor in error state?
> such as len == 0.
>
>
>>> +
>>> +    le64 tx_csum_none;        // The number of packets that doesn't require hardware csum.
>>> +    le64 tx_csum_partial;     // The number of packets that requires hardware csum.
>>> +
>>> +    le64 tx_gso_packets;      // The number of gso packets transmitted.
>>> +    le64 tx_gso_bytes;        // The number of gso bytes transmitted.
>> point is, gso packets are not transmitted. they are received from
>> guest. is this what this means?
> Yes.


Or it could be case of TSO in the case of TX?

Thanks


>
>> gso bytes probably somehow
>> means bytes in gso packets, but again this is a bit vague.
> It should be defined, I think it should be defined as the number of bytes from
> the guest.
>
>
>>> +    le64 tx_reset;            // The number of queue resets.
>> queue reset counter sounds like a useful generic capability.
>> is this with the new features jason added recently?
>> can we add it to all devices?
> It's the one I submitted earlier.
>
> 	https://github.com/oasis-tcs/virtio-spec/issues/124
>
> The purpose of adding this is that the network device will disable/enable the
> queue. The statistics of the corresponding device is queue_reset.
>
> Thank you very much.
>
>>> +}
>>> +\end{lstlisting}
>>> +
>>> +All device stats are divided into three categories:
>>> +\begin{itemize}
>>> +    \item the stats of the device.
>>> +        \begin{itemize}
>>> +            \item command: VIRTIO_NET_CTRL_STATS_GET_DEV
>>> +            \item command-specific-data-reply structure: virtio_net_ctrl_reply_stats_dev
>>> +        \end{itemize}
>>> +
>>> +    \item the stats of the controlq.
>>> +        \begin{itemize}
>>> +            \item command: VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ
>>> +            \item command-specific-data-reply structure: virtio_net_ctrl_reply_stats_cvq
>>> +        \end{itemize}
>>> +
>>> +    \item the stats of the queue pair. This contains the stats of rx and tx.
>>> +        \begin{itemize}
>>> +            \item command: VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR
>>> +            \item command-specific-data structure: virtio_net_ctrl_stats_queue_pair
>>> +            \item command-specific-data-reply structure: virtio_net_ctrl_reply_stats_queue_pair
>>> +        \end{itemize}
>>> +\end{itemize}
>>> +
>>> +\devicenormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>>> +If \field{queue_pair_index} is out of range for a
>>> +VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR command, the device MUST set \field{ack} in
>>> +virtio_net_ctrl to VIRTIO_NET_ERR.
>>> +
>>> +If VIRTIO_NET_F_CTRL_STATS has been negotiated, the device MUST support the
>>> +VIRTIO_NET_CTRL_STATS_GET_DEV, VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ and
>>> +VIRTIO_NET_CTRL_STATS_GET_QUEUE_PAIR commands.
>>> +
>>> +\drivernormative{\subparagraph}{Device stats}{Device Types / Network Device / Device Operation / Control Virtqueue / Device stats}
>>> +
>>> +\field{command-specific-data} MUST be empty for VIRTIO_NET_CTRL_STATS_GET_DEV
>>> +and VIRTIO_NET_CTRL_STATS_GET_CTRL_VQ.
>>>
>>>   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>>>   Types / Network Device / Legacy Interface: Framing Requirements}
>>> --
>>> 2.31.0
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

