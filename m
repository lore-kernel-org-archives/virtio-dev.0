Return-Path: virtio-dev-return-6472-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE1DF98607D
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Dec 2019 16:33:52 +0000 (UTC)
From: Dmitry Sepp <Dmitry.Sepp@opensynergy.com>
Date: Thu, 5 Dec 2019 16:33:39 +0000
Message-ID: <616A957C6824E5468EC44010E4F1DA4801477DA25C@MXS02.open-synergy.com>
References: <4595464.3jghpSLKuc@os-lin-dmo>
In-Reply-To: <4595464.3jghpSLKuc@os-lin-dmo>
Content-Language: en-US
MIME-Version: 1.0
Subject: [virtio-dev] RE: [RFC] virtio video driver
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "tfiga@chromium.org" <tfiga@chromium.org>, "keiichiw@chromium.org" <keiichiw@chromium.org>, "acourbot@chromium.org" <acourbot@chromium.org>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, "posciak@chromium.org" <posciak@chromium.org>, "marcheu@chromium.org" <marcheu@chromium.org>, "stevensd@chromium.org" <stevensd@chromium.org>, "dgreid@chromium.org" <dgreid@chromium.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "egranata@google.com" <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Kiran Pawar <kiran.pawar@opensynergy.com>=0A=0AThis adds a Virtio bas=
ed video driver for video streaming device that=0Aoperates input and/or out=
put data buffers to share video devices with=0Aseveral guests. The current =
implementation consist of V4L2 based video=0Adriver supporting video functi=
ons of decoder and encoder. This can be=0Aextended for other functions e.g.=
 processor, capture and output.=0AThe device uses descriptor structures to =
advertise and negotiate stream=0Aformats and controls. This allows the driv=
er to modify the processing=0Alogic of the device on a per stream basis.=0A=
=0ASigned-off-by: Dmitry Sepp <Dmitry.Sepp@opensynergy.com>=0ASigned-off-by=
: Kiran Pawar <Kiran.Pawar@opensynergy.com>=0ASigned-off-by: Nikolay Martya=
nov <Nikolay.Martyanov@opensynergy.com>=0A---=0A drivers/media/Kconfig     =
                 |    1 +=0A drivers/media/Makefile                     |  =
  2 +=0A drivers/media/virtio/Kconfig               |   11 +=0A drivers/med=
ia/virtio/Makefile              |   12 +=0A drivers/media/virtio/virtio_vid=
eo.h        |  372 +++++++=0A drivers/media/virtio/virtio_video_caps.c   | =
 618 +++++++++++=0A drivers/media/virtio/virtio_video_dec.c    |  947 +++++=
++++++++++++=0A drivers/media/virtio/virtio_video_dec.h    |   30 +=0A driv=
ers/media/virtio/virtio_video_device.c |  747 +++++++++++++=0A drivers/medi=
a/virtio/virtio_video_driver.c |  278 +++++=0A drivers/media/virtio/virtio_=
video_enc.c    | 1124 ++++++++++++++++++++=0A drivers/media/virtio/virtio_v=
ideo_enc.h    |   30 +=0A drivers/media/virtio/virtio_video_vq.c     |  950=
 +++++++++++++++++=0A include/uapi/linux/virtio_ids.h            |    2 +=
=0A include/uapi/linux/virtio_video.h          |  456 ++++++++=0A 15 files =
changed, 5580 insertions(+)=0A create mode 100644 drivers/media/virtio/Kcon=
fig=0A create mode 100644 drivers/media/virtio/Makefile=0A create mode 1006=
44 drivers/media/virtio/virtio_video.h=0A create mode 100644 drivers/media/=
virtio/virtio_video_caps.c=0A create mode 100644 drivers/media/virtio/virti=
o_video_dec.c=0A create mode 100644 drivers/media/virtio/virtio_video_dec.h=
=0A create mode 100644 drivers/media/virtio/virtio_video_device.c=0A create=
 mode 100644 drivers/media/virtio/virtio_video_driver.c=0A create mode 1006=
44 drivers/media/virtio/virtio_video_enc.c=0A create mode 100644 drivers/me=
dia/virtio/virtio_video_enc.h=0A create mode 100644 drivers/media/virtio/vi=
rtio_video_vq.c=0A create mode 100644 include/uapi/linux/virtio_video.h=0A=
=0Adiff --git a/drivers/media/Kconfig b/drivers/media/Kconfig=0Aindex b36a4=
1332867..cc95806e8f8b 100644=0A--- a/drivers/media/Kconfig=0A+++ b/drivers/=
media/Kconfig=0A@@ -170,6 +170,7 @@ source "drivers/media/pci/Kconfig"=0A s=
ource "drivers/media/platform/Kconfig"=0A source "drivers/media/mmc/Kconfig=
"=0A source "drivers/media/radio/Kconfig"=0A+source "drivers/media/virtio/K=
config"=0A=20=0A comment "Supported FireWire (IEEE 1394) Adapters"=0A =09de=
pends on DVB_CORE && FIREWIRE=0Adiff --git a/drivers/media/Makefile b/drive=
rs/media/Makefile=0Aindex f215f0a89f9e..9517a6f724d1 100644=0A--- a/drivers=
/media/Makefile=0A+++ b/drivers/media/Makefile=0A@@ -25,6 +25,8 @@ obj-y +=
=3D rc/=0A=20=0A obj-$(CONFIG_CEC_CORE) +=3D cec/=0A=20=0A+obj-$(CONFIG_VID=
EO_VIRTIO)  +=3D virtio/=0A+=0A #=0A # Finally, merge the drivers that requ=
ire the core=0A #=0Adiff --git a/drivers/media/virtio/Kconfig b/drivers/med=
ia/virtio/Kconfig=0Anew file mode 100644=0Aindex 000000000000..3289bcf233f0=
=0A--- /dev/null=0A+++ b/drivers/media/virtio/Kconfig=0A@@ -0,0 +1,11 @@=0A=
+# SPDX-License-Identifier: GPL-2.0+=0A+# Video driver for virtio=0A+=0A+co=
nfig VIDEO_VIRTIO=0A+=09tristate "Virtio video V4L2 driver"=0A+=09depends o=
n VIRTIO && VIDEO_DEV && VIDEO_V4L2=0A+=09select VIDEOBUF2_DMA_SG=0A+=09sel=
ect V4L2_MEM2MEM_DEV=0A+=09help=0A+          This is the virtual video driv=
er for virtio.=0A+          Say Y or M.=0Adiff --git a/drivers/media/virtio=
/Makefile b/drivers/media/virtio/Makefile=0Anew file mode 100644=0Aindex 00=
0000000000..6bc48fde57b4=0A--- /dev/null=0A+++ b/drivers/media/virtio/Makef=
ile=0A@@ -0,0 +1,12 @@=0A+# SPDX-License-Identifier: GPL-2.0+=0A+=0A+obj-$(=
CONFIG_VIDEO_VIRTIO) +=3D virtio-video.o=0A+=0A+virtio-video-objs :=3D \=0A=
+    virtio_video_driver.o \=0A+    virtio_video_vq.o \=0A+    virtio_video=
_device.o \=0A+    virtio_video_dec.o \=0A+    virtio_video_enc.o \=0A+    =
virtio_video_caps.o=0A+=0Adiff --git a/drivers/media/virtio/virtio_video.h =
b/drivers/media/virtio/virtio_video.h=0Anew file mode 100644=0Aindex 000000=
000000..23c77dc0cb93=0A--- /dev/null=0A+++ b/drivers/media/virtio/virtio_vi=
deo.h=0A@@ -0,0 +1,372 @@=0A+/* SPDX-License-Identifier: GPL-2.0+ */=0A+/* =
Common header for virtio video driver.=0A+ *=0A+ * Copyright 2019 OpenSyner=
gy GmbH.=0A+ *=0A+ * This program is free software; you can redistribute it=
 and/or modify=0A+ * it under the terms of the GNU General Public License a=
s published by=0A+ * the Free Software Foundation; either version 2 of the =
License, or=0A+ * (at your option) any later version.=0A+ *=0A+ * This prog=
ram is distributed in the hope that it will be useful,=0A+ * but WITHOUT AN=
Y WARRANTY; without even the implied warranty of=0A+ * MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE.  See the=0A+ * GNU General Public License =
for more details.=0A+ *=0A+ * You should have received a copy of the GNU Ge=
neral Public License=0A+ * along with this program; if not, see <http://www=
.gnu.org/licenses/>.=0A+ */=0A+=0A+#ifndef _VIRTIO_VIDEO_H=0A+#define _VIRT=
IO_VIDEO_H=0A+=0A+#include <linux/virtio.h>=0A+#include <linux/virtio_ids.h=
>=0A+#include <linux/virtio_config.h>=0A+#include <linux/virtio_video.h>=0A=
+#include <linux/list.h>=0A+#include <media/v4l2-device.h>=0A+#include <med=
ia/v4l2-mem2mem.h>=0A+#include <media/v4l2-ctrls.h>=0A+=0A+#define DRIVER_N=
AME "virtio-video"=0A+=0A+#ifndef VIRTIO_ID_VIDEO=0A+#define VIRTIO_ID_VIDE=
O 29=0A+#endif=0A+=0A+enum video_pin_type {=0A+=09VIDEO_PIN_TYPE_INPUT =3D =
0,=0A+=09VIDEO_PIN_TYPE_OUTPUT,=0A+};=0A+=0A+enum video_params_scope {=0A+=
=09VIDEO_PARAMS_SCOPE_STREAM =3D 0,=0A+=09VIDEO_PARAMS_SCOPE_DEVICE,=0A+};=
=0A+=0A+#define MIN_BUFS_MIN 0=0A+#define MIN_BUFS_MAX 32=0A+#define MIN_BU=
FS_STEP 1=0A+#define MIN_BUFS_DEF 1=0A+=0A+struct video_frame_rate {=0A+=09=
unsigned int min_rate;=0A+=09unsigned int max_rate;=0A+=09unsigned int step=
;=0A+};=0A+=0A+struct video_frame_size {=0A+=09unsigned int min_width;=0A+=
=09unsigned int max_width;=0A+=09unsigned int step_width;=0A+=09unsigned in=
t min_height;=0A+=09unsigned int max_height;=0A+=09unsigned int step_height=
;=0A+=09unsigned int num_rates;=0A+=09struct video_frame_rate *frame_rates;=
=0A+};=0A+=0A+struct video_pix_format {=0A+=09uint32_t fourcc_format;=0A+=
=09unsigned int num_sizes;=0A+=09struct video_frame_size *frame_sizes;=0A+}=
;=0A+=0A+struct video_frame_format {=0A+=09int pin_type; /* VIRTIO_VIDEO_PI=
N_ */=0A+=09unsigned int num_formats;=0A+=09struct video_pix_format *pix_fo=
rmats;=0A+};=0A+=0A+struct video_control {=0A+=09uint32_t control_type;=0A+=
=09uint32_t step;=0A+=09uint64_t min;=0A+=09uint64_t max;=0A+=09uint64_t de=
f;=0A+};=0A+=0A+struct video_controls {=0A+=09unsigned int num_controls;=0A=
+=09struct video_control *control;=0A+};=0A+=0A+struct video_capability {=
=0A+=09struct list_head caps_list_entry;=0A+=09int cap_type; /* VIRTIO_VIDE=
O_CAP_ */=0A+=09unsigned int cap_id;=0A+=09union {=0A+=09=09struct video_fr=
ame_format frame_format;=0A+=09=09struct video_controls controls;=0A+=09} u=
;=0A+};=0A+=0A+struct virtio_video;=0A+struct virtio_video_vbuffer;=0A+=0A+=
typedef void (*virtio_video_resp_cb)(struct virtio_video *vv,=0A+=09=09=09=
=09     struct virtio_video_vbuffer *vbuf);=0A+=0A+struct virtio_video_vbuf=
fer {=0A+=09char *buf;=0A+=09int size;=0A+=0A+=09void *data_buf;=0A+=09uint=
32_t data_size;=0A+=0A+=09char *resp_buf;=0A+=09int resp_size;=0A+=0A+=09vo=
id *priv;=0A+=09virtio_video_resp_cb resp_cb;=0A+=0A+=09struct list_head li=
st;=0A+};=0A+=0A+struct virtio_video_queue {=0A+=09struct virtqueue *vq;=0A=
+=09spinlock_t qlock;=0A+=09wait_queue_head_t ack_queue;=0A+=09struct work_=
struct dequeue_work;=0A+};=0A+=0A+struct virtio_video {=0A+=09struct v4l2_d=
evice v4l2_dev;=0A+=09int instance;=0A+=0A+=09struct virtio_device *vdev;=
=0A+=09struct virtio_video_queue ctrlq;=0A+=09struct virtio_video_queue eve=
ntq;=0A+=09wait_queue_head_t wq;=0A+=09bool vq_ready;=0A+=0A+=09struct kmem=
_cache *vbufs;=0A+=0A+=09struct idr resource_idr;=0A+=09spinlock_t resource=
_idr_lock;=0A+=09struct idr stream_idr;=0A+=09spinlock_t stream_idr_lock;=
=0A+=0A+=09uint32_t num_devices;=0A+=09uint32_t funcs_size;=0A+=09bool got_=
funcs;=0A+=0A+=09bool has_iommu;=0A+=09struct list_head devices_list;=0A+=
=0A+=09int debug;=0A+};=0A+=0A+struct video_plane_format {=0A+=09uint32_t c=
hannel;=0A+=09uint32_t plane_size;=0A+=09uint32_t stride;=0A+=09uint32_t pa=
dding;=0A+};=0A+=0A+struct video_format_info {=0A+=09unsigned int frame_rat=
e;=0A+=09unsigned int frame_width;=0A+=09unsigned int frame_height;=0A+=09u=
nsigned int min_buffers;=0A+=09uint32_t fourcc_format;=0A+=09uint32_t num_p=
lanes;=0A+=09struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES=
];=0A+=09bool is_updated;=0A+};=0A+=0A+enum video_stream_state {=0A+=09STRE=
AM_STATE_IDLE =3D 0,=0A+=09STREAM_STATE_INIT,=0A+=09STREAM_STATE_METADATA, =
/* specific to decoder */=0A+=09STREAM_STATE_RUNNING,=0A+=09STREAM_STATE_DR=
AIN,=0A+=09STREAM_STATE_STOPPED,=0A+=09STREAM_STATE_RESET, /* specific to e=
ncoder */=0A+};=0A+=0A+struct virtio_video_device {=0A+=09struct virtio_vid=
eo *vv;=0A+=09struct video_device video_dev;=0A+=09struct mutex video_dev_m=
utex;=0A+=0A+=09struct v4l2_m2m_dev *m2m_dev;=0A+=0A+=09struct workqueue_st=
ruct *workqueue;=0A+=0A+=09struct list_head devices_list_entry;=0A+=09/* VI=
RTIO_VIDEO_FUNC_ */=0A+=09int type;=0A+=09unsigned int id;=0A+=09/* List of=
 control capabilities */=0A+=09struct list_head ctrl_caps_list;=0A+=09/* Li=
st of frame formats capabilities */=0A+=09struct list_head fmt_caps_list;=
=0A+=0A+=09/* The following 2 arrays contain pointers to pixel formats that=
 are=0A+=09 * stored in 'fmt_caps_list' (as a part of the 'video_frame_form=
at'=0A+=09 * structure). They are necessary to simplify indexing=0A+=09 * t=
hrough pixel formats in the implementation of ENUM_FMT callbacks=0A+=09 */=
=0A+=0A+=09/* Array of pointers to pixel formats of CAPTURE pin */=0A+=09un=
signed int num_capture_formats;=0A+=09struct video_pix_format **capture_fmt=
s;=0A+=0A+=09/* Array of pointers to pixel formats of OUTPUT pin */=0A+=09u=
nsigned int num_output_formats;=0A+=09struct video_pix_format **output_fmts=
;=0A+=0A+=09struct video_format_info in_info;=0A+=09struct video_format_inf=
o out_info;=0A+};=0A+=0A+int virtio_video_alloc_vbufs(struct virtio_video *=
vv);=0A+void virtio_video_free_vbufs(struct virtio_video *vv);=0A+int virti=
o_video_alloc_events(struct virtio_video *vv, size_t num);=0A+=0A+int virti=
o_video_devices_init(struct virtio_video *vv, void *funcs_buf);=0A+void vir=
tio_video_devices_deinit(struct virtio_video *vv);=0A+=0A+struct virtio_vid=
eo_stream {=0A+=09uint32_t stream_id;=0A+=09enum video_stream_state state;=
=0A+=09struct video_device *video_dev;=0A+=09struct v4l2_fh fh;=0A+=09struc=
t mutex vq_mutex;=0A+=09struct v4l2_ctrl_handler ctrl_handler;=0A+=09struct=
 video_format_info in_info;=0A+=09struct video_format_info out_info;=0A+=09=
bool src_cleared;=0A+=09bool dst_cleared;=0A+=09bool mark_last_buffer_pendi=
ng;=0A+=09bool check_drain_sequence_pending;=0A+=09struct work_struct work;=
=0A+=09struct video_frame_size *current_frame_size;=0A+};=0A+=0A+struct vir=
tio_video_buffer {=0A+=09struct v4l2_m2m_buffer v4l2_m2m_vb;=0A+=09uint32_t=
 resource_id;=0A+=09bool detached;=0A+=09bool queued;=0A+};=0A+=0A+static i=
nline struct virtio_video_device *=0A+to_virtio_vd(struct video_device *vid=
eo_dev)=0A+{=0A+=09return container_of(video_dev, struct virtio_video_devic=
e,=0A+=09=09=09 video_dev);=0A+}=0A+=0A+static inline struct virtio_video_s=
tream *file2stream(struct file *file)=0A+{=0A+=09return container_of(file->=
private_data, struct virtio_video_stream, fh);=0A+}=0A+=0A+static inline st=
ruct virtio_video_stream *ctrl2stream(struct v4l2_ctrl *ctrl)=0A+{=0A+=09re=
turn container_of(ctrl->handler, struct virtio_video_stream,=0A+=09=09=09  =
  ctrl_handler);=0A+}=0A+=0A+static inline struct virtio_video_stream *work=
2stream(struct work_struct *work)=0A+{=0A+=09return container_of(work, stru=
ct virtio_video_stream, work);=0A+}=0A+=0A+static inline struct virtio_vide=
o_buffer *to_virtio_vb(struct vb2_buffer *vb)=0A+{=0A+=09struct vb2_v4l2_bu=
ffer *v4l2_vb =3D to_vb2_v4l2_buffer(vb);=0A+=0A+=09return container_of(v4l=
2_vb, struct virtio_video_buffer,=0A+=09=09=09    v4l2_m2m_vb.vb);=0A+}=0A+=
=0A+void virtio_video_stream_id_get(struct virtio_video *vv,=0A+=09=09=09=
=09struct virtio_video_stream *stream,=0A+=09=09=09=09uint32_t *id);=0A+voi=
d virtio_video_stream_id_put(struct virtio_video *vv, uint32_t id);=0A+void=
 virtio_video_resource_id_get(struct virtio_video *vv, uint32_t *id);=0A+vo=
id virtio_video_resource_id_put(struct virtio_video *vv, uint32_t id);=0A+=
=0A+int virtio_video_req_stream_create(struct virtio_video *vv,=0A+=09=09=
=09=09   uint32_t function_id, uint32_t stream_id,=0A+=09=09=09=09   const =
char *name);=0A+int virtio_video_req_stream_destroy(struct virtio_video *vv=
,=0A+=09=09=09=09    uint32_t function_id, uint32_t stream_id);=0A+int virt=
io_video_req_stream_start(struct virtio_video *vv,=0A+=09=09=09=09  uint32_=
t function_id, uint32_t stream_id);=0A+int virtio_video_req_stream_stop(str=
uct virtio_video *vv,=0A+=09=09=09=09 uint32_t function_id,=0A+=09=09=09=09=
 struct virtio_video_stream *stream);=0A+int virtio_video_req_stream_drain(=
struct virtio_video *vv,=0A+=09=09=09=09  uint32_t function_id, uint32_t st=
ream_id);=0A+int virtio_video_req_resource_create(struct virtio_video *vv,=
=0A+=09=09=09=09     uint32_t function_id, uint32_t stream_id,=0A+=09=09=09=
=09     uint32_t resource_id);=0A+int virtio_video_req_resource_destroy(str=
uct virtio_video *vv,=0A+=09=09=09=09      uint32_t function_id, uint32_t s=
tream_id,=0A+=09=09=09=09      uint32_t resource_id);=0A+int virtio_video_r=
eq_resource_queue(struct virtio_video *vv,=0A+=09=09=09=09uint32_t function=
_id, uint32_t stream_id,=0A+=09=09=09=09struct virtio_video_buffer *virtio_=
vb,=0A+=09=09=09=09uint32_t data_size[],=0A+=09=09=09=09uint8_t num_data_si=
ze, bool is_in);=0A+int virtio_video_req_queue_clear(struct virtio_video *v=
v, uint32_t function_id,=0A+=09=09=09=09 struct virtio_video_stream *stream=
,=0A+=09=09=09=09 bool is_in);=0A+int=0A+virtio_video_req_resource_attach_b=
acking(struct virtio_video *vv,=0A+=09=09=09=09=09 uint32_t function_id,=0A=
+=09=09=09=09=09 uint32_t stream_id,=0A+=09=09=09=09=09 uint32_t resource_i=
d,=0A+=09=09=09=09=09 struct virtio_video_mem_entry *ents,=0A+=09=09=09=09=
=09 uint32_t nents);=0A+int=0A+virtio_video_req_resource_detach_backing(str=
uct virtio_video *vv,=0A+=09=09=09=09=09 uint32_t function_id,=0A+=09=09=09=
=09=09 uint32_t stream_id,=0A+=09=09=09=09=09 struct virtio_video_buffer *v=
irtio_vb);=0A+int virtio_video_req_funcs(struct virtio_video *vv, void *res=
p_buf,=0A+=09=09=09   size_t resp_size);=0A+int virtio_video_req_set_params=
(struct virtio_video *vv, uint32_t function_id,=0A+=09=09=09=09=09struct vi=
deo_format_info *format_info,=0A+=09=09=09=09=09enum video_pin_type pin_typ=
e,=0A+=09=09=09=09=09enum video_params_scope scope,=0A+=09=09=09=09=09struc=
t virtio_video_stream *stream);=0A+int virtio_video_req_get_params(struct v=
irtio_video *vv, uint32_t function_id,=0A+=09=09=09=09=09enum video_pin_typ=
e pin_type,=0A+=09=09=09=09=09enum video_params_scope scope,=0A+=09=09=09=
=09=09struct virtio_video_stream *stream);=0A+int virtio_video_req_set_cont=
rol(struct virtio_video *vv,=0A+=09=09=09=09 uint32_t function_id, uint32_t=
 stream_id,=0A+=09=09=09=09 uint32_t control, uint32_t val);=0A+=0A+void vi=
rtio_video_queue_res_chg_event(struct virtio_video_stream *stream);=0A+void=
 virtio_video_queue_eos_event(struct virtio_video_stream *stream);=0A+void =
virtio_video_ctrl_ack(struct virtqueue *vq);=0A+void virtio_video_event_ack=
(struct virtqueue *vq);=0A+void virtio_video_dequeue_ctrl_func(struct work_=
struct *work);=0A+void virtio_video_dequeue_event_func(struct work_struct *=
work);=0A+void virtio_video_buf_done(struct virtio_video_buffer *virtio_vb,=
=0A+=09=09=09   uint32_t flags, uint64_t timestamp, uint32_t size);=0A+void=
 virtio_video_mark_drain_complete(struct virtio_video_stream *stream,=0A+=
=09=09=09=09      struct vb2_v4l2_buffer *v4l2_vb);=0A+=0A+void virtio_vide=
o_free_caps_list(struct list_head *caps_list);=0A+size_t virtio_video_parse=
_virtio_function(void *func_buf,=0A+=09=09=09=09=09  struct virtio_video_de=
vice *vvd);=0A+void virtio_video_clean_virtio_function(struct virtio_video_=
device *vvd);=0A+=0A+uint32_t virtio_video_format_to_v4l2(uint32_t pixel_fo=
rmat);=0A+uint32_t virtio_video_v4l2_fourcc_to_virtio(uint32_t fourcc);=0A+=
uint32_t virtio_video_control_to_v4l2(uint32_t control_type);=0A+uint32_t v=
irtio_video_profile_to_v4l2(uint32_t profile);=0A+uint32_t virtio_video_lev=
el_to_v4l2(uint32_t level);=0A+uint32_t virtio_video_v4l2_control_to_virtio=
(uint32_t v4l2_control);=0A+uint32_t virtio_video_v4l2_profile_to_virtio(ui=
nt32_t v4l2_profile);=0A+uint32_t virtio_video_v4l2_level_to_virtio(uint32_=
t v4l2_level);=0A+=0A+#endif /* _VIRTIO_VIDEO_H */=0Adiff --git a/drivers/m=
edia/virtio/virtio_video_caps.c b/drivers/media/virtio/virtio_video_caps.c=
=0Anew file mode 100644=0Aindex 000000000000..19b025805570=0A--- /dev/null=
=0A+++ b/drivers/media/virtio/virtio_video_caps.c=0A@@ -0,0 +1,618 @@=0A+//=
 SPDX-License-Identifier: GPL-2.0+=0A+/* Driver for virtio video device.=0A=
+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A+ *=0A+ * This program is free=
 software; you can redistribute it and/or modify=0A+ * it under the terms o=
f the GNU General Public License as published by=0A+ * the Free Software Fo=
undation; either version 2 of the License, or=0A+ * (at your option) any la=
ter version.=0A+ *=0A+ * This program is distributed in the hope that it wi=
ll be useful,=0A+ * but WITHOUT ANY WARRANTY; without even the implied warr=
anty of=0A+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=
=0A+ * GNU General Public License for more details.=0A+ *=0A+ * You should =
have received a copy of the GNU General Public License=0A+ * along with thi=
s program; if not, see <http://www.gnu.org/licenses/>.=0A+ */=0A+=0A+#inclu=
de <media/v4l2-ioctl.h>=0A+#include <media/videobuf2-dma-sg.h>=0A+=0A+#incl=
ude "virtio_video.h"=0A+=0A+static void pix_format_free(struct video_pix_fo=
rmat *pix_fmt)=0A+{=0A+=09int size_idx =3D 0;=0A+=0A+=09if (!pix_fmt)=0A+=
=09=09return;=0A+=0A+=09for (size_idx =3D 0; size_idx < pix_fmt->num_sizes;=
 size_idx++)=0A+=09=09kfree(pix_fmt->frame_sizes[size_idx].frame_rates);=0A=
+=09kfree(pix_fmt->frame_sizes);=0A+}=0A+=0A+static void fmt_capability_fre=
e(struct video_frame_format *frame_fmt)=0A+{=0A+=09int fmt_idx =3D 0;=0A+=
=0A+=09if (!frame_fmt)=0A+=09=09return;=0A+=0A+=09for (fmt_idx =3D 0; fmt_i=
dx < frame_fmt->num_formats; fmt_idx++)=0A+=09=09pix_format_free(&frame_fmt=
->pix_formats[fmt_idx]);=0A+=09kfree(frame_fmt->pix_formats);=0A+}=0A+=0A+s=
tatic void ctrl_capability_free(struct video_controls *controls)=0A+{=0A+=
=09if (!controls)=0A+=09=09return;=0A+=0A+=09kfree(controls->control);=0A+}=
=0A+=0A+static void capability_free(struct video_capability *cap)=0A+{=0A+=
=09if (!cap)=0A+=09=09return;=0A+=0A+=09switch (cap->cap_type) {=0A+=09case=
 VIRTIO_VIDEO_CAP_CONTROL:=0A+=09=09ctrl_capability_free(&cap->u.controls);=
=0A+=09=09break;=0A+=09case VIRTIO_VIDEO_CAP_PIN_FORMATS:=0A+=09=09fmt_capa=
bility_free(&cap->u.frame_format);=0A+=09=09break;=0A+=09default:=0A+=09=09=
return;=0A+=09}=0A+=09kfree(cap);=0A+}=0A+=0A+static size_t parse_virtio_fr=
ame_rate(struct video_frame_rate *frame_rate,=0A+=09=09=09=09      void *fr=
ame_rate_buf,=0A+=09=09=09=09      struct virtio_video_device *vvd)=0A+{=0A=
+=09struct virtio_video *vv =3D NULL;=0A+=09struct virtio_video_frame_rate =
*virtio_frame_rate =3D NULL;=0A+=09size_t frame_rate_size =3D sizeof(struct=
 virtio_video_frame_rate);=0A+=0A+=09if (!frame_rate || !frame_rate_buf || =
!vvd)=0A+=09=09return 0;=0A+=0A+=09vv =3D vvd->vv;=0A+=09virtio_frame_rate =
=3D frame_rate_buf;=0A+=0A+=09if (le32_to_cpu(virtio_frame_rate->desc.type)=
 !=3D=0A+=09    VIRTIO_VIDEO_DESC_FRAME_RATE) {=0A+=09=09v4l2_err(&vv->v4l2=
_dev,=0A+=09=09=09 "failed to read frame rate descriptor\n");=0A+=09=09retu=
rn 0;=0A+=09}=0A+=0A+=09frame_rate->min_rate =3D le32_to_cpu(virtio_frame_r=
ate->min_rate);=0A+=09frame_rate->max_rate =3D le32_to_cpu(virtio_frame_rat=
e->max_rate);=0A+=09frame_rate->step =3D le32_to_cpu(virtio_frame_rate->ste=
p);=0A+=0A+=09return frame_rate_size;=0A+}=0A+=0A+static size_t parse_virti=
o_frame_size(struct video_frame_size *frame_size,=0A+=09=09=09=09      void=
 *frame_size_buf,=0A+=09=09=09=09      struct virtio_video_device *vvd)=0A+=
{=0A+=09struct virtio_video *vv =3D NULL;=0A+=09size_t frame_size_size =3D =
0;=0A+=09struct virtio_video_frame_size *virtio_frame_size =3D NULL;=0A+=09=
int rate_idx =3D 0;=0A+=09size_t offset =3D sizeof(struct virtio_video_fram=
e_size);=0A+=0A+=09if (!frame_size || !frame_size_buf || !vvd)=0A+=09=09ret=
urn 0;=0A+=0A+=09vv =3D vvd->vv;=0A+=09virtio_frame_size =3D frame_size_buf=
;=0A+=0A+=09if (le32_to_cpu(virtio_frame_size->desc.type) !=3D=0A+=09    VI=
RTIO_VIDEO_DESC_FRAME_SIZE) {=0A+=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09=
 "failed to read frame size descriptor\n");=0A+=09=09return 0;=0A+=09}=0A+=
=0A+=09frame_size->min_height =3D le32_to_cpu(virtio_frame_size->min_height=
);=0A+=09frame_size->max_height =3D le32_to_cpu(virtio_frame_size->max_heig=
ht);=0A+=09frame_size->step_height =3D le32_to_cpu(virtio_frame_size->step_=
height);=0A+=09frame_size->min_width =3D le32_to_cpu(virtio_frame_size->min=
_width);=0A+=09frame_size->max_width =3D le32_to_cpu(virtio_frame_size->max=
_width);=0A+=09frame_size->step_width =3D le32_to_cpu(virtio_frame_size->st=
ep_width);=0A+=09frame_size->num_rates =3D le32_to_cpu(virtio_frame_size->n=
um_rates);=0A+=0A+=09frame_size->frame_rates =3D kcalloc(frame_size->num_ra=
tes,=0A+=09=09=09=09=09  sizeof(struct video_frame_rate),=0A+=09=09=09=09=
=09  GFP_KERNEL);=0A+=09if (!frame_size->frame_rates) {=0A+=09=09v4l2_err(&=
vv->v4l2_dev, "failed to alloc frame rates\n");=0A+=09=09return 0;=0A+=09}=
=0A+=0A+=09for (rate_idx =3D 0; rate_idx < frame_size->num_rates; rate_idx+=
+) {=0A+=09=09struct video_frame_rate *frame_rate =3D=0A+=09=09=09&frame_si=
ze->frame_rates[rate_idx];=0A+=09=09size_t rate_size =3D 0;=0A+=0A+=09=09ra=
te_size =3D parse_virtio_frame_rate(frame_rate,=0A+=09=09=09=09=09=09    fr=
ame_size_buf + offset,=0A+=09=09=09=09=09=09    vvd);=0A+=09=09if (rate_siz=
e =3D=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse frame ra=
te\n");=0A+=09=09=09kfree(frame_size->frame_rates);=0A+=09=09=09return 0;=
=0A+=09=09}=0A+=09=09offset +=3D rate_size;=0A+=09}=0A+=0A+=09frame_size_si=
ze =3D offset;=0A+=0A+=09return frame_size_size;=0A+}=0A+=0A+static size_t =
parse_virtio_pix_fmt(struct video_pix_format *pix_fmt,=0A+=09=09=09=09   vo=
id *pix_buf,=0A+=09=09=09=09   struct virtio_video_device *vvd)=0A+{=0A+=09=
struct virtio_video *vv =3D NULL;=0A+=09size_t pix_fmt_size =3D 0;=0A+=09st=
ruct virtio_video_pix_format *virtio_pix_fmt =3D NULL;=0A+=09int size_idx =
=3D 0;=0A+=09size_t offset =3D sizeof(struct virtio_video_pix_format);=0A+=
=0A+=09if (!pix_fmt || !pix_buf || !vvd)=0A+=09=09return 0;=0A+=0A+=09vv =
=3D vvd->vv;=0A+=09virtio_pix_fmt =3D pix_buf;=0A+=0A+=09if (le32_to_cpu(vi=
rtio_pix_fmt->desc.type) !=3D=0A+=09    VIRTIO_VIDEO_DESC_PIX_FORMAT) {=0A+=
=09=09v4l2_err(&vv->v4l2_dev, "failed to read pix fmt descriptor\n");=0A+=
=09=09return 0;=0A+=09}=0A+=0A+=09pix_fmt->fourcc_format =3D=0A+=09=09=09vi=
rtio_video_format_to_v4l2(=0A+=09=09=09=09le32_to_cpu(virtio_pix_fmt->pixel=
_format));=0A+=09pix_fmt->num_sizes =3D le32_to_cpu(virtio_pix_fmt->num_siz=
es);=0A+=0A+=09pix_fmt->frame_sizes =3D kcalloc(pix_fmt->num_sizes,=0A+=09=
=09=09=09       sizeof(struct video_frame_size),=0A+=09=09=09=09       GFP_=
KERNEL);=0A+=09if (!pix_fmt->frame_sizes) {=0A+=09=09v4l2_err(&vv->v4l2_dev=
, "failed to alloc frame sizes\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09fo=
r (size_idx =3D 0; size_idx < pix_fmt->num_sizes; size_idx++) {=0A+=09=09st=
ruct video_frame_size *frame_size =3D NULL;=0A+=09=09size_t size_size =3D 0=
;=0A+=0A+=09=09frame_size =3D &pix_fmt->frame_sizes[size_idx];=0A+=09=09siz=
e_size =3D parse_virtio_frame_size(frame_size,=0A+=09=09=09=09=09=09    pix=
_buf + offset, vvd);=0A+=09=09if (size_size =3D=3D 0) {=0A+=09=09=09v4l2_er=
r(&vv->v4l2_dev, "failed to parse frame size\n");=0A+=09=09=09kfree(pix_fmt=
->frame_sizes);=0A+=09=09=09return 0;=0A+=09=09}=0A+=09=09offset +=3D size_=
size;=0A+=09}=0A+=0A+=09pix_fmt_size =3D offset;=0A+=0A+=09return pix_fmt_s=
ize;=0A+}=0A+=0A+static size_t parse_virtio_fmts_cap(struct video_frame_for=
mat *frame_fmt,=0A+=09=09=09=09    void *cap_buf,=0A+=09=09=09=09    struct=
 virtio_video_device *vvd)=0A+{=0A+=09struct virtio_video *vv =3D NULL;=0A+=
=09size_t fmts_size =3D 0;=0A+=09struct virtio_video_frame_format *virtio_f=
mt =3D NULL;=0A+=09int fmt_idx =3D 0;=0A+=09size_t offset =3D sizeof(struct=
 virtio_video_frame_format);=0A+=09struct virtio_video_capability dummy;=0A=
+=0A+=09if (!frame_fmt || !cap_buf || !vvd)=0A+=09=09return 0;=0A+=0A+=09vv=
 =3D vvd->vv;=0A+=09virtio_fmt =3D cap_buf;=0A+=0A+=09frame_fmt->pin_type =
=3D le32_to_cpu(virtio_fmt->pin_type);=0A+=09frame_fmt->num_formats =3D le3=
2_to_cpu(virtio_fmt->num_formats);=0A+=0A+=09frame_fmt->pix_formats =3D kca=
lloc(frame_fmt->num_formats,=0A+=09=09=09=09=09 sizeof(struct video_pix_for=
mat),=0A+=09=09=09=09=09 GFP_KERNEL);=0A+=09if (!frame_fmt->pix_formats) {=
=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to alloc pix formats\n");=0A+=09=
=09return 0;=0A+=09}=0A+=0A+=09for (fmt_idx =3D 0; fmt_idx < frame_fmt->num=
_formats; fmt_idx++) {=0A+=09=09struct video_pix_format *pix_fmt =3D NULL;=
=0A+=09=09size_t fmt_size =3D 0;=0A+=0A+=09=09pix_fmt =3D &frame_fmt->pix_f=
ormats[fmt_idx];=0A+=09=09fmt_size =3D parse_virtio_pix_fmt(pix_fmt, cap_bu=
f + offset, vvd);=0A+=09=09if (fmt_size =3D=3D 0) {=0A+=09=09=09v4l2_err(&v=
v->v4l2_dev,=0A+=09=09=09=09 "failed to parse pixel format\n");=0A+=09=09=
=09fmt_capability_free(frame_fmt);=0A+=09=09=09return 0;=0A+=09=09}=0A+=09=
=09offset +=3D fmt_size;=0A+=09}=0A+=0A+=09switch (frame_fmt->pin_type) {=
=0A+=09case VIRTIO_VIDEO_PIN_INPUT:=0A+=09=09vvd->num_output_formats +=3D f=
rame_fmt->num_formats;=0A+=09=09break;=0A+=09case VIRTIO_VIDEO_PIN_OUTPUT:=
=0A+=09=09vvd->num_capture_formats +=3D frame_fmt->num_formats;=0A+=09=09br=
eak;=0A+=09default:=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to parse a pin=
 type\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09fmts_size =3D offset - size=
of(dummy.u);=0A+=0A+=09return fmts_size;=0A+}=0A+=0A+static size_t parse_vi=
rtio_ctrl(struct video_control *control,=0A+=09=09=09=09void *control_buf,=
=0A+=09=09=09=09struct virtio_video_device *vvd)=0A+{=0A+=09struct virtio_v=
ideo *vv =3D NULL;=0A+=09struct virtio_video_control *virtio_control =3D NU=
LL;=0A+=09size_t control_size =3D sizeof(struct virtio_video_control);=0A+=
=0A+=09if (!control || !control_buf || !vvd)=0A+=09=09return 0;=0A+=0A+=09v=
v =3D vvd->vv;=0A+=09virtio_control =3D control_buf;=0A+=0A+=09if (le32_to_=
cpu(virtio_control->desc.type) !=3D=0A+=09    VIRTIO_VIDEO_DESC_CONTROL) {=
=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to read control descriptor\n");=
=0A+=09=09return 0;=0A+=09}=0A+=0A+=09control->control_type =3D=0A+=09=09vi=
rtio_video_control_to_v4l2=0A+=09=09(le32_to_cpu(virtio_control->control_ty=
pe));=0A+=0A+=09switch (control->control_type) {=0A+=09case V4L2_CID_MPEG_V=
IDEO_H264_PROFILE:=0A+=09=09control->min =3D=0A+=09=09=09virtio_video_profi=
le_to_v4l2=0A+=09=09=09(le64_to_cpu(virtio_control->min));=0A+=09=09control=
->max =3D=0A+=09=09=09virtio_video_profile_to_v4l2=0A+=09=09=09(le64_to_cpu=
(virtio_control->max));=0A+=09=09control->step =3D=0A+=09=09=09virtio_video=
_profile_to_v4l2=0A+=09=09=09(le32_to_cpu(virtio_control->step));=0A+=09=09=
control->def =3D=0A+=09=09=09virtio_video_profile_to_v4l2=0A+=09=09=09(le64=
_to_cpu(virtio_control->def));=0A+=09=09break;=0A+=09case V4L2_CID_MPEG_VID=
EO_H264_LEVEL:=0A+=09=09control->min =3D=0A+=09=09=09virtio_video_level_to_=
v4l2=0A+=09=09=09(le64_to_cpu(virtio_control->min));=0A+=09=09control->max =
=3D=0A+=09=09=09virtio_video_level_to_v4l2=0A+=09=09=09(le64_to_cpu(virtio_=
control->max));=0A+=09=09control->step =3D=0A+=09=09=09virtio_video_level_t=
o_v4l2=0A+=09=09=09(le32_to_cpu(virtio_control->step));=0A+=09=09control->d=
ef =3D=0A+=09=09=09virtio_video_level_to_v4l2=0A+=09=09=09(le64_to_cpu(virt=
io_control->def));=0A+=09=09break;=0A+=09default:=0A+=09=09control->min =3D=
 le64_to_cpu(virtio_control->min);=0A+=09=09control->max =3D le64_to_cpu(vi=
rtio_control->max);=0A+=09=09control->step =3D le32_to_cpu(virtio_control->=
step);=0A+=09=09control->def =3D le64_to_cpu(virtio_control->def);=0A+=09=
=09break;=0A+=09}=0A+=0A+=09return control_size;=0A+}=0A+=0A+static size_t =
parse_virtio_ctrls_cap(struct video_controls *controls,=0A+=09=09=09=09    =
 void *cap_buf,=0A+=09=09=09=09     struct virtio_video_device *vvd)=0A+{=
=0A+=09struct virtio_video_controls *virtio_controls =3D NULL;=0A+=09struct=
 virtio_video *vv =3D NULL;=0A+=09size_t ctrls_size =3D 0;=0A+=09int ctrl_i=
dx =3D 0;=0A+=09size_t offset =3D sizeof(struct virtio_video_controls);=0A+=
=09struct virtio_video_capability dummy;=0A+=0A+=09if (!controls || !cap_bu=
f || !vvd)=0A+=09=09return 0;=0A+=0A+=09vv =3D vvd->vv;=0A+=09virtio_contro=
ls =3D cap_buf;=0A+=0A+=09controls->num_controls =3D le32_to_cpu(virtio_con=
trols->num_controls);=0A+=09controls->control =3D kcalloc(controls->num_con=
trols,=0A+=09=09=09=09    sizeof(struct video_control),=0A+=09=09=09=09    =
GFP_KERNEL);=0A+=09if (!controls->control) {=0A+=09=09v4l2_err(&vv->v4l2_de=
v, "failed to alloc controls\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09for =
(ctrl_idx =3D 0; ctrl_idx < controls->num_controls; ctrl_idx++) {=0A+=09=09=
struct video_control *ctrl =3D NULL;=0A+=09=09size_t ctrl_size =3D 0;=0A+=
=0A+=09=09ctrl =3D &controls->control[ctrl_idx];=0A+=09=09ctrl_size =3D par=
se_virtio_ctrl(ctrl, cap_buf + offset, vvd);=0A+=09=09if (ctrl_size =3D=3D =
0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse control\n");=0A+=
=09=09=09ctrl_capability_free(controls);=0A+=09=09=09return 0;=0A+=09=09}=
=0A+=09=09offset +=3D ctrl_size;=0A+=09}=0A+=0A+=09ctrls_size =3D offset - =
sizeof(dummy.u);=0A+=0A+=09return ctrls_size;=0A+}=0A+=0A+static size_t par=
se_virtio_capability(struct video_capability *cap,=0A+=09=09=09=09      voi=
d *cap_buf,=0A+=09=09=09=09      struct virtio_video_device *vvd)=0A+{=0A+=
=09struct virtio_video *vv =3D NULL;=0A+=09struct virtio_video_capability *=
virtio_cap =3D NULL;=0A+=09size_t offset =3D 0;=0A+=09size_t extra_size =3D=
 0;=0A+=09size_t cap_size =3D 0;=0A+=0A+=09if (!cap || !cap_buf || !vvd)=0A=
+=09=09return 0;=0A+=0A+=09vv =3D vvd->vv;=0A+=09virtio_cap =3D cap_buf;=0A=
+=09offset =3D sizeof(struct virtio_video_capability) - sizeof(virtio_cap->=
u);=0A+=0A+=09if (le32_to_cpu(virtio_cap->desc.type) !=3D VIRTIO_VIDEO_DESC=
_CAP) {=0A+=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09 "failed to read capab=
ility descriptor\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09cap->cap_id =3D =
le32_to_cpu(virtio_cap->cap_id);=0A+=09cap->cap_type =3D le32_to_cpu(virtio=
_cap->cap_type);=0A+=0A+=09switch (cap->cap_type) {=0A+=09case VIRTIO_VIDEO=
_CAP_CONTROL:=0A+=09=09extra_size =3D parse_virtio_ctrls_cap(&cap->u.contro=
ls,=0A+=09=09=09=09=09=09   cap_buf + offset, vvd);=0A+=09=09if (extra_size=
 =3D=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse ctrl cap\=
n");=0A+=09=09=09return 0;=0A+=09=09}=0A+=09=09break;=0A+=09case VIRTIO_VID=
EO_CAP_PIN_FORMATS:=0A+=09=09extra_size =3D parse_virtio_fmts_cap(&cap->u.f=
rame_format,=0A+=09=09=09=09=09=09   cap_buf + offset, vvd);=0A+=09=09if (e=
xtra_size =3D=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse =
fmts cap\n");=0A+=09=09=09return 0;=0A+=09=09}=0A+=09=09break;=0A+=09defaul=
t:=0A+=09=09v4l2_err(&vv->v4l2_dev, "undefined capability type\n");=0A+=09=
=09return 0;=0A+=09}=0A+=0A+=09if (extra_size < 0)=0A+=09=09extra_size =3D =
0;=0A+=0A+=09cap_size =3D sizeof(struct virtio_video_capability) + extra_si=
ze;=0A+=0A+=09return cap_size;=0A+=0A+}=0A+=0A+void virtio_video_free_caps_=
list(struct list_head *caps_list)=0A+{=0A+=09struct video_capability *cap =
=3D NULL;=0A+=09struct video_capability *tmp =3D NULL;=0A+=0A+=09list_for_e=
ach_entry_safe(cap, tmp, caps_list, caps_list_entry) {=0A+=09=09list_del(&c=
ap->caps_list_entry);=0A+=09=09capability_free(cap);=0A+=09}=0A+=0A+}=0A+=
=0A+static int virtio_video_copy_params(struct video_format_info *dst,=0A+=
=09=09=09=09   const struct virtio_video_params *src)=0A+{=0A+=09if (!dst |=
| !src)=0A+=09=09return -EINVAL;=0A+=0A+=09dst->fourcc_format =3D=0A+=09=09=
=09virtio_video_format_to_v4l2(=0A+=09=09=09=09le32_to_cpu(src->pixel_forma=
t));=0A+=09dst->frame_height =3D le32_to_cpu(src->frame_height);=0A+=09dst-=
>frame_width =3D le32_to_cpu(src->frame_width);=0A+=09dst->frame_rate =3D l=
e32_to_cpu(src->frame_rate);=0A+=09dst->min_buffers =3D le32_to_cpu(src->mi=
n_buffers);=0A+=09return 0;=0A+}=0A+=0A+size_t virtio_video_parse_virtio_fu=
nction(void *func_buf,=0A+=09=09=09=09=09  struct virtio_video_device *vvd)=
=0A+{=0A+=09struct virtio_video *vv =3D NULL;=0A+=09size_t func_size =3D 0;=
=0A+=09struct virtio_video_function *virtio_func =3D NULL;=0A+=09uint32_t n=
um_caps =3D 0;=0A+=09int cap_idx =3D 0;=0A+=09size_t offset =3D sizeof(stru=
ct virtio_video_function);=0A+=09struct video_capability *cap =3D NULL;=0A+=
=09int capture_idx =3D 0;=0A+=09int output_idx =3D 0;=0A+=09int ret =3D 0;=
=0A+=0A+=09if (!func_buf || !vvd)=0A+=09=09return 0;=0A+=0A+=09vv =3D vvd->=
vv;=0A+=09virtio_func =3D func_buf;=0A+=0A+=09if (le32_to_cpu(virtio_func->=
desc.type) !=3D VIRTIO_VIDEO_DESC_FUNC) {=0A+=09=09v4l2_err(&vv->v4l2_dev, =
"failed to read function descriptor\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=
=09vvd->id =3D le32_to_cpu(virtio_func->function_id);=0A+=09vvd->type =3D l=
e32_to_cpu(virtio_func->function_type);=0A+=0A+=09if (le32_to_cpu(virtio_fu=
nc->in_params.desc.type) !=3D=0A+=09    VIRTIO_VIDEO_DESC_PARAMS) {=0A+=09=
=09v4l2_err(&vv->v4l2_dev, "failed to read function params\n");=0A+=09=09re=
turn 0;=0A+=09}=0A+=0A+=09ret =3D virtio_video_copy_params(&vvd->in_info,=
=0A+=09=09=09=09=09 &virtio_func->in_params);=0A+=09if (ret) {=0A+=09=09v4l=
2_err(&vv->v4l2_dev, "failed to read 'in' params\n");=0A+=09=09return 0;=0A=
+=09}=0A+=0A+=09if (le32_to_cpu(virtio_func->out_params.desc.type) !=3D=0A+=
=09    VIRTIO_VIDEO_DESC_PARAMS) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed=
 to read function params\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09ret =3D =
virtio_video_copy_params(&vvd->out_info,=0A+=09=09=09=09=09 &virtio_func->o=
ut_params);=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to re=
ad 'out' params\n");=0A+=09=09return 0;=0A+=09}=0A+=0A+=09num_caps =3D le32=
_to_cpu(virtio_func->num_caps);=0A+=0A+=09for (cap_idx =3D 0; cap_idx < num=
_caps; cap_idx++) {=0A+=09=09size_t cap_size =3D 0;=0A+=0A+=09=09cap =3D kz=
alloc(sizeof(*cap), GFP_KERNEL);=0A+=0A+=09=09if (!cap) {=0A+=09=09=09virti=
o_video_free_caps_list(&vvd->ctrl_caps_list);=0A+=09=09=09virtio_video_free=
_caps_list(&vvd->fmt_caps_list);=0A+=09=09=09return 0;=0A+=09=09}=0A+=0A+=
=09=09cap_size =3D parse_virtio_capability(cap, func_buf + offset, vvd);=0A=
+=09=09if (cap_size =3D=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=
=09=09=09 "failed to parse a capability\n");=0A+=09=09=09virtio_video_free_=
caps_list(&vvd->ctrl_caps_list);=0A+=09=09=09virtio_video_free_caps_list(&v=
vd->fmt_caps_list);=0A+=09=09=09kfree(cap);=0A+=09=09=09return 0;=0A+=09=09=
}=0A+=09=09offset +=3D cap_size;=0A+=0A+=09=09switch (cap->cap_type) {=0A+=
=09=09case VIRTIO_VIDEO_CAP_PIN_FORMATS:=0A+=09=09=09list_add(&cap->caps_li=
st_entry, &vvd->fmt_caps_list);=0A+=09=09=09break;=0A+=09=09case VIRTIO_VID=
EO_CAP_CONTROL:=0A+=09=09=09list_add(&cap->caps_list_entry, &vvd->ctrl_caps=
_list);=0A+=09=09=09break;=0A+=09=09default:=0A+=09=09=09virtio_video_free_=
caps_list(&vvd->ctrl_caps_list);=0A+=09=09=09virtio_video_free_caps_list(&v=
vd->fmt_caps_list);=0A+=09=09=09capability_free(cap);=0A+=09=09=09break;=0A=
+=09=09}=0A+=09}=0A+=0A+=09vvd->capture_fmts =3D kcalloc(vvd->num_capture_f=
ormats,=0A+=09=09=09=09    sizeof(struct video_capability *),=0A+=09=09=09=
=09    GFP_KERNEL);=0A+=09vvd->output_fmts =3D kcalloc(vvd->num_output_form=
ats,=0A+=09=09=09=09   sizeof(struct video_capability *),=0A+=09=09=09=09  =
 GFP_KERNEL);=0A+=09if (!vvd->capture_fmts || !vvd->output_fmts) {=0A+=09=
=09v4l2_err(&vv->v4l2_dev, "failed to alloc capability arrays\n");=0A+=09=
=09virtio_video_free_caps_list(&vvd->ctrl_caps_list);=0A+=09=09virtio_video=
_free_caps_list(&vvd->fmt_caps_list);=0A+=09}=0A+=0A+=09cap =3D NULL;=0A+=
=09list_for_each_entry(cap, &vvd->fmt_caps_list, caps_list_entry) {=0A+=09=
=09struct video_frame_format *frame_fmt =3D &cap->u.frame_format;=0A+=09=09=
int pix_idx =3D 0;=0A+=0A+=09=09switch (le32_to_cpu(frame_fmt->pin_type)) {=
=0A+=09=09case VIRTIO_VIDEO_PIN_INPUT:=0A+=09=09=09for (pix_idx =3D 0; pix_=
idx < frame_fmt->num_formats;=0A+=09=09=09     pix_idx++) {=0A+=09=09=09=09=
vvd->output_fmts[pix_idx + output_idx] =3D=0A+=09=09=09=09=09&frame_fmt->pi=
x_formats[pix_idx];=0A+=09=09=09}=0A+=09=09=09output_idx +=3D pix_idx;=0A+=
=09=09=09break;=0A+=09=09case VIRTIO_VIDEO_PIN_OUTPUT:=0A+=09=09=09for (pix=
_idx =3D 0; pix_idx < frame_fmt->num_formats;=0A+=09=09=09     pix_idx++) {=
=0A+=09=09=09=09vvd->capture_fmts[pix_idx + capture_idx] =3D=0A+=09=09=09=
=09=09&frame_fmt->pix_formats[pix_idx];=0A+=09=09=09}=0A+=09=09=09capture_i=
dx +=3D pix_idx;=0A+=09=09=09break;=0A+=09=09default:=0A+=09=09=09v4l2_err(=
&vv->v4l2_dev, "failed to parse a pin type\n");=0A+=09=09=09return 0;=0A+=
=09=09}=0A+=09}=0A+=0A+=09func_size =3D offset;=0A+=09return func_size;=0A+=
}=0A+=0A+void virtio_video_clean_virtio_function(struct virtio_video_device=
 *vvd)=0A+{=0A+=09if (!vvd)=0A+=09=09return;=0A+=0A+=09kfree(vvd->capture_f=
mts);=0A+=09kfree(vvd->output_fmts);=0A+=09virtio_video_free_caps_list(&vvd=
->ctrl_caps_list);=0A+=09virtio_video_free_caps_list(&vvd->fmt_caps_list);=
=0A+}=0Adiff --git a/drivers/media/virtio/virtio_video_dec.c b/drivers/medi=
a/virtio/virtio_video_dec.c=0Anew file mode 100644=0Aindex 000000000000..c2=
ad62229d21=0A--- /dev/null=0A+++ b/drivers/media/virtio/virtio_video_dec.c=
=0A@@ -0,0 +1,947 @@=0A+// SPDX-License-Identifier: GPL-2.0+=0A+/* Decoder =
for virtio video device.=0A+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A+ *=
=0A+ * This program is free software; you can redistribute it and/or modify=
=0A+ * it under the terms of the GNU General Public License as published by=
=0A+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A+ *=0A+ * This program is distrib=
uted in the hope that it will be useful,=0A+ * but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of=0A+ * MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE.  See the=0A+ * GNU General Public License for more detai=
ls.=0A+ *=0A+ * You should have received a copy of the GNU General Public L=
icense=0A+ * along with this program; if not, see <http://www.gnu.org/licen=
ses/>.=0A+ */=0A+=0A+#include <media/v4l2-event.h>=0A+#include <media/v4l2-=
ioctl.h>=0A+#include <media/videobuf2-dma-sg.h>=0A+=0A+#include "virtio_vid=
eo.h"=0A+=0A+static int virtio_video_queue_setup(struct vb2_queue *vq,=0A+=
=09=09=09=09    unsigned int *num_buffers,=0A+=09=09=09=09    unsigned int =
*num_planes,=0A+=09=09=09=09    unsigned int sizes[],=0A+=09=09=09=09    st=
ruct device *alloc_devs[])=0A+{=0A+=09int i;=0A+=09struct virtio_video_stre=
am *stream =3D vb2_get_drv_priv(vq);=0A+=09struct video_format_info *p_info=
;=0A+=0A+=09if (*num_planes)=0A+=09=09return 0;=0A+=0A+=09if (V4L2_TYPE_IS_=
OUTPUT(vq->type))=0A+=09=09p_info =3D &stream->in_info;=0A+=09else=0A+=09=
=09p_info =3D &stream->out_info;=0A+=0A+=09*num_planes =3D p_info->num_plan=
es;=0A+=0A+=09for (i =3D 0; i < p_info->num_planes; i++)=0A+=09=09sizes[i] =
=3D p_info->plane_format[i].plane_size;=0A+=0A+=09return 0;=0A+}=0A+=0A+sta=
tic int virtio_video_buf_plane_init(uint32_t idx,=0A+=09=09=09=09       uin=
t32_t resource_id,=0A+=09=09=09=09       struct virtio_video_device *vvd,=
=0A+=09=09=09=09       struct virtio_video_stream *stream,=0A+=09=09=09=09 =
      struct vb2_buffer *vb)=0A+{=0A+=09int ret;=0A+=09unsigned int i;=0A+=
=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct scatterlist *sg;=0A+=
=09struct virtio_video_mem_entry *ents;=0A+=09struct sg_table *sgt =3D vb2_=
dma_sg_plane_desc(vb, idx);=0A+=0A+=09/* Freed when the request has been co=
mpleted */=0A+=09ents =3D kcalloc(sgt->nents, sizeof(*ents), GFP_KERNEL);=
=0A+=09for_each_sg(sgt->sgl, sg, sgt->nents, i) {=0A+=09=09ents[i].addr =3D=
 cpu_to_le64(vv->has_iommu=0A+=09=09=09=09=09   ? sg_dma_address(sg)=0A+=09=
=09=09=09=09   : sg_phys(sg));=0A+=09=09ents[i].length =3D cpu_to_le32(sg->=
length);=0A+=09}=0A+=0A+=09v4l2_dbg(1, vv->debug, &vv->v4l2_dev, "mem entri=
es:\n");=0A+=09if (vv->debug >=3D 1) {=0A+=09=09for (i =3D 0; i < sgt->nent=
s; i++)=0A+=09=09=09pr_debug("\t%03i: addr=3D%llx length=3D%u\n", i,=0A+=09=
=09=09=09 ents[i].addr, ents[i].length);=0A+=09}=0A+=0A+=09ret =3D virtio_v=
ideo_req_resource_attach_backing(vv, vvd->id,=0A+=09=09=09=09=09=09       s=
tream->stream_id,=0A+=09=09=09=09=09=09       resource_id, ents,=0A+=09=09=
=09=09=09=09       sgt->nents);=0A+=09if (ret)=0A+=09=09kfree(ents);=0A+=0A=
+=09return ret;=0A+}=0A+=0A+static int virtio_video_buf_init(struct vb2_buf=
fer *vb)=0A+{=0A+=09int ret =3D 0;=0A+=09unsigned int i;=0A+=09uint32_t res=
ource_id;=0A+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb-=
>vb2_queue);=0A+=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb(v=
b);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_de=
v);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09virtio_video_resou=
rce_id_get(vv, &resource_id);=0A+=09ret =3D virtio_video_req_resource_creat=
e(vv, vvd->id, stream->stream_id,=0A+=09=09=09=09=09       resource_id);=0A=
+=09if (ret)=0A+=09=09return ret;=0A+=0A+=09for (i =3D 0; i < vb->num_plane=
s; ++i) {=0A+=09=09ret =3D virtio_video_buf_plane_init(i,=0A+=09=09=09=09re=
source_id, vvd, stream, vb);=0A+=09=09if (ret)=0A+=09=09=09break;=0A+=09}=
=0A+=0A+=09if (ret) {=0A+=09=09virtio_video_req_resource_destroy(vvd->vv, v=
vd->id,=0A+=09=09=09=09=09=09  stream->stream_id,=0A+=09=09=09=09=09=09  re=
source_id);=0A+=09=09virtio_video_resource_id_put(vvd->vv, resource_id);=0A=
+=09=09return ret;=0A+=09}=0A+=0A+=09virtio_vb->queued =3D false;=0A+=09vir=
tio_vb->detached =3D false;=0A+=09virtio_vb->resource_id =3D resource_id;=
=0A+=0A+=09return 0;=0A+}=0A+=0A+static void virtio_video_buf_cleanup(struc=
t vb2_buffer *vb)=0A+{=0A+=09int ret;=0A+=09struct virtio_video_stream *str=
eam =3D vb2_get_drv_priv(vb->vb2_queue);=0A+=09struct virtio_video_buffer *=
virtio_vb =3D to_virtio_vb(vb);=0A+=09struct virtio_video_device *vvd =3D t=
o_virtio_vd(stream->video_dev);=0A+=09struct virtio_video *vv =3D vvd->vv;=
=0A+=0A+=09ret =3D virtio_video_req_resource_detach_backing(vv, vvd->id,=0A=
+=09=09=09=09=09=09       stream->stream_id,=0A+=09=09=09=09=09=09       vi=
rtio_vb);=0A+=09if (ret)=0A+=09=09return;=0A+=0A+=09ret =3D wait_event_time=
out(vv->wq, virtio_vb->detached, 5 * HZ);=0A+=09if (ret =3D=3D 0) {=0A+=09=
=09v4l2_err(&vv->v4l2_dev, "timed out waiting for detach\n");=0A+=09=09retu=
rn;=0A+=09}=0A+=0A+=09virtio_video_req_resource_destroy(vv, vvd->id, stream=
->stream_id,=0A+=09=09=09=09=09  virtio_vb->resource_id);=0A+=09virtio_vide=
o_resource_id_put(vv, virtio_vb->resource_id);=0A+}=0A+=0A+static void virt=
io_video_buf_queue(struct vb2_buffer *vb)=0A+{=0A+=09int i, ret;=0A+=09stru=
ct vb2_buffer *src_buf;=0A+=09struct virtio_video_buffer *virtio_vb;=0A+=09=
uint32_t data_size[VB2_MAX_PLANES] =3D {0};=0A+=09struct vb2_v4l2_buffer *v=
4l2_vb =3D to_vb2_v4l2_buffer(vb);=0A+=09struct vb2_v4l2_buffer *src_vb;=0A=
+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);=
=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=
=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09v4l2_m2m_buf_queue(st=
ream->fh.m2m_ctx, v4l2_vb);=0A+=0A+=09if ((stream->state !=3D STREAM_STATE_=
INIT) ||=0A+=09    !V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type))=0A+=09=09retu=
rn;=0A+=0A+=09src_vb =3D v4l2_m2m_next_src_buf(stream->fh.m2m_ctx);=0A+=09i=
f (!src_vb) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "no src buf during initializ=
ation\n");=0A+=09=09return;=0A+=09}=0A+=0A+=09src_buf =3D &src_vb->vb2_buf;=
=0A+=09for (i =3D 0; i < src_buf->num_planes; ++i)=0A+=09=09data_size[i] =
=3D src_buf->planes[i].bytesused;=0A+=0A+=09virtio_vb =3D to_virtio_vb(src_=
buf);=0A+=0A+=09ret =3D virtio_video_req_resource_queue(vv, vvd->id, stream=
->stream_id,=0A+=09=09=09=09=09      virtio_vb, data_size,=0A+=09=09=09=09=
=09      src_buf->num_planes,=0A+=09=09=09=09=09      true);=0A+=09if (ret)=
 {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to queue an src buffer\n");=0A+=
=09=09return;=0A+=09}=0A+=0A+=09virtio_vb->queued =3D true;=0A+=09stream->s=
rc_cleared =3D false;=0A+=09src_vb =3D v4l2_m2m_src_buf_remove(stream->fh.m=
2m_ctx);=0A+}=0A+=0A+static int virtio_video_start_streaming(struct vb2_que=
ue *vq,=0A+=09=09=09=09=09unsigned int count)=0A+{=0A+=09int ret;=0A+=09str=
uct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);=0A+=09struct virt=
io_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct virt=
io_video *vv =3D vvd->vv;=0A+=0A+=09if ((V4L2_TYPE_IS_OUTPUT(vq->type) &&=
=0A+=09    (stream->state =3D=3D STREAM_STATE_INIT)) ||=0A+=09    (stream->=
state =3D=3D STREAM_STATE_STOPPED)) {=0A+=09=09ret =3D virtio_video_req_str=
eam_start(vv, vvd->id,=0A+=09=09=09=09=09=09    stream->stream_id);=0A+=09=
=09if (ret)=0A+=09=09=09return ret;=0A+=09}=0A+=0A+=09if (!V4L2_TYPE_IS_OUT=
PUT(vq->type) &&=0A+=09    (stream->state >=3D STREAM_STATE_INIT))=0A+=09=
=09stream->state =3D STREAM_STATE_RUNNING;=0A+=0A+=09return 0;=0A+}=0A+=0A+=
static void virtio_video_stop_streaming(struct vb2_queue *vq)=0A+{=0A+=09in=
t ret;=0A+=09bool *cleared;=0A+=09bool is_output =3D V4L2_TYPE_IS_OUTPUT(vq=
->type);=0A+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);=
=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=
=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct vb2_v4l2_buffer *v=
4l2_vb;=0A+=0A+=09if (is_output)=0A+=09=09cleared =3D &stream->src_cleared;=
=0A+=09else=0A+=09=09cleared =3D &stream->dst_cleared;=0A+=0A+=09ret =3D vi=
rtio_video_req_queue_clear(vv, vvd->id, stream, is_output);=0A+=09if (ret) =
{=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to clear queue\n");=0A+=09=09ret=
urn;=0A+=09}=0A+=0A+=09ret =3D wait_event_timeout(vv->wq, *cleared, 5 * HZ)=
;=0A+=09if (ret =3D=3D 0) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "timed out wai=
ting for queue clear\n");=0A+=09=09return;=0A+=09}=0A+=0A+=09for (;;) {=0A+=
=09=09if (is_output)=0A+=09=09=09v4l2_vb =3D v4l2_m2m_src_buf_remove(stream=
->fh.m2m_ctx);=0A+=09=09else=0A+=09=09=09v4l2_vb =3D v4l2_m2m_dst_buf_remov=
e(stream->fh.m2m_ctx);=0A+=09=09if (!v4l2_vb)=0A+=09=09=09break;=0A+=09=09v=
4l2_m2m_buf_done(v4l2_vb, VB2_BUF_STATE_ERROR);=0A+=09}=0A+}=0A+=0A+static =
const struct vb2_ops virtio_video_qops =3D {=0A+=09.queue_setup=09 =3D virt=
io_video_queue_setup,=0A+=09.buf_init=09 =3D virtio_video_buf_init,=0A+=09.=
buf_cleanup=09 =3D virtio_video_buf_cleanup,=0A+=09.buf_queue=09 =3D virtio=
_video_buf_queue,=0A+=09.start_streaming =3D virtio_video_start_streaming,=
=0A+=09.stop_streaming  =3D virtio_video_stop_streaming,=0A+=09.wait_prepar=
e=09 =3D vb2_ops_wait_prepare,=0A+=09.wait_finish=09 =3D vb2_ops_wait_finis=
h,=0A+};=0A+=0A+static int virtio_video_g_volatile_ctrl(struct v4l2_ctrl *c=
trl)=0A+{=0A+=09int ret =3D 0;=0A+=09struct virtio_video_stream *stream =3D=
 ctrl2stream(ctrl);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(=
stream->video_dev);=0A+=0A+=09switch (ctrl->id) {=0A+=09case V4L2_CID_MIN_B=
UFFERS_FOR_CAPTURE:=0A+=09=09if (stream->state >=3D STREAM_STATE_METADATA)=
=0A+=09=09=09ctrl->val =3D vvd->out_info.min_buffers;=0A+=09=09else=0A+=09=
=09=09ctrl->val =3D 0;=0A+=09=09break;=0A+=09default:=0A+=09=09ret =3D -EIN=
VAL;=0A+=09}=0A+=0A+=09return ret;=0A+}=0A+=0A+static const struct v4l2_ctr=
l_ops virtio_video_ctrl_ops =3D {=0A+=09.g_volatile_ctrl=09=3D virtio_video=
_g_volatile_ctrl,=0A+};=0A+=0A+int virtio_video_init_dec_ctrls(struct virti=
o_video_stream *stream)=0A+{=0A+=09struct v4l2_ctrl *ctrl;=0A+=0A+=09v4l2_c=
trl_handler_init(&stream->ctrl_handler, 1);=0A+=0A+=09ctrl =3D v4l2_ctrl_ne=
w_std(&stream->ctrl_handler,=0A+=09=09=09=09&virtio_video_ctrl_ops,=0A+=09=
=09=09=09V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,=0A+=09=09=09=09MIN_BUFS_MIN, MIN=
_BUFS_MAX, MIN_BUFS_STEP,=0A+=09=09=09=09MIN_BUFS_DEF);=0A+=09ctrl->flags |=
=3D V4L2_CTRL_FLAG_VOLATILE;=0A+=0A+=09if (stream->ctrl_handler.error)=0A+=
=09=09return stream->ctrl_handler.error;=0A+=0A+=09v4l2_ctrl_handler_setup(=
&stream->ctrl_handler);=0A+=0A+=09return 0;=0A+}=0A+=0A+int virtio_video_in=
it_dec_queues(void *priv, struct vb2_queue *src_vq,=0A+=09=09=09=09 struct =
vb2_queue *dst_vq)=0A+{=0A+=09int ret;=0A+=09struct virtio_video_stream *st=
ream =3D priv;=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(strea=
m->video_dev);=0A+=09struct device *dev =3D vvd->vv->v4l2_dev.dev;=0A+=0A+=
=09src_vq->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;=0A+=09src_vq->io_mod=
es =3D VB2_MMAP | VB2_DMABUF;=0A+=09src_vq->drv_priv =3D stream;=0A+=09src_=
vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);=0A+=09src_vq->o=
ps =3D &virtio_video_qops;=0A+=09src_vq->mem_ops =3D &vb2_dma_sg_memops;=0A=
+=09src_vq->min_buffers_needed =3D vvd->in_info.min_buffers;=0A+=09src_vq->=
timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;=0A+=09src_vq->lock =3D &s=
tream->vq_mutex;=0A+=09src_vq->dev =3D dev;=0A+=0A+=09ret =3D vb2_queue_ini=
t(src_vq);=0A+=09if (ret)=0A+=09=09return ret;=0A+=0A+=09dst_vq->type =3D V=
4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;=0A+=09dst_vq->io_modes =3D VB2_MMAP | VB=
2_DMABUF;=0A+=09dst_vq->drv_priv =3D stream;=0A+=09dst_vq->buf_struct_size =
=3D sizeof(struct virtio_video_buffer);=0A+=09dst_vq->ops =3D &virtio_video=
_qops;=0A+=09dst_vq->mem_ops =3D &vb2_dma_sg_memops;=0A+=09dst_vq->min_buff=
ers_needed =3D vvd->out_info.min_buffers;=0A+=09dst_vq->timestamp_flags =3D=
 V4L2_BUF_FLAG_TIMESTAMP_COPY;=0A+=09dst_vq->lock =3D &stream->vq_mutex;=0A=
+=09dst_vq->dev =3D dev;=0A+=0A+=09return vb2_queue_init(dst_vq);=0A+}=0A+=
=0A+static int virtio_video_querycap(struct file *file, void *fh,=0A+=09=09=
=09=09 struct v4l2_capability *cap)=0A+{=0A+=09struct video_device *video_d=
ev =3D video_devdata(file);=0A+=0A+=09strncpy(cap->driver, DRIVER_NAME, siz=
eof(cap->driver));=0A+=09strncpy(cap->card, video_dev->name, sizeof(cap->ca=
rd));=0A+=09snprintf(cap->bus_info, sizeof(cap->bus_info), "virtio:%s",=0A+=
=09=09 video_dev->name);=0A+=0A+=09cap->device_caps =3D V4L2_CAP_VIDEO_M2M_=
MPLANE | V4L2_CAP_STREAMING;=0A+=09cap->capabilities =3D cap->device_caps |=
 V4L2_CAP_DEVICE_CAPS;=0A+=0A+=09return 0;=0A+}=0A+=0A+static int virtio_vi=
deo_enum_fmt_vid_cap(struct file *file, void *fh,=0A+=09=09=09=09=09 struct=
 v4l2_fmtdesc *f)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2st=
ream(file);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->=
video_dev);=0A+=0A+=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=
=0A+=09=09return -EINVAL;=0A+=0A+=09if (f->index >=3D vvd->num_capture_form=
ats)=0A+=09=09return -EINVAL;=0A+=0A+=09f->pixelformat =3D vvd->capture_fmt=
s[f->index]->fourcc_format;=0A+=0A+=09return 0;=0A+}=0A+=0A+static struct v=
ideo_pix_format *find_pix_format(struct video_pix_format **list,=0A+=09=09=
=09=09=09=09uint32_t fourcc, int num)=0A+{=0A+=09int idx =3D 0;=0A+=0A+=09f=
or (idx =3D 0; idx < num; idx++) {=0A+=09=09if (list[idx]->fourcc_format =
=3D=3D fourcc)=0A+=09=09=09return list[idx];=0A+=09}=0A+=09return NULL;=0A+=
}=0A+=0A+static int virtio_video_try_decoder_cmd(struct file *file, void *f=
h,=0A+=09=09=09=09=09struct v4l2_decoder_cmd *cmd)=0A+{=0A+=09struct virtio=
_video_stream *stream =3D file2stream(file);=0A+=09struct virtio_video_devi=
ce *vvd =3D video_drvdata(file);=0A+=09struct virtio_video *vv =3D vvd->vv;=
=0A+=0A+=09if (stream->state =3D=3D STREAM_STATE_DRAIN)=0A+=09=09return -EB=
USY;=0A+=0A+=09switch (cmd->cmd) {=0A+=09case V4L2_DEC_CMD_STOP:=0A+=09case=
 V4L2_DEC_CMD_START:=0A+=09=09if (cmd->flags !=3D 0) {=0A+=09=09=09v4l2_err=
(&vv->v4l2_dev, "flags=3D%u are not supported",=0A+=09=09=09=09 cmd->flags)=
;=0A+=09=09=09return -EINVAL;=0A+=09=09}=0A+=09=09break;=0A+=09default:=0A+=
=09=09return -EINVAL;=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static int vi=
rtio_video_decoder_cmd(struct file *file, void *fh,=0A+=09=09=09=09    stru=
ct v4l2_decoder_cmd *cmd)=0A+{=0A+=09int ret;=0A+=09struct vb2_queue *src_v=
q, *dst_vq;=0A+=09struct virtio_video_stream *stream =3D file2stream(file);=
=0A+=09struct virtio_video_device *vvd =3D video_drvdata(file);=0A+=09struc=
t virtio_video *vv =3D vvd->vv;=0A+=0A+=09ret =3D virtio_video_try_decoder_=
cmd(file, fh, cmd);=0A+=09if (ret < 0)=0A+=09=09return ret;=0A+=0A+=09dst_v=
q =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,=0A+=09=09=09=09 V4L2_BUF_TYPE_VID=
EO_CAPTURE_MPLANE);=0A+=0A+=09switch (cmd->cmd) {=0A+=09case V4L2_DEC_CMD_S=
TART:=0A+=09=09vb2_clear_last_buffer_dequeued(dst_vq);=0A+=09=09ret =3D vir=
tio_video_req_stream_start(vv, vvd->id,=0A+=09=09=09=09=09=09    stream->st=
ream_id);=0A+=09=09if (ret)=0A+=09=09=09return ret;=0A+=09=09break;=0A+=09c=
ase V4L2_DEC_CMD_STOP:=0A+=09=09src_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_c=
tx,=0A+=09=09=09=09=09 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);=0A+=0A+=09=09if =
(!vb2_is_streaming(src_vq)) {=0A+=09=09=09v4l2_dbg(1, vv->debug,=0A+=09=09=
=09=09 &vv->v4l2_dev, "output is not streaming\n");=0A+=09=09=09return 0;=
=0A+=09=09}=0A+=0A+=09=09if (!vb2_is_streaming(dst_vq)) {=0A+=09=09=09v4l2_=
dbg(1, vv->debug,=0A+=09=09=09=09 &vv->v4l2_dev, "capture is not streaming\=
n");=0A+=09=09=09return 0;=0A+=09=09}=0A+=0A+=09=09ret =3D virtio_video_req=
_stream_drain(vv, vvd->id,=0A+=09=09=09=09=09=09    stream->stream_id);=0A+=
=09=09if (ret) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to drain strea=
m\n");=0A+=09=09=09return ret;=0A+=09=09}=0A+=09=09stream->state =3D STREAM=
_STATE_DRAIN;=0A+=09=09break;=0A+=09default:=0A+=09=09return -EINVAL;=0A+=
=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_enum_framesize=
s(struct file *file, void *fh,=0A+=09=09=09=09=09struct v4l2_frmsizeenum *f=
)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2stream(file);=0A+=
=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=
=09struct video_frame_size *frame_size =3D NULL;=0A+=09int i =3D 0;=0A+=09b=
ool fake_non_discrete =3D false;=0A+=09int idx =3D f->index;=0A+=09struct v=
ideo_pix_format *fmt =3D NULL;=0A+=0A+=09fmt =3D find_pix_format(vvd->outpu=
t_fmts, f->pixel_format,=0A+=09=09=09      vvd->num_output_formats);=0A+=09=
if (fmt =3D=3D NULL)=0A+=09=09fmt =3D find_pix_format(vvd->capture_fmts, f-=
>pixel_format,=0A+=09=09=09=09      vvd->num_capture_formats);=0A+=09if (fm=
t =3D=3D NULL)=0A+=09=09return -EINVAL;=0A+=0A+=09if (idx >=3D fmt->num_siz=
es)=0A+=09=09return -EINVAL;=0A+=0A+=09/* If the index is 0 - it is the fir=
st call of ENUM_FRAMESIZES, that=0A+=09 * defines a type of all the frame s=
izes.=0A+=09 *=0A+=09 * Indexes > 0 can be used later only in case of the t=
ype is discrete.=0A+=09 * But, if there is at least one non-discrete type l=
ater in the array -=0A+=09 * it may be misinterpreted as a discrete one.=0A=
+=09 *=0A+=09 * Hence, check, whether there is a non-discrete frame size, a=
nd if yes=0A+=09 * - return the first of them.=0A+=09 */=0A+=09if (!idx)=0A=
+=09=09for (i =3D 0; i < fmt->num_sizes; i++) {=0A+=09=09=09frame_size =3D =
&fmt->frame_sizes[i];=0A+=09=09=09if (frame_size->min_width !=3D frame_size=
->max_width ||=0A+=09=09=09    frame_size->min_height !=3D frame_size->max_=
height) {=0A+=09=09=09=09idx =3D i;=0A+=09=09=09=09fake_non_discrete =3D tr=
ue;=0A+=09=09=09=09break;=0A+=09=09=09}=0A+=09=09}=0A+=0A+=09/* Index > 0 c=
an be used only for discrete frame sizes. Type of the=0A+=09 * frame sizes =
is equal to type of the first frame size.=0A+=09 */=0A+=09if (idx && !fake_=
non_discrete) {=0A+=09=09frame_size =3D &fmt->frame_sizes[0];=0A+=09=09if (=
frame_size->min_width !=3D frame_size->max_width ||=0A+=09=09    frame_size=
->min_height !=3D frame_size->max_height)=0A+=09=09=09return -EINVAL;=0A+=
=09}=0A+=0A+=09frame_size =3D &fmt->frame_sizes[idx];=0A+=0A+=09if (frame_s=
ize->min_width =3D=3D frame_size->max_width &&=0A+=09   frame_size->min_hei=
ght =3D=3D frame_size->max_height) {=0A+=09=09f->type =3D V4L2_FRMSIZE_TYPE=
_DISCRETE;=0A+=09=09f->discrete.width =3D frame_size->min_width;=0A+=09=09f=
->discrete.height =3D frame_size->min_height;=0A+=09} else {=0A+=09=09if (i=
dx && !fake_non_discrete)=0A+=09=09=09return -EINVAL;=0A+=09=09f->stepwise.=
min_width =3D frame_size->min_width;=0A+=09=09f->stepwise.min_height =3D fr=
ame_size->min_height;=0A+=09=09f->stepwise.step_height =3D frame_size->step=
_height;=0A+=09=09f->stepwise.step_width =3D frame_size->step_width;=0A+=09=
=09f->stepwise.max_height =3D frame_size->max_height;=0A+=09=09f->stepwise.=
max_width =3D frame_size->max_width;=0A+=09=09if (frame_size->step_width =
=3D=3D 1 &&=0A+=09=09    frame_size->min_height =3D=3D 1) {=0A+=09=09=09f->=
type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;=0A+=09=09} else {=0A+=09=09=09f->typ=
e =3D V4L2_FRMSIZE_TYPE_STEPWISE;=0A+=09=09}=0A+=09}=0A+=0A+=09return 0;=0A=
+}=0A+=0A+static bool in_stepped_interval(uint32_t int_start, uint32_t int_=
end,=0A+=09=09=09=09uint32_t step, uint32_t point)=0A+{=0A+=09if (point < i=
nt_start || point > int_end)=0A+=09=09return false;=0A+=0A+=09if (step =3D=
=3D 0 && int_start =3D=3D int_end && int_start =3D=3D point)=0A+=09=09retur=
n true;=0A+=0A+=09if (step !=3D 0 && (point - int_start) % step =3D=3D 0)=
=0A+=09=09return true;=0A+=0A+=09return false;=0A+}=0A+=0A+static int virti=
o_video_enum_framemintervals(struct file *file, void *fh,=0A+=09=09=09=09=
=09     struct v4l2_frmivalenum *f)=0A+{=0A+=09struct virtio_video_stream *=
stream =3D file2stream(file);=0A+=09struct virtio_video_device *vvd =3D to_=
virtio_vd(stream->video_dev);=0A+=09struct video_frame_size *fsize =3D NULL=
;=0A+=09int fsize_idx =3D 0;=0A+=09int i =3D 0;=0A+=09bool fake_non_discret=
e =3D false;=0A+=09int idx =3D f->index;=0A+=09struct video_pix_format *fmt=
 =3D NULL;=0A+=09struct video_frame_rate *frate =3D NULL;=0A+=0A+=09fmt =3D=
 find_pix_format(vvd->output_fmts, f->pixel_format,=0A+=09=09=09      vvd->=
num_output_formats);=0A+=09if (fmt =3D=3D NULL)=0A+=09=09fmt =3D find_pix_f=
ormat(vvd->capture_fmts, f->pixel_format,=0A+=09=09=09=09      vvd->num_cap=
ture_formats);=0A+=09if (fmt =3D=3D NULL)=0A+=09=09return -EINVAL;=0A+=0A+=
=09for (fsize_idx =3D 0; fsize_idx <=3D fmt->num_sizes; fsize_idx++) {=0A+=
=09=09fsize =3D &fmt->frame_sizes[fsize_idx];=0A+=09=09if (in_stepped_inter=
val(fsize->min_width, fsize->max_width,=0A+=09=09=09=09=09fsize->step_width=
, f->width) &&=0A+=09=09   in_stepped_interval(fsize->min_height, fsize->ma=
x_height,=0A+=09=09=09=09=09fsize->step_height, f->height))=0A+=09=09=09bre=
ak;=0A+=09}=0A+=0A+=09if (fsize =3D=3D NULL)=0A+=09=09return -EINVAL;=0A+=
=0A+=09if (idx >=3D fsize->num_rates)=0A+=09=09return -EINVAL;=0A+=0A+=09/*=
 If the index is 0 - it is the first call of ENUM_FRAMEIVALS, that=0A+=09 *=
 defines a type of all the frame intervals.=0A+=09 *=0A+=09 * Indexes > 0 c=
an be used later only in case of the type is discrete.=0A+=09 * But, if the=
re is at least one non-discrete type later in the array -=0A+=09 * it may b=
e misinterpreted as a discrete one.=0A+=09 *=0A+=09 * Hence, check, whether=
 there is a non-discrete frame rate, and if yes=0A+=09 * - return the first=
 of them.=0A+=09 */=0A+=09if (!idx)=0A+=09=09for (i =3D 0; i < fsize->num_r=
ates; i++) {=0A+=09=09=09frate =3D &fsize->frame_rates[i];=0A+=09=09=09if (=
frate->min_rate !=3D frate->max_rate) {=0A+=09=09=09=09fake_non_discrete =
=3D true;=0A+=09=09=09=09idx =3D i;=0A+=09=09=09=09break;=0A+=09=09=09}=0A+=
=09=09}=0A+=0A+=09/* Index > 0 can be used only for discrete frame rates. T=
ype of the=0A+=09 * frame rate is equal to the type of the first frame size=
.=0A+=09 */=0A+=09if (idx && !fake_non_discrete) {=0A+=09=09frate =3D &fsiz=
e->frame_rates[0];=0A+=09=09if (frate->max_rate !=3D frate->min_rate)=0A+=
=09=09=09return -EINVAL;=0A+=09}=0A+=0A+=09frate =3D &fsize->frame_rates[id=
x];=0A+=09if (frate->max_rate =3D=3D frate->min_rate) {=0A+=09=09f->type =
=3D V4L2_FRMIVAL_TYPE_DISCRETE;=0A+=09=09f->discrete.numerator =3D 1;=0A+=
=09=09f->discrete.denominator =3D frate->max_rate;=0A+=09} else {=0A+=09=09=
if (idx && !fake_non_discrete)=0A+=09=09=09return -EINVAL;=0A+=09=09/* If A=
 > B, then 1/A < 1/B, so max denominator =3D min_rate=0A+=09=09 * and vise =
versa=0A+=09=09 */=0A+=09=09f->stepwise.min.numerator =3D 1;=0A+=09=09f->st=
epwise.min.denominator =3D frate->max_rate;=0A+=09=09f->stepwise.max.numera=
tor =3D 1;=0A+=09=09f->stepwise.max.denominator =3D frate->min_rate;=0A+=09=
=09f->stepwise.step.numerator =3D 1;=0A+=09=09f->stepwise.step.denominator =
=3D frate->step;=0A+=09=09if (frate->step =3D=3D 1)=0A+=09=09=09f->type =3D=
 V4L2_FRMIVAL_TYPE_CONTINUOUS;=0A+=09=09else=0A+=09=09=09f->type =3D V4L2_F=
RMIVAL_TYPE_STEPWISE;=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static int vi=
rtio_video_enum_fmt_vid_out(struct file *file, void *fh,=0A+=09=09=09=09=09=
 struct v4l2_fmtdesc *f)=0A+{=0A+=09struct virtio_video_stream *stream =3D =
file2stream(file);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(s=
tream->video_dev);=0A+=0A+=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MP=
LANE)=0A+=09=09return -EINVAL;=0A+=0A+=09if (f->index >=3D vvd->num_output_=
formats)=0A+=09=09return -EINVAL;=0A+=0A+=09f->pixelformat =3D vvd->output_=
fmts[f->index]->fourcc_format;=0A+=0A+=09return 0;=0A+}=0A+=0A+static void =
fill_v4l2_format_from_info(struct video_format_info *info,=0A+=09=09=09=09 =
      struct v4l2_pix_format_mplane *pix_mp)=0A+{=0A+=09int i;=0A+=0A+=09pi=
x_mp->width =3D info->frame_width;=0A+=09pix_mp->height =3D info->frame_hei=
ght;=0A+=09pix_mp->field =3D V4L2_FIELD_NONE;=0A+=09pix_mp->colorspace =3D =
V4L2_COLORSPACE_REC709;=0A+=09pix_mp->xfer_func =3D 0;=0A+=09pix_mp->ycbcr_=
enc =3D 0;=0A+=09pix_mp->quantization =3D 0;=0A+=09memset(pix_mp->reserved,=
 0, sizeof(pix_mp->reserved));=0A+=09memset(pix_mp->plane_fmt[0].reserved, =
0,=0A+=09       sizeof(pix_mp->plane_fmt[0].reserved));=0A+=0A+=09pix_mp->n=
um_planes =3D info->num_planes;=0A+=09pix_mp->pixelformat =3D info->fourcc_=
format;=0A+=0A+=09for (i =3D 0; i < info->num_planes; i++) {=0A+=09=09pix_m=
p->plane_fmt[i].bytesperline =3D=0A+=09=09=09=09=09 info->plane_format[i].s=
tride;=0A+=09=09pix_mp->plane_fmt[i].sizeimage =3D=0A+=09=09=09=09=09 info-=
>plane_format[i].plane_size;=0A+=09}=0A+}=0A+=0A+static int virtio_video_g_=
fmt(struct virtio_video_stream *stream,=0A+=09=09=09      struct v4l2_forma=
t *f)=0A+{=0A+=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;=
=0A+=09struct video_format_info *info;=0A+=0A+=09if (!V4L2_TYPE_IS_OUTPUT(f=
->type))=0A+=09=09info =3D &stream->out_info;=0A+=09else=0A+=09=09info =3D =
&stream->in_info;=0A+=0A+=09fill_v4l2_format_from_info(info, pix_mp);=0A+=
=09return 0;=0A+}=0A+=0A+static int virtio_video_g_fmt_vid_out(struct file =
*file, void *fh,=0A+=09=09=09=09      struct v4l2_format *f)=0A+{=0A+=09ret=
urn virtio_video_g_fmt(file2stream(file), f);=0A+}=0A+=0A+static int virtio=
_video_g_fmt_vid_cap(struct file *file, void *fh,=0A+=09=09=09=09      stru=
ct v4l2_format *f)=0A+{=0A+=09return virtio_video_g_fmt(file2stream(file), =
f);=0A+}=0A+=0A+static inline bool within_range(uint32_t min, uint32_t val,=
 uint32_t max)=0A+{=0A+=09return ((val - min) <=3D (max - min));=0A+}=0A+=
=0A+static inline bool needs_alignment(uint32_t val, uint32_t a)=0A+{=0A+=
=09if (a =3D=3D 0 || IS_ALIGNED(val, a))=0A+=09=09return false;=0A+=0A+=09r=
eturn true;=0A+}=0A+=0A+static int virtio_video_try_fmt(struct virtio_video=
_stream *stream,=0A+=09=09=09=09struct v4l2_format *f)=0A+{=0A+=09int i, id=
x =3D 0;=0A+=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;=0A=
+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A=
+=09struct video_pix_format *fmt =3D NULL;=0A+=09struct video_frame_size *f=
rm_sz =3D NULL;=0A+=09bool found =3D false;=0A+=0A+=09if (V4L2_TYPE_IS_OUTP=
UT(f->type))=0A+=09=09fmt =3D find_pix_format(vvd->output_fmts, pix_mp->pix=
elformat,=0A+=09=09=09=09=09 vvd->num_output_formats);=0A+=09else=0A+=09=09=
fmt =3D find_pix_format(vvd->capture_fmts, pix_mp->pixelformat,=0A+=09=09=
=09=09=09 vvd->num_capture_formats);=0A+=0A+=09if (!fmt) {=0A+=09=09if (f->=
type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=0A+=09=09=09fill_v4l2_forma=
t_from_info(&stream->out_info, pix_mp);=0A+=09=09else if (f->type =3D=3D V4=
L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)=0A+=09=09=09fill_v4l2_format_from_info(&st=
ream->in_info, pix_mp);=0A+=09=09else=0A+=09=09=09return -EINVAL;=0A+=09=09=
return 0;=0A+=09}=0A+=0A+=09for (i =3D 0; i < fmt->num_sizes && !found; i++=
) {=0A+=09=09frm_sz =3D &fmt->frame_sizes[i];=0A+=09=09if (!within_range(fr=
m_sz->min_width, pix_mp->width,=0A+=09=09=09=09 frm_sz->max_width))=0A+=09=
=09=09continue;=0A+=0A+=09=09if (!within_range(frm_sz->min_height, pix_mp->=
height,=0A+=09=09=09=09  frm_sz->max_height))=0A+=09=09=09continue;=0A+=0A+=
=09=09idx =3D i;=0A+=09=09/*=0A+=09=09 * Try to find a more suitable frame =
size. Go with the current=0A+=09=09 * one otherwise.=0A+=09=09 */=0A+=09=09=
if (needs_alignment(pix_mp->width, frm_sz->step_width))=0A+=09=09=09continu=
e;=0A+=0A+=09=09if (needs_alignment(pix_mp->height, frm_sz->step_height))=
=0A+=09=09=09continue;=0A+=0A+=09=09found =3D true;=0A+=09}=0A+=0A+=09if (!=
found) {=0A+=09=09frm_sz =3D &fmt->frame_sizes[idx];=0A+=09=09pix_mp->width=
 =3D clamp(pix_mp->width, frm_sz->min_width,=0A+=09=09=09=09      frm_sz->m=
ax_width);=0A+=09=09if (frm_sz->step_width !=3D 0)=0A+=09=09=09pix_mp->widt=
h =3D ALIGN(pix_mp->width,=0A+=09=09=09=09=09      frm_sz->step_width);=0A+=
=0A+=09=09pix_mp->height =3D clamp(pix_mp->height, frm_sz->min_height,=0A+=
=09=09=09=09      frm_sz->max_height);=0A+=09=09if (frm_sz->step_height !=
=3D 0)=0A+=09=09=09pix_mp->height =3D ALIGN(pix_mp->height,=0A+=09=09=09=09=
       frm_sz->step_height);=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static=
 int virtio_video_s_fmt(struct virtio_video_stream *stream,=0A+=09=09=09   =
   struct v4l2_format *f)=0A+{=0A+=09int i, ret;=0A+=09struct v4l2_pix_form=
at_mplane *pix_mp =3D &f->fmt.pix_mp;=0A+=09struct virtio_video_device *vvd=
 =3D to_virtio_vd(stream->video_dev);=0A+=09struct virtio_video *vv =3D vvd=
->vv;=0A+=09struct video_format_info info;=0A+=09struct video_format_info *=
p_info;=0A+=09enum video_pin_type pin =3D VIDEO_PIN_TYPE_INPUT;=0A+=0A+=09r=
et =3D virtio_video_try_fmt(stream, f);=0A+=09if (ret)=0A+=09=09return ret;=
=0A+=0A+=09info.frame_width =3D pix_mp->width;=0A+=09info.frame_height =3D =
pix_mp->height;=0A+=09info.num_planes =3D pix_mp->num_planes;=0A+=09info.fo=
urcc_format =3D pix_mp->pixelformat;=0A+=0A+=09for (i =3D 0; i < info.num_p=
lanes; i++) {=0A+=09=09info.plane_format[i].stride =3D=0A+=09=09=09=09=09 p=
ix_mp->plane_fmt[i].bytesperline;=0A+=09=09info.plane_format[i].plane_size =
=3D=0A+=09=09=09=09=09 pix_mp->plane_fmt[i].sizeimage;=0A+=09}=0A+=0A+=09if=
 (!V4L2_TYPE_IS_OUTPUT(f->type))=0A+=09=09pin =3D VIDEO_PIN_TYPE_OUTPUT;=0A=
+=0A+=09virtio_video_req_set_params(vv, vvd->id, &info, pin,=0A+=09=09=09=
=09    VIDEO_PARAMS_SCOPE_STREAM, stream);=0A+=0A+=09virtio_video_req_get_p=
arams(vv, vvd->id, VIDEO_PIN_TYPE_INPUT,=0A+=09=09=09=09    VIDEO_PARAMS_SC=
OPE_STREAM, stream);=0A+=0A+=09virtio_video_req_get_params(vv, vvd->id, VID=
EO_PIN_TYPE_OUTPUT,=0A+=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM, stream);=
=0A+=0A+=09if (V4L2_TYPE_IS_OUTPUT(f->type))=0A+=09=09p_info =3D &stream->i=
n_info;=0A+=09else=0A+=09=09p_info =3D &stream->out_info;=0A+=0A+=09fill_v4=
l2_format_from_info(p_info, pix_mp);=0A+=0A+=09if (V4L2_TYPE_IS_OUTPUT(f->t=
ype)) {=0A+=09=09if (stream->state =3D=3D STREAM_STATE_IDLE)=0A+=09=09=09st=
ream->state =3D STREAM_STATE_INIT;=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+=
static int virtio_video_s_fmt_vid_cap(struct file *file, void *fh,=0A+=09=
=09=09=09      struct v4l2_format *f)=0A+{=0A+=09struct virtio_video_stream=
 *stream =3D file2stream(file);=0A+=0A+=09return virtio_video_s_fmt(stream,=
 f);=0A+}=0A+=0A+static int virtio_video_s_fmt_vid_out(struct file *file, v=
oid *fh,=0A+=09=09=09=09      struct v4l2_format *f)=0A+{=0A+=09struct virt=
io_video_stream *stream =3D file2stream(file);=0A+=0A+=09return virtio_vide=
o_s_fmt(stream, f);=0A+}=0A+=0A+static int=0A+virtio_video_subscribe_event(=
struct v4l2_fh *fh,=0A+=09=09=09     const struct v4l2_event_subscription *=
sub)=0A+{=0A+=09switch (sub->type) {=0A+=09case V4L2_EVENT_SOURCE_CHANGE:=
=0A+=09=09return v4l2_src_change_event_subscribe(fh, sub);=0A+=09default:=
=0A+=09=09return -EINVAL;=0A+=09}=0A+}=0A+=0A+static const struct v4l2_ioct=
l_ops virtio_video_device_dec_ioctl_ops =3D {=0A+=09.vidioc_querycap=09=3D =
virtio_video_querycap,=0A+=0A+=09.vidioc_enum_fmt_vid_cap =3D virtio_video_=
enum_fmt_vid_cap,=0A+=09.vidioc_g_fmt_vid_cap=09=3D virtio_video_g_fmt_vid_=
cap,=0A+=09.vidioc_s_fmt_vid_cap=09=3D virtio_video_s_fmt_vid_cap,=0A+=0A+=
=09.vidioc_g_fmt_vid_cap_mplane=09=3D virtio_video_g_fmt_vid_cap,=0A+=09.vi=
dioc_s_fmt_vid_cap_mplane=09=3D virtio_video_s_fmt_vid_cap,=0A+=0A+=09.vidi=
oc_enum_fmt_vid_out =3D virtio_video_enum_fmt_vid_out,=0A+=09.vidioc_g_fmt_=
vid_out=09=3D virtio_video_g_fmt_vid_out,=0A+=09.vidioc_s_fmt_vid_out=09=3D=
 virtio_video_s_fmt_vid_out,=0A+=0A+=09.vidioc_g_fmt_vid_out_mplane=09=3D v=
irtio_video_g_fmt_vid_out,=0A+=09.vidioc_s_fmt_vid_out_mplane=09=3D virtio_=
video_s_fmt_vid_out,=0A+=0A+=09.vidioc_try_decoder_cmd=09=3D virtio_video_t=
ry_decoder_cmd,=0A+=09.vidioc_decoder_cmd=09=3D virtio_video_decoder_cmd,=
=0A+=09.vidioc_enum_frameintervals =3D virtio_video_enum_framemintervals,=
=0A+=09.vidioc_enum_framesizes =3D virtio_video_enum_framesizes,=0A+=0A+=09=
.vidioc_reqbufs=09=09=3D v4l2_m2m_ioctl_reqbufs,=0A+=09.vidioc_querybuf=09=
=3D v4l2_m2m_ioctl_querybuf,=0A+=09.vidioc_qbuf=09=09=3D v4l2_m2m_ioctl_qbu=
f,=0A+=09.vidioc_dqbuf=09=09=3D v4l2_m2m_ioctl_dqbuf,=0A+=09.vidioc_prepare=
_buf=09=3D v4l2_m2m_ioctl_prepare_buf,=0A+=09.vidioc_create_bufs=09=3D v4l2=
_m2m_ioctl_create_bufs,=0A+=09.vidioc_expbuf=09=09=3D v4l2_m2m_ioctl_expbuf=
,=0A+=0A+=09.vidioc_streamon=09=3D v4l2_m2m_ioctl_streamon,=0A+=09.vidioc_s=
treamoff=09=3D v4l2_m2m_ioctl_streamoff,=0A+=0A+=09.vidioc_subscribe_event =
=3D virtio_video_subscribe_event,=0A+=09.vidioc_unsubscribe_event =3D v4l2_=
event_unsubscribe,=0A+};=0A+=0A+int virtio_video_dec_init(struct virtio_vid=
eo_device *vvd)=0A+{=0A+=09struct video_device *vd =3D NULL;=0A+=0A+=09if (=
!vvd)=0A+=09=09return -EINVAL;=0A+=0A+=09vd =3D &vvd->video_dev;=0A+=09vd->=
ioctl_ops =3D &virtio_video_device_dec_ioctl_ops;=0A+=09return 0;=0A+}=0Adi=
ff --git a/drivers/media/virtio/virtio_video_dec.h b/drivers/media/virtio/v=
irtio_video_dec.h=0Anew file mode 100644=0Aindex 000000000000..5f67478ef9c5=
=0A--- /dev/null=0A+++ b/drivers/media/virtio/virtio_video_dec.h=0A@@ -0,0 =
+1,30 @@=0A+/* SPDX-License-Identifier: GPL-2.0+ */=0A+/* Decoder header fo=
r virtio video driver.=0A+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A+ *=
=0A+ * This program is free software; you can redistribute it and/or modify=
=0A+ * it under the terms of the GNU General Public License as published by=
=0A+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A+ *=0A+ * This program is distrib=
uted in the hope that it will be useful,=0A+ * but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of=0A+ * MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE.  See the=0A+ * GNU General Public License for more detai=
ls.=0A+ *=0A+ * You should have received a copy of the GNU General Public L=
icense=0A+ * along with this program; if not, see <http://www.gnu.org/licen=
ses/>.=0A+ */=0A+=0A+#ifndef _VIRTIO_VIDEO_DEC_H=0A+#define _VIRTIO_VIDEO_D=
EC_H=0A+=0A+#include "virtio_video.h"=0A+=0A+int virtio_video_dec_init(stru=
ct virtio_video_device *vvd);=0A+int virtio_video_init_dec_ctrls(struct vir=
tio_video_stream *stream);=0A+int virtio_video_init_dec_queues(void *priv, =
struct vb2_queue *src_vq,=0A+=09=09=09=09 struct vb2_queue *dst_vq);=0A+=0A=
+#endif /* _VIRTIO_VIDEO_DEC_H */=0Adiff --git a/drivers/media/virtio/virti=
o_video_device.c b/drivers/media/virtio/virtio_video_device.c=0Anew file mo=
de 100644=0Aindex 000000000000..d105a2fb1594=0A--- /dev/null=0A+++ b/driver=
s/media/virtio/virtio_video_device.c=0A@@ -0,0 +1,747 @@=0A+// SPDX-License=
-Identifier: GPL-2.0+=0A+/* Driver for virtio video device.=0A+ *=0A+ * Cop=
yright 2019 OpenSynergy GmbH.=0A+ *=0A+ * This program is free software; yo=
u can redistribute it and/or modify=0A+ * it under the terms of the GNU Gen=
eral Public License as published by=0A+ * the Free Software Foundation; eit=
her version 2 of the License, or=0A+ * (at your option) any later version.=
=0A+ *=0A+ * This program is distributed in the hope that it will be useful=
,=0A+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A+ =
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A+ * GNU G=
eneral Public License for more details.=0A+ *=0A+ * You should have receive=
d a copy of the GNU General Public License=0A+ * along with this program; i=
f not, see <http://www.gnu.org/licenses/>.=0A+ */=0A+=0A+#include <media/v4=
l2-event.h>=0A+#include <media/v4l2-ioctl.h>=0A+#include <media/videobuf2-d=
ma-sg.h>=0A+=0A+#include "virtio_video.h"=0A+#include "virtio_video_dec.h"=
=0A+#include "virtio_video_enc.h"=0A+=0A+void virtio_video_queue_eos_event(=
struct virtio_video_stream *stream)=0A+{=0A+=09static const struct v4l2_eve=
nt eos_event =3D {=0A+=09=09.type =3D V4L2_EVENT_EOS=0A+=09};=0A+=0A+=09v4l=
2_event_queue_fh(&stream->fh, &eos_event);=0A+}=0A+=0A+void virtio_video_qu=
eue_res_chg_event(struct virtio_video_stream *stream)=0A+{=0A+=09static con=
st struct v4l2_event ev_src_ch =3D {=0A+=09=09.type =3D V4L2_EVENT_SOURCE_C=
HANGE,=0A+=09=09.u.src_change.changes =3D=0A+=09=09=09V4L2_EVENT_SRC_CH_RES=
OLUTION,=0A+=09};=0A+=0A+=09v4l2_event_queue_fh(&stream->fh, &ev_src_ch);=
=0A+}=0A+=0A+void virtio_video_mark_drain_complete(struct virtio_video_stre=
am *stream,=0A+=09=09=09=09      struct vb2_v4l2_buffer *v4l2_vb)=0A+{=0A+=
=09struct vb2_buffer *vb2_buf;=0A+=0A+=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_=
LAST;=0A+=0A+=09vb2_buf =3D &v4l2_vb->vb2_buf;=0A+=09vb2_buf->planes[0].byt=
esused =3D 0;=0A+=0A+=09v4l2_m2m_buf_done(v4l2_vb, VB2_BUF_STATE_DONE);=0A+=
=09stream->state =3D STREAM_STATE_STOPPED;=0A+}=0A+=0A+void virtio_video_bu=
f_done(struct virtio_video_buffer *virtio_vb,=0A+=09=09=09   uint32_t flags=
, uint64_t timestamp, uint32_t size)=0A+{=0A+=09int i, ret;=0A+=09enum vb2_=
buffer_state done_state =3D VB2_BUF_STATE_DONE;=0A+=09struct vb2_v4l2_buffe=
r *v4l2_vb =3D &virtio_vb->v4l2_m2m_vb.vb;=0A+=09struct vb2_buffer *vb =3D =
&v4l2_vb->vb2_buf;=0A+=09struct vb2_queue *vb2_queue =3D vb->vb2_queue;=0A+=
=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb2_queue);=0A+=
=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=
=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct video_format_info *p_i=
nfo;=0A+=0A+=09virtio_vb->queued =3D false;=0A+=0A+=09if (!V4L2_TYPE_IS_OUT=
PUT(vb2_queue->type) &&=0A+=09    stream->check_drain_sequence_pending) {=
=0A+=09=09virtio_video_mark_drain_complete(stream, v4l2_vb);=0A+=09=09strea=
m->check_drain_sequence_pending =3D false;=0A+=09=09return;=0A+=09}=0A+=0A+=
=09if (flags & VIRTIO_VIDEO_BUFFER_F_ERR)=0A+=09=09done_state =3D VB2_BUF_S=
TATE_ERROR;=0A+=0A+=09if (flags & VIRTIO_VIDEO_BUFFER_IFRAME)=0A+=09=09v4l2=
_vb->flags |=3D V4L2_BUF_FLAG_KEYFRAME;=0A+=0A+=09if (flags & VIRTIO_VIDEO_=
BUFFER_BFRAME)=0A+=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_BFRAME;=0A+=0A+=
=09if (flags & VIRTIO_VIDEO_BUFFER_PFRAME)=0A+=09=09v4l2_vb->flags |=3D V4L=
2_BUF_FLAG_PFRAME;=0A+=0A+=09if (flags & VIRTIO_VIDEO_BUFFER_F_EOS) {=0A+=
=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_LAST;=0A+=09=09ret =3D virtio_video=
_req_stream_stop(vv, vvd->id, stream);=0A+=09=09if (ret)=0A+=09=09=09v4l2_e=
rr(&vv->v4l2_dev, "failed to stop stream\n");=0A+=09=09else=0A+=09=09=09str=
eam->state =3D STREAM_STATE_STOPPED;=0A+=09=09virtio_video_queue_eos_event(=
stream);=0A+=09}=0A+=0A+=09if (!V4L2_TYPE_IS_OUTPUT(vb2_queue->type)) {=0A+=
=09=09if (vvd->type =3D=3D VIRTIO_VIDEO_FUNC_ENCODER) {=0A+=09=09=09vb->pla=
nes[0].bytesused =3D size;=0A+=09=09} else if (vvd->type =3D=3D VIRTIO_VIDE=
O_FUNC_DECODER) {=0A+=09=09=09p_info =3D &stream->out_info;=0A+=09=09=09for=
 (i =3D 0; i < p_info->num_planes; i++)=0A+=09=09=09=09vb->planes[i].bytesu=
sed =3D=0A+=09=09=09=09=09p_info->plane_format[i].plane_size;=0A+=09=09}=0A=
+=0A+=09=09vb->timestamp =3D timestamp;=0A+=09}=0A+=0A+=09v4l2_m2m_buf_done=
(v4l2_vb, done_state);=0A+}=0A+=0A+=0A+static void virtio_video_worker(stru=
ct work_struct *work)=0A+{=0A+=09unsigned int i;=0A+=09int ret;=0A+=09struc=
t vb2_buffer *vb2_buf;=0A+=09struct vb2_v4l2_buffer *src_vb, *dst_vb;=0A+=
=09struct virtio_video_buffer *virtio_vb;=0A+=09struct virtio_video_stream =
*stream =3D work2stream(work);=0A+=09struct virtio_video_device *vvd =3D to=
_virtio_vd(stream->video_dev);=0A+=09struct vb2_queue *src_vq =3D=0A+=09=09=
v4l2_m2m_get_vq(stream->fh.m2m_ctx,=0A+=09=09=09=09V4L2_BUF_TYPE_VIDEO_OUTP=
UT_MPLANE);=0A+=09struct vb2_queue *dst_vq =3D=0A+=09=09v4l2_m2m_get_vq(str=
eam->fh.m2m_ctx,=0A+=09=09=09=09V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);=0A+=09=
struct virtio_video *vv =3D vvd->vv;=0A+=09uint32_t data_size[VB2_MAX_PLANE=
S] =3D {0};=0A+=0A+=0A+=09mutex_lock(dst_vq->lock);=0A+=09for (;;) {=0A+=09=
=09dst_vb =3D v4l2_m2m_next_dst_buf(stream->fh.m2m_ctx);=0A+=09=09if (dst_v=
b =3D=3D NULL)=0A+=09=09=09break;=0A+=0A+=09=09vb2_buf =3D &dst_vb->vb2_buf=
;=0A+=09=09virtio_vb =3D to_virtio_vb(vb2_buf);=0A+=0A+=09=09for (i =3D 0; =
i < vb2_buf->num_planes; ++i)=0A+=09=09=09data_size[i] =3D vb2_buf->planes[=
i].bytesused;=0A+=0A+=09=09ret =3D virtio_video_req_resource_queue(vv, vvd-=
>id,=0A+=09=09=09=09=09=09      stream->stream_id,=0A+=09=09=09=09=09=09   =
   virtio_vb, data_size,=0A+=09=09=09=09=09=09      vb2_buf->num_planes,=0A=
+=09=09=09=09=09=09      false);=0A+=09=09if (ret) {=0A+=09=09=09v4l2_info(=
&vv->v4l2_dev,=0A+=09=09=09=09  "failed to queue a dst buffer\n");=0A+=09=
=09=09v4l2_m2m_job_finish(vvd->m2m_dev, stream->fh.m2m_ctx);=0A+=09=09=09mu=
tex_unlock(dst_vq->lock);=0A+=09=09=09return;=0A+=09=09}=0A+=0A+=09=09virti=
o_vb->queued =3D true;=0A+=09=09stream->dst_cleared =3D false;=0A+=09=09dst=
_vb =3D v4l2_m2m_dst_buf_remove(stream->fh.m2m_ctx);=0A+=09}=0A+=09mutex_un=
lock(dst_vq->lock);=0A+=0A+=09mutex_lock(src_vq->lock);=0A+=09for (;;) {=0A=
+=09=09if (stream->state =3D=3D STREAM_STATE_DRAIN)=0A+=09=09=09break;=0A+=
=0A+=09=09src_vb =3D v4l2_m2m_next_src_buf(stream->fh.m2m_ctx);=0A+=09=09if=
 (src_vb =3D=3D NULL)=0A+=09=09=09break;=0A+=0A+=09=09vb2_buf =3D &src_vb->=
vb2_buf;=0A+=09=09virtio_vb =3D to_virtio_vb(vb2_buf);=0A+=0A+=09=09for (i =
=3D 0; i < vb2_buf->num_planes; ++i)=0A+=09=09=09data_size[i] =3D vb2_buf->=
planes[i].bytesused;=0A+=0A+=09=09ret =3D virtio_video_req_resource_queue(v=
v, vvd->id,=0A+=09=09=09=09=09=09      stream->stream_id,=0A+=09=09=09=09=
=09=09      virtio_vb,=0A+=09=09=09=09=09=09=09  data_size,=0A+=09=09=09=09=
=09=09=09  vb2_buf->num_planes,=0A+=09=09=09=09=09=09      true);=0A+=09=09=
if (ret) {=0A+=09=09=09v4l2_info(&vv->v4l2_dev,=0A+=09=09=09=09  "failed to=
 queue an src buffer\n");=0A+=09=09=09v4l2_m2m_job_finish(vvd->m2m_dev, str=
eam->fh.m2m_ctx);=0A+=09=09=09mutex_unlock(src_vq->lock);=0A+=09=09=09retur=
n;=0A+=09=09}=0A+=0A+=09=09virtio_vb->queued =3D true;=0A+=09=09stream->src=
_cleared =3D false;=0A+=09=09src_vb =3D v4l2_m2m_src_buf_remove(stream->fh.=
m2m_ctx);=0A+=09}=0A+=09mutex_unlock(src_vq->lock);=0A+=0A+=09v4l2_m2m_job_=
finish(vvd->m2m_dev, stream->fh.m2m_ctx);=0A+}=0A+=0A+static int virtio_vid=
eo_device_open(struct file *file)=0A+{=0A+=09int ret;=0A+=09uint32_t stream=
_id;=0A+=09char name[TASK_COMM_LEN];=0A+=09struct virtio_video_stream *stre=
am;=0A+=09struct video_device *video_dev =3D video_devdata(file);=0A+=09str=
uct virtio_video_device *vvd =3D video_drvdata(file);=0A+=09struct virtio_v=
ideo *vv =3D vvd->vv;=0A+=0A+=09stream =3D kzalloc(sizeof(*stream), GFP_KER=
NEL);=0A+=09if (!stream)=0A+=09=09return -ENOMEM;=0A+=0A+=09get_task_comm(n=
ame, current);=0A+=09virtio_video_stream_id_get(vv, stream, &stream_id);=0A=
+=09ret =3D virtio_video_req_stream_create(vv, vvd->id, stream_id, name);=
=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to create stream=
\n");=0A+=09=09goto err_stream_create;=0A+=09}=0A+=0A+=09stream->video_dev =
=3D video_dev;=0A+=09stream->stream_id =3D stream_id;=0A+=09stream->state =
=3D STREAM_STATE_IDLE;=0A+=09mutex_init(&stream->vq_mutex);=0A+=09INIT_WORK=
(&stream->work, virtio_video_worker);=0A+=09v4l2_fh_init(&stream->fh, video=
_dev);=0A+=09stream->fh.ctrl_handler =3D &stream->ctrl_handler;=0A+=0A+=09i=
f (vvd->type =3D=3D VIRTIO_VIDEO_FUNC_DECODER) {=0A+=09=09stream->fh.m2m_ct=
x =3D=0A+=09=09=09v4l2_m2m_ctx_init(vvd->m2m_dev, stream,=0A+=09=09=09=09=
=09  &virtio_video_init_dec_queues);=0A+=09} else if (vvd->type =3D=3D VIRT=
IO_VIDEO_FUNC_ENCODER) {=0A+=09=09stream->fh.m2m_ctx =3D=0A+=09=09=09v4l2_m=
2m_ctx_init(vvd->m2m_dev, stream,=0A+=09=09=09=09=09  &virtio_video_init_en=
c_queues);=0A+=09} else {=0A+=09=09v4l2_err(&vv->v4l2_dev, "unsupported dev=
ice type\n");=0A+=09=09goto err_stream_create;=0A+=09}=0A+=0A+=09v4l2_m2m_s=
et_src_buffered(stream->fh.m2m_ctx, true);=0A+=09v4l2_m2m_set_dst_buffered(=
stream->fh.m2m_ctx, true);=0A+=09file->private_data =3D &stream->fh;=0A+=09=
v4l2_fh_add(&stream->fh);=0A+=0A+=09if (vvd->type =3D=3D VIRTIO_VIDEO_FUNC_=
DECODER)=0A+=09=09ret =3D virtio_video_init_dec_ctrls(stream);=0A+=09else i=
f (vvd->type =3D=3D VIRTIO_VIDEO_FUNC_ENCODER)=0A+=09=09ret =3D virtio_vide=
o_init_enc_ctrls(stream);=0A+=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_=
dev, "failed to init controls\n");=0A+=09=09goto err_init_ctrls;=0A+=09}=0A=
+=0A+=09ret =3D virtio_video_req_get_params(vv, vvd->id, VIDEO_PIN_TYPE_INP=
UT,=0A+=09=09=09=09=09  VIDEO_PARAMS_SCOPE_STREAM, stream);=0A+=09if (ret) =
{=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream in params\n");=0A+=
=09=09goto err_init_ctrls;=0A+=09}=0A+=0A+=09ret =3D virtio_video_req_get_p=
arams(vv, vvd->id, VIDEO_PIN_TYPE_OUTPUT,=0A+=09=09=09=09=09  VIDEO_PARAMS_=
SCOPE_STREAM, stream);=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "f=
ailed to get stream out params\n");=0A+=09=09goto err_init_ctrls;=0A+=09}=
=0A+=0A+=09return 0;=0A+=0A+err_init_ctrls:=0A+=09v4l2_fh_del(&stream->fh);=
=0A+=09v4l2_fh_exit(&stream->fh);=0A+=09mutex_lock(video_dev->lock);=0A+=09=
v4l2_m2m_ctx_release(stream->fh.m2m_ctx);=0A+=09mutex_unlock(video_dev->loc=
k);=0A+err_stream_create:=0A+=09virtio_video_stream_id_put(vv, stream_id);=
=0A+=09kfree(stream);=0A+=0A+=09return ret;=0A+}=0A+=0A+static int virtio_v=
ideo_device_release(struct file *file)=0A+{=0A+=09struct virtio_video_strea=
m *stream =3D file2stream(file);=0A+=09struct video_device *video_dev =3D v=
ideo_devdata(file);=0A+=09struct virtio_video_device *vvd =3D video_drvdata=
(file);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09v4l2_fh_del(&s=
tream->fh);=0A+=09v4l2_fh_exit(&stream->fh);=0A+=09mutex_lock(video_dev->lo=
ck);=0A+=09v4l2_m2m_ctx_release(stream->fh.m2m_ctx);=0A+=09mutex_unlock(vid=
eo_dev->lock);=0A+=0A+=09virtio_video_req_stream_destroy(vv, vvd->id, strea=
m->stream_id);=0A+=09virtio_video_stream_id_put(vv, stream->stream_id);=0A+=
=0A+=09kfree(stream);=0A+=0A+=09return 0;=0A+}=0A+=0A+static const struct v=
4l2_file_operations virtio_video_device_fops =3D {=0A+=09.owner=09=09=3D TH=
IS_MODULE,=0A+=09.open=09=09=3D virtio_video_device_open,=0A+=09.release=09=
=3D virtio_video_device_release,=0A+=09.poll=09=09=3D v4l2_m2m_fop_poll,=0A=
+=09.unlocked_ioctl=09=3D video_ioctl2,=0A+=09.mmap=09=09=3D v4l2_m2m_fop_m=
map,=0A+};=0A+=0A+static void virtio_video_device_run(void *priv)=0A+{=0A+=
=09struct virtio_video_stream *stream =3D priv;=0A+=09struct virtio_video_d=
evice *vvd =3D to_virtio_vd(stream->video_dev);=0A+=0A+=09queue_work(vvd->w=
orkqueue, &stream->work);=0A+}=0A+=0A+static int virtio_video_device_job_re=
ady(void *priv)=0A+{=0A+=09struct virtio_video_stream *stream =3D priv;=0A+=
=0A+=09if (stream->state =3D=3D STREAM_STATE_STOPPED)=0A+=09=09return 0;=0A=
+=0A+=09if (v4l2_m2m_num_src_bufs_ready(stream->fh.m2m_ctx) > 0 ||=0A+=09  =
  v4l2_m2m_num_dst_bufs_ready(stream->fh.m2m_ctx) > 0)=0A+=09=09return 1;=
=0A+=0A+=09return 0;=0A+}=0A+=0A+static void virtio_video_device_job_abort(=
void *priv)=0A+{=0A+=09struct virtio_video_stream *stream =3D priv;=0A+=09s=
truct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=0A+=
=09v4l2_m2m_job_finish(vvd->m2m_dev, stream->fh.m2m_ctx);=0A+}=0A+=0A+stati=
c const struct v4l2_m2m_ops virtio_video_device_m2m_ops =3D {=0A+=09.device=
_run=09=3D virtio_video_device_run,=0A+=09.job_ready=09=3D virtio_video_dev=
ice_job_ready,=0A+=09.job_abort=09=3D virtio_video_device_job_abort,=0A+};=
=0A+=0A+uint32_t virtio_video_control_to_v4l2(uint32_t control_type)=0A+{=
=0A+=09switch (control_type) {=0A+=09case VIRTIO_VIDEO_CONTROL_BITRATE:=0A+=
=09=09return V4L2_CID_MPEG_VIDEO_BITRATE;=0A+=09case VIRTIO_VIDEO_CONTROL_P=
ROFILE:=0A+=09=09return V4L2_CID_MPEG_VIDEO_H264_PROFILE;=0A+=09case VIRTIO=
_VIDEO_CONTROL_LEVEL:=0A+=09=09return V4L2_CID_MPEG_VIDEO_H264_LEVEL;=0A+=
=09default:=0A+=09=09return 0;=0A+=09}=0A+}=0A+=0A+uint32_t virtio_video_pr=
ofile_to_v4l2(uint32_t profile)=0A+{=0A+=09switch (profile) {=0A+=09case VI=
RTIO_MPEG_VIDEO_H264_PROFILE_BASELINE:=0A+=09=09return V4L2_MPEG_VIDEO_H264=
_PROFILE_BASELINE;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BA=
SELINE:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE;=
=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_MAIN:=0A+=09=09return V4L2_MPEG_=
VIDEO_H264_PROFILE_MAIN;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_EXTENDED=
:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED;=0A+=09case VIRTIO_=
MPEG_VIDEO_H264_PROFILE_HIGH:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_=
HIGH;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_10:=0A+=09=09return V4=
L2_MPEG_VIDEO_H264_PROFILE_HIGH_10;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFI=
LE_HIGH_422:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422;=0A+=09c=
ase VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE:=0A+=09=09return V4L=
2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE;=0A+=09case VIRTIO_MPEG_VIDEO=
_H264_PROFILE_HIGH_10_INTRA:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_H=
IGH_10_INTRA;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA:=0A+=
=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA;=0A+=09case VIRTIO=
_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA:=0A+=09=09return V4L2_MPEG_VIDEO_H2=
64_PROFILE_HIGH_444_INTRA;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_CAVLC_=
444_INTRA:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA;=0A=
+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE:=0A+=09=09return =
V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE;=0A+=09case VIRTIO_MPEG_VIDE=
O_H264_PROFILE_SCALABLE_HIGH:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_=
SCALABLE_HIGH;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTR=
A:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA;=0A+=09=
case VIRTIO_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH:=0A+=09=09return V4L2_MPEG_=
VIDEO_H264_PROFILE_STEREO_HIGH;=0A+=09case VIRTIO_MPEG_VIDEO_H264_PROFILE_M=
ULTIVIEW_HIGH:=0A+=09=09return V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH;=
=0A+=09default:=0A+=09=09return 0;=0A+=09}=0A+}=0A+=0A+uint32_t virtio_vide=
o_level_to_v4l2(uint32_t level)=0A+{=0A+=09switch (level) {=0A+=09case VIRT=
IO_MPEG_VIDEO_H264_LEVEL_1_0:=0A+=09=09return V4L2_MPEG_VIDEO_H264_LEVEL_1_=
0;=0A+=09case VIRTIO_MPEG_VIDEO_H264_LEVEL_2_0:=0A+=09=09return V4L2_MPEG_V=
IDEO_H264_LEVEL_2_0;=0A+=09case VIRTIO_MPEG_VIDEO_H264_LEVEL_4_0:=0A+=09=09=
return V4L2_MPEG_VIDEO_H264_LEVEL_4_0;=0A+=09case VIRTIO_MPEG_VIDEO_H264_LE=
VEL_4_1:=0A+=09=09return V4L2_MPEG_VIDEO_H264_LEVEL_4_1;=0A+=09case VIRTIO_=
MPEG_VIDEO_H264_LEVEL_4_2:=0A+=09=09return V4L2_MPEG_VIDEO_H264_LEVEL_4_2;=
=0A+=09case VIRTIO_MPEG_VIDEO_H264_LEVEL_5_0:=0A+=09=09return V4L2_MPEG_VID=
EO_H264_LEVEL_5_0;=0A+=09case VIRTIO_MPEG_VIDEO_H264_LEVEL_5_1:=0A+=09=09re=
turn V4L2_MPEG_VIDEO_H264_LEVEL_5_1;=0A+=09default:=0A+=09=09return 0;=0A+=
=09}=0A+}=0A+=0A+uint32_t virtio_video_v4l2_control_to_virtio(uint32_t v4l2=
_control)=0A+{=0A+=09switch (v4l2_control) {=0A+=09case V4L2_CID_MPEG_VIDEO=
_BITRATE:=0A+=09=09return VIRTIO_VIDEO_CONTROL_BITRATE;=0A+=09case V4L2_CID=
_MPEG_VIDEO_H264_PROFILE:=0A+=09=09return VIRTIO_VIDEO_CONTROL_PROFILE;=0A+=
=09case V4L2_CID_MPEG_VIDEO_H264_LEVEL:=0A+=09=09return VIRTIO_VIDEO_CONTRO=
L_LEVEL;=0A+=09default:=0A+=09=09return 0;=0A+=09}=0A+}=0A+=0A+uint32_t vir=
tio_video_v4l2_profile_to_virtio(uint32_t v4l2_profile)=0A+{=0A+=09switch (=
v4l2_profile) {=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE:=0A+=09=09=
return VIRTIO_MPEG_VIDEO_H264_PROFILE_BASELINE;=0A+=09case V4L2_MPEG_VIDEO_=
H264_PROFILE_MAIN:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_MAIN;=0A+=
=09case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:=0A+=09=09return VIRTIO_MPEG_=
VIDEO_H264_PROFILE_EXTENDED;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:=
=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH;=0A+=09case V4L2_MPEG_=
VIDEO_H264_PROFILE_HIGH_10:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_=
HIGH_10;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422:=0A+=09=09return =
VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_422;=0A+=09case V4L2_MPEG_VIDEO_H264_PR=
OFILE_HIGH_444_PREDICTIVE:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_H=
IGH_444_PREDICTIVE;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA:=
=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA;=0A+=09case V=
4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA:=0A+=09=09return VIRTIO_MPEG_VID=
EO_H264_PROFILE_HIGH_422_INTRA;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_HIG=
H_444_INTRA:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA;=
=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA:=0A+=09=09return V=
IRTIO_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA;=0A+=09case V4L2_MPEG_VIDEO_H=
264_PROFILE_SCALABLE_BASELINE:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFI=
LE_SCALABLE_BASELINE;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH=
:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH;=0A+=09case =
V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA:=0A+=09=09return VIRTIO_MP=
EG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA;=0A+=09case V4L2_MPEG_VIDEO_H264_=
PROFILE_STEREO_HIGH:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_PROFILE_STEREO_=
HIGH;=0A+=09case V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH:=0A+=09=09retu=
rn VIRTIO_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH;=0A+=09default:=0A+=09=09r=
eturn VIRTIO_MPEG_VIDEO_H264_PROFILE_UNDEFINED;=0A+=09}=0A+}=0A+=0A+uint32_=
t virtio_video_v4l2_level_to_virtio(uint32_t v4l2_level)=0A+{=0A+=09switch =
(v4l2_level) {=0A+=09case V4L2_MPEG_VIDEO_H264_LEVEL_1_0:=0A+=09=09return V=
IRTIO_MPEG_VIDEO_H264_LEVEL_1_0;=0A+=09case V4L2_MPEG_VIDEO_H264_LEVEL_2_0:=
=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_LEVEL_2_0;=0A+=09case V4L2_MPEG_VID=
EO_H264_LEVEL_4_0:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_LEVEL_4_0;=0A+=09=
case V4L2_MPEG_VIDEO_H264_LEVEL_4_1:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264=
_LEVEL_4_1;=0A+=09case V4L2_MPEG_VIDEO_H264_LEVEL_4_2:=0A+=09=09return VIRT=
IO_MPEG_VIDEO_H264_LEVEL_4_2;=0A+=09case V4L2_MPEG_VIDEO_H264_LEVEL_5_0:=0A=
+=09=09return VIRTIO_MPEG_VIDEO_H264_LEVEL_5_0;=0A+=09case V4L2_MPEG_VIDEO_=
H264_LEVEL_5_1:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_LEVEL_5_1;=0A+=09def=
ault:=0A+=09=09return VIRTIO_MPEG_VIDEO_H264_LEVEL_UNDEFINED;=0A+=09}=0A+}=
=0A+=0A+uint32_t virtio_video_format_to_v4l2(uint32_t pixel_format)=0A+{=0A=
+=0A+=09switch (pixel_format) {=0A+=09case VIRTIO_VIDEO_PIX_FMT_H264:=0A+=
=09=09return V4L2_PIX_FMT_H264;=0A+=09case VIRTIO_VIDEO_PIX_FMT_H265:=0A+=
=09=09return V4L2_PIX_FMT_HEVC;=0A+=09case VIRTIO_VIDEO_PIX_FMT_MPEG4:=0A+=
=09=09return V4L2_PIX_FMT_MPEG4;=0A+=09case VIRTIO_VIDEO_PIX_FMT_MPEG2:=0A+=
=09=09return V4L2_PIX_FMT_MPEG2;=0A+=09case VIRTIO_VIDEO_PIX_FMT_NV12:=0A+=
=09=09return V4L2_PIX_FMT_NV12;=0A+=09case VIRTIO_VIDEO_PIX_FMT_I420:=0A+=
=09=09return V4L2_PIX_FMT_YUV420;=0A+=09default:=0A+=09=09return 0;=0A+=09}=
=0A+}=0A+=0A+uint32_t virtio_video_v4l2_fourcc_to_virtio(uint32_t fourcc)=
=0A+{=0A+=09switch (fourcc) {=0A+=09case V4L2_PIX_FMT_H264:=0A+=09=09return=
 VIRTIO_VIDEO_PIX_FMT_H264;=0A+=09case V4L2_PIX_FMT_HEVC:=0A+=09=09return V=
IRTIO_VIDEO_PIX_FMT_H265;=0A+=09case V4L2_PIX_FMT_MPEG4:=0A+=09=09return VI=
RTIO_VIDEO_PIX_FMT_MPEG4;=0A+=09case V4L2_PIX_FMT_MPEG2:=0A+=09=09return VI=
RTIO_VIDEO_PIX_FMT_MPEG2;=0A+=09case V4L2_PIX_FMT_NV12:=0A+=09=09return VIR=
TIO_VIDEO_PIX_FMT_NV12;=0A+=09case V4L2_PIX_FMT_YUV420:=0A+=09=09return VIR=
TIO_VIDEO_PIX_FMT_I420;=0A+=09default:=0A+=09=09return VIRTIO_VIDEO_PIX_FMT=
_UNKNOWN;=0A+=09}=0A+}=0A+=0A+static int virtio_video_device_init(struct vi=
rtio_video_device *vvd)=0A+{=0A+=09int ret =3D 0;=0A+=09const char *device_=
name =3D NULL;=0A+=09struct video_device *vd =3D NULL;=0A+=09struct virtio_=
video *vv =3D NULL;=0A+=0A+=09if (!vvd)=0A+=09=09return -EINVAL;=0A+=0A+=09=
vd =3D &vvd->video_dev;=0A+=09vv =3D vvd->vv;=0A+=0A+=09switch (vvd->type) =
{=0A+=09case VIRTIO_VIDEO_FUNC_ENCODER:=0A+=09=09device_name =3D "stateful-=
encoder";=0A+=09=09ret =3D virtio_video_enc_init(vvd);=0A+=09=09break;=0A+=
=09case VIRTIO_VIDEO_FUNC_DECODER:=0A+=09=09device_name =3D "stateful-decod=
er";=0A+=09=09ret =3D virtio_video_dec_init(vvd);=0A+=09=09break;=0A+=09cas=
e VIRTIO_VIDEO_FUNC_PROCESSOR:=0A+=09case VIRTIO_VIDEO_FUNC_CAPTURE:=0A+=09=
case VIRTIO_VIDEO_FUNC_OUTPUT:=0A+=09default:=0A+=09=09ret =3D -EINVAL;=0A+=
=09=09break;=0A+=09}=0A+=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev, =
"failed to init device type");=0A+=09=09return ret;=0A+=09}=0A+=0A+=09ret =
=3D video_register_device(vd, VFL_TYPE_GRABBER, 0);=0A+=09if (ret) {=0A+=09=
=09v4l2_err(&vv->v4l2_dev, "failed to register video device\n");=0A+=09=09r=
eturn ret;=0A+=09}=0A+=0A+=09vvd->workqueue =3D alloc_ordered_workqueue(vd-=
>name,=0A+=09=09=09=09=09=09 WQ_MEM_RECLAIM | WQ_FREEZABLE);=0A+=09if (!vvd=
->workqueue) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to create a workque=
ue");=0A+=09=09video_unregister_device(vd);=0A+=09=09return -ENOMEM;=0A+=09=
}=0A+=0A+=09list_add(&vvd->devices_list_entry, &vv->devices_list);=0A+=09v4=
l2_info(&vv->v4l2_dev, "Device '%s' registered as /dev/video%d\n",=0A+=09=
=09  device_name, vd->num);=0A+=0A+=09return 0;=0A+}=0A+=0A+static void vir=
tio_video_device_deinit(struct virtio_video_device *vvd)=0A+{=0A+=09if (!vv=
d)=0A+=09=09return;=0A+=0A+=09list_del(&vvd->devices_list_entry);=0A+=09flu=
sh_workqueue(vvd->workqueue);=0A+=09destroy_workqueue(vvd->workqueue);=0A+=
=09video_unregister_device(&vvd->video_dev);=0A+}=0A+=0A+static struct virt=
io_video_device *=0A+virtio_video_device_create(struct virtio_video *vv)=0A=
+{=0A+=09struct device *dev =3D NULL;=0A+=09struct video_device *vd =3D NUL=
L;=0A+=09struct v4l2_m2m_dev *m2m_dev =3D NULL;=0A+=09struct virtio_video_d=
evice *vvd =3D NULL;=0A+=0A+=09if (!vv)=0A+=09=09return ERR_PTR(-EINVAL);=
=0A+=0A+=09dev =3D &vv->vdev->dev;=0A+=0A+=09vvd =3D devm_kzalloc(dev, size=
of(*vvd), GFP_KERNEL);=0A+=09if (!vvd)=0A+=09=09return ERR_PTR(-ENOMEM);=0A=
+=0A+=09m2m_dev =3D v4l2_m2m_init(&virtio_video_device_m2m_ops);=0A+=09if (=
IS_ERR(m2m_dev)) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to init m2m dev=
ice\n");=0A+=09=09goto err;=0A+=09}=0A+=0A+=09vvd->vv =3D vv;=0A+=09vvd->m2=
m_dev =3D m2m_dev;=0A+=09mutex_init(&vvd->video_dev_mutex);=0A+=09vd =3D &v=
vd->video_dev;=0A+=09vd->lock =3D &vvd->video_dev_mutex;=0A+=09vd->v4l2_dev=
 =3D &vv->v4l2_dev;=0A+=09vd->vfl_dir =3D VFL_DIR_M2M;=0A+=09vd->ioctl_ops =
=3D NULL;=0A+=09vd->fops =3D &virtio_video_device_fops;=0A+=09vd->device_ca=
ps =3D V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;=0A+=09vd->release =
=3D video_device_release_empty;=0A+=0A+=09memset(vd->name, 0, sizeof(vd->na=
me));=0A+=0A+=09video_set_drvdata(vd, vvd);=0A+=0A+=09INIT_LIST_HEAD(&vvd->=
ctrl_caps_list);=0A+=09INIT_LIST_HEAD(&vvd->fmt_caps_list);=0A+=0A+=09vvd->=
num_output_formats =3D 0;=0A+=09vvd->num_capture_formats =3D 0;=0A+=0A+=09r=
eturn vvd;=0A+=0A+err:=0A+=09devm_kfree(dev, vvd);=0A+=0A+=09return ERR_CAS=
T(m2m_dev);=0A+}=0A+=0A+void virtio_video_device_destroy(struct virtio_vide=
o_device *vvd)=0A+{=0A+=09if (!vvd)=0A+=09=09return;=0A+=0A+=09v4l2_m2m_rel=
ease(vvd->m2m_dev);=0A+=09devm_kfree(&vvd->vv->vdev->dev, vvd);=0A+}=0A+=0A=
+int virtio_video_devices_init(struct virtio_video *vv, void *funcs_buf)=0A=
+{=0A+=09int ret =3D 0;=0A+=09int fun_idx =3D 0;=0A+=09size_t offset =3D 0;=
=0A+=0A+=09if (!vv || !funcs_buf)=0A+=09=09return -EINVAL;=0A+=0A+=09for (f=
un_idx =3D 0; fun_idx < vv->num_devices; fun_idx++) {=0A+=09=09struct virti=
o_video_device *vvd =3D NULL;=0A+=09=09size_t func_size =3D 0;=0A+=0A+=09=
=09vvd =3D virtio_video_device_create(vv);=0A+=09=09if (IS_ERR(vvd)) {=0A+=
=09=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09=09 "failed to create virtio v=
ideo device\n");=0A+=09=09=09ret =3D PTR_ERR(vvd);=0A+=09=09=09goto failed;=
=0A+=09=09}=0A+=0A+=09=09func_size =3D virtio_video_parse_virtio_function(f=
uncs_buf +=0A+=09=09=09=09=09=09=09       offset, vvd);=0A+=09=09if (func_s=
ize =3D=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse a func=
tion\n");=0A+=09=09=09virtio_video_device_destroy(vvd);=0A+=09=09=09ret =3D=
 -EINVAL;=0A+=09=09=09goto failed;=0A+=09=09}=0A+=09=09offset +=3D func_siz=
e;=0A+=0A+=09=09ret =3D virtio_video_device_init(vvd);=0A+=09=09if (ret !=
=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09=09 "failed to ini=
t virtio video device\n");=0A+=09=09=09virtio_video_clean_virtio_function(v=
vd);=0A+=09=09=09virtio_video_device_destroy(vvd);=0A+=09=09=09goto failed;=
=0A+=09=09}=0A+=09}=0A+=0A+=09return 0;=0A+=0A+failed:=0A+=09virtio_video_d=
evices_deinit(vv);=0A+=0A+=09return ret;=0A+}=0A+=0A+void virtio_video_devi=
ces_deinit(struct virtio_video *vv)=0A+{=0A+=09struct virtio_video_device *=
vvd =3D NULL, *tmp =3D NULL;=0A+=0A+=09list_for_each_entry_safe(vvd, tmp, &=
vv->devices_list,=0A+=09=09=09=09 devices_list_entry) {=0A+=09=09virtio_vid=
eo_device_deinit(vvd);=0A+=09=09virtio_video_clean_virtio_function(vvd);=0A=
+=09=09virtio_video_device_destroy(vvd);=0A+=09}=0A+}=0Adiff --git a/driver=
s/media/virtio/virtio_video_driver.c b/drivers/media/virtio/virtio_video_dr=
iver.c=0Anew file mode 100644=0Aindex 000000000000..78e02faba7aa=0A--- /dev=
/null=0A+++ b/drivers/media/virtio/virtio_video_driver.c=0A@@ -0,0 +1,278 @=
@=0A+// SPDX-License-Identifier: GPL-2.0+=0A+/*=0A+ * Driver for virtio vid=
eo device.=0A+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A+ *=0A+ * This pr=
ogram is free software; you can redistribute it and/or modify=0A+ * it unde=
r the terms of the GNU General Public License as published by=0A+ * the Fre=
e Software Foundation; either version 2 of the License, or=0A+ * (at your o=
ption) any later version.=0A+ *=0A+ * This program is distributed in the ho=
pe that it will be useful,=0A+ * but WITHOUT ANY WARRANTY; without even the=
 implied warranty of=0A+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the=0A+ * GNU General Public License for more details.=0A+ *=0A+ =
* You should have received a copy of the GNU General Public License=0A+ * a=
long with this program; if not, see <http://www.gnu.org/licenses/>.=0A+ */=
=0A+=0A+#include <linux/module.h>=0A+#include <linux/version.h>=0A+#include=
 <linux/dma-mapping.h>=0A+=0A+#include "virtio_video.h"=0A+=0A+static unsig=
ned int debug;=0A+module_param(debug, uint, 0644);=0A+=0A+static void virti=
o_video_init_vq(struct virtio_video_queue *vvq,=0A+=09=09=09=09 void (*work=
_func)(struct work_struct *work))=0A+{=0A+=09spin_lock_init(&vvq->qlock);=
=0A+=09init_waitqueue_head(&vvq->ack_queue);=0A+=09INIT_WORK(&vvq->dequeue_=
work, work_func);=0A+}=0A+=0A+static void *dma_phys_alloc(struct device *de=
v, size_t size,=0A+=09=09=09    dma_addr_t *dma_handle, gfp_t gfp,=0A+=09=
=09=09    unsigned long attrs)=0A+{=0A+=09void *ret;=0A+=0A+=09ret =3D (voi=
d *)__get_free_pages(gfp, get_order(size));=0A+=09if (ret)=0A+=09=09*dma_ha=
ndle =3D virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);=0A+=0A+=09retur=
n ret;=0A+}=0A+=0A+static void dma_phys_free(struct device *dev, size_t siz=
e,=0A+=09=09=09  void *cpu_addr, dma_addr_t dma_addr,=0A+=09=09=09  unsigne=
d long attrs)=0A+{=0A+=09free_pages((unsigned long)cpu_addr, get_order(size=
));=0A+}=0A+=0A+static dma_addr_t dma_phys_map_page(struct device *dev, str=
uct page *page,=0A+=09=09=09=09    unsigned long offset, size_t size,=0A+=
=09=09=09=09    enum dma_data_direction dir,=0A+=09=09=09=09    unsigned lo=
ng attrs)=0A+{=0A+=09return page_to_phys(page) + offset - PFN_PHYS(dev->dma=
_pfn_offset);=0A+}=0A+=0A+static int dma_phys_map_sg(struct device *dev, st=
ruct scatterlist *sgl,=0A+=09=09=09   int nents, enum dma_data_direction di=
r,=0A+=09=09=09   unsigned long attrs)=0A+{=0A+=09int i;=0A+=09struct scatt=
erlist *sg;=0A+=0A+=09for_each_sg(sgl, sg, nents, i) {=0A+=09=09dma_addr_t =
offset =3D PFN_PHYS(dev->dma_pfn_offset);=0A+=09=09void *va;=0A+=0A+=09=09B=
UG_ON(!sg_page(sg));=0A+=09=09va =3D sg_virt(sg);=0A+=09=09sg_dma_address(s=
g) =3D (dma_addr_t)virt_to_phys(va) - offset;=0A+=09=09sg_dma_len(sg) =3D s=
g->length;=0A+=09}=0A+=0A+=09return nents;=0A+}=0A+=0A+const struct dma_map=
_ops dma_phys_ops =3D {=0A+=09.alloc=09=09=09=3D dma_phys_alloc,=0A+=09.fre=
e=09=09=09=3D dma_phys_free,=0A+=09.map_page=09=09=3D dma_phys_map_page,=0A=
+=09.map_sg=09=09=09=3D dma_phys_map_sg,=0A+};=0A+=0A+static int virtio_vid=
eo_init(struct virtio_video *vv)=0A+{=0A+=09int ret =3D 0;=0A+=09void *resp=
_buf =3D NULL;=0A+=09void *funcs_buf =3D NULL;=0A+=09size_t total_resp_size=
 =3D 0;=0A+=0A+=09if (!vv)=0A+=09=09return -EINVAL;=0A+=0A+=09total_resp_si=
ze =3D vv->funcs_size +=0A+=09=09=09  sizeof(struct virtio_video_get_functi=
ons);=0A+=09resp_buf =3D kzalloc(total_resp_size, GFP_KERNEL);=0A+=09if (IS=
_ERR(resp_buf))=0A+=09=09return -ENOMEM;=0A+=0A+=09ret =3D virtio_video_req=
_funcs(vv, resp_buf, total_resp_size);=0A+=09if (ret) {=0A+=09=09v4l2_err(&=
vv->v4l2_dev,=0A+=09=09=09 "failed to get devices from the host\n");=0A+=09=
=09goto err;=0A+=09}=0A+=0A+=09ret =3D wait_event_timeout(vv->wq, vv->got_f=
uncs, 5 * HZ);=0A+=09if (ret =3D=3D 0) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "=
timed out waiting for get_funcs\n");=0A+=09=09ret =3D -EIO;=0A+=09=09goto e=
rr;=0A+=09}=0A+=0A+=09funcs_buf =3D resp_buf + sizeof(struct virtio_video_c=
trl_hdr);=0A+=09ret =3D virtio_video_devices_init(vv, funcs_buf);=0A+=09if =
(ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "failed to initialize devices\n");=
=0A+=09=09goto err;=0A+=09}=0A+=0A+=09kfree(resp_buf);=0A+=09return 0;=0A+=
=0A+err:=0A+=09kfree(resp_buf);=0A+=09return ret;=0A+};=0A+=0A+static int v=
irtio_video_probe(struct virtio_device *vdev)=0A+{=0A+=09int ret;=0A+=09str=
uct virtio_video *vv;=0A+=09struct virtqueue *vqs[2];=0A+=09struct device *=
dev =3D &vdev->dev;=0A+=0A+=09static const char * const names[] =3D { "cont=
rol", "event" };=0A+=09static vq_callback_t *callbacks[] =3D {=0A+=09=09vir=
tio_video_ctrl_ack,=0A+=09=09virtio_video_event_ack=0A+=09};=0A+=0A+=09vv =
=3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);=0A+=09if (!vv)=0A+=09=09ret=
urn -ENOMEM;=0A+=09vv->vdev =3D vdev;=0A+=09vv->debug =3D debug;=0A+=09vdev=
->priv =3D vv;=0A+=0A+=09spin_lock_init(&vv->resource_idr_lock);=0A+=09idr_=
init(&vv->resource_idr);=0A+=09spin_lock_init(&vv->stream_idr_lock);=0A+=09=
idr_init(&vv->stream_idr);=0A+=0A+=09init_waitqueue_head(&vv->wq);=0A+=0A+=
=09vv->has_iommu =3D !virtio_has_iommu_quirk(vdev);=0A+=09if (!vv->has_iomm=
u)=0A+=09=09set_dma_ops(dev, &dma_phys_ops);=0A+=0A+=09dev_set_name(dev, DR=
IVER_NAME);=0A+=09ret =3D v4l2_device_register(dev, &vv->v4l2_dev);=0A+=09i=
f (ret)=0A+=09=09goto err_v4l2_reg;=0A+=0A+=09virtio_video_init_vq(&vv->ctr=
lq, virtio_video_dequeue_ctrl_func);=0A+=09virtio_video_init_vq(&vv->eventq=
, virtio_video_dequeue_event_func);=0A+=0A+=09ret =3D virtio_find_vqs(vdev,=
 2, vqs, callbacks, names, NULL);=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v=
4l2_dev, "failed to find virt queues\n");=0A+=09=09goto err_vqs;=0A+=09}=0A=
+=0A+=09vv->ctrlq.vq =3D vqs[0];=0A+=09vv->eventq.vq =3D vqs[1];=0A+=0A+=09=
ret =3D virtio_video_alloc_vbufs(vv);=0A+=09if (ret) {=0A+=09=09v4l2_err(&v=
v->v4l2_dev, "failed to alloc vbufs\n");=0A+=09=09goto err_vbufs;=0A+=09}=
=0A+=0A+=09virtio_cread(vdev, struct virtio_video_config, total_functions_s=
ize,=0A+=09=09     &vv->funcs_size);=0A+=09if (!vv->funcs_size) {=0A+=09=09=
v4l2_err(&vv->v4l2_dev, "virtio_functions_size is zero\n");=0A+=09=09ret =
=3D -EINVAL;=0A+=09=09goto err_config;=0A+=09}=0A+=0A+=09virtio_cread(vdev,=
 struct virtio_video_config, num_functions,=0A+=09=09     &vv->num_devices)=
;=0A+=09if (!vv->num_devices) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "num_devic=
es is zero\n");=0A+=09=09ret =3D -EINVAL;=0A+=09=09goto err_config;=0A+=09}=
=0A+=0A+=09ret =3D virtio_video_alloc_events(vv, vv->eventq.vq->num_free);=
=0A+=09if (ret)=0A+=09=09goto err_events;=0A+=0A+=09virtio_device_ready(vde=
v);=0A+=09vv->vq_ready =3D true;=0A+=09vv->got_funcs =3D false;=0A+=0A+=09I=
NIT_LIST_HEAD(&vv->devices_list);=0A+=0A+=09ret =3D virtio_video_init(vv);=
=0A+=09if (ret) {=0A+=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09 "failed to =
init virtio video\n");=0A+=09=09goto err_init;=0A+=09}=0A+=0A+=09return 0;=
=0A+=0A+err_init:=0A+err_events:=0A+err_config:=0A+=09virtio_video_free_vbu=
fs(vv);=0A+err_vbufs:=0A+=09vdev->config->del_vqs(vdev);=0A+err_vqs:=0A+=09=
v4l2_device_unregister(&vv->v4l2_dev);=0A+err_v4l2_reg:=0A+=09devm_kfree(&v=
dev->dev, vv);=0A+=0A+=09return ret;=0A+}=0A+=0A+static void virtio_video_r=
emove(struct virtio_device *vdev)=0A+{=0A+=09struct virtio_video *vv =3D vd=
ev->priv;=0A+=0A+=09virtio_video_devices_deinit(vv);=0A+=09virtio_video_fre=
e_vbufs(vv);=0A+=09vdev->config->del_vqs(vdev);=0A+=09v4l2_device_unregiste=
r(&vv->v4l2_dev);=0A+=09devm_kfree(&vdev->dev, vv);=0A+}=0A+=0A+static stru=
ct virtio_device_id id_table[] =3D {=0A+=09{ VIRTIO_ID_VIDEO, VIRTIO_DEV_AN=
Y_ID },=0A+=09{ 0 },=0A+};=0A+=0A+static unsigned int features[] =3D {=0A+=
=09/* none */=0A+};=0A+=0A+static struct virtio_driver virtio_video_driver =
=3D {=0A+=09.feature_table =3D features,=0A+=09.feature_table_size =3D ARRA=
Y_SIZE(features),=0A+=09.driver.name =3D DRIVER_NAME,=0A+=09.driver.owner =
=3D THIS_MODULE,=0A+=09.id_table =3D id_table,=0A+=09.probe =3D virtio_vide=
o_probe,=0A+=09.remove =3D virtio_video_remove,=0A+};=0A+=0A+module_virtio_=
driver(virtio_video_driver);=0A+=0A+MODULE_DEVICE_TABLE(virtio, id_table);=
=0A+MODULE_DESCRIPTION("virtio video driver");=0A+MODULE_AUTHOR("Dmitry Mor=
ozov <dmitry.morozov@opensynergy.com>");=0A+MODULE_AUTHOR("Kiran Pawar <kir=
an.pawar@opensynergy.com>");=0A+MODULE_AUTHOR("Nikolay Martyanov <nikolay.m=
artyanov@opensynergy.com>");=0A+MODULE_LICENSE("GPL");=0Adiff --git a/drive=
rs/media/virtio/virtio_video_enc.c b/drivers/media/virtio/virtio_video_enc.=
c=0Anew file mode 100644=0Aindex 000000000000..3fe6d0e52d4a=0A--- /dev/null=
=0A+++ b/drivers/media/virtio/virtio_video_enc.c=0A@@ -0,0 +1,1124 @@=0A+//=
 SPDX-License-Identifier: GPL-2.0+=0A+/* Encoder for virtio video device.=
=0A+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A+ *=0A+ * This program is f=
ree software; you can redistribute it and/or modify=0A+ * it under the term=
s of the GNU General Public License as published by=0A+ * the Free Software=
 Foundation; either version 2 of the License, or=0A+ * (at your option) any=
 later version.=0A+ *=0A+ * This program is distributed in the hope that it=
 will be useful,=0A+ * but WITHOUT ANY WARRANTY; without even the implied w=
arranty of=0A+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See =
the=0A+ * GNU General Public License for more details.=0A+ *=0A+ * You shou=
ld have received a copy of the GNU General Public License=0A+ * along with =
this program; if not, see <http://www.gnu.org/licenses/>.=0A+ */=0A+=0A+#in=
clude <media/v4l2-event.h>=0A+#include <media/v4l2-ioctl.h>=0A+#include <me=
dia/videobuf2-dma-sg.h>=0A+=0A+#include "virtio_video.h"=0A+=0A+static int =
virtio_video_queue_setup(struct vb2_queue *vq,=0A+=09=09=09=09    unsigned =
int *num_buffers,=0A+=09=09=09=09    unsigned int *num_planes,=0A+=09=09=09=
=09    unsigned int sizes[],=0A+=09=09=09=09    struct device *alloc_devs[]=
)=0A+{=0A+=09int i;=0A+=09struct virtio_video_stream *stream =3D vb2_get_dr=
v_priv(vq);=0A+=09struct video_format_info *p_info;=0A+=0A+=09if (*num_plan=
es)=0A+=09=09return 0;=0A+=0A+=09if (V4L2_TYPE_IS_OUTPUT(vq->type))=0A+=09=
=09p_info =3D &stream->in_info;=0A+=09else=0A+=09=09p_info =3D &stream->out=
_info;=0A+=0A+=09*num_planes =3D p_info->num_planes;=0A+=0A+=09for (i =3D 0=
; i < p_info->num_planes; i++)=0A+=09=09sizes[i] =3D p_info->plane_format[i=
].plane_size;=0A+=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_buf_p=
lane_init(uint32_t idx,=0A+=09=09=09=09       uint32_t resource_id,=0A+=09=
=09=09=09       struct virtio_video_device *vvd,=0A+=09=09=09=09       stru=
ct virtio_video_stream *stream,=0A+=09=09=09=09       struct vb2_buffer *vb=
)=0A+{=0A+=09int ret;=0A+=09unsigned int i;=0A+=09struct virtio_video *vv =
=3D vvd->vv;=0A+=09struct scatterlist *sg;=0A+=09struct virtio_video_mem_en=
try *ents;=0A+=09struct sg_table *sgt =3D vb2_dma_sg_plane_desc(vb, idx);=
=0A+=0A+=09/* Freed when the request has been completed */=0A+=09ents =3D k=
calloc(sgt->nents, sizeof(*ents), GFP_KERNEL);=0A+=09for_each_sg(sgt->sgl, =
sg, sgt->nents, i) {=0A+=09=09ents[i].addr =3D cpu_to_le64(vv->has_iommu=0A=
+=09=09=09=09=09   ? sg_dma_address(sg)=0A+=09=09=09=09=09   : sg_phys(sg))=
;=0A+=09=09ents[i].length =3D cpu_to_le32(sg->length);=0A+=09}=0A+=0A+=09v4=
l2_dbg(1, vv->debug, &vv->v4l2_dev, "mem entries:\n");=0A+=09if (vv->debug =
>=3D 1) {=0A+=09=09for (i =3D 0; i < sgt->nents; i++)=0A+=09=09=09pr_debug(=
"\t%03i: addr=3D%llx length=3D%u\n", i,=0A+=09=09=09=09 ents[i].addr, ents[=
i].length);=0A+=09}=0A+=0A+=09ret =3D virtio_video_req_resource_attach_back=
ing(vv, vvd->id,=0A+=09=09=09=09=09=09       stream->stream_id,=0A+=09=09=
=09=09=09=09       resource_id, ents,=0A+=09=09=09=09=09=09       sgt->nent=
s);=0A+=09if (ret)=0A+=09=09kfree(ents);=0A+=0A+=09return ret;=0A+}=0A+=0A+=
static int virtio_video_buf_init(struct vb2_buffer *vb)=0A+{=0A+=09int ret =
=3D 0;=0A+=09unsigned int i;=0A+=09uint32_t resource_id;=0A+=09struct virti=
o_video_stream *stream =3D vb2_get_drv_priv(vb->vb2_queue);=0A+=09struct vi=
rtio_video_buffer *virtio_vb =3D to_virtio_vb(vb);=0A+=09struct virtio_vide=
o_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct virtio_vide=
o *vv =3D vvd->vv;=0A+=0A+=09virtio_video_resource_id_get(vv, &resource_id)=
;=0A+=09ret =3D virtio_video_req_resource_create(vv, vvd->id, stream->strea=
m_id,=0A+=09=09=09=09=09       resource_id);=0A+=09if (ret)=0A+=09=09return=
 ret;=0A+=0A+=09for (i =3D 0; i < vb->num_planes; ++i) {=0A+=09=09ret =3D v=
irtio_video_buf_plane_init(i,=0A+=09=09=09=09resource_id, vvd, stream, vb);=
=0A+=09=09if (ret)=0A+=09=09=09break;=0A+=09}=0A+=0A+=09if (ret) {=0A+=09=
=09virtio_video_req_resource_destroy(vvd->vv, vvd->id,=0A+=09=09=09=09=09=
=09  stream->stream_id,=0A+=09=09=09=09=09=09  resource_id);=0A+=09=09virti=
o_video_resource_id_put(vvd->vv, resource_id);=0A+=09=09return ret;=0A+=09}=
=0A+=0A+=09virtio_vb->queued =3D false;=0A+=09virtio_vb->detached =3D false=
;=0A+=09virtio_vb->resource_id =3D resource_id;=0A+=0A+=09return 0;=0A+}=0A=
+=0A+static void virtio_video_buf_cleanup(struct vb2_buffer *vb)=0A+{=0A+=
=09int ret;=0A+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(v=
b->vb2_queue);=0A+=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb=
(vb);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_=
dev);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09ret =3D virtio_v=
ideo_req_resource_detach_backing(vv, vvd->id,=0A+=09=09=09=09=09=09       s=
tream->stream_id,=0A+=09=09=09=09=09=09       virtio_vb);=0A+=09if (ret)=0A=
+=09=09return;=0A+=0A+=09ret =3D wait_event_timeout(vv->wq, virtio_vb->deta=
ched, 5 * HZ);=0A+=09if (ret =3D=3D 0) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "=
timed out waiting for detach\n");=0A+=09=09return;=0A+=09}=0A+=0A+=09virtio=
_video_req_resource_destroy(vv, vvd->id, stream->stream_id,=0A+=09=09=09=09=
=09  virtio_vb->resource_id);=0A+=09virtio_video_resource_id_put(vv, virtio=
_vb->resource_id);=0A+}=0A+=0A+static void virtio_video_buf_queue(struct vb=
2_buffer *vb)=0A+{=0A+=09struct vb2_v4l2_buffer *v4l2_vb =3D to_vb2_v4l2_bu=
ffer(vb);=0A+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb-=
>vb2_queue);=0A+=0A+=09v4l2_m2m_buf_queue(stream->fh.m2m_ctx, v4l2_vb);=0A+=
=0A+=09v4l2_vb =3D v4l2_m2m_next_dst_buf(stream->fh.m2m_ctx);=0A+=09if (v4l=
2_vb && stream->mark_last_buffer_pending) {=0A+=09=09v4l2_vb =3D v4l2_m2m_d=
st_buf_remove(stream->fh.m2m_ctx);=0A+=09=09if (v4l2_vb)=0A+=09=09=09virtio=
_video_mark_drain_complete(stream, v4l2_vb);=0A+=09=09stream->mark_last_buf=
fer_pending =3D false;=0A+=09}=0A+}=0A+=0A+static int virtio_video_start_st=
reaming(struct vb2_queue *vq,=0A+=09=09=09=09=09unsigned int count)=0A+{=0A=
+=09int ret;=0A+=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(=
vq);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_d=
ev);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09if (stream->state=
 =3D=3D STREAM_STATE_INIT ||=0A+=09    (!V4L2_TYPE_IS_OUTPUT(vq->type) &&=
=0A+=09     stream->state =3D=3D STREAM_STATE_RESET) ||=0A+=09    (V4L2_TYP=
E_IS_OUTPUT(vq->type) &&=0A+=09    stream->state =3D=3D STREAM_STATE_STOPPE=
D)) {=0A+=09=09ret =3D virtio_video_req_stream_start(vv, vvd->id,=0A+=09=09=
=09=09=09=09    stream->stream_id);=0A+=09=09if (ret)=0A+=09=09=09return re=
t;=0A+=09=09stream->state =3D STREAM_STATE_RUNNING;=0A+=09}=0A+=0A+=09retur=
n 0;=0A+}=0A+=0A+static void virtio_video_stop_streaming(struct vb2_queue *=
vq)=0A+{=0A+=09int ret;=0A+=09bool *cleared;=0A+=09bool is_output =3D V4L2_=
TYPE_IS_OUTPUT(vq->type);=0A+=09struct virtio_video_stream *stream =3D vb2_=
get_drv_priv(vq);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(st=
ream->video_dev);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct v=
b2_v4l2_buffer *v4l2_vb;=0A+=0A+=09if (is_output)=0A+=09=09cleared =3D &str=
eam->src_cleared;=0A+=09else=0A+=09=09cleared =3D &stream->dst_cleared;=0A+=
=0A+=09if (is_output && stream->state =3D=3D STREAM_STATE_DRAIN)=0A+=09=09s=
tream->check_drain_sequence_pending =3D true;=0A+=0A+=09ret =3D virtio_vide=
o_req_queue_clear(vv, vvd->id, stream, is_output);=0A+=09if (ret) {=0A+=09=
=09v4l2_err(&vv->v4l2_dev, "failed to clear queue\n");=0A+=09=09return;=0A+=
=09}=0A+=0A+=09ret =3D wait_event_timeout(vv->wq, *cleared, 5 * HZ);=0A+=09=
if (ret =3D=3D 0) {=0A+=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for=
 queue clear\n");=0A+=09=09return;=0A+=09}=0A+=0A+=09if (stream->check_drai=
n_sequence_pending) {=0A+=09=09v4l2_vb =3D v4l2_m2m_dst_buf_remove(stream->=
fh.m2m_ctx);=0A+=09=09if (v4l2_vb)=0A+=09=09=09virtio_video_mark_drain_comp=
lete(stream, v4l2_vb);=0A+=09=09else=0A+=09=09=09stream->mark_last_buffer_p=
ending =3D true;=0A+=09}=0A+=0A+=09for (;;) {=0A+=09=09if (is_output)=0A+=
=09=09=09v4l2_vb =3D v4l2_m2m_src_buf_remove(stream->fh.m2m_ctx);=0A+=09=09=
else=0A+=09=09=09v4l2_vb =3D v4l2_m2m_dst_buf_remove(stream->fh.m2m_ctx);=
=0A+=09=09if (!v4l2_vb)=0A+=09=09=09break;=0A+=09=09v4l2_m2m_buf_done(v4l2_=
vb, VB2_BUF_STATE_ERROR);=0A+=09}=0A+=0A+=09if (is_output)=0A+=09=09stream-=
>state =3D STREAM_STATE_STOPPED;=0A+=09else=0A+=09=09stream->state =3D STRE=
AM_STATE_RESET;=0A+}=0A+=0A+static const struct vb2_ops virtio_video_qops =
=3D {=0A+=09.queue_setup=09 =3D virtio_video_queue_setup,=0A+=09.buf_init=
=09 =3D virtio_video_buf_init,=0A+=09.buf_cleanup=09 =3D virtio_video_buf_c=
leanup,=0A+=09.buf_queue=09 =3D virtio_video_buf_queue,=0A+=09.start_stream=
ing =3D virtio_video_start_streaming,=0A+=09.stop_streaming  =3D virtio_vid=
eo_stop_streaming,=0A+=09.wait_prepare=09 =3D vb2_ops_wait_prepare,=0A+=09.=
wait_finish=09 =3D vb2_ops_wait_finish,=0A+};=0A+=0A+static int virtio_vide=
o_s_ctrl(struct v4l2_ctrl *ctrl)=0A+{=0A+=09int ret =3D 0, val;=0A+=09struc=
t virtio_video_stream *stream =3D ctrl2stream(ctrl);=0A+=09struct virtio_vi=
deo_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct virtio_vi=
deo *vv =3D vvd->vv;=0A+=0A+=09switch (ctrl->id) {=0A+=09case V4L2_CID_MPEG=
_VIDEO_BITRATE:=0A+=09=09ret =3D virtio_video_req_set_control(vv, vvd->id,=
=0A+=09=09=09=09=09=09   stream->stream_id,=0A+=09=09=09=09=09=09   ctrl->i=
d, ctrl->val);=0A+=09=09break;=0A+=09case V4L2_CID_MPEG_VIDEO_H264_LEVEL:=
=0A+=09=09val =3D virtio_video_v4l2_level_to_virtio(ctrl->val);=0A+=09=09if=
 (val =3D=3D VIRTIO_MPEG_VIDEO_H264_LEVEL_UNDEFINED)=0A+=09=09=09return -EI=
NVAL;=0A+=09=09ret =3D virtio_video_req_set_control=0A+=09=09=09(vv, vvd->i=
d, stream->stream_id, ctrl->id, val);=0A+=09=09break;=0A+=09case V4L2_CID_M=
PEG_VIDEO_H264_PROFILE:=0A+=09=09val =3D virtio_video_v4l2_profile_to_virti=
o(ctrl->val);=0A+=09=09if (val =3D=3D VIRTIO_MPEG_VIDEO_H264_PROFILE_UNDEFI=
NED)=0A+=09=09=09return -EINVAL;=0A+=09=09ret =3D virtio_video_req_set_cont=
rol=0A+=09=09=09(vv, vvd->id, stream->stream_id, ctrl->id, val);=0A+=09=09b=
reak;=0A+=09default:=0A+=09=09ret =3D -EINVAL;=0A+=09=09break;=0A+=09}=0A+=
=0A+=09return ret;=0A+}=0A+=0A+static int virtio_video_g_volatile_ctrl(stru=
ct v4l2_ctrl *ctrl)=0A+{=0A+=09int ret =3D 0;=0A+=09struct virtio_video_str=
eam *stream =3D ctrl2stream(ctrl);=0A+=09struct virtio_video_device *vvd =
=3D to_virtio_vd(stream->video_dev);=0A+=0A+=09switch (ctrl->id) {=0A+=09ca=
se V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:=0A+=09=09if (stream->state >=3D STREAM_=
STATE_INIT) {=0A+=09=09=09/* TODO: Get the real value from the device */=0A=
+=09=09=09ctrl->val =3D vvd->in_info.min_buffers;=0A+=09=09} else {=0A+=09=
=09=09ctrl->val =3D 0;=0A+=09=09}=0A+=09=09break;=0A+=09default:=0A+=09=09r=
et =3D -EINVAL;=0A+=09}=0A+=0A+=09return ret;=0A+}=0A+=0A+static const stru=
ct v4l2_ctrl_ops virtio_video_ctrl_ops =3D {=0A+=09.g_volatile_ctrl=09=3D v=
irtio_video_g_volatile_ctrl,=0A+=09.s_ctrl=09=09=09=3D virtio_video_s_ctrl,=
=0A+};=0A+=0A+int virtio_video_init_enc_ctrls(struct virtio_video_stream *s=
tream)=0A+{=0A+=09struct v4l2_ctrl *ctrl;=0A+=09struct virtio_video_device =
*vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct virtio_video *vv =3D=
 vvd->vv;=0A+=09struct video_capability *cap =3D NULL;=0A+=0A+=09v4l2_ctrl_=
handler_init(&stream->ctrl_handler, 1);=0A+=0A+=09ctrl =3D v4l2_ctrl_new_st=
d(&stream->ctrl_handler,=0A+=09=09=09=09&virtio_video_ctrl_ops,=0A+=09=09=
=09=09V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,=0A+=09=09=09=09MIN_BUFS_MIN, MIN_BUF=
S_MAX, MIN_BUFS_STEP,=0A+=09=09=09=09MIN_BUFS_DEF);=0A+=09ctrl->flags |=3D =
V4L2_CTRL_FLAG_VOLATILE;=0A+=0A+=09list_for_each_entry(cap, &vvd->ctrl_caps=
_list, caps_list_entry) {=0A+=09=09struct video_controls *video_controls =
=3D &cap->u.controls;=0A+=09=09struct video_control *control =3D NULL;=0A+=
=09=09int ctrl_idx =3D 0;=0A+=0A+=09=09for (ctrl_idx =3D 0; ctrl_idx < vide=
o_controls->num_controls;=0A+=09=09     ctrl_idx++) {=0A+=09=09=09control =
=3D &video_controls->control[ctrl_idx];=0A+=09=09=09if (!control)=0A+=09=09=
=09=09continue;=0A+=0A+=09=09=09switch (control->control_type) {=0A+=09=09=
=09case V4L2_CID_MPEG_VIDEO_BITRATE:=0A+=09=09=09=09v4l2_ctrl_new_std=0A+=
=09=09=09=09=09(&stream->ctrl_handler,=0A+=09=09=09=09=09 &virtio_video_ctr=
l_ops,=0A+=09=09=09=09=09 control->control_type,=0A+=09=09=09=09=09 control=
->min, control->max,=0A+=09=09=09=09=09 control->step, control->def);=0A+=
=09=09=09=09break;=0A+=0A+=09=09=09case V4L2_CID_MPEG_VIDEO_H264_PROFILE:=
=0A+=09=09=09case V4L2_CID_MPEG_VIDEO_H264_LEVEL:=0A+=09=09=09=09v4l2_ctrl_=
new_std_menu=0A+=09=09=09=09=09(&stream->ctrl_handler,=0A+=09=09=09=09=09 &=
virtio_video_ctrl_ops,=0A+=09=09=09=09=09 control->control_type,=0A+=09=09=
=09=09=09 control->max, 0, control->def);=0A+=09=09=09=09break;=0A+=09=09=
=09default:=0A+=09=09=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09=09=09 "unsu=
pported control type\n");=0A+=09=09=09}=0A+=09=09}=0A+=09}=0A+=0A+=09if (st=
ream->ctrl_handler.error)=0A+=09=09return stream->ctrl_handler.error;=0A+=
=0A+=09v4l2_ctrl_handler_setup(&stream->ctrl_handler);=0A+=0A+=09return 0;=
=0A+}=0A+=0A+int virtio_video_init_enc_queues(void *priv, struct vb2_queue =
*src_vq,=0A+=09=09=09=09 struct vb2_queue *dst_vq)=0A+{=0A+=09int ret;=0A+=
=09struct virtio_video_stream *stream =3D priv;=0A+=09struct virtio_video_d=
evice *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct device *dev =
=3D vvd->vv->v4l2_dev.dev;=0A+=0A+=09src_vq->type =3D V4L2_BUF_TYPE_VIDEO_O=
UTPUT_MPLANE;=0A+=09src_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;=0A+=09src_v=
q->drv_priv =3D stream;=0A+=09src_vq->buf_struct_size =3D sizeof(struct vir=
tio_video_buffer);=0A+=09src_vq->ops =3D &virtio_video_qops;=0A+=09src_vq->=
mem_ops =3D &vb2_dma_sg_memops;=0A+=09src_vq->min_buffers_needed =3D vvd->i=
n_info.min_buffers;=0A+=09src_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTA=
MP_COPY;=0A+=09src_vq->lock =3D &stream->vq_mutex;=0A+=09src_vq->dev =3D de=
v;=0A+=0A+=09ret =3D vb2_queue_init(src_vq);=0A+=09if (ret)=0A+=09=09return=
 ret;=0A+=0A+=09dst_vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;=0A+=09=
dst_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;=0A+=09dst_vq->drv_priv =3D stre=
am;=0A+=09dst_vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);=
=0A+=09dst_vq->ops =3D &virtio_video_qops;=0A+=09dst_vq->mem_ops =3D &vb2_d=
ma_sg_memops;=0A+=09dst_vq->min_buffers_needed =3D vvd->out_info.min_buffer=
s;=0A+=09dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;=0A+=09ds=
t_vq->lock =3D &stream->vq_mutex;=0A+=09dst_vq->dev =3D dev;=0A+=0A+=09retu=
rn vb2_queue_init(dst_vq);=0A+}=0A+=0A+static int virtio_video_querycap(str=
uct file *file, void *fh,=0A+=09=09=09=09 struct v4l2_capability *cap)=0A+{=
=0A+=09struct video_device *video_dev =3D video_devdata(file);=0A+=0A+=09st=
rncpy(cap->driver, DRIVER_NAME, sizeof(cap->driver));=0A+=09strncpy(cap->ca=
rd, video_dev->name, sizeof(cap->card));=0A+=09snprintf(cap->bus_info, size=
of(cap->bus_info), "virtio:%s",=0A+=09=09 video_dev->name);=0A+=0A+=09cap->=
device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;=0A+=09cap->=
capabilities =3D cap->device_caps | V4L2_CAP_DEVICE_CAPS;=0A+=0A+=09return =
0;=0A+}=0A+=0A+static int virtio_video_enum_fmt_vid_cap(struct file *file, =
void *fh,=0A+=09=09=09=09=09 struct v4l2_fmtdesc *f)=0A+{=0A+=09struct virt=
io_video_stream *stream =3D file2stream(file);=0A+=09struct virtio_video_de=
vice *vvd =3D to_virtio_vd(stream->video_dev);=0A+=0A+=09if (f->type !=3D V=
4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=0A+=09=09return -EINVAL;=0A+=0A+=09if (f=
->index >=3D vvd->num_capture_formats)=0A+=09=09return -EINVAL;=0A+=0A+=09f=
->pixelformat =3D vvd->capture_fmts[f->index]->fourcc_format;=0A+=0A+=09ret=
urn 0;=0A+}=0A+=0A+static struct video_pix_format *find_pix_format(struct v=
ideo_pix_format **list,=0A+=09=09=09=09=09=09uint32_t fourcc, int num)=0A+{=
=0A+=09int idx =3D 0;=0A+=0A+=09for (idx =3D 0; idx < num; idx++) {=0A+=09=
=09if (list[idx]->fourcc_format =3D=3D fourcc)=0A+=09=09=09return list[idx]=
;=0A+=09}=0A+=09return NULL;=0A+}=0A+=0A+static int virtio_video_try_encode=
r_cmd(struct file *file, void *fh,=0A+=09=09=09=09=09struct v4l2_encoder_cm=
d *cmd)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2stream(file)=
;=0A+=09struct virtio_video_device *vvd =3D video_drvdata(file);=0A+=09stru=
ct virtio_video *vv =3D vvd->vv;=0A+=0A+=09if (stream->state =3D=3D STREAM_=
STATE_DRAIN)=0A+=09=09return -EBUSY;=0A+=0A+=09switch (cmd->cmd) {=0A+=09ca=
se V4L2_ENC_CMD_STOP:=0A+=09case V4L2_ENC_CMD_START:=0A+=09=09if (cmd->flag=
s !=3D 0) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "flags=3D%u are not support=
ed",=0A+=09=09=09=09 cmd->flags);=0A+=09=09=09return -EINVAL;=0A+=09=09}=0A=
+=09=09break;=0A+=09default:=0A+=09=09return -EINVAL;=0A+=09}=0A+=0A+=09ret=
urn 0;=0A+}=0A+=0A+static int virtio_video_encoder_cmd(struct file *file, v=
oid *fh,=0A+=09=09=09=09    struct v4l2_encoder_cmd *cmd)=0A+{=0A+=09int re=
t;=0A+=09struct vb2_queue *src_vq, *dst_vq;=0A+=09struct virtio_video_strea=
m *stream =3D file2stream(file);=0A+=09struct virtio_video_device *vvd =3D =
video_drvdata(file);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=0A+=09r=
et =3D virtio_video_try_encoder_cmd(file, fh, cmd);=0A+=09if (ret < 0)=0A+=
=09=09return ret;=0A+=0A+=09dst_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,=
=0A+=09=09=09=09 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);=0A+=0A+=09switch (cmd=
->cmd) {=0A+=09case V4L2_ENC_CMD_START:=0A+=09=09vb2_clear_last_buffer_dequ=
eued(dst_vq);=0A+=09=09ret =3D virtio_video_req_stream_start(vv, vvd->id,=
=0A+=09=09=09=09=09=09    stream->stream_id);=0A+=09=09if (ret)=0A+=09=09=
=09return ret;=0A+=09=09stream->state =3D STREAM_STATE_RUNNING;=0A+=09=09br=
eak;=0A+=09case V4L2_ENC_CMD_STOP:=0A+=09=09src_vq =3D v4l2_m2m_get_vq(stre=
am->fh.m2m_ctx,=0A+=09=09=09=09=09 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);=0A+=
=0A+=09=09if (!vb2_is_streaming(src_vq)) {=0A+=09=09=09v4l2_dbg(1, vv->debu=
g,=0A+=09=09=09=09 &vv->v4l2_dev, "output is not streaming\n");=0A+=09=09=
=09return 0;=0A+=09=09}=0A+=0A+=09=09if (!vb2_is_streaming(dst_vq)) {=0A+=
=09=09=09v4l2_dbg(1, vv->debug,=0A+=09=09=09=09 &vv->v4l2_dev, "capture is =
not streaming\n");=0A+=09=09=09return 0;=0A+=09=09}=0A+=0A+=09=09ret =3D vi=
rtio_video_req_stream_drain(vv, vvd->id,=0A+=09=09=09=09=09=09    stream->s=
tream_id);=0A+=09=09if (ret) {=0A+=09=09=09v4l2_err(&vv->v4l2_dev, "failed =
to drain stream\n");=0A+=09=09=09return ret;=0A+=09=09}=0A+=0A+=09=09stream=
->state =3D STREAM_STATE_DRAIN;=0A+=09=09break;=0A+=09default:=0A+=09=09ret=
urn -EINVAL;=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static int virtio_vide=
o_enum_framesizes(struct file *file, void *fh,=0A+=09=09=09=09=09struct v4l=
2_frmsizeenum *f)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2st=
ream(file);=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->=
video_dev);=0A+=09struct video_frame_size *frame_size =3D NULL;=0A+=09int i=
 =3D 0;=0A+=09bool fake_non_discrete =3D false;=0A+=09int idx =3D f->index;=
=0A+=09struct video_pix_format *fmt =3D NULL;=0A+=0A+=09fmt =3D find_pix_fo=
rmat(vvd->output_fmts, f->pixel_format,=0A+=09=09=09      vvd->num_output_f=
ormats);=0A+=09if (fmt =3D=3D NULL)=0A+=09=09fmt =3D find_pix_format(vvd->c=
apture_fmts, f->pixel_format,=0A+=09=09=09=09      vvd->num_capture_formats=
);=0A+=09if (fmt =3D=3D NULL)=0A+=09=09return -EINVAL;=0A+=0A+=09if (idx >=
=3D fmt->num_sizes)=0A+=09=09return -EINVAL;=0A+=0A+=09/* If the index is 0=
 - it is the first call of ENUM_FRAMESIZES, that=0A+=09 * defines a type of=
 all the frame sizes.=0A+=09 *=0A+=09 * Indexes > 0 can be used later only =
in case of the type is discrete.=0A+=09 * But, if there is at least one non=
-discrete type later in the array -=0A+=09 * it may be misinterpreted as a =
discrete one.=0A+=09 *=0A+=09 * Hence, check, whether there is a non-discre=
te frame size, and if yes=0A+=09 * - return the first of them.=0A+=09 */=0A=
+=09if (!idx)=0A+=09=09for (i =3D 0; i < fmt->num_sizes; i++) {=0A+=09=09=
=09frame_size =3D &fmt->frame_sizes[i];=0A+=09=09=09if (frame_size->min_wid=
th !=3D frame_size->max_width ||=0A+=09=09=09    frame_size->min_height !=
=3D frame_size->max_height) {=0A+=09=09=09=09idx =3D i;=0A+=09=09=09=09fake=
_non_discrete =3D true;=0A+=09=09=09=09break;=0A+=09=09=09}=0A+=09=09}=0A+=
=0A+=09/* Index > 0 can be used only for discrete frame sizes. Type of the=
=0A+=09 * frame sizes is equal to type of the first frame size.=0A+=09 */=
=0A+=09if (idx && !fake_non_discrete) {=0A+=09=09frame_size =3D &fmt->frame=
_sizes[0];=0A+=09=09if (frame_size->min_width !=3D frame_size->max_width ||=
=0A+=09=09    frame_size->min_height !=3D frame_size->max_height)=0A+=09=09=
=09return -EINVAL;=0A+=09}=0A+=0A+=09frame_size =3D &fmt->frame_sizes[idx];=
=0A+=0A+=09if (frame_size->min_width =3D=3D frame_size->max_width &&=0A+=09=
   frame_size->min_height =3D=3D frame_size->max_height) {=0A+=09=09f->type=
 =3D V4L2_FRMSIZE_TYPE_DISCRETE;=0A+=09=09f->discrete.width =3D frame_size-=
>min_width;=0A+=09=09f->discrete.height =3D frame_size->min_height;=0A+=09}=
 else {=0A+=09=09if (idx && !fake_non_discrete)=0A+=09=09=09return -EINVAL;=
=0A+=09=09f->stepwise.min_width =3D frame_size->min_width;=0A+=09=09f->step=
wise.min_height =3D frame_size->min_height;=0A+=09=09f->stepwise.step_heigh=
t =3D frame_size->step_height;=0A+=09=09f->stepwise.step_width =3D frame_si=
ze->step_width;=0A+=09=09f->stepwise.max_height =3D frame_size->max_height;=
=0A+=09=09f->stepwise.max_width =3D frame_size->max_width;=0A+=09=09if (fra=
me_size->step_width =3D=3D 1 &&=0A+=09=09    frame_size->min_height =3D=3D =
1) {=0A+=09=09=09f->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;=0A+=09=09} else =
{=0A+=09=09=09f->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;=0A+=09=09}=0A+=09}=0A=
+=0A+=09return 0;=0A+}=0A+=0A+static bool in_stepped_interval(uint32_t int_=
start, uint32_t int_end,=0A+=09=09=09=09uint32_t step, uint32_t point)=0A+{=
=0A+=09if (point < int_start || point > int_end)=0A+=09=09return false;=0A+=
=0A+=09if (step =3D=3D 0 && int_start =3D=3D int_end && int_start =3D=3D po=
int)=0A+=09=09return true;=0A+=0A+=09if (step !=3D 0 && (point - int_start)=
 % step =3D=3D 0)=0A+=09=09return true;=0A+=0A+=09return false;=0A+}=0A+=0A=
+static int virtio_video_enum_framemintervals(struct file *file, void *fh,=
=0A+=09=09=09=09=09     struct v4l2_frmivalenum *f)=0A+{=0A+=09struct virti=
o_video_stream *stream =3D file2stream(file);=0A+=09struct virtio_video_dev=
ice *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09struct video_frame_size=
 *fsize =3D NULL;=0A+=09int fsize_idx =3D 0;=0A+=09int i =3D 0;=0A+=09bool =
fake_non_discrete =3D false;=0A+=09int idx =3D f->index;=0A+=09struct video=
_pix_format *fmt =3D NULL;=0A+=09struct video_frame_rate *frate =3D NULL;=
=0A+=0A+=09fmt =3D find_pix_format(vvd->output_fmts, f->pixel_format,=0A+=
=09=09=09      vvd->num_output_formats);=0A+=09if (fmt =3D=3D NULL)=0A+=09=
=09fmt =3D find_pix_format(vvd->capture_fmts, f->pixel_format,=0A+=09=09=09=
=09      vvd->num_capture_formats);=0A+=09if (fmt =3D=3D NULL)=0A+=09=09ret=
urn -EINVAL;=0A+=0A+=09for (fsize_idx =3D 0; fsize_idx <=3D fmt->num_sizes;=
 fsize_idx++) {=0A+=09=09fsize =3D &fmt->frame_sizes[fsize_idx];=0A+=09=09i=
f (in_stepped_interval(fsize->min_width, fsize->max_width,=0A+=09=09=09=09=
=09fsize->step_width, f->width) &&=0A+=09=09   in_stepped_interval(fsize->m=
in_height, fsize->max_height,=0A+=09=09=09=09=09fsize->step_height, f->heig=
ht))=0A+=09=09=09break;=0A+=09}=0A+=0A+=09if (fsize =3D=3D NULL)=0A+=09=09r=
eturn -EINVAL;=0A+=0A+=09if (idx >=3D fsize->num_rates)=0A+=09=09return -EI=
NVAL;=0A+=0A+=09/* If the index is 0 - it is the first call of ENUM_FRAMEIV=
ALS, that=0A+=09 * defines a type of all the frame intervals.=0A+=09 *=0A+=
=09 * Indexes > 0 can be used later only in case of the type is discrete.=
=0A+=09 * But, if there is at least one non-discrete type later in the arra=
y -=0A+=09 * it may be misinterpreted as a discrete one.=0A+=09 *=0A+=09 * =
Hence, check, whether there is a non-discrete frame rate, and if yes=0A+=09=
 * - return the first of them.=0A+=09 */=0A+=09if (!idx)=0A+=09=09for (i =
=3D 0; i < fsize->num_rates; i++) {=0A+=09=09=09frate =3D &fsize->frame_rat=
es[i];=0A+=09=09=09if (frate->min_rate !=3D frate->max_rate) {=0A+=09=09=09=
=09fake_non_discrete =3D true;=0A+=09=09=09=09idx =3D i;=0A+=09=09=09=09bre=
ak;=0A+=09=09=09}=0A+=09=09}=0A+=0A+=09/* Index > 0 can be used only for di=
screte frame rates. Type of the=0A+=09 * frame rate is equal to the type of=
 the first frame size.=0A+=09 */=0A+=09if (idx && !fake_non_discrete) {=0A+=
=09=09frate =3D &fsize->frame_rates[0];=0A+=09=09if (frate->max_rate !=3D f=
rate->min_rate)=0A+=09=09=09return -EINVAL;=0A+=09}=0A+=0A+=09frate =3D &fs=
ize->frame_rates[idx];=0A+=09if (frate->max_rate =3D=3D frate->min_rate) {=
=0A+=09=09f->type =3D V4L2_FRMIVAL_TYPE_DISCRETE;=0A+=09=09f->discrete.nume=
rator =3D 1;=0A+=09=09f->discrete.denominator =3D frate->max_rate;=0A+=09} =
else {=0A+=09=09if (idx && !fake_non_discrete)=0A+=09=09=09return -EINVAL;=
=0A+=09=09/* If A > B, then 1/A < 1/B, so max denominator =3D min_rate=0A+=
=09=09 * and vise versa=0A+=09=09 */=0A+=09=09f->stepwise.min.numerator =3D=
 1;=0A+=09=09f->stepwise.min.denominator =3D frate->max_rate;=0A+=09=09f->s=
tepwise.max.numerator =3D 1;=0A+=09=09f->stepwise.max.denominator =3D frate=
->min_rate;=0A+=09=09f->stepwise.step.numerator =3D 1;=0A+=09=09f->stepwise=
.step.denominator =3D frate->step;=0A+=09=09if (frate->step =3D=3D 1)=0A+=
=09=09=09f->type =3D V4L2_FRMIVAL_TYPE_CONTINUOUS;=0A+=09=09else=0A+=09=09=
=09f->type =3D V4L2_FRMIVAL_TYPE_STEPWISE;=0A+=09}=0A+=0A+=09return 0;=0A+}=
=0A+=0A+static int virtio_video_enum_fmt_vid_out(struct file *file, void *f=
h,=0A+=09=09=09=09=09 struct v4l2_fmtdesc *f)=0A+{=0A+=09struct virtio_vide=
o_stream *stream =3D file2stream(file);=0A+=09struct virtio_video_device *v=
vd =3D to_virtio_vd(stream->video_dev);=0A+=0A+=09if (f->type !=3D V4L2_BUF=
_TYPE_VIDEO_OUTPUT_MPLANE)=0A+=09=09return -EINVAL;=0A+=0A+=09if (f->index =
>=3D vvd->num_output_formats)=0A+=09=09return -EINVAL;=0A+=0A+=09f->pixelfo=
rmat =3D vvd->output_fmts[f->index]->fourcc_format;=0A+=0A+=09return 0;=0A+=
}=0A+=0A+static void fill_v4l2_format_from_info(struct video_format_info *i=
nfo,=0A+=09=09=09=09       struct v4l2_pix_format_mplane *pix_mp)=0A+{=0A+=
=09int i;=0A+=0A+=09pix_mp->width =3D info->frame_width;=0A+=09pix_mp->heig=
ht =3D info->frame_height;=0A+=09pix_mp->field =3D V4L2_FIELD_NONE;=0A+=09p=
ix_mp->colorspace =3D V4L2_COLORSPACE_REC709;=0A+=09pix_mp->xfer_func =3D 0=
;=0A+=09pix_mp->ycbcr_enc =3D 0;=0A+=09pix_mp->quantization =3D 0;=0A+=09me=
mset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));=0A+=09memset(pix_mp->p=
lane_fmt[0].reserved, 0,=0A+=09       sizeof(pix_mp->plane_fmt[0].reserved)=
);=0A+=0A+=09pix_mp->num_planes =3D info->num_planes;=0A+=09pix_mp->pixelfo=
rmat =3D info->fourcc_format;=0A+=0A+=09for (i =3D 0; i < info->num_planes;=
 i++) {=0A+=09=09pix_mp->plane_fmt[i].bytesperline =3D=0A+=09=09=09=09=09 i=
nfo->plane_format[i].stride;=0A+=09=09pix_mp->plane_fmt[i].sizeimage =3D=0A=
+=09=09=09=09=09 info->plane_format[i].plane_size;=0A+=09}=0A+}=0A+=0A+stat=
ic int virtio_video_g_fmt(struct virtio_video_stream *stream,=0A+=09=09=09 =
     struct v4l2_format *f)=0A+{=0A+=09struct v4l2_pix_format_mplane *pix_m=
p =3D &f->fmt.pix_mp;=0A+=09struct video_format_info *info;=0A+=0A+=09if (!=
V4L2_TYPE_IS_OUTPUT(f->type))=0A+=09=09info =3D &stream->out_info;=0A+=09el=
se=0A+=09=09info =3D &stream->in_info;=0A+=0A+=09fill_v4l2_format_from_info=
(info, pix_mp);=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_g_fmt_v=
id_out(struct file *file, void *fh,=0A+=09=09=09=09      struct v4l2_format=
 *f)=0A+{=0A+=09return virtio_video_g_fmt(file2stream(file), f);=0A+}=0A+=
=0A+static int virtio_video_g_fmt_vid_cap(struct file *file, void *fh,=0A+=
=09=09=09=09      struct v4l2_format *f)=0A+{=0A+=09return virtio_video_g_f=
mt(file2stream(file), f);=0A+}=0A+=0A+static inline bool within_range(uint3=
2_t min, uint32_t val, uint32_t max)=0A+{=0A+=09return ((val - min) <=3D (m=
ax - min));=0A+}=0A+=0A+static inline bool needs_alignment(uint32_t val, ui=
nt32_t a)=0A+{=0A+=09if (a =3D=3D 0 || IS_ALIGNED(val, a))=0A+=09=09return =
false;=0A+=0A+=09return true;=0A+}=0A+=0A+static int virtio_video_try_fmt(s=
truct virtio_video_stream *stream,=0A+=09=09=09=09struct v4l2_format *f)=0A=
+{=0A+=09int i, idx =3D 0;=0A+=09struct v4l2_pix_format_mplane *pix_mp =3D =
&f->fmt.pix_mp;=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stre=
am->video_dev);=0A+=09struct video_pix_format *fmt =3D NULL;=0A+=09struct v=
ideo_frame_size *frm_sz =3D NULL;=0A+=09bool found =3D false;=0A+=0A+=09if =
(V4L2_TYPE_IS_OUTPUT(f->type))=0A+=09=09fmt =3D find_pix_format(vvd->output=
_fmts, pix_mp->pixelformat,=0A+=09=09=09=09=09 vvd->num_output_formats);=0A=
+=09else=0A+=09=09fmt =3D find_pix_format(vvd->capture_fmts, pix_mp->pixelf=
ormat,=0A+=09=09=09=09=09 vvd->num_capture_formats);=0A+=0A+=09if (!fmt) {=
=0A+=09=09if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)=0A+=09=09=
=09fill_v4l2_format_from_info(&stream->out_info, pix_mp);=0A+=09=09else if =
(f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)=0A+=09=09=09fill_v4l2_fo=
rmat_from_info(&stream->in_info, pix_mp);=0A+=09=09else=0A+=09=09=09return =
-EINVAL;=0A+=09=09return 0;=0A+=09}=0A+=0A+=09for (i =3D 0; i < fmt->num_si=
zes && !found; i++) {=0A+=09=09frm_sz =3D &fmt->frame_sizes[i];=0A+=09=09if=
 (!within_range(frm_sz->min_width, pix_mp->width,=0A+=09=09=09=09 frm_sz->m=
ax_width))=0A+=09=09=09continue;=0A+=0A+=09=09if (!within_range(frm_sz->min=
_height, pix_mp->height,=0A+=09=09=09=09  frm_sz->max_height))=0A+=09=09=09=
continue;=0A+=0A+=09=09idx =3D i;=0A+=09=09/*=0A+=09=09 * Try to find a mor=
e suitable frame size. Go with the current=0A+=09=09 * one otherwise.=0A+=
=09=09 */=0A+=09=09if (needs_alignment(pix_mp->width, frm_sz->step_width))=
=0A+=09=09=09continue;=0A+=0A+=09=09if (needs_alignment(pix_mp->height, frm=
_sz->step_height))=0A+=09=09=09continue;=0A+=0A+=09=09stream->current_frame=
_size =3D frm_sz;=0A+=09=09found =3D true;=0A+=09}=0A+=0A+=09if (!found) {=
=0A+=09=09frm_sz =3D &fmt->frame_sizes[idx];=0A+=09=09pix_mp->width =3D cla=
mp(pix_mp->width, frm_sz->min_width,=0A+=09=09=09=09      frm_sz->max_width=
);=0A+=09=09if (frm_sz->step_width !=3D 0)=0A+=09=09=09pix_mp->width =3D AL=
IGN(pix_mp->width,=0A+=09=09=09=09=09      frm_sz->step_width);=0A+=0A+=09=
=09pix_mp->height =3D clamp(pix_mp->height, frm_sz->min_height,=0A+=09=09=
=09=09      frm_sz->max_height);=0A+=09=09if (frm_sz->step_height !=3D 0)=
=0A+=09=09=09pix_mp->height =3D ALIGN(pix_mp->height,=0A+=09=09=09=09      =
 frm_sz->step_height);=0A+=09=09stream->current_frame_size =3D frm_sz;=0A+=
=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_s_fmt(struct v=
irtio_video_stream *stream,=0A+=09=09=09      struct v4l2_format *f)=0A+{=
=0A+=09int i, ret;=0A+=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.=
pix_mp;=0A+=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->vide=
o_dev);=0A+=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct video_forma=
t_info info;=0A+=09struct video_format_info *p_info;=0A+=09enum video_pin_t=
ype pin =3D VIDEO_PIN_TYPE_INPUT;=0A+=0A+=09ret =3D virtio_video_try_fmt(st=
ream, f);=0A+=09if (ret)=0A+=09=09return ret;=0A+=0A+=09if (V4L2_TYPE_IS_OU=
TPUT(f->type)) {=0A+=09=09info.frame_rate =3D stream->in_info.frame_rate;=
=0A+=09} else {=0A+=09=09info.frame_rate =3D stream->out_info.frame_rate;=
=0A+=09=09pin =3D VIDEO_PIN_TYPE_OUTPUT;=0A+=09}=0A+=0A+=09info.frame_width=
 =3D pix_mp->width;=0A+=09info.frame_height =3D pix_mp->height;=0A+=09info.=
num_planes =3D pix_mp->num_planes;=0A+=09info.fourcc_format =3D pix_mp->pix=
elformat;=0A+=0A+=09for (i =3D 0; i < info.num_planes; i++) {=0A+=09=09info=
.plane_format[i].stride =3D=0A+=09=09=09=09=09 pix_mp->plane_fmt[i].bytespe=
rline;=0A+=09=09info.plane_format[i].plane_size =3D=0A+=09=09=09=09=09 pix_=
mp->plane_fmt[i].sizeimage;=0A+=09}=0A+=0A+=09virtio_video_req_set_params(v=
v, vvd->id, &info, pin,=0A+=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM, strea=
m);=0A+=09virtio_video_req_get_params(vv, vvd->id, VIDEO_PIN_TYPE_INPUT,=0A=
+=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM, stream);=0A+=09virtio_video_req=
_get_params(vv, vvd->id, VIDEO_PIN_TYPE_OUTPUT,=0A+=09=09=09=09    VIDEO_PA=
RAMS_SCOPE_STREAM, stream);=0A+=0A+=09if (V4L2_TYPE_IS_OUTPUT(f->type))=0A+=
=09=09p_info =3D &stream->in_info;=0A+=09else=0A+=09=09p_info =3D &stream->=
out_info;=0A+=0A+=09fill_v4l2_format_from_info(p_info, pix_mp);=0A+=0A+=09i=
f (!V4L2_TYPE_IS_OUTPUT(f->type)) {=0A+=09=09if (stream->state =3D=3D STREA=
M_STATE_IDLE)=0A+=09=09=09stream->state =3D STREAM_STATE_INIT;=0A+=09}=0A+=
=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_s_fmt_vid_cap(struct f=
ile *file, void *fh,=0A+=09=09=09=09      struct v4l2_format *f)=0A+{=0A+=
=09struct virtio_video_stream *stream =3D file2stream(file);=0A+=0A+=09retu=
rn virtio_video_s_fmt(stream, f);=0A+}=0A+=0A+static int virtio_video_s_fmt=
_vid_out(struct file *file, void *fh,=0A+=09=09=09=09      struct v4l2_form=
at *f)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2stream(file);=
=0A+=0A+=09return virtio_video_s_fmt(stream, f);=0A+}=0A+=0A+static int vir=
tio_video_try_framerate(struct virtio_video_stream *stream,=0A+=09=09=09=09=
     unsigned int fps)=0A+{=0A+=09int rate_idx;=0A+=09struct video_frame_si=
ze *frame_size =3D NULL;=0A+=0A+=09if (stream->current_frame_size =3D=3D NU=
LL)=0A+=09=09return -EINVAL;=0A+=0A+=09frame_size =3D stream->current_frame=
_size;=0A+=09for (rate_idx =3D 0; rate_idx < frame_size->num_rates; rate_id=
x++) {=0A+=09=09struct video_frame_rate *frame_rate =3D=0A+=09=09=09&frame_=
size->frame_rates[rate_idx];=0A+=0A+=09=09if (within_range(frame_rate->min_=
rate,=0A+=09=09=09=09 fps, frame_rate->max_rate))=0A+=09=09=09return 0;=0A+=
=09}=0A+=09return -EINVAL;=0A+}=0A+=0A+static void fill_timeperframe_from_i=
nfo(struct video_format_info *info,=0A+=09=09=09=09=09struct v4l2_fract *ti=
meperframe)=0A+{=0A+=09timeperframe->numerator =3D info->frame_rate;=0A+=09=
timeperframe->denominator =3D 1;=0A+}=0A+=0A+static int virtio_video_g_parm=
(struct file *file, void *priv,=0A+=09=09=09       struct v4l2_streamparm *=
a)=0A+{=0A+=09struct virtio_video_stream *stream =3D file2stream(file);=0A+=
=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=
=09struct virtio_video *vv =3D vvd->vv;=0A+=09struct v4l2_outputparm *out =
=3D &a->parm.output;=0A+=09struct v4l2_fract *timeperframe =3D &out->timepe=
rframe;=0A+=0A+=09if (!V4L2_TYPE_IS_OUTPUT(a->type)) {=0A+=09=09v4l2_err(&v=
v->v4l2_dev,=0A+=09=09=09 "Getting FPS is only possible for the output queu=
e\n");=0A+=09=09return -EINVAL;=0A+=09}=0A+=0A+=09out->capability =3D V4L2_=
CAP_TIMEPERFRAME;=0A+=09fill_timeperframe_from_info(&stream->in_info, timep=
erframe);=0A+=09return 0;=0A+}=0A+=0A+static int virtio_video_s_parm(struct=
 file *file, void *priv,=0A+=09=09=09       struct v4l2_streamparm *a)=0A+{=
=0A+=09struct virtio_video_stream *stream =3D file2stream(file);=0A+=09stru=
ct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev);=0A+=09stru=
ct virtio_video *vv =3D vvd->vv;=0A+=09struct v4l2_outputparm *out =3D &a->=
parm.output;=0A+=09struct v4l2_fract *timeperframe =3D &out->timeperframe;=
=0A+=09struct video_format_info info, *p_info;=0A+=09int i, ret;=0A+=09u64 =
frame_interval, frame_rate;=0A+=0A+=09if (V4L2_TYPE_IS_OUTPUT(a->type)) {=
=0A+=09=09frame_interval =3D timeperframe->numerator * (u64)USEC_PER_SEC;=
=0A+=09=09do_div(frame_interval, timeperframe->denominator);=0A+=09=09if (!=
frame_interval)=0A+=09=09=09return -EINVAL;=0A+=0A+=09=09frame_rate =3D (u6=
4)USEC_PER_SEC;=0A+=09=09do_div(frame_rate, frame_interval);=0A+=09} else {=
=0A+=09=09v4l2_err(&vv->v4l2_dev,=0A+=09=09=09 "Setting FPS is only possibl=
e for the output queue\n");=0A+=09=09return -EINVAL;=0A+=09}=0A+=0A+=09ret =
=3D virtio_video_try_framerate(stream, frame_rate);=0A+=09if (ret)=0A+=09=
=09return ret;=0A+=0A+=09p_info =3D &stream->in_info;=0A+=09info.frame_rate=
 =3D frame_rate;=0A+=09info.frame_width =3D p_info->frame_width;=0A+=09info=
.frame_height =3D p_info->frame_height;=0A+=09info.num_planes =3D p_info->n=
um_planes;=0A+=09info.fourcc_format =3D p_info->fourcc_format;=0A+=0A+=09fo=
r (i =3D 0; i < info.num_planes; i++) {=0A+=09=09info.plane_format[i].strid=
e =3D=0A+=09=09=09p_info->plane_format[i].stride;=0A+=09=09info.plane_forma=
t[i].plane_size =3D=0A+=09=09=09p_info->plane_format[i].plane_size;=0A+=09}=
=0A+=0A+=09virtio_video_req_set_params(vv, vvd->id, &info, VIDEO_PIN_TYPE_I=
NPUT,=0A+=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM, stream);=0A+=09virtio_v=
ideo_req_get_params(vv, vvd->id, VIDEO_PIN_TYPE_INPUT,=0A+=09=09=09=09    V=
IDEO_PARAMS_SCOPE_STREAM, stream);=0A+=09virtio_video_req_get_params(vv, vv=
d->id, VIDEO_PIN_TYPE_OUTPUT,=0A+=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM,=
 stream);=0A+=0A+=09out->capability =3D V4L2_CAP_TIMEPERFRAME;=0A+=09fill_t=
imeperframe_from_info(&stream->in_info, timeperframe);=0A+=09return 0;=0A+}=
=0A+=0A+static int=0A+virtio_video_subscribe_event(struct v4l2_fh *fh,=0A+=
=09=09=09     const struct v4l2_event_subscription *sub)=0A+{=0A+=09switch =
(sub->type) {=0A+=09case V4L2_EVENT_SOURCE_CHANGE:=0A+=09=09return v4l2_src=
_change_event_subscribe(fh, sub);=0A+=09default:=0A+=09=09return -EINVAL;=
=0A+=09}=0A+}=0A+=0A+static const struct v4l2_ioctl_ops virtio_video_device=
_enc_ioctl_ops =3D {=0A+=09.vidioc_querycap=09=3D virtio_video_querycap,=0A=
+=0A+=09.vidioc_enum_fmt_vid_cap =3D virtio_video_enum_fmt_vid_cap,=0A+=09.=
vidioc_g_fmt_vid_cap=09=3D virtio_video_g_fmt_vid_cap,=0A+=09.vidioc_s_fmt_=
vid_cap=09=3D virtio_video_s_fmt_vid_cap,=0A+=0A+=09.vidioc_g_fmt_vid_cap_m=
plane=09=3D virtio_video_g_fmt_vid_cap,=0A+=09.vidioc_s_fmt_vid_cap_mplane=
=09=3D virtio_video_s_fmt_vid_cap,=0A+=0A+=09.vidioc_enum_fmt_vid_out =3D v=
irtio_video_enum_fmt_vid_out,=0A+=09.vidioc_g_fmt_vid_out=09=3D virtio_vide=
o_g_fmt_vid_out,=0A+=09.vidioc_s_fmt_vid_out=09=3D virtio_video_s_fmt_vid_o=
ut,=0A+=0A+=09.vidioc_g_fmt_vid_out_mplane=09=3D virtio_video_g_fmt_vid_out=
,=0A+=09.vidioc_s_fmt_vid_out_mplane=09=3D virtio_video_s_fmt_vid_out,=0A+=
=0A+=09.vidioc_try_encoder_cmd=09=3D virtio_video_try_encoder_cmd,=0A+=09.v=
idioc_encoder_cmd=09=3D virtio_video_encoder_cmd,=0A+=09.vidioc_enum_framei=
ntervals =3D virtio_video_enum_framemintervals,=0A+=09.vidioc_enum_framesiz=
es =3D virtio_video_enum_framesizes,=0A+=0A+=09.vidioc_reqbufs=09=09=3D v4l=
2_m2m_ioctl_reqbufs,=0A+=09.vidioc_querybuf=09=3D v4l2_m2m_ioctl_querybuf,=
=0A+=09.vidioc_qbuf=09=09=3D v4l2_m2m_ioctl_qbuf,=0A+=09.vidioc_dqbuf=09=09=
=3D v4l2_m2m_ioctl_dqbuf,=0A+=09.vidioc_prepare_buf=09=3D v4l2_m2m_ioctl_pr=
epare_buf,=0A+=09.vidioc_create_bufs=09=3D v4l2_m2m_ioctl_create_bufs,=0A+=
=09.vidioc_expbuf=09=09=3D v4l2_m2m_ioctl_expbuf,=0A+=0A+=09.vidioc_streamo=
n=09=3D v4l2_m2m_ioctl_streamon,=0A+=09.vidioc_streamoff=09=3D v4l2_m2m_ioc=
tl_streamoff,=0A+=0A+=09.vidioc_s_parm=09=09=3D virtio_video_s_parm,=0A+=09=
.vidioc_g_parm=09=09=3D virtio_video_g_parm,=0A+=0A+=09.vidioc_subscribe_ev=
ent =3D virtio_video_subscribe_event,=0A+=09.vidioc_unsubscribe_event =3D v=
4l2_event_unsubscribe,=0A+};=0A+=0A+int virtio_video_enc_init(struct virtio=
_video_device *vvd)=0A+{=0A+=09struct video_device *vd =3D NULL;=0A+=0A+=09=
if (!vvd)=0A+=09=09return -EINVAL;=0A+=0A+=09vd =3D &vvd->video_dev;=0A+=09=
vd->ioctl_ops =3D &virtio_video_device_enc_ioctl_ops;=0A+=09return 0;=0A+}=
=0Adiff --git a/drivers/media/virtio/virtio_video_enc.h b/drivers/media/vir=
tio/virtio_video_enc.h=0Anew file mode 100644=0Aindex 000000000000..28fb385=
f40a7=0A--- /dev/null=0A+++ b/drivers/media/virtio/virtio_video_enc.h=0A@@ =
-0,0 +1,30 @@=0A+/* SPDX-License-Identifier: GPL-2.0+ */=0A+/* Encoder head=
er for virtio video driver.=0A+ *=0A+ * Copyright 2019 OpenSynergy GmbH.=0A=
+ *=0A+ * This program is free software; you can redistribute it and/or mod=
ify=0A+ * it under the terms of the GNU General Public License as published=
 by=0A+ * the Free Software Foundation; either version 2 of the License, or=
=0A+ * (at your option) any later version.=0A+ *=0A+ * This program is dist=
ributed in the hope that it will be useful,=0A+ * but WITHOUT ANY WARRANTY;=
 without even the implied warranty of=0A+ * MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE.  See the=0A+ * GNU General Public License for more de=
tails.=0A+ *=0A+ * You should have received a copy of the GNU General Publi=
c License=0A+ * along with this program; if not, see <http://www.gnu.org/li=
censes/>.=0A+ */=0A+=0A+#ifndef _VIRTIO_VIDEO_ENC_H=0A+#define _VIRTIO_VIDE=
O_ENC_H=0A+=0A+#include "virtio_video.h"=0A+=0A+int virtio_video_enc_init(s=
truct virtio_video_device *vvd);=0A+int virtio_video_init_enc_ctrls(struct =
virtio_video_stream *stream);=0A+int virtio_video_init_enc_queues(void *pri=
v, struct vb2_queue *src_vq,=0A+=09=09=09=09 struct vb2_queue *dst_vq);=0A+=
=0A+#endif /* _VIRTIO_VIDEO_ENC_H */=0Adiff --git a/drivers/media/virtio/vi=
rtio_video_vq.c b/drivers/media/virtio/virtio_video_vq.c=0Anew file mode 10=
0644=0Aindex 000000000000..4ad72332112f=0A--- /dev/null=0A+++ b/drivers/med=
ia/virtio/virtio_video_vq.c=0A@@ -0,0 +1,950 @@=0A+// SPDX-License-Identifi=
er: GPL-2.0+=0A+/* Driver for virtio video device.=0A+ *=0A+ * Copyright 20=
19 OpenSynergy GmbH.=0A+ *=0A+ * Based on drivers/gpu/drm/virtio/virtgpu_vq=
.c=0A+ * Copyright (C) 2015 Red Hat, Inc.=0A+ *=0A+ * This program is free =
software; you can redistribute it and/or modify=0A+ * it under the terms of=
 the GNU General Public License as published by=0A+ * the Free Software Fou=
ndation; either version 2 of the License, or=0A+ * (at your option) any lat=
er version.=0A+ *=0A+ * This program is distributed in the hope that it wil=
l be useful,=0A+ * but WITHOUT ANY WARRANTY; without even the implied warra=
nty of=0A+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=
=0A+ * GNU General Public License for more details.=0A+ *=0A+ * You should =
have received a copy of the GNU General Public License=0A+ * along with thi=
s program; if not, see <http://www.gnu.org/licenses/>.=0A+ */=0A+=0A+#inclu=
de "virtio_video.h"=0A+=0A+#define MAX_INLINE_CMD_SIZE   298=0A+#define MAX=
_INLINE_RESP_SIZE  298=0A+#define VBUFFER_SIZE          (sizeof(struct virt=
io_video_vbuffer) \=0A+=09=09=09       + MAX_INLINE_CMD_SIZE=09=09   \=0A+=
=09=09=09       + MAX_INLINE_RESP_SIZE)=0A+=0A+void virtio_video_resource_i=
d_get(struct virtio_video *vv, uint32_t *id)=0A+{=0A+=09int handle;=0A+=0A+=
=09idr_preload(GFP_KERNEL);=0A+=09spin_lock(&vv->resource_idr_lock);=0A+=09=
handle =3D idr_alloc(&vv->resource_idr, NULL, 1, 0, GFP_NOWAIT);=0A+=09spin=
_unlock(&vv->resource_idr_lock);=0A+=09idr_preload_end();=0A+=09*id =3D han=
dle;=0A+}=0A+=0A+void virtio_video_resource_id_put(struct virtio_video *vv,=
 uint32_t id)=0A+{=0A+=09spin_lock(&vv->resource_idr_lock);=0A+=09idr_remov=
e(&vv->resource_idr, id);=0A+=09spin_unlock(&vv->resource_idr_lock);=0A+}=
=0A+=0A+void virtio_video_stream_id_get(struct virtio_video *vv,=0A+=09=09=
=09=09struct virtio_video_stream *stream,=0A+=09=09=09=09uint32_t *id)=0A+{=
=0A+=09int handle;=0A+=0A+=09idr_preload(GFP_KERNEL);=0A+=09spin_lock(&vv->=
stream_idr_lock);=0A+=09handle =3D idr_alloc(&vv->stream_idr, stream, 1, 0,=
 0);=0A+=09spin_unlock(&vv->stream_idr_lock);=0A+=09idr_preload_end();=0A+=
=09*id =3D handle;=0A+}=0A+=0A+void virtio_video_stream_id_put(struct virti=
o_video *vv, uint32_t id)=0A+{=0A+=09spin_lock(&vv->stream_idr_lock);=0A+=
=09idr_remove(&vv->stream_idr, id);=0A+=09spin_unlock(&vv->stream_idr_lock)=
;=0A+}=0A+=0A+void virtio_video_ctrl_ack(struct virtqueue *vq)=0A+{=0A+=09s=
truct virtio_video *vv =3D vq->vdev->priv;=0A+=0A+=09schedule_work(&vv->ctr=
lq.dequeue_work);=0A+}=0A+=0A+void virtio_video_event_ack(struct virtqueue =
*vq)=0A+{=0A+=09struct virtio_video *vv =3D vq->vdev->priv;=0A+=0A+=09sched=
ule_work(&vv->eventq.dequeue_work);=0A+}=0A+=0A+static struct virtio_video_=
vbuffer *=0A+virtio_video_get_vbuf(struct virtio_video *vv, int size,=0A+=
=09=09      int resp_size, void *resp_buf,=0A+=09=09      virtio_video_resp=
_cb resp_cb)=0A+{=0A+=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09vbuf =
=3D kmem_cache_alloc(vv->vbufs, GFP_KERNEL);=0A+=09if (!vbuf)=0A+=09=09retu=
rn ERR_PTR(-ENOMEM);=0A+=09memset(vbuf, 0, VBUFFER_SIZE);=0A+=0A+=09BUG_ON(=
size > MAX_INLINE_CMD_SIZE);=0A+=09vbuf->buf =3D (void *)vbuf + sizeof(*vbu=
f);=0A+=09vbuf->size =3D size;=0A+=0A+=09vbuf->resp_cb =3D resp_cb;=0A+=09v=
buf->resp_size =3D resp_size;=0A+=09if (resp_size <=3D MAX_INLINE_RESP_SIZE=
 && !resp_buf)=0A+=09=09vbuf->resp_buf =3D (void *)vbuf->buf + size;=0A+=09=
else=0A+=09=09vbuf->resp_buf =3D resp_buf;=0A+=09BUG_ON(!vbuf->resp_buf);=
=0A+=0A+=09return vbuf;=0A+}=0A+=0A+static void free_vbuf(struct virtio_vid=
eo *vv,=0A+=09=09      struct virtio_video_vbuffer *vbuf)=0A+{=0A+=09if (!v=
buf->resp_cb &&=0A+=09    vbuf->resp_size > MAX_INLINE_RESP_SIZE)=0A+=09=09=
kfree(vbuf->resp_buf);=0A+=09kfree(vbuf->data_buf);=0A+=09kmem_cache_free(v=
v->vbufs, vbuf);=0A+}=0A+=0A+static void reclaim_vbufs(struct virtqueue *vq=
, struct list_head *reclaim_list)=0A+{=0A+=09struct virtio_video_vbuffer *v=
buf;=0A+=09unsigned int len;=0A+=09struct virtio_video *vv =3D vq->vdev->pr=
iv;=0A+=09int freed =3D 0;=0A+=0A+=09while ((vbuf =3D virtqueue_get_buf(vq,=
 &len))) {=0A+=09=09list_add_tail(&vbuf->list, reclaim_list);=0A+=09=09free=
d++;=0A+=09}=0A+=0A+=09if (freed =3D=3D 0)=0A+=09=09v4l2_dbg(1, vv->debug, =
&vv->v4l2_dev,=0A+=09=09=09 "zero vbufs reclaimed\n");=0A+}=0A+=0A+static v=
oid detach_vbufs(struct virtqueue *vq, struct list_head *detach_list)=0A+{=
=0A+=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09while ((vbuf =3D virtqu=
eue_detach_unused_buf(vq)) !=3D NULL)=0A+=09=09list_add_tail(&vbuf->list, d=
etach_list);=0A+}=0A+=0A+static void virtio_video_deatch_vbufs(struct virti=
o_video *vv)=0A+{=0A+=09struct list_head detach_list;=0A+=09struct virtio_v=
ideo_vbuffer *entry, *tmp;=0A+=0A+=09INIT_LIST_HEAD(&detach_list);=0A+=0A+=
=09detach_vbufs(vv->eventq.vq, &detach_list);=0A+=09detach_vbufs(vv->ctrlq.=
vq, &detach_list);=0A+=0A+=09if (list_empty(&detach_list))=0A+=09=09return;=
=0A+=0A+=09list_for_each_entry_safe(entry, tmp, &detach_list, list) {=0A+=
=09=09list_del(&entry->list);=0A+=09=09free_vbuf(vv, entry);=0A+=09}=0A+}=
=0A+=0A+int virtio_video_alloc_vbufs(struct virtio_video *vv)=0A+{=0A+=09vv=
->vbufs =3D=0A+=09=09kmem_cache_create("virtio-video-vbufs", VBUFFER_SIZE,=
=0A+=09=09=09=09  __alignof__(struct virtio_video_vbuffer), 0,=0A+=09=09=09=
=09  NULL);=0A+=09if (!vv->vbufs)=0A+=09=09return -ENOMEM;=0A+=0A+=09return=
 0;=0A+}=0A+=0A+void virtio_video_free_vbufs(struct virtio_video *vv)=0A+{=
=0A+=09virtio_video_deatch_vbufs(vv);=0A+=09kmem_cache_destroy(vv->vbufs);=
=0A+=09vv->vbufs =3D NULL;=0A+}=0A+=0A+static void *virtio_video_alloc_req(=
struct virtio_video *vv,=0A+=09=09=09=09    struct virtio_video_vbuffer **v=
buffer_p,=0A+=09=09=09=09    int size)=0A+{=0A+=09struct virtio_video_vbuff=
er *vbuf;=0A+=0A+=09vbuf =3D virtio_video_get_vbuf(vv, size,=0A+=09=09=09=
=09     sizeof(struct virtio_video_ctrl_hdr),=0A+=09=09=09=09     NULL, NUL=
L);=0A+=09if (IS_ERR(vbuf)) {=0A+=09=09*vbuffer_p =3D NULL;=0A+=09=09return=
 ERR_CAST(vbuf);=0A+=09}=0A+=09*vbuffer_p =3D vbuf;=0A+=0A+=09return vbuf->=
buf;=0A+}=0A+=0A+static void *=0A+virtio_video_alloc_req_resp(struct virtio=
_video *vv,=0A+=09=09=09    virtio_video_resp_cb cb,=0A+=09=09=09    struct=
 virtio_video_vbuffer **vbuffer_p,=0A+=09=09=09    int req_size, int resp_s=
ize,=0A+=09=09=09    void *resp_buf)=0A+{=0A+=09struct virtio_video_vbuffer=
 *vbuf;=0A+=0A+=09vbuf =3D virtio_video_get_vbuf(vv, req_size, resp_size, r=
esp_buf, cb);=0A+=09if (IS_ERR(vbuf)) {=0A+=09=09*vbuffer_p =3D NULL;=0A+=
=09=09return ERR_CAST(vbuf);=0A+=09}=0A+=09*vbuffer_p =3D vbuf;=0A+=0A+=09r=
eturn vbuf->buf;=0A+}=0A+=0A+void virtio_video_dequeue_ctrl_func(struct wor=
k_struct *work)=0A+{=0A+=09struct virtio_video *vv =3D=0A+=09=09container_o=
f(work, struct virtio_video,=0A+=09=09=09     ctrlq.dequeue_work);=0A+=09st=
ruct list_head reclaim_list;=0A+=09struct virtio_video_vbuffer *entry, *tmp=
;=0A+=09struct virtio_video_ctrl_hdr *resp;=0A+=0A+=09INIT_LIST_HEAD(&recla=
im_list);=0A+=09spin_lock(&vv->ctrlq.qlock);=0A+=09do {=0A+=09=09virtqueue_=
disable_cb(vv->ctrlq.vq);=0A+=09=09reclaim_vbufs(vv->ctrlq.vq, &reclaim_lis=
t);=0A+=0A+=09} while (!virtqueue_enable_cb(vv->ctrlq.vq));=0A+=09spin_unlo=
ck(&vv->ctrlq.qlock);=0A+=0A+=09list_for_each_entry_safe(entry, tmp, &recla=
im_list, list) {=0A+=09=09resp =3D (struct virtio_video_ctrl_hdr *)entry->r=
esp_buf;=0A+=09=09if (resp->type >=3D cpu_to_le32(VIRTIO_VIDEO_S_ERR_UNSPEC=
))=0A+=09=09=09v4l2_dbg(1, vv->debug, &vv->v4l2_dev,=0A+=09=09=09=09 "respo=
nse 0x%x\n", le32_to_cpu(resp->type));=0A+=09=09if (entry->resp_cb)=0A+=09=
=09=09entry->resp_cb(vv, entry);=0A+=0A+=09=09list_del(&entry->list);=0A+=
=09=09free_vbuf(vv, entry);=0A+=09}=0A+=09wake_up(&vv->ctrlq.ack_queue);=0A=
+}=0A+=0A+void virtio_video_dequeue_event_func(struct work_struct *work)=0A=
+{=0A+=09struct virtio_video *vv =3D=0A+=09=09container_of(work, struct vir=
tio_video,=0A+=09=09=09     eventq.dequeue_work);=0A+=09struct list_head re=
claim_list;=0A+=09struct virtio_video_vbuffer *entry, *tmp;=0A+=0A+=09INIT_=
LIST_HEAD(&reclaim_list);=0A+=09spin_lock(&vv->eventq.qlock);=0A+=09do {=0A=
+=09=09virtqueue_disable_cb(vv->eventq.vq);=0A+=09=09reclaim_vbufs(vv->even=
tq.vq, &reclaim_list);=0A+=0A+=09} while (!virtqueue_enable_cb(vv->eventq.v=
q));=0A+=09spin_unlock(&vv->eventq.qlock);=0A+=0A+=09list_for_each_entry_sa=
fe(entry, tmp, &reclaim_list, list) {=0A+=09=09entry->resp_cb(vv, entry);=
=0A+=09=09list_del(&entry->list);=0A+=09}=0A+=09wake_up(&vv->eventq.ack_que=
ue);=0A+}=0A+=0A+static int=0A+virtio_video_queue_ctrl_buffer_locked(struct=
 virtio_video *vv,=0A+=09=09=09=09      struct virtio_video_vbuffer *vbuf)=
=0A+{=0A+=09struct virtqueue *vq =3D vv->ctrlq.vq;=0A+=09struct scatterlist=
 *sgs[3], vreq, vout, vresp;=0A+=09int outcnt =3D 0, incnt =3D 0;=0A+=09int=
 ret;=0A+=0A+=09if (!vv->vq_ready)=0A+=09=09return -ENODEV;=0A+=0A+=09sg_in=
it_one(&vreq, vbuf->buf, vbuf->size);=0A+=09sgs[outcnt + incnt] =3D &vreq;=
=0A+=09outcnt++;=0A+=0A+=09if (vbuf->data_size) {=0A+=09=09sg_init_one(&vou=
t, vbuf->data_buf, vbuf->data_size);=0A+=09=09sgs[outcnt + incnt] =3D &vout=
;=0A+=09=09outcnt++;=0A+=09}=0A+=0A+=09if (vbuf->resp_size) {=0A+=09=09sg_i=
nit_one(&vresp, vbuf->resp_buf, vbuf->resp_size);=0A+=09=09sgs[outcnt + inc=
nt] =3D &vresp;=0A+=09=09incnt++;=0A+=09}=0A+=0A+retry:=0A+=09ret =3D virtq=
ueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);=0A+=09if (ret =3D=
=3D -ENOSPC) {=0A+=09=09spin_unlock(&vv->ctrlq.qlock);=0A+=09=09wait_event(=
vv->ctrlq.ack_queue, vq->num_free);=0A+=09=09spin_lock(&vv->ctrlq.qlock);=
=0A+=09=09goto retry;=0A+=09} else {=0A+=09=09virtqueue_kick(vq);=0A+=09}=
=0A+=0A+=09return ret;=0A+}=0A+=0A+static int virtio_video_queue_ctrl_buffe=
r(struct virtio_video *vv,=0A+=09=09=09=09=09  struct virtio_video_vbuffer =
*vbuf)=0A+{=0A+=09int ret;=0A+=0A+=09spin_lock(&vv->ctrlq.qlock);=0A+=09ret=
 =3D virtio_video_queue_ctrl_buffer_locked(vv, vbuf);=0A+=09spin_unlock(&vv=
->ctrlq.qlock);=0A+=0A+=09return ret;=0A+}=0A+=0A+static int virtio_video_q=
ueue_event_buffer(struct virtio_video *vv,=0A+=09=09=09=09=09   struct virt=
io_video_vbuffer *vbuf)=0A+{=0A+=09int ret;=0A+=09struct scatterlist vresp;=
=0A+=09struct virtqueue *vq =3D vv->eventq.vq;=0A+=0A+=09spin_lock(&vv->eve=
ntq.qlock);=0A+=09sg_init_one(&vresp, vbuf->resp_buf, vbuf->resp_size);=0A+=
=09ret =3D virtqueue_add_inbuf(vq, &vresp, 1, vbuf, GFP_ATOMIC);=0A+=09spin=
_unlock(&vv->eventq.qlock);=0A+=09if (ret)=0A+=09=09return ret;=0A+=0A+=09v=
irtqueue_kick(vq);=0A+=0A+=09return 0;=0A+}=0A+=0A+static void virtio_video=
_event_cb(struct virtio_video *vv,=0A+=09=09=09=09  struct virtio_video_vbu=
ffer *vbuf)=0A+{=0A+=09int ret;=0A+=09struct virtio_video_stream *stream;=
=0A+=09struct virtio_video_event *event =3D=0A+=09=09(struct virtio_video_e=
vent *)vbuf->resp_buf;=0A+=0A+=09stream =3D idr_find(&vv->stream_idr, event=
->stream_id);=0A+=09if (!stream) {=0A+=09=09v4l2_warn(&vv->v4l2_dev, "no st=
ream %u found for event\n",=0A+=09=09=09  event->stream_id);=0A+=09=09retur=
n;=0A+=09}=0A+=0A+=09switch (le32_to_cpu(event->event_type)) {=0A+=09case V=
IRTIO_VIDEO_EVENT_T_RESOLUTION_CHANGED:=0A+=09=09virtio_video_req_get_param=
s(vv, event->function_id,=0A+=09=09=09=09=09    VIDEO_PIN_TYPE_OUTPUT,=0A+=
=09=09=09=09=09    VIDEO_PARAMS_SCOPE_STREAM, stream);=0A+=09=09virtio_vide=
o_queue_res_chg_event(stream);=0A+=09=09break;=0A+=09case VIRTIO_VIDEO_EVEN=
T_T_CONFIGURED:=0A+=09=09if (stream->state =3D=3D STREAM_STATE_INIT) {=0A+=
=09=09=09stream->state =3D STREAM_STATE_METADATA;=0A+=09=09=09wake_up(&vv->=
wq);=0A+=09=09}=0A+=09=09break;=0A+=09default:=0A+=09=09v4l2_warn(&vv->v4l2=
_dev, "failed to queue event buffer\n");=0A+=09=09break;=0A+=09}=0A+=0A+=09=
memset(vbuf->resp_buf, 0, vbuf->resp_size);=0A+=09ret =3D virtio_video_queu=
e_event_buffer(vv, vbuf);=0A+=09if (ret)=0A+=09=09v4l2_warn(&vv->v4l2_dev, =
"queue event buffer failed\n");=0A+}=0A+=0A+int virtio_video_alloc_events(s=
truct virtio_video *vv, size_t num)=0A+{=0A+=09int ret;=0A+=09size_t i;=0A+=
=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09for (i =3D 0; i < num; i++)=
 {=0A+=09=09vbuf =3D virtio_video_get_vbuf(vv, 0,=0A+=09=09=09=09=09     si=
zeof(struct virtio_video_event),=0A+=09=09=09=09=09     NULL, virtio_video_=
event_cb);=0A+=09=09if (IS_ERR(vbuf))=0A+=09=09=09return PTR_ERR(vbuf);=0A+=
=0A+=09=09ret =3D virtio_video_queue_event_buffer(vv, vbuf);=0A+=09=09if (r=
et)=0A+=09=09=09return ret;=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+int vir=
tio_video_req_stream_create(struct virtio_video *vv,=0A+=09=09=09=09   uint=
32_t function_id, uint32_t stream_id,=0A+=09=09=09=09   const char *name)=
=0A+{=0A+=09struct virtio_video_stream_create *req_p;=0A+=09struct virtio_v=
ideo_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, s=
izeof(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A=
+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_=
le32(VIRTIO_VIDEO_T_STREAM_CREATE);=0A+=09req_p->hdr.stream_id =3D cpu_to_l=
e32(stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_id);=
=0A+=09strncpy(req_p->debug_name, name, sizeof(req_p->debug_name) - 1);=0A+=
=09req_p->debug_name[sizeof(req_p->debug_name) - 1] =3D 0;=0A+=0A+=09return=
 virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+int virtio_video_req=
_stream_destroy(struct virtio_video *vv,=0A+=09=09=09=09    uint32_t functi=
on_id, uint32_t stream_id)=0A+{=0A+=09struct virtio_video_stream_destroy *r=
eq_p;=0A+=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_v=
ideo_alloc_req(vv, &vbuf, sizeof(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=
=09return PTR_ERR(req_p);=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=
=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_T_STREAM_DESTROY);=0A+=09re=
q_p->hdr.stream_id =3D cpu_to_le32(stream_id);=0A+=09req_p->hdr.function_id=
 =3D cpu_to_le32(function_id);=0A+=0A+=09return virtio_video_queue_ctrl_buf=
fer(vv, vbuf);=0A+}=0A+=0A+int virtio_video_req_stream_start(struct virtio_=
video *vv,=0A+=09=09=09=09  uint32_t function_id, uint32_t stream_id)=0A+{=
=0A+=09struct virtio_video_stream_start *req_p;=0A+=09struct virtio_video_v=
buffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(=
*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=09me=
mset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(V=
IRTIO_VIDEO_T_STREAM_START);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32(str=
eam_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_id);=0A+=0A+=
=09return virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+int virtio_=
video_req_stream_stop(struct virtio_video *vv,=0A+=09=09=09=09 uint32_t fun=
ction_id,=0A+=09=09=09=09 struct virtio_video_stream *stream)=0A+{=0A+=09st=
ruct virtio_video_stream_stop *req_p;=0A+=09struct virtio_video_vbuffer *vb=
uf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));=
=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=09memset(req_=
p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VID=
EO_T_STREAM_STOP);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32(stream->strea=
m_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_id);=0A+=0A+=
=09vbuf->priv =3D stream;=0A+=0A+=09return virtio_video_queue_ctrl_buffer(v=
v, vbuf);=0A+}=0A+=0A+int virtio_video_req_stream_drain(struct virtio_video=
 *vv,=0A+=09=09=09=09  uint32_t function_id, uint32_t stream_id)=0A+{=0A+=
=09struct virtio_video_stream_drain *req_p;=0A+=09struct virtio_video_vbuff=
er *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req=
_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=09memset=
(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(VIRTI=
O_VIDEO_T_STREAM_DRAIN);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32(stream_=
id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_id);=0A+=0A+=09r=
eturn virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+int virtio_vide=
o_req_resource_create(struct virtio_video *vv,=0A+=09=09=09=09     uint32_t=
 function_id, uint32_t stream_id,=0A+=09=09=09=09     uint32_t resource_id)=
=0A+{=0A+=09struct virtio_video_resource_create *req_p;=0A+=09struct virtio=
_video_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf,=
 sizeof(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=
=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_=
to_le32(VIRTIO_VIDEO_T_RESOURCE_CREATE);=0A+=09req_p->hdr.stream_id =3D cpu=
_to_le32(stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_=
id);=0A+=09req_p->resource_id =3D cpu_to_le32(resource_id);=0A+=0A+=09retur=
n virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+int virtio_video_re=
q_resource_destroy(struct virtio_video *vv,=0A+=09=09=09=09      uint32_t f=
unction_id, uint32_t stream_id,=0A+=09=09=09=09      uint32_t resource_id)=
=0A+{=0A+=09struct virtio_video_resource_destroy *req_p;=0A+=09struct virti=
o_video_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf=
, sizeof(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=
=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_=
to_le32(VIRTIO_VIDEO_T_RESOURCE_DESTROY);=0A+=09req_p->hdr.stream_id =3D cp=
u_to_le32(stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function=
_id);=0A+=09req_p->resource_id =3D cpu_to_le32(resource_id);=0A+=0A+=09retu=
rn virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+static void=0A+vir=
tio_video_req_resource_queue_cb(struct virtio_video *vv,=0A+=09=09=09=09   =
struct virtio_video_vbuffer *vbuf)=0A+{=0A+=09uint32_t flags, bytesused;=0A=
+=09uint64_t timestamp;=0A+=09struct virtio_video_buffer *virtio_vb =3D vbu=
f->priv;=0A+=09struct virtio_video_resource_queue_resp *resp =3D=0A+=09=09(=
struct virtio_video_resource_queue_resp *)vbuf->resp_buf;=0A+=0A+=09flags =
=3D le32_to_cpu(resp->flags);=0A+=09bytesused =3D le32_to_cpu(resp->size);=
=0A+=09timestamp =3D le64_to_cpu(resp->timestamp);=0A+=0A+=09virtio_video_b=
uf_done(virtio_vb, flags, timestamp, bytesused);=0A+}=0A+=0A+int virtio_vid=
eo_req_resource_queue(struct virtio_video *vv,=0A+=09=09=09=09    uint32_t =
function_id, uint32_t stream_id,=0A+=09=09=09=09    struct virtio_video_buf=
fer *virtio_vb,=0A+=09=09=09=09    uint32_t data_size[],=0A+=09=09=09=09   =
 uint8_t num_data_size, bool is_in)=0A+{=0A+=09uint8_t i;=0A+=09struct virt=
io_video_resource_queue *req_p;=0A+=09struct virtio_video_resource_queue_re=
sp *resp_p;=0A+=09struct virtio_video_vbuffer *vbuf;=0A+=09size_t resp_size=
 =3D sizeof(struct virtio_video_resource_queue_resp);=0A+=0A+=09req_p =3D v=
irtio_video_alloc_req_resp(vv,=0A+=09=09=09=09=09    &virtio_video_req_reso=
urce_queue_cb,=0A+=09=09=09=09=09    &vbuf, sizeof(*req_p), resp_size,=0A+=
=09=09=09=09=09    NULL);=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(=
req_p);=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =
=3D cpu_to_le32(VIRTIO_VIDEO_T_RESOURCE_QUEUE);=0A+=09req_p->hdr.stream_id =
=3D cpu_to_le32(stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(fu=
nction_id);=0A+=09req_p->pin_type =3D cpu_to_le32(is_in ? VIRTIO_VIDEO_PIN_=
INPUT :=0A+=09=09=09=09      VIRTIO_VIDEO_PIN_OUTPUT);=0A+=0A+=09for (i =3D=
 0; i < num_data_size; ++i)=0A+=09=09req_p->data_size[i] =3D cpu_to_le32(da=
ta_size[i]);=0A+=0A+=09req_p->resource_id =3D cpu_to_le32(virtio_vb->resour=
ce_id);=0A+=09req_p->nr_data_size =3D num_data_size;=0A+=09req_p->timestamp=
 =3D=0A+=09=09cpu_to_le64(virtio_vb->v4l2_m2m_vb.vb.vb2_buf.timestamp);=0A+=
=0A+=09resp_p =3D (struct virtio_video_resource_queue_resp *)vbuf->resp_buf=
;=0A+=09memset(resp_p, 0, sizeof(*resp_p));=0A+=0A+=09vbuf->priv =3D virtio=
_vb;=0A+=0A+=09return virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A=
+int=0A+virtio_video_req_resource_attach_backing(struct virtio_video *vv,=
=0A+=09=09=09=09=09 uint32_t function_id,=0A+=09=09=09=09=09 uint32_t strea=
m_id,=0A+=09=09=09=09=09 uint32_t resource_id,=0A+=09=09=09=09=09 struct vi=
rtio_video_mem_entry *ents,=0A+=09=09=09=09=09 uint32_t nents)=0A+{=0A+=09s=
truct virtio_video_resource_attach_backing *req_p;=0A+=09struct virtio_vide=
o_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, size=
of(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=
=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_l=
e32(VIRTIO_VIDEO_T_RESOURCE_ATTACH_BACKING);=0A+=09req_p->hdr.stream_id =3D=
 cpu_to_le32(stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(funct=
ion_id);=0A+=09req_p->resource_id =3D cpu_to_le32(resource_id);=0A+=09req_p=
->nr_entries =3D cpu_to_le32(nents);=0A+=0A+=09vbuf->data_buf =3D ents;=0A+=
=09vbuf->data_size =3D sizeof(*ents) * nents;=0A+=0A+=09return virtio_video=
_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+static void=0A+virtio_video_req_d=
etach_backing_cb(struct virtio_video *vv,=0A+=09=09=09=09   struct virtio_v=
ideo_vbuffer *vbuf)=0A+{=0A+=09struct virtio_video_buffer *virtio_vb =3D vb=
uf->priv;=0A+=0A+=09virtio_vb->detached =3D true;=0A+=09wake_up(&vv->wq);=
=0A+}=0A+=0A+int=0A+virtio_video_req_resource_detach_backing(struct virtio_=
video *vv,=0A+=09=09=09=09=09 uint32_t function_id,=0A+=09=09=09=09=09 uint=
32_t stream_id,=0A+=09=09=09=09=09 struct virtio_video_buffer *virtio_vb)=
=0A+{=0A+=09struct virtio_video_resource_detach_backing *req_p;=0A+=09struc=
t virtio_video_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_alloc_req_re=
sp=0A+=09=09(vv, &virtio_video_req_detach_backing_cb, &vbuf, sizeof(*req_p)=
,=0A+=09=09 sizeof(struct virtio_video_ctrl_hdr), NULL);=0A+=09if (IS_ERR(r=
eq_p))=0A+=09=09return PTR_ERR(req_p);=0A+=09memset(req_p, 0, sizeof(*req_p=
));=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_T_RESOURCE_DETAC=
H_BACKING);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);=0A+=09re=
q_p->hdr.function_id =3D cpu_to_le32(function_id);=0A+=09req_p->resource_id=
 =3D cpu_to_le32(virtio_vb->resource_id);=0A+=09vbuf->priv =3D virtio_vb;=
=0A+=0A+=09return virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+sta=
tic void=0A+virtio_video_req_queue_clear_cb(struct virtio_video *vv,=0A+=09=
=09=09=09struct virtio_video_vbuffer *vbuf)=0A+{=0A+=09struct virtio_video_=
stream *stream =3D vbuf->priv;=0A+=09struct virtio_video_queue_clear *req_p=
 =3D=0A+=09=09(struct virtio_video_queue_clear *)vbuf->buf;=0A+=0A+=09if (l=
e32_to_cpu(req_p->pin_type) =3D=3D VIRTIO_VIDEO_PIN_INPUT)=0A+=09=09stream-=
>src_cleared =3D true;=0A+=09else=0A+=09=09stream->dst_cleared =3D true;=0A=
+=0A+=09wake_up(&vv->wq);=0A+}=0A+=0A+int virtio_video_req_queue_clear(stru=
ct virtio_video *vv, uint32_t function_id,=0A+=09=09=09=09 struct virtio_vi=
deo_stream *stream,=0A+=09=09=09=09 bool is_in)=0A+{=0A+=09struct virtio_vi=
deo_queue_clear *req_p;=0A+=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09=
req_p =3D virtio_video_alloc_req_resp=0A+=09=09(vv, &virtio_video_req_queue=
_clear_cb, &vbuf, sizeof(*req_p),=0A+=09=09 sizeof(struct virtio_video_ctrl=
_hdr), NULL);=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=
=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_l=
e32(VIRTIO_VIDEO_T_QUEUE_CLEAR);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32=
(stream->stream_id);=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_=
id);=0A+=09req_p->pin_type =3D cpu_to_le32(is_in ? VIRTIO_VIDEO_PIN_INPUT :=
=0A+=09=09=09=09      VIRTIO_VIDEO_PIN_OUTPUT);=0A+=0A+=09vbuf->priv =3D st=
ream;=0A+=0A+=09return virtio_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=
=0A+static void=0A+virtio_video_req_funcs_cb(struct virtio_video *vv,=0A+=
=09=09=09  struct virtio_video_vbuffer *vbuf)=0A+{=0A+=09bool *got_resp_p =
=3D vbuf->priv;=0A+=09*got_resp_p =3D true;=0A+=09wake_up(&vv->wq);=0A+}=0A=
+=0A+int virtio_video_req_funcs(struct virtio_video *vv, void *resp_buf,=0A=
+=09=09=09   size_t resp_size)=0A+{=0A+=09struct virtio_video_get_functions=
 *req_p =3D NULL;=0A+=09struct virtio_video_vbuffer *vbuf =3D NULL;=0A+=0A+=
=09if (!vv || !resp_buf)=0A+=09=09return -1;=0A+=0A+=09req_p =3D virtio_vid=
eo_alloc_req_resp(vv, &virtio_video_req_funcs_cb,=0A+=09=09=09=09=09    &vb=
uf, sizeof(*req_p), resp_size,=0A+=09=09=09=09=09    resp_buf);=0A+=09if (I=
S_ERR(req_p))=0A+=09=09return -1;=0A+=0A+=09memset(req_p, 0, sizeof(*req_p)=
);=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_T_GET_FUNCS);=0A+=
=0A+=09vbuf->priv =3D &vv->got_funcs;=0A+=0A+=09return virtio_video_queue_c=
trl_buffer(vv, vbuf);=0A+}=0A+=0A+static void=0A+virtio_video_req_get_param=
s_cb(struct virtio_video *vv,=0A+=09=09=09       struct virtio_video_vbuffe=
r *vbuf)=0A+{=0A+=09int i;=0A+=09struct virtio_video_get_params_resp *resp =
=3D=0A+=09=09(struct virtio_video_get_params_resp *)vbuf->resp_buf;=0A+=09s=
truct virtio_video_params *params =3D &resp->params;=0A+=09struct virtio_vi=
deo_stream *stream =3D vbuf->priv;=0A+=09enum virtio_video_pin_type pin_typ=
e;=0A+=09enum virtio_video_scope_type scope;=0A+=09struct video_format_info=
 *format_info =3D NULL;=0A+=09struct virtio_video_device *vvd  =3D NULL;=0A=
+=0A+=09pin_type =3D le32_to_cpu(params->pin_type);=0A+=09scope =3D le32_to=
_cpu(params->scope);=0A+=0A+=09vvd =3D to_virtio_vd(stream->video_dev);=0A+=
=09if (!vvd) {=0A+=09=09v4l2_warn(&vv->v4l2_dev, "no video device found\n")=
;=0A+=09=09return;=0A+=09}=0A+=0A+=09if (scope =3D=3D VIRTIO_VIDEO_SCOPE_ST=
REAM) {=0A+=09=09if (pin_type =3D=3D VIRTIO_VIDEO_PIN_INPUT)=0A+=09=09=09fo=
rmat_info =3D &stream->in_info;=0A+=09=09else=0A+=09=09=09format_info =3D &=
stream->out_info;=0A+=09} else {=0A+=09=09if (pin_type =3D=3D VIRTIO_VIDEO_=
PIN_INPUT)=0A+=09=09=09format_info =3D &vvd->in_info;=0A+=09=09else=0A+=09=
=09=09format_info =3D &vvd->out_info;=0A+=09}=0A+=0A+=09if (!format_info)=
=0A+=09=09return;=0A+=0A+=09format_info->frame_rate =3D le32_to_cpu(params-=
>frame_rate);=0A+=09format_info->frame_width =3D le32_to_cpu(params->frame_=
width);=0A+=09format_info->frame_height =3D le32_to_cpu(params->frame_heigh=
t);=0A+=09format_info->min_buffers =3D le32_to_cpu(params->min_buffers);=0A=
+=09format_info->fourcc_format =3D virtio_video_format_to_v4l2(=0A+=09=09=
=09 le32_to_cpu(params->pixel_format));=0A+=0A+=09format_info->num_planes =
=3D le32_to_cpu(params->num_planes);=0A+=09for (i =3D 0; i < le32_to_cpu(pa=
rams->num_planes); i++) {=0A+=09=09struct virtio_video_plane_format *plane_=
formats =3D=0A+=09=09=09=09=09=09 &params->plane_formats[i];=0A+=09=09struc=
t video_plane_format *plane_format =3D=0A+=09=09=09=09=09=09 &format_info->=
plane_format[i];=0A+=0A+=09=09plane_format->channel =3D le32_to_cpu(plane_f=
ormats->channel);=0A+=09=09plane_format->plane_size =3D=0A+=09=09=09=09 le3=
2_to_cpu(plane_formats->plane_size);=0A+=09=09plane_format->stride =3D le32=
_to_cpu(plane_formats->stride);=0A+=09=09plane_format->padding =3D le32_to_=
cpu(plane_formats->padding);=0A+=09}=0A+=0A+=09format_info->is_updated =3D =
true;=0A+=09wake_up(&vv->wq);=0A+}=0A+=0A+int virtio_video_req_get_params(s=
truct virtio_video *vv, uint32_t function_id,=0A+=09=09=09=09enum video_pin=
_type pin_type,=0A+=09=09=09=09enum video_params_scope params_scope,=0A+=09=
=09=09=09struct virtio_video_stream *stream)=0A+{=0A+=09int ret;=0A+=09stru=
ct virtio_video_get_params *req_p =3D NULL;=0A+=09struct virtio_video_vbuff=
er *vbuf =3D NULL;=0A+=09struct virtio_video_get_params_resp *resp_p;=0A+=
=09struct video_format_info *format_info =3D NULL;=0A+=09size_t resp_size =
=3D sizeof(struct virtio_video_get_params_resp);=0A+=09struct virtio_video_=
device *vvd  =3D NULL;=0A+=0A+=09if (!vv || !stream)=0A+=09=09return -1;=0A=
+=0A+=09req_p =3D virtio_video_alloc_req_resp(vv,=0A+=09=09=09=09=09&virtio=
_video_req_get_params_cb,=0A+=09=09=09=09=09&vbuf, sizeof(*req_p), resp_siz=
e,=0A+=09=09=09=09=09NULL);=0A+=0A+=09if (IS_ERR(req_p))=0A+=09=09return PT=
R_ERR(req_p);=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.=
type =3D cpu_to_le32(VIRTIO_VIDEO_T_GET_PARAMS);=0A+=09req_p->hdr.stream_id=
 =3D cpu_to_le32(stream->stream_id);=0A+=09req_p->hdr.function_id =3D cpu_t=
o_le32(function_id);=0A+=09req_p->pin_type =3D=0A+=09=09cpu_to_le32(pin_typ=
e =3D=3D VIDEO_PIN_TYPE_INPUT ?=0A+=09=09=09    VIRTIO_VIDEO_PIN_INPUT : VI=
RTIO_VIDEO_PIN_OUTPUT);=0A+=09req_p->scope =3D=0A+=09=09cpu_to_le32(params_=
scope =3D=3D VIDEO_PARAMS_SCOPE_DEVICE ?=0A+=09=09=09    VIRTIO_VIDEO_SCOPE=
_GLOBAL :=0A+=09=09=09    VIRTIO_VIDEO_SCOPE_STREAM);=0A+=09resp_p =3D (str=
uct virtio_video_get_params_resp *)vbuf->resp_buf;=0A+=09memset(resp_p, 0, =
sizeof(*resp_p));=0A+=0A+=09if (req_p->scope =3D=3D VIRTIO_VIDEO_SCOPE_STRE=
AM) {=0A+=09=09if (req_p->pin_type =3D=3D VIRTIO_VIDEO_PIN_INPUT)=0A+=09=09=
=09format_info =3D &stream->in_info;=0A+=09=09else=0A+=09=09=09format_info =
=3D &stream->out_info;=0A+=09} else {=0A+=09=09vvd =3D to_virtio_vd(stream-=
>video_dev);=0A+=09=09if (!vvd) {=0A+=09=09=09v4l2_warn(&vv->v4l2_dev, "no =
video device found\n");=0A+=09=09=09return -1;=0A+=09=09}=0A+=09=09if (req_=
p->pin_type =3D=3D VIRTIO_VIDEO_PIN_INPUT)=0A+=09=09=09format_info =3D &vvd=
->in_info;=0A+=09=09else=0A+=09=09=09format_info =3D &vvd->out_info;=0A+=09=
}=0A+=0A+=09if (!format_info)=0A+=09=09return -1;=0A+=0A+=09format_info->is=
_updated =3D false;=0A+=0A+=09vbuf->priv =3D stream;=0A+=09ret =3D virtio_v=
ideo_queue_ctrl_buffer(vv, vbuf);=0A+=09if (ret)=0A+=09=09return ret;=0A+=
=0A+=09ret =3D wait_event_timeout(vv->wq,=0A+=09=09=09=09 format_info->is_u=
pdated, 5 * HZ);=0A+=09if (ret =3D=3D 0) {=0A+=09=09v4l2_err(&vv->v4l2_dev,=
 "timed out waiting for get_params\n");=0A+=09=09return -1;=0A+=09}=0A+=09r=
eturn 0;=0A+}=0A+=0A+int=0A+virtio_video_req_set_params(struct virtio_video=
 *vv, uint32_t function_id,=0A+=09=09=09    struct video_format_info *forma=
t_info,=0A+=09=09=09    enum video_pin_type pin_type,=0A+=09=09=09    enum =
video_params_scope params_scope,=0A+=09=09=09    struct virtio_video_stream=
 *stream)=0A+{=0A+=09int i;=0A+=09struct virtio_video_set_params *req_p;=0A=
+=09struct virtio_video_vbuffer *vbuf;=0A+=0A+=09req_p =3D virtio_video_all=
oc_req(vv, &vbuf, sizeof(*req_p));=0A+=09if (IS_ERR(req_p))=0A+=09=09return=
 PTR_ERR(req_p);=0A+=09memset(req_p, 0, sizeof(*req_p));=0A+=0A+=09req_p->h=
dr.type =3D cpu_to_le32(VIRTIO_VIDEO_T_SET_PARAMS);=0A+=09req_p->hdr.stream=
_id =3D cpu_to_le32(stream->stream_id);=0A+=09req_p->hdr.function_id =3D cp=
u_to_le32(function_id);=0A+=09req_p->params.pin_type =3D=0A+=09=09cpu_to_le=
32(pin_type =3D=3D VIDEO_PIN_TYPE_INPUT ?=0A+=09=09=09    VIRTIO_VIDEO_PIN_=
INPUT : VIRTIO_VIDEO_PIN_OUTPUT);=0A+=09req_p->params.scope =3D=0A+=09=09cp=
u_to_le32(params_scope =3D=3D VIDEO_PARAMS_SCOPE_DEVICE ?=0A+=09=09=09    V=
IRTIO_VIDEO_SCOPE_GLOBAL :=0A+=09=09=09    VIRTIO_VIDEO_SCOPE_STREAM);=0A+=
=09req_p->params.frame_rate =3D cpu_to_le32(format_info->frame_rate);=0A+=
=09req_p->params.frame_width =3D cpu_to_le32(format_info->frame_width);=0A+=
=09req_p->params.frame_height =3D=0A+=09=09=09=09 cpu_to_le32(format_info->=
frame_height);=0A+=09req_p->params.pixel_format =3D virtio_video_v4l2_fourc=
c_to_virtio(=0A+=09=09=09=09 cpu_to_le32(format_info->fourcc_format));=0A+=
=09req_p->params.min_buffers =3D cpu_to_le32(format_info->min_buffers);=0A+=
=09req_p->params.num_planes =3D cpu_to_le32(format_info->num_planes);=0A+=
=0A+=09for (i =3D 0; i < format_info->num_planes; i++) {=0A+=09=09struct vi=
rtio_video_plane_format *plane_formats =3D=0A+=09=09=09&req_p->params.plane=
_formats[i];=0A+=09=09struct video_plane_format *plane_format =3D=0A+=09=09=
=09&format_info->plane_format[i];=0A+=09=09plane_formats->channel =3D cpu_t=
o_le32(plane_format->channel);=0A+=09=09plane_formats->plane_size =3D=0A+=
=09=09=09=09 cpu_to_le32(plane_format->plane_size);=0A+=09=09plane_formats-=
>stride =3D cpu_to_le32(plane_format->stride);=0A+=09=09plane_formats->padd=
ing =3D cpu_to_le32(plane_format->padding);=0A+=09}=0A+=0A+=09return virtio=
_video_queue_ctrl_buffer(vv, vbuf);=0A+}=0A+=0A+int virtio_video_req_set_co=
ntrol(struct virtio_video *vv,=0A+=09=09=09=09 uint32_t function_id, uint32=
_t stream_id,=0A+=09=09=09=09 uint32_t control, uint32_t val)=0A+{=0A+=09st=
ruct virtio_video_set_control *req_p;=0A+=09struct virtio_video_vbuffer *vb=
uf;=0A+=0A+=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));=
=0A+=09if (IS_ERR(req_p))=0A+=09=09return PTR_ERR(req_p);=0A+=09memset(req_=
p, 0, sizeof(*req_p));=0A+=0A+=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VID=
EO_T_SET_CONTROL);=0A+=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);=
=0A+=09req_p->hdr.function_id =3D cpu_to_le32(function_id);=0A+=09req_p->ty=
pe =3D virtio_video_v4l2_control_to_virtio(cpu_to_le32(control));=0A+=09req=
_p->val =3D cpu_to_le64(val);=0A+=0A+=09return virtio_video_queue_ctrl_buff=
er(vv, vbuf);=0A+}=0A+=0Adiff --git a/include/uapi/linux/virtio_ids.h b/inc=
lude/uapi/linux/virtio_ids.h=0Aindex 585e07b27333..8be72c11ae22 100644=0A--=
- a/include/uapi/linux/virtio_ids.h=0A+++ b/include/uapi/linux/virtio_ids.h=
=0A@@ -47,4 +47,6 @@=0A #define VIRTIO_ID_FS           26 /* virtio filesys=
tem */=0A #define VIRTIO_ID_PMEM         27 /* virtio pmem */=0A=20=0A+#def=
ine VIRTIO_ID_VIDEO        29 /* virtio video  */=0A+=0A #endif /* _LINUX_V=
IRTIO_IDS_H */=0Adiff --git a/include/uapi/linux/virtio_video.h b/include/u=
api/linux/virtio_video.h=0Anew file mode 100644=0Aindex 000000000000..c8122=
f03bfeb=0A--- /dev/null=0A+++ b/include/uapi/linux/virtio_video.h=0A@@ -0,0=
 +1,456 @@=0A+/* SPDX-License-Identifier: BSD-3-Clause */=0A+/*=0A+ * Virti=
o Video Device=0A+ *=0A+ * This header is BSD licensed so anyone can use th=
e definitions=0A+ * to implement compatible drivers/servers:=0A+ *=0A+ * Re=
distribution and use in source and binary forms, with or without=0A+ * modi=
fication, are permitted provided that the following conditions=0A+ * are me=
t:=0A+ * 1. Redistributions of source code must retain the above copyright=
=0A+ *    notice, this list of conditions and the following disclaimer.=0A+=
 * 2. Redistributions in binary form must reproduce the above copyright=0A+=
 *    notice, this list of conditions and the following disclaimer in the=
=0A+ *    documentation and/or other materials provided with the distributi=
on.=0A+ * 3. Neither the name of IBM nor the names of its contributors=0A+ =
*    may be used to endorse or promote products derived from this software=
=0A+ *    without specific prior written permission.=0A+ * THIS SOFTWARE IS=
 PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS=0A+ * ``AS IS'' AND ANY=
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=0A+ * LIMITED TO, THE IM=
PLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=0A+ * FOR A PARTICULAR PURP=
OSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR=0A+ * CONTRIBUTORS BE LIABLE =
FOR ANY DIRECT, INDIRECT, INCIDENTAL,=0A+ * SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL DAMAGES (INCLUDING, BUT NOT=0A+ * LIMITED TO, PROCUREMENT OF SUBSTITU=
TE GOODS OR SERVICES; LOSS OF=0A+ * USE, DATA, OR PROFITS; OR BUSINESS INTE=
RRUPTION) HOWEVER CAUSED AND=0A+ * ON ANY THEORY OF LIABILITY, WHETHER IN C=
ONTRACT, STRICT LIABILITY,=0A+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE=
) ARISING IN ANY WAY OUT=0A+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED=
 OF THE POSSIBILITY OF=0A+ * SUCH DAMAGE.=0A+ */=0A+=0A+#ifndef _UAPI_VIRTI=
O_VIDEO_H=0A+#define=09_UAPI_VIRTIO_VIDEO_H=0A+=0A+#include <linux/types.h>=
=0A+#include <linux/virtio_config.h>=0A+=0A+/* Maximum number of planes ass=
ociated with a resource. */=0A+#define VIRTIO_VIDEO_MAX_PLANES 8=0A+=0A+/* =
Maximum size of get params response */=0A+#define VIRTIO_VIDEO_MAXSIZE_GET_=
PARAMS 1024=0A+=0A+enum virtio_video_func_type {=0A+=09VIRTIO_VIDEO_FUNC_UN=
DEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_FUNC_ENCODER =3D 0x0100,=0A+=09VIRTIO=
_VIDEO_FUNC_DECODER,=0A+=09VIRTIO_VIDEO_FUNC_PROCESSOR,=0A+=09VIRTIO_VIDEO_=
FUNC_CAPTURE,=0A+=09VIRTIO_VIDEO_FUNC_OUTPUT,=0A+};=0A+=0A+enum virtio_vide=
o_ctrl_type {=0A+=09VIRTIO_VIDEO_CTRL_UNDEFINED =3D 0,=0A+=0A+=09/* request=
 */=0A+=09VIRTIO_VIDEO_T_GET_FUNCS =3D 0x0100,=0A+=09VIRTIO_VIDEO_T_STREAM_=
CREATE,=0A+=09VIRTIO_VIDEO_T_STREAM_DESTROY,=0A+=09VIRTIO_VIDEO_T_STREAM_ST=
ART,=0A+=09VIRTIO_VIDEO_T_STREAM_STOP,=0A+=09VIRTIO_VIDEO_T_STREAM_DRAIN,=
=0A+=09VIRTIO_VIDEO_T_RESOURCE_CREATE,=0A+=09VIRTIO_VIDEO_T_RESOURCE_DESTRO=
Y,=0A+=09VIRTIO_VIDEO_T_RESOURCE_ATTACH_BACKING,=0A+=09VIRTIO_VIDEO_T_RESOU=
RCE_DETACH_BACKING,=0A+=09VIRTIO_VIDEO_T_RESOURCE_QUEUE,=0A+=09VIRTIO_VIDEO=
_T_QUEUE_CLEAR,=0A+=09VIRTIO_VIDEO_T_SET_PARAMS,=0A+=09VIRTIO_VIDEO_T_GET_P=
ARAMS,=0A+=09VIRTIO_VIDEO_T_SET_CONTROL,=0A+=0A+=09/* response */=0A+=09VIR=
TIO_VIDEO_S_OK =3D 0x0200,=0A+=09VIRTIO_VIDEO_S_OK_RESOURCE_QUEUE,=0A+=09VI=
RTIO_VIDEO_S_OK_GET_PARAMS,=0A+=0A+=09VIRTIO_VIDEO_S_ERR_UNSPEC =3D 0x0300,=
=0A+=09VIRTIO_VIDEO_S_ERR_OUT_OF_MEMORY,=0A+=09VIRTIO_VIDEO_S_ERR_INVALID_F=
UNCTION_ID,=0A+=09VIRTIO_VIDEO_S_ERR_INVALID_RESOURCE_ID,=0A+=09VIRTIO_VIDE=
O_S_ERR_INVALID_STREAM_ID,=0A+=09VIRTIO_VIDEO_S_ERR_INVALID_PARAMETER,=0A+}=
;=0A+=0A+enum virtio_video_event_type {=0A+=09VIRTIO_VIDEO_EVENT_T_UNDEFINE=
D =3D 0,=0A+=0A+=09VIRTIO_VIDEO_EVENT_T_RESOLUTION_CHANGED =3D 0x0100,=0A+=
=09VIRTIO_VIDEO_EVENT_T_CONFIGURED,=0A+};=0A+=0A+enum virtio_video_buffer_f=
lag {=0A+=09VIRTIO_VIDEO_BUFFER_F_ERR=09=3D 0x0001,=0A+=09VIRTIO_VIDEO_BUFF=
ER_F_EOS=09=3D 0x0002,=0A+=09VIRTIO_VIDEO_BUFFER_IFRAME=09=3D 0x0004,=0A+=
=09VIRTIO_VIDEO_BUFFER_PFRAME=09=3D 0x0008,=0A+=09VIRTIO_VIDEO_BUFFER_BFRAM=
E=09=3D 0x0010,=0A+};=0A+=0A+enum virtio_video_desc_type {=0A+=09VIRTIO_VID=
EO_DESC_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_DESC_FRAME_RATE =3D 0x0100,=
=0A+=09VIRTIO_VIDEO_DESC_FRAME_SIZE,=0A+=09VIRTIO_VIDEO_DESC_PIX_FORMAT,=0A=
+=09VIRTIO_VIDEO_DESC_PLANE_FORMAT,=0A+=09VIRTIO_VIDEO_DESC_CONTROL,=0A+=09=
VIRTIO_VIDEO_DESC_EXTRAS,=0A+=09VIRTIO_VIDEO_DESC_CAP,=0A+=09VIRTIO_VIDEO_D=
ESC_FUNC,=0A+=09VIRTIO_VIDEO_DESC_PARAMS,=0A+=09VIRTIO_VIDEO_DESC_DEFAULTS,=
=0A+};=0A+=0A+enum virtio_video_pin_type {=0A+=09VIRTIO_VIDEO_PIN_UNDEFINED=
 =3D 0,=0A+=0A+=09VIRTIO_VIDEO_PIN_INPUT =3D 0x0100,=0A+=09VIRTIO_VIDEO_PIN=
_OUTPUT,=0A+};=0A+=0A+enum virtio_video_channel_type {=0A+=09VIRTIO_VIDEO_C=
HANNEL_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_CHANNEL_Y =3D 0x0100,=0A+=09=
VIRTIO_VIDEO_CHANNEL_U,=0A+=09VIRTIO_VIDEO_CHANNEL_V,=0A+=09VIRTIO_VIDEO_CH=
ANNEL_UV,=0A+=09VIRTIO_VIDEO_CHANNEL_VU,=0A+=09VIRTIO_VIDEO_CHANNEL_YUV,=0A=
+=09VIRTIO_VIDEO_CHANNEL_YVU,=0A+=09VIRTIO_VIDEO_CHANNEL_BGR,=0A+=09VIRTIO_=
VIDEO_CHANNEL_BGRX,=0A+};=0A+=0A+enum virtio_video_control_type {=0A+=09VIR=
TIO_VIDEO_CONTROL_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_CONTROL_BITRATE =
=3D 0x100,=0A+=09VIRTIO_VIDEO_CONTROL_PROFILE,=0A+=09VIRTIO_VIDEO_CONTROL_L=
EVEL,=0A+};=0A+=0A+enum virtio_video_scope_type {=0A+=09VIRTIO_VIDEO_SCOPE_=
UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_SCOPE_GLOBAL =3D 0x0100,=0A+=09VIRT=
IO_VIDEO_SCOPE_STREAM,=0A+};=0A+=0A+enum virtio_video_cap_type {=0A+=09VIRT=
IO_VIDEO_CAP_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_VIDEO_CAP_PIN_FORMATS =3D 0x=
0100,=0A+=09VIRTIO_VIDEO_CAP_CONTROL,=0A+};=0A+=0A+struct virtio_video_ctrl=
_hdr {=0A+=09__le32 type;=0A+=09__le32 stream_id;=0A+=09__le32 function_id;=
=0A+=09__u8 padding[4];=0A+};=0A+=0A+struct virtio_video_desc {=0A+=09__le3=
2 type; /* One of VIRTIO_VIDEO_DESC_* types */=0A+=09__le16 length;=0A+=09_=
_u8 padding[2];=0A+};=0A+=0A+struct virtio_video_frame_rate {=0A+=09struct =
virtio_video_desc desc;=0A+=09__le32 min_rate;=0A+=09__le32 max_rate;=0A+=
=09__le32 step;=0A+=09__u8 padding[4];=0A+};=0A+=0A+struct virtio_video_fra=
me_size {=0A+=09struct virtio_video_desc desc;=0A+=09__le32 min_width;=0A+=
=09__le32 max_width;=0A+=09__le32 step_width;=0A+=09__le32 min_height;=0A+=
=09__le32 max_height;=0A+=09__le32 step_height;=0A+=09__le32 num_rates;=0A+=
=09__u8 padding[4];=0A+=09/* Followed by struct virtio_video_frame_rate fra=
me_rates[]; */=0A+};=0A+=0A+struct virtio_video_pix_format {=0A+=09struct v=
irtio_video_desc desc;=0A+=09__le32 pixel_format;=0A+=09__le32 num_sizes;=
=0A+=09/* Followed by struct virtio_video_frame_size frame_sizes[]; */=0A+}=
;=0A+=0A+struct virtio_video_frame_format {=0A+=09__le32 pin_type; /* One o=
f VIRTIO_VIDEO_PIN_* types */=0A+=09__le32 num_formats;=0A+=09/* Followed b=
y struct virtio_video_pix_format pix_formats[]; */=0A+};=0A+=0A+struct virt=
io_video_extras {=0A+=09struct virtio_video_desc desc;=0A+};=0A+=0A+struct =
virtio_video_plane_format {=0A+=09struct virtio_video_desc desc;=0A+=09__le=
32 channel; /* One of VIRTIO_VIDEO_CHANNEL_* types */=0A+=09__le32 plane_si=
ze;=0A+=09__le32 stride;=0A+=09__le32 padding;=0A+};=0A+=0A+struct virtio_v=
ideo_control {=0A+=09struct virtio_video_desc desc;=0A+=09__le32 control_ty=
pe;  /* One of VIRTO_VIDEO_CONTROL_* types */=0A+=09__le32 step;=0A+=09__le=
64 min;=0A+=09__le64 max;=0A+=09__le64 def;=0A+};=0A+=0A+struct virtio_vide=
o_controls {=0A+=09__le32 num_controls;=0A+=09__u8 padding[4];=0A+=09/* Fol=
lowed by struct virtio_video_control control[]; */=0A+};=0A+=0A+struct virt=
io_video_capability {=0A+=09struct virtio_video_desc desc;=0A+=09__le32 cap=
_type; /* One of VIRTIO_VIDEO_CAP_* types */=0A+=09__le32 cap_id;=0A+=09uni=
on {=0A+=09=09struct virtio_video_frame_format frame_format;=0A+=09=09struc=
t virtio_video_controls controls;=0A+=09} u;=0A+};=0A+=0A+struct virtio_vid=
eo_params {=0A+=09struct virtio_video_desc desc;=0A+=09__le32 pin_type; /* =
One of VIRTIO_VIDEO_PIN_* types */=0A+=09__le32 scope; /* One of VIRTIO_VID=
EO_SCOPE_* types */=0A+=09__le32 frame_rate;=0A+=09__le32 frame_width;=0A+=
=09__le32 frame_height;=0A+=09__le32 pixel_format;=0A+=09__le32 min_buffers=
;=0A+=09__le32 num_planes;=0A+=09struct virtio_video_plane_format plane_for=
mats[VIRTIO_VIDEO_MAX_PLANES];=0A+=09struct virtio_video_extras extra;=0A+=
=0A+};=0A+=0A+struct virtio_video_function {=0A+=09struct virtio_video_desc=
 desc;=0A+=09__le32 function_type; /* One of VIRTIO_VIDEO_FUNC_* types */=
=0A+=09__le32 function_id;=0A+=09struct virtio_video_params in_params;=0A+=
=09struct virtio_video_params out_params;=0A+=09__le32 num_caps;=0A+=09__u8=
 padding[4];=0A+=09/* Followed by struct virtio_video_capability video_caps=
[]; */=0A+};=0A+=0A+struct virtio_video_config {=0A+=09__u32 num_functions;=
=0A+=09__u32 total_functions_size;=0A+};=0A+=0A+struct virtio_video_mem_ent=
ry {=0A+=09__le64 addr;=0A+=09__le32 length;=0A+=09__u8 padding[4];=0A+};=
=0A+=0A+struct virtio_video_event {=0A+=09__le32 event_type;=0A+=09__le32 f=
unction_id;=0A+=09__le32 stream_id;=0A+=09__u8 padding[4];=0A+};=0A+=0A+/* =
VIRTIO_VIDEO_T_GET_FUNCS */=0A+struct virtio_video_get_functions {=0A+=09st=
ruct virtio_video_ctrl_hdr hdr;=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_STREAM_CREAT=
E */=0A+struct virtio_video_stream_create {=0A+=09struct virtio_video_ctrl_=
hdr hdr;=0A+=09char debug_name[64];=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_STREAM_D=
ESTROY */=0A+struct virtio_video_stream_destroy {=0A+=09struct virtio_video=
_ctrl_hdr hdr;=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_STREAM_START */=0A+struct vir=
tio_video_stream_start {=0A+=09struct virtio_video_ctrl_hdr hdr;=0A+};=0A+=
=0A+/* VIRTIO_VIDEO_T_STREAM_STOP */=0A+struct virtio_video_stream_stop {=
=0A+=09struct virtio_video_ctrl_hdr hdr;=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_STR=
EAM_DRAIN */=0A+struct virtio_video_stream_drain {=0A+=09struct virtio_vide=
o_ctrl_hdr hdr;=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_RESOURCE_CREATE */=0A+struct=
 virtio_video_resource_create {=0A+=09struct virtio_video_ctrl_hdr hdr;=0A+=
=09__le32 resource_id;=0A+=09__u8 padding[4];=0A+};=0A+=0A+/* VIRTIO_VIDEO_=
T_RESOURCE_DESTROY */=0A+struct virtio_video_resource_destroy {=0A+=09struc=
t virtio_video_ctrl_hdr hdr;=0A+=09__le32 resource_id;=0A+=09__u8 padding[4=
];=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_RESOURCE_ATTACH_BACKING */=0A+struct virt=
io_video_resource_attach_backing {=0A+=09struct virtio_video_ctrl_hdr hdr;=
=0A+=09__le32 resource_id;=0A+=09__le32 nr_entries;=0A+};=0A+=0A+/* VIRTIO_=
VIDEO_T_RESOURCE_DETACH_BACKING*/=0A+struct virtio_video_resource_detach_ba=
cking {=0A+=09struct virtio_video_ctrl_hdr hdr;=0A+=09__le32 resource_id;=
=0A+=09__u8 padding[4];=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_RESOURCE_QUEUE */=0A=
+struct virtio_video_resource_queue {=0A+=09struct virtio_video_ctrl_hdr hd=
r;=0A+=09__le64 timestamp;=0A+=09__le32 resource_id;=0A+=09__le32 pin_type;=
=0A+=09__le32 data_size[VIRTIO_VIDEO_MAX_PLANES];=0A+=09__u8 nr_data_size;=
=0A+=09__u8 padding[7];=0A+};=0A+=0A+/* VIRTIO_VIDEO_QUEUE_CLEAR */=0A+stru=
ct virtio_video_queue_clear {=0A+=09struct virtio_video_ctrl_hdr hdr;=0A+=
=09__le32 pin_type;=0A+=09__u8 padding[4];=0A+};=0A+=0A+/* VIRTIO_VIDEO_T_S=
ET_PARAMS */=0A+struct virtio_video_set_params {=0A+=09struct virtio_video_=
ctrl_hdr hdr;=0A+=09struct virtio_video_params params;=0A+};=0A+=0A+/* VIRT=
IO_VIDEO_T_GET_PARAMS */=0A+struct virtio_video_get_params {=0A+=09struct v=
irtio_video_ctrl_hdr hdr;=0A+=09__le32 pin_type; /* One of VIRTIO_VIDEO_PIN=
_* types */=0A+=09__le32 scope; /* One of VIRTIO_VIDEO_SCOPE_* types */=0A+=
};=0A+=0A+struct virtio_video_resource_queue_resp {=0A+=09struct virtio_vid=
eo_ctrl_hdr hdr;=0A+=09__le64 timestamp;=0A+=09__le32 flags; /* One of VIRT=
IO_VIDEO_BUFFER_* flags */=0A+=09__le32 size;  /* Encoded size */=0A+};=0A+=
=0A+struct virtio_video_get_params_resp {=0A+=09struct virtio_video_ctrl_hd=
r hdr;=0A+=09struct virtio_video_params params;=0A+};=0A+=0A+/* VIRTIO_VIDE=
O_T_SET_CONTROL */=0A+struct virtio_video_set_control {=0A+=09struct virtio=
_video_ctrl_hdr hdr;=0A+=09__le64 val;=0A+=09__le32 type;  /* One of VIRTO_=
VIDEO_CONTROL_* types */=0A+=09__u8 padding[4];=0A+};=0A+=0A+enum virtio_vi=
deo_pix_format_type {=0A+=09VIRTIO_VIDEO_PIX_FMT_UNKNOWN =3D 0,=0A+=0A+=09V=
IRTIO_VIDEO_PIX_FMT_H264 =3D 0x100,=0A+=09VIRTIO_VIDEO_PIX_FMT_NV12,=0A+=09=
VIRTIO_VIDEO_PIX_FMT_NV21,=0A+=09VIRTIO_VIDEO_PIX_FMT_I420,=0A+=09VIRTIO_VI=
DEO_PIX_FMT_I422,=0A+=09VIRTIO_VIDEO_PIX_FMT_XBGR,=0A+=09VIRTIO_VIDEO_PIX_F=
MT_H265,=0A+=09VIRTIO_VIDEO_PIX_FMT_MPEG4,=0A+=09VIRTIO_VIDEO_PIX_FMT_MPEG2=
,=0A+};=0A+=0A+enum virtio_video_profile_type {=0A+=09VIRTIO_MPEG_VIDEO_H26=
4_PROFILE_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_BASELIN=
E=09=3D 0x100,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE,=
=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_MAIN,=0A+=09VIRTIO_MPEG_VIDEO_H264_PR=
OFILE_EXTENDED,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH,=0A+=09VIRTIO_MPE=
G_VIDEO_H264_PROFILE_HIGH_10,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_422=
,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE,=0A+=09VIRTIO_MP=
EG_VIDEO_H264_PROFILE_HIGH_10_INTRA,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_H=
IGH_422_INTRA,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA,=0A+=09V=
IRTIO_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA,=0A+=09VIRTIO_MPEG_VIDEO_H264=
_PROFILE_SCALABLE_BASELINE,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_SCALABLE_H=
IGH,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA,=0A+=09VIRTIO=
_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH,=0A+=09VIRTIO_MPEG_VIDEO_H264_PROFILE_=
MULTIVIEW_HIGH,=0A+};=0A+=0A+enum virtio_video_level_type {=0A+=09VIRTIO_MP=
EG_VIDEO_H264_LEVEL_UNDEFINED =3D 0,=0A+=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL=
_1_0 =3D 0x100,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_1B,=0A+=09VIRTIO_MPEG_VI=
DEO_H264_LEVEL_1_1,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_1_2,=0A+=09VIRTIO_MP=
EG_VIDEO_H264_LEVEL_1_3,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_2_0,=0A+=09VIRT=
IO_MPEG_VIDEO_H264_LEVEL_2_1,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_2_2,=0A+=
=09VIRTIO_MPEG_VIDEO_H264_LEVEL_3_0,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_3_1=
,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_3_2,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVE=
L_4_0,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_4_1,=0A+=09VIRTIO_MPEG_VIDEO_H264=
_LEVEL_4_2,=0A+=09VIRTIO_MPEG_VIDEO_H264_LEVEL_5_0,=0A+=09VIRTIO_MPEG_VIDEO=
_H264_LEVEL_5_1,=0A+};=0A+=0A+#endif /* _UAPI_VIRTIO_VIDEO_H */=0A--=20=0A2=
.24.0=0A=0A=0A________________________________________=0AFrom: Dmitry Sepp=
=0ASent: Thursday, December 05, 2019 17:11=0ATo: linux-media@vger.kernel.or=
g=0ACc: virtio-dev@lists.oasis-open.org; kraxel@redhat.com; tfiga@chromium.=
org; keiichiw@chromium.org; acourbot@chromium.org; hverkuil@xs4all.nl; posc=
iak@chromium.org; marcheu@chromium.org; stevensd@chromium.org; dgreid@chrom=
ium.org; daniel@ffwll.ch; egranata@google.com=0ASubject: [RFC] virtio video=
 driver=0A=0AHello,=0A=0AMy apologies for the long delay. The driver code i=
s now available and provided=0Aas a follow-up to the discussion from this t=
hread [1].=0A=0AThe reference Linux kernel 5.4 driver implementation is loc=
ated here:=0Ahttps://github.com/OpenSynergy/linux/tree/virtio-video-draft-v=
1=0A=0AThe driver is implemented using the V4L2 API. It allocates a v4l2 de=
vice for=0Aeach probed virtio device and then creates a video device for ea=
ch function=0Awithin the respective virtio device. The driver implements th=
e stateful=0Adecoder interface [2] and the stateful encoder interface (WIP)=
 [3].=0A=0AThe DMA SG memory allocator tries to map buffers right away. As =
it is not=0Aalways suitable, and some implementations might need just a phy=
sical address,=0Awe had to introduce a set of simple dma ops directly in th=
e driver.=0A=0AThe driver is in the RFC state and currently a bit ahead of =
the spec that was=0Aproposed in the discussion mentioned above. On the othe=
r hand, the driver=0Aunfortunately does not yet include changes proposed in=
 the recent comments=0A[4]. The driver currently supports encoder and decod=
er functions. Also, it=0Adoes not fully pass the v4l2-compliance yet, it ha=
s been a bit out of the=0Afocus so far.=0A=0AAny feedback and contribution =
would be greatly appreciated.=0A=0A[1] https://markmail.org/message/gc6h25a=
cct22niut=0A[2] https://www.kernel.org/doc/html/v5.4/media/uapi/v4l/dev-dec=
oder.html=0A[3] https://hverkuil.home.xs4all.nl/codec-api/uapi/v4l/dev-enco=
der.html=0A[4] https://markmail.org/message/yy67elx2adbivdsp=0A=0ABest rega=
rds,=0ADmitry.=0A

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

