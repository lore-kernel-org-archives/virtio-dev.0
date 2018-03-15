Return-Path: virtio-dev-return-3576-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6272D581819D
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Mar 2018 11:43:33 -0700 (PDT)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 11:43:21 -0700
Message-ID: <20180315184248.3102.16810.stgit@localhost.localdomain>
In-Reply-To: <20180315183449.3102.64791.stgit@localhost.localdomain>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [pci PATCH v7 3/5] ena: Migrate over to unmanaged SR-IOV support
To: bhelgaas@google.com, alexander.h.duyck@intel.com, linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com, mheyne@amazon.de, liang-min.wang@intel.com, mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the ena driver we can just reuse the existing
pci_sriov_configure_simple function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple
v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
v7: No change

 drivers/net/ethernet/amazon/ena/ena_netdev.c |   28 +-------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6975150d144e..6054deb1e6aa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3385,32 +3385,6 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 
 /*****************************************************************************/
-static int ena_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	int rc;
-
-	if (numvfs > 0) {
-		rc = pci_enable_sriov(dev, numvfs);
-		if (rc != 0) {
-			dev_err(&dev->dev,
-				"pci_enable_sriov failed to enable: %d vfs with the error: %d\n",
-				numvfs, rc);
-			return rc;
-		}
-
-		return numvfs;
-	}
-
-	if (numvfs == 0) {
-		pci_disable_sriov(dev);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*****************************************************************************/
-/*****************************************************************************/
 
 /* ena_remove - Device Removal Routine
  * @pdev: PCI device information struct
@@ -3525,7 +3499,7 @@ static int ena_resume(struct pci_dev *pdev)
 	.suspend    = ena_suspend,
 	.resume     = ena_resume,
 #endif
-	.sriov_configure = ena_sriov_configure,
+	.sriov_configure = pci_sriov_configure_simple,
 };
 
 static int __init ena_init(void)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

