Return-Path: virtio-dev-return-3473-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D9E41CB8088
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Mar 2018 19:26:01 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Date: Wed,  7 Mar 2018 22:25:38 -0500
Message-Id: <cover.1520450515.git.jbaron@akamai.com>
Subject: [virtio-dev] [PATCH v2 0/3] virtio-net: allow linkspeed and duplex setting
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

Linux can now read linkspeed and duplex settings as set by the
hypervisor:

faa9b39 virtio_net: propagate linkspeed/duplex settings from the hypervisor

This series thus adds qemu support.

Also, this patchset depends on this header sync:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg07072.html

Thanks,

-Jason

v2
-pull in include/linux/ethtool.h (Michael Tsirkin)

Jason Baron (3):
  scripts/update-linux-headers: add ethtool.h and update to 4.16.0-rc4
  virtio-net: use 64-bit values for feature flags
  virtio-net: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                      |   81 +-
 include/hw/virtio/virtio-net.h           |    5 +-
 include/standard-headers/linux/ethtool.h | 1821 ++++++++++++++++++++++++++++++
 include/standard-headers/linux/input.h   |    4 +-
 include/standard-headers/linux/kernel.h  |   15 +
 include/standard-headers/linux/sysinfo.h |   25 +
 linux-headers/asm-x86/kvm_para.h         |    1 +
 linux-headers/linux/kvm.h                |    2 +
 scripts/update-linux-headers.sh          |   11 +-
 9 files changed, 1934 insertions(+), 31 deletions(-)
 create mode 100644 include/standard-headers/linux/ethtool.h
 create mode 100644 include/standard-headers/linux/kernel.h
 create mode 100644 include/standard-headers/linux/sysinfo.h

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

