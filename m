Return-Path: <virtio-dev-return-10085-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22D8F98658F
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Oct 2022 08:42:20 +0000 (UTC)
Message-ID: <bfc9f2b2-aaa6-f9c5-ae77-600c24342f13@linux.alibaba.com>
Date: Fri, 21 Oct 2022 16:42:13 +0800
MIME-Version: 1.0
References: <9b6d4dfb-39ca-1f46-3487-680267557d24@linux.alibaba.com>
 <CACGkMEviK-t+jCEdwUZHn=mJNYeC-wQY1FN0rwsDE5NEKxybMw@mail.gmail.com>
 <64f206ba-ad94-4526-a084-10ac96f0112b@linux.alibaba.com>
 <CACGkMEsqGQw_cU04v1cSynFPgezntsWZiSpm2M-7Oto106o4qg@mail.gmail.com>
 <CA+FuTSdg8KZK=4fohHBQx_uyv1bcoU0D2hY1btPM=aPqKNt2vg@mail.gmail.com>
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
In-Reply-To: <CA+FuTSdg8KZK=4fohHBQx_uyv1bcoU0D2hY1btPM=aPqKNt2vg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: support timestamp received
 packet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 10/19/22 8:20 PM, Willem de Bruijn =E5=86=99=E9=81=93:
> On Wed, Oct 19, 2022 at 12:58 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Wed, Oct 19, 2022 at 3:24 PM Shuyi Cheng
>> <chengshuyi@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> =E5=9C=A8 10/19/22 1:55 PM, Jason Wang =E5=86=99=E9=81=93:
>>>> On Wed, Oct 19, 2022 at 9:32 AM Shuyi Cheng
>>>> <chengshuyi@linux.alibaba.com> wrote:
>>>>>
>>>>> This patch introduces VIRTIO_NET_F_RX_TSTAMP to enhance the
>>>>> observability of network packet delay between virtio device and virti=
o
>>>>> driver.
>>>>>
>>>>> We have encountered many network jitter problems from virtio device t=
o
>>>>> virtio driver in the production environment. Due to the lack of relev=
ant
>>>>> indicators in this path, we often spend a lot of energy to locate suc=
h
>>>>> problems. If the virtio device can provide the packet receiving
>>>>> timestamp, then we can easily calculate the network jitter index betw=
een
>>>>> the virtio device and the virtio driver. When such a problem is
>>>>> encountered again, it is easy to determine the problem boundary.
>>>>>
>>>>> Thanks and looking forward to your response!
>>>>
>>>> While at it, do we need a tx timestamp as well?
>>>>
>>>
>>> We have not encountered network jitter in packets from driver to device=
.
>>> For now, rx timestamp is more valuable.
>>
>> Well, it doesn't mean it can't happen in other places, I'd suggest
>> adding it for symmetry.
>=20
> I included both previously in an RFC patch series:
>=20
> https://lists.linuxfoundation.org/pipermail/virtualization/2021-February/=
052424.html
>=20
> Ended up not sending that for inclusion due to lack of a device
> support. Maybe it can come in handy now.

Nice work! I studied it carefully, it seems that there are some problems=20
in the implementation of tx tstamp that need to be solved. Do you have=20
any plans to release the third version?

Thanks.

>>>
>>>>>
>>>>> Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
>>>>> ---
>>>>>     content.tex | 14 ++++++++++++++
>>>>>     1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/content.tex b/content.tex
>>>>> index e863709..472acf3 100644
>>>>> --- a/content.tex
>>>>> +++ b/content.tex
>>>>> @@ -3097,6 +3097,8 @@ \subsection{Feature bits}\label{sec:Device Type=
s /
>>>>> Network Device / Feature bits
>>>>>     \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet =
hash
>>>>>         value and a type of calculated hash.
>>>>>
>>>>> +\item[VIRTIO_NET_F_RX_TSTAMP(58)] Device can timestamp received pack=
et.
>>>>> +
>>>>>     \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact
>>>>> \field{hdr_len}
>>>>>         value. Device benefits from knowing the exact header length.
>>>>>
>>>>> @@ -3371,6 +3373,7 @@ \subsection{Device Operation}\label{sec:Device
>>>>> Types / Network Device / Device O
>>>>>     #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>>>>     #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>>>>     #define VIRTIO_NET_HDR_F_RSC_INFO      4
>>>>> +#define VIRTIO_NET_HDR_F_TSTAMP        8
>>>>>             u8 flags;
>>>>>     #define VIRTIO_NET_HDR_GSO_NONE        0
>>>>>     #define VIRTIO_NET_HDR_GSO_TCPV4       1
>>>>> @@ -3387,6 +3390,7 @@ \subsection{Device Operation}\label{sec:Device
>>>>> Types / Network Device / Device O
>>>>>             le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
>>>>> negotiated)
>>>>>             le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
>>>>> negotiated)
>>>>>             le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
>>>>> negotiated)
>>>>> +        le64 tstamp;            (Only if VIRITO_NET_F_RX_TSTAMP nego=
tiated)
>>>>>     };
>>>>>     \end{lstlisting}
>>>>>
>>>>> @@ -3809,6 +3813,13 @@ \subsubsection{Processing of Incoming
>>>>> Packets}\label{sec:Device Types / Network
>>>>>     checksum (in case of multiple encapsulated protocols, one level
>>>>>     of checksums is validated).
>>>>>
>>>>> +If VIRTIO_NET_F_RX_TSTAMP was not negotiated, the device MUST not se=
t
>>>>> +VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags}.
>>>>> +
>>>>> +If VIRTIO_NET_F_RX_TSTAMP was negotiated, the device MUST also
>>>>> +set VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags},
>>>>> +set \field{tstamp} to time to receive the packet.
>>>>
>>>> What kind of time should we use? Willem tried to propose something
>>>> like this via TAI:
>>>>
>>>> https://lists.linuxfoundation.org/pipermail/virtualization/2021-Februa=
ry/052476.html
>>>>
>>>> Thanks
>>>
>>> We calculate the jitter by the time difference between the two adjacent
>>> packets, that is
>>>          jitter =3D DriverTime(P2) - DriverTime(P1) -
>>>                  (DeviceTime(P2) - DeviceTime(P1))
>>>
>>
>> How can you guarantee this works after migration? E.g P2 is received
>> after migration.
>>
>> And what's more important, let's try to make the feature general by
>> not limiting the use case for jitter calculation only.
>>
>> Thanks
>>
>>> P1,P2 means packet
>>> DriverTime(Px) means the time from the Px packet to the virtio driver,
>>> DeviceTime (Px) means the time from the Px packet to the virtio device,
>>> which is the tstamp field in virtio_net_hdr
>>>
>>> Therefore, We may not specify the clock type. If the virtio device is
>>> hardware, it may be the hardware's own clock. If the virtio device is
>>> qemu, it may be CLOCK_MONOTONIC, TAI or other types.
>>>
>>>
>>>>
>>>>> +
>>>>>     \drivernormative{\paragraph}{Processing of Incoming
>>>>>     Packets}{Device Types / Network Device / Device Operation /
>>>>>     Processing of Incoming Packets}
>>>>> @@ -3831,6 +3842,9 @@ \subsubsection{Processing of Incoming
>>>>> Packets}\label{sec:Device Types / Network
>>>>>     VIRTIO_NET_HDR_F_DATA_VALID is set, the driver MUST NOT
>>>>>     rely on the packet checksum being correct.
>>>>>
>>>>> +If VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags} is not set, the
>>>>> +driver MUST NOT use the \field{tstamp}.
>>>>> +
>>>>>     \paragraph{Hash calculation for incoming packets}
>>>>>     \label{sec:Device Types / Network Device / Device Operation /
>>>>> Processing of Incoming Packets / Hash calculation for incoming packet=
s}
>>>>>
>>>>> --
>>>>> 2.27.0
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

