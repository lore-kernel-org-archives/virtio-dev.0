Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v5 0/7] Introduce device group and device management
Date: Wed, 27 Apr 2022 01:58:17 +0300
Message-ID: <20220426225824.5918-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
A device group definition will help extending the virtio specefication for
various future features that require a notion of grouping devices together or
managing devices inside a group. A device group include one or more virtio devices.
For now, only support for type 1 device group was added.

Also introduce the admin facility to allow manipulating features and configurations
in a generic manner. Using the admin command set, one can manipulate the device itself
and/or to manipulate, if possible, another device within the same device group (for now,
introduce only support of PCI SR-IOV devices grouping).

The admin command set will be extended in the future  to support more functionalities.
Some of these functionalities are already under discussions.

The admin virtqueue is the first management interface to issue admin commands from
the admin command set.

Motivation for choosing admin queue as first management interface:
1. It is anticipated that admin queue will be used for managing and configuring
   many different type of resources. For example,
   a. PCI PF configuring PCI VF attributes.
   b. virtio device creating/destroying/configuring subfunctions discussed in [1]
   c. composing device config space of VF or SF such as mac address, number of VQs, virtio features

   Mapping all of them as configuration registers to MMIO will require large MMIO space,
   if done for each VF/SF. Such MMIO implementation in physical devices such as PCI PF and VF
   requires on-chip resources to complete within MMIO access latencies. Such resources are very
   expensive.

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

A future work can add another management interface to issue admin commands.

[1] https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html

This series include the comments and fixes from V1-V4 of the initial patch sets ("VIRTIO: Provision maximum
MSI-X vectors for a VF" and "Introduce virtio subsystem and Admin virtqueue" [2]).
This series was extended with additional RFC for setting managed device feature bits as another example for
using admin command set. Also device/driver negotiation for admin caps was introduced as a response for previous
comments on the mailing list.

[2] https://lists.oasis-open.org/archives/virtio-comment/202203/msg00005.html


Open issues:
1. CCW and MMIO specification for admin_queue_index register

Changelog:
 - Merged MSI-X configuration series to current one.
 - Addressed comments from MST, Jason Wang and others.
 - simplified the interface.
 - added another resource management  as RFC (feature bits).

Max Gurtovoy (7):
  Introduce device group
  Introduce admin command set
  Introduce new destination type for admin commands
  Introduce virtio admin virtqueue
  Add miscellaneous configuration structure for PCI
  Introduce MGMT admin commands
  RFC: add initial support for configuring feature bits

 admin.tex        | 282 +++++++++++++++++++++++++++++++++++++++++++++++
 conformance.tex  |   3 +
 content.tex      | 118 +++++++++++++++++++-
 introduction.tex |  42 +++++++
 4 files changed, 443 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

-- 
2.21.0

