Return-Path: virtio-dev-return-3354-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CA89558191C7
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 12:08:45 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  1 Mar 2018 12:08:41 -0800
Message-Id: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH v4 0/2] Enable virtio_net to act as a backup for a passthru device 
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, jiri@resnulli.us, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Based on the review comments on the v3 version of the RFC patch and
Jakub's suggestion for the naming issue with 3 netdev solution, we are now 
proposing 3 netdev in-driver bonding solution for virtio-net.

The main motivation for this patch is to enable cloud service providers
to provide an accelerated datapath to virtio-net enabled VMs in a 
transparent manner with no/minimal guest userspace changes. This also
enables hypervisor controlled live migration to be supported with VMs that
have direct attached SR-IOV VF devices.

Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
used by hypervisor to indicate that virtio_net interface should act as
a backup for another device with the same MAC address.

Patch 2 extends virtio_net to use alternate datapath when available and
registered. When BACKUP feature is enabled, virtio_net driver creates
an additional 'bypass' netdev that acts as a master device and controls
2 slave devices.  The original virtio_net netdev is registered as
'backup' netdev and a passthru/vf device with the same MAC gets
registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
associated with the same 'pci' device.  The user accesses the network
interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
as default for transmits when it is available with link up and running.

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

Most of the code added is implemented as new functions that are isolated
from the existing virtio_net functionality and it can be moved to a new
driver to implement bypass functionality if we decide to make it common
with other para virtual drivers like netvsc.

This patch is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Sridhar Samudrala (2):
  virtio_net: Introduce VIRTIO_NET_F_BACKUP feature bit
  virtio_net: Extend virtio to use VF datapath when available

 drivers/net/virtio_net.c        | 682 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   3 +
 2 files changed, 683 insertions(+), 2 deletions(-)

-- 
2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

