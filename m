Return-Path: virtio-dev-return-2751-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B47F15818FA1
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 04:14:50 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  5 Dec 2017 13:14:45 +0100
Message-Id: <cover.1512476043.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/1] Disk caches in VirtIO Balloon driver stats
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is a QEMU counterpart to the patch for VirtIO balloon driver posted here:

https://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg02106.html

Tomáš Golembiovský (1):
  virtio-balloon: include statistics of disk/file caches

 hw/virtio/virtio-balloon.c                      | 1 +
 include/standard-headers/linux/virtio_balloon.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.15.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

