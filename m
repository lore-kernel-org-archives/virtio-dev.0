Return-Path: virtio-dev-return-7735-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0148D985ECA
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:08:59 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:27 -0700
Message-Id: <20200902210847.2689-4-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 03/23] drm/virtio: report uuid in debugfs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

In keeping with other features, report this in the debugfs.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/vir=
tio/virtgpu_debugfs.c
index 3221520f61f0c..d5b0c543bd6d7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -48,6 +48,7 @@ static int virtio_gpu_features(struct seq_file *m, void *=
data)
 =09virtio_add_bool(m, "virgl", vgdev->has_virgl_3d);
 =09virtio_add_bool(m, "edid", vgdev->has_edid);
 =09virtio_add_bool(m, "indirect", vgdev->has_indirect);
+=09virtio_add_bool(m, "resource uuid", vgdev->has_resource_assign_uuid);
 =09virtio_add_int(m, "cap sets", vgdev->num_capsets);
 =09virtio_add_int(m, "scanouts", vgdev->num_scanouts);
 =09return 0;
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

