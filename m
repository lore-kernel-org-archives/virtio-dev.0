Return-Path: <hengqi@linux.alibaba.com>
Date: Wed, 14 Dec 2022 17:01:44 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio_net: support inner header hash
Message-ID: <20221214090144.GC56694@h68b04307.sqa.eu95>
References: <20221205063639.127767-1-hengqi@linux.alibaba.com>
 <68a101b6-6b8b-6966-6162-7fe8d46d589d@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <68a101b6-6b8b-6966-6162-7fe8d46d589d@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 09, 2022 at 02:09:18PM +0800, Heng Qi wrote:
> 
> Do you have any comments on this new version?
> 

If the reviewers do not have more comments on
"[v3] virtio_net: support inner header hash",
then I submit an issue in the virtio-spec repository.
Please vote on whether this new feature is added to
the virtio specification.

The link is https://github.com/oasis-tcs/virtio-spec/issues/151.

Thanks.

> Thanks.
> 
> 在 2022/12/5 下午2:36, Heng Qi 写道:
> >When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> >encapsulate the packets, the hash calculated using the outer header
> >of the receive packets is always fixed for the same flow packets,
> >i.e. they will be steered to the same receive queue.
> >
> >We add a VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER feature bit and
> >related bitmasks in \field{hash_types}, which instructs the device
> >to calculate the hash using the inner headers of GRE, VXLAN or
> >GENEVE-encapsulated packets. Besides, \field{hash_report_tunnel} are
> >added to report packet type when calculating hash over the inner header.
> >
> >Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >---
> >v2:
> >	1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
> >	2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jason Wang, @Michael S. Tsirkin
> >
> >v1:
> >	1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> >	2. Clarify some paragraphs. @Jason Wang
> >	3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
> >
> >  content.tex | 190 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 181 insertions(+), 9 deletions(-)
> >
> >diff --git a/content.tex b/content.tex
> >index e863709..675da87 100644
> >--- a/content.tex
> >+++ b/content.tex
> >@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >+\item[VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER(52)] Device supports inner
> >+    header hash for GRE, VXLAN and GENEVE-encapsulated packets.
> >+
> >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
> >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> >@@ -3095,7 +3098,8 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >   to several segments when each of these smaller packets has UDP header.
> >  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
> >-    value and a type of calculated hash.
> >+    value, a type of calculated hash and a tunnel packet type if
> >+    VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER is negotiated.
> >  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
> >      value. Device benefits from knowing the exact header length.
> >@@ -3140,6 +3144,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> >+\item[VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER] Requires VIRTIO_NET_F_CTRL_VQ and VIRTIO_NET_F_RSS.
> >  \end{description}
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> >@@ -3386,7 +3391,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >          le16 num_buffers;
> >          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >-        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >+        le8 hash_report_tunnel; (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >+        le8 padding_reserved;   (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> >  };
> >  \end{lstlisting}
> >@@ -3837,19 +3843,22 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  A device attempts to calculate a per-packet hash in the following cases:
> >  \begin{itemize}
> >  \item The feature VIRTIO_NET_F_RSS was negotiated. The device uses the hash to determine the receive virtqueue to place incoming packets.
> >-\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value and the hash type with the packet.
> >+\item The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device reports the hash value, the hash type and the tunnel packet type.
> >  \end{itemize}
> >  If the feature VIRTIO_NET_F_RSS was negotiated:
> >  \begin{itemize}
> >-\item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask.
> >+\item The device uses \field{hash_types} of the virtio_net_rss_config structure as 'Enabled hash types' bitmask,
> >+but VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and VIRTIO_NET_HASH_TYPE_GENEVE_INNER in
> >+\field{hash_types} can only be used when the feature VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER is negotiated.
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_rss_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / Setting RSS parameters}).
> >  \end{itemize}
> >  If the feature VIRTIO_NET_F_RSS was not negotiated:
> >  \begin{itemize}
> >-\item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask.
> >+\item The device uses \field{hash_types} of the virtio_net_hash_config structure as 'Enabled hash types' bitmask,
> >+except VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and VIRTIO_NET_HASH_TYPE_GENEVE_INNER.
> >  \item The device uses a key as defined in \field{hash_key_data} and \field{hash_key_length} of the virtio_net_hash_config structure (see
> >  \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Hash calculation}).
> >  \end{itemize}
> >@@ -3883,6 +3892,18 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_TYPE_TCP_EX            (1 << 7)
> >  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
> >  \end{lstlisting}
> >+Hash types applicable to inner payloads of GRE-encapsulated packets
> >+\begin{lstlisting}
> >+#define VIRTIO_NET_HASH_TYPE_GRE_INNER         (1 << 9)
> >+\end{lstlisting}
> >+Hash types applicable to inner payloads of VXLAN-encapsulated packets
> >+\begin{lstlisting}
> >+#define VIRTIO_NET_HASH_TYPE_VXLAN_INNER       (1 << 10)
> >+\end{lstlisting}
> >+Hash types applicable to inner payloads of GENEVE-encapsulated packets
> >+\begin{lstlisting}
> >+#define VIRTIO_NET_HASH_TYPE_GENEVE_INNER      (1 << 11)
> >+\end{lstlisting}
> >  \subparagraph{IPv4 packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
> >@@ -3975,15 +3996,148 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
> >  \end{itemize}
> >+\subparagraph{Inner payloads of GRE, VXLAN or GENEVE-encapsulated packets}
> >+\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Inner payloads of GRE, VXLAN or GENEVE-encapsulated packets}}
> >+VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER or
> >+VIRTIO_NET_HASH_TYPE_GENEVE_INNER bit is set at the same time as one of
> >+the bits between VIRTIO_NET_HASH_TYPE_IPv4 and VIRTIO_NET_HASH_TYPE_UDP_EX.
> >+
> >+The device calculates the hash on GRE, VXLAN or GENEVE-encapsulated packets whose inner
> >+payloads are IPv4 packets according to 'Enabled hash types' bitmasks as follows:
> >+\begin{itemize}
> >+  \item If VIRTIO_NET_HASH_TYPE_TCPv4 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner TCPv4 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IP address
> >+          \item inner Destination IP address
> >+          \item inner Source TCP port
> >+          \item inner Destination TCP port
> >+        \end{itemsize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_UDPv4 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner UDPv4 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IP address
> >+          \item inner Destination IP address
> >+          \item inner Source UDP port
> >+          \item inner Destination UDP port
> >+        \end{itemize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_IPv4 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, the hash is calculated over the
> >+      following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IP address
> >+          \item inner Destination IP address
> >+        \end{itemsize}
> >+  \item Else the device does not calculate the hash
> >+\end{itemize}
> >+
> >+The device calculates the hash on GRE, VXLAN or GENEVE-encapsulated packets whose inner
> >+payloads are IPv6 packets without extension headers according to 'Enabled hash types'
> >+bitmasks as follows:
> >+\begin{itemize}
> >+  \item If VIRTIO_NET_HASH_TYPE_TCPv6 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner TCPv6 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IPv6 address
> >+          \item inner Destination IPv6 address
> >+          \item inner Source TCP port
> >+          \item inner Destination TCP port
> >+        \end{itemsize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_UDPv6 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner UDPv6 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IPv6 address
> >+          \item inner Destination IPv6 address
> >+          \item inner Source UDP port
> >+          \item inner Destination UDP port
> >+        \end{itemize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_IPv6 is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, the hash is calculated over the
> >+      following fields:
> >+        \begin{itemsize}
> >+          \item inner Source IPv6 address
> >+          \item inner Destination IPv6 address
> >+        \end{itemsize}
> >+  \item Else the device does not calculate the hash
> >+\end{itemize}
> >+
> >+The device calculates the hash on GRE, VXLAN or GENEV-encapsulated packets whose inner
> >+payloads are IPv6 packets with extension headers according to 'Enabled hash types'
> >+bitmasks as follows:
> >+\begin{itemsize}
> >+  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner TCPv6 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemize}
> >+          \item Home address from the home address option in the inner IPv6 destination
> >+              options header. If the inner extension header is not present, use the
> >+              inner Source IPv6 address.
> >+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> >+              associated inner extension header. If the inner extension header is not
> >+              present, use the inner Destination IPv6 address.
> >+          \item inner Source TCP port
> >+          \item inner Destination TCP port
> >+        \end{itemize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_UDP_EX is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, and the GRE, VXLAN or GENEVE-encapsulated
> >+      packet has an inner UDPv6 header in its payload, the hash is calculated over
> >+      the following fields:
> >+        \begin{itemsize}
> >+          \item Home address from the home address option in the inner IPv6 destination
> >+              options header. If the inner extension header is not present, use the
> >+              inner Source IPv6 address.
> >+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> >+              associated inner extension header. If the inner extension header is not
> >+              present, use the inner Destination IPv6 address.
> >+          \item inner Source UDP port
> >+          \item inner Destination UDP port
> >+        \end{itemize}
> >+  \item Else if VIRTIO_NET_HASH_TYPE_IP_EX is set along with one of
> >+      VIRTIO_NET_HASH_TYPE_GRE_INNER, VIRTIO_NET_HASH_TYPE_VXLAN_INNER and
> >+      VIRTIO_NET_HASH_TYPE_GENEVE_INNER, the hash is calculated over the
> >+      following fields:
> >+        \begin{itemsize}
> >+          \item Home address from the home address option in the inner IPv6 destination
> >+              options header. If the inner extension header is not present, use the
> >+              inner Source IPv6 address.
> >+          \item IPv6 address that is contained in the Routing-Header-Type-2 from the
> >+              associated inner extension header. If the inner extension header is not
> >+              present, use the inner Destination IPv6 address.
> >+        \end{itemize}
> >+  \item Else skip inner IPv6 extension headers and calculate the hash as defined
> >+      for a GRE, VXLAN or GENEVE-encapsulated packet whose inner payload is an IPv6
> >+      packet without extension headers
> >+\end{itemsize}
> >+
> >  \paragraph{Hash reporting for incoming packets}
> >  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash reporting for incoming packets}
> >-If VIRTIO_NET_F_HASH_REPORT was negotiated and
> >- the device has calculated the hash for the packet, the device fills \field{hash_report} with the report type of calculated hash
> >-and \field{hash_value} with the value of calculated hash.
> >+If VIRTIO_NET_F_HASH_REPORT was negotiated and the device has calculated the
> >+hash for the packet, the device fills \field{hash_report} with the report type
> >+of calculated hash, and \field{hash_value} with the value of calculated hash.
> >+And if VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER was negotiated, the device also
> >+needs to fills \field{hash_report_tunnel} with the type of the tunnel packet,
> >  If VIRTIO_NET_F_HASH_REPORT was negotiated but due to any reason the
> >-hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE.
> >+hash was not calculated, the device sets \field{hash_report} to VIRTIO_NET_HASH_REPORT_NONE,
> >+and \field{hash_report_tunnel} is no longer valid.
> >  Possible values that the device can report in \field{hash_report} are defined below.
> >  They correspond to supported hash types defined in
> >@@ -4005,6 +4159,24 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >  \end{lstlisting}
> >+If \field{hash_report} differs from VIRTIO_NET_HASH_REPORT_NONE,
> >+\field{hash_report_tunnel} can report the type of the tunnel-encapsulated
> >+packet to the driver over the inner header hash calculation.
> >+Possible values that the device can report in \field{hash_report_tunnel}
> >+are defined below:
> >+
> >+\begin{lstlisting}
> >+#define VIRTIO_NET_HASH_REPORT_GRE             1
> >+#define VIRTIO_NET_HASH_REPORT_VXLAN           2
> >+#define VIRTIO_NET_HASH_REPORT_GENEVE          3
> >+\end{lstlisting}
> >+
> >+The values VIRTIO_NET_HASH_REPORT_GRE, VIRTIO_NET_HASH_REPORT_VXLAN and
> >+VIRTIO_NET_HASH_REPORT_GENEVE correspond to VIRTIO_NET_HASH_TYPE_GRE_INNER,
> >+VIRTIO_NET_HASH_TYPE_VXLAN_INNER and VIRTIO_NET_HASH_TYPE_GENEVE_INNER bits
> >+of supported hash types defined in respectively
> >+\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
> >+
> >  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
> >  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

