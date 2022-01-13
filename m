Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/5] VIRTIO: Provision maximum MSI-X vectors for a VF
Date: Thu, 13 Jan 2022 16:50:58 +0200
Message-ID: <20220113145103.26894-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

In a PCI SR-IOV configuration, MSI-X vectors of the device is precious
device resource. Hence making efficient use of it based on the use case
that aligns to the VM configuration is desired for best system
performance.

For example, today's static assignment of the amount of MSI-X vectors
doesn't allow sophisticated utilization of resources.

A typical cloud provider SR-IOV use case is to create many VFs for
use by guest VMs. Each VM might have a different purpose and different
amount of resources accordingly (e.g. number of CPUs). A common driver
usage of device's MSI-X vectors is proportional to the number of CPUs in
the VM. Since the system administrator might know the amount of CPUs in
the requested VM, he can also configure the VF's MSI-X vectors amount
proportional to the number of CPUs in the VM. In this way, the
utilization of the physical hardware will be improved.

Today we have some operating systems that support provisioning MSI-X
vectors for PCI VFs.

Update the specification to have a method to change the number of MSI-X
vectors supported by a VF using the PF admin virtqueue interface. For that,
create a generic infrastructure for managing PCI resources of the managed
VF by its parent PF.

Patches (1/5)-(2/5) introduce the admin virtqueue concept and feature bits.
Patches (3/5)-(4/5) add the admin virtq to virtio-blk and virtio-net
devices.
Patch (5/5) introduce MSI-X mgmt support.

Max Gurtovoy (5):
  Add virtio Admin Virtqueue specification
  Introduce VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
  virtio-blk: add support for VIRTIO_F_ADMIN_VQ
  virtio-net: add support for VIRTIO_F_ADMIN_VQ
  Add support for dynamic MSI-X vector mgmt for VFs

 admin-virtq.tex | 145 ++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex     |  91 +++++++++++++++++++++++++++---
 packed-ring.tex |  26 ++++-----
 split-ring.tex  |  35 ++++++++----
 4 files changed, 263 insertions(+), 34 deletions(-)
 create mode 100644 admin-virtq.tex

-- 
2.21.0

