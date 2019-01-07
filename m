Return-Path: virtio-dev-return-5266-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 784B1985A63
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Jan 2019 17:55:03 +0000 (UTC)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 12:54:45 -0500
Message-Id: <1546883690-17798-1-git-send-email-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH v2 0/5] Support for datapath switching during live migration
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

Implement the infrastructure to support datapath switching during live
migration involving SR-IOV devices.

1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
   bit and MAC address device pairing.

2. This set of events will be consumed by userspace management software
   to orchestrate all the hot plug and datapath switching activities.
   This scheme has the least QEMU modifications while allowing userspace
   software to build its own intelligence to control the whole process
   of SR-IOV live migration.

3. While the hidden device model (viz. coupled device model) is still
   being explored for automatic hot plugging (QEMU) and automatic datapath
   switching (host-kernel), this series provides a supplemental set
   of interfaces if management software wants to drive the SR-IOV live
   migration on its own. It should not conflict with the hidden device
   model but just offers simplicity of implementation.


Si-Wei Liu (2):
  vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
  pci: query command extension to check the bus master enabling status of the failover-primary device

Sridhar Samudrala (1):
  virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.

Venu Busireddy (2):
  virtio_net: Add support for "Data Path Switching" during Live Migration.
  virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.

---
Changes in v2:
  Added a query command for FAILOVER_STANDBY_CHANGED event.
  Added a query command for FAILOVER_PRIMARY_CHANGED event.

 hmp.c                          |   5 +++
 hw/acpi/pcihp.c                |  27 +++++++++++
 hw/net/virtio-net.c            |  42 +++++++++++++++++
 hw/pci/pci.c                   |   5 +++
 hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
 hw/vfio/pci.h                  |   1 +
 include/hw/pci/pci.h           |   1 +
 include/hw/virtio/virtio-net.h |   1 +
 include/net/net.h              |   2 +
 net/net.c                      |  59 ++++++++++++++++++++++++
 qapi/misc.json                 |   5 ++-
 qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 307 insertions(+), 1 deletion(-)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

