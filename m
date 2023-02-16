Return-Path: <virtio-comment-return-4267-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <aa76a49a-a578-4d15-3f42-519c97d6a812@linux.alibaba.com>
Date: Thu, 16 Feb 2023 14:48:40 +0800
MIME-Version: 1.0
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
 <20230213153119-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230213153119-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v8] virtio-net: support
 inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/14 =E4=B8=8A=E5=8D=884:43, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Mon, Feb 13, 2023 at 09:05:04PM +0800, Heng Qi wrote:
>> Hi, all.
>>
>> Do you have any comments on this version?
>>
>> Thanks.
>>
>> =E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=885:08, Heng Qi =E5=86=99=E9=81=93:
>>> If the tunnel is used to encapsulate the packets, the hash calculated
>>> using the outer header of the receive packets is always fixed for the
>>> same flow packets, i.e. they will be steered to the same receive queue.
>>>
>>> We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
>>> in \field{hash_tunnel_types}, which instructs the device to calculate t=
he
>>> hash using the inner headers of tunnel-encapsulated packets. Besides,
>>> values in \field{hash_report_tunnel_types} are added to report tunnel t=
ypes.
>>>
>>> Note that VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the in=
ner
>>> header hash, and does not give the device the ability to use the hash v=
alue
>>> to select a receiving queue to place the packet.
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151
>>>
>>> Reviewed-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> I didn't yes come up with anything convincing for improving
> security (dos/usage info leak due to queue collisions between
> tunnels).
>
> I'd like to at least have a security considerations section
> documenting the issue with using RSS with tunneling.

I think it's a good idea, I agree.

> In fact it's high time we started adding these sections all over
> the place.
>
> I also found out at least mlx5 has these tunnel offloads,
> so I'd like to ask nvidia guys here on list
> - does this cover e.g. mlx5 functionality? e.g. is the tunnel list
>    sufficient?
> - does mlx5 cover queue collisions between tunnels and if yes how?
>
> Thanks!
>
>
>>> ---
>>> v7->v8:
>>> =091. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
>>> =092. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pan=
dit
>>> =093. Removed re-definition for inner packet hashing. @Parav Pandit
>>> =094. Fix some typos. @Michael S . Tsirkin
>>> =095. Clarify some sentences. @Michael S . Tsirkin
>>>
>>> v6->v7:
>>> =091. Modify the wording of some sentences for clarity. @Michael S. Tsi=
rkin
>>> =092. Fix some syntax issues. @Michael S. Tsirkin
>>>
>>> v5->v6:
>>> =091. Fix some syntax and capitalization issues. @Michael S. Tsirkin
>>> =092. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
>>> =093. Move the links to introduction section. @Michael S. Tsirkin
>>> =094. Clarify some sentences. @Michael S. Tsirkin
>>>
>>> v4->v5:
>>> =091. Clarify some paragraphs. @Cornelia Huck
>>> =092. Fix the u8 type. @Cornelia Huck
>>>
>>> v3->v4:
>>> =091. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_H=
ASH_TUNNEL. @Jason Wang
>>> =092. Make things clearer. @Jason Wang @Michael S. Tsirkin
>>> =093. Keep the possibility to use inner hash for automatic receive stee=
ring. @Jason Wang
>>> =094. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc.=
 many times. @Michael S. Tsirkin
>>>
>>> v2->v3:
>>> =091. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>>> =092. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason W=
ang, @Michael S. Tsirkin
>>>
>>> v1->v2:
>>> =091. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>>> =092. Clarify some paragraphs. @Jason Wang
>>> =093. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Ben=
ditovich
>>>
>>>    content.tex      | 135 ++++++++++++++++++++++++++++++++++++++++++---=
--
>>>    introduction.tex |  19 +++++++
>>>    2 files changed, 140 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index e863709..2598d96 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
>>>    \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through contro=
l
>>>        channel.
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner header hash
>>> +=09for tunnel-encapsulated packets.
>>> +
>>>    \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coal=
escing.
>>>    \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets=
.
>>> @@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
>>>     to several segments when each of these smaller packets has UDP head=
er.
>>>    \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet has=
h
>>> -    value and a type of calculated hash.
>>> +    value, a type of calculated hash, and, if VIRTIO_NET_F_HASH_TUNNEL
>>> +    is negotiated, an encapsulation packet type.
>>>    \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \f=
ield{hdr_len}
>>>        value. Device benefits from knowing the exact header length.
>>> @@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
>>>    \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTI=
O_NET_F_HOST_TSO6.
>>>    \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>    \end{description}
>>>    \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Type=
s / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -3199,20 +3204,27 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Network Device
>>>            u8 rss_max_key_size;
>>>            le16 rss_max_indirection_table_length;
>>>            le32 supported_hash_types;
>>> +        le32 supported_tunnel_hash_types;
>>>    };
>>>    \end{lstlisting}
>>> -The following field, \field{rss_max_key_size} only exists if VIRTIO_NE=
T_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>>> +The following field, \field{rss_max_key_size} only exists if VIRTIO_NE=
T_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
>>>    It specifies the maximum supported length of RSS key in bytes.
>>>    The following field, \field{rss_max_indirection_table_length} only e=
xists if VIRTIO_NET_F_RSS is set.
>>>    It specifies the maximum number of 16-bit entries in RSS indirection=
 table.
>>>    The next field, \field{supported_hash_types} only exists if the devi=
ce supports hash calculation,
>>> -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>>> +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HAS=
H_TUNNEL is set.
>>>    Field \field{supported_hash_types} contains the bitmask of supported=
 hash types.
>>>    See \ref{sec:Device Types / Network Device / Device Operation / Proc=
essing of Incoming Packets / Hash calculation for incoming packets / Suppor=
ted/enabled hash types} for details of supported hash types.
>>> +The next field, \field{supported_tunnel_hash_types} only exists if the=
 device
>>> +supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is s=
et.
>>> +
>>> +Field \field{supported_tunnel_hash_types} contains the bitmask of supp=
orted tunnel hash types.
>>> +See \ref{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / Supporte=
d/enabled tunnel hash types} for details of supported tunnel hash types.
>>> +
>>>    \devicenormative{\subsubsection}{Device configuration layout}{Device=
 Types / Network Device / Device configuration layout}
>>>    The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8=
000 inclusive,
>>> @@ -3236,7 +3248,7 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Network Device
>>>    negotiated.
>>>    The device MUST set \field{rss_max_key_size} to at least 40, if it o=
ffers
>>> -VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
>>> +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL=
.
>>>    The device MUST set \field{rss_max_indirection_table_length} to at l=
east 128, if it offers
>>>    VIRTIO_NET_F_RSS.
>>> @@ -3384,9 +3396,10 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Network Device / Device O
>>>            le16 csum_start;
>>>            le16 csum_offset;
>>>            le16 num_buffers;
>>> -        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>>> -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>>> -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>>> +        le32 hash_value;              (Only if VIRTIO_NET_F_HASH_REPOR=
T negotiated)
>>> +        le16 hash_report;             (Only if VIRTIO_NET_F_HASH_REPOR=
T negotiated)
>>> +        u8 hash_report_tunnel_types;  (Only if VIRTIO_NET_F_HASH_REPOR=
T negotiated, only valid if VIRTIO_NET_F_HASH_TUNNEL negotiated, otherwise =
reserved)
>>> +        u8 padding_reserved;          (Only if VIRTIO_NET_F_HASH_REPOR=
T negotiated)
>>>    };
>>>    \end{lstlisting}
>>> @@ -3838,11 +3851,15 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
>>>    \begin{itemize}
>>>    \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses t=
he hash to determine the receive virtqueue to place incoming packets.
>>>    \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The devic=
e reports the hash value and the hash type with the packet.
>>> +=09If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device=
 reports the encapsulation type as well.
>>> +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device =
supports inner hash calculation.
>>>    \end{itemize}
>>>    If the feature VIRTIO_NET_F_RSS was negotiated:
>>>    \begin{itemize}
>>>    \item The device uses \field{hash_types} of the virtio_net_rss_confi=
g structure as 'Enabled hash types' bitmask.
>>> +=09If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device=
 uses \field{hash_tunnel_types} of the
>>> +=09virtio_net_rss_config structure as 'Enabled hash tunnel types' bitm=
ask.
>>>    \item The device uses a key as defined in \field{hash_key_data} and =
\field{hash_key_length} of the virtio_net_rss_config structure (see
>>>    \ref{sec:Device Types / Network Device / Device Operation / Control =
Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
>>>    \end{itemize}
>>> @@ -3850,11 +3867,13 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
>>>    If the feature VIRTIO_NET_F_RSS was not negotiated:
>>>    \begin{itemize}
>>>    \item The device uses \field{hash_types} of the virtio_net_hash_conf=
ig structure as 'Enabled hash types' bitmask.
>>> +=09If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device=
 uses \field{hash_tunnel_types} of the
>>> +=09virtio_net_hash_config structure as 'Enabled hash tunnel types' bit=
mask.
>>>    \item The device uses a key as defined in \field{hash_key_data} and =
\field{hash_key_length} of the virtio_net_hash_config structure (see
>>>    \ref{sec:Device Types / Network Device / Device Operation / Control =
Virtqueue / Automatic receive steering in multiqueue mode / Hash calculatio=
n}).
>>>    \end{itemize}
>>> -Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it su=
pports only one pair of virtqueues, it MUST support
>>> +Note that if the device offers VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_=
F_HASH_TUNNEL, even if it supports only one pair of virtqueues, it MUST sup=
port
>>>    at least one of commands of VIRTIO_NET_CTRL_MQ class to configure re=
ported hash parameters:
>>>    \begin{itemize}
>>>    \item If the device offers VIRTIO_NET_F_RSS, it MUST support VIRTIO_=
NET_CTRL_MQ_RSS_CONFIG command per
>>> @@ -3863,8 +3882,37 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
>>>     \ref{sec:Device Types / Network Device / Device Operation / Control=
 Virtqueue / Automatic receive steering in multiqueue mode / Hash calculati=
on}.
>>>    \end{itemize}
>>> +\subparagraph{Tunnel/Encapsulated packet}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Tunnel/Enc=
apsulated packet}
>>> +A tunnel packet is encapsulated from the original packet based on the =
tunneling
>>> +protocol (only a single level of encapsulation is currently supported)=
. The
>>> +encapsulated packet contains an outer header and an inner header, and =
the device
>>> +calculates the hash over either the inner header or the outer header.
>>> +
>>> +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the corres=
ponding
>>> +encapsulation type is set in \field{hash_tunnel_types}, the hash for a=
 specific
>>> +type of encapsulated packet is calculated over the inner as opposed to=
 outer header.
>>> +Supported encapsulation types are listed in \ref{sec:Device Types / Ne=
twork Device /
>>> +Device Operation / Processing of Incoming Packets / Hash calculation f=
or incoming packets /
>>> +Supported/enabled hash tunnel types}.
>>> +
>>> +If both VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_TUNNEL are nego=
tiated,
>>> +and the corresponding encapsulation type is set in \field{hash_tunnel_=
types},
>>> +the device supports inner hash calculation for the encapsulated packet=
,
>>> +For example, if the encapsulated packets \hyperref[intro:GRE]{[GRE]},
>>> +\hyperref[intro:VXLAN]{[VXLAN]} and \hyperref[intro:GENEVE]{[GENEVE]} =
are hashed in inner
>>> +headers, then \field{hash_tunnel_types} should be set to VIRTIO_NET_HA=
SH_TUNNEL_TYPE_{GRE, VXLAN, GENEVE}
>>> +respectively, and \field{hash_report_tunnel_types} should be respectiv=
ely set to
>>> +VIRTIO_NET_HASH_TUNNEL_REPORT_{GRE, VXLAN, GENEVE}.
>>> +
>>> +If VIRTIO_NET_F_HASH_REPORT is negotiated but VIRTIO_NET_F_HASH_TUNNEL=
 is not
>>> +negotiated, the device calculates the hash over the outer header, and =
\field{hash_report}
>>> +reports the hash type. \field{hash_report_tunnel_types} is no longer v=
alid.
>>> +
>>>    \subparagraph{Supported/enabled hash types}
>>>    \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / Supporte=
d/enabled hash types}
>>> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
>>> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>>>    Hash types applicable for IPv4 packets:
>>>    \begin{lstlisting}
>>>    #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
>>> @@ -3884,6 +3932,24 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
>>>    #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>>    \end{lstlisting}
>>> +\subparagraph{Supported/enabled tunnel hash types}
>>> +\label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Supported/=
enabled tunnel hash types}
>>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the encapsulati=
on
>>> +hash type indicates that the hash is calculated over the inner header =
of
>>> +the encapsulated packet:
>>> +Hash type applicable for inner payload of the gre-encapsulated packet
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 0)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the vxlan-encapsulated packe=
t
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 1)
>>> +\end{lstlisting}
>>> +Hash type applicable for inner payload of the geneve-encapsulated pack=
et
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 2)
>>> +\end{lstlisting}
>>> +
>>>    \subparagraph{IPv4 packets}
>>>    \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / IPv4 pac=
kets}
>>>    The device calculates the hash on IPv4 packets according to 'Enabled=
 hash types' bitmask as follows:
>>> @@ -3975,15 +4041,26 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
>>>    (see \ref{sec:Device Types / Network Device / Device Operation / Pro=
cessing of Incoming Packets / Hash calculation for incoming packets / IPv6 =
packets without extension header}).
>>>    \end{itemize}
>>> +\subparagraph{Inner hash calculation of an encapsulated packet}
>>> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the correspo=
nding
>>> +encapsulation hash type is set in \field{hash_tunnel_types}, the devic=
e calculates the
>>> +hash on the inner header of an encapsulated packet (See \ref{sec:Devic=
e Types
>>> +/ Network Device / Device Operation / Processing of Incoming Packets /
>>> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}), =
and
>>> +\field{hash_report_tunnel_types} contains the valid outer tunnel type.
>>> +
>>>    \paragraph{Hash reporting for incoming packets}
>>>    \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash reporting for incoming packets}
>>> -
>>> -If VIRTIO_NET_F_HASH_REPORT was negotiated and
>>> - the device has calculated the hash for the packet, the device fills \=
field{hash_report} with the report type of calculated hash
>>> -and \field{hash_value} with the value of calculated hash.
>>> +If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculat=
ed the
>>> +hash for the packet, the device fills \field{hash_report} with the rep=
ort type
>>> +of calculated hash, and \field{hash_value} with the value of calculate=
d hash.
>>> +Also, if VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device needs to =
fill
>>> +\field{hash_report_tunnel_types} with the report type of the encapsula=
ted packet,
>>> +and it is set to VIRTIO_NET_HASH_TUNNEL_REPORT_NONE for the unencapsul=
ated packet.
>>>    If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
>>> -hash was not calculated, the device sets \field{hash_report} to VIRTIO=
_NET_HASH_REPORT_NONE.
>>> +hash was not calculated, the device sets \field{hash_report} to VIRTIO=
_NET_HASH_REPORT_NONE,
>>> +and sets \field{hash_report_tunnel_types} to VIRTIO_NET_HASH_TUNNEL_RE=
PORT_NONE.
>>>    Possible values that the device can report in \field{hash_report} ar=
e defined below.
>>>    They correspond to supported hash types defined in
>>> @@ -4005,6 +4082,26 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
>>>    #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>    \end{lstlisting}
>>> +\field{hash_report_tunnel} can report the type of the encapsulated
>>> +packet to the driver when the inner header hash is calculated.
>>> +Possible values that the device can report in \field{hash_report_tunne=
l_types}
>>> +are defined below.
>>> +They correspond to supported hash tunnel types defined in
>>> +\ref{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled hash tunnel types}
>>> +as follows:
>>> +
>>> +VIRTIO_NET_HASH_TUNNEL_TYPE_XXX =3D 1 << (VIRTIO_NET_HASH_TUNNEL_REPOR=
T_XXX -1)
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_NONE     0
>>> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GRE      1
>>> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_VXLAN    2
>>> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GENEVE   3
>>> +\end{lstlisting}
>>> +
>>> +They correspond to supported hash types defined in
>>> +\ref{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled hash types}.
>>> +
>>>    \subsubsection{Control Virtqueue}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue}
>>>    The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
>>> @@ -4364,6 +4461,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>>    \begin{lstlisting}
>>>    struct virtio_net_hash_config {
>>>        le32 hash_types;
>>> +    le32 hash_tunnel_types;
>>>        le16 reserved[4];
>>>        u8 hash_key_length;
>>>        u8 hash_key_data[hash_key_length];
>>> @@ -4372,7 +4470,12 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>>    Field \field{hash_types} contains a bitmask of allowed hash types as
>>>    defined in
>>>    \ref{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Supported/=
enabled hash types}.
>>> -Initially the device has all hash types disabled and reports only VIRT=
IO_NET_HASH_REPORT_NONE.
>>> +
>>> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tun=
nel types as
>>> +defined in \ref{sec:Device Types / Network Device / Device Operation /=
 Processing of Incoming Packets / Hash calculation for incoming packets / S=
upported/enabled hash tunnel types}.
>>> +
>>> +Initially the device has all hash types and hash tunnel types disabled=
 and reports only
>>> +VIRTIO_NET_HASH_REPORT_NONE and VIRTIO_NET_HASH_TUNNEL_REPORT_NONE res=
pectively.
>>>    Field \field{reserved} MUST contain zeroes. It is defined to make th=
e structure to match the layout of virtio_net_rss_config structure,
>>>    defined in \ref{sec:Device Types / Network Device / Device Operation=
 / Control Virtqueue / Receive-side scaling (RSS)}.
>>> @@ -4390,6 +4493,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>>    \begin{lstlisting}
>>>    struct virtio_net_rss_config {
>>>        le32 hash_types;
>>> +    le32 hash_tunnel_types;
>>>        le16 indirection_table_mask;
>>>        le16 unclassified_queue;
>>>        le16 indirection_table[indirection_table_length];
>>> @@ -4402,6 +4506,9 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>>    defined in
>>>    \ref{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Supported/=
enabled hash types}.
>>> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tun=
nel types as
>>> +defined in \ref{sec:Device Types / Network Device / Device Operation /=
 Processing of Incoming Packets / Hash calculation for incoming packets / S=
upported/enabled hash tunnel types}.
>>> +
>>>    Field \field{indirection_table_mask} is a mask to be applied to
>>>    the calculated hash to produce an index in the
>>>    \field{indirection_table} array.
>>> diff --git a/introduction.tex b/introduction.tex
>>> index 287c5fc..ff01a9b 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -98,6 +98,25 @@ \section{Normative References}\label{sec:Normative R=
eferences}
>>>    =09\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>>>        Standards for Efficient Cryptography Group(SECG), ``SEC1: Ellipt=
ic Cureve Cryptography'', Version 1.0, September 2000.
>>>    =09\newline\url{https://www.secg.org/sec1-v2.pdf}\\
>>> +=09\phantomsection\label{intro:GRE}\textbf{[GRE]} &
>>> +=09Generic Routing Encapsulation
>>> +=09\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
>>> +=09\phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
>>> +=09Virtual eXtensible Local Area Network
>>> +=09\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
>>> +=09\phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
>>> +=09Generic Network Virtualization Encapsulation
>>> +=09\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
>>> +=09\phantomsection\label{intro:IP}\textbf{[IP]} &
>>> +=09INTERNET PROTOCOL
>>> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
>>> +=09\phantomsection\label{intro:UDP}\textbf{[UDP]} &
>>> +=09User Datagram Protocol
>>> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
>>> +=09\phantomsection\label{intro:TCP}\textbf{[TCP]} &
>>> +=09TRANSMISSION CONTROL PROTOCOL
>>> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>>> +
>>>    \end{longtable}
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

