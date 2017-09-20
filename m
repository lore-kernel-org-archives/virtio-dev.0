Return-Path: virtio-dev-return-2559-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 88D825819260
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2017 09:05:28 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed, 20 Sep 2017 18:05:22 +0200
Message-Id: <13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
In-Reply-To: <cover.1505923516.git.tgolembi@redhat.com>
References: <cover.1505923516.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 1/1] virtio-balloon: include buffers and chached memory statistics
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 2 ++
 include/standard-headers/linux/virtio_balloon.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a705e0ec55..0434784c14 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -49,6 +49,8 @@ static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
+   [VIRTIO_BALLOON_S_BUFFERS] = "stat-linux-buffers",
+   [VIRTIO_BALLOON_S_CACHED] = "stat-linux-cached",
    [VIRTIO_BALLOON_S_NR] = NULL
 };
 
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd066..d61efbfcee 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -52,7 +52,9 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc */
+#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
+#define VIRTIO_BALLOON_S_NR       9
 
 /*
  * Memory statistics structure.
-- 
2.14.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

