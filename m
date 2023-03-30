Return-Path: <virtio-dev-return-11862-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FB9C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE66F21180
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84D86986758
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D20A9865BA; Thu, 30 Mar 2023 21:50:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4632986563
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Mar 2023 21:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="226745727"
IronPort-SDR: Y6yqjj2ly2PkzYPT2BZodstLB2hmmCo1QYmDxLdwv9Hdbq59SRVzfkx5qR9pgGek9xsb1tI6Km
 YxzhI4hsTw/8QJThpIcuh/I3Ky0MeS8mKnWOmrL+jaLW6DVUbp/lBh7JLOEx8cvieBIzHHg8Tu
 siaLHBQWGOXqStkYRThRlM+PbSgIvKddk0XKcFwrmrbs1JNzc+Kca5S7WfL1B9TGj2nxsOCHIA
 YZtOd5n11a1hCafQewrs4fDFfYL97QdFiyuPmJDyGCui0LAPKC/PJKOKxadJADppQpvb3GUs17
 ElQ=
IronPort-SDR: DNvGBiq89+ZAQJlWk3BqyqkYzKCO/2v/F1gd7R/I6LgvpyUPRbBjFHdso6rFzxziCulUKYkrh/
 tENgRzamSf6jpHM+NOCreBYdFJVcBX9QsnKAIBa988xqK400Usuq+hoVuuOFzQGfaDGN2UX0OO
 PurFpJYjJx5dwVrMdWsLK8umP2+eGv3udnZQiBNFLT2Q84pdA2BkzNOSNue6gULJE16W7trw1w
 9x3lT0PX6oIsH1MrrPeArXLbV2JW56fvpK4FEUx32X/usacniiyGW1H4x+GyiDWqDyasKPvSHJ
 0Hg=
WDCIronportException: Internal
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Thu, 30 Mar 2023 17:49:53 -0400
Message-Id: <20230330214953.1088216-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 2/2] virtio-blk: fix ZBD probe in kernels without ZBD support

When the kernel is built without support for zoned block devices,
virtio-blk probe needs to error out any host-managed device scans
to prevent such devices from appearing in the system as non-zoned.
The current virtio-blk code simply bypasses all ZBD checks if
CONFIG_BLK_DEV_ZONED is not defined and this leads to host-managed
block devices being presented as non-zoned in the OS. This is one of
the main problems this patch series is aimed to fix.

In this patch, make VIRTIO_BLK_F_ZONED feature defined even when
CONFIG_BLK_DEV_ZONED is not. This change makes the code compliant with
the voted revision of virtio-blk ZBD spec. Modify the probe code to
look at the situation when VIRTIO_BLK_F_ZONED is negotiated in a kernel
that is built without ZBD support. In this case, the code checks
the zoned model of the device and fails the probe is the device
is host-managed.

The patch also adds the comment to clarify that the call to perform
the zoned device probe is correctly placed after virtio_device ready().

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/virtio_blk.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4f0dbbb3d4a5..2b918e28acaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -866,16 +866,12 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
-}
-
 #else
 
 /*
  * Zoned block device support is not configured in this kernel.
- * We only need to define a few symbols to avoid compilation errors.
+ * Host-managed zoned devices can't be supported, but others are
+ * good to go as regular block devices.
  */
 #define virtblk_report_zones       NULL
 
@@ -886,12 +882,16 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	return -EOPNOTSUPP;
-}
+	u8 model;
 
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return false;
+	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
+	if (model == VIRTIO_BLK_Z_HM) {
+		dev_err(&vdev->dev,
+			"virtio_blk: zoned devices are not supported");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1577,7 +1577,11 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtblk_has_zoned_feature(vdev)) {
+	/*
+	 * All steps that follow use the VQs therefore they need to be
+	 * placed after the virtio_device_ready() call above.
+	 */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
@@ -1683,10 +1687,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
-	VIRTIO_BLK_F_SECURE_ERASE,
-#ifdef CONFIG_BLK_DEV_ZONED
-	VIRTIO_BLK_F_ZONED,
-#endif /* CONFIG_BLK_DEV_ZONED */
+	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
 };
 
 static struct virtio_driver virtio_blk = {
-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

