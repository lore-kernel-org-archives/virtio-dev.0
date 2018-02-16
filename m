Return-Path: virtio-dev-return-3229-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BB3E458191AA
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2018 10:11:24 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Fri, 16 Feb 2018 10:11:19 -0800
Message-Id: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a passthru device 
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
used by hypervisor to indicate that virtio_net interface should act as
a backup for another device with the same MAC address.

Ppatch 2 is in response to the community request for a 3 netdev
solution.  However, it creates some issues we'll get into in a moment.
It extends virtio_net to use alternate datapath when available and
registered. When BACKUP feature is enabled, virtio_net driver creates
an additional 'bypass' netdev that acts as a master device and controls
2 slave devices.  The original virtio_net netdev is registered as
'backup' netdev and a passthru/vf device with the same MAC gets
registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
associated with the same 'pci' device.  The user accesses the network
interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
as default for transmits when it is available with link up and running.

We noticed a couple of issues with this approach during testing.
- As both 'bypass' and 'backup' netdevs are associated with the same
  virtio pci device, udev tries to rename both of them with the same name
  and the 2nd rename will fail. This would be OK as long as the first netdev
  to be renamed is the 'bypass' netdev, but the order in which udev gets
  to rename the 2 netdevs is not reliable. 
- When the 'active' netdev is unplugged OR not present on a destination
  system after live migration, the user will see 2 virtio_net netdevs.

Patch 3 refactors much of the changes made in patch 2, which was done on 
purpose just to show the solution we recommend as part of one patch set.  
If we submit a final version of this, we would combine patch 2/3 together.
This patch removes the creation of an additional netdev, Instead, it
uses a new virtnet_bypass_info struct added to the original 'backup' netdev
to track the 'bypass' information and introduces an additional set of ndo and 
ethtool ops that are used when BACKUP feature is enabled.

One difference with the 3 netdev model compared to the 2 netdev model is that
the 'bypass' netdev is created with 'noqueue' qdisc marked as 'NETIF_F_LLTX'. 
This avoids going through an additional qdisc and acquiring an additional
qdisc and tx lock during transmits.
If we can replace the qdisc of virtio netdev dynamically, it should be
possible to get these optimizations enabled even with 2 netdev model when
BACKUP feature is enabled.

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

Sridhar Samudrala (3):
  virtio_net: Introduce VIRTIO_NET_F_BACKUP feature bit
  virtio_net: Extend virtio to use VF datapath when available
  virtio_net: Enable alternate datapath without creating an additional
    netdev

 drivers/net/virtio_net.c        | 564 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   3 +
 2 files changed, 563 insertions(+), 4 deletions(-)

-- 
2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

