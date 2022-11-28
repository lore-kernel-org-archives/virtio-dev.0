Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1669602685.636302-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_net: support inner header hash for GRE-encapsulated packets
Date: Mon, 28 Nov 2022 10:31:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
 <20221125064742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221125064742-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 25 Nov 2022 06:49:42 -0500, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
> > On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com> wrot=
e:
> > >
> > > When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> > > encapsulate the packets, the hash calculated using the outer header
> > > of the receive packets is always fixed for the same flow packets,
> > > i.e. they will be steered to the same receive queue.
> > >
> > > We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types}=
,
> > > which instructs the device to calculate the hash using the inner
> > > headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
> > > value in \field{hash_tunnel} to report packet type when calculating
> > > hash over the inner header.
> >
> > So I think we need a new feature bit for this to keep migration compati=
bility.
>
> I am not sure I agree.  hash types need to be specified or migrated.

I think migration is necessary to consider. If VM migrates, it may cause VM=
's
behavior to be inconsistent.

> Also having feature bits is a lot of work and duplication,
> and inconsistency - we do not have bits for existing hash types.

The existing Hash Types are brought by default when negotiating RSS. I don'=
t
think it is necessary to negotiate for them separately.

As far as Virtio-Net's Feature Bits are concerned, I am indeed worried, bec=
ause
we think Virtio-Net can also add a lot of new features. In the end, there w=
ill
be no feature bit available.

>
>
>
> > >
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > > v1:
> > >         1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> > >         2. Clarify some paragraphs. @Jason Wang
> > >         3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Y=
uri Benditovich
> > >
> > >  content.tex | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 135 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index e863709..fba0c7d 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device Type=
s / Network Device / Feature bits
> > >   to several segments when each of these smaller packets has UDP head=
er.
> > >
> > >  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet has=
h
> > > -    value and a type of calculated hash.
> > > +    value, a type of calculated hash and a tunnel packet type.
> > >
> > >  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \f=
ield{hdr_len}
> > >      value. Device benefits from knowing the exact header length.
> > > @@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:Device =
Types / Network Device / Device O
> > >          le16 num_buffers;
> > >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT ne=
gotiated)
> > >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT ne=
gotiated)
> > > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT ne=
gotiated)
> > > +        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPORT ne=
gotiated)
> >
> > It's better not limit this to be tunnel only unless we limit the same
> > for hash_config.
> >
> > Btw, this needs an independent fix. I wonder if we need a dedicated
> > feature bit VIRTIO_NET_F_HASH_REPORT_EX and documenting that device
> > SHOULD offer HASH_REPORT_EX along with HASH_REPORT. Then we can do GRE
> > tunnel hash report on top? (Or doing GRE first and fix the mismatch on
> > top)
> >
>
> hashing already supports a ton of types all of them optional.
> this is no different.

I don't think that HASH REPORT has to add the feature consultation
separately. If we introduce a feature for a certain Hash Type, I think it c=
an be
used here.

Thanks.


>
>
>
> > > +        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT ne=
gotiated)
> > >  };
> > >  \end{lstlisting}
> > >
> > > @@ -3837,7 +3838,7 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
> > >  A device attempts to calculate a per-packet hash in the following ca=
ses:
> > >  \begin{itemize}
> > >  \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses t=
he hash to determine the receive virtqueue to place incoming packets.
> > > -\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The devic=
e reports the hash value and the hash type with the packet.
> > > +\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The devic=
e reports the hash value, the hash type and the tunnel packet type.
> > >  \end{itemize}
> > >
> > >  If the feature VIRTIO_NET_F_RSS was negotiated:
> > > @@ -3883,6 +3884,10 @@ \subsubsection{Processing of Incoming Packets}=
\label{sec:Device Types / Network
> > >  #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
> > >  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> > >  \end{lstlisting}
> > > +Hash types applicable to inner payloads of GRE-encapsulated packets
> >
> > Unless there are other GRE related hash types, would it be better to
> > say "inner payloads of tunnel packets"?
> >
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> > > +\end{lstlisting}
> > >
> > >  \subparagraph{IPv4 packets}
> > >  \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / IPv4 pac=
kets}
> > > @@ -3975,12 +3980,123 @@ \subsubsection{Processing of Incoming Packet=
s}\label{sec:Device Types / Network
> > >  (see \ref{sec:Device Types / Network Device / Device Operation / Pro=
cessing of Incoming Packets / Hash calculation for incoming packets / IPv6 =
packets without extension header}).
> > >  \end{itemize}
> > >
> > > +\subparagraph{Inner payloads of GRE-encapsulated packets}
> > > +\label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / Inner pa=
yloads of GRE-encapsulated packets}}
> > > +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is set at the same time as one of
> > > +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_=
UDP_EX.
> > > +
> > > +The device calculates the hash on GRE-encapsulated packets whose inn=
er payloads
> > > +are IPv4 packets according to 'Enabled hash types' bitmasks as follo=
ws:
> > > +\begin{itemize}
> > > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_T=
YPE_TCPv4 bits
> > > +      are set, and the GRE-encapsulated packet has an inner TCPv4 he=
ader in its
> > > +      payload, the hash is calculated over the following fields:
> > > +    \begin{itemsize}
> > > +      \item inner Source IP address
> > > +      \item inner Destination IP address
> > > +      \item inner Source TCP port
> > > +      \item inner Destination TCP port
> > > +    \end{itemsize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_UDPv4
> > > +      bits are set, and the GRE-encapsulated packet has an inner UDP=
v4 header in
> > > +      its payload, the hash is calculated over the following fields:
> > > +    \begin{itemsize}
> > > +      \item inner Source IP address
> > > +      \item inner Destination IP address
> > > +      \item inner Source UDP port
> > > +      \item inner Destination UDP port
> > > +    \end{itemize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_IPv4
> > > +      bits are set, the hash is calculated over the following fields=
:
> > > +    \begin{itemsize}
> > > +      \item inner Source IP address
> > > +      \item inner Destination IP address
> > > +    \end{itemsize}
> > > +  \item Else the device does not calculate the hash
> > > +\end{itemize}
> > > +
> > > +The device calculates the hash on GRE-encapsulated packets whose inn=
er payloads
> > > +are IPv6 packets without extension headers according to 'Enabled has=
h types'
> > > +bitmasks as follows:
> > > +\begin{itemsize}
> > > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_T=
YPE_TCPv6
> > > +      bits are set, and the GRE-encapsulated packet has an inner TCP=
v6 header in
> > > +      its payload, the hash is calculated over the following fields:
> > > +    \begin{itemsize}
> > > +      \item inner Source IPv6 address
> > > +      \item inner Destination IPv6 address
> > > +      \item inner Source TCP port
> > > +      \item inner Destination TCP port
> > > +    \end{itemsize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_UDPv6
> > > +      bits are set, and the GRE-encapsulated packet has an inner UDP=
v6 header in
> > > +      its payload, the hash is calculated over the following fields:
> > > +    \begin{itemsize}
> > > +      \item inner Source IPv6 address
> > > +      \item inner Destination IPv6 address
> > > +      \item inner Source UDP port
> > > +      \item inner Destination UDP port
> > > +    \end{itemize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_IPv6
> > > +      bits are set, the hash is calculated over the following fields=
:
> > > +    \begin{itemsize}
> > > +      \item inner Source IPv6 address
> > > +      \item inner Destination IPv6 address
> > > +    \end{itemsize}
> > > +  \item Else the device does not calculate the hash
> > > +\end{itemize}
> > > +
> > > +The device calculates the hash on GRE-encapsulated packets whose inn=
er payloads
> > > +are IPv6 packets with extension headers according to 'Enabled hash t=
ypes'
> > > +bitmasks as follows:
> > > +\begin{itemsize}
> > > +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_T=
YPE_TCP_EX
> > > +      bits are set, and the GRE-encapsulated packet has an inner TCP=
v6 header in
> > > +      its payload, the hash is calculated over the following fields:
> > > +    \begin{itemize}
> > > +      \item Home address from the home address option in the inner I=
Pv6 destination
> > > +          options header. If the inner extension header is not prese=
nt, use the
> > > +          inner Source IPv6 address.
> > > +      \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from the
> > > +          associated inner extension header. If the inner extension =
header is not
> > > +          present, use the inner Destination IPv6 address.
> > > +      \item inner Source TCP port
> > > +      \item inner Destination TCP port
> > > +    \end{itemize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_UDP_EX
> > > +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 h=
eader in its
> > > +  payload, the hash is calculated over the following fields:
> > > +    \begin{itemsize}
> > > +      \item Home address from the home address option in the inner I=
Pv6 destination
> > > +          options header. If the inner extension header is not prese=
nt, use the
> > > +          inner Source IPv6 address.
> > > +      \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from the
> > > +          associated inner extension header. If the inner extension =
header is not
> > > +          present, use the inner Destination IPv6 address.
> > > +      \item inner Source UDP port
> > > +      \item inner Destination UDP port
> > > +    \end{itemize}
> > > +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_H=
ASH_TYPE_IP_EX
> > > +      bits are set, the hash is calculated over the following fields=
:
> > > +    \begin{itemsize}
> > > +      \item Home address from the home address option in the inner I=
Pv6 destination
> > > +          options header. If the inner extension header is not prese=
nt, use the
> > > +          inner Source IPv6 address.
> > > +      \item IPv6 address that is contained in the Routing-Header-Typ=
e-2 from the
> > > +          associated inner extension header. If the inner extension =
header is not
> > > +          present, use the inner Destination IPv6 address.
> > > +    \end{itemize}
> > > +  \item Else skip inner IPv6 extension headers and calculate the has=
h as defined
> > > +      for a GRE-encapsulated packet whose inner payload is an IPv6 p=
acket without
> > > +      extension headers
> > > +\end{itemsize}
> > > +
> > >  \paragraph{Hash reporting for incoming packets}
> > >  \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash reporting for incoming packets}
> > >
> > >  If VIRTIO_NET_F_HASH_REPORT was negotiated and
> > > - the device has calculated the hash for the packet, the device fills=
 \field{hash_report} with the report type of calculated hash
> > > -and \field{hash_value} with the value of calculated hash.
> > > + the device has calculated the hash for the packet, the device fills=
 \field{hash_report} with the report type of calculated hash,
> > > +\field{hash_tunnel} with the type of the tunnel packet, and \field{h=
ash_value} with the value of calculated hash.
> > >
> > >  If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> > >  hash was not calculated, the device sets \field{hash_report} to VIRT=
IO_NET_HASH_REPORT_NONE.
> > > @@ -4005,6 +4121,20 @@ \subsubsection{Processing of Incoming Packets}=
\label{sec:Device Types / Network
> > >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > >  \end{lstlisting}
> > >
> > > +If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
> > > +\field{hash_tunnel} can report the type of the tunnel-encapsulated
> > > +packet to the driver over the inner header hash calculation.
> > > +Possible values that the device can report in field{hash_tunnel}
> > > +are defined below:
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_NET_HASH_REPORT_GRE             1
> > > +\end{lstlisting}
> >
> > What's the advantage of not simply doing the matching via the existing =
math:
> >
> > VIRTIO_NET_HASH_TYPE_XXX =3D 1 =C2=AB (VIRTIO_NET_HASH_REPORT_XXX - 1)
> > ?
> >
> > Thanks
> >
> >
> > > +
> > > +The value VIRTIO_NET_HASH_REPORT_GRE corresponds to
> > > +VIRTIO_NET_HASH_TYPE_GRE_INNER bit of supported hash types defined i=
n
> > > +\ref{sec:Device Types / Network Device / Device Operation / Processi=
ng of Incoming Packets / Hash calculation for incoming packets / Supported/=
enabled hash types}.
> > > +
> > >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue}
> > >
> > >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> > > --
> > > 2.19.1.6.gb485710b
> > >
>

