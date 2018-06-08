Return-Path: virtio-dev-return-4313-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DC6C958191AE
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 01:36:17 -0700 (PDT)
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:38 +0800
Message-Id: <1528445443-43406-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v8 1/6] bitmap: bitmap_count_one_with_offset
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Count the number of 1s in a bitmap starting from an offset.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/bitmap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..e3f31f1 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -228,6 +228,19 @@ static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
     }
 }
 
+static inline long bitmap_count_one_with_offset(const unsigned long *bitmap,
+                                                long offset, long nbits)
+{
+    long aligned_offset = QEMU_ALIGN_DOWN(offset, BITS_PER_LONG);
+    long redundant_bits = offset - aligned_offset;
+    long bits_to_count = nbits + redundant_bits;
+    const unsigned long *bitmap_start = bitmap +
+                                        aligned_offset / BITS_PER_LONG;
+
+    return bitmap_count_one(bitmap_start, bits_to_count) -
+           bitmap_count_one(bitmap_start, redundant_bits);
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

