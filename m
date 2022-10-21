Return-Path: <virtio-dev-return-10080-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A08098658F
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Oct 2022 05:36:08 +0000 (UTC)
Message-ID: <40619f5b-fbc7-7d4b-5895-5fc22f316376@linux.alibaba.com>
Date: Fri, 21 Oct 2022 13:36:02 +0800
MIME-Version: 1.0
References: <9b6d4dfb-39ca-1f46-3487-680267557d24@linux.alibaba.com>
 <1666144574.5021315-1-xuanzhuo@linux.alibaba.com>
 <213fc29f-cf04-60a8-2b52-b91a3f8eda6c@linux.alibaba.com>
 <1666161716.3903756-1-xuanzhuo@linux.alibaba.com>
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
In-Reply-To: <1666161716.3903756-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: support timestamp received
 packet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 10/19/22 2:41 PM, Xuan Zhuo =E5=86=99=E9=81=93:
> On Wed, 19 Oct 2022 14:40:46 +0800, Shuyi Cheng <chengshuyi@linux.alibaba=
.com> wrote:
>>
>>
>> =E5=9C=A8 10/19/22 9:56 AM, Xuan Zhuo =E5=86=99=E9=81=93:
>>> On Wed, 19 Oct 2022 09:32:39 +0800, Shuyi Cheng <chengshuyi@linux.aliba=
ba.com> wrote:
>>>> This patch introduces VIRTIO_NET_F_RX_TSTAMP to enhance the
>>>> observability of network packet delay between virtio device and virtio
>>>> driver.
>>>>
>>>> We have encountered many network jitter problems from virtio device to
>>>> virtio driver in the production environment. Due to the lack of releva=
nt
>>>> indicators in this path, we often spend a lot of energy to locate such
>>>> problems. If the virtio device can provide the packet receiving
>>>> timestamp, then we can easily calculate the network jitter index betwe=
en
>>>> the virtio device and the virtio driver. When such a problem is
>>>> encountered again, it is easy to determine the problem boundary.
>>>>
>>>> Thanks and looking forward to your response!
>>>
>>>
>>> 1. Do we need to dynamically turn on and off this function?
>>> 2. What is the unit of tstamp here?
>>>
>>> Thanks.
>>>
>>
>> 1. yes, we could use ethtool to dynamically turn on and off this functio=
n.
>=20
> But at present, you don't support dynamic modification, do you?
>=20

Yes, i will add it.

Thanks.

>>
>> 2. nanosecond precision is ok.
>=20
> Please specify this in the spec.
>=20
> Thanks.
>=20
>>
>> Thanks.
>>
>>>
>>>>
>>>> Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
>>>> ---
>>>>     content.tex | 14 ++++++++++++++
>>>>     1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index e863709..472acf3 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -3097,6 +3097,8 @@ \subsection{Feature bits}\label{sec:Device Types=
 /
>>>> Network Device / Feature bits
>>>>     \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet h=
ash
>>>>         value and a type of calculated hash.
>>>>
>>>> +\item[VIRTIO_NET_F_RX_TSTAMP(58)] Device can timestamp received packe=
t.
>>>> +
>>>>     \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact
>>>> \field{hdr_len}
>>>>         value. Device benefits from knowing the exact header length.
>>>>
>>>> @@ -3371,6 +3373,7 @@ \subsection{Device Operation}\label{sec:Device
>>>> Types / Network Device / Device O
>>>>     #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>>>     #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>>>     #define VIRTIO_NET_HDR_F_RSC_INFO      4
>>>> +#define VIRTIO_NET_HDR_F_TSTAMP        8
>>>>             u8 flags;
>>>>     #define VIRTIO_NET_HDR_GSO_NONE        0
>>>>     #define VIRTIO_NET_HDR_GSO_TCPV4       1
>>>> @@ -3387,6 +3390,7 @@ \subsection{Device Operation}\label{sec:Device
>>>> Types / Network Device / Device O
>>>>             le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
>>>> negotiated)
>>>>             le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
>>>> negotiated)
>>>>             le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
>>>> negotiated)
>>>> +        le64 tstamp;            (Only if VIRITO_NET_F_RX_TSTAMP negot=
iated)
>>>>     };
>>>>     \end{lstlisting}
>>>>
>>>> @@ -3809,6 +3813,13 @@ \subsubsection{Processing of Incoming
>>>> Packets}\label{sec:Device Types / Network
>>>>     checksum (in case of multiple encapsulated protocols, one level
>>>>     of checksums is validated).
>>>>
>>>> +If VIRTIO_NET_F_RX_TSTAMP was not negotiated, the device MUST not set
>>>> +VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags}.
>>>> +
>>>> +If VIRTIO_NET_F_RX_TSTAMP was negotiated, the device MUST also
>>>> +set VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags},
>>>> +set \field{tstamp} to time to receive the packet.
>>>> +
>>>>     \drivernormative{\paragraph}{Processing of Incoming
>>>>     Packets}{Device Types / Network Device / Device Operation /
>>>>     Processing of Incoming Packets}
>>>> @@ -3831,6 +3842,9 @@ \subsubsection{Processing of Incoming
>>>> Packets}\label{sec:Device Types / Network
>>>>     VIRTIO_NET_HDR_F_DATA_VALID is set, the driver MUST NOT
>>>>     rely on the packet checksum being correct.
>>>>
>>>> +If VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags} is not set, the
>>>> +driver MUST NOT use the \field{tstamp}.
>>>> +
>>>>     \paragraph{Hash calculation for incoming packets}
>>>>     \label{sec:Device Types / Network Device / Device Operation /
>>>> Processing of Incoming Packets / Hash calculation for incoming packets=
}
>>>>
>>>> --
>>>> 2.27.0
>>>>
>>>>
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

