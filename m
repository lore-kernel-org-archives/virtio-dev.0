Return-Path: virtio-dev-return-3153-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AB1425818FA1
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Feb 2018 03:27:24 -0800 (PST)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  6 Feb 2018 19:08:16 +0800
Message-Id: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v2 0/3] virtio-balloon: free page hint reporting support
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is the deivce part implementation to add a new feature,
VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
receives the guest free page hints from the driver and clears the
corresponding bits in the dirty bitmap, so that those free pages are
not transferred by the migration thread to the destination.

Please see the driver patch link for test results:
https://lkml.org/lkml/2018/2/4/60

ChangeLog:
v1->v2: 
    1) virtio-balloon
        - use subsections to save free_page_report_cmd_id;
        - poll the free page vq after sending a cmd id to the driver;
        - change the free page vq size to VIRTQUEUE_MAX_SIZE;
        - virtio_balloon_poll_free_page_hints: handle the corner case
          that the free page block reported from the driver may cross
          the RAMBlock boundary.
    2) migration/ram.c
        - use balloon_free_page_poll to start the optimization

Wei Wang (3):
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  migration: use the free page reporting feature from balloon
  virtio-balloon: add a timer to limit the free page report waiting time

 balloon.c                                       |  39 ++--
 hw/virtio/virtio-balloon.c                      | 227 ++++++++++++++++++++++--
 hw/virtio/virtio-pci.c                          |   3 +
 include/hw/virtio/virtio-balloon.h              |  15 +-
 include/migration/misc.h                        |   3 +
 include/standard-headers/linux/virtio_balloon.h |   7 +
 include/sysemu/balloon.h                        |  12 +-
 migration/ram.c                                 |  34 +++-
 8 files changed, 307 insertions(+), 33 deletions(-)

-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

