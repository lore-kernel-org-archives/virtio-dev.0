Return-Path: virtio-dev-return-5117-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7C4C985E8B
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Dec 2018 10:51:27 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Tue,  4 Dec 2018 18:49:29 +0800
Message-Id: <20181204104929.21586-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2] packed-ring: fix example code
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Driver can't just check whether USED bit equals to the used
wrap counter when checking whether a descriptor is a used
descriptor. Below is an example:

Assuming ring size is 4, ring's initial state will be:

+----+----+----+----+
| 00 | 00 | 00 | 00 |
+----+----+----+----+

00 means AVAIL=0 USED=0, 01 means AVAIL=0 USED=1
10 means AVAIL=1 USED=0, 11 means AVAIL=1 USED=1

After driver made two descriptor chains available and each
chain consists of two descriptors, the ring could be:

+----+-----------+----+-----------+
| 10 | 10 (id=0) | 10 | 10 (id=1) |
+----+-----------+----+-----------+

After device processed all the available descriptors and made
them used (e.g. in order), the ring could be:

+-----------+----+-----------+----+
| 11 (id=0) | 10 | 11 (id=1) | 10 |
+-----------+----+-----------+----+

After driver processed all the used descriptors and made
one descriptor (not chained, just one descriptor) available,
the ring could be:

+-----------+----+----+----+
| 01 (id=0) | 10 | 11 | 10 |
+-----------+----+----+----+

After device made that descriptor used, the ring will be:

+-----------+----+----+----+
| 00 (id=0) | 10 | 11 | 10 |
+-----------+----+----+----+

If driver just checks whether USED bit equals to the used
wrap counter when checking whether a descriptor is a used
descriptor, after processing the first descriptor (whose
AVAIL and USED bits are both 0), and advancing vq->next_used
pointer, it will then also treat the next descriptor, i.e.
the second descriptor (whose AVAIL and USED bits are 1 and
0 respectively) as a used descriptor which is wrong. The
most straightforward way to fix it is to also check whether
AVAIL bit equals to USED bit.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/29
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
v2:
- Add "Fixes" tag;
- Refine commit log;

 packed-ring.tex | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index f24f49b..c913768 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -688,15 +688,17 @@ for (;;) {
         struct pvirtq_desc *d = vq->desc[vq->next_used];
 
         flags = d->flags;
+        bool avail = flags & VIRTQ_DESC_F_AVAIL;
         bool used = flags & VIRTQ_DESC_F_USED;
 
-        if (used != vq->used_wrap_count) {
+        if (avail != used || used != vq->used_wrap_count) {
                 vq->driver_event.flags = RING_EVENT_FLAGS_ENABLE;
                 memory_barrier();
 
                 flags = d->flags;
+                bool avail = flags & VIRTQ_DESC_F_AVAIL;
                 bool used = flags & VIRTQ_DESC_F_USED;
-                if (used != vq->used_wrap_count) {
+                if (avail != used || used != vq->used_wrap_count) {
                         break;
                 }
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

