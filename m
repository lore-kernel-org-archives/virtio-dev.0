Return-Path: virtio-dev-return-3735-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D5D3558191AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Apr 2018 14:08:34 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  5 Apr 2018 14:08:19 -0700
Message-Id: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v5 0/4] Enable virtio_net to act as a backup for a passthru device 
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

The main motivation for this patch is to enable cloud service providers
to provide an accelerated datapath to virtio-net enabled VMs in a 
transparent manner with no/minimal guest userspace changes. This also
enables hypervisor controlled live migration to be supported with VMs that
have direct attached SR-IOV VF devices.

Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
used by hypervisor to indicate that virtio_net interface should act as
a backup for another device with the same MAC address.

Patch 2 introduces a bypass module that provides a generic interface for 
paravirtual drivers to listen for netdev register/unregister/link change
events from pci ethernet devices with the same MAC and takeover their
datapath. The notifier and event handling code is based on the existing
netvsc implementation. A paravirtual driver can use this module by
registering a set of ops and each instance of the device when it is probed.

Patch 3 extends virtio_net to use alternate datapath when available and
registered. When BACKUP feature is enabled, virtio_net driver creates
an additional 'bypass' netdev that acts as a master device and controls
2 slave devices.  The original virtio_net netdev is registered as
'backup' netdev and a passthru/vf device with the same MAC gets
registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
associated with the same 'pci' device.  The user accesses the network
interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
as default for transmits when it is available with link up and running.

Patch 4 refactors netvsc to use the registration/notification framework
supported by bypass module.

As this patch series is initially focusing on usecases where hypervisor 
fully controls the VM networking and the guest is not expected to directly 
configure any hardware settings, it doesn't expose all the ndo/ethtool ops
that are supported by virtio_net at this time. To support additional usecases,
it should be possible to enable additional ops later by caching the state
in virtio netdev and replaying when the 'active' netdev gets registered. 
 
The hypervisor needs to enable only one datapath at any time so that packets
don't get looped back to the VM over the other datapath. When a VF is
plugged, the virtio datapath link state can be marked as down.
At the time of live migration, the hypervisor needs to unplug the VF device
from the guest on the source host and reset the MAC filter of the VF to
initiate failover of datapath to virtio before starting the migration. After
the migration is completed, the destination hypervisor sets the MAC filter
on the VF and plugs it back to the guest to switch over to VF datapath.

This patch is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

v5 RFC:
  Based on Jiri's comments, moved the common functionality to a 'bypass'
  module so that the same notifier and event handlers to handle child
  register/unregister/link change events can be shared between virtio_net
  and netvsc.
  Improved error handling based on Siwei's comments.
v4:
- Based on the review comments on the v3 version of the RFC patch and
  Jakub's suggestion for the naming issue with 3 netdev solution,
  proposed 3 netdev in-driver bonding solution for virtio-net.
v3 RFC:
- Introduced 3 netdev model and pointed out a couple of issues with
  that model and proposed 2 netdev model to avoid these issues.
- Removed broadcast/multicast optimization and only use virtio as
  backup path when VF is unplugged.
v2 RFC:
- Changed VIRTIO_NET_F_MASTER to VIRTIO_NET_F_BACKUP (mst)
- made a small change to the virtio-net xmit path to only use VF datapath
  for unicasts. Broadcasts/multicasts use virtio datapath. This avoids
  east-west broadcasts to go over the PCI link.
- added suppport for the feature bit in qemu

Sridhar Samudrala (4):
  virtio_net: Introduce VIRTIO_NET_F_BACKUP feature bit
  net: Introduce generic bypass module
  virtio_net: Extend virtio to use VF datapath when available
  netvsc: refactor notifier/event handling code to use the bypass
    framework

 drivers/net/Kconfig             |   1 +
 drivers/net/hyperv/Kconfig      |   1 +
 drivers/net/hyperv/netvsc_drv.c | 219 ++++----------
 drivers/net/virtio_net.c        | 614 +++++++++++++++++++++++++++++++++++++++-
 include/net/bypass.h            |  80 ++++++
 include/uapi/linux/virtio_net.h |   3 +
 net/Kconfig                     |  18 ++
 net/core/Makefile               |   1 +
 net/core/bypass.c               | 406 ++++++++++++++++++++++++++
 9 files changed, 1184 insertions(+), 159 deletions(-)
 create mode 100644 include/net/bypass.h
 create mode 100644 net/core/bypass.c

-- 
2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

