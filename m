Return-Path: virtio-dev-return-3398-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EF46D58180EF
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 15:45:23 -0800 (PST)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 02 Mar 2018 15:45:20 -0800
Message-ID: <20180302234459.3337.5625.stgit@localhost.localdomain>
In-Reply-To: <20180302234218.3337.16486.stgit@localhost.localdomain>
References: <20180302234218.3337.16486.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH 3/3] virtio_pci: Add support for unmanaged SR-IOV on
 virtio_pci devices
To: bhelgaas@google.com, alexander.h.duyck@intel.com, linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com, linux-kernel@vger.kernel.org, mheyne@amazon.de, liang-min.wang@intel.com, mark.d.rustad@intel.com, dwmw2@infradead.org, dwmw@amazon.co.uk
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Hardware-realized virtio_pci devices can implement SR-IOV, so this
patch enables its use. The device in question is an upcoming Intel
NIC that implements both a virtio_net PF and virtio_net VFs. These
are hardware realizations of what has been up to now been a software
interface.

The device in question has the following 4-part PCI IDs:

PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

The patch currently needs no check for device ID, because the callback
will never be made for devices that do not assert the capability or
when run on a platform incapable of SR-IOV.

One reason for this patch is because the hardware requires the
vendor ID of a VF to be the same as the vendor ID of the PF that
created it. So it seemed logical to simply have a fully-functioning
virtio_net PF create the VFs. This patch makes that possible.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/virtio/virtio_pci_common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 48d4d1cf1cb6..ca1549393255 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -584,6 +584,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	else
 		virtio_pci_modern_remove(vp_dev);
 
+	pci_disable_sriov(pci_dev);
 	pci_disable_device(pci_dev);
 	put_device(dev);
 }
@@ -596,6 +597,9 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = pci_sriov_configure_unmanaged,
+#endif
 };
 
 module_pci_driver(virtio_pci_driver);


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

