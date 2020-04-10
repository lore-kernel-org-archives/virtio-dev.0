Return-Path: virtio-dev-return-7047-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E603E985FE3
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Apr 2020 03:41:52 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 09 Apr 2020 20:41:50 -0700
Message-ID: <20200410034150.24738.98143.stgit@localhost.localdomain>
In-Reply-To: <20200410033729.24738.22879.stgit@localhost.localdomain>
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v19 QEMU 4/4] memory: Do not allow direct write access to
 rom_device regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: pbonzini@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

According to the documentation in memory.h a ROM memory region will be
backed by RAM for reads, but is supposed to go through a callback for
writes. Currently we were not checking for the existence of the rom_device
flag when determining if we could perform a direct write or not.

To correct that add a check to memory_region_is_direct so that if the
memory region has the rom_device flag set we will return false for all
checks where is_write is set.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/exec/memory.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1614d9a02c0c..e000bd2f97b2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegionCache *cache,
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
     if (is_write) {
-        return memory_region_is_ram(mr) &&
-               !mr->readonly && !memory_region_is_ram_device(mr);
+        return memory_region_is_ram(mr) && !mr->readonly &&
+               !mr->rom_device && !memory_region_is_ram_device(mr);
     } else {
         return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
                memory_region_is_romd(mr);


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

