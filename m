Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
 <20221128031413.GA118868@h68b04307.sqa.eu95> <2cde8c0d-5826-408f-1034-0ed5852310d9@redhat.com>
 <20221128053316.GA103984@h68b04307.sqa.eu95> <CACGkMEvCRNFmkNnTaHPcA+=4tDOr7ZdwVHiKwdLTF=_Ad+dmtw@mail.gmail.com>
 <b0ffed52-ab12-4160-21c4-e01f9f34ac5f@linux.alibaba.com> <CACGkMEuDC=O8eP1me27i6e1F0fggqJwNLQb_0bH-PmwZ4duNXA@mail.gmail.com>
 <08f0a9ba-09d4-78e0-ae14-4c43e06aeda5@linux.alibaba.com>
In-Reply-To: <08f0a9ba-09d4-78e0-ae14-4c43e06aeda5@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Nov 2022 16:53:22 +0800
Message-ID: <CACGkMEucw6-CTcEHAAusGuxV5mMdRRRNyP8LrBiFhSdsyk2gpw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_net: support inner header hash
 for GRE-encapsulated packets
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 29, 2022 at 5:49 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2022/11/29 =E4=B8=8B=E5=8D=884:19, Jason Wang =E5=86=99=E9=81=
=93:
> > On Tue, Nov 29, 2022 at 1:11 PM Heng Qi <hengqi@linux.alibaba.com> wrot=
e:
> >>
> >>
> >> =E5=9C=A8 2022/11/29 =E4=B8=8A=E5=8D=8811:47, Jason Wang =E5=86=99=E9=
=81=93:
> >>> On Mon, Nov 28, 2022 at 1:33 PM Heng Qi <hengqi@linux.alibaba.com> wr=
ote:
> >>>> On Mon, Nov 28, 2022 at 11:52:23AM +0800, Jason Wang wrote:
> >>>>> =E5=9C=A8 2022/11/28 11:14, Heng Qi =E5=86=99=E9=81=93:
> >>>>>> On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
> >>>>>>> On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >>>>>>>> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> >>>>>>>> encapsulate the packets, the hash calculated using the outer hea=
der
> >>>>>>>> of the receive packets is always fixed for the same flow packets=
,
> >>>>>>>> i.e. they will be steered to the same receive queue.
> >>>>>>>>
> >>>>>>>> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_t=
ypes},
> >>>>>>>> which instructs the device to calculate the hash using the inner
> >>>>>>>> headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPOR=
T_GRE
> >>>>>>>> value in \field{hash_tunnel} to report packet type when calculat=
ing
> >>>>>>>> hash over the inner header.
> >>>>>>> So I think we need a new feature bit for this to keep migration c=
ompatibility.
> >>>>>>>
> >>>>>> If we consider adding feature negotiation for this, it will be exp=
lained
> >>>>>> more below.
> >>>>>>
> >>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>>>> ---
> >>>>>>>> v1:
> >>>>>>>>           1. Remove the patch for the bitmask fix. @Michael S. T=
sirkin
> >>>>>>>>           2. Clarify some paragraphs. @Jason Wang
> >>>>>>>>           3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_=
GRE. @Yuri Benditovich
> >>>>>>>>
> >>>>>>>>    content.tex | 140 +++++++++++++++++++++++++++++++++++++++++++=
+++++++--
> >>>>>>>>    1 file changed, 135 insertions(+), 5 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/content.tex b/content.tex
> >>>>>>>> index e863709..fba0c7d 100644
> >>>>>>>> --- a/content.tex
> >>>>>>>> +++ b/content.tex
> >>>>>>>> @@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device=
 Types / Network Device / Feature bits
> >>>>>>>>     to several segments when each of these smaller packets has U=
DP header.
> >>>>>>>>
> >>>>>>>>    \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-pac=
ket hash
> >>>>>>>> -    value and a type of calculated hash.
> >>>>>>>> +    value, a type of calculated hash and a tunnel packet type.
> >>>>>>>>
> >>>>>>>>    \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the e=
xact \field{hdr_len}
> >>>>>>>>        value. Device benefits from knowing the exact header leng=
th.
> >>>>>>>> @@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:De=
vice Types / Network Device / Device O
> >>>>>>>>            le16 num_buffers;
> >>>>>>>>            le32 hash_value;        (Only if VIRTIO_NET_F_HASH_RE=
PORT negotiated)
> >>>>>>>>            le16 hash_report;       (Only if VIRTIO_NET_F_HASH_RE=
PORT negotiated)
> >>>>>>>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPO=
RT negotiated)
> >>>>>>>> +        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPO=
RT negotiated)
> >>>>>>> It's better not limit this to be tunnel only unless we limit the =
same
> >>>>>>> for hash_config.
> >>>>>> Maybe we can use the \field{hash_report_ex} instead of \field{hash=
_tunnel}=EF=BC=9F
> >>>>> Probably.
> >>>>>
> >>>>>
> >>>>>>> Btw, this needs an independent fix. I wonder if we need a dedicat=
ed
> >>>>>>> feature bit VIRTIO_NET_F_HASH_REPORT_EX and documenting that devi=
ce
> >>>>>>> SHOULD offer HASH_REPORT_EX along with HASH_REPORT. Then we can d=
o GRE
> >>>>>>> tunnel hash report on top? (Or doing GRE first and fix the mismat=
ch on
> >>>>>>> top)
> >>>>>>>
> >>>>>> For this, we have the following ideas:
> >>>>>>
> >>>>>> 1. Considering our actual business application scenarios, the curr=
ent mainstream
> >>>>>>      tunnel-encapsulated technologies are mainly GRE and VXLAN, so=
 we are also
> >>>>>>      working on VXLAN.
> >>>>>>
> >>>>>> 2. To keep migration compatibility, we can add a VIRTIO_NET_F_HASH=
_GRE_INNER
> >>>>>>      feature bit (it depends on VIRTIO_NET_F_RSS). If it is negoti=
ated, this
> >>>>>>      means that the device calculates the hash based on the inner =
header of the
> >>>>>>      GRE-encapsulated packet. We assume that the inner header in G=
RE is TCPv4,
> >>>>>>      at this time \field{hash_types} needs to include
> >>>>>>      (VIRTIO_NET_HASH_TYPE_GRE_INNER | VIRTIO_NET_HASH_TYPE_TCPv4)=
. Besides,
> >>>>>>      if VIRTIO_NET_F_HASH_REPORT is also negotiated, then \field{h=
ash_report}
> >>>>>>      should be set to VIRTIO_NET_HASH_REPORT_TCPv4, and field \fie=
ld{hash_report_ex}
> >>>>>>      should be set to VIRTIO_NET_HASH_REPORT_GRE.
> >>>>> One question here, if I was not wrong, hash_report is sufficient fo=
r
> >>>>> GRE and VXLAN now. So that's why I think they should be indenepent
> >>>>> patch.
> >>>>>
> >>>> As discussed in https://lists.oasis-open.org/archives/virtio-dev/202=
211/msg00064.html,
> >>>> \field{hash_report} is an integer rather than a bitmask.
> >>> Ok, I see.
> >>>
> >>>> On the premise that
> >>>> VIRTIO_NET_F_HASH_GRE_INNER is negotiated, assuming that the inner h=
eader of the GRE packet
> >>>> is TCPv4 and we only have \field{hash_report} instead of \field{hash=
_report_ex}, then we
> >>>> need to set VIRTIO_NET_HASH_REPORT_GRE(10) in \field{hash_report} al=
ong with
> >>>> VIRTIO_NET_HASH_REPORT_TCPv4(2). At this point \field{hash_report} s=
hould be (2+10=3D12).
> >>>>
> >>>> However, if the inner header of another VXLAN packet is IPv4, and VI=
RTIO_NET_HASH_REPORT_VXLAN
> >>>> is 11 (following VIRTIO_NET_HASH_REPORT_GRE(10), like below), then \=
field{hash_report} is
> >>>> (1+11=3D12). Then how does the driver distinguish that 12 belongs to=
 the above which situation?
> >>>>
> >>>> Suppose the report type is as follows:
> >>>> \begin{lstlisting}
> >>>> #define VIRTIO_NET_HASH_REPORT_NONE            0
> >>>> #define VIRTIO_NET_HASH_REPORT_IPv4            1
> >>>> #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> >>>> #define VIRTIO_NET_HASH_REPORT_UDPv4           3
> >>>> #define VIRTIO_NET_HASH_REPORT_IPv6            4
> >>>> #define VIRTIO_NET_HASH_REPORT_TCPv6           5
> >>>> #define VIRTIO_NET_HASH_REPORT_UDPv6           6
> >>>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >>>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >>>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >>>> #define VIRTIO_NET_HASH_REPORT_GRE            10
> >>>> #define VIRTIO_NET_HASH_REPORT_VXLAN          11
> >>>> \end{lstlisting}
> >>>>
> >>>> So it seems more reasonable to include tunnel-related report types i=
n \field{hash_report_ex},
> >>> Ok, I think I got this, if we go this way, hash_report_tunnel might b=
e better.
> >> Ok. I agree with you.
> >>
> >>> In the long run, the mismatching behaviour of hash_config and
> >>> hash_report might end up more burden in the maintenance. I wonder if
> >>> it's worth it to make hash_report a bitmask that matches hash_config.
> >>> That seems to ease everything a lot.
> >> This seems to be debatable.
> >> In order not to cause trouble to users who currently use
> > It won't actually, we can introduce a new feature bit and when that
> > feature bit is negotiated, we can say hash_repot plus hash_report_ex
> > are bitmasks according to hash_config?
>
> Adding a feature bit and using \field{hash_report} and
> \field{hash_report_ex} together as bitmasks
> seems to be a bit of a detour. When VIRTIO_NET_F_HASH_GRE_VXLAN_INNER is
> negotiated, we
> pass \field{hash_report} and \field{hash_report_ex} as integers, which
> seems to work cleanly, and if
> \field{hash_report_ex} does not exist, simply use \field{hash_report},
> and pass it as Bitmask seems
> worth a try?
>
> Thanks.

Your call really.

Thanks

>
> >
> > Thanks
> >
> >> \field{hash_report}, we can make
> >> \field{hash_report} a bitmask when VIRTIO_NET_F_HASH_GRE_VXLAN_INNER i=
s
> >> negotiated,
> >> but this seems to make \field{hash_report} more than one word
> >> definition, and it is 16 bits
> >> but \field{hash_type} is 32 bits. VIRTIO_NET_HASH_TYPE_GRE_INNER and
> >> \field{hash_report_ex}
> >> are only used if VIRTIO_NET_F_HASH_GRE_VXLAN_INNER is negotiated and
> >> have no effect before.
> >>
> >>
> >> Thanks.
> >>
> >>> Thanks
> >>>
> >>>> or we can adopt something like https://lists.oasis-open.org/archives=
/virtio-dev/202211/msg00064.html
> >>>> , which only uses the \field{hash_report} method.
> >>>>
> >>>>>> 3. Why don't we consider a feature bit for all tunnel types?
> >>>>>>
> >>>>>>      If some devices do not support GRE but support VXLAN, and som=
e devices
> >>>>>>      support both VXLAN and GRE, so we must set the specific featu=
re bit
> >>>>>>      (e.g VIRTIO_NET_F_HASH_GRE_INNER) for a specific tunnel type.=
 Fortunately,
> >>>>>>      the number of mainstream tunnel encapsulations is limited.
> >>>>> My understanding is that if we start from having both GRE and VXLAN
> >>>>> for a single feature bit, it would be simpler for both maintaining
> >>>>> (spec), driver and device(vendor).
> >>>>>
> >>>>> (E.g it can force the device vendor to implement both)
> >>>> Ok, this seems to work. We can bind them together.
> >>>>
> >>>>>> 4. Why do we not need VIRTIO_NET_F_HASH_REPORT_EX after we negotia=
te VIRTIO_NET_F_HASH_GRE_INNER?
> >>>>>>
> >>>>>>      Because once VIRTIO_NET_F_HASH_GRE_INNER is negotiated, the d=
evice should
> >>>>>>      calculate the hash based on the GRE inner header, and should =
not hide the
> >>>>>>      information when reporting, that is, VIRTIO_NET_HASH_REPORT_T=
CPv4 and
> >>>>>>      VIRTIO_NET_HASH_REPORT_GRE should be set in \field{hash_repor=
t} and
> >>>>>>      \field{hash_report_ex} respectively.
> >>>>>>
> >>>>>> Do you think this is feasible?
> >>>>> I think so.
> >>>>>
> >>>>>
> >>>>>>>> +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPO=
RT negotiated)
> >>>>>>>>    };
> >>>>>>>>    \end{lstlisting}
> >>>>>>>>
> >>>>>>>> @@ -3837,7 +3838,7 @@ \subsubsection{Processing of Incoming Pack=
ets}\label{sec:Device Types / Network
> >>>>>>>>    A device attempts to calculate a per-packet hash in the follo=
wing cases:
> >>>>>>>>    \begin{itemize}
> >>>>>>>>    \item The feature VIRTIO_NET_F_RSS was negotiated. The device=
 uses the hash to determine the receive virtqueue to place incoming packets=
.
> >>>>>>>> -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The =
device reports the hash value and the hash type with the packet.
> >>>>>>>> +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The =
device reports the hash value, the hash type and the tunnel packet type.
> >>>>>>>>    \end{itemize}
> >>>>>>>>
> >>>>>>>>    If the feature VIRTIO_NET_F_RSS was negotiated:
> >>>>>>>> @@ -3883,6 +3884,10 @@ \subsubsection{Processing of Incoming Pac=
kets}\label{sec:Device Types / Network
> >>>>>>>>    #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
> >>>>>>>>    #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> >>>>>>>>    \end{lstlisting}
> >>>>>>>> +Hash types applicable to inner payloads of GRE-encapsulated pac=
kets
> >>>>>>> Unless there are other GRE related hash types, would it be better=
 to
> >>>>>>> say "inner payloads of tunnel packets"?
> >>>>>>>
> >>>>>> We will post a similar spec for VXLAN-encapsulated packets, which =
is in
> >>>>>> process. It is also a tunnel hash type.
> >>>>>>
> >>>>>>>> +\begin{lstlisting}
> >>>>>>>> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> >>>>>>>> +\end{lstlisting}
> >>>>>>>>
> >>>>>>>>    \subparagraph{IPv4 packets}
> >>>>>>>>    \label{sec:Device Types / Network Device / Device Operation /=
 Processing of Incoming Packets / Hash calculation for incoming packets / I=
Pv4 packets}
> >>>>>>>> @@ -3975,12 +3980,123 @@ \subsubsection{Processing of Incoming P=
ackets}\label{sec:Device Types / Network
> >>>>>>>>    (see \ref{sec:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets / Hash calculation for incoming packets =
/ IPv6 packets without extension header}).
> >>>>>>>>    \end{itemize}
> >>>>>>>>
> >>>>>>>> +\subparagraph{Inner payloads of GRE-encapsulated packets}
> >>>>>>>> +\label{sec:Device Types / Network Device / Device Operation / P=
rocessing of Incoming Packets / Hash calculation for incoming packets / Inn=
er payloads of GRE-encapsulated packets}}
> >>>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is set at the same time as o=
ne of
> >>>>>>>> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_=
TYPE_UDP_EX.
> >>>>>>>> +
> >>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
> >>>>>>>> +are IPv4 packets according to 'Enabled hash types' bitmasks as =
follows:
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCPv4 bits
> >>>>>>>> +      are set, and the GRE-encapsulated packet has an inner TCP=
v4 header in its
> >>>>>>>> +      payload, the hash is calculated over the following fields=
:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IP address
> >>>>>>>> +      \item inner Destination IP address
> >>>>>>>> +      \item inner Source TCP port
> >>>>>>>> +      \item inner Destination TCP port
> >>>>>>>> +    \end{itemsize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDPv4
> >>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r UDPv4 header in
> >>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IP address
> >>>>>>>> +      \item inner Destination IP address
> >>>>>>>> +      \item inner Source UDP port
> >>>>>>>> +      \item inner Destination UDP port
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IPv4
> >>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IP address
> >>>>>>>> +      \item inner Destination IP address
> >>>>>>>> +    \end{itemsize}
> >>>>>>>> +  \item Else the device does not calculate the hash
> >>>>>>>> +\end{itemize}
> >>>>>>>> +
> >>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
> >>>>>>>> +are IPv6 packets without extension headers according to 'Enable=
d hash types'
> >>>>>>>> +bitmasks as follows:
> >>>>>>>> +\begin{itemsize}
> >>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCPv6
> >>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r TCPv6 header in
> >>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IPv6 address
> >>>>>>>> +      \item inner Destination IPv6 address
> >>>>>>>> +      \item inner Source TCP port
> >>>>>>>> +      \item inner Destination TCP port
> >>>>>>>> +    \end{itemsize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDPv6
> >>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r UDPv6 header in
> >>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IPv6 address
> >>>>>>>> +      \item inner Destination IPv6 address
> >>>>>>>> +      \item inner Source UDP port
> >>>>>>>> +      \item inner Destination UDP port
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IPv6
> >>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item inner Source IPv6 address
> >>>>>>>> +      \item inner Destination IPv6 address
> >>>>>>>> +    \end{itemsize}
> >>>>>>>> +  \item Else the device does not calculate the hash
> >>>>>>>> +\end{itemize}
> >>>>>>>> +
> >>>>>>>> +The device calculates the hash on GRE-encapsulated packets whos=
e inner payloads
> >>>>>>>> +are IPv6 packets with extension headers according to 'Enabled h=
ash types'
> >>>>>>>> +bitmasks as follows:
> >>>>>>>> +\begin{itemsize}
> >>>>>>>> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_TCP_EX
> >>>>>>>> +      bits are set, and the GRE-encapsulated packet has an inne=
r TCPv6 header in
> >>>>>>>> +      its payload, the hash is calculated over the following fi=
elds:
> >>>>>>>> +    \begin{itemize}
> >>>>>>>> +      \item Home address from the home address option in the in=
ner IPv6 destination
> >>>>>>>> +          options header. If the inner extension header is not =
present, use the
> >>>>>>>> +          inner Source IPv6 address.
> >>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
> >>>>>>>> +          associated inner extension header. If the inner exten=
sion header is not
> >>>>>>>> +          present, use the inner Destination IPv6 address.
> >>>>>>>> +      \item inner Source TCP port
> >>>>>>>> +      \item inner Destination TCP port
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_UDP_EX
> >>>>>>>> +  bits are set, and the GRE-encapsulated packet has an inner UD=
Pv6 header in its
> >>>>>>>> +  payload, the hash is calculated over the following fields:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item Home address from the home address option in the in=
ner IPv6 destination
> >>>>>>>> +          options header. If the inner extension header is not =
present, use the
> >>>>>>>> +          inner Source IPv6 address.
> >>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
> >>>>>>>> +          associated inner extension header. If the inner exten=
sion header is not
> >>>>>>>> +          present, use the inner Destination IPv6 address.
> >>>>>>>> +      \item inner Source UDP port
> >>>>>>>> +      \item inner Destination UDP port
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_=
NET_HASH_TYPE_IP_EX
> >>>>>>>> +      bits are set, the hash is calculated over the following f=
ields:
> >>>>>>>> +    \begin{itemsize}
> >>>>>>>> +      \item Home address from the home address option in the in=
ner IPv6 destination
> >>>>>>>> +          options header. If the inner extension header is not =
present, use the
> >>>>>>>> +          inner Source IPv6 address.
> >>>>>>>> +      \item IPv6 address that is contained in the Routing-Heade=
r-Type-2 from the
> >>>>>>>> +          associated inner extension header. If the inner exten=
sion header is not
> >>>>>>>> +          present, use the inner Destination IPv6 address.
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +  \item Else skip inner IPv6 extension headers and calculate th=
e hash as defined
> >>>>>>>> +      for a GRE-encapsulated packet whose inner payload is an I=
Pv6 packet without
> >>>>>>>> +      extension headers
> >>>>>>>> +\end{itemsize}
> >>>>>>>> +
> >>>>>>>>    \paragraph{Hash reporting for incoming packets}
> >>>>>>>>    \label{sec:Device Types / Network Device / Device Operation /=
 Processing of Incoming Packets / Hash reporting for incoming packets}
> >>>>>>>>
> >>>>>>>>    If VIRTIO_NET_F_HASH_REPORT was negotiated and
> >>>>>>>> - the device has calculated the hash for the packet, the device =
fills \field{hash_report} with the report type of calculated hash
> >>>>>>>> -and \field{hash_value} with the value of calculated hash.
> >>>>>>>> + the device has calculated the hash for the packet, the device =
fills \field{hash_report} with the report type of calculated hash,
> >>>>>>>> +\field{hash_tunnel} with the type of the tunnel packet, and \fi=
eld{hash_value} with the value of calculated hash.
> >>>>>>>>
> >>>>>>>>    If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any rea=
son the
> >>>>>>>>    hash was not calculated, the device sets \field{hash_report} =
to VIRTIO_NET_HASH_REPORT_NONE.
> >>>>>>>> @@ -4005,6 +4121,20 @@ \subsubsection{Processing of Incoming Pac=
kets}\label{sec:Device Types / Network
> >>>>>>>>    #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >>>>>>>>    \end{lstlisting}
> >>>>>>>>
> >>>>>>>> +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE=
,
> >>>>>>>> +\field{hash_tunnel} can report the type of the tunnel-encapsula=
ted
> >>>>>>>> +packet to the driver over the inner header hash calculation.
> >>>>>>>> +Possible values that the device can report in field{hash_tunnel=
}
> >>>>>>>> +are defined below:
> >>>>>>>> +
> >>>>>>>> +\begin{lstlisting}
> >>>>>>>> +#define VIRTIO_NET_HASH_REPORT_GRE             1
> >>>>>>>> +\end{lstlisting}
> >>>>>>> What's the advantage of not simply doing the matching via the exi=
sting math:
> >>>>>>>
> >>>>>>> VIRTIO_NET_HASH_TYPE_XXX =3D 1 =C2=AB (VIRTIO_NET_HASH_REPORT_XXX=
 - 1)
> >>>>>>> ?
> >>>>>>>
> >>>>>> Considering that other tunnel-encapsulated packets may be added, t=
his
> >>>>>> existing formula will no longer be applicable.
> >>>>> So I basically mean what's wrong with simply defining
> >>>>> VIRTIO_NET_HASH_TYPE_GRE_INNER as 10?
> >>>>>
> >>>> Considering the addition of VXLAN, if VIRTIO_NET_HASH_TYPE_GRE_INNER=
 is 10,
> >>>> then VIRTIO_NET_HASH_TYPE_VXLAN_INNER should be 11, and they need to=
 be
> >>>> used with existing types in \field{hash_report} which brings problem=
s as I
> >>>> explained above, since they are integers instead of bitmask.
> >>>>
> >>>> Thanks.
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>> +The value VIRTIO_NET_HASH_REPORT_GRE corresponds to
> >>>>>>>> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit of supported hash types defi=
ned in
> >>>>>>>> +\ref{sec:Device Types / Network Device / Device Operation / Pro=
cessing of Incoming Packets / Hash calculation for incoming packets / Suppo=
rted/enabled hash types}.
> >>>>>>>> +
> >>>>>>>>    \subsubsection{Control Virtqueue}\label{sec:Device Types / Ne=
twork Device / Device Operation / Control Virtqueue}
> >>>>>>>>
> >>>>>>>>    The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_V=
Q is
> >>>>>>>> --
> >>>>>>>> 2.19.1.6.gb485710b
> >>>>>>>>
> >>>>>>> -----------------------------------------------------------------=
----
> >>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.o=
rg
> >>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open=
.org
>

