Return-Path: virtio-dev-return-7693-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BC15985E85
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:12 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:35 +0200
Message-Id: <20200821131540.2801801-2-jean-philippe@linaro.org>
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 1/6] iommu/virtio: Move to drivers/iommu/virtio/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Before adding new files to the virtio-iommu driver, move it to its own
subfolder, similarly to other IOMMU drivers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Makefile                    | 3 +--
 drivers/iommu/virtio/Makefile             | 2 ++
 drivers/iommu/{ =3D> virtio}/virtio-iommu.c | 0
 MAINTAINERS                               | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/virtio/Makefile
 rename drivers/iommu/{ =3D> virtio}/virtio-iommu.c (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..fc7523042512 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y +=3D amd/ intel/ arm/
+obj-y +=3D amd/ intel/ arm/ virtio/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
@@ -26,4 +26,3 @@ obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
-obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
new file mode 100644
index 000000000000..279368fcc074
--- /dev/null
+++ b/drivers/iommu/virtio/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio/virtio-iom=
mu.c
similarity index 100%
rename from drivers/iommu/virtio-iommu.c
rename to drivers/iommu/virtio/virtio-iommu.c
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..3602b223c9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18451,7 +18451,7 @@ VIRTIO IOMMU DRIVER
 M:=09Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:=09virtualization@lists.linux-foundation.org
 S:=09Maintained
-F:=09drivers/iommu/virtio-iommu.c
+F:=09drivers/iommu/virtio/
 F:=09include/uapi/linux/virtio_iommu.h
=20
 VIRTIO MEM DRIVER
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

