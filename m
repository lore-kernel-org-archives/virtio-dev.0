Return-Path: virtio-dev-return-3517-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CD805818081
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Mar 2018 10:23:57 -0700 (PDT)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Mar 2018 10:23:43 -0700
Message-ID: <20180312172337.3487.95817.stgit@localhost.localdomain>
In-Reply-To: <20180312171813.3487.94803.stgit@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [pci PATCH v5 4/4] nvme: Migrate over to unmanaged SR-IOV support
To: bhelgaas@google.com, alexander.h.duyck@intel.com, linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de, liang-min.wang@intel.com, mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the nvme driver we can just reuse the existing
pci_sriov_configure_simple function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple

 drivers/nvme/host/pci.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5933a5c732e8..3b582f9f8cac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2580,24 +2580,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
-{
-	int ret = 0;
-
-	if (numvfs == 0) {
-		if (pci_vfs_assigned(pdev)) {
-			dev_warn(&pdev->dev,
-				"Cannot disable SR-IOV VFs while assigned\n");
-			return -EPERM;
-		}
-		pci_disable_sriov(pdev);
-		return 0;
-	}
-
-	ret = pci_enable_sriov(pdev, numvfs);
-	return ret ? ret : numvfs;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2716,7 +2698,9 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-	.sriov_configure = nvme_pci_sriov_configure,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = pci_sriov_configure_simple,
+#endif
 	.err_handler	= &nvme_err_handler,
 };
 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

