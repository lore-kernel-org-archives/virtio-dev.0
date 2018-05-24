Return-Path: virtio-dev-return-4150-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 26D131CB80F0
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 03:33:33 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 24 May 2018 18:33:30 +0800
Message-Id: <20180524103336.21233-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH 0/6] Support host notifiers in vhost-user
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch set depends on below patch set:

http://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05335.html

More details about this patch set can be found from:

http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01779.html
http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04626.html

Best regards,
Tiwei Bie

Tiwei Bie (6):
  vhost: allow backends to filter memory sections
  vhost-user: allow slave to send fds via slave channel
  vhost-user: introduce shared vhost-user state
  vhost-user: support registering external host notifiers
  libvhost-user: support host notifier
  vhost-user-bridge: support host notifier

 backends/cryptodev-vhost-user.c       |  20 ++-
 contrib/libvhost-user/libvhost-user.c |  81 ++++++++++--
 contrib/libvhost-user/libvhost-user.h |  32 +++++
 docs/interop/vhost-user.txt           |  38 ++++++
 hw/block/vhost-user-blk.c             |  22 +++-
 hw/scsi/vhost-user-scsi.c             |  20 ++-
 hw/virtio/Makefile.objs               |   2 +-
 hw/virtio/vhost-stub.c                |  10 ++
 hw/virtio/vhost-user.c                | 182 +++++++++++++++++++++++---
 hw/virtio/vhost.c                     |   9 +-
 include/hw/virtio/vhost-backend.h     |   4 +
 include/hw/virtio/vhost-user-blk.h    |   2 +
 include/hw/virtio/vhost-user-scsi.h   |   2 +
 include/hw/virtio/vhost-user.h        |  28 ++++
 net/vhost-user.c                      |  44 +++++--
 tests/vhost-user-bridge.c             |  98 +++++++++++++-
 16 files changed, 550 insertions(+), 44 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

