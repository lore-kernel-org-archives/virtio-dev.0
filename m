Return-Path: virtio-dev-return-2960-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 62626581911D
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jan 2018 21:58:51 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 11 Jan 2018 21:58:37 -0800
Message-Id: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v2 0/2] Enable virtio to act as a backup for a passthru device
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series extends virtio_net to take over VF datapath by
simulating a transparent bond without creating any additional netdev.

I understand that there are some comments suggesting an alternate model
that is based on 3 driver model(virtio_net, VF driver, a new driver 
virt_bond that acts as a master to virtio_net and VF).

Would like to get some feedback on the right way to solve the live
migration problem with direct attached devices in KVM environment.

Stephen,
Is the netvsc transparent bond implemenation robust enough and deployed
in real environments? Or would netvsc switch over to a 3-driver model if
that solution becomes available?

Can we start with this implementation that is similar to netvsc and if
needed we can move to the 3 driver model later?

This patch series enables virtio to switch over to a VF datapath when a 
VF netdev is present with the same MAC address. It allows live migration 
of a VM with a direct attached VF without the need to setup a bond/team
between a VF and virtio net device in the guest.

The hypervisor needs to unplug the VF device from the guest on the source
host and reset the MAC filter of the VF to initiate failover of datapath
to virtio before starting the migration. After the migration is completed,
the destination hypervisor sets the MAC filter on the VF and plugs it back
to the guest to switch over to VF datapath.

It is based on netvsc implementation and it should be possible to make this
code generic and move it to a common location that can be shared by netvsc
and virtio.

This patch series is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

v2:
- Changed VIRTIO_NET_F_MASTER to VIRTIO_NET_F_BACKUP (mst)
- made a small change to the virtio-net xmit path to only use VF datapath
  for unicasts. Broadcasts/multicasts use virtio datapath. This avoids
  east-west broadcasts to go over the PCI link.
- added suppport for the feature bit in qemu

Sridhar Samudrala (2):
  virtio_net: Introduce VIRTIO_NET_F_BACKUP feature bit
  virtio_net: Extend virtio to use VF datapath when available

 drivers/net/virtio_net.c        | 309 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   3 +
 2 files changed, 309 insertions(+), 3 deletions(-)

Sridhar Samudrala (1):
  qemu: Introduce VIRTIO_NET_F_BACKUP feature bit to virtio_net

 hw/net/virtio-net.c                         | 2 ++
 include/standard-headers/linux/virtio_net.h | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

