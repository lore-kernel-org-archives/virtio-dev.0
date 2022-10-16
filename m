Return-Path: <virtio-dev-return-10021-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B11C98620E
	for <virtio-dev@lists.oasis-open.org>; Sun, 16 Oct 2022 03:41:35 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Sat, 15 Oct 2022 23:41:27 -0400
Message-Id: <20221016034127.330942-3-dmitry.fomichev@wdc.com>
In-Reply-To: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 2/2] virtio-blk: add support for zoned block devices
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch adds support for Zoned Block Devices (ZBDs) to the kernel
virtio-blk driver.

The patch accompanies the virtio-blk ZBD support draft that is now
being proposed for standardization. The latest version of the draft is
linked at

https://github.com/oasis-tcs/virtio-spec/issues/143 .

The QEMU zoned device code that implements these protocol extensions
has been developed by Sam Li and it is currently in review at the QEMU
mailing list.

A number of virtblk request structure changes has been introduced to
accommodate the functionality that is specific to zoned block devices
and, most importantly, make room for carrying the Zoned Append sector
value from the device back to the driver along with the request status.

The zone-specific code in the patch is heavily influenced by NVMe ZNS
code in drivers/nvme/host/zns.c, but it is simpler because the proposed
virtio ZBD draft only covers the zoned device features that are
relevant to the zoned functionality provided by Linux block layer.

Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 drivers/block/virtio_blk.c      | 377 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h | 105 +++++++++
 2 files changed, 464 insertions(+), 18 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3efe3da5f8c2..c9ad590816f8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -80,22 +80,51 @@ struct virtio_blk {
 =09int num_vqs;
 =09int io_queues[HCTX_MAX_TYPES];
 =09struct virtio_blk_vq *vqs;
+
+=09/* For zoned device */
+=09unsigned int zone_sectors;
 };
=20
 struct virtblk_req {
+=09/* Out header */
 =09struct virtio_blk_outhdr out_hdr;
-=09u8 status;
+
+=09/* In header */
+=09union {
+=09=09u8 status;
+
+=09=09/*
+=09=09 * The zone append command has an extended in header.
+=09=09 * The status field in zone_append_in_hdr must have
+=09=09 * the same offset in virtblk_req as the non-zoned
+=09=09 * status field above.
+=09=09 */
+=09=09struct {
+=09=09=09u8 status;
+=09=09=09u8 reserved[7];
+=09=09=09u64 append_sector;
+=09=09} zone_append_in_hdr;
+=09};
+
+=09size_t in_hdr_len;
+
 =09struct sg_table sg_table;
 =09struct scatterlist sg[];
 };
=20
-static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
+static inline blk_status_t virtblk_result(u8 status)
 {
-=09switch (vbr->status) {
+=09switch (status) {
 =09case VIRTIO_BLK_S_OK:
 =09=09return BLK_STS_OK;
 =09case VIRTIO_BLK_S_UNSUPP:
 =09=09return BLK_STS_NOTSUPP;
+=09case VIRTIO_BLK_S_ZONE_OPEN_RESOURCE:
+=09=09return BLK_STS_ZONE_OPEN_RESOURCE;
+=09case VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE:
+=09=09return BLK_STS_ZONE_ACTIVE_RESOURCE;
+=09case VIRTIO_BLK_S_IOERR:
+=09case VIRTIO_BLK_S_ZONE_UNALIGNED_WP:
 =09default:
 =09=09return BLK_STS_IOERR;
 =09}
@@ -111,11 +140,11 @@ static inline struct virtio_blk_vq *get_virtio_blk_vq=
(struct blk_mq_hw_ctx *hctx
=20
 static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
 {
-=09struct scatterlist hdr, status, *sgs[3];
+=09struct scatterlist out_hdr, in_hdr, *sgs[3];
 =09unsigned int num_out =3D 0, num_in =3D 0;
=20
-=09sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
-=09sgs[num_out++] =3D &hdr;
+=09sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
+=09sgs[num_out++] =3D &out_hdr;
=20
 =09if (vbr->sg_table.nents) {
 =09=09if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
@@ -124,8 +153,8 @@ static int virtblk_add_req(struct virtqueue *vq, struct=
 virtblk_req *vbr)
 =09=09=09sgs[num_out + num_in++] =3D vbr->sg_table.sgl;
 =09}
=20
-=09sg_init_one(&status, &vbr->status, sizeof(vbr->status));
-=09sgs[num_out + num_in++] =3D &status;
+=09sg_init_one(&in_hdr, &vbr->status, vbr->in_hdr_len);
+=09sgs[num_out + num_in++] =3D &in_hdr;
=20
 =09return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
@@ -214,21 +243,22 @@ static blk_status_t virtblk_setup_cmd(struct virtio_d=
evice *vdev,
 =09=09=09=09      struct request *req,
 =09=09=09=09      struct virtblk_req *vbr)
 {
+=09size_t in_hdr_len =3D sizeof(vbr->status);
 =09bool unmap =3D false;
 =09u32 type;
+=09u64 sector =3D 0;
=20
-=09vbr->out_hdr.sector =3D 0;
+=09/* Set fields for all request types */
+=09vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
=20
 =09switch (req_op(req)) {
 =09case REQ_OP_READ:
 =09=09type =3D VIRTIO_BLK_T_IN;
-=09=09vbr->out_hdr.sector =3D cpu_to_virtio64(vdev,
-=09=09=09=09=09=09      blk_rq_pos(req));
+=09=09sector =3D blk_rq_pos(req);
 =09=09break;
 =09case REQ_OP_WRITE:
 =09=09type =3D VIRTIO_BLK_T_OUT;
-=09=09vbr->out_hdr.sector =3D cpu_to_virtio64(vdev,
-=09=09=09=09=09=09      blk_rq_pos(req));
+=09=09sector =3D blk_rq_pos(req);
 =09=09break;
 =09case REQ_OP_FLUSH:
 =09=09type =3D VIRTIO_BLK_T_FLUSH;
@@ -243,16 +273,42 @@ static blk_status_t virtblk_setup_cmd(struct virtio_d=
evice *vdev,
 =09case REQ_OP_SECURE_ERASE:
 =09=09type =3D VIRTIO_BLK_T_SECURE_ERASE;
 =09=09break;
-=09case REQ_OP_DRV_IN:
-=09=09type =3D VIRTIO_BLK_T_GET_ID;
+=09case REQ_OP_ZONE_OPEN:
+=09=09type =3D VIRTIO_BLK_T_ZONE_OPEN;
+=09=09sector =3D blk_rq_pos(req);
 =09=09break;
+=09case REQ_OP_ZONE_CLOSE:
+=09=09type =3D VIRTIO_BLK_T_ZONE_CLOSE;
+=09=09sector =3D blk_rq_pos(req);
+=09=09break;
+=09case REQ_OP_ZONE_FINISH:
+=09=09type =3D VIRTIO_BLK_T_ZONE_FINISH;
+=09=09sector =3D blk_rq_pos(req);
+=09=09break;
+=09case REQ_OP_ZONE_APPEND:
+=09=09type =3D VIRTIO_BLK_T_ZONE_APPEND;
+=09=09sector =3D blk_rq_pos(req);
+=09=09in_hdr_len =3D sizeof(vbr->zone_append_in_hdr);
+=09=09break;
+=09case REQ_OP_ZONE_RESET:
+=09=09type =3D VIRTIO_BLK_T_ZONE_RESET;
+=09=09sector =3D blk_rq_pos(req);
+=09=09break;
+=09case REQ_OP_ZONE_RESET_ALL:
+=09=09type =3D VIRTIO_BLK_T_ZONE_RESET_ALL;
+=09=09break;
+=09case REQ_OP_DRV_IN:
+=09=09/* Out header already filled in, nothing to do */
+=09=09return 0;
 =09default:
 =09=09WARN_ON_ONCE(1);
 =09=09return BLK_STS_IOERR;
 =09}
=20
+=09/* Set fields for non-REQ_OP_DRV_IN request types */
+=09vbr->in_hdr_len =3D in_hdr_len;
 =09vbr->out_hdr.type =3D cpu_to_virtio32(vdev, type);
-=09vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
+=09vbr->out_hdr.sector =3D cpu_to_virtio64(vdev, sector);
=20
 =09if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_=
ZEROES ||
 =09    type =3D=3D VIRTIO_BLK_T_SECURE_ERASE) {
@@ -266,10 +322,15 @@ static blk_status_t virtblk_setup_cmd(struct virtio_d=
evice *vdev,
 static inline void virtblk_request_done(struct request *req)
 {
 =09struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
+=09int status =3D virtblk_result(vbr->status);
=20
 =09virtblk_unmap_data(req, vbr);
 =09virtblk_cleanup_cmd(req);
-=09blk_mq_end_request(req, virtblk_result(vbr));
+
+=09if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
+=09=09req->__sector =3D le64_to_cpu(vbr->zone_append_in_hdr.append_sector)=
;
+
+=09blk_mq_end_request(req, status);
 }
=20
 static void virtblk_done(struct virtqueue *vq)
@@ -455,6 +516,266 @@ static void virtio_queue_rqs(struct request **rqlist)
 =09*rqlist =3D requeue_list;
 }
=20
+#ifdef CONFIG_BLK_DEV_ZONED
+static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
+=09=09=09=09=09  unsigned int nr_zones,
+=09=09=09=09=09  unsigned int zone_sectors,
+=09=09=09=09=09  size_t *buflen)
+{
+=09struct request_queue *q =3D vblk->disk->queue;
+=09size_t bufsize;
+=09void *buf;
+
+=09nr_zones =3D min_t(unsigned int, nr_zones,
+=09=09=09 get_capacity(vblk->disk) >> ilog2(zone_sectors));
+
+=09bufsize =3D sizeof(struct virtio_blk_zone_report) +
+=09=09nr_zones * sizeof(struct virtio_blk_zone_descriptor);
+=09bufsize =3D min_t(size_t, bufsize,
+=09=09=09queue_max_hw_sectors(q) << SECTOR_SHIFT);
+=09bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT)=
;
+
+=09while (bufsize >=3D sizeof(struct virtio_blk_zone_report)) {
+=09=09buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+=09=09if (buf) {
+=09=09=09*buflen =3D bufsize;
+=09=09=09return buf;
+=09=09}
+=09=09bufsize >>=3D 1;
+=09}
+
+=09return NULL;
+}
+
+static int virtblk_submit_zone_report(struct virtio_blk *vblk,
+=09=09=09=09       char *report_buf, size_t report_len,
+=09=09=09=09       sector_t sector)
+{
+=09struct request_queue *q =3D vblk->disk->queue;
+=09struct request *req;
+=09struct virtblk_req *vbr;
+=09int err;
+
+=09req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
+=09if (IS_ERR(req))
+=09=09return PTR_ERR(req);
+
+=09vbr =3D blk_mq_rq_to_pdu(req);
+=09vbr->in_hdr_len =3D sizeof(vbr->status);
+=09vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REP=
ORT);
+=09vbr->out_hdr.sector =3D cpu_to_virtio64(vblk->vdev, sector);
+
+=09err =3D blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
+=09if (err)
+=09=09goto out;
+
+=09blk_execute_rq(req, false);
+=09err =3D blk_status_to_errno(virtblk_result(vbr->status));
+out:
+=09blk_mq_free_request(req);
+=09return err;
+}
+
+static int virtblk_parse_zone(struct virtio_blk *vblk,
+=09=09=09       struct virtio_blk_zone_descriptor *entry,
+=09=09=09       unsigned int idx, unsigned int zone_sectors,
+=09=09=09       report_zones_cb cb, void *data)
+{
+=09struct blk_zone zone =3D { };
+
+=09if (entry->z_type !=3D VIRTIO_BLK_ZT_SWR &&
+=09    entry->z_type !=3D VIRTIO_BLK_ZT_SWP &&
+=09    entry->z_type !=3D VIRTIO_BLK_ZT_CONV) {
+=09=09dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
+=09=09=09entry->z_type);
+=09=09return -EINVAL;
+=09}
+
+=09zone.type =3D entry->z_type;
+=09zone.cond =3D entry->z_state;
+=09zone.len =3D zone_sectors;
+=09zone.capacity =3D le64_to_cpu(entry->z_cap);
+=09zone.start =3D le64_to_cpu(entry->z_start);
+=09if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
+=09=09zone.wp =3D zone.start + zone.len;
+=09else
+=09=09zone.wp =3D le64_to_cpu(entry->z_wp);
+
+=09return cb(&zone, idx, data);
+}
+
+static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
+=09=09=09=09 unsigned int nr_zones, report_zones_cb cb,
+=09=09=09=09 void *data)
+{
+=09struct virtio_blk *vblk =3D disk->private_data;
+=09struct virtio_blk_zone_report *report;
+=09unsigned int zone_sectors =3D vblk->zone_sectors;
+=09unsigned int nz, i;
+=09int ret, zone_idx =3D 0;
+=09size_t buflen;
+
+=09if (WARN_ON_ONCE(!vblk->zone_sectors))
+=09=09return -EOPNOTSUPP;
+
+=09report =3D virtblk_alloc_report_buffer(vblk, nr_zones,
+=09=09=09=09=09     zone_sectors, &buflen);
+=09if (!report)
+=09=09return -ENOMEM;
+
+=09while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
+=09=09memset(report, 0, buflen);
+
+=09=09ret =3D virtblk_submit_zone_report(vblk, (char *)report,
+=09=09=09=09=09=09 buflen, sector);
+=09=09if (ret) {
+=09=09=09if (ret > 0)
+=09=09=09=09ret =3D -EIO;
+=09=09=09goto out_free;
+=09=09}
+=09=09nz =3D min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
+=09=09if (!nz)
+=09=09=09break;
+
+=09=09for (i =3D 0; i < nz && zone_idx < nr_zones; i++) {
+=09=09=09ret =3D virtblk_parse_zone(vblk, &report->zones[i],
+=09=09=09=09=09=09 zone_idx, zone_sectors, cb, data);
+=09=09=09if (ret)
+=09=09=09=09goto out_free;
+=09=09=09sector =3D le64_to_cpu(report->zones[i].z_start) + zone_sectors;
+=09=09=09zone_idx++;
+=09=09}
+=09}
+
+=09if (zone_idx > 0)
+=09=09ret =3D zone_idx;
+=09else
+=09=09ret =3D -EINVAL;
+out_free:
+=09kvfree(report);
+=09return ret;
+}
+
+static void virtblk_revalidate_zones(struct virtio_blk *vblk)
+{
+=09u8 model;
+
+=09if (!vblk->zone_sectors)
+=09=09return;
+
+=09virtio_cread(vblk->vdev, struct virtio_blk_config,
+=09=09     zoned.model, &model);
+=09if (!blk_revalidate_disk_zones(vblk->disk, NULL))
+=09=09set_capacity_and_notify(vblk->disk, 0);
+}
+
+static int virtblk_probe_zoned_device(struct virtio_device *vdev,
+=09=09=09=09       struct virtio_blk *vblk,
+=09=09=09=09       struct request_queue *q)
+{
+=09u32 v;
+=09u8 model;
+=09int ret;
+
+=09virtio_cread(vdev, struct virtio_blk_config,
+=09=09     zoned.model, &model);
+
+=09switch (model) {
+=09case VIRTIO_BLK_Z_NONE:
+=09=09return 0;
+=09case VIRTIO_BLK_Z_HM:
+=09=09break;
+=09case VIRTIO_BLK_Z_HA:
+=09=09/*
+=09=09 * Present the host-aware device as a regular drive.
+=09=09 * TODO It is possible to add an option to make it appear
+=09=09 * in the system as a zoned drive.
+=09=09 */
+=09=09return 0;
+=09default:
+=09=09dev_err(&vdev->dev, "unsupported zone model %d\n", model);
+=09=09return -EINVAL;
+=09}
+
+=09dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
+
+=09disk_set_zoned(vblk->disk, BLK_ZONED_HM);
+=09blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+
+=09virtio_cread(vdev, struct virtio_blk_config,
+=09=09     zoned.max_open_zones, &v);
+=09disk_set_max_open_zones(vblk->disk, le32_to_cpu(v));
+
+=09dev_dbg(&vdev->dev, "max open zones =3D %u\n", le32_to_cpu(v));
+
+=09virtio_cread(vdev, struct virtio_blk_config,
+=09=09     zoned.max_active_zones, &v);
+=09disk_set_max_active_zones(vblk->disk, le32_to_cpu(v));
+=09dev_dbg(&vdev->dev, "max active zones =3D %u\n", le32_to_cpu(v));
+
+=09virtio_cread(vdev, struct virtio_blk_config,
+=09=09     zoned.write_granularity, &v);
+=09if (!v) {
+=09=09dev_warn(&vdev->dev, "zero write granularity reported\n");
+=09=09return -ENODEV;
+=09}
+=09blk_queue_physical_block_size(q, le32_to_cpu(v));
+=09blk_queue_io_min(q, le32_to_cpu(v));
+
+=09dev_dbg(&vdev->dev, "write granularity =3D %u\n", le32_to_cpu(v));
+
+=09/*
+=09 * virtio ZBD specification doesn't require zones to be a power of
+=09 * two sectors in size, but the code in this driver expects that.
+=09 */
+=09virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
+=09vblk->zone_sectors =3D le32_to_cpu(v);
+=09if (vblk->zone_sectors =3D=3D 0 || !is_power_of_2(vblk->zone_sectors)) =
{
+=09=09dev_err(&vdev->dev,
+=09=09=09"zoned device with non power of two zone size %u\n",
+=09=09=09vblk->zone_sectors);
+=09=09return -ENODEV;
+=09}
+=09dev_dbg(&vdev->dev, "zone sectors =3D %u\n", vblk->zone_sectors);
+
+=09if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
+=09=09dev_warn(&vblk->vdev->dev,
+=09=09=09 "ignoring negotiated F_DISCARD for zoned device\n");
+=09=09blk_queue_max_discard_sectors(q, 0);
+=09}
+
+=09ret =3D blk_revalidate_disk_zones(vblk->disk, NULL);
+=09if (!ret) {
+=09=09virtio_cread(vdev, struct virtio_blk_config,
+=09=09=09     zoned.max_append_sectors, &v);
+=09=09if (!v) {
+=09=09=09dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
+=09=09=09return -ENODEV;
+=09=09}
+=09=09blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
+=09=09dev_dbg(&vdev->dev, "max append sectors =3D %u\n", le32_to_cpu(v));
+=09}
+
+=09return ret;
+}
+
+#else
+
+/*
+ * Zoned block device support is not configured in this kernel.
+ * We only need to define a few symbols to avoid compilation errors.
+ */
+#define virtblk_report_zones       NULL
+static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
+{
+}
+static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
+=09=09=09struct virtio_blk *vblk, struct request_queue *q)
+{
+=09return -EOPNOTSUPP;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 /* return id (s/n) string for *disk to *id_str
  */
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
@@ -462,18 +783,24 @@ static int virtblk_get_id(struct gendisk *disk, char =
*id_str)
 =09struct virtio_blk *vblk =3D disk->private_data;
 =09struct request_queue *q =3D vblk->disk->queue;
 =09struct request *req;
+=09struct virtblk_req *vbr;
 =09int err;
=20
 =09req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
 =09if (IS_ERR(req))
 =09=09return PTR_ERR(req);
=20
+=09vbr =3D blk_mq_rq_to_pdu(req);
+=09vbr->in_hdr_len =3D sizeof(vbr->status);
+=09vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
+=09vbr->out_hdr.sector =3D 0;
+
 =09err =3D blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL=
);
 =09if (err)
 =09=09goto out;
=20
 =09blk_execute_rq(req, false);
-=09err =3D blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
+=09err =3D blk_status_to_errno(virtblk_result(vbr->status));
 out:
 =09blk_mq_free_request(req);
 =09return err;
@@ -524,6 +851,7 @@ static const struct block_device_operations virtblk_fop=
s =3D {
 =09.owner  =09=3D THIS_MODULE,
 =09.getgeo=09=09=3D virtblk_getgeo,
 =09.free_disk=09=3D virtblk_free_disk,
+=09.report_zones=09=3D virtblk_report_zones,
 };
=20
 static int index_to_minor(int index)
@@ -594,6 +922,7 @@ static void virtblk_config_changed_work(struct work_str=
uct *work)
 =09struct virtio_blk *vblk =3D
 =09=09container_of(work, struct virtio_blk, config_work);
=20
+=09virtblk_revalidate_zones(vblk);
 =09virtblk_update_capacity(vblk, true);
 }
=20
@@ -1150,6 +1479,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 =09virtblk_update_capacity(vblk, false);
 =09virtio_device_ready(vdev);
=20
+=09if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+=09=09err =3D virtblk_probe_zoned_device(vdev, vblk, q);
+=09=09if (err)
+=09=09=09goto out_cleanup_disk;
+=09}
+
+=09dev_info(&vdev->dev, "blk config size: %zu\n",
+=09=09sizeof(struct virtio_blk_config));
+
 =09err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
 =09if (err)
 =09=09goto out_cleanup_disk;
@@ -1251,6 +1589,9 @@ static unsigned int features[] =3D {
 =09VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 =09VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 =09VIRTIO_BLK_F_SECURE_ERASE,
+#ifdef CONFIG_BLK_DEV_ZONED
+=09VIRTIO_BLK_F_ZONED,
+#endif /* CONFIG_BLK_DEV_ZONED */
 };
=20
 static struct virtio_driver virtio_blk =3D {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_bl=
k.h
index 58e70b24b504..3744e4da1b2a 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -41,6 +41,7 @@
 #define VIRTIO_BLK_F_DISCARD=0913=09/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES=0914=09/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE=0916 /* Secure Erase is supported */
+#define VIRTIO_BLK_F_ZONED=09=0917=09/* Zoned block device */
=20
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -137,6 +138,16 @@ struct virtio_blk_config {
 =09/* Secure erase commands must be aligned to this number of sectors. */
 =09__virtio32 secure_erase_sector_alignment;
=20
+=09/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
+=09struct virtio_blk_zoned_characteristics {
+=09=09__virtio32 zone_sectors;
+=09=09__virtio32 max_open_zones;
+=09=09__virtio32 max_active_zones;
+=09=09__virtio32 max_append_sectors;
+=09=09__virtio32 write_granularity;
+=09=09__u8 model;
+=09=09__u8 unused2[3];
+=09} zoned;
 } __attribute__((packed));
=20
 /*
@@ -174,6 +185,27 @@ struct virtio_blk_config {
 /* Secure erase command */
 #define VIRTIO_BLK_T_SECURE_ERASE=0914
=20
+/* Zone append command */
+#define VIRTIO_BLK_T_ZONE_APPEND    15
+
+/* Report zones command */
+#define VIRTIO_BLK_T_ZONE_REPORT    16
+
+/* Open zone command */
+#define VIRTIO_BLK_T_ZONE_OPEN      18
+
+/* Close zone command */
+#define VIRTIO_BLK_T_ZONE_CLOSE     20
+
+/* Finish zone command */
+#define VIRTIO_BLK_T_ZONE_FINISH    22
+
+/* Reset zone command */
+#define VIRTIO_BLK_T_ZONE_RESET     24
+
+/* Reset All zones command */
+#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER=090x80000000
@@ -193,6 +225,72 @@ struct virtio_blk_outhdr {
 =09__virtio64 sector;
 };
=20
+/*
+ * Supported zoned device models.
+ */
+
+/* Regular block device */
+#define VIRTIO_BLK_Z_NONE      0
+/* Host-managed zoned device */
+#define VIRTIO_BLK_Z_HM        1
+/* Host-aware zoned device */
+#define VIRTIO_BLK_Z_HA        2
+
+/*
+ * Zone descriptor. A part of VIRTIO_BLK_T_ZONE_REPORT command reply.
+ */
+struct virtio_blk_zone_descriptor {
+=09/* Zone capacity */
+=09__virtio64 z_cap;
+=09/* The starting sector of the zone */
+=09__virtio64 z_start;
+=09/* Zone write pointer position in sectors */
+=09__virtio64 z_wp;
+=09/* Zone type */
+=09__u8 z_type;
+=09/* Zone state */
+=09__u8 z_state;
+=09__u8 reserved[38];
+};
+
+struct virtio_blk_zone_report {
+=09__virtio64 nr_zones;
+=09__u8 reserved[56];
+=09struct virtio_blk_zone_descriptor zones[];
+};
+
+/*
+ * Supported zone types.
+ */
+
+/* Conventional zone */
+#define VIRTIO_BLK_ZT_CONV         1
+/* Sequential Write Required zone */
+#define VIRTIO_BLK_ZT_SWR          2
+/* Sequential Write Preferred zone */
+#define VIRTIO_BLK_ZT_SWP          3
+
+/*
+ * Zone states that are available for zones of all types.
+ */
+
+/* Not a write pointer (conventional zones only) */
+#define VIRTIO_BLK_ZS_NOT_WP       0
+/* Empty */
+#define VIRTIO_BLK_ZS_EMPTY        1
+/* Implicitly Open */
+#define VIRTIO_BLK_ZS_IOPEN        2
+/* Explicitly Open */
+#define VIRTIO_BLK_ZS_EOPEN        3
+/* Closed */
+#define VIRTIO_BLK_ZS_CLOSED       4
+/* Read-Only */
+#define VIRTIO_BLK_ZS_RDONLY       13
+/* Full */
+#define VIRTIO_BLK_ZS_FULL         14
+/* Offline */
+#define VIRTIO_BLK_ZS_OFFLINE      15
+
 /* Unmap this range (only valid for write zeroes command) */
 #define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP=090x00000001
=20
@@ -219,4 +317,11 @@ struct virtio_scsi_inhdr {
 #define VIRTIO_BLK_S_OK=09=090
 #define VIRTIO_BLK_S_IOERR=091
 #define VIRTIO_BLK_S_UNSUPP=092
+
+/* Error codes that are specific to zoned block devices */
+#define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
+#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP    4
+#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
+#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
+
 #endif /* _LINUX_VIRTIO_BLK_H */
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

