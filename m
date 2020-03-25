Return-Path: virtio-dev-return-6979-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1ACBC985ECA
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Mar 2020 10:41:09 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Wed, 25 Mar 2020 19:40:39 +0900
Message-Id: <20200325104039.196058-2-keiichiw@chromium.org>
In-Reply-To: <20200325104039.196058-1-keiichiw@chromium.org>
References: <20200325104039.196058-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH RFC 1/1] drivers: media: virtio: Support virtio objects in virtio-video driver
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Keiichi Watanabe <keiichiw@chromium.org>, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, acourbot@chromium.org, alexlau@chromium.org, egranata@google.com, hverkuil@xs4all.nl, kraxel@redhat.com, posciak@chromium.org, stevensd@chromium.org, tfiga@chromium.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch makes the virtio-video driver use virtio objects as DMA buffers.
So, users will beable to import resources exported by other virtio devices
such as virtio-gpu.

Currently, we assumes that only one virtio object for each v4l2_buffer
format even if it's for a multiplanar format.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 drivers/media/virtio/virtio_video.h        |  26 +++-
 drivers/media/virtio/virtio_video_dec.c    |   1 +
 drivers/media/virtio/virtio_video_device.c | 131 ++++++++++++++++++++-
 drivers/media/virtio/virtio_video_driver.c |  25 +++-
 drivers/media/virtio/virtio_video_vq.c     |  81 ++++++++++---
 include/uapi/linux/virtio_video.h          |  15 ++-
 6 files changed, 243 insertions(+), 36 deletions(-)

diff --git a/drivers/media/virtio/virtio_video.h b/drivers/media/virtio/vir=
tio_video.h
index c5a5704326c0..b74e5a06753f 100644
--- a/drivers/media/virtio/virtio_video.h
+++ b/drivers/media/virtio/virtio_video.h
@@ -25,6 +25,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_video.h>
 #include <linux/list.h>
+#include <media/videobuf2-core.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/v4l2-ctrls.h>
@@ -123,10 +124,17 @@ struct virtio_video_queue {
 =09struct work_struct dequeue_work;
 };

+enum virtio_video_resource_type {
+=09RESOURCE_TYPE_GUEST_PAGES =3D 0,
+=09RESOURCE_TYPE_VIRTIO_OBJECT,
+};
+
 struct virtio_video {
 =09struct v4l2_device v4l2_dev;
 =09int instance;

+=09enum virtio_video_resource_type res_type;
+
 =09struct virtio_device *vdev;
 =09struct virtio_video_queue commandq;
 =09struct virtio_video_queue eventq;
@@ -207,6 +215,9 @@ struct virtio_video_buffer {
 =09struct v4l2_m2m_buffer v4l2_m2m_vb;
 =09uint32_t resource_id;
 =09bool queued;
+
+=09/* Only for virtio object buffer */
+=09uuid_t uuid;
 };

 static inline gfp_t
@@ -300,12 +311,14 @@ int virtio_video_cmd_stream_create(struct virtio_vide=
o *vv, uint32_t stream_id,
 int virtio_video_cmd_stream_destroy(struct virtio_video *vv,
 =09=09=09=09    uint32_t stream_id);
 int virtio_video_cmd_stream_drain(struct virtio_video *vv, uint32_t stream=
_id);
-int virtio_video_cmd_resource_create(struct virtio_video *vv,
-=09=09=09=09     uint32_t stream_id, uint32_t resource_id,
-=09=09=09=09     uint32_t queue_type,
-=09=09=09=09     struct virtio_video_mem_entry *ents,
-=09=09=09=09    unsigned int num_planes,
-=09=09=09=09     unsigned int *num_entry);
+int virtio_video_cmd_resource_create_page(
+=09struct virtio_video *vv, uint32_t stream_id, uint32_t resource_id,
+=09uint32_t queue_type, unsigned int num_planes, unsigned int *num_entries=
,
+=09struct virtio_video_mem_entry *ents);
+int virtio_video_cmd_resource_create_object(
+=09struct virtio_video *vv, uint32_t stream_id, uint32_t resource_id,
+=09uint32_t queue_type, unsigned int num_planes, struct vb2_plane *planes,
+=09struct virtio_video_object_entry *ents);
 int virtio_video_cmd_resource_destroy_all(struct virtio_video *vv,
 =09=09=09=09=09  struct virtio_video_stream *stream,
 =09=09=09=09=09  uint32_t queue_type);
@@ -354,6 +367,7 @@ void virtio_video_mark_drain_complete(struct virtio_vid=
eo_stream *stream,
 int virtio_video_queue_setup(struct vb2_queue *vq, unsigned int *num_buffe=
rs,
 =09=09=09     unsigned int *num_planes, unsigned int sizes[],
 =09=09=09     struct device *alloc_devs[]);
+int virtio_video_buf_prepare(struct vb2_buffer *vb);
 int virtio_video_buf_init(struct vb2_buffer *vb);
 void virtio_video_buf_cleanup(struct vb2_buffer *vb);
 int virtio_video_querycap(struct file *file, void *fh,
diff --git a/drivers/media/virtio/virtio_video_dec.c b/drivers/media/virtio=
/virtio_video_dec.c
index 4b85337bb9f3..5d763191f436 100644
--- a/drivers/media/virtio/virtio_video_dec.c
+++ b/drivers/media/virtio/virtio_video_dec.c
@@ -122,6 +122,7 @@ static void virtio_video_dec_stop_streaming(struct vb2_=
queue *vq)
 static const struct vb2_ops virtio_video_dec_qops =3D {
 =09.queue_setup=09 =3D virtio_video_queue_setup,
 =09.buf_init=09 =3D virtio_video_buf_init,
+=09.buf_prepare=09 =3D virtio_video_buf_prepare,
 =09.buf_cleanup=09 =3D virtio_video_buf_cleanup,
 =09.buf_queue=09 =3D virtio_video_dec_buf_queue,
 =09.start_streaming =3D virtio_video_dec_start_streaming,
diff --git a/drivers/media/virtio/virtio_video_device.c b/drivers/media/vir=
tio/virtio_video_device.c
index 8e6bc317339b..e91107082d97 100644
--- a/drivers/media/virtio/virtio_video_device.c
+++ b/drivers/media/virtio/virtio_video_device.c
@@ -17,6 +17,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */

+#include <linux/dma-buf.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-dma-sg.h>
@@ -49,7 +50,47 @@ int virtio_video_queue_setup(struct vb2_queue *vq, unsig=
ned int *num_buffers,
 =09return 0;
 }

-int virtio_video_buf_init(struct vb2_buffer *vb)
+static int virtio_video_get_dma_buf_id(struct virtio_video_device *vvd,
+=09=09=09  struct vb2_buffer *vb, uuid_t *uuid)
+{
+=09/**
+=09 * For multiplanar formats, we assume all planes are on one DMA buffer.
+=09 */
+=09struct dma_buf *dma_buf =3D dma_buf_get(vb->planes[0].m.fd);
+
+=09return dma_buf_get_uuid(dma_buf, uuid);
+}
+
+static int virtio_video_send_resource_create_object(struct vb2_buffer *vb,
+=09=09=09=09=09=09    uint32_t resource_id,
+=09=09=09=09=09=09    uuid_t uuid)
+{
+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);
+=09struct virtio_video *vv =3D to_virtio_vd(stream->video_dev)->vv;
+=09struct virtio_video_object_entry *ent;
+=09int queue_type;
+=09int ret;
+
+=09if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type))
+=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT;
+=09else
+=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT;
+
+=09ent =3D kcalloc(1, sizeof(*ent), GFP_KERNEL);
+=09uuid_copy((uuid_t *) &ent->uuid, &uuid);
+
+=09ret =3D virtio_video_cmd_resource_create_object(vv, stream->stream_id,
+=09=09=09=09=09=09      resource_id,
+=09=09=09=09=09=09      queue_type,
+=09=09=09=09=09=09      vb->num_planes,
+=09=09=09=09=09=09      vb->planes, ent);
+=09if (ret)
+=09=09kfree(ent);
+
+=09return ret;
+}
+
+static int virtio_video_buf_init_guest_pages(struct vb2_buffer *vb)
 {
 =09int ret =3D 0;
 =09unsigned int i, j;
@@ -109,11 +150,10 @@ int virtio_video_buf_init(struct vb2_buffer *vb)
 =09=09=09=09=09ents[i].addr, ents[i].length);
 =09}

-=09ret =3D virtio_video_cmd_resource_create(vv, stream->stream_id,
-=09=09=09=09=09       resource_id,
-=09=09=09=09=09       to_virtio_queue_type(queue_type),
-=09=09=09=09=09       ents, vb->num_planes,
-=09=09=09=09=09       num_ents);
+=09ret =3D virtio_video_cmd_resource_create_page(
+=09=09vv, stream->stream_id, resource_id,
+=09=09to_virtio_queue_type(queue_type), vb->num_planes, num_ents,
+=09=09ents);
 =09if (ret) {
 =09=09virtio_video_resource_id_put(vvd->vv, resource_id);
 =09=09kfree(ents);
@@ -127,6 +167,85 @@ int virtio_video_buf_init(struct vb2_buffer *vb)
 =09return 0;
 }

+static int virtio_video_buf_init_virtio_object(struct vb2_buffer *vb)
+{
+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);
+=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb(vb);
+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);
+=09struct virtio_video *vv =3D vvd->vv;
+=09int ret;
+=09uint32_t resource_id;
+=09uuid_t uuid;
+
+=09ret =3D virtio_video_get_dma_buf_id(vvd, vb, &uuid);
+=09if (ret) {
+=09=09v4l2_err(&vv->v4l2_dev, "failed to get DMA-buf handle");
+=09=09return ret;
+=09}
+=09virtio_video_resource_id_get(vv, &resource_id);
+
+=09ret =3D virtio_video_send_resource_create_object(vb, resource_id, uuid)=
;
+=09if (ret) {
+=09=09virtio_video_resource_id_put(vv, resource_id);
+=09=09return ret;
+=09}
+
+=09virtio_vb->queued =3D false;
+=09virtio_vb->resource_id =3D resource_id;
+=09virtio_vb->uuid =3D uuid;
+
+=09return 0;
+}
+
+int virtio_video_buf_init(struct vb2_buffer *vb)
+{
+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);
+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);
+=09struct virtio_video *vv =3D vvd->vv;
+
+=09switch (vv->res_type) {
+=09case RESOURCE_TYPE_GUEST_PAGES:
+=09=09return virtio_video_buf_init_guest_pages(vb);
+=09case RESOURCE_TYPE_VIRTIO_OBJECT:
+=09=09return virtio_video_buf_init_virtio_object(vb);
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
+int virtio_video_buf_prepare(struct vb2_buffer *vb)
+{
+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);
+=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb(vb);
+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);
+=09struct virtio_video *vv =3D vvd->vv;
+=09uuid_t uuid;
+=09int ret;
+
+=09if (vv->res_type !=3D RESOURCE_TYPE_VIRTIO_OBJECT)
+=09=09return 0;
+
+=09ret =3D virtio_video_get_dma_buf_id(vvd, vb, &uuid);
+=09if (ret) {
+=09=09v4l2_err(&vv->v4l2_dev, "failed to get DMA-buf handle");
+=09=09return ret;
+=09}
+
+=09/**
+=09 * If a user gave a different object as a buffer from the previous
+=09 * one, send RESOURCE_CREATE again to register the object.
+=09 */
+=09if (!uuid_equal(&uuid, &virtio_vb->uuid)) {
+=09=09ret =3D virtio_video_send_resource_create_object(
+=09=09=09vb, virtio_vb->resource_id, uuid);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09virtio_vb->uuid =3D uuid;
+=09}
+
+=09return ret;
+}
+
 void virtio_video_buf_cleanup(struct vb2_buffer *vb)
 {
 =09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);
diff --git a/drivers/media/virtio/virtio_video_driver.c b/drivers/media/vir=
tio/virtio_video_driver.c
index 2d4fd7671f4f..f01b744587c8 100644
--- a/drivers/media/virtio/virtio_video_driver.c
+++ b/drivers/media/virtio/virtio_video_driver.c
@@ -171,16 +171,27 @@ static int virtio_video_probe(struct virtio_device *v=
dev)
 =09=09virtio_video_cmd_ack,
 =09=09virtio_video_event_ack
 =09};
-
-=09if (!virtio_has_feature(vdev, VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES)) {
-=09=09dev_err(dev, "device must support guest allocated buffers\n");
-=09=09return -ENODEV;
-=09}
-
 =09vv =3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
 =09if (!vv)
 =09=09return -ENOMEM;

+=09/**
+=09 * RESOURCE_GUEST_PAGES is prioritized when both resource type is
+=09 * supported.
+=09 * TODO: Can we provide users with a way of specifying a
+=09 *  resource type when both are supported?
+=09 */
+=09if (virtio_has_feature(vdev, VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES)) {
+=09=09vv->res_type =3D RESOURCE_TYPE_GUEST_PAGES;
+=09} else if (virtio_has_feature(vdev,
+=09=09=09=09      VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT)) {
+=09=09vv->res_type =3D RESOURCE_TYPE_VIRTIO_OBJECT;
+=09} else {
+=09=09dev_err(dev, "device must support guest allocated buffers or virtio =
objects\n");
+=09=09ret =3D -ENODEV;
+=09=09goto err_res_type;
+=09}
+
 =09vv->vdev =3D vdev;
 =09vv->debug =3D debug;
 =09vv->use_dma_mem =3D use_dma_mem;
@@ -267,6 +278,7 @@ static int virtio_video_probe(struct virtio_device *vde=
v)
 err_vqs:
 =09v4l2_device_unregister(&vv->v4l2_dev);
 err_v4l2_reg:
+err_res_type:
 =09devm_kfree(&vdev->dev, vv);

 =09return ret;
@@ -292,6 +304,7 @@ static struct virtio_device_id id_table[] =3D {
 static unsigned int features[] =3D {
 =09VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES,
 =09VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG,
+=09VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT,
 };

 static struct virtio_driver virtio_video_driver =3D {
diff --git a/drivers/media/virtio/virtio_video_vq.c b/drivers/media/virtio/=
virtio_video_vq.c
index 4679e6b49cf3..dc5e1b7a320e 100644
--- a/drivers/media/virtio/virtio_video_vq.c
+++ b/drivers/media/virtio/virtio_video_vq.c
@@ -411,6 +411,18 @@ int virtio_video_cmd_stream_create(struct virtio_video=
 *vv, uint32_t stream_id,
 {
 =09struct virtio_video_stream_create *req_p;
 =09struct virtio_video_vbuffer *vbuf;
+=09int resource_type;
+
+=09switch (vv->res_type) {
+=09case RESOURCE_TYPE_GUEST_PAGES:
+=09=09resource_type =3D VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES;
+=09=09break;
+=09case RESOURCE_TYPE_VIRTIO_OBJECT:
+=09=09resource_type =3D VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT;
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}

 =09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
 =09if (IS_ERR(req_p))
@@ -418,9 +430,10 @@ int virtio_video_cmd_stream_create(struct virtio_video=
 *vv, uint32_t stream_id,

 =09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_STREAM_CREATE);
 =09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
-=09req_p->in_mem_type =3D cpu_to_le32(VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES);
-=09req_p->out_mem_type =3D cpu_to_le32(VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES);
 =09req_p->coded_format =3D cpu_to_le32(format);
+=09req_p->in_mem_type =3D cpu_to_le32(resource_type);
+=09req_p->out_mem_type =3D cpu_to_le32(resource_type);
+
 =09strncpy(req_p->tag, tag, sizeof(req_p->tag) - 1);
 =09req_p->tag[sizeof(req_p->tag) - 1] =3D 0;

@@ -457,30 +470,38 @@ int virtio_video_cmd_stream_drain(struct virtio_video=
 *vv, uint32_t stream_id)
 =09return virtio_video_queue_cmd_buffer(vv, vbuf);
 }

-int virtio_video_cmd_resource_create(struct virtio_video *vv,
-=09=09=09=09     uint32_t stream_id, uint32_t resource_id,
-=09=09=09=09     uint32_t queue_type,
-=09=09=09=09     struct virtio_video_mem_entry *ents,
-=09=09=09=09     unsigned int num_planes,
-=09=09=09=09     unsigned int *num_entry)
+static void virtio_video_cmd_resource_create_core(
+=09struct virtio_video *vv, struct virtio_video_resource_create *req_p,
+=09uint32_t stream_id, uint32_t resource_id, uint32_t queue_type,
+=09unsigned int num_planes)
+{
+=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_RESOURCE_CREATE);
+=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
+=09req_p->resource_id =3D cpu_to_le32(resource_id);
+=09req_p->queue_type =3D cpu_to_le32(queue_type);
+=09req_p->num_planes =3D cpu_to_le32(num_planes);
+}
+
+int virtio_video_cmd_resource_create_page(
+=09struct virtio_video *vv, uint32_t stream_id, uint32_t resource_id,
+=09uint32_t queue_type, unsigned int num_planes, unsigned int *num_entries=
,
+=09struct virtio_video_mem_entry *ents)
 {
-=09unsigned int i =3D 0, nents =3D 0;
 =09struct virtio_video_resource_create *req_p;
 =09struct virtio_video_vbuffer *vbuf;
+=09unsigned int nents =3D 0;
+=09int i;

 =09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
 =09if (IS_ERR(req_p))
 =09=09return PTR_ERR(req_p);

-=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_RESOURCE_CREATE);
-=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
-=09req_p->resource_id =3D cpu_to_le32(resource_id);
-=09req_p->queue_type =3D cpu_to_le32(queue_type);
-=09 req_p->num_planes =3D cpu_to_le32(num_planes);
+=09virtio_video_cmd_resource_create_core(vv, req_p, stream_id, resource_id=
,
+=09=09=09=09=09      queue_type, num_planes);

 =09for (i =3D 0; i < num_planes; i++) {
-=09=09nents +=3D num_entry[i];
-=09=09req_p->num_entries[i] =3D cpu_to_le32(num_entry[i]);
+=09=09nents +=3D num_entries[i];
+=09=09req_p->num_entries[i] =3D cpu_to_le32(num_entries[i]);
 =09}

 =09vbuf->data_buf =3D ents;
@@ -489,6 +510,33 @@ int virtio_video_cmd_resource_create(struct virtio_vid=
eo *vv,
 =09return virtio_video_queue_cmd_buffer(vv, vbuf);
 }

+int virtio_video_cmd_resource_create_object(
+=09struct virtio_video *vv, uint32_t stream_id, uint32_t resource_id,
+=09uint32_t queue_type, unsigned int num_planes, struct vb2_plane *planes,
+=09struct virtio_video_object_entry *ents)
+{
+=09struct virtio_video_resource_create *req_p;
+=09struct virtio_video_vbuffer *vbuf;
+=09int i;
+
+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
+=09if (IS_ERR(req_p))
+=09=09return PTR_ERR(req_p);
+
+=09virtio_video_cmd_resource_create_core(vv, req_p, stream_id, resource_id=
,
+=09=09=09=09=09      queue_type, num_planes);
+
+=09req_p->planes_layout =3D
+=09=09cpu_to_le32(VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER);
+=09for (i =3D 0; i < num_planes; i++)
+=09=09req_p->plane_offsets[i] =3D planes[i].data_offset;
+
+=09vbuf->data_buf =3D ents;
+=09vbuf->data_size =3D sizeof(*ents);
+
+=09return virtio_video_queue_cmd_buffer(vv, vbuf);
+}
+
 int virtio_video_cmd_resource_destroy_all(struct virtio_video *vv,
 =09=09=09=09=09  struct virtio_video_stream *stream,
 =09=09=09=09=09  enum virtio_video_queue_type qtype)
@@ -1009,4 +1057,3 @@ int virtio_video_cmd_set_control(struct virtio_video =
*vv, uint32_t stream_id,

 =09return virtio_video_queue_cmd_buffer(vv, vbuf);
 }
-
diff --git a/include/uapi/linux/virtio_video.h b/include/uapi/linux/virtio_=
video.h
index 0dd98a2237c6..f7b3f94f9dbb 100644
--- a/include/uapi/linux/virtio_video.h
+++ b/include/uapi/linux/virtio_video.h
@@ -49,6 +49,8 @@
  * scatter-gather lists.
  */
 #define VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG 1
+/* Objects exported by another virtio device can be used for video buffers=
 */
+#define VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT 2

 /*
  * Image formats
@@ -240,6 +242,7 @@ struct virtio_video_query_capability_resp {
 /* VIRTIO_VIDEO_CMD_STREAM_CREATE */
 enum virtio_video_mem_type {
 =09VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES,
+=09VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT,
 };

 struct virtio_video_stream_create {
@@ -268,6 +271,10 @@ struct virtio_video_mem_entry {
 =09__u8 padding[4];
 };

+struct virtio_video_object_entry {
+=09__u8 uuid[16];
+};
+
 #define VIRTIO_VIDEO_MAX_PLANES 8

 struct virtio_video_resource_create {
@@ -278,7 +285,13 @@ struct virtio_video_resource_create {
 =09__le32 num_planes;
 =09__le32 plane_offsets[VIRTIO_VIDEO_MAX_PLANES];
 =09__le32 num_entries[VIRTIO_VIDEO_MAX_PLANES];
-=09/* Followed by struct virtio_video_mem_entry entries[] */
+=09/**
+=09 * Followed by either
+=09 * - struct virtio_video_mem_entry entries[]
+=09 *   for VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES
+=09 * - struct virtio_video_object_entry entries[]
+=09 *   for VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT
+=09 */
 };

 /* VIRTIO_VIDEO_CMD_RESOURCE_QUEUE */
--
2.25.1.696.g5e7596f4ac-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

