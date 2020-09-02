Return-Path: virtio-dev-return-7756-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDBB9986048
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:51 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:45 -0700
Message-Id: <20200902210847.2689-22-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 21/23] drm/virtio: implement blob resources: report blob mem to userspace
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The stride field has never been used, so repurpose it to be
"blob_mem". This way, userspace can know the memory properties
of the blob if it's passed between userspace processes and
no suitable userspace API exists to transmit that knowledge.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Acked-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 0075995a9f5b8..7dbe24248a200 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -300,6 +300,9 @@ static int virtio_gpu_resource_info_ioctl(struct drm_de=
vice *dev, void *data,
=20
 =09ri->size =3D qobj->base.base.size;
 =09ri->res_handle =3D qobj->hw_res_handle;
+=09if (qobj->host3d_blob || qobj->guest_blob)
+=09=09ri->blob_mem =3D qobj->blob_mem;
+
 =09drm_gem_object_put(gobj);
 =09return 0;
 }
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

