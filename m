Return-Path: <virtio-dev-return-13511-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58577C001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B6701F3F7A
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9A74698638A
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 11:29:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 892C0983F78; Mon, 14 Aug 2023 11:29:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 776DA98633D;
	Mon, 14 Aug 2023 11:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="351613507"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="351613507"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803432815"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803432815"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Tue, 15 Aug 2023 03:28:59 +0800
Message-Id: <20230814192904.30062-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH 0/5] virtio: introduce SUSPEND bit and vq state

This seires introduces
1)a new SUSPEND bit in the device status
Which is used to suspend the device, so that the device states
and virtqueue states are stablized.

2)virtqueue state and accessors, to get and set last_avail_idx
and last_used_idx of virtqueues.

The main usecase of these new facilities is Live Migration.

Furture work: dirty page tracking and in-flight descriptors.

This is RFC, this series carries on Jason and Eugenio's pervious work.

Any comments are welcome.

Zhu Lingshan (5):
  virtio: introduce SUSPEND bit in device status
  virtio: introduce vq state as basic facility
  virtio: The actions by the device upon SUSPEND
  virtqueue: constraints for virtqueue state
  virtio-pci: implement VIRTIO_F_QUEUE_STATE

 content.tex       | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 transport-pci.tex |  15 ++++++
 2 files changed, 135 insertions(+)

-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

