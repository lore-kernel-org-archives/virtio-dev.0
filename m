Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <b0ffed52-ab12-4160-21c4-e01f9f34ac5f@linux.alibaba.com>
Date: Tue, 29 Nov 2022 13:11:34 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_net: support inner header hash
 for GRE-encapsulated packets
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
 <20221128031413.GA118868@h68b04307.sqa.eu95>
 <2cde8c0d-5826-408f-1034-0ed5852310d9@redhat.com>
 <20221128053316.GA103984@h68b04307.sqa.eu95>
 <CACGkMEvCRNFmkNnTaHPcA+=4tDOr7ZdwVHiKwdLTF=_Ad+dmtw@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEvCRNFmkNnTaHPcA+=4tDOr7ZdwVHiKwdLTF=_Ad+dmtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2022/11/29 上午11:47, Jason Wang 写道:
> On Mon, Nov 28, 2022 at 1:33 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> On Mon, Nov 28, 2022 at 11:52:23AM +0800, Jason Wang wrote:
>>> 在 2022/11/28 11:14, Heng Qi 写道:
>>>> On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
>>>>> On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
>>>>>> encapsulate the packets, the hash calculated using the outer header
>>>>>> of the receive packets is always fixed for the same flow packets,
>>>>>> i.e. they will be steered to the same receive queue.
>>>>>>
>>>>>> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
>>>>>> which instructs the device to calculate the hash using the inner
>>>>>> headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
>>>>>> value in \field{hash_tunnel} to report packet type when calculating
>>>>>> hash over the inner header.
>>>>> So I think we need a new feature bit for this to keep migration compatibility.
>>>>>
>>>> If we consider adding feature negotiation for this, it will be explained
>>>> more below.
>>>>
>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> ---
>>>>>> v1:
>>>>>>          1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>>>>>>          2. Clarify some paragraphs. @Jason Wang
>>>>>>          3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
>>>>>>
>>>>>>   content.tex | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>   1 file changed, 135 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/content.tex b/content.tex
>>>>>> index e863709..fba0c7d 100644
>>>>>> --- a/content.tex
>>>>>> +++ b/content.tex
>>>>>> @@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>>>>>    to several segments when each of these smaller packets has UDP header.
>>>>>>
>>>>>>   \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
>>>>>> -    value and a type of calculated hash.
>>>>>> +    value, a type of calculated hash and a tunnel packet type.
>>>>>>
>>>>>>   \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
>>>>>>       value. Device benefits from knowing the exact header length.
>>>>>> @@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>>>>>>           le16 num_buffers;
>>>>>>           le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>>>>           le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>>>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>>>> +        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>>> It's better not limit this to be tunnel only unless we limit the same
>>>>> for hash_config.
>>>> Maybe we can use the \field{hash_report_ex} instead of \field{hash_tunnel}？
>>>
>>> Probably.
>>>
>>>
>>>>> Btw, this needs an independent fix. I wonder if we need a dedicated
>>>>> feature bit VIRTIO_NET_F_HASH_REPORT_EX and documenting that device
>>>>> SHOULD offer HASH_REPORT_EX along with HASH_REPORT. Then we can do GRE
>>>>> tunnel hash report on top? (Or doing GRE first and fix the mismatch on
>>>>> top)
>>>>>
>>>> For this, we have the following ideas:
>>>>
>>>> 1. Considering our actual business application scenarios, the current mainstream
>>>>     tunnel-encapsulated technologies are mainly GRE and VXLAN, so we are also
>>>>     working on VXLAN.
>>>>
>>>> 2. To keep migration compatibility, we can add a VIRTIO_NET_F_HASH_GRE_INNER
>>>>     feature bit (it depends on VIRTIO_NET_F_RSS). If it is negotiated, this
>>>>     means that the device calculates the hash based on the inner header of the
>>>>     GRE-encapsulated packet. We assume that the inner header in GRE is TCPv4,
>>>>     at this time \field{hash_types} needs to include
>>>>     (VIRTIO_NET_HASH_TYPE_GRE_INNER | VIRTIO_NET_HASH_TYPE_TCPv4). Besides,
>>>>     if VIRTIO_NET_F_HASH_REPORT is also negotiated, then \field{hash_report}
>>>>     should be set to VIRTIO_NET_HASH_REPORT_TCPv4, and field \field{hash_report_ex}
>>>>     should be set to VIRTIO_NET_HASH_REPORT_GRE.
>>>
>>> One question here, if I was not wrong, hash_report is sufficient for
>>> GRE and VXLAN now. So that's why I think they should be indenepent
>>> patch.
>>>
>> As discussed in https://lists.oasis-open.org/archives/virtio-dev/202211/msg00064.html,
>> \field{hash_report} is an integer rather than a bitmask.
> Ok, I see.
>
>> On the premise that
>> VIRTIO_NET_F_HASH_GRE_INNER is negotiated, assuming that the inner header of the GRE packet
>> is TCPv4 and we only have \field{hash_report} instead of \field{hash_report_ex}, then we
>> need to set VIRTIO_NET_HASH_REPORT_GRE(10) in \field{hash_report} along with
>> VIRTIO_NET_HASH_REPORT_TCPv4(2). At this point \field{hash_report} should be (2+10=12).
>>
>> However, if the inner header of another VXLAN packet is IPv4, and VIRTIO_NET_HASH_REPORT_VXLAN
>> is 11 (following VIRTIO_NET_HASH_REPORT_GRE(10), like below), then \field{hash_report} is
>> (1+11=12). Then how does the driver distinguish that 12 belongs to the above which situation?
>>
>> Suppose the report type is as follows:
>> \begin{lstlisting}
>> #define VIRTIO_NET_HASH_REPORT_NONE            0
>> #define VIRTIO_NET_HASH_REPORT_IPv4            1
>> #define VIRTIO_NET_HASH_REPORT_TCPv4           2
>> #define VIRTIO_NET_HASH_REPORT_UDPv4           3
>> #define VIRTIO_NET_HASH_REPORT_IPv6            4
>> #define VIRTIO_NET_HASH_REPORT_TCPv6           5
>> #define VIRTIO_NET_HASH_REPORT_UDPv6           6
>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>> #define VIRTIO_NET_HASH_REPORT_GRE            10
>> #define VIRTIO_NET_HASH_REPORT_VXLAN          11
>> \end{lstlisting}
>>
>> So it seems more reasonable to include tunnel-related report types in \field{hash_report_ex},
> Ok, I think I got this, if we go this way, hash_report_tunnel might be better.

Ok. I agree with you.

>
> In the long run, the mismatching behaviour of hash_config and
> hash_report might end up more burden in the maintenance. I wonder if
> it's worth it to make hash_report a bitmask that matches hash_config.
> That seems to ease everything a lot.

This seems to be debatable.
In order not to cause trouble to users who currently use 
\field{hash_report}, we can make
\field{hash_report} a bitmask when VIRTIO_NET_F_HASH_GRE_VXLAN_INNER is 
negotiated,
but this seems to make \field{hash_report} more than one word 
definition, and it is 16 bits
but \field{hash_type} is 32 bits. VIRTIO_NET_HASH_TYPE_GRE_INNER and 
\field{hash_report_ex}
are only used if VIRTIO_NET_F_HASH_GRE_VXLAN_INNER is negotiated and 
have no effect before.


Thanks.

>
> Thanks
>
>> or we can adopt something like https://lists.oasis-open.org/archives/virtio-dev/202211/msg00064.html
>> , which only uses the \field{hash_report} method.
>>
>>>> 3. Why don't we consider a feature bit for all tunnel types?
>>>>
>>>>     If some devices do not support GRE but support VXLAN, and some devices
>>>>     support both VXLAN and GRE, so we must set the specific feature bit
>>>>     (e.g VIRTIO_NET_F_HASH_GRE_INNER) for a specific tunnel type. Fortunately,
>>>>     the number of mainstream tunnel encapsulations is limited.
>>>
>>> My understanding is that if we start from having both GRE and VXLAN
>>> for a single feature bit, it would be simpler for both maintaining
>>> (spec), driver and device(vendor).
>>>
>>> (E.g it can force the device vendor to implement both)
>> Ok, this seems to work. We can bind them together.
>>
>>>
>>>> 4. Why do we not need VIRTIO_NET_F_HASH_REPORT_EX after we negotiate VIRTIO_NET_F_HASH_GRE_INNER?
>>>>
>>>>     Because once VIRTIO_NET_F_HASH_GRE_INNER is negotiated, the device should
>>>>     calculate the hash based on the GRE inner header, and should not hide the
>>>>     information when reporting, that is, VIRTIO_NET_HASH_REPORT_TCPv4 and
>>>>     VIRTIO_NET_HASH_REPORT_GRE should be set in \field{hash_report} and
>>>>     \field{hash_report_ex} respectively.
>>>>
>>>> Do you think this is feasible?
>>>
>>> I think so.
>>>
>>>
>>>>>> +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
>>>>>>   };
>>>>>>   \end{lstlisting}
>>>>>>
>>>>>> @@ -3837,7 +3838,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>>>>   A device attempts to calculate a per-packet hash in the following cases:
>>>>>>   \begin{itemize}
>>>>>>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
>>>>>> -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
>>>>>> +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value, the hash type and the tunnel packet type.
>>>>>>   \end{itemize}
>>>>>>
>>>>>>   If the feature VIRTIO_NET_F_RSS was negotiated:
>>>>>> @@ -3883,6 +3884,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>>>>   #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
>>>>>>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>>>>>   \end{lstlisting}
>>>>>> +Hash types applicable to inner payloads of GRE-encapsulated packets
>>>>> Unless there are other GRE related hash types, would it be better to
>>>>> say "inner payloads of tunnel packets"?
>>>>>
>>>> We will post a similar spec for VXLAN-encapsulated packets, which is in
>>>> process. It is also a tunnel hash type.
>>>>
>>>>>> +\begin{lstlisting}
>>>>>> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
>>>>>> +\end{lstlisting}
>>>>>>
>>>>>>   \subparagraph{IPv4 packets}
>>>>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
>>>>>> @@ -3975,12 +3980,123 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>>>>   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
>>>>>>   \end{itemize}
>>>>>>
>>>>>> +\subparagraph{Inner payloads of GRE-encapsulated packets}
>>>>>> +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Inner payloads of GRE-encapsulated packets}}
>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is set at the same time as one of
>>>>>> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_UDP_EX.
>>>>>> +
>>>>>> +The device calculates the hash on GRE-encapsulated packets whose inner payloads
>>>>>> +are IPv4 packets according to 'Enabled hash types' bitmasks as follows:
>>>>>> +\begin{itemize}
>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_TCPv4 bits
>>>>>> +      are set, and the GRE-encapsulated packet has an inner TCPv4 header in its
>>>>>> +      payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IP address
>>>>>> +      \item inner Destination IP address
>>>>>> +      \item inner Source TCP port
>>>>>> +      \item inner Destination TCP port
>>>>>> +    \end{itemsize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_UDPv4
>>>>>> +      bits are set, and the GRE-encapsulated packet has an inner UDPv4 header in
>>>>>> +      its payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IP address
>>>>>> +      \item inner Destination IP address
>>>>>> +      \item inner Source UDP port
>>>>>> +      \item inner Destination UDP port
>>>>>> +    \end{itemize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_IPv4
>>>>>> +      bits are set, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IP address
>>>>>> +      \item inner Destination IP address
>>>>>> +    \end{itemsize}
>>>>>> +  \item Else the device does not calculate the hash
>>>>>> +\end{itemize}
>>>>>> +
>>>>>> +The device calculates the hash on GRE-encapsulated packets whose inner payloads
>>>>>> +are IPv6 packets without extension headers according to 'Enabled hash types'
>>>>>> +bitmasks as follows:
>>>>>> +\begin{itemsize}
>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_TCPv6
>>>>>> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 header in
>>>>>> +      its payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IPv6 address
>>>>>> +      \item inner Destination IPv6 address
>>>>>> +      \item inner Source TCP port
>>>>>> +      \item inner Destination TCP port
>>>>>> +    \end{itemsize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_UDPv6
>>>>>> +      bits are set, and the GRE-encapsulated packet has an inner UDPv6 header in
>>>>>> +      its payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IPv6 address
>>>>>> +      \item inner Destination IPv6 address
>>>>>> +      \item inner Source UDP port
>>>>>> +      \item inner Destination UDP port
>>>>>> +    \end{itemize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_IPv6
>>>>>> +      bits are set, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item inner Source IPv6 address
>>>>>> +      \item inner Destination IPv6 address
>>>>>> +    \end{itemsize}
>>>>>> +  \item Else the device does not calculate the hash
>>>>>> +\end{itemize}
>>>>>> +
>>>>>> +The device calculates the hash on GRE-encapsulated packets whose inner payloads
>>>>>> +are IPv6 packets with extension headers according to 'Enabled hash types'
>>>>>> +bitmasks as follows:
>>>>>> +\begin{itemsize}
>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_TCP_EX
>>>>>> +      bits are set, and the GRE-encapsulated packet has an inner TCPv6 header in
>>>>>> +      its payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemize}
>>>>>> +      \item Home address from the home address option in the inner IPv6 destination
>>>>>> +          options header. If the inner extension header is not present, use the
>>>>>> +          inner Source IPv6 address.
>>>>>> +      \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>>> +          associated inner extension header. If the inner extension header is not
>>>>>> +          present, use the inner Destination IPv6 address.
>>>>>> +      \item inner Source TCP port
>>>>>> +      \item inner Destination TCP port
>>>>>> +    \end{itemize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_UDP_EX
>>>>>> +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 header in its
>>>>>> +  payload, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item Home address from the home address option in the inner IPv6 destination
>>>>>> +          options header. If the inner extension header is not present, use the
>>>>>> +          inner Source IPv6 address.
>>>>>> +      \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>>> +          associated inner extension header. If the inner extension header is not
>>>>>> +          present, use the inner Destination IPv6 address.
>>>>>> +      \item inner Source UDP port
>>>>>> +      \item inner Destination UDP port
>>>>>> +    \end{itemize}
>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYPE_IP_EX
>>>>>> +      bits are set, the hash is calculated over the following fields:
>>>>>> +    \begin{itemsize}
>>>>>> +      \item Home address from the home address option in the inner IPv6 destination
>>>>>> +          options header. If the inner extension header is not present, use the
>>>>>> +          inner Source IPv6 address.
>>>>>> +      \item IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>>> +          associated inner extension header. If the inner extension header is not
>>>>>> +          present, use the inner Destination IPv6 address.
>>>>>> +    \end{itemize}
>>>>>> +  \item Else skip inner IPv6 extension headers and calculate the hash as defined
>>>>>> +      for a GRE-encapsulated packet whose inner payload is an IPv6 packet without
>>>>>> +      extension headers
>>>>>> +\end{itemsize}
>>>>>> +
>>>>>>   \paragraph{Hash reporting for incoming packets}
>>>>>>   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
>>>>>>
>>>>>>   If VIRTIO_NET_F_HASH_REPORT was negotiated and
>>>>>> - the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
>>>>>> -and \field{hash_value} with the value of calculated hash.
>>>>>> + the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash,
>>>>>> +\field{hash_tunnel} with the type of the tunnel packet, and \field{hash_value} with the value of calculated hash.
>>>>>>
>>>>>>   If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
>>>>>>   hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
>>>>>> @@ -4005,6 +4121,20 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>>>>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>>>>   \end{lstlisting}
>>>>>>
>>>>>> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
>>>>>> +\field{hash_tunnel} can report the type of the tunnel-encapsulated
>>>>>> +packet to the driver over the inner header hash calculation.
>>>>>> +Possible values that the device can report in field{hash_tunnel}
>>>>>> +are defined below:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +#define VIRTIO_NET_HASH_REPORT_GRE             1
>>>>>> +\end{lstlisting}
>>>>> What's the advantage of not simply doing the matching via the existing math:
>>>>>
>>>>> VIRTIO_NET_HASH_TYPE_XXX = 1 « (VIRTIO_NET_HASH_REPORT_XXX - 1)
>>>>> ?
>>>>>
>>>> Considering that other tunnel-encapsulated packets may be added, this
>>>> existing formula will no longer be applicable.
>>>
>>> So I basically mean what's wrong with simply defining
>>> VIRTIO_NET_HASH_TYPE_GRE_INNER as 10?
>>>
>> Considering the addition of VXLAN, if VIRTIO_NET_HASH_TYPE_GRE_INNER is 10,
>> then VIRTIO_NET_HASH_TYPE_VXLAN_INNER should be 11, and they need to be
>> used with existing types in \field{hash_report} which brings problems as I
>> explained above, since they are integers instead of bitmask.
>>
>> Thanks.
>>
>>> Thanks
>>>
>>>
>>>> Thanks.
>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>> +
>>>>>> +The value VIRTIO_NET_HASH_REPORT_GRE corresponds to
>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit of supported hash types defined in
>>>>>> +\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
>>>>>> +
>>>>>>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
>>>>>>
>>>>>>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
>>>>>> --
>>>>>> 2.19.1.6.gb485710b
>>>>>>
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

