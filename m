Return-Path: virtio-dev-return-3055-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F20EA581911B
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jan 2018 20:04:35 -0800 (PST)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 25 Jan 2018 12:03:27 +0800
Message-Id: <20180125040328.22867-6-tiwei.bie@intel.com>
In-Reply-To: <20180125040328.22867-1-tiwei.bie@intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v1 5/6] vfio: remove DPRINTF() definition from vfio-common.h
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This macro isn't used by any VFIO code. And its name is
too generic. The vfio-common.h (in include/hw/vfio) can
be included by other modules in QEMU. It can introduce
conflicts.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 include/hw/vfio/vfio-common.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 2383ded670..3fe99636f3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -33,15 +33,6 @@
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "
 
-/*#define DEBUG_VFIO*/
-#ifdef DEBUG_VFIO
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
-- 
2.13.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

