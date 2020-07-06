Return-Path: virtio-dev-return-7527-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0834B9849EB
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jul 2020 21:14:04 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 06 Jul 2020 14:14:00 -0700
Message-ID: <20200706211400.20018.89031.stgit@localhost.localdomain>
In-Reply-To: <20200706211314.20018.89695.stgit@localhost.localdomain>
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 1/3] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a430a..0c0fd7114799 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

