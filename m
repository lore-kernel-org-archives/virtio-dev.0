Return-Path: virtio-dev-return-4743-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B652D985CA1
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 09:52:48 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 27 Jul 2018 17:24:53 +0800
Message-Id: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v2 0/2] virtio-balloon: some improvements
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This series is split from the "Virtio-balloon: support free page
reporting" series to make some improvements.

v1->v2 ChangeLog:
- register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is negotiated.

Wei Wang (2):
  virtio-balloon: remove BUG() in init_vqs
  virtio_balloon: replace oom notifier with shrinker

 drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 53 deletions(-)

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

