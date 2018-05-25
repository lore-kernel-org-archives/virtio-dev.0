Return-Path: virtio-dev-return-4180-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 888C758191DB
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 May 2018 04:04:36 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 25 May 2018 19:04:36 +0800
Message-Id: <20180525110441.7185-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2 0/5] Support host notifiers in vhost-user
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

More details about this patch set can be found from:

http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01779.html
http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04626.html

v1 -> v2:
- Drop the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD patch; (MST)
- In PATCH 2/5, for net/vhost-user, only save VhostUserState
  in queue index 0, i.e. where `chr` is saved;
- In PATCH 4/5, check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
  before sending msg (including fd) to master; (MST)

Tiwei Bie (5):
  vhost: allow backends to filter memory sections
  vhost-user: introduce shared vhost-user state
  vhost-user: support registering external host notifiers
  libvhost-user: support host notifier
  vhost-user-bridge: support host notifier

 backends/cryptodev-vhost-user.c       |  20 +++-
 contrib/libvhost-user/libvhost-user.c |  80 +++++++++++--
 contrib/libvhost-user/libvhost-user.h |  31 +++++
 docs/interop/vhost-user.txt           |  33 ++++++
 hw/block/vhost-user-blk.c             |  22 +++-
 hw/scsi/vhost-user-scsi.c             |  20 +++-
 hw/virtio/Makefile.objs               |   2 +-
 hw/virtio/vhost-stub.c                |  10 ++
 hw/virtio/vhost-user.c                | 165 ++++++++++++++++++++++++--
 hw/virtio/vhost.c                     |   9 +-
 include/hw/virtio/vhost-backend.h     |   4 +
 include/hw/virtio/vhost-user-blk.h    |   2 +
 include/hw/virtio/vhost-user-scsi.h   |   2 +
 include/hw/virtio/vhost-user.h        |  28 +++++
 net/vhost-user.c                      |  57 ++++++---
 tests/vhost-user-bridge.c             |  98 ++++++++++++++-
 16 files changed, 542 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

