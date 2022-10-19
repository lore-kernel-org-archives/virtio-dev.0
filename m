Return-Path: <virtio-dev-return-10050-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C560198656C
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Oct 2022 07:24:02 +0000 (UTC)
Message-ID: <64f206ba-ad94-4526-a084-10ac96f0112b@linux.alibaba.com>
Date: Wed, 19 Oct 2022 15:23:56 +0800
MIME-Version: 1.0
References: <9b6d4dfb-39ca-1f46-3487-680267557d24@linux.alibaba.com>
 <CACGkMEviK-t+jCEdwUZHn=mJNYeC-wQY1FN0rwsDE5NEKxybMw@mail.gmail.com>
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
In-Reply-To: <CACGkMEviK-t+jCEdwUZHn=mJNYeC-wQY1FN0rwsDE5NEKxybMw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: support timestamp received
 packet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Willem de Bruijn <willemb@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 10/19/22 1:55 PM, Jason Wang =E5=86=99=E9=81=93:
> On Wed, Oct 19, 2022 at 9:32 AM Shuyi Cheng
> <chengshuyi@linux.alibaba.com> wrote:
>>
>> This patch introduces VIRTIO_NET_F_RX_TSTAMP to enhance the
>> observability of network packet delay between virtio device and virtio
>> driver.
>>
>> We have encountered many network jitter problems from virtio device to
>> virtio driver in the production environment. Due to the lack of relevant
>> indicators in this path, we often spend a lot of energy to locate such
>> problems. If the virtio device can provide the packet receiving
>> timestamp, then we can easily calculate the network jitter index between
>> the virtio device and the virtio driver. When such a problem is
>> encountered again, it is easy to determine the problem boundary.
>>
>> Thanks and looking forward to your response!
>=20
> While at it, do we need a tx timestamp as well?
>=20

We have not encountered network jitter in packets from driver to device.=20
For now, rx timestamp is more valuable.

>>
>> Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
>> ---
>>    content.tex | 14 ++++++++++++++
>>    1 file changed, 14 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..472acf3 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3097,6 +3097,8 @@ \subsection{Feature bits}\label{sec:Device Types /
>> Network Device / Feature bits
>>    \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
>>        value and a type of calculated hash.
>>
>> +\item[VIRTIO_NET_F_RX_TSTAMP(58)] Device can timestamp received packet.
>> +
>>    \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact
>> \field{hdr_len}
>>        value. Device benefits from knowing the exact header length.
>>
>> @@ -3371,6 +3373,7 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Network Device / Device O
>>    #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>    #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>    #define VIRTIO_NET_HDR_F_RSC_INFO      4
>> +#define VIRTIO_NET_HDR_F_TSTAMP        8
>>            u8 flags;
>>    #define VIRTIO_NET_HDR_GSO_NONE        0
>>    #define VIRTIO_NET_HDR_GSO_TCPV4       1
>> @@ -3387,6 +3390,7 @@ \subsection{Device Operation}\label{sec:Device
>> Types / Network Device / Device O
>>            le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
>> negotiated)
>>            le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
>> negotiated)
>>            le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
>> negotiated)
>> +        le64 tstamp;            (Only if VIRITO_NET_F_RX_TSTAMP negotia=
ted)
>>    };
>>    \end{lstlisting}
>>
>> @@ -3809,6 +3813,13 @@ \subsubsection{Processing of Incoming
>> Packets}\label{sec:Device Types / Network
>>    checksum (in case of multiple encapsulated protocols, one level
>>    of checksums is validated).
>>
>> +If VIRTIO_NET_F_RX_TSTAMP was not negotiated, the device MUST not set
>> +VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags}.
>> +
>> +If VIRTIO_NET_F_RX_TSTAMP was negotiated, the device MUST also
>> +set VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags},
>> +set \field{tstamp} to time to receive the packet.
>=20
> What kind of time should we use? Willem tried to propose something
> like this via TAI:
>=20
> https://lists.linuxfoundation.org/pipermail/virtualization/2021-February/=
052476.html
>=20
> Thanks

We calculate the jitter by the time difference between the two adjacent=20
packets, that is
=09jitter =3D DriverTime(P2) - DriverTime(P1) -
=09=09(DeviceTime(P2) - DeviceTime(P1))

P1,P2 means packet
DriverTime(Px) means the time from the Px packet to the virtio driver,
DeviceTime (Px) means the time from the Px packet to the virtio device,=20
which is the tstamp field in virtio_net_hdr

Therefore, We may not specify the clock type. If the virtio device is=20
hardware, it may be the hardware's own clock. If the virtio device is=20
qemu, it may be CLOCK_MONOTONIC, TAI or other types.


>=20
>> +
>>    \drivernormative{\paragraph}{Processing of Incoming
>>    Packets}{Device Types / Network Device / Device Operation /
>>    Processing of Incoming Packets}
>> @@ -3831,6 +3842,9 @@ \subsubsection{Processing of Incoming
>> Packets}\label{sec:Device Types / Network
>>    VIRTIO_NET_HDR_F_DATA_VALID is set, the driver MUST NOT
>>    rely on the packet checksum being correct.
>>
>> +If VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags} is not set, the
>> +driver MUST NOT use the \field{tstamp}.
>> +
>>    \paragraph{Hash calculation for incoming packets}
>>    \label{sec:Device Types / Network Device / Device Operation /
>> Processing of Incoming Packets / Hash calculation for incoming packets}
>>
>> --
>> 2.27.0
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

