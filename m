Return-Path: virtio-dev-return-4955-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD153985DD9
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Nov 2018 11:00:51 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 13 Nov 2018 18:27:45 +0800
Message-Id: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 0/2] Virtio-balloon Updates
To: virtio-dev@lists.oasis-open.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series adds 2 features to the virtio-balloon spec.
The VIRTIO_BALLOON_F_FREE_PAGE_HINT feature supports guest to report
free page hints to host.
The VIRTIO_BALLOON_F_PAGE_POISON feature supports guest to report the
memory poison value to host.

Wei Wang (2):
  content/virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  content/virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 content.tex | 140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 6 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

