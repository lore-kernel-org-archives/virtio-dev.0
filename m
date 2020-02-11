Return-Path: virtio-dev-return-6732-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4B8E985DB5
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 22:53:26 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 11 Feb 2020 14:53:18 -0800
Message-ID: <20200211225220.30596.80416.stgit@localhost.localdomain>
In-Reply-To: <20200211224416.29318.44077.stgit@localhost.localdomain>
References: <20200211224416.29318.44077.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v17 QEMU 4/3 RFC] memory: Add support for MADV_FREE as
 mechanism to lazy discard pages
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, willy@infradead.org, lcapitulino@redhat.com, dave.hansen@intel.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, mhocko@kernel.org, mgorman@techsingularity.net, alexander.h.duyck@linux.intel.com, vbabka@suse.cz, osalvador@suse.de
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add support for the MADV_FREE advice argument when discarding pages.
Specifically we add an option to perform a lazy discard for use with free
page reporting as this allows us to avoid expensive page zeroing in the
case that the system is not under memory pressure.

To enable this I simply extended the ram_block_discard_range function to
add an extra parameter for "lazy" freeing. I then renamed the function,
wrapped it in a function defined using the original name and defaulting
lazy to false. From there I created a second wrapper for
ram_block_free_range and updated the page reporting code to use that.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 exec.c                     |   39 +++++++++++++++++++++++++++------------
 hw/virtio/virtio-balloon.c |    2 +-
 include/exec/cpu-common.h  |    1 +
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18ea5..2266574eb06e 100644
--- a/exec.c
+++ b/exec.c
@@ -3881,15 +3881,8 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
-/*
- * Unmap pages of memory from start to start+length such that
- * they a) read as 0, b) Trigger whatever fault mechanism
- * the OS provides for postcopy.
- * The pages must be unmapped by the end of the function.
- * Returns: 0 on success, none-0 on failure
- *
- */
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+static int __ram_block_discard_range(RAMBlock *rb, uint64_t start,
+                                     size_t length, bool lazy)
 {
     int ret = -1;
 
@@ -3941,13 +3934,18 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
 #endif
         }
         if (need_madvise) {
-            /* For normal RAM this causes it to be unmapped,
+#ifdef CONFIG_MADVISE
+#ifdef MADV_FREE
+            int advice = (lazy && !need_fallocate) ? MADV_FREE : MADV_DONTNEED;
+#else
+            int advice = MADV_DONTNEED;
+#endif
+            /* For normal RAM this causes it to be lazy freed or unmapped,
              * for shared memory it causes the local mapping to disappear
              * and to fall back on the file contents (which we just
              * fallocate'd away).
              */
-#if defined(CONFIG_MADVISE)
-            ret =  madvise(host_startaddr, length, MADV_DONTNEED);
+            ret =  madvise(host_startaddr, length, advice);
             if (ret) {
                 ret = -errno;
                 error_report("ram_block_discard_range: Failed to discard range "
@@ -3975,6 +3973,23 @@ err:
     return ret;
 }
 
+/*
+ * Unmap pages of memory from start to start+length such that
+ * they a) read as 0, b) Trigger whatever fault mechanism
+ * the OS provides for postcopy.
+ * The pages must be unmapped by the end of the function.
+ * Returns: 0 on success, none-0 on failure
+ *
+ */
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+{
+    return __ram_block_discard_range(rb, start, length, false);
+}
+
+int ram_block_free_range(RAMBlock *rb, uint64_t start, size_t length)
+{
+    return __ram_block_discard_range(rb, start, length, true);
+}
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 5faafd2f62ac..7df92af73792 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -346,7 +346,7 @@ static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
             if ((ram_offset | size) & (rb_page_size - 1))
                 continue;
 
-            ram_block_discard_range(rb, ram_offset, size);
+            ram_block_free_range(rb, ram_offset, size);
         }
 
         virtqueue_push(vq, elem, 0);
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 81753bbb3431..2bbd26784c63 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -104,6 +104,7 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_free_range(RAMBlock *rb, uint64_t start, size_t length);
 
 #endif
 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

