Return-Path: virtio-dev-return-4957-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82B83985E32
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Nov 2018 10:41:06 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:07:57 +0800
Message-Id: <1542276484-25508-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v9 1/8] bitmap: fix bitmap_count_one
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", which
makes bitmap_count_one fail to handle the "nbits=0" case. It appears to be
preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
implementation that it is ported from.

So this patch fixes bitmap_count_one to handle the nbits=0 case.

Inital Discussion Link:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg554316.html
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..679f1bd 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -221,6 +221,10 @@ static inline int bitmap_intersects(const unsigned long *src1,
 
 static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
     } else {
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

