Return-Path: <virtio-dev-return-13516-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7349DC001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D41FECB120
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C86C0986400
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B9CD298633E; Mon, 14 Aug 2023 11:29:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A00F698638E;
	Mon, 14 Aug 2023 11:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="351613538"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="351613538"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803432898"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803432898"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Tue, 15 Aug 2023 03:29:04 +0800
Message-Id: <20230814192904.30062-6-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814192904.30062-1-lingshan.zhu@intel.com>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

This patch adds two new le16 fields to common configruation structure
to support VIRTIO_F_QUEUE_STATE in PCI tranport layer.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 transport-pci.tex | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719..d9bccb0 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -321,6 +321,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_device;              /* read-write */
         le16 queue_notif_config_data;   /* read-only for driver */
         le16 queue_reset;               /* read-write */
+        le16 queue_avail_state;         /* read-write */
+        le16 queue_used_state;          /* read-write */
 
         /* About the administration virtqueue. */
         le16 admin_queue_index;         /* read-only for driver */
@@ -415,6 +417,16 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         This field exists only if VIRTIO_F_RING_RESET has been
         negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\item[\field{queue_avail_state}]
+        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
+        negotiated. The driver sets and gets the available state of
+        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
+
+\item[\field{queue_used_state}]
+        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
+        negotiated. The driver sets and gets the used state of the
+        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
+
 \item[\field{admin_queue_index}]
         The device uses this to report the index of the first administration virtqueue.
         This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
@@ -488,6 +500,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 present either a value of 0 or a power of 2 in
 \field{queue_size}.
 
+If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
+any accesses against \field{queue_avail_state} and \field{queue_used_state}.
+
 If VIRTIO_F_ADMIN_VQ has been negotiated, the value
 \field{admin_queue_index} MUST be equal to, or bigger than
 \field{num_queues}; also, \field{admin_queue_num} MUST be
-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

