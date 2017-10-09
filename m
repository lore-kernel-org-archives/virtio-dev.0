Return-Path: virtio-dev-return-2602-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 48BF958190E9
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Oct 2017 12:42:17 -0700 (PDT)
Date: Mon, 9 Oct 2017 20:46:51 +0100
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9f22b03d-704d-3df9-08ec-83fed037c428@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <0e0db2c0-86bc-a76a-05bd-0b41e00ba926@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e0db2c0-86bc-a76a-05bd-0b41e00ba926@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [RFC] virtio-iommu version 0.4
To: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Eric,

On 03/10/17 14:04, Auger Eric wrote:
> When rebasing the v0.4 driver on master I observe a regression: commands
> are not received properly by QEMU (typically an attach command is
> received with a type of 0). After a bisection of the guest kernel the
> first commit the problem appears is:
> 
> commit e3067861ba6650a566a6273738c23c956ad55c02
> arm64: add basic VMAP_STACK support

Indeed, thanks for the report. I can reproduce the problem with 4.14 and
kvmtool. We should allocate buffers on the heap for any request (see for
example 9472fe704 or e37e2ff35). I rebased onto 4.14 and pushed the
following patch at: git://linux-arm.org/linux-jpb.git virtio-iommu/v0.4.1

It's not very nice, but should fix the issue. I didn't manage to measure
the difference though, my benchmark isn't precise enough. So I don't
know if we should try to use a kmem cache instead of kmalloc.

Thanks,
Jean

--- 8< ---
From 3fc957560e1e6f070a0468bf75ebc4862d37ff82 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Mon, 9 Oct 2017 20:13:57 +0100
Subject: [PATCH] iommu/virtio-iommu: Allocate all requests on the heap

When CONFIG_VMAP_STACK is enabled, DMA on the stack isn't allowed. Instead
of allocating virtio-iommu requests on the stack, use kmalloc.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/virtio-iommu.c | 86 +++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ec1cfaba5997..2d8fd5e99fa7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -473,13 +473,10 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int i;
 	int ret = 0;
+	struct virtio_iommu_req_attach *req;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct viommu_endpoint *vdev = fwspec->iommu_priv;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
-	struct virtio_iommu_req_attach req = {
-		.head.type	= VIRTIO_IOMMU_T_ATTACH,
-		.address_space	= cpu_to_le32(vdomain->id),
-	};

 	mutex_lock(&vdomain->mutex);
 	if (!vdomain->viommu) {
@@ -531,14 +528,25 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)

 	dev_dbg(dev, "attach to domain %llu\n", vdomain->id);

+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	*req = (struct virtio_iommu_req_attach) {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH,
+		.address_space	= cpu_to_le32(vdomain->id),
+	};
+
 	for (i = 0; i < fwspec->num_ids; i++) {
-		req.device = cpu_to_le32(fwspec->ids[i]);
+		req->device = cpu_to_le32(fwspec->ids[i]);

-		ret = viommu_send_req_sync(vdomain->viommu, &req);
+		ret = viommu_send_req_sync(vdomain->viommu, req);
 		if (ret)
 			break;
 	}

+	kfree(req);
+
 	vdomain->attached++;
 	vdev->vdomain = vdomain;

@@ -550,13 +558,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
-	struct virtio_iommu_req_map req = {
-		.head.type	= VIRTIO_IOMMU_T_MAP,
-		.address_space	= cpu_to_le32(vdomain->id),
-		.virt_addr	= cpu_to_le64(iova),
-		.phys_addr	= cpu_to_le64(paddr),
-		.size		= cpu_to_le64(size),
-	};
+	struct virtio_iommu_req_map *req;

 	pr_debug("map %llu 0x%lx -> 0x%llx (%zu)\n", vdomain->id, iova,
 		 paddr, size);
@@ -564,17 +566,30 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!vdomain->attached)
 		return -ENODEV;

-	if (prot & IOMMU_READ)
-		req.flags |= cpu_to_le32(VIRTIO_IOMMU_MAP_F_READ);
-
-	if (prot & IOMMU_WRITE)
-		req.flags |= cpu_to_le32(VIRTIO_IOMMU_MAP_F_WRITE);
-
 	ret = viommu_tlb_map(vdomain, iova, paddr, size);
 	if (ret)
 		return ret;

-	ret = viommu_send_req_sync(vdomain->viommu, &req);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	*req = (struct virtio_iommu_req_map) {
+		.head.type	= VIRTIO_IOMMU_T_MAP,
+		.address_space	= cpu_to_le32(vdomain->id),
+		.virt_addr	= cpu_to_le64(iova),
+		.phys_addr	= cpu_to_le64(paddr),
+		.size		= cpu_to_le64(size),
+	};
+
+	if (prot & IOMMU_READ)
+		req->flags |= cpu_to_le32(VIRTIO_IOMMU_MAP_F_READ);
+
+	if (prot & IOMMU_WRITE)
+		req->flags |= cpu_to_le32(VIRTIO_IOMMU_MAP_F_WRITE);
+
+	ret = viommu_send_req_sync(vdomain->viommu, req);
+	kfree(req);
 	if (ret)
 		viommu_tlb_unmap(vdomain, iova, size);

@@ -587,11 +602,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 	size_t unmapped;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
-	struct virtio_iommu_req_unmap req = {
-		.head.type	= VIRTIO_IOMMU_T_UNMAP,
-		.address_space	= cpu_to_le32(vdomain->id),
-		.virt_addr	= cpu_to_le64(iova),
-	};
+	struct virtio_iommu_req_unmap *req;

 	pr_debug("unmap %llu 0x%lx (%zu)\n", vdomain->id, iova, size);

@@ -603,9 +614,19 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	if (unmapped < size)
 		return 0;

-	req.size = cpu_to_le64(unmapped);
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;

-	ret = viommu_send_req_sync(vdomain->viommu, &req);
+	*req = (struct virtio_iommu_req_unmap) {
+		.head.type	= VIRTIO_IOMMU_T_UNMAP,
+		.address_space	= cpu_to_le32(vdomain->id),
+		.virt_addr	= cpu_to_le64(iova),
+		.size		= cpu_to_le64(unmapped),
+	};
+
+	ret = viommu_send_req_sync(vdomain->viommu, req);
+	kfree(req);
 	if (ret)
 		return 0;

@@ -626,12 +647,16 @@ static size_t viommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	unsigned long mapped_iova;
 	size_t top_size, bottom_size;
 	struct viommu_request reqs[nents];
-	struct virtio_iommu_req_map map_reqs[nents];
+	struct virtio_iommu_req_map *map_reqs;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);

 	if (!vdomain->attached)
 		return 0;

+	map_reqs = kcalloc(nents, sizeof(*map_reqs), GFP_KERNEL);
+	if (!map_reqs)
+		return -ENOMEM;
+
 	pr_debug("map_sg %llu %u 0x%lx\n", vdomain->id, nents, iova);

 	if (prot & IOMMU_READ)
@@ -679,6 +704,7 @@ static size_t viommu_map_sg(struct iommu_domain *domain, unsigned long iova,

 	if (ret) {
 		viommu_tlb_unmap(vdomain, iova, total_size);
+		kfree(map_reqs);
 		return 0;
 	}

@@ -692,6 +718,7 @@ static size_t viommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			goto err_rollback;
 	}

+	kfree(map_reqs);
 	return total_size;

 err_rollback:
@@ -719,6 +746,7 @@ static size_t viommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	}

 	viommu_tlb_unmap(vdomain, iova, total_size);
+	kfree(map_reqs);

 	return 0;
 }
@@ -863,6 +891,8 @@ static int viommu_probe_device(struct viommu_dev *viommu,
 		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
 	}

+	kfree(probe);
+
 	return 0;
 }

--
2.13.3



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

