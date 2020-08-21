Return-Path: virtio-dev-return-7695-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A59C985E87
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Aug 2020 13:16:16 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 21 Aug 2020 15:15:38 +0200
Message-Id: <20200821131540.2801801-5-jean-philippe@linaro.org>
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 4/6] iommu/virtio: Add topology definitions
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add struct definitions for describing endpoints managed by the
virtio-iommu. When VIRTIO_IOMMU_F_TOPOLOGY is offered, an array of
virtio_iommu_topo_* structures in config space describes the endpoints,
identified either by their PCI BDF or their physical MMIO address.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_=
iommu.h
index 237e36a280cb..70cba30644d5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS=09=09=093
 #define VIRTIO_IOMMU_F_PROBE=09=09=094
 #define VIRTIO_IOMMU_F_MMIO=09=09=095
+#define VIRTIO_IOMMU_F_TOPOLOGY=09=09=096
=20
 struct virtio_iommu_range_64 {
 =09__le64=09=09=09=09=09start;
@@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
 =09__le32=09=09=09=09=09end;
 };
=20
+struct virtio_iommu_topo_config {
+=09/* Number of topology description structures */
+=09__le16=09=09=09=09=09count;
+=09/*
+=09 * Offset to the first topology description structure
+=09 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
+=09 * space. Aligned on 8 bytes.
+=09 */
+=09__le16=09=09=09=09=09offset;
+};
+
 struct virtio_iommu_config {
 =09/* Supported page sizes */
 =09__le64=09=09=09=09=09page_size_mask;
@@ -36,6 +48,38 @@ struct virtio_iommu_config {
 =09struct virtio_iommu_range_32=09=09domain_range;
 =09/* Probe buffer size */
 =09__le32=09=09=09=09=09probe_size;
+=09struct virtio_iommu_topo_config=09=09topo_config;
+};
+
+#define VIRTIO_IOMMU_TOPO_PCI_RANGE=09=090x1
+#define VIRTIO_IOMMU_TOPO_MMIO=09=09=090x2
+
+struct virtio_iommu_topo_pci_range {
+=09/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
+=09__u8=09=09=09=09=09type;
+=09__u8=09=09=09=09=09reserved;
+=09/* Length of this structure */
+=09__le16=09=09=09=09=09length;
+=09/* First endpoint ID in the range */
+=09__le32=09=09=09=09=09endpoint_start;
+=09/* PCI domain number */
+=09__le16=09=09=09=09=09segment;
+=09/* PCI Bus:Device.Function range */
+=09__le16=09=09=09=09=09bdf_start;
+=09__le16=09=09=09=09=09bdf_end;
+=09__le16=09=09=09=09=09padding;
+};
+
+struct virtio_iommu_topo_mmio {
+=09/* VIRTIO_IOMMU_TOPO_MMIO */
+=09__u8=09=09=09=09=09type;
+=09__u8=09=09=09=09=09reserved;
+=09/* Length of this structure */
+=09__le16=09=09=09=09=09length;
+=09/* Endpoint ID */
+=09__le32=09=09=09=09=09endpoint;
+=09/* Address of the first MMIO region */
+=09__le64=09=09=09=09=09address;
 };
=20
 /* Request types */
--=20
2.28.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

