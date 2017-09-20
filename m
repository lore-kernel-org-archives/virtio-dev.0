Return-Path: virtio-dev-return-2558-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 53F92581925E
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2017 09:05:28 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed, 20 Sep 2017 18:05:21 +0200
Message-Id: <cover.1505923516.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 0/1] Buffers/caches in VirtIO Balloon driver stats
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is a QEMU counterpart to the patch for VirtIO balloon driver posted here:

https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg05720.html

Tomáš Golembiovský (1):
  virtio-balloon: include buffers and chached memory statistics

 hw/virtio/virtio-balloon.c                      | 2 ++
 include/standard-headers/linux/virtio_balloon.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.14.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

