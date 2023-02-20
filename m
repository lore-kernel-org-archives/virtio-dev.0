Return-Path: <virtio-comment-return-4385-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <a93e8cb6-6d09-9bfd-fe68-863d2975e17f@linux.alibaba.com>
Date: Mon, 20 Feb 2023 23:53:31 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230218143715.841-1-hengqi@linux.alibaba.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v9] virtio-net: support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, all.
Do you have any comments on this?

Thanks!

=E5=9C=A8 2023/2/18 =E4=B8=8B=E5=8D=8810:37, Heng Qi =E5=86=99=E9=81=93:
> If the tunnel is used to encapsulate the packets, the hash calculated
> using the outer header of the receive packets is always fixed for the
> same flow packets, i.e. they will be steered to the same receive queue.
>
> We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks
> in \field{hash_tunnel_types}, which instructs the device to calculate the
> hash using the inner headers of tunnel-encapsulated packets. Note that
> VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the inner header
> hash, and does not give the device the ability to use the hash value
> to select a receiving queue to place the packet.
>
> Also, a feature bit VIRTIO_NET_F_HASH_REPORT_TUNNEL are added to report
> an encapsulation type, and the feature depends on VIRTIO_NET_F_HASH_REPOR=
T.
> It only means that the encapsulation type can be reported, it cannot inst=
ruct
> the device to calculate the hash.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/151
>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v8->v9:
> =091. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
> =092. Add tunnel security section. @Michael S . Tsirkin
> =093. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
> =094. Fix some typos.
> =095. Add more tunnel types. @Michael S . Tsirkin
>
> v7->v8:
> =091. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
> =092. Change hash_report_tunnel to hash_report_tunnel_types. @Parav Pandi=
t
> =093. Removed re-definition for inner packet hashing. @Parav Pandit
> =094. Fix some typos. @Michael S . Tsirkin
> =095. Clarify some sentences. @Michael S . Tsirkin
>
> v6->v7:
> =091. Modify the wording of some sentences for clarity. @Michael S. Tsirk=
in
> =092. Fix some syntax issues. @Michael S. Tsirkin
>
> v5->v6:
> =091. Fix some syntax and capitalization issues. @Michael S. Tsirkin
> =092. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
> =093. Move the links to introduction section. @Michael S. Tsirkin
> =094. Clarify some sentences. @Michael S. Tsirkin
>
> v4->v5:
> =091. Clarify some paragraphs. @Cornelia Huck
> =092. Fix the u8 type. @Cornelia Huck
>
> v3->v4:
> =091. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_F_HAS=
H_TUNNEL. @Jason Wang
> =092. Make things clearer. @Jason Wang @Michael S. Tsirkin
> =093. Keep the possibility to use inner hash for automatic receive steeri=
ng. @Jason Wang
> =094. Add the "Tunnel packet" paragraph to avoid repeating the GRE etc. m=
any times. @Michael S. Tsirkin
>
> v2->v3:
> =091. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> =092. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wan=
g, @Michael S. Tsirkin
>
> v1->v2:
> =091. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> =092. Clarify some paragraphs. @Jason Wang
> =093. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Bendi=
tovich
>
>   content.tex      | 164 ++++++++++++++++++++++++++++++++++++++++++-----
>   introduction.tex |  25 ++++++++
>   2 files changed, 174 insertions(+), 15 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index e863709..8e352d2 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3084,6 +3084,11 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>  =20
> +\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash
> +=09for tunnel-encapsulated packets.
> +
> +\item[VIRTIO_NET_F_HASH_REPORT_TUNNEL(52)] Device can report an encapsul=
ation type.
> +
>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesc=
ing.
>  =20
>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3140,6 +3145,8 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_N=
ET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_HASH_REPORT_TUNNEL] Requires VIRTIO_NET_F_HASH_REPORT=
.
>   \end{description}
>  =20
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3199,20 +3206,27 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Network Device
>           u8 rss_max_key_size;
>           le16 rss_max_indirection_table_length;
>           le32 supported_hash_types;
> +        le32 supported_tunnel_hash_types;
>   };
>   \end{lstlisting}
> -The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_=
F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> +The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_=
F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL is set.
>   It specifies the maximum supported length of RSS key in bytes.
>  =20
>   The following field, \field{rss_max_indirection_table_length} only exis=
ts if VIRTIO_NET_F_RSS is set.
>   It specifies the maximum number of 16-bit entries in RSS indirection ta=
ble.
>  =20
>   The next field, \field{supported_hash_types} only exists if the device =
supports hash calculation,
> -i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
> +i.e. if VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_=
TUNNEL is set.
>  =20
>   Field \field{supported_hash_types} contains the bitmask of supported ha=
sh types.
>   See \ref{sec:Device Types / Network Device / Device Operation / Process=
ing of Incoming Packets / Hash calculation for incoming packets / Supported=
/enabled hash types} for details of supported hash types.
>  =20
> +The next field, \field{supported_tunnel_hash_types} only exists if the d=
evice
> +supports inner hash calculation, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set=
.
> +
> +Field \field{supported_tunnel_hash_types} contains the bitmask of suppor=
ted tunnel hash types.
> +See \ref{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Supported/=
enabled tunnel hash types} for details of supported tunnel hash types.
> +
>   \devicenormative{\subsubsection}{Device configuration layout}{Device Ty=
pes / Network Device / Device configuration layout}
>  =20
>   The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000=
 inclusive,
> @@ -3236,7 +3250,7 @@ \subsection{Device configuration layout}\label{sec:=
Device Types / Network Device
>   negotiated.
>  =20
>   The device MUST set \field{rss_max_key_size} to at least 40, if it offe=
rs
> -VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> +VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_HASH_TUNNEL.
>  =20
>   The device MUST set \field{rss_max_indirection_table_length} to at leas=
t 128, if it offers
>   VIRTIO_NET_F_RSS.
> @@ -3385,7 +3399,8 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Network Device / Device O
>           le16 csum_offset;
>           le16 num_buffers;
>           le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negot=
iated)
> -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negoti=
ated)
> +        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negoti=
ated, and the upper 8 bits indicates the
> +                                 encapsulation type if VIRTIO_NET_F_HASH=
_REPORT_TUNNEL negotiated, otherwise reserved)
>           le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negot=
iated)
>   };
>   \end{lstlisting}
> @@ -3838,11 +3853,15 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>   \begin{itemize}
>   \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the =
hash to determine the receive virtqueue to place incoming packets.
>   \item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device r=
eports the hash value and the hash type with the packet.
> +\item The feature VIRTIO_NET_F_HASH_TUNNEL was negotiated. The device su=
pports inner hash calculation. If additionally
> +      VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the device reports=
 the encapsulation type as well.
>   \end{itemize}
>  =20
>   If the feature VIRTIO_NET_F_RSS was negotiated:
>   \begin{itemize}
>   \item The device uses \field{hash_types} of the virtio_net_rss_config s=
tructure as 'Enabled hash types' bitmask.
> +=09If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device u=
ses \field{hash_tunnel_types} of the
> +=09virtio_net_rss_config structure as 'Enabled hash tunnel types' bitmas=
k.
>   \item The device uses a key as defined in \field{hash_key_data} and \fi=
eld{hash_key_length} of the virtio_net_rss_config structure (see
>   \ref{sec:Device Types / Network Device / Device Operation / Control Vir=
tqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
>   \end{itemize}
> @@ -3850,11 +3869,13 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>   If the feature VIRTIO_NET_F_RSS was not negotiated:
>   \begin{itemize}
>   \item The device uses \field{hash_types} of the virtio_net_hash_config =
structure as 'Enabled hash types' bitmask.
> +=09If additionally VIRTIO_NET_F_HASH_TUNNEL was negotiated, the device u=
ses \field{hash_tunnel_types} of the
> +=09virtio_net_hash_config structure as 'Enabled hash tunnel types' bitma=
sk.
>   \item The device uses a key as defined in \field{hash_key_data} and \fi=
eld{hash_key_length} of the virtio_net_hash_config structure (see
>   \ref{sec:Device Types / Network Device / Device Operation / Control Vir=
tqueue / Automatic receive steering in multiqueue mode / Hash calculation})=
.
>   \end{itemize}
>  =20
> -Note that if the device offers VIRTIO_NET_F_HASH_REPORT, even if it supp=
orts only one pair of virtqueues, it MUST support
> +Note that if the device offers VIRTIO_NET_F_HASH_REPORT or VIRTIO_NET_F_=
HASH_TUNNEL, even if it supports only one pair of virtqueues, it MUST suppo=
rt
>   at least one of commands of VIRTIO_NET_CTRL_MQ class to configure repor=
ted hash parameters:
>   \begin{itemize}
>   \item If the device offers VIRTIO_NET_F_RSS, it MUST support VIRTIO_NET=
_CTRL_MQ_RSS_CONFIG command per
> @@ -3863,8 +3884,36 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>    \ref{sec:Device Types / Network Device / Device Operation / Control Vi=
rtqueue / Automatic receive steering in multiqueue mode / Hash calculation}=
.
>   \end{itemize}
>  =20
> +\subparagraph{Tunnel/Encapsulated packet}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Tunnel/Encap=
sulated packet}
> +A tunnel packet is encapsulated from the original packet based on the tu=
nneling
> +protocol (only a single level of encapsulation is currently supported). =
The
> +encapsulated packet contains an outer header and an inner header, and th=
e device
> +calculates the hash over either the inner header or the outer header.
> +
> +When the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the correspo=
nding
> +encapsulation type is set in \field{hash_tunnel_types}, the hash for a s=
pecific
> +type of encapsulated packet is calculated over the inner as opposed to o=
uter header.
> +Supported encapsulation types are listed in \ref{sec:Device Types / Netw=
ork Device /
> +Device Operation / Processing of Incoming Packets / Hash calculation for=
 incoming packets /
> +Supported/enabled hash tunnel types}.
> +
> +If both VIRTIO_NET_F_HASH_REPORT_TUNNEL and VIRTIO_NET_F_HASH_REPORT are=
 negotiated,
> +and hash is calculated for an encapsulated  packet, the device reports t=
he encapsulation
> +type in addition to the hash value and hash type, regardless of whether =
the hash is
> +calculated on the inner header or the outer header.
> +
> +If VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_HASH_REPORT_TUNNEL are nego=
tiated
> +but VIRTIO_NET_F_HASH_TUNNEL is not negotiated, the device calculates th=
e hash over
> +the outer header, and \field{hash_report} reports the hash type and enca=
psulation type.
> +
> +Some encapsulated packet types: \hyperref[intro:GRE]{[GRE]}, \hyperref[i=
ntro:VXLAN]{[VXLAN]},
> +\hyperref[intro:GENEVE]{[GENEVE]}, \hyperref[intro:IPIP]{[IPIP]} and \hy=
perref[intro:NVGRE]{[NVGRE]}.
> +
>   \subparagraph{Supported/enabled hash types}
>   \label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash calculation for incoming packets / Supported/e=
nabled hash types}
> +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]},
> +\hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
>   Hash types applicable for IPv4 packets:
>   \begin{lstlisting}
>   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> @@ -3884,6 +3933,32 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>   \end{lstlisting}
>  =20
> +\subparagraph{Supported/enabled tunnel hash types}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled tunnel hash types}
> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated, the encapsulation
> +hash type indicates that the hash is calculated over the inner header of
> +the encapsulated packet:
> +Hash type applicable for inner payload of the gre-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE         (1 << 0)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the vxlan-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 1)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the geneve-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 2)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the ip-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 3)
> +\end{lstlisting}
> +Hash type applicable for inner payload of the nvgre-encapsulated packet
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 4)
> +\end{lstlisting}
> +
>   \subparagraph{IPv4 packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash calculation for incoming packets / IPv4 packet=
s}
>   The device calculates the hash on IPv4 packets according to 'Enabled ha=
sh types' bitmask as follows:
> @@ -3975,17 +4050,47 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>   (see \ref{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / IPv6 pac=
kets without extension header}).
>   \end{itemize}
>  =20
> +\subparagraph{Inner hash calculation of an encapsulated packet}
> +If the feature VIRTIO_NET_F_HASH_TUNNEL is negotiated and the correspond=
ing
> +encapsulation hash type is set in \field{hash_tunnel_types}, the device =
calculates the
> +hash on the inner header of an encapsulated packet (See \ref{sec:Device =
Types
> +/ Network Device / Device Operation / Processing of Incoming Packets /
> +Hash calculation for incoming packets / Tunnel/Encapsulated packet}).
> +
> +\subparagraph{Security risks between encapsulated packets and RSS}
> +There may be potential security risks when encapsulated packets using RS=
S to
> +select queues for placement. When a user inside a tunnel tries to contro=
l the
> +enqueuing of encapsulated packets, then the user can flood the device wi=
th invaild
> +packets, and the flooded packets may be hashed into the same queue as pa=
ckets in
> +other normal tunnels, which causing the queue to overflow.
> +
> +This can pose several security risks:
> +\begin{itemize}
> +\item  Encapsulated packets in the normal tunnels cannot be enqueued due=
 to queue
> +       overflow, resulting in a large amount of packet loss.
> +\item  The delay and retransmission of packets in the normal tunnels are=
 extremely increased.
> +\item  The user can observe the traffic information and enqueue informat=
ion of other normal
> +       tunnels, and conduct targeted DoS attacks.
> +\end{\itemize}
> +
>   \paragraph{Hash reporting for incoming packets}
>   \label{sec:Device Types / Network Device / Device Operation / Processin=
g of Incoming Packets / Hash reporting for incoming packets}
> -
> -If VIRTIO_NET_F_HASH_REPORT was negotiated and
> - the device has calculated the hash for the packet, the device fills \fi=
eld{hash_report} with the report type of calculated hash
> -and \field{hash_value} with the value of calculated hash.
> -
> -If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> -hash was not calculated, the device sets \field{hash_report} to VIRTIO_N=
ET_HASH_REPORT_NONE.
> -
> -Possible values that the device can report in \field{hash_report} are de=
fined below.
> +If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated=
 the
> +hash for the packet, the device fills the lower 8 bits of \field{hash_re=
port} with
> +the report type of calculated hash, and \field{hash_value} with the valu=
e of calculated
> +hash. Also, if VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the devic=
e needs to fill
> +the upper 8 bits of \field{hash_report} with the encapsulation type.
> +
> +If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the has=
h was not
> +calculated, the device sets the lower 8 bits of \field{hash_report} to
> +VIRTIO_NET_HASH_REPORT_NONE.
> +
> +If VIRTIO_NET_F_HASH_REPORT_TUNNEL was negotiated, the device fills the =
upper
> +8 bits of \field{hash_report} with the encapsulation type for an encapsu=
lated
> +packet. Note that the upper 8 bits are all set to 0 for an unencapsulate=
d
> +packet, regardless of whether VIRTIO_NET_F_HASH_REPORT_TUNNEL is negotia=
ted or not.
> +
> +Possible hash types that the device can report in \field{hash_report} ar=
e defined below.
>   They correspond to supported hash types defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}
>   as follows:
> @@ -4005,6 +4110,26 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>   \end{lstlisting}
>  =20
> +The upper 8 bits of \field{hash_report} can report the encapsulation typ=
e to
> +the driver if VIRTIO_NET_F_HASH_REPORT_TUNNEL is negotiated.
> +Possible encapsulation types that the device can report in \field{hash_r=
eport} are defined below.
> +They correspond to supported hash tunnel types defined in
> +\ref{sec:Device Types / Network Device / Device Operation / Processing o=
f Incoming Packets / Hash calculation for incoming packets / Supported/enab=
led hash tunnel types}
> +as follows:
> +
> +VIRTIO_NET_HASH_TUNNEL_TYPE_XXX =3D 1 << (VIRTIO_NET_HASH_TUNNEL_REPORT_=
XXX - 256)
> +
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GRE      256
> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_VXLAN    257
> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_GENEVE   258
> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_IPIP     259
> +#define VIRTIO_NET_HASH_TUNNEL_REPORT_NVGRE    260
> +\end{lstlisting}
> +
> +They correspond to supported hash types defined in
> +\ref{sec:Device Types / Network Device / Device Operation / Processing o=
f Incoming Packets / Hash calculation for incoming packets / Supported/enab=
led hash types}.
> +
>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue}
>  =20
>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> @@ -4364,6 +4489,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>   \begin{lstlisting}
>   struct virtio_net_hash_config {
>       le32 hash_types;
> +    le32 hash_tunnel_types;
>       le16 reserved[4];
>       u8 hash_key_length;
>       u8 hash_key_data[hash_key_length];
> @@ -4372,7 +4498,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>   Field \field{hash_types} contains a bitmask of allowed hash types as
>   defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
> -Initially the device has all hash types disabled and reports only VIRTIO=
_NET_HASH_REPORT_NONE.
> +
> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunne=
l types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / P=
rocessing of Incoming Packets / Hash calculation for incoming packets / Sup=
ported/enabled hash tunnel types}.
> +
> +Initially the device has all hash types and hash tunnel types disabled a=
nd reports only VIRTIO_NET_HASH_REPORT_NONE.
>  =20
>   Field \field{reserved} MUST contain zeroes. It is defined to make the s=
tructure to match the layout of virtio_net_rss_config structure,
>   defined in \ref{sec:Device Types / Network Device / Device Operation / =
Control Virtqueue / Receive-side scaling (RSS)}.
> @@ -4390,6 +4520,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>   \begin{lstlisting}
>   struct virtio_net_rss_config {
>       le32 hash_types;
> +    le32 hash_tunnel_types;
>       le16 indirection_table_mask;
>       le16 unclassified_queue;
>       le16 indirection_table[indirection_table_length];
> @@ -4402,6 +4533,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>   defined in
>   \ref{sec:Device Types / Network Device / Device Operation / Processing =
of Incoming Packets / Hash calculation for incoming packets / Supported/ena=
bled hash types}.
>  =20
> +Field \field{hash_tunnel_types} contains a bitmask of allowed hash tunne=
l types as
> +defined in \ref{sec:Device Types / Network Device / Device Operation / P=
rocessing of Incoming Packets / Hash calculation for incoming packets / Sup=
ported/enabled hash tunnel types}.
> +
>   Field \field{indirection_table_mask} is a mask to be applied to
>   the calculated hash to produce an index in the
>   \field{indirection_table} array.
> diff --git a/introduction.tex b/introduction.tex
> index 287c5fc..69b95ae 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -98,6 +98,31 @@ \section{Normative References}\label{sec:Normative Ref=
erences}
>   =09\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic =
Cureve Cryptography'', Version 1.0, September 2000.
>   =09\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> +=09\phantomsection\label{intro:GRE}\textbf{[GRE]} &
> +=09Generic Routing Encapsulation
> +=09\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> +=09\phantomsection\label{intro:VXLAN}\textbf{[VXLAN]} &
> +=09Virtual eXtensible Local Area Network
> +=09\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> +=09\phantomsection\label{intro:GENEVE}\textbf{[GENEVE]} &
> +=09Generic Network Virtualization Encapsulation
> +=09\phantomsection\label{intro:IPIP}\textbf{[IPIP]} &
> +=09IP Encapsulation within IP
> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> +=09\phantomsection\label{intro:IPIP}\textbf{[NVGRE]} &
> +=09NVGRE: Network Virtualization Using Generic Routing Encapsulation
> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> +=09\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> +=09\phantomsection\label{intro:IP}\textbf{[IP]} &
> +=09INTERNET PROTOCOL
> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> +=09\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> +=09User Datagram Protocol
> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> +=09\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> +=09TRANSMISSION CONTROL PROTOCOL
> +=09\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
> +
>  =20
>   \end{longtable}
>  =20

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

