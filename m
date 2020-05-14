Return-Path: virtio-dev-return-7331-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83434985FC2
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 07:52:52 +0000 (UTC)
From: Bharat Bhushan <bbhushan2@marvell.com>
Date: Thu, 14 May 2020 13:22:37 +0530
Message-ID: <20200514075237.3941-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6] iommu/virtio: Use page size bitmap supported by endpoint
Content-Type: text/plain
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, jean-philippe@linaro.org, joro@8bytes.org, mst@redhat.com, jasowang@redhat.com, eric.auger.pro@gmail.com, eric.auger@redhat.com
Cc: Bharat Bhushan <bbhushan2@marvell.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Different endpoint can support different page size, probe
endpoint if it supports specific page size otherwise use
global page sizes.

Device attached to domain should support a minimum of
domain supported page sizes. If device supports more
than domain supported page sizes then device is limited
to use domain supported page sizes only.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v5->v6
 - property length before dereference
 - Error out on no supported page sizes (page-size-mask is zero)
 - Allow device to attach to domain even it supports
   minimum of domain supported page sizes. In that case device
   will use domain page sizes only.
 - added format of pgsize_bitmap

v4->v5:
 - Rebase to Linux v5.7-rc4

v3->v4:
 - Fix whitespace error

v2->v3:
 - Fixed error return for incompatible endpoint
 - __u64 changed to __le64 in header file

 drivers/iommu/virtio-iommu.c      | 63 ++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_iommu.h | 14 ++++++-
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 4e1d11af23c8..cbac3047a781 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -78,6 +78,7 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	u64				pgsize_bitmap;
 };
 
 struct viommu_request {
@@ -415,6 +416,23 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 	return ret;
 }
 
+static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
+				    struct virtio_iommu_probe_pgsize_mask *mask,
+				    size_t len)
+{
+	u64 pgsize_bitmap;
+
+	if (len < sizeof(*mask))
+		return -EINVAL;
+
+	pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
+	if (!pgsize_bitmap)
+		return -EINVAL;
+
+	vdev->pgsize_bitmap = pgsize_bitmap;
+	return 0;
+}
+
 static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
@@ -499,6 +517,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
 			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
 			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
+			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
 		}
@@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	struct viommu_dev *viommu = vdev->viommu;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
+	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
 	if (viommu_page_size > PAGE_SIZE) {
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
@@ -630,7 +651,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 
 	vdomain->id		= (unsigned int)ret;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
+	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
 	vdomain->map_flags	= viommu->map_flags;
@@ -654,6 +675,38 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+/*
+ * Check whether the endpoint's capabilities are compatible with other
+ * endpoints in the domain. Report any inconsistency.
+ */
+static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
+					  struct viommu_domain *vdomain)
+{
+	struct device *dev = vdev->dev;
+	u64 pgsize_bitmap;
+
+	if (vdomain->viommu != vdev->viommu) {
+		dev_err(dev, "cannot attach to foreign vIOMMU\n");
+		return false;
+	}
+
+	pgsize_bitmap = vdomain->domain.pgsize_bitmap & vdev->pgsize_bitmap;
+
+	if (pgsize_bitmap != vdomain->domain.pgsize_bitmap) {
+		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
+			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
+		return false;
+	}
+
+	/* Domain pagesize bitmap is subset of device pagesize bitmap */
+	if (pgsize_bitmap != vdev->pgsize_bitmap) {
+		dev_info(dev, "page size bitmap used %llx, supported %llx\n",
+			 pgsize_bitmap, vdev->pgsize_bitmap);
+		vdev->pgsize_bitmap = pgsize_bitmap;
+	}
+	return true;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int i;
@@ -670,9 +723,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * owns it.
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
-	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
@@ -886,6 +938,7 @@ static int viommu_add_device(struct device *dev)
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
+	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
 	INIT_LIST_HEAD(&vdev->resv_regions);
 	dev_iommu_priv_set(dev, vdev);
 
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 48e3c29223b5..15a8327ffef5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -28,7 +28,11 @@ struct virtio_iommu_range_32 {
 };
 
 struct virtio_iommu_config {
-	/* Supported page sizes */
+	/*
+	 * Bitmap of supported page sizes. The least significant bit
+	 * indicates the smallest granularity and the other bits are
+	 * hints indicating optimal block sizes.
+	 */
 	__u64					page_size_mask;
 	/* Supported IOVA range */
 	struct virtio_iommu_range_64		input_range;
@@ -111,6 +115,7 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -119,6 +124,13 @@ struct virtio_iommu_probe_property {
 	__le16					length;
 };
 
+struct virtio_iommu_probe_pgsize_mask {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	/* Same format as virtio_iommu_config::page_size_mask */
+	__le64					pgsize_bitmap;
+};
+
 #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
 #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

