Return-Path: <virtio-dev-return-8672-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E33F9863D0
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 10:34:23 +0000 (UTC)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 16 Sep 2021 11:33:34 +0100
Message-Id: <20210916103336.7243-1-cristian.marussi@arm.com>
Subject: [virtio-dev] [PATCH 1/3] firmware: arm_scmi: Review some virtio log messages
Content-Type: text/plain; charset="US-ASCII"
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, cristian.marussi@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Tryshnivskyy@opensynergy.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Be more verbose avoiding to use _once flavour of dev_info/_err/_notice.
Remove usage of __func_ to identify which vqueue is referred in some error
messages and explicitly name the TX/RX vqueue.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Apply on sudeep/for-next/scmi on top of:

440320fdecdb ("firmware: arm_scmi: Fix virtio transport Kconfig dependency")
---
 drivers/firmware/arm_scmi/virtio.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 224577f86928..9a758d294693 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -94,8 +94,8 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
 
 	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
 	if (rc)
-		dev_err_once(vioch->cinfo->dev,
-			     "failed to add to virtqueue (%d)\n", rc);
+		dev_err(vioch->cinfo->dev,
+			"failed to add to RX virtqueue (%d)\n", rc);
 	else
 		virtqueue_kick(vioch->vqueue);
 
@@ -187,8 +187,8 @@ static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
 static int virtio_link_supplier(struct device *dev)
 {
 	if (!scmi_vdev) {
-		dev_notice_once(dev,
-				"Deferring probe after not finding a bound scmi-virtio device\n");
+		dev_notice(dev,
+			   "Deferring probe after not finding a bound scmi-virtio device\n");
 		return -EPROBE_DEFER;
 	}
 
@@ -328,9 +328,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
 	if (rc) {
 		list_add(&msg->list, &vioch->free_list);
-		dev_err_once(vioch->cinfo->dev,
-			     "%s() failed to add to virtqueue (%d)\n", __func__,
-			     rc);
+		dev_err(vioch->cinfo->dev,
+			"failed to add to TX virtqueue (%d)\n", rc);
 	} else {
 		virtqueue_kick(vioch->vqueue);
 	}
@@ -418,10 +417,10 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 			sz /= DESCRIPTORS_PER_TX_MSG;
 
 		if (sz > MSG_TOKEN_MAX) {
-			dev_info_once(dev,
-				      "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
-				      channels[i].is_rx ? "rx" : "tx",
-				      sz, MSG_TOKEN_MAX);
+			dev_info(dev,
+				 "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
+				 channels[i].is_rx ? "rx" : "tx",
+				 sz, MSG_TOKEN_MAX);
 			sz = MSG_TOKEN_MAX;
 		}
 		channels[i].max_msg = sz;
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

