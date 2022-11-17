Return-Path: <virtio-dev-return-10174-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C27B986652
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Nov 2022 07:49:03 +0000 (UTC)
Message-ID: <dc278c2c-eab9-067f-7082-a4e6bcd3b28f@linux.alibaba.com>
Date: Thu, 17 Nov 2022 15:48:56 +0800
MIME-Version: 1.0
References: <20221109113336.121773-1-hengqi@linux.alibaba.com>
 <20221109113336.121773-3-hengqi@linux.alibaba.com>
 <CACGkMEtVMLKDGfXzhbVshO2DkHmU6ayNH=-EJg2ins9jJYjGNg@mail.gmail.com>
 <77551372-bab9-5e55-d290-f50ebc6cad14@linux.alibaba.com>
 <CAOEp5OcgAVTO+ds6RGw1e-Wk_vtmsH8bX0YSHDfVrz+1JDvWkw@mail.gmail.com>
 <807c72ba-73cd-939f-1ab8-8c7e6765761a@linux.alibaba.com>
 <CACGkMEuECnCqx-5hZtNbKs07MQ2e=56OD+M40BVSy4MNzN=F+Q@mail.gmail.com>
 <0c579d31-120f-60af-3b87-53d8aefcaa91@linux.alibaba.com>
 <CACGkMEv1YS-QTeQwJzysMYFucYAZ4m2+qPjax=6i1evOMnpRsA@mail.gmail.com>
 <155e22e7-e646-73cb-3cb1-e0525e3a6905@linux.alibaba.com>
 <CACGkMEt7Ozc_jnd6fF57a7yYF9YUD2SP4JyyyaSxcy3wk0_8eA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEt7Ozc_jnd6fF57a7yYF9YUD2SP4JyyyaSxcy3wk0_8eA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH 2/2] virtio_net: support inner header
 hash for GRE-encapsulated packets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2022/11/17 =E4=B8=8B=E5=8D=882:09, Jason Wang =E5=86=99=E9=81=93:
> On Thu, Nov 17, 2022 at 2:00 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> =E5=9C=A8 2022/11/17 =E4=B8=8B=E5=8D=881:34, Jason Wang =E5=86=99=E9=81=
=93:
>>> On Thu, Nov 17, 2022 at 1:01 PM Heng Qi <hengqi@linux.alibaba.com> wrot=
e:
>>>>
>>>> =E5=9C=A8 2022/11/17 =E4=B8=8B=E5=8D=8812:29, Jason Wang =E5=86=99=E9=
=81=93:
>>>>> On Thu, Nov 17, 2022 at 10:53 AM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>>>>>> =E5=9C=A8 2022/11/17 =E4=B8=8A=E5=8D=887:32, Yuri Benditovich =E5=86=
=99=E9=81=93:
>>>>>>> I would suggest to specify also the hash type the device should rep=
ort
>>>>>>> in case the hash reporting feature is enabled. For example, should =
the
>>>>>>> device specify somehow in the report that the hash was calculated o=
n
>>>>>>> the inner header or on the regular header?
>>>>>> It seems unnecessary. The calculation of RSS hash using the regular =
or
>>>>>> inner header is actually
>>>>>> transparent to the driver, and after the hash value and hash type
>>>>>> calculated by the device,
>>>>>> the feedback on skb is that skb only has L4 or L3 hash boolean type.
>>>>> I think what Yuri meant is what if the user wants to calculate hash
>>>>> based on the inner header? Do we need VIRTIO_NET_HASH_TYPE_GRE_XXX?
>>>> Yes, if the user wants to calculate the hash on the inner header, then
>>>> we need VIRTIO_NET_HASH_TYPE_GRE_INNER,
>>>> if the user wants to calculate the hash on the outer header, then we
>>>> don=E2=80=99t need to use VIRTIO_NET_HASH_TYPE_GRE_INNER,
>>>> just keep the previous default behavior.
>>> I actually meant should we add VIRTIO_NET_HASH_REPORT_GRE_XXX?
>> VIRTIO_NET_HASH_REPORT_GRE_XXX does not seem to need to be added.
>>
>> _HASH_TYPE_GRE_INNER is a special hash type, which is used in
>> combination with other hash types,
>> indicating that the sd, sdfn, etc. of the inner or outer header are used
>> to calculate the hash.
>> The device can report the following true types to the driver to meet the
>> subsequent requirements of driver.
>>
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
>> \end{lstlisting}
>>
>> As for whether the device uses the outer or inner header to calculate
>> the hash information,
>> the driver does not seem to need to know?
> We can't assume the behaviour of the driver actually. E.g driver may
> try to do rx classification based on the rxhash.

Ok, I think this is reasonable and we shouldn't hide certain information.

Then I'll add VIRTIO_NET_HASH_REPORT_GRE_INNER, considering that=20
\field{hash_types} is a 32-bit bitmap,
and \field{hash_report} is a 16-bit integer, in order to be compatible=20
with existing hash computing devices,
we can use the first 8 bits of \field{hash_report} as a tunnel-related=20
flag, and the last 8 bits of \field{hash_report}
represent the hash five-tuple, e.g. VIRTIO_NET_HASH_TYPE_TCPv4.

That is, if the value of the obtained \field{hash_report} is greater=20
than 256, it means that the driver wants
the device to calculate the hash for the inner header of the=20
tunnel-encapsulated packet . And if the value is less
than 256, the default outer header hashing will be performed.

Do you think this proposal is feasible?=F0=9F=98=81

Thanks.

>
> Thanks
>
>> Thanks.
>>
>>> Thanks
>>>
>>>> This is a configurable hash specification.
>>>>
>>>> Thanks.
>>>>
>>>>> Thanks
>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>> On Thu, Nov 10, 2022 at 5:41 AM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>>>>>>>> =E5=9C=A8 2022/11/10 =E4=B8=8A=E5=8D=8811:35, Jason Wang =E5=86=99=
=E9=81=93:
>>>>>>>>> On Wed, Nov 9, 2022 at 7:33 PM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>>>>>>>>>> From: Heng Qi <henqqi@linux.alibaba.com>
>>>>>>>>>>
>>>>>>>>>> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
>>>>>>>>>> encapsulate the packets, the hash calculated using the outer hea=
der
>>>>>>>>>> of the receive packets is always fixed for the same flow packets=
,
>>>>>>>>>> i.e. they will be steered to the same receive queue.
>>>>>>>>>>
>>>>>>>>>> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_t=
ypes},
>>>>>>>>>> which instructs the device to calculate the hash using the inner=
 headers
>>>>>>>>>> of GRE-encapsulated packets.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
>>>>>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>>>>>> ---
>>>>>>>>>>       content.tex | 116 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++
>>>>>>>>>>       1 file changed, 116 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>>>>> index 6fabf1d..319d401 100644
>>>>>>>>>> --- a/content.tex
>>>>>>>>>> +++ b/content.tex
>>>>>>>>>> @@ -3883,6 +3883,10 @@ \subsubsection{Processing of Incoming Pac=
kets}\label{sec:Device Types / Network
>>>>>>>>>>       #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
>>>>>>>>>>       #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>>>>>>>>>       \end{lstlisting}
>>>>>>>>>> +Hash types applicable to inner payloads of GRE-encapsulated pac=
kets
>>>>>>>>>> +\begin{lstlisting}
>>>>>>>>>> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
>>>>>>>>>> +\end{lstlisting}
>>>>>>>>>>
>>>>>>>>>>       \subparagraph{IPv4 packets}
>>>>>>>>>>       \label{sec:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets / Hash calculation for incoming packets =
/ IPv4 packets}
>>>>>>>>>> @@ -3975,6 +3979,114 @@ \subsubsection{Processing of Incoming Pa=
ckets}\label{sec:Device Types / Network
>>>>>>>>>>       (see \ref{sec:Device Types / Network Device / Device Opera=
tion / Processing of Incoming Packets / Hash calculation for incoming packe=
ts / IPv6 packets without extension header}).
>>>>>>>>>>       \end{itemize}
>>>>>>>>>>
>>>>>>>>>> +\subparagraph{Inner payloads of GRE-encapsulated packets}
>>>>>>>>>> +\label{sec:Device Types / Network Device / Device Operation / P=
rocessing of Incoming Packets / Hash calculation for incoming packets / Inn=
er payloads of GRE-encapsulated packets}}
>>>>>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit MUST be set at the same time=
 as one of
>>>>>>>>>> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_=
TYPE_UDP_EX.
>>>>>>>>> "MUST" keyword must belong to the normative section.
>>>>>>>> Okay. Thanks for pointing out.
>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
>>>>>>>>>> +are IPv4 packets according to 'Enabled hash types' bitmasks as =
follows:
>>>>>>>>>> +\begin{itemize}
>>>>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCPv4 bits
>>>>>>>>>> +      are set, and the GRE-encapsulated packet has an inner TCP=
v4 header in its
>>>>>>>>>> +      payload, the hash is calculated over the following fields=
:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IP address
>>>>>>>>>> +      \item Inner destination IP address
>>>>>>>>>> +      \item Inner source TCP port
>>>>>>>>>> +      \item Inner destination TCP port
>>>>>>>>>> +    \end{itemsize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDPv4
>>>>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r UDPv4 header in
>>>>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IP address
>>>>>>>>>> +      \item Inner destination IP address
>>>>>>>>>> +      \item Inner source UDP port
>>>>>>>>>> +      \item Inner destination UDP port
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IPv4
>>>>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IP address
>>>>>>>>>> +      \item Inner destination IP address
>>>>>>>>>> +    \end{itemsize}
>>>>>>>>>> +  \item Else the device does not calculate the hash
>>>>>>>>>> +\end{itemize}
>>>>>>>>>> +
>>>>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
>>>>>>>>>> +are IPv6 packets without extension headers according to 'Enable=
d hash types'
>>>>>>>>>> +bitmasks as follows:
>>>>>>>>>> +\begin{itemsize}
>>>>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCPv6
>>>>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r TCPv6 header in
>>>>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IPv6 address
>>>>>>>>>> +      \item Inner destination IPv6 address
>>>>>>>>>> +      \item Inner source TCP port
>>>>>>>>>> +      \item Inner destination TCP port
>>>>>>>>>> +    \end{itemsize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDPv6
>>>>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r UDPv6 header in
>>>>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IPv6 address
>>>>>>>>>> +      \item Inner destination IPv6 address
>>>>>>>>>> +      \item Inner source UDP port
>>>>>>>>>> +      \item Inner destination UDP port
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IPv6
>>>>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Inner source IPv6 address
>>>>>>>>>> +      \item Inner destination IPv6 address
>>>>>>>>>> +    \end{itemsize}
>>>>>>>>>> +  \item Else the device does not calculate the hash
>>>>>>>>>> +\end{itemize}
>>>>>>>>>> +
>>>>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
>>>>>>>>>> +are IPv6 packets with extension headers according to 'Enabled h=
ash types'
>>>>>>>>>> +bitmasks as follows:
>>>>>>>>>> +\begin{itemsize}
>>>>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCP_EX
>>>>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r TCPv6 header in
>>>>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
>>>>>>>>>> +    \begin{itemize}
>>>>>>>>>> +      \item Home address from the home address option in the IP=
v6 destination options
>>>>>>>>> Is this inner or outer?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>> +          header. If the extension header is not present, use t=
he Source IPv6 address.
>>>>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
>>>>>>>>>> +          associated extension header. If the extension header =
is not present, use
>>>>>>>>>> +          the Destination IPv6 address.
>>>>>>>>>> +      \item Source TCP port
>>>>>>>>>> +      \item Destination TCP port
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDP_EX
>>>>>>>>>> +  bits are set, and the GRE-encapsulated packet has an inner UD=
Pv6 header in its
>>>>>>>>>> +  payload, the hash is calculated over the following fields:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Home address from the home address option in the IP=
v6 destination options
>>>>>>>>>> +          header. If the extension header is not present, use t=
he Source IPv6 address.
>>>>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
>>>>>>>>>> +          associated extension header. If the extension header =
is not present, use the
>>>>>>>>>> +          Destination IPv6 address.
>>>>>>>>>> +      \item Source UDP port
>>>>>>>>>> +      \item Destination UDP port
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IP_EX
>>>>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
>>>>>>>>>> +    \begin{itemsize}
>>>>>>>>>> +      \item Home address from the home address option in the IP=
v6 destination options
>>>>>>>>>> +          header. If the extension header is not present, use t=
he Source IPv6 address.
>>>>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
>>>>>>>>>> +          associated extension header. If the extension header =
is not present, use the
>>>>>>>>>> +          Destination IPv6 address.
>>>>>>>>>> +    \end{itemize}
>>>>>>>>>> +  \item Else skip IPv6 extension headers and calculate the hash=
 as defined for
>>>>>>>>>> +      a GRE-encapsulated packet whose inner payload is an IPv6 =
packet without
>>>>>>>>>> +      extension headers
>>>>>>>>>> +\end{itemsize}
>>>>>>>>>> +
>>>>>>>>>>       \paragraph{Hash reporting for incoming packets}
>>>>>>>>>>       \label{sec:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets / Hash reporting for incoming packets}
>>>>>>>>>>
>>>>>>>>>> @@ -4005,6 +4117,10 @@ \subsubsection{Processing of Incoming Pac=
kets}\label{sec:Device Types / Network
>>>>>>>>>>       #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>>>>>>>>       \end{lstlisting}
>>>>>>>>>>
>>>>>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is not included in \field{ha=
sh_report},
>>>>>>>>>> +it just indicates that the hash is calculated using the inner h=
eader inside
>>>>>>>>>> +the GRE-encapsulated packet.
>>>>>>>>>> +
>>>>>>>>>>       \subsubsection{Control Virtqueue}\label{sec:Device Types /=
 Network Device / Device Operation / Control Virtqueue}
>>>>>>>>>>
>>>>>>>>>>       The driver uses the control virtqueue (if VIRTIO_NET_F_CTR=
L_VQ is
>>>>>>>>>> --
>>>>>>>>>> 2.19.1.6.gb485710b
>>>>>>>>>>
>>>>>>>> ------------------------------------------------------------------=
---
>>>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.or=
g
>>>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.=
org
>>>>>>>>
>>>>>> --------------------------------------------------------------------=
-
>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g
>>>>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

