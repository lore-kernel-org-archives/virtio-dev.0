Return-Path: virtio-dev-return-5966-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2ADF985E4D
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 12:51:41 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
Date: Tue, 13 Aug 2019 18:21:33 +0530
Message-Id: <20190813125133.19754-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] content: document console vq detach buffer
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, amit@kernel.org, pagupta@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch documents console special case where vq buffers
are deleted at port hotunplug time. This behavior is different in
other devices where vq buffers are deleted at device unplug time.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index ee0d7c9..33e8ccc 100644
--- a/content.tex
+++ b/content.tex
@@ -497,6 +497,8 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 of a live virtqueue.
 
 Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
+Console has a special property that when port is detached virtqueue is considered stopped, device
+must not use any buffers, and it is legal to take buffers out of the device.
 
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

