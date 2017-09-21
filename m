Return-Path: virtio-dev-return-2563-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 74AD7581926B
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2017 05:55:48 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu, 21 Sep 2017 14:55:40 +0200
Message-Id: <cover.1505998455.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/1] linux: Buffers/caches in VirtIO Balloon driver stats
To: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Linux driver part

v2:
- fixed typos

Tomáš Golembiovský (1):
  virtio_balloon: include buffers and cached memory statistics

 drivers/virtio/virtio_balloon.c     | 11 +++++++++++
 include/uapi/linux/virtio_balloon.h |  4 +++-
 mm/swap_state.c                     |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.14.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

