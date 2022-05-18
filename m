Return-Path: <virtio-dev-return-9551-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 017F4986508
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 May 2022 10:16:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 18 May 2022 12:15:53 +0200
Message-Id: <24d684572923c7171ccffa365e14526223ccb881.1652798338.git.pabeni@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: define UDP tunnel offload feature
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_NET_HDR_GSO_UDP_TUNNEL is a gso_type flags allowing
GSO over UDP tunnel. It can be negotiated on both the host and
guest side.

UDP tunnel usage is ubiquitous in container deployment, and the
ability to offload UDP encapsulated GSO traffic impacts greatly
the performances and the CPU utilization of such use-case

To keep the design relatively simple, this copes only with tunneling
scenarios including an inner ethernet MAC header - e.g. inner network
on top of the UDP encapsulation is not allowed.

Other than that the new flag is designed to be independent from the
specific UDP tunnel encapsulation - geneve, vxlan, etc.

The outer UDP header may carry a second checksum, which can be
offloaded independently from the inner one. We don't need to specify
the location of such checksum, as both the host and the guest can infer
its location the same way they currently do for the transport header for
plain GSO packets.

One constraint addressed here is that the virtio side (either device or
driver) receiving an UDP tunneled GSO packet must be able to reconstruct
completely the inner and outer headers offset - to allow for later GSO.

To accommodate such need the hdr_len field is [re-]used: when
the UDP tunnel feature is negotiated and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL
is set, such field is used to identify the inner network header.

All the other inner/outer headers location can be computed from the
above info.

Note that when the VIRTIO_NET_HDR_GSO_UDP_TUNNEL flag is not set,
the current semantic for the hdr_hen field does not change.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 content.tex | 110 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/content.tex b/content.tex
index c6f116c..8825d81 100644
--- a/content.tex
+++ b/content.tex
@@ -3092,6 +3092,16 @@ \subsection{Feature bits}\label{sec:Device Types / N=
etwork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL (54)] Driver can receive GSO packets
+  carried by an UDP tunnel. The tunnel encapsulation is constrained to hav=
e
+  constant size and carring an inner ethernet header. e.g. alike vxlan and
+  geneve defaults.
+
+\item[VIRTIO_NET_F_HOST_UDP_TUNNEL (55)] Device can receive GSO packets
+  carried by an UDP tunnel. The tunnel encapsulation is constrained to hav=
e
+  constant size and carring an inner ethernet header. e.g. alike vxlan and
+  geneve defaults.
+
 \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike U=
FO
  (fragmenting the packet) the USO splits large UDP packet
  to several segments when each of these smaller packets has UDP header.
@@ -3125,12 +3135,14 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
 \item[VIRTIO_NET_F_GUEST_TSO6] Requires VIRTIO_NET_F_GUEST_CSUM.
 \item[VIRTIO_NET_F_GUEST_ECN] Requires VIRTIO_NET_F_GUEST_TSO4 or VIRTIO_N=
ET_F_GUEST_TSO6.
 \item[VIRTIO_NET_F_GUEST_UFO] Requires VIRTIO_NET_F_GUEST_CSUM.
+\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL] Requires VIRTIO_NET_F_GUEST_TSO4 or V=
IRTIO_NET_F_GUEST_TSO6
=20
 \item[VIRTIO_NET_F_HOST_TSO4] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_TSO6] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_ECN] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET=
_F_HOST_TSO6.
 \item[VIRTIO_NET_F_HOST_UFO] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_USO] Requires VIRTIO_NET_F_CSUM.
+\item[VIRTIO_NET_F_HOST_UDP_TUNNEL] Requires VIRTIO_NET_F_HOST_TSO4, VIRTI=
O_NET_F_HOST_TSO6 or VIRTIO_NET_F_HOST_USO
=20
 \item[VIRTIO_NET_F_CTRL_RX] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_VLAN] Requires VIRTIO_NET_F_CTRL_VQ.
@@ -3337,6 +3349,9 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Network Device / Dev
   segmentation/fragmentation offload by negotiating the VIRTIO_NET_F_HOST_=
TSO4 (IPv4
   TCP), VIRTIO_NET_F_HOST_TSO6 (IPv6 TCP), VIRTIO_NET_F_HOST_UFO
   (UDP fragmentation) and VIRTIO_NET_F_HOST_USO (UDP segmentation) feature=
s.
+  Additionally, it can negotiate the VIRTIO_NET_F_HOST_UDP_TUNNEL feature =
to
+  use TCP segmentation or UDP segmentation on top of UDP encapsulation,
+  respecting the other negotiated features.
=20
 \item The converse features are also available: a driver can save
   the virtual device some work by negotiating these features.\note{For exa=
mple, a network packet transported between two guests on
@@ -3345,8 +3360,8 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Network Device / Dev
    The VIRTIO_NET_F_GUEST_CSUM feature indicates that partially
   checksummed packets can be received, and if it can do that then
   the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
-  VIRTIO_NET_F_GUEST_UFO and VIRTIO_NET_F_GUEST_ECN are the input
-  equivalents of the features described above.
+  VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN and VIRTIO_NET_F_GUEST_UD=
P_TUNNEL
+  are the input equivalents of the features described above.
   See \ref{sec:Device Types / Network Device / Device Operation /
 Setting Up Receive Buffers}~\nameref{sec:Device Types / Network
 Device / Device Operation / Setting Up Receive Buffers} and
@@ -3370,12 +3385,14 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
 #define VIRTIO_NET_HDR_GSO_UDP         3
 #define VIRTIO_NET_HDR_GSO_TCPV6       4
 #define VIRTIO_NET_HDR_GSO_UDP_L4      5
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL 0x40
 #define VIRTIO_NET_HDR_GSO_ECN      0x80
         u8 gso_type;
         le16 hdr_len;
@@ -3443,6 +3460,8 @@ \subsubsection{Packet Transmission}\label{sec:Device =
Types / Network Device / De
 followed by the TCP header (with the TCP checksum field 16 bytes
 into that header). \field{csum_start} will be 14+20 =3D 34 (the TCP
 checksum includes the header), and \field{csum_offset} will be 16.
+If the given packets has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set,
+the above checksum fields refer to the inner header checksum.
 \end{note}
=20
 \item If the driver negotiated
@@ -3455,11 +3474,16 @@ \subsubsection{Packet Transmission}\label{sec:Devic=
e Types / Network Device / De
   into smaller packets. The other gso fields are set:
=20
   \begin{itemize}
-  \item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
+  \item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiated an=
d
+    the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set,
+    \field{hdr_len} indicates the location of the inner network header.
+    Otherwise, if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiate=
d
+    and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set,
     \field{hdr_len} indicates the header length that needs to be replicate=
d
     for each packet. It's the number of bytes from the beginning of the pa=
cket
     to the beginning of the transport payload.
-    Otherwise, if the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negot=
iated,
+    Finally, if the VIRTIO_NET_F_GUEST_HDRLEN and VIRTIO_NET_F_HOST_UDP_TU=
NNEL
+    the features has not been negotiated,
     \field{hdr_len} is a hint to the device as to how much of the header
     needs to be kept to copy into each packet, usually set to the
     length of the headers, including the transport header\footnote{Due to =
various bugs in implementations, this field is not useful
@@ -3477,6 +3501,13 @@ \subsubsection{Packet Transmission}\label{sec:Device=
 Types / Network Device / De
     the VIRTIO_NET_HDR_GSO_ECN bit in \field{gso_type}
     indicates that the TCP packet has the ECN bit set\footnote{This case i=
s not handled by some older hardware, so is called out
 specifically in the protocol.}.
+
+  \item If the driver negotiated the VIRTIO_NET_F_HOST_UDP_TUNNEL feature,
+    \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set,
+    \field{flags} has the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM set, the outer
+    UDP checksum field carries the checksum for the UDP pseudo header,
+    the complete UDP checksum can be computed in a similar way to the
+    inner TCP.
    \end{itemize}
=20
 \item \field{num_buffers} is set to zero.  This field is unused on transmi=
tted packets.
@@ -3520,6 +3551,11 @@ \subsubsection{Packet Transmission}\label{sec:Device=
 Types / Network Device / De
 driver MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
 \field{gso_type}.
=20
+The driver MUST NOT sent to the device TCP or UDP packets over UDP tunnel
+requiring segmentation offload, unless the VIRTIO_NET_F_HOST_UDP_TUNNEL is
+negotiated, in which case the driver MUST set the VIRTIO_NET_HDR_GSO_UDP_T=
UNNEL
+bit in the \field{gso_type}.
+
 If the VIRTIO_NET_F_CSUM feature has been negotiated, the
 driver MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
 \field{flags}, if so:
@@ -3549,7 +3585,13 @@ \subsubsection{Packet Transmission}\label{sec:Device=
 Types / Network Device / De
 If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
 been negotiated:
 \begin{itemize}
-\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
+\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiated,
+=09and the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is
+=09set, the driver MUST set \field{hdr_len} to a value equal to
+=09the inner network header offset.
+
+\item If the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL is not set,
+=09the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 =09and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
 =09the driver MUST set \field{hdr_len} to a value equal to the length
 =09of the headers, including the transport header.
@@ -3576,7 +3618,18 @@ \subsubsection{Packet Transmission}\label{sec:Device=
 Types / Network Device / De
 If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
 been negotiated:
 \begin{itemize}
-\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
+\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has been negotiated,
+=09and the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is
+=09set, the driver MUST use \field{hdr_len} as the inner network
+=09header offset.
+
+=09\begin{note}
+=09Caution should be taken by the implementation so as to prevent
+=09a malicious driver from attacking the device by setting an incorrect hd=
r_len.
+=09\end{note}
+
+\item If the \field{gso_type} VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set=
,
+=09the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 =09and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
 =09the device MAY use \field{hdr_len} as the transport header size.
=20
@@ -3585,7 +3638,8 @@ \subsubsection{Packet Transmission}\label{sec:Device =
Types / Network Device / De
 =09a malicious driver from attacking the device by setting an incorrect hd=
r_len.
 =09\end{note}
=20
-\item If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
+\item If the VIRTIO_NET_F_HOST_UDP_TUNNEL feature has not been negotiated,
+=09the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
 =09or \field{gso_type} is VIRTIO_NET_HDR_GSO_NONE,
 =09the device MAY use \field{hdr_len} only as a hint about the
 =09transport header size.
@@ -3689,8 +3743,8 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
   has been validated.
 \end{enumerate}
=20
-Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN
-features enable receive checksum, large receive offload and ECN
+Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP, UDP_TUNNEL
+and ECN features enable receive checksum, large receive offload and ECN
 support which are the input equivalents of the transmit checksum,
 transmit segmentation offloading and ECN features, as described
 in \ref{sec:Device Types / Network Device / Device Operation /
@@ -3700,6 +3754,14 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
   negotiated, then \field{gso_type} MAY be something other than
   VIRTIO_NET_HDR_GSO_NONE, and \field{gso_size} field indicates the
   desired MSS (see Packet Transmission point 2).
+\item If the VIRTIO_NET_F_GUEST_UDP_TUNNEL option was negotiated and
+  \field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE, the VIRTIO_NET_HDR_GSO_=
UDP_TUNNEL
+  bit MAY be set, and the \field{hdr_len} field indicates the
+  inner network header offset (see Packet Transmission point 2).
+  Additionally, the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in the
+  \field{flags} MAY be set, indicating that the outer UDP header
+  carries the UDP pseudo header csum and that the full UDP checksum
+  (see Packet Transmission point 2).
 \item If the VIRTIO_NET_F_RSC_EXT option was negotiated (this
   implies one of VIRTIO_NET_F_GUEST_TSO4, TSO6), the
   device processes also duplicated ACK segments, reports
@@ -3759,6 +3821,19 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 which have the Explicit Congestion Notification bit set, unless the
 VIRTIO_NET_F_GUEST_ECN feature is negotiated, in which case the
 device MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
+
+The device SHOULD NOT send to the driver TCP or UDP packets encapsulated i=
n UDP
+tunnel and requiring segmentation offload, unless the
+VIRTIO_NET_F_GUEST_UDP_TUNNEL is negotiated, in which case the device MUST=
 set
+the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit in \field{gso_type}. If the outer UD=
P
+header carries a non 0 checksum:
+\begin{enumerate}
+\item the device MUST set the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in
+=09\field{flags}
+\item the device MUST set the outer UDP header checksum field to the outer
+=09UDP pseudo header
+\end{enumerate}
+
 \field{gso_type}.
=20
 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
@@ -3778,6 +3853,12 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 =09fully checksummed packet;
 \end{enumerate}
=20
+\begin{note}
+If the VIRTIO_NET_F_GUEST_UDP_TUNNEL feature is negotiated and the
+VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set, the VIRTIO_NET_HDR_F_NEEDS_CSUM
+bit refears to the inner header checksum
+\end{note}
+
 If none of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
 been negotiated, the device MUST set \field{gso_type} to
 VIRTIO_NET_HDR_GSO_NONE.
@@ -3794,9 +3875,9 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
 not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
=20
 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
-been negotiated, the device SHOULD set \field{hdr_len} to a value
-not less than the length of the headers, including the transport
-header.
+been negotiate and the VIRTIO_NET_HDR_GSO_UDP_TUNNEL is not set,
+the device SHOULD set \field{hdr_len} to a value not less than
+the length of the headers, including the transport header.
=20
 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
 device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
@@ -3814,8 +3895,9 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
 if VIRTIO_NET_HDR_F_RSC_INFO bit \field{flags} is set, the
 driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
=20
-If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about t=
he
+If the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is not set and one of the
+VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have been negotiated,
+the driver MAY use \field{hdr_len} only as a hint about the
 transport header size.
 The driver MUST NOT rely on \field{hdr_len} to be correct.
 \begin{note}
--=20
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

