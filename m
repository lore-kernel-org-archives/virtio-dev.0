Return-Path: virtio-dev-return-7685-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05A63985D38
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Aug 2020 03:10:27 +0000 (UTC)
From: David Stevens <stevensd@chromium.org>
Date: Wed, 19 Aug 2020 12:10:11 +0900
Message-Id: <20200819031011.310180-1-stevensd@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio: fix build for configs without dma-bufs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, David Stevens <stevensd@chromium.org>, kernel test robot <lkp@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/virtio/Kconfig  | 1 +
 drivers/virtio/Kconfig          | 7 +++++++
 drivers/virtio/Makefile         | 3 ++-
 drivers/virtio/virtio_dma_buf.c | 3 +++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfi=
g
index eff3047052d4..67624423013a 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -4,6 +4,7 @@ config DRM_VIRTIO_GPU
 =09depends on DRM && VIRTIO && MMU
 =09select DRM_KMS_HELPER
 =09select DRM_GEM_SHMEM_HELPER
+=09select VIRTIO_DMA_SHARED_BUFFER
 =09help
 =09   This is the virtual GPU driver for virtio.  It can be used with
 =09   QEMU based VMMs (like KVM or Xen).
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 5c92e4a50882..e76e9b9ba93c 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -126,4 +126,11 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
=20
 =09 If unsure, say 'N'.
=20
+config VIRTIO_DMA_SHARED_BUFFER
+=09tristate
+=09depends on DMA_SHARED_BUFFER
+=09help
+=09 This option adds a flavor of dma buffers that are backed by
+=09 virtio resources.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 49da768ee7fd..591e6f72aa54 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o virtio_dma_buf.o
+obj-$(CONFIG_VIRTIO) +=3D virtio.o virtio_ring.o
 obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) +=3D virtio_pci.o
 virtio_pci-y :=3D virtio_pci_modern.o virtio_pci_common.o
@@ -8,3 +8,4 @@ obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio_balloon.o
 obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) +=3D virtio_vdpa.o
 obj-$(CONFIG_VIRTIO_MEM) +=3D virtio_mem.o
+obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) +=3D virtio_dma_buf.o
diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_bu=
f.c
index 45d6e8647dcf..5127a2f0c986 100644
--- a/drivers/virtio/virtio_dma_buf.c
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Google, Inc.
  */
=20
+#include <linux/module.h>
 #include <linux/virtio_dma_buf.h>
=20
 /**
@@ -83,3 +84,5 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
 =09return ops->get_uuid(dma_buf, uuid);
 }
 EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
+
+MODULE_LICENSE("GPL");
--=20
2.28.0.220.ged08abb693-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

