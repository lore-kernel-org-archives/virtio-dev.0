Return-Path: <virtio-dev-return-9576-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02270986590
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Jun 2022 17:42:35 +0000 (UTC)
Message-ID: <af2556267ff9d2796ba3d176b7c2d8e5c3dad918.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 01 Jun 2022 19:42:29 +0200
In-Reply-To: <CACGkMEtXUdOgity7UB=f5hTs-sqrzFy_3rKQWnSf4EmNzz+LRg@mail.gmail.com>
References: <24d684572923c7171ccffa365e14526223ccb881.1652798338.git.pabeni@redhat.com>
	 <CACGkMEtXUdOgity7UB=f5hTs-sqrzFy_3rKQWnSf4EmNzz+LRg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: define UDP tunnel offload
 feature
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2022-05-31 at 14:34 +0800, Jason Wang wrote:
> On Wed, May 18, 2022 at 6:16 PM Paolo Abeni <pabeni@redhat.com> wrote:
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
> >=20
> > The outer UDP header may carry a second checksum, which can be
> > offloaded independently from the inner one. We don't need to specify
> > the location of such checksum, as both the host and the guest can infer
> > its location the same way they currently do for the transport header fo=
r
> > plain GSO packets.
>=20
> I'm not sure I get this, the transport header is set based on
> csum_start currently.=C2=A0

As a reference I looked at the Linux implementation and I missed that
the skb_partial_csum_set() in virtio_net_hdr_to_skb() actually sets the
transport offset, sorry.

Still is possible - and quite cheap - to infer the transport header
offset from the network header.

> More below.


>=20
> >=20
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
> > above info.
> >=20
> > Note that when the VIRTIO_NET_HDR_GSO_UDP_TUNNEL flag is not set,
> > the current semantic for the hdr_hen field does not change.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  content.tex | 110 +++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 96 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/content.tex b/content.tex
> > index c6f116c..8825d81 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3092,6 +3092,16 @@ \subsection{Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >=20
> > +\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL (54)] Driver can receive GSO packe=
ts
> > +  carried by an UDP tunnel. The tunnel encapsulation is constrained to=
 have
> > +  constant size and carring an inner ethernet header. e.g. alike vxlan=
 and
>=20
> I think you mean "carrying" here.
>=20
> > +  geneve defaults.
> > +
> > +\item[VIRTIO_NET_F_HOST_UDP_TUNNEL (55)] Device can receive GSO packet=
s
> > +  carried by an UDP tunnel. The tunnel encapsulation is constrained to=
 have
> > +  constant size and carring an inner ethernet header. e.g. alike vxlan=
 and
>=20
> And here.
>=20
> > +  geneve defaults.
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
>=20
> I think we need to explain how the outer checksum is expected to work.
> It looks to me it requires the device to examine/probe the outer
> packet header.=C2=A0

I will do in the next revision.

> If it's true, I wonder what happen if the device fail
> to do such probing.

In that case the packet should be discarded - the same way the device
discards packets when it fails to access the transport offset for the
plain GSO case.
>=20
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
>=20
> It's probably better to explain why a network header instead of
> transport header is needed here. (Anyhow we're doing segmentation at
> L4 instead of L3).

yes, well do in the next revision.

>=20
> > +    Otherwise, if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negot=
iated
> > +    and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set,
>=20
> I wonder if this just suppress the semantic of GUEST_HDR_LEN.=C2=A0

It should not. This specification gives VIRTIO_NET_F_HOST_UDP_TUNNEL/
VIRTIO_NET_HDR_GSO_UDP_TUNNEL an 'higher priority' over GUEST_HDR_LEN.
If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature is not negotiated or the
VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set, hdr_len and GUEST_HDR_LEN
retain their current semantic.

> If yes,
> is this better to have dedicated inner hdr len?
>=20
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
> > @@ -3477,6 +3501,13 @@ \subsubsection{Packet Transmission}\label{sec:De=
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
>=20
> This looks like a partial offload of the outer checksum, if yes, we
> probably need a better name of the flag (maybe
> UDP_TUNNEL_PARTIAL_CSUM)?=C2=A0

Still looking at the linux implementation, if I read the code
correctly, it looks like VIRTIO_NET_HDR_F_NEEDS_CSUM expect to find the
L4 pseudo header csum in place (e.g. in tcp_header->csum I mean)?!? if
so this would be exactly the same.

> This is because VIRTIO_NET_HDR_F_CSUM is
> used for complete offloading.
>=20
> >     \end{itemize}
> >=20
> >  \item \field{num_buffers} is set to zero.  This field is unused on tra=
nsmitted packets.
> > @@ -3520,6 +3551,11 @@ \subsubsection{Packet Transmission}\label{sec:De=
vice Types / Network Device / De
> >  driver MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
> >  \field{gso_type}.
> >=20
> > +The driver MUST NOT sent to the device TCP or UDP packets over UDP tun=
nel
> > +requiring segmentation offload, unless the VIRTIO_NET_F_HOST_UDP_TUNNE=
L is
> > +negotiated, in which case the driver MUST set the VIRTIO_NET_HDR_GSO_U=
DP_TUNNEL
> > +bit in the \field{gso_type}.
>=20
> Do we need to clarify that inner UFO is forbidden even with UDP_TUNNEL?

Yes, UFO is forbitten on top of UDP_TUNNEL (and USO is/will be
allowed). I'll try to clarify that in the next revision.


Thanks!

Paolo


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

