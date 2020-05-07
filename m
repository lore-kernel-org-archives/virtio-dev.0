Return-Path: virtio-dev-return-7281-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBA64985ECA
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 14:03:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 May 2020 16:01:38 +0200
Message-Id: <20200507140139.17083-15-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4 14/15] virtio-mem: Use -ETXTBSY as error code if the device is busy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's be able to distinguish if the device or if memory is busy.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a719e1a04ac7..abd93b778a26 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -893,7 +893,7 @@ static int virtio_mem_send_plug_request(struct virtio_m=
em *vm, uint64_t addr,
 =09case VIRTIO_MEM_RESP_NACK:
 =09=09return -EAGAIN;
 =09case VIRTIO_MEM_RESP_BUSY:
-=09=09return -EBUSY;
+=09=09return -ETXTBSY;
 =09case VIRTIO_MEM_RESP_ERROR:
 =09=09return -EINVAL;
 =09default:
@@ -919,7 +919,7 @@ static int virtio_mem_send_unplug_request(struct virtio=
_mem *vm, uint64_t addr,
 =09=09vm->plugged_size -=3D size;
 =09=09return 0;
 =09case VIRTIO_MEM_RESP_BUSY:
-=09=09return -EBUSY;
+=09=09return -ETXTBSY;
 =09case VIRTIO_MEM_RESP_ERROR:
 =09=09return -EINVAL;
 =09default:
@@ -941,7 +941,7 @@ static int virtio_mem_send_unplug_all_request(struct vi=
rtio_mem *vm)
 =09=09atomic_set(&vm->config_changed, 1);
 =09=09return 0;
 =09case VIRTIO_MEM_RESP_BUSY:
-=09=09return -EBUSY;
+=09=09return -ETXTBSY;
 =09default:
 =09=09return -ENOMEM;
 =09}
@@ -1557,11 +1557,15 @@ static void virtio_mem_run_wq(struct work_struct *w=
ork)
 =09=09 * or we have too many offline memory blocks.
 =09=09 */
 =09=09break;
-=09case -EBUSY:
+=09case -ETXTBSY:
 =09=09/*
 =09=09 * The hypervisor cannot process our request right now
-=09=09 * (e.g., out of memory, migrating) or we cannot free up
-=09=09 * any memory to unplug it (all plugged memory is busy).
+=09=09 * (e.g., out of memory, migrating);
+=09=09 */
+=09case -EBUSY:
+=09=09/*
+=09=09 * We cannot free up any memory to unplug it (all plugged memory
+=09=09 * is busy).
 =09=09 */
 =09case -ENOMEM:
 =09=09/* Out of memory, try again later. */
--=20
2.25.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

