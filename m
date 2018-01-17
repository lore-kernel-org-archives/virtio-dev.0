Return-Path: virtio-dev-return-2979-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D6ACA1CB807D
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Jan 2018 22:50:13 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:31:56 +0800
Message-Id: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 0/4] virtio-balloon: support free page reporting
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is the deivce part implementation to add a new feature,
VIRTIO_BALLOON_F_FREE_PAGE_VQ to the virtio-balloon device. The device
receives the guest free page hint from the driver and clears the
corresponding bits in the dirty bitmap, so that those free pages are
not transferred to the destination. Please see the results in the
commit log of patch 1.

Link to the driver patches:
https://marc.info/?l=kvm&m=151616696828185&w=2

Wei Wang (4):
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
  migration: call balloon to clear bits of free pages from dirty bitmap
  virtio-balloon: add a timer to limit the free page report wating time
  virtio-balloon: Don't skip free pages if the poison val is non-zero

 balloon.c                                       |  46 ++++-
 hw/virtio/virtio-balloon.c                      | 224 ++++++++++++++++++++++--
 hw/virtio/virtio-pci.c                          |   3 +
 include/hw/virtio/virtio-balloon.h              |  12 +-
 include/migration/misc.h                        |   3 +
 include/standard-headers/linux/virtio_balloon.h |   6 +
 include/sysemu/balloon.h                        |  15 +-
 migration/ram.c                                 |  38 +++-
 8 files changed, 316 insertions(+), 31 deletions(-)

-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

