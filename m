Return-Path: virtio-dev-return-5181-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C718A985C83
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Dec 2018 18:26:59 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Tue, 11 Dec 2018 18:21:01 +0000
Message-Id: <20181211182104.18241-5-jean-philippe.brucker@arm.com>
In-Reply-To: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v6 4/7] PCI: OF: Initialize dev->fwnode appropriately
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, mst@redhat.com
Cc: jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com, bhelgaas@google.com, frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, tnowicki@caviumnetworks.com, kevin.tian@intel.com, marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, bharat.bhushan@nxp.com
List-ID: <virtio-dev.lists.oasis-open.org>

For PCI devices that have an OF node, set the fwnode as well. This way
drivers that rely on fwnode don't need the special case described by
commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 4c4217d0c3f1..c272ecfcd038 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -21,12 +21,15 @@ void pci_set_of_node(struct pci_dev *dev)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
+	if (dev->dev.of_node)
+		dev->dev.fwnode = &dev->dev.of_node->fwnode;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
 	dev->dev.of_node = NULL;
+	dev->dev.fwnode = NULL;
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -35,12 +38,16 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		bus->dev.of_node = pcibios_get_phb_of_node(bus);
 	else
 		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
+
+	if (bus->dev.of_node)
+		bus->dev.fwnode = &bus->dev.of_node->fwnode;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
+	bus->dev.fwnode = NULL;
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.19.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

