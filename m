Return-Path: virtio-dev-return-5938-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96A02984399
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 13:14:09 +0000 (UTC)
From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 12 Aug 2019 09:13:56 -0400
Message-Id: <20190812131357.27312-1-nitesh@redhat.com>
In-Reply-To: <20190812131235.27244-1-nitesh@redhat.com>
References: <20190812131235.27244-1-nitesh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [QEMU Patch 1/2] virtio-balloon: adding bit for page reporting support
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com, mst@redhat.com, dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com, alexander.duyck@gmail.com, john.starks@microsoft.com, dave.hansen@intel.com, mhocko@suse.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch will be replaced once the feature is merged into the
Linux kernel.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/standard-headers/linux/virtio_balloon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2a70..1c5f6d6f2d 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

