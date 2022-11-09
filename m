Return-Path: <virtio-dev-return-10131-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DEB259864CF
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 04:52:40 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Tue,  8 Nov 2022 23:46:31 -0500
Message-Id: <20221109044632.3121790-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
References: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6 1/2] virtio-blk: use a helper to handle request queuing errors
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..3efe3da5f8c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -315,6 +315,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hc=
tx)
 =09=09virtqueue_notify(vq->vq);
 }
=20
+static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
+{
+=09virtblk_cleanup_cmd(req);
+=09switch (rc) {
+=09case -ENOSPC:
+=09=09return BLK_STS_DEV_RESOURCE;
+=09case -ENOMEM:
+=09=09return BLK_STS_RESOURCE;
+=09default:
+=09=09return BLK_STS_IOERR;
+=09}
+}
+
 static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 =09=09=09=09=09struct virtio_blk *vblk,
 =09=09=09=09=09struct request *req,
@@ -327,10 +340,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_c=
tx *hctx,
 =09=09return status;
=20
 =09vbr->sg_table.nents =3D virtblk_map_data(hctx, req, vbr);
-=09if (unlikely(vbr->sg_table.nents < 0)) {
-=09=09virtblk_cleanup_cmd(req);
-=09=09return BLK_STS_RESOURCE;
-=09}
+=09if (unlikely(vbr->sg_table.nents < 0))
+=09=09return virtblk_fail_to_queue(req, -ENOMEM);
=20
 =09blk_mq_start_request(req);
=20
@@ -364,15 +375,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_c=
tx *hctx,
 =09=09=09blk_mq_stop_hw_queue(hctx);
 =09=09spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 =09=09virtblk_unmap_data(req, vbr);
-=09=09virtblk_cleanup_cmd(req);
-=09=09switch (err) {
-=09=09case -ENOSPC:
-=09=09=09return BLK_STS_DEV_RESOURCE;
-=09=09case -ENOMEM:
-=09=09=09return BLK_STS_RESOURCE;
-=09=09default:
-=09=09=09return BLK_STS_IOERR;
-=09=09}
+=09=09return virtblk_fail_to_queue(req, err);
 =09}
=20
 =09if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

