Return-Path: <mst@redhat.com>
Date: Fri, 25 Nov 2022 06:49:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_net: support inner header hash for
 GRE-encapsulated packets
Message-ID: <20221125064742-mutt-send-email-mst@kernel.org>
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
> On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> > When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> > encapsulate the packets, the hash calculated using the outer header
> > of the receive packets is always fixed for the same flow packets,
> > i.e. they will be steered to the same receive queue.
> >
> > We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
> > which instructs the device to calculate the hash using the inner
> > headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
> > value in \field{hash_tunnel} to report packet type when calculating
> > hash over the inner header.
>=20
> So I think we need a new feature bit for this to keep migration compatibi=
lity.

I am not sure I agree.  hash types need to be specified or migrated.
Also having feature bits is a lot of work and duplication,
and inconsistency - we do not have bits for existing hash types.



> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> > v1:
> >         1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> >         2. Clarify some paragraphs. @Jason Wang
> >         3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yur=
i Benditovich
> >
> >  content.tex | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 135 insertions(+), 5 deletions(-)
> >
> > diff --git a/content.tex b/content.tex
> > index e863709..fba0c7d 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
> >   to several segments when each of these smaller packets has UDP header.
> >
> >  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
> > -    value and a type of calculated hash.
> > +    value, a type of calculated hash and a tunnel packet type.
> >
> >  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \fie=
ld{hdr_len}
> >      value. Device benefits from knowing the exact header length.
> > @@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Network Device / Device O
> >          le16 num_buffers;
> >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
> >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
> > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
> > +        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
>=20
> It's better not limit this to be tunnel only unless we limit the same
> for hash_config.
>=20
> Btw, this needs an independent fix. I wonder if we need a dedicated
> feature bit VIRTIO_NET_F_HASH_REPORT_EX and documenting that device
> SHOULD offer HASH_REPORT_EX along with HASH_REPORT. Then we can do GRE
> tunnel hash report on top? (Or doing GRE first and fix the mismatch on
> top)
>=20

hashing already supports a ton of types all of them optional.
this is no different.



> > +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT nego=
tiated)
> >  };
> >  \end{lstlisting}
> >
> > @@ -3837,7 +3838,7 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
> >  A device attempts to calculate a per-packet hash in the following case=
s:
> >  \begin{itemize}
> >  \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the=
 hash to determine the receive virtqueue to place incoming packets.
> > -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device =
reports the hash value and the hash type with the packet.
> > +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device =
reports the hash value, the hash type and the tunnel packet type.
> >  \end{itemize}
> >
> >  If the feature VIRTIO_NET_F_RSS was negotiated:
> > @@ -3883,6 +3884,10 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
> >  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> >  \end{lstlisting}
> > +Hash types applicable to inner payloads of GRE-encapsulated packets
>=20
> Unless there are other GRE related hash types, would it be better to
> say "inner payloads of tunnel packets"?
>=20
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> > +\end{lstlisting}
> >
> >  \subparagraph{IPv4 packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / IPv4 packe=
ts}
> > @@ -3975,12 +3980,123 @@ \subsubsection{Processing of Incoming Packets}=
\label{sec:Device Types / Network
> >  (see \ref{sec:Device Types / Network Device / Device Operation / Proce=
ssing of Incoming Packets / Hash calculation for incoming packets / IPv6 pa=
ckets without extension header}).
> >  \end{itemize}
> >
> > +\subparagraph{Inner payloads of GRE-encapsulated packets}
> > +\label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Inner payl=
oads of GRE-encapsulated packets}}
> > +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is set at the same time as one of
> > +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_UD=
P_EX.
> > +
> > +The device calculates the hash on GRE-encapsulated packets whose inner=
 payloads
> > +are IPv4 packets according to 'Enabled hash types' bitmasks as follows:
> > +\begin{itemize}
> > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYP=
E_TCPv4 bits
> > +      are set, and the GRE-encapsulated packet has an inner TCPv4 head=
er in its
> > +      payload, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IP address
> > +      \item inner Destination IP address
> > +      \item inner Source TCP port
> > +      \item inner Destination TCP port
> > +    \end{itemsize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_UDPv4
> > +      bits are set, and the GRE-encapsulated packet has an inner UDPv4=
 header in
> > +      its payload, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IP address
> > +      \item inner Destination IP address
> > +      \item inner Source UDP port
> > +      \item inner Destination UDP port
> > +    \end{itemize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_IPv4
> > +      bits are set, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IP address
> > +      \item inner Destination IP address
> > +    \end{itemsize}
> > +  \item Else the device does not calculate the hash
> > +\end{itemize}
> > +
> > +The device calculates the hash on GRE-encapsulated packets whose inner=
 payloads
> > +are IPv6 packets without extension headers according to 'Enabled hash =
types'
> > +bitmasks as follows:
> > +\begin{itemsize}
> > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYP=
E_TCPv6
> > +      bits are set, and the GRE-encapsulated packet has an inner TCPv6=
 header in
> > +      its payload, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IPv6 address
> > +      \item inner Destination IPv6 address
> > +      \item inner Source TCP port
> > +      \item inner Destination TCP port
> > +    \end{itemsize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_UDPv6
> > +      bits are set, and the GRE-encapsulated packet has an inner UDPv6=
 header in
> > +      its payload, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IPv6 address
> > +      \item inner Destination IPv6 address
> > +      \item inner Source UDP port
> > +      \item inner Destination UDP port
> > +    \end{itemize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_IPv6
> > +      bits are set, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item inner Source IPv6 address
> > +      \item inner Destination IPv6 address
> > +    \end{itemsize}
> > +  \item Else the device does not calculate the hash
> > +\end{itemize}
> > +
> > +The device calculates the hash on GRE-encapsulated packets whose inner=
 payloads
> > +are IPv6 packets with extension headers according to 'Enabled hash typ=
es'
> > +bitmasks as follows:
> > +\begin{itemsize}
> > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TYP=
E_TCP_EX
> > +      bits are set, and the GRE-encapsulated packet has an inner TCPv6=
 header in
> > +      its payload, the hash is calculated over the following fields:
> > +    \begin{itemize}
> > +      \item Home address from the home address option in the inner IPv=
6 destination
> > +          options header. If the inner extension header is not present=
, use the
> > +          inner Source IPv6 address.
> > +      \item IPv6 address that is contained in the Routing-Header-Type-=
2 from the
> > +          associated inner extension header. If the inner extension he=
ader is not
> > +          present, use the inner Destination IPv6 address.
> > +      \item inner Source TCP port
> > +      \item inner Destination TCP port
> > +    \end{itemize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_UDP_EX
> > +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 hea=
der in its
> > +  payload, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item Home address from the home address option in the inner IPv=
6 destination
> > +          options header. If the inner extension header is not present=
, use the
> > +          inner Source IPv6 address.
> > +      \item IPv6 address that is contained in the Routing-Header-Type-=
2 from the
> > +          associated inner extension header. If the inner extension he=
ader is not
> > +          present, use the inner Destination IPv6 address.
> > +      \item inner Source UDP port
> > +      \item inner Destination UDP port
> > +    \end{itemize}
> > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HAS=
H_TYPE_IP_EX
> > +      bits are set, the hash is calculated over the following fields:
> > +    \begin{itemsize}
> > +      \item Home address from the home address option in the inner IPv=
6 destination
> > +          options header. If the inner extension header is not present=
, use the
> > +          inner Source IPv6 address.
> > +      \item IPv6 address that is contained in the Routing-Header-Type-=
2 from the
> > +          associated inner extension header. If the inner extension he=
ader is not
> > +          present, use the inner Destination IPv6 address.
> > +    \end{itemize}
> > +  \item Else skip inner IPv6 extension headers and calculate the hash =
as defined
> > +      for a GRE-encapsulated packet whose inner payload is an IPv6 pac=
ket without
> > +      extension headers
> > +\end{itemsize}
> > +
> >  \paragraph{Hash reporting for incoming packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash reporting for incoming packets}
> >
> >  If VIRTIO_NET_F_HASH_REPORT was negotiated and
> > - the device has calculated the hash for the packet, the device fills \=
field{hash_report} with the report type of calculated hash
> > -and \field{hash_value} with the value of calculated hash.
> > + the device has calculated the hash for the packet, the device fills \=
field{hash_report} with the report type of calculated hash,
> > +\field{hash_tunnel} with the type of the tunnel packet, and \field{has=
h_value} with the value of calculated hash.
> >
> >  If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> >  hash was not calculated, the device sets \field{hash_report} to VIRTIO=
_NET_HASH_REPORT_NONE.
> > @@ -4005,6 +4121,20 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >  \end{lstlisting}
> >
> > +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
> > +\field{hash_tunnel} can report the type of the tunnel-encapsulated
> > +packet to the driver over the inner header hash calculation.
> > +Possible values that the device can report in field{hash_tunnel}
> > +are defined below:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_NET_HASH_REPORT_GRE             1
> > +\end{lstlisting}
>=20
> What's the advantage of not simply doing the matching via the existing ma=
th:
>=20
> VIRTIO_NET_HASH_TYPE_XXX =3D 1 =AB (VIRTIO_NET_HASH_REPORT_XXX - 1)
> ?
>=20
> Thanks
>=20
>=20
> > +
> > +The value VIRTIO_NET_HASH_REPORT_GRE corresponds to
> > +VIRTIO_NET_HASH_TYPE_GRE_INNER bit of supported hash types defined in
> > +\ref{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled hash types}.
> > +
> >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Dev=
ice / Device Operation / Control Virtqueue}
> >
> >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> > --
> > 2.19.1.6.gb485710b
> >

