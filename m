Return-Path: <virtio-dev-return-13515-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EDBC001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 93E3671CAE
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 887839863F0
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7C82098633E; Mon, 14 Aug 2023 11:29:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54FD698657D;
	Mon, 14 Aug 2023 11:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="351613534"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="351613534"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803432880"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803432880"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Tue, 15 Aug 2023 03:29:03 +0800
Message-Id: <20230814192904.30062-5-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814192904.30062-1-lingshan.zhu@intel.com>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH 4/5] virtqueue: constraints for virtqueue state

This commit specifies the constraints of the virtqueue state,
and the actions should be taken by the device when SUSPEND
and DRIVER_OK is set

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 content.tex | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/content.tex b/content.tex
index 43bd5de..f6ac581 100644
--- a/content.tex
+++ b/content.tex
@@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
 
 See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}.
 
+\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
+
+If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SUSPEND in \field{device status}
+first before getting or setting Virtqueue State of any virtqueues.
+
+If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKED not been negotiated,
+the driver MUST NOT access \field{Used State} of any virtqueues, it should use the
+used index in the used ring.
+
+\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
+
+If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in \field{device status},
+the device MUST ignore any accesses against Virtqueue State of any virtqueues.
+
+When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED is not,
+the device MUST ignore any accesses against \field{Used State}.
+
+If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
+the Virtqueue State of every virtqueue upon a reset.
+
+If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negotiaged, when SUSPEND is set,
+the device MUST record the Virtqueue State of every enabled virtqueue
+in \field{Available State} and \field{Used State} respectively,
+and correspondingly restore the Virtqueue State of every enabled virtqueue
+from \field{Avaiable State} and \field{Used State} when DRIVER_OK is set.
+
+If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED has been not, when SUSPEND is set,
+the device MUST record the available state of every enabled virtqueue in \field{Available State},
+and restore the available state of every enabled virtqueue from \field{Avaiable State}
+when DRIVER_OK is set.
+
 \input{admin.tex}
 
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

