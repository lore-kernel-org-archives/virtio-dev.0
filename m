Return-Path: virtio-dev-return-2752-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 323855818F75
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 04:14:52 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  5 Dec 2017 13:14:46 +0100
Message-Id: <938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
In-Reply-To: <cover.1512476043.git.tgolembi@redhat.com>
References: <cover.1512476043.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 1/1] virtio-balloon: include statistics of disk/file caches
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 1 +
 include/standard-headers/linux/virtio_balloon.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38982..8141326a51 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -50,6 +50,7 @@ static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
+   [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
    [VIRTIO_BALLOON_S_NR] = NULL
 };
 
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd066..7b0a41b8fc 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -52,7 +52,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
+#define VIRTIO_BALLOON_S_NR       8
 
 /*
  * Memory statistics structure.
-- 
2.15.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

