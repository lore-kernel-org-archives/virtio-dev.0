Return-Path: virtio-dev-return-7736-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85882985EC6
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Sep 2020 21:09:00 +0000 (UTC)
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Wed,  2 Sep 2020 14:08:28 -0700
Message-Id: <20200902210847.2689-5-gurchetansingh@chromium.org>
In-Reply-To: <20200902210847.2689-1-gurchetansingh@chromium.org>
References: <20200902210847.2689-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 04/23] virtio: Add get_shm_region method
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: sebastien.boeuf@intel.com, kraxel@redhat.com, vgoyal@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Virtio defines 'shared memory regions' that provide a continuously
shared region between the host and guest.

Provide a method to find a particular region on a device.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 include/linux/virtio_config.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8fe857e27ef32..4b8e38c5c4d8c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -11,6 +11,11 @@
=20
 struct irq_affinity;
=20
+struct virtio_shm_region {
+=09u64 addr;
+=09u64 len;
+};
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -66,6 +71,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_shm_region: get a shared memory region based on the index.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -89,6 +95,8 @@ struct virtio_config_ops {
 =09=09=09       const struct cpumask *cpu_mask);
 =09const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 =09=09=09int index);
+=09bool (*get_shm_region)(struct virtio_device *vdev,
+=09=09=09       struct virtio_shm_region *region, u8 id);
 };
=20
 /* If driver didn't advertise the feature, it will never appear. */
@@ -251,6 +259,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const=
 struct cpumask *cpu_mask)
 =09return 0;
 }
=20
+static inline
+bool virtio_get_shm_region(struct virtio_device *vdev,
+=09=09=09   struct virtio_shm_region *region, u8 id)
+{
+=09if (!vdev->config->get_shm_region)
+=09=09return false;
+=09return vdev->config->get_shm_region(vdev, region, id);
+}
+
 static inline bool virtio_is_little_endian(struct virtio_device *vdev)
 {
 =09return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
--=20
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

