Return-Path: <virtio-dev-return-13626-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1DEB8FA5
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:16:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A6D2479596
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:16:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97F0A9865F9
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:16:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8ACC69865C9; Wed,  6 Sep 2023 08:16:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71BBB9865D9;
	Wed,  6 Sep 2023 08:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374397905"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374397905"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741439884"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741439884"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com,
	stefanha@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Wed,  6 Sep 2023 16:16:33 +0800
Message-Id: <20230906081637.32185-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230906081637.32185-1-lingshan.zhu@intel.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 1/5] virtio: introduce vq state as basic facility

This patch adds new device facility to save and restore virtqueue
state. The virtqueue state is split into two parts:

- The available state: The state that is used for read the next
  available buffer.
- The used state: The state that is used for make buffer used.

This will simply the transport specific method implementation. E.g two
le16 could be used instead of a single le32). For split virtqueue, we
only need the available state since the used state is implemented in
the virtqueue itself (the used index). For packed virtqueue, we need
both the available state and the used state.

Those states are required to implement live migration support for
virtio device.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 content.tex | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..0e492cd 100644
--- a/content.tex
+++ b/content.tex
@@ -502,6 +502,71 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\section{Virtqueue State}\label{sec:Virtqueues / Virtqueue State}
+
+When VIRTIO_F_QUEUE_STATE has been negotiated, the driver can set and
+get the device internal virtqueue state through the following
+fields. The implementation of the interfaces is transport specific.
+
+\subsection{\field{Available State} Field}
+
+The available state field is two bytes of virtqueue state that is used by
+the device to read the next available buffer.
+
+When VIRTIO_RING_F_PACKED is not negotiated, it contains:
+
+\begin{lstlisting}
+le16 last_avail_idx;
+\end{lstlisting}
+
+The \field{last_avail_idx} field is the free-running available ring
+index where the device will read the next available head of a
+descriptor chain.
+
+See also \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}.
+
+When VIRTIO_RING_F_PACKED is negotiated, it contains:
+
+\begin{lstlisting}
+le16 {
+  last_avail_idx : 15;
+  last_avail_wrap_counter : 1;
+};
+\end{lstlisting}
+
+The \field{last_avail_idx} field is the free-running location
+where the device read the next descriptor from the virtqueue descriptor ring.
+
+The \field{last_avail_wrap_counter} field is the last driver ring wrap
+counter that was observed by the device.
+
+See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
+
+\subsection{\field{Used State} Field}
+
+The used state field is two bytes of virtqueue state that is used by
+the device when marking a buffer used.
+
+When VIRTIO_RING_F_PACKED is negotiated, the used state contains:
+
+\begin{lstlisting}
+le16 {
+  used_idx : 15;
+  used_wrap_counter : 1;
+};
+\end{lstlisting}
+
+The \field{used_idx} field is the free-running location where the device write the next
+used descriptor to the descriptor ring.
+
+The \field{used_wrap_counter} field is the wrap counter that is used
+by the device.
+
+See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
+
+When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
+is always 0
+
 \input{admin.tex}
 
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

