Return-Path: virtio-dev-return-2738-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D3CBE581819D
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2017 19:49:38 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  5 Dec 2017 11:33:09 +0800
Message-Id: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Cc: jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, Wei Wang <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Vhost-pci is a point-to-point based inter-VM communication solution. This
patch series implements the vhost-pci-net device setup and emulation. The
device is implemented as a virtio device, and it is set up via the
vhost-user protocol to get the neessary info (e.g the memory info of the
remote VM, vring info).

Currently, only the fundamental functions are implemented. More features,
such as MQ and live migration, will be updated in the future.

The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
http://dpdk.org/ml/archives/dev/2017-November/082615.html

v2->v3 changes:
1) static device creation: instead of creating and hot-plugging the
   device when receiving a vhost-user msg, the device is not created
   via the qemu booting command line.
2) remove vqs: rq and ctrlq are removed in this version.
    - receive vq: the receive vq is not needed anymore. The PMD directly
                  shares the remote txq and rxq - grab from remote txq to
                  receive packets, and put to rxq to send packets.
    - ctrlq: the ctrlq is replaced by the first 4KB metadata area of the
             device Bar-2.
3) simpler implementation: the entire implementation has been tailored
   from ~1800 LOC to ~850 LOC.

Wei Wang (7):
  vhost-user: share the vhost-user protocol related structures
  vhost-pci-net: add vhost-pci-net
  virtio/virtio-pci.c: add vhost-pci-net-pci
  vhost-pci-slave: add vhost-pci slave implementation
  vhost-user: VHOST_USER_SET_VHOST_PCI msg
  vhost-pci-slave: handle VHOST_USER_SET_VHOST_PCI
  virtio/vhost.c: vhost-pci needs remote gpa

 hw/net/Makefile.objs                           |   2 +-
 hw/net/vhost_net.c                             |  37 +++
 hw/net/vhost_pci_net.c                         | 137 +++++++++++
 hw/virtio/Makefile.objs                        |   1 +
 hw/virtio/vhost-pci-slave.c                    | 310 +++++++++++++++++++++++++
 hw/virtio/vhost-user.c                         | 117 ++--------
 hw/virtio/vhost.c                              |  63 +++--
 hw/virtio/virtio-pci.c                         |  55 +++++
 hw/virtio/virtio-pci.h                         |  14 ++
 include/hw/pci/pci.h                           |   1 +
 include/hw/virtio/vhost-backend.h              |   2 +
 include/hw/virtio/vhost-pci-net.h              |  42 ++++
 include/hw/virtio/vhost-pci-slave.h            |  12 +
 include/hw/virtio/vhost-user.h                 | 108 +++++++++
 include/hw/virtio/vhost.h                      |   2 +
 include/net/vhost_net.h                        |   2 +
 include/standard-headers/linux/vhost_pci_net.h |  65 ++++++
 include/standard-headers/linux/virtio_ids.h    |   1 +
 18 files changed, 851 insertions(+), 120 deletions(-)
 create mode 100644 hw/net/vhost_pci_net.c
 create mode 100644 hw/virtio/vhost-pci-slave.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/hw/virtio/vhost-pci-slave.h
 create mode 100644 include/hw/virtio/vhost-user.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

