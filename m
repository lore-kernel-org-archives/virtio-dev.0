Return-Path: virtio-dev-return-5760-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54C4A98601B
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 May 2019 17:12:46 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Thu, 30 May 2019 18:09:25 +0100
Message-Id: <20190530170929.19366-4-jean-philippe.brucker@arm.com>
In-Reply-To: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v8 3/7] of: Allow the iommu-map property to omit untranslated devices
To: joro@8bytes.org, mst@redhat.com
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com, bhelgaas@google.com, frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, tnowicki@caviumnetworks.com, kevin.tian@intel.com, bauerman@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

In PCI root complex nodes, the iommu-map property describes the IOMMU that
translates each endpoint. On some platforms, the IOMMU itself is presented
as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
by the current OF driver, which expects all endpoints to have an IOMMU.
Allow the iommu-map property to have gaps.

Relaxing of_map_rid() also allows the msi-map property to have gaps, which
is invalid since MSIs always reach an MSI controller. In that case
pci_msi_setup_msi_irqs() will return an error when attempting to find the
device's MSI domain.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/of/base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20e0e7ee4edf..55e7f5bb0549 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2294,8 +2294,12 @@ int of_map_rid(struct device_node *np, u32 rid,
 		return 0;
 	}
 
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
+	pr_info("%pOF: no %s translation for rid 0x%x on %pOF\n", np, map_name,
+		rid, target && *target ? *target : NULL);
+
+	/* Bypasses translation */
+	if (id_out)
+		*id_out = rid;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_map_rid);
-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

