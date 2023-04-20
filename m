Return-Path: <virtio-dev-return-12323-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E28C77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:47:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 282BD3F546
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCEE5986647
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 12:46:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9E15C98668F; Thu, 20 Apr 2023 12:46:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C750E986622;
	Thu, 20 Apr 2023 12:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
From: David Edmondson <david.edmondson@oracle.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Date: Thu, 20 Apr 2023 13:46:47 +0100
Message-Id: <20230420124647.58488-3-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230420124647.58488-1-david.edmondson@oracle.com>
References: <20230420124647.58488-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_08,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=953 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200104
X-Proofpoint-GUID: ksYllhSDo0ezvzpmk1iCcXdzuXxs3eAY
X-Proofpoint-ORIG-GUID: ksYllhSDo0ezvzpmk1iCcXdzuXxs3eAY
Subject: [virtio-dev] [PATCH 2/2] virtio-net: Avoid abbreviating flag names

Use the full name for various flags when referencing them in the body
of the text.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 device-types/net/description.tex | 87 ++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index 8aa7953..106a1c7 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -472,14 +472,16 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 checksum includes the header), and \field{csum_offset} will be 16.
 \end{note}
 
-\item If the driver negotiated
-  VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO, and the packet requires
-  TCP segmentation, UDP segmentation or fragmentation, then \field{gso_type}
-  is set to VIRTIO_NET_HDR_GSO_TCPV4, TCPV6, UDP_L4 or UDP.
-  (Otherwise, it is set to VIRTIO_NET_HDR_GSO_NONE). In this
-  case, packets larger than 1514 bytes can be transmitted: the
-  metadata indicates how to replicate the packet header to cut it
-  into smaller packets. The other gso fields are set:
+\item If the driver negotiated VIRTIO_NET_F_HOST_TSO4,
+  VIRTIO_NET_F_HOST_TSO6, VIRTIO_NET_F_HOST_USO or
+  VIRTIO_NET_F_HOST_UFO, and the packet requires TCP segmentation, UDP
+  segmentation or fragmentation, then \field{gso_type} is set to
+  VIRTIO_NET_HDR_GSO_TCPV4, VIRTIO_NET_HDR_GSO_TCPV6,
+  VIRTIO_NET_HDR_GSO_UDP_L4 or VIRTIO_NET_HDR_GSO_UDP.  (Otherwise, it
+  is set to VIRTIO_NET_HDR_GSO_NONE). In this case, packets larger
+  than 1514 bytes can be transmitted: the metadata indicates how to
+  replicate the packet header to cut it into smaller packets. The
+  other gso fields are set:
 
   \begin{itemize}
   \item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
@@ -564,8 +566,9 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 	packet;
 \end{enumerate}
 
-If none of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
-been negotiated, the driver MUST set \field{gso_type} to
+If none of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
+VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have been
+negotiated, the driver MUST set \field{gso_type} to
 VIRTIO_NET_HDR_GSO_NONE.
 
 If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
@@ -573,8 +576,9 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 \field{flags} and MUST set \field{gso_size} to indicate the
 desired MSS.
 
-If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
-been negotiated:
+If one of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
+VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have been
+negotiated:
 \begin{itemize}
 \item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 	and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
@@ -600,8 +604,9 @@ \subsubsection{Packet Transmission}\label{sec:Device Types / Network Device / De
 If VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} is not set, the
 device MUST NOT use the \field{csum_start} and \field{csum_offset}.
 
-If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
-been negotiated:
+If one of the VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_TSO6,
+VIRTIO_NET_F_HOST_USO or VIRTIO_NET_F_HOST_UFO options have been
+negotiated:
 \begin{itemize}
 \item If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
 	and \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,
@@ -717,23 +722,26 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
   has been validated.
 \end{enumerate}
 
-Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN
-features enable receive checksum, large receive offload and ECN
-support which are the input equivalents of the transmit checksum,
-transmit segmentation offloading and ECN features, as described
-in \ref{sec:Device Types / Network Device / Device Operation /
-Packet Transmission}:
+Additionally, VIRTIO_NET_F_GUEST_CSUM, VIRTIO_NET_F_GUEST_TSO4,
+VIRTIO_NET_F_GUEST_TSO6, VIRTIO_NET_F_GUEST_UDP and
+VIRTIO_NET_F_GUEST_ECN features enable receive checksum, large receive
+offload and ECN support which are the input equivalents of the
+transmit checksum, transmit segmentation offloading and ECN features,
+as described in \ref{sec:Device Types / Network Device / Device
+  Operation / Packet Transmission}:
 \begin{enumerate}
-\item If the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options were
-  negotiated, then \field{gso_type} MAY be something other than
+\item If the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+  VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_USO4 or
+  VIRTIO_NET_F_GUEST_USO6 options were negotiated, then
+  \field{gso_type} MAY be something other than
   VIRTIO_NET_HDR_GSO_NONE, and \field{gso_size} field indicates the
   desired MSS (see Packet Transmission point 2).
-\item If the VIRTIO_NET_F_RSC_EXT option was negotiated (this
-  implies one of VIRTIO_NET_F_GUEST_TSO4, TSO6), the
-  device processes also duplicated ACK segments, reports
-  number of coalesced TCP segments in \field{csum_start} field and
-  number of duplicated ACK segments in \field{csum_offset} field
-  and sets bit VIRTIO_NET_HDR_F_RSC_INFO in \field{flags}.
+\item If the VIRTIO_NET_F_RSC_EXT option was negotiated (this implies
+  one of VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6), the device
+  processes also duplicated ACK segments, reports number of coalesced
+  TCP segments in \field{csum_start} field and number of duplicated
+  ACK segments in \field{csum_offset} field and sets bit
+  VIRTIO_NET_HDR_F_RSC_INFO in \field{flags}.
 \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
   set: if so, the packet checksum at offset \field{csum_offset}
@@ -809,9 +817,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 	fully checksummed packet;
 \end{enumerate}
 
-If none of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the device MUST set \field{gso_type} to
-VIRTIO_NET_HDR_GSO_NONE.
+If none of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_USO4 or
+VIRTIO_NET_F_GUEST_USO6 options have been negotiated, the device MUST
+set \field{gso_type} to VIRTIO_NET_HDR_GSO_NONE.
 
 If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
 the device MUST also set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
@@ -824,10 +833,11 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 If VIRTIO_NET_F_RSC_EXT was not negotiated, the device MUST
 not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
 
-If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the device SHOULD set \field{hdr_len} to a value
-not less than the length of the headers, including the transport
-header.
+If one of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_USO4 or
+VIRTIO_NET_F_GUEST_USO6 options have been negotiated, the device
+SHOULD set \field{hdr_len} to a value not less than the length of the
+headers, including the transport header.
 
 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
 device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
@@ -845,9 +855,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 if VIRTIO_NET_HDR_F_RSC_INFO bit \field{flags} is set, the
 driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
 
-If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
-transport header size.
+If one of the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
+VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_USO4 or
+VIRTIO_NET_F_GUEST_USO6 options have been negotiated, the driver MAY
+use \field{hdr_len} only as a hint about the transport header size.
 The driver MUST NOT rely on \field{hdr_len} to be correct.
 \begin{note}
 This is due to various bugs in implementations.
-- 
2.39.2 (Apple Git-143)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

