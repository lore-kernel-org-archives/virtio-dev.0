Return-Path: virtio-dev-return-7737-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80C2F985F5A
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:08:55 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:26 -0700
Message-Id: <20200902210847.2689-3-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 02/23] drm/virtio: fix uninitialized variable
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

smatch reported this with the blob series:

drivers/gpu/drm/virtio/virtgpu_kms.c:227 virtio_gpu_init()
error: uninitialized symbol 'ret'.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/=
virtgpu_kms.c
index 5ba389e0a02fb..06af537b0091d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -105,7 +105,7 @@ int virtio_gpu_init(struct drm_device *dev)
 =09/* this will expand later */
 =09struct virtqueue *vqs[2];
 =09u32 num_scanouts, num_capsets;
-=09int ret;
+=09int ret =3D 0;
=20
 =09if (!virtio_has_feature(dev_to_virtio(dev->dev), VIRTIO_F_VERSION_1))
 =09=09return -ENODEV;
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

