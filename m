Return-Path: virtio-dev-return-4771-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2921985D02
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Aug 2018 09:00:43 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  3 Aug 2018 16:32:24 +0800
Message-Id: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 0/2] virtio-balloon: some improvements
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, penguin-kernel@I-love.SAKURA.ne.jp
Cc: wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

ChangeLog:
v2->v3:
- shrink the balloon pages according to the amount requested by the
  claimer, instead of using a user specified number;
v1->v2:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
  negotiated.

Wei Wang (2):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 121 ++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

