Return-Path: virtio-dev-return-6509-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A5C99860C9
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 17:13:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 Dec 2019 18:11:34 +0100
Message-Id: <20191212171137.13872-11-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC v4 10/13] virtio-mem: Better retry handling
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's start with a retry interval of 30 seconds and double the time until
we reach 30 minutes, in case we keep getting errors. Reset the retry
interval in case we succeeded.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 807d4e393427..3a57434f92ed 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -137,7 +137,9 @@ struct virtio_mem {
=20
 =09/* Timer for retrying to plug/unplug memory. */
 =09struct hrtimer retry_timer;
-#define VIRTIO_MEM_RETRY_TIMER_MS=09=0930000
+=09unsigned int retry_timer_ms;
+#define VIRTIO_MEM_RETRY_TIMER_MIN_MS=09=0930000
+#define VIRTIO_MEM_RETRY_TIMER_MAX_MS=09=091800000
=20
 =09/* Memory notifier (online/offline events). */
 =09struct notifier_block memory_notifier;
@@ -1537,6 +1539,7 @@ static void virtio_mem_run_wq(struct work_struct *wor=
k)
=20
 =09switch (rc) {
 =09case 0:
+=09=09vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 =09=09break;
 =09case -ENOSPC:
 =09=09/*
@@ -1552,8 +1555,7 @@ static void virtio_mem_run_wq(struct work_struct *wor=
k)
 =09=09 */
 =09case -ENOMEM:
 =09=09/* Out of memory, try again later. */
-=09=09hrtimer_start(&vm->retry_timer,
-=09=09=09      ms_to_ktime(VIRTIO_MEM_RETRY_TIMER_MS),
+=09=09hrtimer_start(&vm->retry_timer, ms_to_ktime(vm->retry_timer_ms),
 =09=09=09      HRTIMER_MODE_REL);
 =09=09break;
 =09case -EAGAIN:
@@ -1573,6 +1575,9 @@ static enum hrtimer_restart virtio_mem_timer_expired(=
struct hrtimer *timer)
 =09=09=09=09=09     retry_timer);
=20
 =09virtio_mem_retry(vm);
+=09/* Racy (with reset in virtio_mem_run_wq), we ignore that for now. */
+=09vm->retry_timer_ms =3D min_t(unsigned int, vm->retry_timer_ms * 2,
+=09=09=09=09   VIRTIO_MEM_RETRY_TIMER_MAX_MS);
 =09return HRTIMER_NORESTART;
 }
=20
@@ -1746,6 +1751,7 @@ static int virtio_mem_probe(struct virtio_device *vde=
v)
 =09spin_lock_init(&vm->removal_lock);
 =09hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 =09vm->retry_timer.function =3D virtio_mem_timer_expired;
+=09vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
=20
 =09/* register the virtqueue */
 =09rc =3D virtio_mem_init_vq(vm);
--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

