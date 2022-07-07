Return-Path: <virtio-dev-return-9649-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB03C9867DD
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Jul 2022 14:57:26 +0000 (UTC)
Message-ID: <bd53926c71cc67894d16ae3a318cb8a520883bc0.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 07 Jul 2022 16:57:18 +0200
In-Reply-To: <CACGkMEvbNOEAs8V_JwkG=cxosjRE-abPWDnoOhT26dkg7cAXjw@mail.gmail.com>
References: <cb8140a142a4884b2c2a237bf8e5c4b9dbbd1616.1655477504.git.pabeni@redhat.com>
	 <CACGkMEvbNOEAs8V_JwkG=cxosjRE-abPWDnoOhT26dkg7cAXjw@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: define UDP tunnel offload feature
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2022-07-06 at 14:05 +0800, Jason Wang wrote:
> On Fri, Jun 17, 2022 at 10:55 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >=20
> > The VIRTIO_NET_HDR_GSO_UDP_TUNNEL is a gso_type flags allowing
> > GSO over UDP tunnel. It can be negotiated on both the host and
> > guest side.
> >=20
> > UDP tunnel usage is ubiquitous in container deployment, and the
> > ability to offload UDP encapsulated GSO traffic impacts greatly
> > the performances and the CPU utilization of such use-case
> >=20
> > To keep the design relatively simple, this copes only with tunneling
> > scenarios including an inner ethernet MAC header - e.g. inner network
> > on top of the UDP encapsulation is not allowed.
> >=20
> > Other than that the new flag is designed to be independent from the
> > specific UDP tunnel encapsulation - geneve, vxlan, etc.
>=20
> Do we need to whitelist the protocol we support here? Otherwise it
> might be risky.

Why should be risky?=C2=A0

Perhaps stating explicitly/more clearly the assumption is that the
tunnel protocol is immutable at segmentation time would be enough?

> > One constraint addressed here is that the virtio side (either device or
> > driver) receiving an UDP tunneled GSO packet must be able to reconstruc=
t
> > completely the inner and outer headers offset - to allow for later GSO.
> >=20
> > To accommodate such need the hdr_len field is [re-]used: when
> > the UDP tunnel feature is negotiated and the VIRTIO_NET_HDR_GSO_UDP_TUN=
NEL
> > is set, such field is used to identify the inner network header.
> >=20
> > All the other inner/outer headers location can be computed from the
> > above info and the host and the guest must explicitly probe the locatio=
n
> > of the outer headers.
> >=20
> > The outer UDP header may carry a second checksum, which can be
> > offloaded independently from the inner one. After outer header probing
> > such checksum is handle alike the inner header one.
> >=20
> > Note that when the VIRTIO_NET_HDR_GSO_UDP_TUNNEL flag is not set,
> > the current semantic for the hdr_hen field does not change.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - explicitly state that the outer header probing is mandatory
> >  - explicitly state that GSO_UDP is not allowed with GSO_UDP_TUNNEL
> >  - clarify hdr_len usage
> >  - clarify UDP_TUNNEL_CSUM bit usage
> >  - fix a few typos
> > ---
> >  content.tex | 131 ++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 116 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/content.tex b/content.tex
> > index c6f116c..e3577f0 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3092,6 +3092,16 @@ \subsection{Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >=20
> > +\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL (54)] Driver can receive GSO packe=
ts
>=20
> To be more clear, I wonder if we need to have "GSO" in the name of this f=
eature.

Ok, will add in the next iteration.

> > +  carried by an UDP tunnel and can handle the outer checksum. The tunn=
el
> > +  encapsulation is constrained to have constant size and carrying an i=
nner
> > +  ethernet header. e.g. alike vxlan and geneve defaults.
> > +
> > +\item[VIRTIO_NET_F_HOST_UDP_TUNNEL (55)] Device can receive GSO packet=
s
> > +  carried by an UDP tunnel and can handle the outer checksum. The tunn=
el
> > +  encapsulation is constrained to have constant size and carrying an i=
nner
> > +  ethernet header. e.g. alike vxlan and geneve defaults.
> > +
> >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unli=
ke UFO
> >   (fragmenting the packet) the USO splits large UDP packet
> >   to several segments when each of these smaller packets has UDP header=
.
> > @@ -3125,12 +3135,14 @@ \subsubsection{Feature bit requirements}\label{=
sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_GUEST_TSO6] Requires VIRTIO_NET_F_GUEST_CSUM.
> >  \item[VIRTIO_NET_F_GUEST_ECN] Requires VIRTIO_NET_F_GUEST_TSO4 or VIRT=
IO_NET_F_GUEST_TSO6.
> >  \item[VIRTIO_NET_F_GUEST_UFO] Requires VIRTIO_NET_F_GUEST_CSUM.
> > +\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL] Requires VIRTIO_NET_F_GUEST_TSO4 =
or VIRTIO_NET_F_GUEST_TSO6
> >=20
> >  \item[VIRTIO_NET_F_HOST_TSO4] Requires VIRTIO_NET_F_CSUM.
> >  \item[VIRTIO_NET_F_HOST_TSO6] Requires VIRTIO_NET_F_CSUM.
> >  \item[VIRTIO_NET_F_HOST_ECN] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO=
_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_HOST_UFO] Requires VIRTIO_NET_F_CSUM.
> >  \item[VIRTIO_NET_F_HOST_USO] Requires VIRTIO_NET_F_CSUM.
> > +\item[VIRTIO_NET_F_HOST_UDP_TUNNEL] Requires VIRTIO_NET_F_HOST_TSO4, V=
IRTIO_NET_F_HOST_TSO6 or VIRTIO_NET_F_HOST_USO
> >=20
> >  \item[VIRTIO_NET_F_CTRL_RX] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_CTRL_VLAN] Requires VIRTIO_NET_F_CTRL_VQ.
> > @@ -3337,6 +3349,9 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Network Device / Dev
> >    segmentation/fragmentation offload by negotiating the VIRTIO_NET_F_H=
OST_TSO4 (IPv4
> >    TCP), VIRTIO_NET_F_HOST_TSO6 (IPv6 TCP), VIRTIO_NET_F_HOST_UFO
> >    (UDP fragmentation) and VIRTIO_NET_F_HOST_USO (UDP segmentation) fea=
tures.
> > +  Additionally, it can negotiate the VIRTIO_NET_F_HOST_UDP_TUNNEL feat=
ure to
> > +  use TCP segmentation or UDP segmentation on top of UDP encapsulation=
,
> > +  respecting the other negotiated features.
> >=20
> >  \item The converse features are also available: a driver can save
> >    the virtual device some work by negotiating these features.\note{For=
 example, a network packet transported between two guests on
> > @@ -3345,8 +3360,8 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Network Device / Dev
> >     The VIRTIO_NET_F_GUEST_CSUM feature indicates that partially
> >    checksummed packets can be received, and if it can do that then
> >    the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
> > -  VIRTIO_NET_F_GUEST_UFO and VIRTIO_NET_F_GUEST_ECN are the input
> > -  equivalents of the features described above.
> > +  VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN and VIRTIO_NET_F_GUES=
T_UDP_TUNNEL
> > +  are the input equivalents of the features described above.
> >    See \ref{sec:Device Types / Network Device / Device Operation /
> >  Setting Up Receive Buffers}~\nameref{sec:Device Types / Network
> >  Device / Device Operation / Setting Up Receive Buffers} and
> > @@ -3370,12 +3385,14 @@ \subsection{Device Operation}\label{sec:Device =
Types / Network Device / Device O
> >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > +#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8
> >          u8 flags;
> >  #define VIRTIO_NET_HDR_GSO_NONE        0
> >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> >  #define VIRTIO_NET_HDR_GSO_UDP         3
> >  #define VIRTIO_NET_HDR_GSO_TCPV6       4
> >  #define VIRTIO_NET_HDR_GSO_UDP_L4      5
> > +#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL 0x40
> >  #define VIRTIO_NET_HDR_GSO_ECN      0x80
> >          u8 gso_type;
> >          le16 hdr_len;
> > @@ -3443,6 +3460,8 @@ \subsubsection{Packet Transmission}\label{sec:Dev=
ice Types / Network Device / De
> >  followed by the TCP header (with the TCP checksum field 16 bytes
> >  into that header). \field{csum_start} will be 14+20 =3D 34 (the TCP
> >  checksum includes the header), and \field{csum_offset} will be 16.
> > +If the given packets has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set,
> > +the above checksum fields refer to the inner header checksum.
> >  \end{note}
> >=20
> >  \item If the driver negotiated
> > @@ -3455,11 +3474,16 @@ \subsubsection{Packet Transmission}\label{sec:D=
evice Types / Network Device / De
> >    into smaller packets. The other gso fields are set:
> >=20
> >    \begin{itemize}
> > -  \item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> > +  \item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiate=
d and
> > +    the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set,
> > +    \field{hdr_len} indicates the location of the inner network header=
.
> > +    Otherwise, if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negot=
iated
> > +    and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set,
> >      \field{hdr_len} indicates the header length that needs to be repli=
cated
> >      for each packet. It's the number of bytes from the beginning of th=
e packet
> >      to the beginning of the transport payload.
> > -    Otherwise, if the VIRTIO_NET_F_GUEST_HDRLEN feature has not been n=
egotiated,
> > +    Finally, if the VIRTIO_NET_F_GUEST_HDRLEN and VIRTIO_NET_F_HOST_UD=
P_TUNNEL
> > +    the features has not been negotiated,
> >      \field{hdr_len} is a hint to the device as to how much of the head=
er
> >      needs to be kept to copy into each packet, usually set to the
> >      length of the headers, including the transport header\footnote{Due=
 to various bugs in implementations, this field is not useful
> > @@ -3467,7 +3491,13 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >  }.
> >=20
> >    \begin{note}
> > -  Some devices benefit from knowledge of the exact header length.
> > +  The segmentation happens at the (inner) L4 level, but it additionall=
y requires
> > +  the knowledge of all the inner and outer headers (L3 and L4).
>=20
> So if this is true, I wonder why not simply introduce the inner_l3/l4
> and outer_l3/l4 location in the vnet header? This is the way some NIC
> did (e.g Intel E810).

My main concern is as follow.=C2=A0

AFAICS, once that the involved peers have negotiated the
supported/enabled features, the virtio header len is constant.

Adding more fields to support UDP_TUNNEL GSO will increase the
negotiated virtio header size, adding overhead for the non UDP_TUNNEL
GSO traffic, making this feature less appealing. Likely that overhead
will be low, but it looks avodiable.

Additionally adding more fields don't lead to a simpler or faster
UDP_TUNNEL GSO implementation, as the complexity of validating them is
roughly equivalent to the very simple parsing needed to compute the
offsets from the data provided here.

I guess in the end is mostly a matter of personal preferences. I can
change the spec to use additional fields, if you have strong opinion
about it.

> > When a UDP tunnel
> > +  encapsulation is present, the device can probe the outer headers, bu=
t it needs
> > +  an explicit indication of the inner L3, as the UDP tunnel encapsulat=
ion could
> > +  potentially have a variable length. The driver can probe the inner L=
4 header given
> > +  the inner L3, while the reverse operation is error-prone..
>=20
> But this depends on the device to probe outer L3 and then outer L4. So we=
 have:
>=20
> 1) outer_l3
> 2) outer_l4
> 3) inner_l3
> 4) inner_l4
>=20
> This proposal wants an explicit specification for 3), I wonder what's
> the reason for not choosing from others?

I'm sorry I guess the above paragraph is a bit too terse. Note that we
already have the outer l3 and l4, for plain/non UDP_TUNNEL GSO sake.

Knowing the inner l4 offset is not enough to recontruct the inner l3
offset correctly, as such l3 could be either ipv4 or ipv6 (with
UDP_TUNNEL GSO + USO).

Assuming the real binary layout of the packet is:

outer mac| outer L3 (IPv6) | outer L4 (udp) | geneve encap with additional =
options | inner mac|  inner L3 (IPv4) | Inner L4 (UDP)

starting from the inner L4, the code could guess incorrectly an IPv6
inner l3, and it can find "consistent" values at the relevant
offset[s].=20

Instead, starting from the inner L3, the location of the inner L4 can
be computed deteministically with simple parsing.

> > +  Even for non GSO packets, some devices benefit from knowledge of the=
 exact header length.
> >    \end{note}
> >=20
> >    \item \field{gso_size} is the maximum size of each packet beyond tha=
t
> > @@ -3477,6 +3507,13 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >      the VIRTIO_NET_HDR_GSO_ECN bit in \field{gso_type}
> >      indicates that the TCP packet has the ECN bit set\footnote{This ca=
se is not handled by some older hardware, so is called out
> >  specifically in the protocol.}.
> > +
> > +  \item If the driver negotiated the VIRTIO_NET_F_HOST_UDP_TUNNEL feat=
ure,
> > +    \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set,
> > +    \field{flags} has the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM set, the ou=
ter
> > +    UDP checksum field carries the checksum for the UDP pseudo header,
> > +    the complete UDP checksum can be computed in a similar way to the
> > +    inner TCP.
> >     \end{itemize}
> >=20
> >  \item \field{num_buffers} is set to zero.  This field is unused on tra=
nsmitted packets.
> > @@ -3520,6 +3557,14 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >  driver MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
> >  \field{gso_type}.
> >=20
> > +The driver MUST NOT sent to the device TCP or UDP packets over UDP tun=
nel
>=20
> I think it should be "TCP or UDP GSO packets"

Right. I'll fix in the next version.

> > +requiring segmentation offload, unless the VIRTIO_NET_F_HOST_UDP_TUNNE=
L is
> > +negotiated, in which case the driver MUST set the VIRTIO_NET_HDR_GSO_U=
DP_TUNNEL
> > +bit in the \field{gso_type}.
> > +
> > +The driver MUST NOT set the VIRTIO_NET_HDR_GSO_UDP_TUNNEL together wit=
h
> > +VIRTIO_NET_HDR_GSO_UDP.
> > +
> >  If the VIRTIO_NET_F_CSUM feature has been negotiated, the
> >  driver MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> >  \field{flags}, if so:
> > @@ -3549,7 +3594,17 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >  If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> >  been negotiated:
> >  \begin{itemize}
> > -\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> > +\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiated,
> > +       and the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is
> > +       set, the driver MUST set \field{hdr_len} to a value equal to
> > +       the inner network header offset. If the outer header carries a
> > +       non zero checksum, the driver MUST additionally set the
> > +       \filed{flags} VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit and MUST
> > +       set the outer UDP header checksum field to the outer UDP pseudo
> > +       header sum.
> > +
> > +\item If the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL is not set=
,
> > +       the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> >         and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
> >         the driver MUST set \field{hdr_len} to a value equal to the len=
gth
> >         of the headers, including the transport header.
> > @@ -3576,7 +3631,21 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >  If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
> >  been negotiated:
> >  \begin{itemize}
> > -\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> > +\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiated,
> > +       and the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is
> > +       set, the driver MUST use \field{hdr_len} as the inner network
> > +       header offset.
> > +
> > +       The device MUST probe the outer UDP header and must drop the pa=
cket if
> > +       the probe operation is not successful.
>=20
> I wonder if this is the best choice:
>=20
> 1) the option by option probing is probably not efficient for both
> software and hardware device implementation

I'm not sure about the H/W, but S/W wise is trivial.

> 2) this wouldn't work when the networking stack want to use new ipv6
> option that is not recognized by the device

I guess we can't escape this last point without the additinal fields,
even if I'm reasonably sure that the creation of a new IPv6 option that
is not parsable by the existing code will break any [other] kind of h/w
offload and looks quite unlikely.

I'll look into revisting this whole change using the additional inner
fields.
>=20
> > +
> > +       \begin{note}
> > +       Caution should be taken by the implementation so as to prevent
> > +       a malicious driver from attacking the device by setting an inco=
rrect hdr_len.
> > +       \end{note}
> > +
> > +\item If the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not=
 set,
> > +       the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> >         and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
> >         the device MAY use \field{hdr_len} as the transport header size=
.
> >=20
> > @@ -3585,7 +3654,8 @@ \subsubsection{Packet Transmission}\label{sec:Dev=
ice Types / Network Device / De
> >         a malicious driver from attacking the device by setting an inco=
rrect hdr_len.
> >         \end{note}
> >=20
> > -\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated=
,
> > +\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has not been negotia=
ted,
> > +       the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
> >         or \field{gso_type} is VIRTIO_NET_HDR_GSO_NONE,
> >         the device MAY use \field{hdr_len} only as a hint about the
> >         transport header size.
> > @@ -3689,8 +3759,8 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
> >    has been validated.
> >  \end{enumerate}
> >=20
> > -Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN
> > -features enable receive checksum, large receive offload and ECN
> > +Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP, UDP_TUNNEL
> > +and ECN features enable receive checksum, large receive offload and EC=
N
> >  support which are the input equivalents of the transmit checksum,
> >  transmit segmentation offloading and ECN features, as described
> >  in \ref{sec:Device Types / Network Device / Device Operation /
> > @@ -3700,6 +3770,14 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >    negotiated, then \field{gso_type} MAY be something other than
> >    VIRTIO_NET_HDR_GSO_NONE, and \field{gso_size} field indicates the
> >    desired MSS (see Packet Transmission point 2).
> > +\item If the VIRTIO_NET_F_GUEST_UDP_TUNNEL option was negotiated and
> > +  \field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE, the VIRTIO_NET_HDR_=
GSO_UDP_TUNNEL
> > +  bit MAY be set, and the \field{hdr_len} field indicates the
> > +  inner network header offset (see Packet Transmission point 2).
> > +  Additionally, the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in the
> > +  \field{flags} MAY be set, indicating that the outer UDP header
> > +  carries the UDP pseudo header csum and that the driver can compute
> > +  the full UDP checksum on top of it (see Packet Transmission point 2)=
.
> >  \item If the VIRTIO_NET_F_RSC_EXT option was negotiated (this
> >    implies one of VIRTIO_NET_F_GUEST_TSO4, TSO6), the
> >    device processes also duplicated ACK segments, reports
> > @@ -3759,6 +3837,19 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >  which have the Explicit Congestion Notification bit set, unless the
> >  VIRTIO_NET_F_GUEST_ECN feature is negotiated, in which case the
> >  device MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
> > +
> > +The device SHOULD NOT send to the driver TCP or UDP packets encapsulat=
ed in UDP
> > +tunnel and requiring segmentation offload, unless the
> > +VIRTIO_NET_F_GUEST_UDP_TUNNEL is negotiated, in which case the device =
MUST set
> > +the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit in \field{gso_type}. If the oute=
r UDP
> > +header carries a non 0 checksum:
> > +\begin{enumerate}
> > +\item the device MUST set the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in
> > +       \field{flags}
> > +\item the device MUST set the outer UDP header checksum field to the o=
uter
> > +       UDP pseudo header sum
> > +\end{enumerate}
> > +
> >  \field{gso_type}.
> >=20
> >  If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
> > @@ -3778,6 +3869,12 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >         fully checksummed packet;
> >  \end{enumerate}
> >=20
> > +\begin{note}
> > +If the VIRTIO_NET_F_GUEST_UDP_TUNNEL feature is negotiated and the
> > +VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set, the VIRTIO_NET_HDR_F_NEEDS_C=
SUM
> > +bit refers to the inner header checksum.
> > +\end{note}
> > +
> >  If none of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
> >  been negotiated, the device MUST set \field{gso_type} to
> >  VIRTIO_NET_HDR_GSO_NONE.
> > @@ -3794,9 +3891,9 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
> >  not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
> >=20
> >  If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
> > -been negotiated, the device SHOULD set \field{hdr_len} to a value
> > -not less than the length of the headers, including the transport
> > -header.
> > +been negotiate and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL is not set,
> > +the device SHOULD set \field{hdr_len} to a value not less than
> > +the length of the headers, including the transport header.
> >=20
> >  If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
> >  device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
> > @@ -3814,8 +3911,12 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
> >  if VIRTIO_NET_HDR_F_RSC_INFO bit \field{flags} is set, the
> >  driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
> >=20
> > -If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
> > -been negotiated, the driver MAY use \field{hdr_len} only as a hint abo=
ut the
> > +If the VIRTIO_NET_HDR_GSO_UDP_TUNNEL in \field{gso_type} is set, the
> > +driver MUST probe the outer network and transport headers.
> > +
> > +If the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set and one of the
> > +VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have been negotiated,
> > +the driver MAY use \field{hdr_len} only as a hint about the
> >  transport header size.
> >  The driver MUST NOT rely on \field{hdr_len} to be correct.
> >  \begin{note}
>=20
> Btw, it looks to me that we need to add the guest tunnel to the
> offload state configuration.

Ok, I'll do that in the next revision.

Thanks!

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

