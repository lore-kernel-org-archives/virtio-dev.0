Return-Path: <virtio-dev-return-13630-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE19EB8FA5
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12FBC3711C
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C74798662A
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00BAF9865D9; Wed,  6 Sep 2023 08:17:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E69A89865EB;
	Wed,  6 Sep 2023 08:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374397953"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374397953"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741439960"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741439960"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com,
	stefanha@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Wed,  6 Sep 2023 16:16:37 +0800
Message-Id: <20230906081637.32185-6-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230906081637.32185-1-lingshan.zhu@intel.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

This patch adds two new le16 fields to common configuration structure
to support VIRTIO_F_QUEUE_STATE in PCI transport layer.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 transport-pci.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..3161519 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -325,6 +325,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         /* About the administration virtqueue. */
         le16 admin_queue_index;         /* read-only for driver */
         le16 admin_queue_num;         /* read-only for driver */
+
+	/* Virtqueue state */
+        le16 queue_avail_state;         /* read-write */
+        le16 queue_used_state;          /* read-write */
 };
 \end{lstlisting}
 
@@ -428,6 +432,17 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 	The value 0 indicates no supported administration virtqueues.
 	This field is valid only if VIRTIO_F_ADMIN_VQ has been
 	negotiated.
+
+\item[\field{queue_avail_state}]
+        This field is valid only if VIRTIO_F_QUEUE_STATE has been
+        negotiated. The driver sets and gets the available state of
+        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
+
+\item[\field{queue_used_state}]
+        This field is valid only if VIRTIO_F_QUEUE_STATE has been
+        negotiated. The driver sets and gets the used state of the
+        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
+
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -488,6 +503,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 present either a value of 0 or a power of 2 in
 \field{queue_size}.
 
+If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
+any accesses to \field{queue_avail_state} and \field{queue_used_state}.
+
 If VIRTIO_F_ADMIN_VQ has been negotiated, the value
 \field{admin_queue_index} MUST be equal to, or bigger than
 \field{num_queues}; also, \field{admin_queue_num} MUST be
-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

