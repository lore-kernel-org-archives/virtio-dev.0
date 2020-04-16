Return-Path: virtio-dev-return-7085-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 362AA986014
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 19:30:43 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Apr 2020 12:30:38 -0700
Message-ID: <20200416192809.8763.19308.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-balloon: Disable free page hinting/reporting if page
 poison is disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jasowang@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

If we have free page hinting or page reporting enabled we should disable it
if the pages are poisoned or initialized on free and we cannot notify the
hypervisor.

Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page reports to host")

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/virtio/virtio_balloon.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 95d9c2f0a7be..08bc86a6e468 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1110,8 +1110,12 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	/* Tell the host whether we care about poisoned pages. */
 	if (!want_init_on_free() &&
 	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
-	     !page_poisoning_enabled()))
+	     !page_poisoning_enabled())) {
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+	} else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
+	}
 
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

