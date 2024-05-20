Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077824B26
	for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193507; cv=none; b=H2pKJummqz9KcgiMMrYvewCnphOvSeqabzoPOK3XVkOf8/8hRbaYbOij70CWUbdiCuetX1WIiwZzKs0whQTPfpzKaz/50AkI3CTS1R3kM5PqEWUfzSidmzfxuvmpfoYYG2mG7xQ3+sFvvYWnWwmHcbDVod8F6bJSDZLO4O3FL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193507; c=relaxed/simple;
	bh=X+GO9lDcH2muZ/8TthEKyZ1FbrBuye4OaPHPx1q4M0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVUYDMFjBAGhZbkpLoDEnD2Otvzcb5lxTFunHpL/RzvxZLTeK1jCBHl4fnB+kmAL9F/5pGxK4KflfDfwfb7TgQb8T5+Nm8iQ3NFXjABCLpYW15RZOeGn9TCHBdkmnwunOwhux61NSfuBIEWNYnwa0B8sZSUZcnsLB7HreXqvrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iieAxudQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iieAxudQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716193504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ZCzbYfTuRE/Y3ltR7JT/L4R5OfUzQ782I/fk2dJTmM=;
	b=iieAxudQvXI9nv+CREBTpOvNQSs7/QlCJkfMn6fDVA5jnRUV74ltQM1Zo51spWnt3d/zuO
	ZrcwCr5/v6qdZiXMieTxDKrOxShq15LABa8jjnWUvyvZ/F2yMX10bqNWxja/68yMCUxsS1
	Phba/A1lZlHJVwJkng/A0qRn3ARD2+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ZIKdQGPcPi2AdYrWCgFUMg-1; Mon, 20 May 2024 04:25:02 -0400
X-MC-Unique: ZIKdQGPcPi2AdYrWCgFUMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C333101A52C
	for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 08:25:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4547C10004FE;
	Mon, 20 May 2024 08:25:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: virtio-dev@lists.linux.dev
Cc: maxime.coquelin@redhat.com,
	Eelco Chaudron <echaudro@redhat.com>,
	pabeni@redhat.com,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3] virtio-net: define UDP tunnel offload feature
Date: Mon, 20 May 2024 10:24:53 +0200
Message-ID: <f0bf2db203f8061a3ecb50b7a48cf26d8f3c7f68.1716193086.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The VIRTIO_NET_HDR_GSO_UDP_TUNNEL is a gso_type flag allowing GSO over
UDP tunnel. It can be negotiated on both the host and guest sides.

UDP tunnel usage is ubiquitous in container deployment, and the ability
to offload UDP encapsulated GSO traffic impacts greatly the performances
and the CPU utilization of such use cases.

One constraint addressed here is that the virtio side (either device or
driver) receiving a UDP tunneled GSO packet must be able to reconstruct
completely the inner and outer headers offset - to allow for later GSO.

To accommodate such need, new optional fields are introduced in the
virtio_net header: outer_th_offset, inner_protocol, inner_mac_offset,
inner_nh_offset. They map directly to the corresponding header
information.

Note that the inner transport header is implied by the (inner) checksum
offload, if present. Otherwise, it's up to the receiver to detect the
inner transport header offset from the provided information, as it's
currently the case for plain (not UDP tunneled) GSO packets.

The outer UDP header may carry a second checksum, which can be offloaded
independently from the inner one. Since UDP tunnel checksum offload
support makes little sense without UDP tunnel GSO support, to avoid
unnecessary complex feature negotiation, the
VIRTIO_NET_HDR_GSO_UDP_TUNNEL feature implies the support for the outer
header checksum offload and the checksum itself is handled similarly to
the inner header one.

Note that there is no concept of UDP tunnel type negotiation (e.g.
vxlan, geneve, vxlan-gpe, etc.). That is intentional because:
- given the information carried by the guest or host kernel, it's
  impossible to probe reliably the UDP tunnel type. Specifically, the
  outer UDP port numbers give a hint, but peers could use nonstandard
  ones.
- all the existing UDP tunnel protocols behave the same way WRT GSO
  offload, carrying an immutable header on top of the outer transport
  one.
- if a new UDP tunnel protocol should surface in the future with
  different constraints, the host and guest kernels will need explicit
  support for it, including new, different GSO features. Additional
  virtio support should be designed separately.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - UDP_TUNNEL -> UDP_TUNNEL_GSO
 - add explicit fields for the inner meta-data
 - more verbose changelog
 https://lists.oasis-open.org/archives/virtio-dev/202206/msg00026.html

v1 -> v2:
 - explicitly state that the outer header probing is mandatory
 - explicitly state that GSO_UDP is not allowed with GSO_UDP_TUNNEL
 - clarify hdr_len usage
 - clarify UDP_TUNNEL_CSUM bit usage
 - fix a few typos
 https://lists.oasis-open.org/archives/virtio-dev/202205/msg00037.html
---
 device-types/net/description.tex | 118 ++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 8 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 76585b0..2eae797 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -88,6 +88,12 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO (49)] Driver can receive GSO packets
+  carried by an UDP tunnel and can handle the outer checksum.
+
+\item[VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO (50)] Device can receive GSO packets
+  carried by an UDP tunnel and can handle the outer checksum.
+
 \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
 
 \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
@@ -133,12 +139,16 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_GUEST_UFO] Requires VIRTIO_NET_F_GUEST_CSUM.
 \item[VIRTIO_NET_F_GUEST_USO4] Requires VIRTIO_NET_F_GUEST_CSUM.
 \item[VIRTIO_NET_F_GUEST_USO6] Requires VIRTIO_NET_F_GUEST_CSUM.
+\item[VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO] Requires VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+   VIRTIO_NET_F_GUEST_USO4 or VIRTIO_NET_F_GUEST_USO6.
 
 \item[VIRTIO_NET_F_HOST_TSO4] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_TSO6] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_ECN] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_HOST_UFO] Requires VIRTIO_NET_F_CSUM.
 \item[VIRTIO_NET_F_HOST_USO] Requires VIRTIO_NET_F_CSUM.
+\item[VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO] Requires VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
+   VIRTIO_NET_F_GUEST_USO4 or VIRTIO_NET_F_GUEST_USO6.
 
 \item[VIRTIO_NET_F_CTRL_RX] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_CTRL_VLAN] Requires VIRTIO_NET_F_CTRL_VQ.
@@ -374,6 +384,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Network Device / Dev
   segmentation/fragmentation offload by negotiating the VIRTIO_NET_F_HOST_TSO4 (IPv4
   TCP), VIRTIO_NET_F_HOST_TSO6 (IPv6 TCP), VIRTIO_NET_F_HOST_UFO
   (UDP fragmentation) and VIRTIO_NET_F_HOST_USO (UDP segmentation) features.
+  Additionally, it can negotiate the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO feature
+  to use TCP segmentation or UDP segmentation on top of UDP encapsulation,
+  respecting the other negotiated features.
 
 \item The converse features are also available: a driver can save
   the virtual device some work by negotiating these features.\note{For example, a network packet transported between two guests on
@@ -382,8 +395,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Network Device / Dev
    The VIRTIO_NET_F_GUEST_CSUM feature indicates that partially
   checksummed packets can be received, and if it can do that then
   the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
-  VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_USO4
-  and VIRTIO_NET_F_GUEST_USO6 are the input equivalents of the features described above.
+  VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_USO4,
+  VIRTIO_NET_F_GUEST_USO6 and VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
+  are the input equivalents of the features described above.
   See \ref{sec:Device Types / Network Device / Device Operation /
 Setting Up Receive Buffers}~\nameref{sec:Device Types / Network
 Device / Device Operation / Setting Up Receive Buffers} and
@@ -407,12 +421,14 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
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
@@ -423,6 +439,10 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
         le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
         le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
         le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
+        le16 outer_th_offset;   (Only if VIRTIO_NET_F_UDP_TUNNEL_GSO negotiated)
+        le16 inner_protocol;    (Only if VIRTIO_NET_F_UDP_TUNNEL_GSO negotiated)
+        le16 inner_mac_offset;  (Only if VIRTIO_NET_F_UDP_TUNNEL_GSO negotiated)
+        le16 inner_nh_offset;   (Only if VIRTIO_NET_F_UDP_TUNNEL_GSO negotiated)
 };
 \end{lstlisting}
 
@@ -480,6 +500,8 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 followed by the TCP header (with the TCP checksum field 16 bytes
 into that header). \field{csum_start} will be 14+20 = 34 (the TCP
 checksum includes the header), and \field{csum_offset} will be 16.
+If the given packets has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set,
+the above checksum fields refer to the inner header checksum.
 \end{note}
 
 \item If the driver negotiated
@@ -516,6 +538,30 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 specifically in the protocol.}.
    \end{itemize}
 
+\item If the driver negotiated the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO feature,
+  the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit in \field{gso_type} indicates that
+  the GSO protocol is encapsulated in an UDP tunnel.
+  The other tunnel-related fields indicate how to replicate the inner packet
+  header to cut it into smaller packets:
+
+  \begin{itemize}
+  \item \field{outer_th_offset} field indicates the outer transport header within
+      the packet
+
+  \item \field{inner_protocol} field indicates the ethernet type of the inner
+      protocol.
+
+  \item \field{inner_mac_offset} field indicates the inner mac header within the packet
+
+  \item \field{inner_nh_offset} field indicates the inner network header within
+      the packet
+
+  \item If the \field{flags} field has the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM set,
+    the outer UDP checksum field carries the checksum for the UDP pseudo header
+    and the complete UDP checksum can be computed in a similar way to the
+    inner TCP.
+  \end{itemize}
+
 \item \field{num_buffers} is set to zero.  This field is unused on transmitted packets.
 
 \item The header and packet are added as one output descriptor to the
@@ -557,6 +603,14 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 driver MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
 \field{gso_type}.
 
+The driver MUST NOT send to the device TCP or UDP GSO packets over UDP tunnel
+requiring segmentation offload, unless the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO is
+negotiated, in which case the driver MUST set the VIRTIO_NET_HDR_GSO_UDP_TUNNEL
+bit in the \field{gso_type}.
+
+The driver MUST NOT set the VIRTIO_NET_HDR_GSO_UDP_TUNNEL together with
+VIRTIO_NET_HDR_GSO_UDP.
+
 If the VIRTIO_NET_F_CSUM feature has been negotiated, the
 driver MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
 \field{flags}, if so:
@@ -633,6 +687,18 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 	\end{note}
 \end{itemize}
 
+If the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO option has been negotiated:
+\begin{itemize}
+\item If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit set
+	the device MUST use the \field{outer_th_offset}, \field{inner_protocol},
+  \field{inner_mac_offset} and \field{inner_nh_offset} fields to
+  locate the corresponding headers inside the packet.
+\end{itemize}
+
+If VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit in \field{gso_type} is not set, the
+device MUST NOT use the \field{outer_th_offset}, \field{inner_protocol},
+\field{inner_mac_offset} and \field{inner_nh_offset}.
+
 If VIRTIO_NET_HDR_F_NEEDS_CSUM is not set, the device MUST NOT
 rely on the packet checksum being correct.
 \paragraph{Packet Transmission Interrupt}\label{sec:Device Types / Network Device / Device Operation / Packet Transmission / Packet Transmission Interrupt}
@@ -727,8 +793,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
   has been validated.
 \end{enumerate}
 
-Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN
-features enable receive checksum, large receive offload and ECN
+Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP, UDP_TUNNEL
+and ECN features enable receive checksum, large receive offload and ECN
 support which are the input equivalents of the transmit checksum,
 transmit segmentation offloading and ECN features, as described
 in \ref{sec:Device Types / Network Device / Device Operation /
@@ -738,6 +804,15 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
   negotiated, then \field{gso_type} MAY be something other than
   VIRTIO_NET_HDR_GSO_NONE, and \field{gso_size} field indicates the
   desired MSS (see Packet Transmission point 2).
+\item If the VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO option was negotiated and
+  \field{gso_type} is not VIRTIO_NET_HDR_GSO_NONE, the VIRTIO_NET_HDR_GSO_UDP_TUNNEL
+  bit MAY be set. In such case the \field{outer_th_offset}, \field{inner_protocol},
+  \field{inner_mac_offset} and \field{inner_nh_offset} fields indicates corresponding
+  header information.
+  Additionally, the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in the
+  \field{flags} MAY be set, indicating that the outer UDP header
+  carries the UDP pseudo header csum and that the driver can compute
+  the full UDP checksum on top of it (see Packet Transmission point 3).
 \item If the VIRTIO_NET_F_RSC_EXT option was negotiated (this
   implies one of VIRTIO_NET_F_GUEST_TSO4, TSO6), the
   device processes also duplicated ACK segments, reports
@@ -750,8 +825,9 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
   from \field{csum_start} and any preceding checksums
   have been validated.  The checksum on the packet is incomplete and
   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
-  then \field{csum_start} and \field{csum_offset} indicate how to calculate it
-  (see Packet Transmission point 1).
+  then \field{csum_start} and \field{csum_offset} indicate how to calculate it.
+  If the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set, the \field{csum_start} field
+  refers to the inner transport header offset (see Packet Transmission point 1).
 
 \end{enumerate}
 
@@ -800,6 +876,20 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 which have the Explicit Congestion Notification bit set, unless the
 VIRTIO_NET_F_GUEST_ECN feature is negotiated, in which case the
 device MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
+
+The device SHOULD NOT send to the driver TCP or UDP GSO packets encapsulated in UDP
+tunnel and requiring segmentation offload, unless the
+VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO is negotiated, in which case the device MUST set
+the VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit in \field{gso_type} and MUST set the
+\field{outer_th_offset}, \field{inner_protocol}, \field{inner_mac_offset} and
+\field{inner_nh_offset}. If the outer UDP header carries a non 0 checksum:
+\begin{enumerate}
+\item the device MUST set the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM bit in
+	\field{flags}
+\item the device MUST set the outer UDP header checksum field to the outer
+	UDP pseudo header sum
+\end{enumerate}
+
 \field{gso_type}.
 
 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
@@ -819,6 +909,12 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 	fully checksummed packet;
 \end{enumerate}
 
+\begin{note}
+If the VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO feature is negotiated and the
+VIRTIO_NET_HDR_GSO_UDP_TUNNEL bit is set, the VIRTIO_NET_HDR_F_NEEDS_CSUM
+bit refers to the inner header checksum.
+\end{note}
+
 If none of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
 been negotiated, the device MUST set \field{gso_type} to
 VIRTIO_NET_HDR_GSO_NONE.
@@ -842,8 +938,9 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
 device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
 \field{flags}, if so, the device MUST validate the packet
-checksum (in case of multiple encapsulated protocols, one level
-of checksums is validated).
+checksum. If the VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM
+bit in \field{flags} is also set, the device MUST additionally validate
+the outer UDP header checksum.
 
 \drivernormative{\paragraph}{Processing of Incoming
 Packets}{Device Types / Network Device / Device Operation /
@@ -863,6 +960,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 This is due to various bugs in implementations.
 \end{note}
 
+If the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_GSO bit in \field{gso_type} is not set,
+the driver MUST NOT use the \field{outer_th_offset}, \field{inner_protocol},
+\field{inner_mac_offset} and \field{inner_nh_offset}.
+
 If neither VIRTIO_NET_HDR_F_NEEDS_CSUM nor
 VIRTIO_NET_HDR_F_DATA_VALID is set, the driver MUST NOT
 rely on the packet checksum being correct.
@@ -1624,6 +1725,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 #define VIRTIO_NET_F_GUEST_TSO6       8
 #define VIRTIO_NET_F_GUEST_ECN        9
 #define VIRTIO_NET_F_GUEST_UFO        10
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 49
 #define VIRTIO_NET_F_GUEST_USO4       54
 #define VIRTIO_NET_F_GUEST_USO6       55
 
-- 
2.43.2

