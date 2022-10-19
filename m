Return-Path: <virtio-dev-return-10034-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 430AD986569
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Oct 2022 01:32:44 +0000 (UTC)
Message-ID: <9b6d4dfb-39ca-1f46-3487-680267557d24@linux.alibaba.com>
Date: Wed, 19 Oct 2022 09:32:39 +0800
MIME-Version: 1.0
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: [virtio-dev] [PATCH] virtio-net: support timestamp received packet
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces VIRTIO_NET_F_RX_TSTAMP to enhance the 
observability of network packet delay between virtio device and virtio 
driver.

We have encountered many network jitter problems from virtio device to 
virtio driver in the production environment. Due to the lack of relevant 
indicators in this path, we often spend a lot of energy to locate such 
problems. If the virtio device can provide the packet receiving 
timestamp, then we can easily calculate the network jitter index between 
the virtio device and the virtio driver. When such a problem is 
encountered again, it is easy to determine the problem boundary.

Thanks and looking forward to your response!

Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
  content.tex | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/content.tex b/content.tex
index e863709..472acf3 100644
--- a/content.tex
+++ b/content.tex
@@ -3097,6 +3097,8 @@ \subsection{Feature bits}\label{sec:Device Types / 
Network Device / Feature bits
  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
      value and a type of calculated hash.

+\item[VIRTIO_NET_F_RX_TSTAMP(58)] Device can timestamp received packet.
+
  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact 
\field{hdr_len}
      value. Device benefits from knowing the exact header length.

@@ -3371,6 +3373,7 @@ \subsection{Device Operation}\label{sec:Device 
Types / Network Device / Device O
  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
  #define VIRTIO_NET_HDR_F_DATA_VALID    2
  #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_TSTAMP        8
          u8 flags;
  #define VIRTIO_NET_HDR_GSO_NONE        0
  #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -3387,6 +3390,7 @@ \subsection{Device Operation}\label{sec:Device 
Types / Network Device / Device O
          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT 
negotiated)
          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT 
negotiated)
          le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT 
negotiated)
+        le64 tstamp;            (Only if VIRITO_NET_F_RX_TSTAMP negotiated)
  };
  \end{lstlisting}

@@ -3809,6 +3813,13 @@ \subsubsection{Processing of Incoming 
Packets}\label{sec:Device Types / Network
  checksum (in case of multiple encapsulated protocols, one level
  of checksums is validated).

+If VIRTIO_NET_F_RX_TSTAMP was not negotiated, the device MUST not set
+VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags}.
+
+If VIRTIO_NET_F_RX_TSTAMP was negotiated, the device MUST also
+set VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags},
+set \field{tstamp} to time to receive the packet.
+
  \drivernormative{\paragraph}{Processing of Incoming
  Packets}{Device Types / Network Device / Device Operation /
  Processing of Incoming Packets}
@@ -3831,6 +3842,9 @@ \subsubsection{Processing of Incoming 
Packets}\label{sec:Device Types / Network
  VIRTIO_NET_HDR_F_DATA_VALID is set, the driver MUST NOT
  rely on the packet checksum being correct.

+If VIRTIO_NET_HDR_F_TSTAMP bit in \field{flags} is not set, the
+driver MUST NOT use the \field{tstamp}.
+
  \paragraph{Hash calculation for incoming packets}
  \label{sec:Device Types / Network Device / Device Operation / 
Processing of Incoming Packets / Hash calculation for incoming packets}

-- 
2.27.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

