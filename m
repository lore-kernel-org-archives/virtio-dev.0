Return-Path: virtio-dev-return-2893-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CF76858191AA
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Jan 2018 16:35:49 -0800 (PST)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue,  2 Jan 2018 16:35:36 -0800
Message-Id: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH net-next 0/2] Enable virtio to act as a master for a passthru device
To: mst@redhat.com, stephen@networkplumber.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, sridhar.samudrala@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series enables virtio to switch over to a VF datapath when a VF
netdev is present with the same MAC address. It allows live migration of a VM
with a direct attached VF without the need to setup a bond/team between a
VF and virtio net device in the guest.

The hypervisor needs to unplug the VF device from the guest on the source
host and reset the MAC filter of the VF to initiate failover of datapath to
virtio before starting the migration. After the migration is completed, the
destination hypervisor sets the MAC filter on the VF and plugs it back to
the guest to switch over to VF datapath.

It is based on netvsc implementation and it may be possible to make this code 
generic and move it to a common location that can be shared by netvsc and virtio.

This patch series is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Sridhar Samudrala (2):
  virtio_net: Introduce VIRTIO_NET_F_MASTER feature bit
  virtio_net: Extend virtio to use VF datapath when available

 drivers/net/virtio_net.c        | 308 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   1 +
 2 files changed, 306 insertions(+), 3 deletions(-)

-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

