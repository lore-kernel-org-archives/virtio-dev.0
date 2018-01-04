Return-Path: virtio-dev-return-2904-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A17658191C4
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 21:17:20 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  4 Jan 2018 00:16:42 -0500
Message-Id: <cover.1515041373.git.jbaron@akamai.com>
Subject: [virtio-dev] [PATCH v3 0/3] virtio_net: allow hypervisor to indicate linkspeed and duplex setting
To: mst@redhat.com, davem@davemloft.net
Cc: jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

We have found it useful to be able to set the linkspeed and duplex
settings from the host-side for virtio_net. This obviates the need
for guest changes and settings for these fields, and does not require
custom ethtool commands for virtio_net.

The ability to set linkspeed and duplex is useful in various cases
as described here:

16032be virtio_net: add ethtool support for set and get of settings                                                                                                                                                           
Using 'ethtool -s' continues to over-write the linkspeed/duplex
settings with this patch.

The 1/3 patch is against net-next, while the 2-3/3 patch are the associated
qemu changes that would go in after as update-linux-headers.sh should
be run first. So the qemu patches are a demonstration of how I intend this
to work.

Thanks,

-Jason  

linux changes:

changes from v2:
* move speed/duplex read into virtnet_config_changed_work() so link up changes
  are detected

Jason Baron (1):
  virtio_net: propagate linkspeed/duplex settings from the hypervisor

 drivers/net/virtio_net.c        | 19 ++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

qemu changes:

changes from v2:
* if link up return configured speed/duplex, else return UNKNOWN speed and duplex

Jason Baron (2):
  qemu: virtio-net: use 64-bit values for feature flags
  qemu: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                         | 89 ++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h              |  5 +-
 include/standard-headers/linux/virtio_net.h | 13 +++++
 3 files changed, 79 insertions(+), 28 deletions(-)


-- 
2.6.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

