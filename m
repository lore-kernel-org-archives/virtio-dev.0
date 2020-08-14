Return-Path: virtio-dev-return-7640-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49EA2985DAE
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Aug 2020 02:40:08 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 13 Aug 2020 19:39:37 -0700
Message-Id: <20200814024000.2485-2-gurchetansingh@chromium.org>
In-Reply-To: <20200814024000.2485-1-gurchetansingh@chromium.org>
References: <20200814024000.2485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 01/24] drm/virtio: Revert "drm/virtio: Call the right shmem helpers"
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: kraxel@redhat.com, mst@redhat.com, vgoyal@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This reverts commit d323bb44e4d23802eb25d13de1f93f2335bd60d0.

Fixes a double-free regression:

[    4.357928]  drm_gem_shmem_free_object+0xb4/0x100
[    4.358983]  virtio_gpu_dequeue_ctrl_func+0xd9/0x290
[    4.360343]  process_one_work+0x1d2/0x3a0
[    4.361581]  worker_thread+0x45/0x3c0
[    4.362645]  kthread+0xf6/0x130
[    4.363543]  ? process_one_work+0x3a0/0x3a0
[    4.364770]  ? kthread_park+0x80/0x80
[    4.365799]  ret_from_fork+0x35/0x40
[    4.367103] Modules linked in:
[    4.367958] CR2: 0000000000000018
[    4.368857] ---[ end trace db84f7a2974d5c79 ]---
[    4.370118] RIP: 0010:dma_direct_unmap_sg+0x1f/0x60

In addition, virtio has it's own set of dma-ops so there's not an
obviously clean way to transition to shmem helpers.

Fixes: d323bb44e4d2 ("drm/virtio: Call the right shmem helpers")
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virt=
io/virtgpu_object.c
index 346cef5ce251..1359eb8f1a02 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -150,7 +150,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_=
gpu_device *vgdev,
 =09if (ret < 0)
 =09=09return -EINVAL;
=20
-=09shmem->pages =3D drm_gem_shmem_get_pages_sgt(&bo->base.base);
+=09/*
+=09 * virtio_gpu uses drm_gem_shmem_get_sg_table instead of
+=09 * drm_gem_shmem_get_pages_sgt because virtio has it's own set of
+=09 * dma-ops. This is discouraged for other drivers, but should be fine
+=09 * since virtio_gpu doesn't support dma-buf import from other devices.
+=09 */
+=09shmem->pages =3D drm_gem_shmem_get_sg_table(&bo->base.base);
 =09if (!shmem->pages) {
 =09=09drm_gem_shmem_unpin(&bo->base.base);
 =09=09return -EINVAL;
--=20
2.24.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

