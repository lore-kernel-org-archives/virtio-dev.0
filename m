Return-Path: virtio-dev-return-3691-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DFCE581916B
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Apr 2018 02:33:38 -0700 (PDT)
From: Si-Wei Liu <si-wei.liu@oracle.com>
Date: Sun,  1 Apr 2018 05:13:07 -0400
Message-Id: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] [RFC PATCH 0/3] Userspace compatible driver model for virtio_bypass
To: mst@redhat.com, jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This RFC patch series attempts to hide the lower netdevs for virtio_bypass
from userspace visibility, and tighten up the association between virtio_bypass
and the lower passthrough netdev to be enslaved by binding to a specific device
identifier explicitly. This in turn has the benefits of taking the merit of the
2-netdev driver model from netvsc (userspace compliance) to a perfect sense,
while keeping the internal implementation still a 3-netdev model. There's no
loss of feature such as XDP, and continously adding improvements for performance
and features thanks to the good bypass nature of the 3-netdev model are also
possible in the long run.

As said, this change should make the code sharing between netvsc and virtio_bypass
easier and more approachable, as I think the concerns Stephen pointed out was
mainly regarding userspace compatibility and not the hardware offloading
tunables on the VF slave that had to be exposed to netvsc users today, if I'm
not mistaken.

Jiri expressed concerns around the weak check depending on MAC address only
during enslavement and we really need to do strict checks more than that. With
the change to requiring user explicitly specifying the passthrough device
to which virtio_bypass is expected to be bound, virtio_bypass now would match
device based on the PCI slot info in device tree, rather than rely on MAC
address inadvertently. In addition, the PCI slot info passed in will be helpful
to accommodate udevd to name the virtio_bypass interface specifically, making
a transparent and automatic upgrade from existing VF setup to virtio_bypass
possible (expect udevd patch to come later on).

Since I'd like to get the discussion going as early as possible, this series
just shows essential changes to a minimal set. Although not included in the
series, I would like to remind ahead that a few neccessary pieces must be built
upon the assumption of hidden lower netdevs and explicit binding. Such as
sysfs interfaces for udev's naming of virtio_bypass interace. Such as passing
down HW offloading configs to the active lower slave, and making it persistent
across live migration. And so on..

The current patch series is based on Sridhar's v4 patch "Enable virtio to act
as a backup for a passthru device", but I can resync anyway to his upcoming
version once posted.


Si-Wei Liu (1):
  qemu: virtio-bypass should explicitly bind to a passthrough device

 hw/net/virtio-net.c                         | 29 ++++++++++++-
 include/hw/pci/pci.h                        |  3 ++
 include/hw/virtio/virtio-net.h              |  2 +
 include/standard-headers/linux/virtio_net.h |  1 +
 qdev-monitor.c                              | 64 +++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

Si-Wei Liu (2):
  netdev: kernel-only IFF_HIDDEN netdevice
  virtio_net: make lower netdevs for virtio_bypass hidden

 drivers/net/virtio_net.c        | 159 +++++++++++++++++++++--
 include/linux/netdevice.h       |  12 ++
 include/net/net_namespace.h     |   2 +
 include/uapi/linux/virtio_net.h |   2 +
 net/core/dev.c                  | 281 +++++++++++++++++++++++++++++++++++-----
 net/core/net_namespace.c        |   1 +
 6 files changed, 411 insertions(+), 46 deletions(-)

-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

