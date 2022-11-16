Return-Path: <virtio-dev-return-10167-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFE8B98664E
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Nov 2022 23:33:10 +0000 (UTC)
MIME-Version: 1.0
References: <20221109113336.121773-1-hengqi@linux.alibaba.com>
 <20221109113336.121773-3-hengqi@linux.alibaba.com> <CACGkMEtVMLKDGfXzhbVshO2DkHmU6ayNH=-EJg2ins9jJYjGNg@mail.gmail.com>
 <77551372-bab9-5e55-d290-f50ebc6cad14@linux.alibaba.com>
In-Reply-To: <77551372-bab9-5e55-d290-f50ebc6cad14@linux.alibaba.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 17 Nov 2022 01:32:57 +0200
Message-ID: <CAOEp5OcgAVTO+ds6RGw1e-Wk_vtmsH8bX0YSHDfVrz+1JDvWkw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH 2/2] virtio_net: support inner header
 hash for GRE-encapsulated packets
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Heng Qi <henqqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

I would suggest to specify also the hash type the device should report
in case the hash reporting feature is enabled. For example, should the
device specify somehow in the report that the hash was calculated on
the inner header or on the regular header?

On Thu, Nov 10, 2022 at 5:41 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2022/11/10 =E4=B8=8A=E5=8D=8811:35, Jason Wang =E5=86=99=E9=81=
=93:
> > On Wed, Nov 9, 2022 at 7:33 PM Heng Qi <hengqi@linux.alibaba.com> wrote=
:
> >> From: Heng Qi <henqqi@linux.alibaba.com>
> >>
> >> When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> >> encapsulate the packets, the hash calculated using the outer header
> >> of the receive packets is always fixed for the same flow packets,
> >> i.e. they will be steered to the same receive queue.
> >>
> >> We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
> >> which instructs the device to calculate the hash using the inner heade=
rs
> >> of GRE-encapsulated packets.
> >>
> >> Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
> >> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> ---
> >>   content.tex | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 116 insertions(+)
> >>
> >> diff --git a/content.tex b/content.tex
> >> index 6fabf1d..319d401 100644
> >> --- a/content.tex
> >> +++ b/content.tex
> >> @@ -3883,6 +3883,10 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
> >>   #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
> >>   #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> >>   \end{lstlisting}
> >> +Hash types applicable to inner payloads of GRE-encapsulated packets
> >> +\begin{lstlisting}
> >> +#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> >> +\end{lstlisting}
> >>
> >>   \subparagraph{IPv4 packets}
> >>   \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash calculation for incoming packets / IPv4 pac=
kets}
> >> @@ -3975,6 +3979,114 @@ \subsubsection{Processing of Incoming Packets}=
\label{sec:Device Types / Network
> >>   (see \ref{sec:Device Types / Network Device / Device Operation / Pro=
cessing of Incoming Packets / Hash calculation for incoming packets / IPv6 =
packets without extension header}).
> >>   \end{itemize}
> >>
> >> +\subparagraph{Inner payloads of GRE-encapsulated packets}
> >> +\label{sec:Device Types / Network Device / Device Operation / Process=
ing of Incoming Packets / Hash calculation for incoming packets / Inner pay=
loads of GRE-encapsulated packets}}
> >> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit MUST be set at the same time as on=
e of
> >> +the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_U=
DP_EX.
> > "MUST" keyword must belong to the normative section.
>
> Okay. Thanks for pointing out.
>
> >
> >> +
> >> +The device calculates the hash on GRE-encapsulated packets whose inne=
r payloads
> >> +are IPv4 packets according to 'Enabled hash types' bitmasks as follow=
s:
> >> +\begin{itemize}
> >> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TY=
PE_TCPv4 bits
> >> +      are set, and the GRE-encapsulated packet has an inner TCPv4 hea=
der in its
> >> +      payload, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IP address
> >> +      \item Inner destination IP address
> >> +      \item Inner source TCP port
> >> +      \item Inner destination TCP port
> >> +    \end{itemsize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_UDPv4
> >> +      bits are set, and the GRE-encapsulated packet has an inner UDPv=
4 header in
> >> +      its payload, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IP address
> >> +      \item Inner destination IP address
> >> +      \item Inner source UDP port
> >> +      \item Inner destination UDP port
> >> +    \end{itemize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_IPv4
> >> +      bits are set, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IP address
> >> +      \item Inner destination IP address
> >> +    \end{itemsize}
> >> +  \item Else the device does not calculate the hash
> >> +\end{itemize}
> >> +
> >> +The device calculates the hash on GRE-encapsulated packets whose inne=
r payloads
> >> +are IPv6 packets without extension headers according to 'Enabled hash=
 types'
> >> +bitmasks as follows:
> >> +\begin{itemsize}
> >> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TY=
PE_TCPv6
> >> +      bits are set, and the GRE-encapsulated packet has an inner TCPv=
6 header in
> >> +      its payload, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IPv6 address
> >> +      \item Inner destination IPv6 address
> >> +      \item Inner source TCP port
> >> +      \item Inner destination TCP port
> >> +    \end{itemsize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_UDPv6
> >> +      bits are set, and the GRE-encapsulated packet has an inner UDPv=
6 header in
> >> +      its payload, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IPv6 address
> >> +      \item Inner destination IPv6 address
> >> +      \item Inner source UDP port
> >> +      \item Inner destination UDP port
> >> +    \end{itemize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_IPv6
> >> +      bits are set, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Inner source IPv6 address
> >> +      \item Inner destination IPv6 address
> >> +    \end{itemsize}
> >> +  \item Else the device does not calculate the hash
> >> +\end{itemize}
> >> +
> >> +The device calculates the hash on GRE-encapsulated packets whose inne=
r payloads
> >> +are IPv6 packets with extension headers according to 'Enabled hash ty=
pes'
> >> +bitmasks as follows:
> >> +\begin{itemsize}
> >> +  \item If both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HASH_TY=
PE_TCP_EX
> >> +      bits are set, and the GRE-encapsulated packet has an inner TCPv=
6 header in
> >> +      its payload, the hash is calculated over the following fields:
> >> +    \begin{itemize}
> >> +      \item Home address from the home address option in the IPv6 des=
tination options
> > Is this inner or outer?
> >
> > Thanks
> >
> >> +          header. If the extension header is not present, use the Sou=
rce IPv6 address.
> >> +      \item IPv6 address that is contained in the Routing-Header-Type=
-2 from the
> >> +          associated extension header. If the extension header is not=
 present, use
> >> +          the Destination IPv6 address.
> >> +      \item Source TCP port
> >> +      \item Destination TCP port
> >> +    \end{itemize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_UDP_EX
> >> +  bits are set, and the GRE-encapsulated packet has an inner UDPv6 he=
ader in its
> >> +  payload, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Home address from the home address option in the IPv6 des=
tination options
> >> +          header. If the extension header is not present, use the Sou=
rce IPv6 address.
> >> +      \item IPv6 address that is contained in the Routing-Header-Type=
-2 from the
> >> +          associated extension header. If the extension header is not=
 present, use the
> >> +          Destination IPv6 address.
> >> +      \item Source UDP port
> >> +      \item Destination UDP port
> >> +    \end{itemize}
> >> +  \item Else if both VIRTIO_NET_HASH_TYPE_GRE_INNER and VIRTIO_NET_HA=
SH_TYPE_IP_EX
> >> +      bits are set, the hash is calculated over the following fields:
> >> +    \begin{itemsize}
> >> +      \item Home address from the home address option in the IPv6 des=
tination options
> >> +          header. If the extension header is not present, use the Sou=
rce IPv6 address.
> >> +      \item IPv6 address that is contained in the Routing-Header-Type=
-2 from the
> >> +          associated extension header. If the extension header is not=
 present, use the
> >> +          Destination IPv6 address.
> >> +    \end{itemize}
> >> +  \item Else skip IPv6 extension headers and calculate the hash as de=
fined for
> >> +      a GRE-encapsulated packet whose inner payload is an IPv6 packet=
 without
> >> +      extension headers
> >> +\end{itemsize}
> >> +
> >>   \paragraph{Hash reporting for incoming packets}
> >>   \label{sec:Device Types / Network Device / Device Operation / Proces=
sing of Incoming Packets / Hash reporting for incoming packets}
> >>
> >> @@ -4005,6 +4117,10 @@ \subsubsection{Processing of Incoming Packets}\=
label{sec:Device Types / Network
> >>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >>   \end{lstlisting}
> >>
> >> +VIRTIO_NET_HASH_TYPE_GRE_INNER bit is not included in \field{hash_rep=
ort},
> >> +it just indicates that the hash is calculated using the inner header =
inside
> >> +the GRE-encapsulated packet.
> >> +
> >>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue}
> >>
> >>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> >> --
> >> 2.19.1.6.gb485710b
> >>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

