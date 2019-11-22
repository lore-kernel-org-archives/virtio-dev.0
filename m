Return-Path: virtio-dev-return-6368-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60DEF985EB2
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:50:55 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:49 +0100
Message-Id: <20191122105000.800410-3-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 02/13] ACPI: Add VIOT definitions
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is temporary, until the VIOT table is published and these
definitions added to ACPICA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/actbl2.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced27f4c3..99c1d747e9d8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_IORT           "IORT"=09/* IO Remapping Table */
+#define ACPI_SIG_VIOT           "VIOT"=09/* Virtual I/O Table */
 #define ACPI_SIG_IVRS           "IVRS"=09/* I/O Virtualization Reporting S=
tructure */
 #define ACPI_SIG_LPIT           "LPIT"=09/* Low Power Idle Table */
 #define ACPI_SIG_MADT           "APIC"=09/* Multiple APIC Description Tabl=
e */
@@ -412,6 +413,36 @@ struct acpi_ivrs_memory {
 =09u64 memory_length;
 };
=20
+/*************************************************************************=
******
+ *
+ * VIOT - Virtual I/O Table
+ *        Version 1
+ *
+ *************************************************************************=
*****/
+
+struct acpi_table_viot {
+=09struct acpi_table_header header;
+=09u8 reserved[12];
+=09struct acpi_table_header base_table;
+};
+
+#define ACPI_VIOT_IORT_NODE_VIRTIO_PCI_IOMMU    0x80
+#define ACPI_VIOT_IORT_NODE_VIRTIO_MMIO_IOMMU   0x81
+
+struct acpi_viot_iort_virtio_pci_iommu {
+=09u32 devid;
+};
+
+struct acpi_viot_iort_virtio_mmio_iommu {
+=09u64 base_address;
+=09u64 span;
+=09u64 flags;
+=09u64 interrupt;
+};
+
+/* FIXME: rename this monstrosity. */
+#define ACPI_VIOT_IORT_VIRTIO_MMIO_IOMMU_CACHE_COHERENT (1<<0)
+
 /*************************************************************************=
******
  *
  * LPIT - Low Power Idle Table
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

