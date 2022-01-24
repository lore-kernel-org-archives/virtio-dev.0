Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 0/4] VIRTIO: Provision maximum MSI-X vectors for a VF
Date: Mon, 24 Jan 2022 11:39:14 +0200
Message-ID: <20220124093918.34371-1-mgurtovoy@nvidia.com>
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

The admin virtqueue interface will be extended in the future with more and more
features that some of them already in discussions. Some of these features don't
fit to MMIO/config_space characteristics, therefore a queue is selected to address
admin commands.

Motivation for choosing admin queue:
1. It is anticipated that admin queue will be used for managing and configuring
   many different type of resources. For example,
   a. PCI PF configuring PCI VF attributes in [1].
   b. virtio device creating/destroying/configuring subfunctions discussed in [2]
   c. composing device config space of VF or SF such as mac address, number of VQs, virtio features

Mapping all of them as configuration registers to MMIO will require large MMIO space, if done for
each VF/SF. Such MMIO implementation in physical devices such as PCI PF and VF requires on-chip
resources to complete within MMIO access latencies. Such resources are very expensive.

2. Such limitation can be overcome by having smaller MMIO register set to build
   a command request response interface. However, such MMIO based command interface
   will be limited to serve single outstanding command execution. Such limitation can
   resulting in high device creation and composing time which can affect VM startup time.
   Often device can queue and service multiple commands in parallel, such command interface
   cannot use parallelism offered by the device.

3. When a command wants to DMA data from one or more physical addresses, for example in the future a
   live migration command may need to fetch device state consist of config space, tens of
   VQs state, VLAN and MAC table, per VQ partial outstanding block IO list database and more.
   Packing one or more DMA addresses over new command interface will be burden some and continue
   to suffer single outstanding command execution latencies. Such limitation is not good for time
   sensitive live migration use cases.

4. A virtio queue overcomes all the above limitations. It also supports DMA and multiple outstanding
   descriptors. Similar mechanism exist today for device specific configuration - the control VQ.

[1] This proposal
[2] https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html

Patches (1/4) introduce the admin virtqueue concept and feature bit.
Patches (2/4)-(3/4) add the admin virtq to virtio-blk and virtio-net
devices.
Patch (4/4) introduce MSI-X control support.

---

changes from V1:

1. Addressed below comments from MST:
 - updated cover letter for admin queue motivation
 - removed VIRTIO_F_ADMIN_PCI_VIRT_MANAGER
 - simplified admin queue interface by removing 
   VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER feature bits
 - added a subsection for VF MSI-X control capability in PCI section
 - re-designed interrupt vector management admin commands
 - added a mandatory admin command to expose admin capabilities
 - improved commit messages
 - described error code for unsupported command
 - described error code for errors on invalid VF
 - described system software requirements for supporting MSI-X configuration

2. Addressed comments from Parav
 - extended command opcode to 16-bit
 - improve commit messages

3. Added more command specific error codes

---

Max Gurtovoy (4):
  Add virtio Admin Virtqueue
  virtio-blk: add support for VIRTIO_F_ADMIN_VQ
  virtio-net: add support for VIRTIO_F_ADMIN_VQ
  Add support for MSI-X vectors configuration for PCI VFs

 admin-virtq.tex | 235 ++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex     |  67 +++++++++++++-
 2 files changed, 299 insertions(+), 3 deletions(-)
 create mode 100644 admin-virtq.tex

-- 
2.21.0

