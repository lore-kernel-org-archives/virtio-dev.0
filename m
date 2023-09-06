Return-Path: <virtio-dev-return-13627-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23928EB8FA5
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AFAE3F3F40
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A00059865F6
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:17:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 947469865C9; Wed,  6 Sep 2023 08:17:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 800799865D0;
	Wed,  6 Sep 2023 08:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374397903"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374397903"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741439853"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741439853"
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	cohuck@redhat.com,
	stefanha@redhat.com
Cc: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>
Date: Wed,  6 Sep 2023 16:16:32 +0800
Message-Id: <20230906081637.32185-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

This series introduces
1)a new SUSPEND bit in the device status
Which is used to suspend the device, so that the device states
and virtqueue states are stabilized.

2)virtqueue state and its accessor, to get and set last_avail_idx
and last_used_idx of virtqueues.

The main usecase of these new facilities is Live Migration.

Future work: dirty page tracking and in-flight descriptors.

This series addresses many comments from Jason, Stefan and Eugenio
from RFC series.

Zhu Lingshan (5):
  virtio: introduce vq state as basic facility
  virtio: introduce SUSPEND bit in device status
  virtqueue: constraints for virtqueue state
  virtqueue: ignore resetting vqs when SUSPEND
  virtio-pci: implement VIRTIO_F_QUEUE_STATE

 content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
 transport-pci.tex |  18 +++++++
 2 files changed, 136 insertions(+)

-- 
2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

