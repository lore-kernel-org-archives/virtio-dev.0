Return-Path: virtio-dev-return-7514-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F5DC985359
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jun 2020 08:06:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Mon, 29 Jun 2020 10:06:15 +0200
Message-Id: <20200629080615.26022-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2] virtio-balloon: always indicate S_DONE when migration fails
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

If something goes wrong during precopy, before stopping the VM, we will
never send a S_DONE indication to the VM, resulting in the hinted pages
not getting released to be used by the guest OS (e.g., Linux).

Easy to reproduce:
1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
2. Cancel migration (e.g., HMP "migrate_cancel")
3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
   no free memory left.

While at it, add similar locking to virtio_balloon_free_page_done() as
done in virtio_balloon_free_page_stop. Locking is still weird, but that
has to be sorted out separately.

There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
comments regarding S_DONE handling.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a43..8a84718490 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -628,8 +628,13 @@ static void virtio_balloon_free_page_done(VirtIOBalloo=
n *s)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
=20
-    s->free_page_report_status =3D FREE_PAGE_REPORT_S_DONE;
-    virtio_notify_config(vdev);
+    if (s->free_page_report_status !=3D FREE_PAGE_REPORT_S_DONE) {
+        /* See virtio_balloon_free_page_stop() */
+        qemu_mutex_lock(&s->free_page_lock);
+        s->free_page_report_status =3D FREE_PAGE_REPORT_S_DONE;
+        qemu_mutex_unlock(&s->free_page_lock);
+        virtio_notify_config(vdev);
+    }
 }
=20
 static int
@@ -653,17 +658,26 @@ virtio_balloon_free_page_report_notify(NotifierWithRe=
turn *n, void *data)
     case PRECOPY_NOTIFY_SETUP:
         precopy_enable_free_page_optimization();
         break;
-    case PRECOPY_NOTIFY_COMPLETE:
-    case PRECOPY_NOTIFY_CLEANUP:
     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
         virtio_balloon_free_page_stop(dev);
         break;
     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
         if (vdev->vm_running) {
             virtio_balloon_free_page_start(dev);
-        } else {
-            virtio_balloon_free_page_done(dev);
+            break;
         }
+        /*
+         * Set S_DONE before migrating the vmstate, so the guest will reus=
e
+         * all hinted pages once running on the destination. Fall through.
+         */
+    case PRECOPY_NOTIFY_CLEANUP:
+        /*
+         * Especially, if something goes wrong during precopy or if migrat=
ion
+         * is canceled, we have to properly communicate S_DONE to the VM.
+         */
+        virtio_balloon_free_page_done(dev);
+        break;
+    case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
         virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason)=
;
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

