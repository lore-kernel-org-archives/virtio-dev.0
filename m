Return-Path: <kvm-owner@vger.kernel.org>
Date: Mon, 14 Feb 2022 19:59:08 +0000
Message-Id: <20220214195908.4070138-1-kalutes@google.com>
Mime-Version: 1.0
Subject: [PATCH] Virtio-balloon: add user space API for sizing
From: Kameron Lutes <kalutes@google.com>
Content-Type: text/plain; charset="UTF-8"
To: "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org
Cc: Suleiman Souhlal <suleiman@chromium.org>, Charles William Dick <cwd@google.com>, Kameron Lutes <kalutes@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This new linux API will allow user space applications to directly
control the size of the virtio-balloon. This is useful in
situations where the guest must quickly respond to drastically
increased memory pressure and cannot wait for the host to adjust
the balloon's size.

Under the current wording of the Virtio spec, guest driven
behavior such as this is permitted:

VIRTIO Version 1.1 Section 5.5.6
"The device is driven either by the receipt of a configuration
change notification, or by changing guest memory needs, such as
performing memory compaction or responding to out of memory
conditions."

The intended use case for this API is one where the host
communicates a deflation limit to the guest. The guest may then
choose to respond to memory pressure by deflating its balloon down
to the guest's allowable limit.

Signed-off-by: Kameron Lutes <kalutes@google.com>
---
 drivers/virtio/virtio_balloon.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f4c34a2a6b8e..aa06305a3137 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -878,6 +878,54 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 	return register_shrinker(&vb->shrinker);
 }
 
+static ssize_t balloon_size_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
+	u32 num_pages;
+
+	/*
+	 * Read the size directly from the balloon's configuration.
+	 * The caller expects the balloon size enforced by the host,
+	 * not the actual balloon size
+	 */
+	virtio_cread(vdev, struct virtio_balloon_config, num_pages,
+		     &num_pages);
+
+	return sprintf(buf, "0x%x", num_pages);
+}
+
+static ssize_t balloon_size_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
+	u32 num_pages;
+	int err;
+
+	err = kstrtou32(buf, 0, &num_pages);
+
+	if (err < 0) {
+		dev_err(dev, "Failed to read balloon size from file\n");
+		return err;
+	}
+
+	/*
+	 * Write num_pages back to the balloon's config section
+	 */
+	virtio_cwrite_le(vdev, struct virtio_balloon_config, num_pages,
+		      &num_pages);
+
+	/*
+	 * Signal to the balloon that the configuration has changed.
+	 * This triggers any necessary resizing actions
+	 */
+	virtballoon_changed(vdev);
+
+	return count;
+}
+static DEVICE_ATTR_RW(balloon_size);
+
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
@@ -1015,12 +1063,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	err = device_create_file(&vb->vdev->dev, &dev_attr_balloon_size);
+	if (err)
+		goto out_unregister_page_reporting;
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
 
+out_unregister_page_reporting:
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+		page_reporting_unregister(&vb->pr_dev_info);
 out_unregister_oom:
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
-- 
2.35.1.265.g69c8d7142f-goog

