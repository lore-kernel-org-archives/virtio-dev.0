Return-Path: <virtio-dev-return-9951-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A1C29863A4
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Sep 2022 02:29:26 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Sun, 18 Sep 2022 22:29:19 -0400
Message-Id: <20220919022921.946344-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/3] virtio-blk: use a helper to handle request queuing errors
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
Cc: linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..9a6aa94a212c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -311,6 +311,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hc=
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
@@ -325,10 +338,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_c=
tx *hctx,
 =09blk_mq_start_request(req);
=20
 =09vbr->sg_table.nents =3D virtblk_map_data(hctx, req, vbr);
-=09if (unlikely(vbr->sg_table.nents < 0)) {
-=09=09virtblk_cleanup_cmd(req);
-=09=09return BLK_STS_RESOURCE;
-=09}
+=09if (unlikely(vbr->sg_table.nents < 0))
+=09=09return virtblk_fail_to_queue(req, -ENOMEM);
=20
 =09return BLK_STS_OK;
 }
@@ -360,15 +371,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_c=
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

