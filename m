Return-Path: virtio-dev-return-4427-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 23A385819145
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Jun 2018 09:32:48 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 19 Jun 2018 11:32:24 -0500
Message-Id: <20180619163228.13790-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH 0/3] Use of unique identifier for pairing virtio and passthrough devices...
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

The patch set "Enable virtio_net to act as a standby for a passthru
device" [1] deals with live migration of guests that use passthrough
devices. However, that scheme uses the MAC address for pairing
the virtio device and the passthrough device. The thread "netvsc:
refactor notifier/event handling code to use the failover framework"
[2] discusses an alternate mechanism, such as using an UUID, for pairing
the devices. Based on that discussion, proposals "Add "Group Identifier"
to virtio PCI capabilities." [3] and "RFC: Use of bridge devices to
store pairing information..." [4] were made.

The current patch set includes all the feedback received for proposals [3]
and [4]. For the sake of completeness, patch for the virtio specification
is also included here. Following is the updated proposal.

1. Extend the virtio specification to include a new virtio PCI capability
   "VIRTIO_PCI_CAP_GROUP_ID_CFG".

2. Enhance the QEMU CLI to include a "uuid" option to the virtio device.
   The "uuid" is a string in UUID format.

3. Enhance the QEMU CLI to include a "uuid" option to the bridge device.
   The "uuid" is a string in UUID format. Currently, PCIe bridge for
   the Q35 model is supported.

4. The operator creates a unique identifier string using 'uuidgen'.

5. When the virtio device is created, the operator uses the "uuid" option
   (for example, '-device virtio-net-pci,uuid="string"') and specifies
   the UUID created in step 4.

   QEMU stores the UUID in the virtio device's configuration space
   in the capability "VIRTIO_PCI_CAP_GROUP_ID_CFG".

6. When assigning a PCI device to the guest in passthrough mode, the
   operator first creates a bridge using the "uuid" option (for example,
   '-device ioh3420,uuid="string"') to specify the UUID created in step 4,
   and then attaches the passthrough device to the bridge.

   QEMU stores the UUID in the configuration space of the bridge as
   Vendor-Specific capability (0x09). The "Vendor" here is not to be
   confused with a specific organization. Instead, the vendor of the
   bridge is QEMU. To avoid mixing up with other bridges, the bridge
   will be created with vendor ID 0x1b36 (PCI_VENDOR_ID_REDHAT) and
   device ID 0x000e (PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE) if the "uuid"
   option is specified. Otherwise, current defaults are used.

7. Patch 4 in patch series "Enable virtio_net to act as a standby for
   a passthru device" [1] needs to be modified to use the UUID values
   present in the bridge's configuration space and the virtio device's
   configuration space instead of the MAC address for pairing the devices.

Thanks!

Venu

[1] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00156.html
[2] https://www.spinics.net/lists/netdev/msg499011.html
[3] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00118.html
[4] https://lists.oasis-open.org/archives/virtio-dev/201805/msg00204.html


Venu Busireddy (3):
  Add a true or false option to the DEFINE_PROP_UUID macro.
  Add "Group Identifier" support to PCIe bridges.
  Add "Group Identifier" support to virtio devices.

 hw/acpi/vmgenid.c                           |  2 +-
 hw/pci-bridge/ioh3420.c                     |  2 ++
 hw/pci-bridge/pcie_root_port.c              |  7 +++++++
 hw/pci/pci_bridge.c                         | 32 +++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c                      | 15 ++++++++++++++
 hw/virtio/virtio-pci.h                      |  3 ++-
 include/hw/pci/pci.h                        |  2 ++
 include/hw/pci/pcie.h                       |  1 +
 include/hw/pci/pcie_port.h                  |  1 +
 include/hw/qdev-properties.h                |  4 ++--
 include/standard-headers/linux/virtio_pci.h |  8 ++++++++
 11 files changed, 73 insertions(+), 4 deletions(-)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

