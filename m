Return-Path: virtio-dev-return-4045-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 437C158191B2
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 04:25:22 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon,  7 May 2018 14:24:56 +0300
Message-Id: <20180507112457.14134-4-sameeh@daynix.com>
In-Reply-To: <20180507112457.14134-1-sameeh@daynix.com>
References: <20180507112457.14134-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v5 3/4] content: net: Add VIRTIO_NET_F_HASH_OFFLOAD feature
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

This commit introduces hash offload support into network device. The device
calculates hashes for packets all the time and especially when it uses
multiqueue, these hash values can be very useful for the driver and OS in some
cases.

This feature allows the delivery of the calculated hash to the driver.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 content.tex | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/content.tex b/content.tex
index 850844e..c8add9b 100644
--- a/content.tex
+++ b/content.tex
@@ -3116,6 +3116,9 @@ features.
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
 
+\item[VIRTIO_NET_F_HASH_OFFLOAD(61)] Device supports supplying packet's
+    hash value to the driver.
+
 \item[VIRTIO_NET_F_CTRL_STEERING_MODE(60)] Device supports configurable steering
     mode.
 \end{description}
@@ -3320,6 +3323,7 @@ struct virtio_net_hdr {
         le16 csum_start;
         le16 csum_offset;
         le16 num_buffers;
+// Only if VIRTIO_NET_F_HASH_OFFLOAD has been negotiated
         le64 hash;
 };
 \end{lstlisting}
@@ -4017,6 +4021,25 @@ MUST format \field{virtqueue_pairs}
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
 
+\paragraph{Hash offload}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Hash offload}
+
+If the driver negotiates the feature bit VIRTIO_NET_F_HASH_OFFLOAD, the device
+MUST provide the driver with the hash values used for distributing the packets
+among the receive queues.
+
+If this feature has been negotiated, the virtio net header has an additional
+\field{hash} field attached to it.
+
+\drivernormative{\subparagraph}{Hash offload}{Device Types / Network Device / Device Operation / Control Virtqueue / Hash offload}
+
+If the VIRTIO_NET_F_HASH_OFFLOAD feature has been successfully negotiated the,
+driver can access and use the \field{hash} field in the virtio net header.
+
+\devicenormative{\subparagraph}{Hash offload}{Device Types / Network Device / Device Operation / Control Virtqueue / Hash offload}
+
+If the VIRTIO_NET_F_HASH_OFFLOAD feature has been successfully negotiated, the
+device MUST supply the hash value for each packet in the \field{hash} field.
+
 \paragraph{Steering mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode}
 
 \begin{lstlisting}
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

