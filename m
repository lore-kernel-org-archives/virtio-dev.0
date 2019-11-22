Return-Path: virtio-dev-return-6376-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E6C3985FF6
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:51:09 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:58 +0100
Message-Id: <20191122105000.800410-12-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 11/13] ACPI: Add VIOT table
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add support for a new ACPI table that embeds other tables describing a
platform's IOMMU topology. Currently the only supported base table is
IORT. The VIOT contains an IORT with additional node types, that
describe a virtio-iommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/Kconfig      |  4 ++++
 drivers/acpi/Makefile     |  1 +
 drivers/acpi/bus.c        |  2 ++
 drivers/acpi/tables.c     |  2 +-
 drivers/acpi/viot.c       | 44 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig     |  1 +
 include/linux/acpi_viot.h | 20 ++++++++++++++++++
 7 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/viot.c
 create mode 100644 include/linux/acpi_viot.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 548976c8b2b0..513a5e4d3526 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -579,6 +579,10 @@ config TPS68470_PMIC_OPREGION
 config ACPI_IORT
 =09bool
=20
+config ACPI_VIOT
+=09bool
+=09select ACPI_IORT
+
 endif=09# ACPI
=20
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9d1792165713..6abdc6cc32c7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -124,3 +124,4 @@ obj-y=09=09=09=09+=3D dptf/
=20
 obj-$(CONFIG_ARM64)=09=09+=3D arm64/
 obj-$(CONFIG_ACPI_IORT) =09+=3D iort.o
+obj-$(CONFIG_ACPI_VIOT)=09=09+=3D viot.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 48bc96d45bab..6f364e0c9240 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
 #include <linux/suspend.h>
@@ -1246,6 +1247,7 @@ static int __init acpi_init(void)
=20
 =09pci_mmcfg_late_init();
 =09acpi_iort_init();
+=09acpi_viot_init();
 =09acpi_scan_init();
 =09acpi_ec_init();
 =09acpi_debugfs_init();
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 180ac4329763..9662ea5e1064 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -501,7 +501,7 @@ static const char * const table_sigs[] =3D {
 =09ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 =09ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 =09ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-=09NULL };
+=09ACPI_SIG_VIOT, NULL };
=20
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
=20
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
new file mode 100644
index 000000000000..ab9a6e43ad9b
--- /dev/null
+++ b/drivers/acpi/viot.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Linaro
+ *
+ * Virtual IOMMU table
+ */
+#define pr_fmt(fmt)=09"ACPI: VIOT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
+
+int __init acpi_viot_init(void)
+{
+=09struct acpi_table_viot *viot;
+=09struct acpi_table_header *acpi_header;
+=09acpi_status status;
+
+=09status =3D acpi_get_table(ACPI_SIG_VIOT, 0, &acpi_header);
+=09if (ACPI_FAILURE(status)) {
+=09=09if (status !=3D AE_NOT_FOUND) {
+=09=09=09const char *msg =3D acpi_format_exception(status);
+
+=09=09=09pr_err("Failed to get table, %s\n", msg);
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09return 0;
+=09}
+
+=09if (acpi_header->length < sizeof(*viot)) {
+=09=09pr_err("VIOT table overflow, bad table!\n");
+=09=09return -EINVAL;
+=09}
+
+=09viot =3D (struct acpi_table_viot *)acpi_header;
+=09if (ACPI_COMPARE_NAMESEG(viot->base_table.signature, ACPI_SIG_IORT)) {
+=09=09acpi_iort_register_table(&viot->base_table, IORT_SOURCE_VIOT);
+=09=09return 0;
+=09}
+
+=09pr_err("Unknown base table header\n");
+=09return -EINVAL;
+}
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..e6eb4f238d1a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -480,6 +480,7 @@ config VIRTIO_IOMMU
 =09depends on ARM64
 =09select IOMMU_API
 =09select INTERVAL_TREE
+=09select ACPI_VIOT if ACPI
 =09help
 =09  Para-virtualised IOMMU driver with virtio.
=20
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
new file mode 100644
index 000000000000..6c282d5eb793
--- /dev/null
+++ b/include/linux/acpi_viot.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 Linaro
+ */
+
+#ifndef __ACPI_VIOT_H__
+#define __ACPI_VIOT_H__
+
+#ifdef CONFIG_ACPI_VIOT
+
+int acpi_viot_init(void);
+
+#else /* !CONFIG_ACPI_VIOT */
+
+static inline int acpi_viot_init(void)
+{}
+
+#endif /* !CONFIG_ACPI_VIOT */
+
+#endif /* __ACPI_VIOT_H__ */
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

