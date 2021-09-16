Return-Path: <virtio-dev-return-8674-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02BDE9863D6
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 10:34:30 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 16 Sep 2021 11:33:36 +0100
Message-Id: <20210916103336.7243-3-cristian.marussi@arm.com>
In-Reply-To: <20210916103336.7243-1-cristian.marussi@arm.com>
References: <20210916103336.7243-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH 3/3] firmware: arm_scmi: Add proper barriers to scmi virtio device
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Tryshnivskyy@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Only one single SCMI Virtio device is currently supported by this driver
and it is referenced using a static global variable which is initialized
once for all during probing and nullified at virtio device removal.

Add proper SMP barriers to protect accesses to such device reference to
ensure that the initialzation state of such device is correctly observed by
all PEs at any time.

Return -EBUSY, instead of -EINVAL, and a descriptive error message if more
than one SCMI Virtio device is ever found and probed.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 633b5bc379a4..3671986ea056 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -389,8 +389,11 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
 
 	/* Only one SCMI VirtiO device allowed */
-	if (scmi_vdev)
-		return -EINVAL;
+	if (scmi_vdev) {
+		dev_err(dev,
+			"One SCMI Virtio device was already initialized: only one allowed.\n");
+		return -EBUSY;
+	}
 
 	have_vq_rx = scmi_vio_have_vq_rx(vdev);
 	vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
@@ -433,7 +436,8 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	}
 
 	vdev->priv = channels;
-	scmi_vdev = vdev;
+	/* Ensure initialized scmi_vdev is visible */
+	smp_store_mb(scmi_vdev, vdev);
 
 	return 0;
 }
@@ -449,7 +453,8 @@ static void scmi_vio_remove(struct virtio_device *vdev)
 	 */
 	vdev->config->reset(vdev);
 	vdev->config->del_vqs(vdev);
-	scmi_vdev = NULL;
+	/* Ensure scmi_vdev is visible as NULL */
+	smp_store_mb(scmi_vdev, NULL);
 }
 
 static int scmi_vio_validate(struct virtio_device *vdev)
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

