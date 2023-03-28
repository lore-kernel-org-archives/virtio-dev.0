Return-Path: <virtio-dev-return-11805-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D583C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A0DEE150E28
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9830C98648A
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8B028986405; Tue, 28 Mar 2023 02:29:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BD829863E6
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 02:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="226460244"
IronPort-SDR: UrXNEJ9wY6IYLdWbWY2V6nCqdT8w2q/1+S/SDWEnOqsY7CO65ED6k2ZaNYbSEEjrFgC9oSgIqf
 AXFGMp9mAnI1P3Ijuo1KZhRpKGyig4UP8z4yciJspYuwnOADXQQBj+mZNFhtNIdRdp+eW0hHk6
 ZrJ0vWLDdvf50q/vitdJmrtFA2quSqrgdRTKqoSMu9DcwCdMJwxdkN2Ldch3/0mlEtWg7Q3GkZ
 0GouNoz9ERIB4eBvFenjmAI44r6XJZ/ma7xfzFVH7N3aoJ1ZJYDUNR91vI+JP/ns9FaatT3jd9
 Iv4=
IronPort-SDR: 0/0GEX6ngGBREaUzdfSBf8lYe2pQ3uS29PJdD1JWhlRzyTmjYNYXreUtYy2S4LksHPnpkpT4ox
 DGA0y7IYpeBui8TvXkEU/vohl4NTbGlmUJ3rY1W3u5YPGGubmDts7dKz24AWT+3AzwBGh78UCj
 GrUzhUcV3jV7pNKY2AxXBm+6ktj4EYpX+492RUptqyKaHbEFDkI7Szkp2HmOdR/1i9DPuOZUaS
 C3//8gljkO1bgab95eTq6D3yLIVlWfVFaiBixK1izdawHda/Dnfjg2dcfCN6NpFh1vt1kzyJsc
 I4k=
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
Date: Mon, 27 Mar 2023 22:29:28 -0400
Message-Id: <20230328022928.1003996-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 2/2] virtio-blk: fix ZBD probe in kernels without ZBD support

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
---
 drivers/block/virtio_blk.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0b49fd2bd3bf..6d2674aa0551 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -867,16 +867,12 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
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
+ * Host-managed zoned devices can't be supported, but others are good
+ * to go as regular block devices.
  */
 #define virtblk_report_zones       NULL
 static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
@@ -885,11 +881,16 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
 static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			struct virtio_blk *vblk, struct request_queue *q)
 {
-	return -EOPNOTSUPP;
-}
-static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
-{
-	return false;
+	u8 model;
+
+	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
+	if (model == VIRTIO_BLK_Z_HM) {
+		dev_err(&vdev->dev,
+			"zoned devices are not supported by the kernel");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
@@ -1575,7 +1576,11 @@ static int virtblk_probe(struct virtio_device *vdev)
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
@@ -1681,10 +1686,7 @@ static unsigned int features[] = {
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

