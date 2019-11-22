Return-Path: virtio-dev-return-6371-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2AA9985F32
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:50:58 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:50 +0100
Message-Id: <20191122105000.800410-4-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 03/13] ACPI/IORT: Allow registration of external tables
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add a function to register an IORT table from an external source.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c       | 22 ++++++++++++++++++++--
 include/linux/acpi_iort.h | 10 ++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index d62a9ea26fae..9c6c91e06f8f 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -144,6 +144,7 @@ typedef acpi_status (*iort_find_node_callback)
=20
 /* Root pointer to the mapped IORT table */
 static struct acpi_table_header *iort_table;
+static enum iort_table_source iort_table_source;
=20
 static LIST_HEAD(iort_msi_chip_list);
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
@@ -1617,11 +1618,28 @@ static void __init iort_init_platform_devices(void)
 =09}
 }
=20
+void __init acpi_iort_register_table(struct acpi_table_header *table,
+=09=09=09=09     enum iort_table_source source)
+{
+=09/*
+=09 * Firmware or hypervisor should know better than give us two IORT
+=09 * tables.
+=09 */
+=09if (WARN_ON(iort_table))
+=09=09return;
+
+=09iort_table =3D table;
+=09iort_table_source =3D source;
+
+=09iort_init_platform_devices();
+}
+
 void __init acpi_iort_init(void)
 {
 =09acpi_status status;
+=09static struct acpi_table_header *table;
=20
-=09status =3D acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
+=09status =3D acpi_get_table(ACPI_SIG_IORT, 0, &table);
 =09if (ACPI_FAILURE(status)) {
 =09=09if (status !=3D AE_NOT_FOUND) {
 =09=09=09const char *msg =3D acpi_format_exception(status);
@@ -1632,5 +1650,5 @@ void __init acpi_iort_init(void)
 =09=09return;
 =09}
=20
-=09iort_init_platform_devices();
+=09acpi_iort_register_table(table, IORT_SOURCE_IORT);
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..f4db5fff07cf 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -11,6 +11,11 @@
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
=20
+enum iort_table_source {
+=09IORT_SOURCE_IORT,=09/* The Real Thing */
+=09IORT_SOURCE_VIOT,=09/* Paravirtual extensions */
+};
+
 #define IORT_IRQ_MASK(irq)=09=09(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)=09((irq >> 32) & 0xffffffffULL)
=20
@@ -27,6 +32,8 @@ int iort_register_domain_token(int trans_id, phys_addr_t =
base,
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
+void acpi_iort_register_table(struct acpi_table_header *table,
+=09=09=09      enum iort_table_source source);
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
@@ -37,6 +44,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u6=
4 *size);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *=
head);
 #else
+static void acpi_iort_register_table(struct acpi_table_header *table,
+=09=09=09=09     enum iort_table_source source)
+{ }
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

