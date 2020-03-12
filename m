Return-Path: virtio-dev-return-6939-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFA46985FDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Mar 2020 10:16:04 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 12 Mar 2020 11:15:52 +0100
Message-ID: <20719772.EfDdHjke4D@os-lin-dmo>
In-Reply-To: <d79df162-5fcc-6ff9-8480-4cff3548bb4a@xs4all.nl>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <20200218202753.652093-2-dmitry.sepp@opensynergy.com> <d79df162-5fcc-6ff9-8480-4cff3548bb4a@xs4all.nl>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc: virtio-dev@lists.oasis-open.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Hans,

Thank you for your great detailed review!

I won't provide inline answers as your comments totally make sense. There i=
s=20
only one thing I want to mention:

> > +=09struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES];
>=20
> Why is this virtio specific? Any reason for not using VIDEO_MAX_PLANES?

I'd say this is because VIDEO_MAX_PLANES does not exist outside of the Linu=
x=20
OS, so for whatever other system we need a virtio specific definition.

Best regards,
Dmitry.

On Mittwoch, 11. M=E4rz 2020 14:23:14 CET Hans Verkuil wrote:
> Hi Dmitry,
>=20
> Here is a quick review of this code:
>=20
> On 2/18/20 9:27 PM, Dmitry Sepp wrote:
> > This adds a Virtio based video driver for video streaming device that
> > operates input and output data buffers to share video devices with
> > several guests. The current implementation consist of V4L2 based video
> > driver supporting video functions of decoder and encoder. The device
> > uses command structures to advertise and negotiate stream formats and
> > controls. This allows the driver to modify the processing logic of the
> > device on a per stream basis.
> >=20
> > Signed-off-by: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> > Signed-off-by: Kiran Pawar <Kiran.Pawar@opensynergy.com>
> > Signed-off-by: Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
> > Signed-off-by: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>
> > ---
> >=20
> >  drivers/media/Kconfig                       |    1 +
> >  drivers/media/Makefile                      |    2 +
> >  drivers/media/virtio/Kconfig                |   12 +
> >  drivers/media/virtio/Makefile               |   12 +
> >  drivers/media/virtio/virtio_video.h         |  402 +++++++
> >  drivers/media/virtio/virtio_video_caps.c    |  498 +++++++++
> >  drivers/media/virtio/virtio_video_dec.c     |  427 ++++++++
> >  drivers/media/virtio/virtio_video_dec.h     |   30 +
> >  drivers/media/virtio/virtio_video_device.c  | 1079 +++++++++++++++++++
> >  drivers/media/virtio/virtio_video_driver.c  |  315 ++++++
> >  drivers/media/virtio/virtio_video_enc.c     |  569 ++++++++++
> >  drivers/media/virtio/virtio_video_enc.h     |   30 +
> >  drivers/media/virtio/virtio_video_helpers.c |  250 +++++
> >  drivers/media/virtio/virtio_video_vq.c      | 1012 +++++++++++++++++
> >  include/uapi/linux/virtio_ids.h             |    2 +
> >  include/uapi/linux/virtio_video.h           |  469 ++++++++
> >  16 files changed, 5110 insertions(+)
> >  create mode 100644 drivers/media/virtio/Kconfig
> >  create mode 100644 drivers/media/virtio/Makefile
> >  create mode 100644 drivers/media/virtio/virtio_video.h
> >  create mode 100644 drivers/media/virtio/virtio_video_caps.c
> >  create mode 100644 drivers/media/virtio/virtio_video_dec.c
> >  create mode 100644 drivers/media/virtio/virtio_video_dec.h
> >  create mode 100644 drivers/media/virtio/virtio_video_device.c
> >  create mode 100644 drivers/media/virtio/virtio_video_driver.c
> >  create mode 100644 drivers/media/virtio/virtio_video_enc.c
> >  create mode 100644 drivers/media/virtio/virtio_video_enc.h
> >  create mode 100644 drivers/media/virtio/virtio_video_helpers.c
> >  create mode 100644 drivers/media/virtio/virtio_video_vq.c
> >  create mode 100644 include/uapi/linux/virtio_video.h
> >=20
> > diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> > index 092e7509af9b..b89169e5d24d 100644
> > --- a/drivers/media/Kconfig
> > +++ b/drivers/media/Kconfig
> > @@ -205,6 +205,7 @@ source "drivers/media/pci/Kconfig"
> >=20
> >  source "drivers/media/platform/Kconfig"
> >  source "drivers/media/mmc/Kconfig"
> >  source "drivers/media/radio/Kconfig"
> >=20
> > +source "drivers/media/virtio/Kconfig"
> >=20
> >  comment "Supported FireWire (IEEE 1394) Adapters"
> > =20
> >  =09depends on DVB_CORE && FIREWIRE
> >=20
> > diff --git a/drivers/media/Makefile b/drivers/media/Makefile
> > index 4a330d0e5e40..1d886730bafd 100644
> > --- a/drivers/media/Makefile
> > +++ b/drivers/media/Makefile
> > @@ -34,6 +34,8 @@ obj-y +=3D rc/
> >=20
> >  obj-$(CONFIG_CEC_CORE) +=3D cec/
> >=20
> > +obj-$(CONFIG_VIRTIO_VIDEO)  +=3D virtio/
> > +
> >=20
> >  #
> >  # Finally, merge the drivers that require the core
> >  #
> >=20
> > diff --git a/drivers/media/virtio/Kconfig b/drivers/media/virtio/Kconfi=
g
> > new file mode 100644
> > index 000000000000..82012178254d
> > --- /dev/null
> > +++ b/drivers/media/virtio/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Video driver for virtio
> > +
> > +config VIRTIO_VIDEO
> > +=09tristate "Virtio video V4L2 driver"
> > +=09depends on VIRTIO && VIDEO_DEV && VIDEO_V4L2
> > +=09select VIDEOBUF2_DMA_SG
> > +=09select VIDEOBUF2_DMA_CONTIG
> > +=09select V4L2_MEM2MEM_DEV
> > +=09help
> > +          This is the virtual video driver for virtio.
> > +          Say Y or M.
> > diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makef=
ile
> > new file mode 100644
> > index 000000000000..b17dce4cfc19
> > --- /dev/null
> > +++ b/drivers/media/virtio/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +obj-$(CONFIG_VIRTIO_VIDEO) +=3D virtio-video.o
> > +
> > +virtio-video-objs :=3D \
> > +    virtio_video_driver.o \
> > +    virtio_video_device.o \
> > +    virtio_video_vq.o \
> > +    virtio_video_dec.o \
> > +    virtio_video_enc.o \
> > +    virtio_video_caps.o \
> > +    virtio_video_helpers.o
> > diff --git a/drivers/media/virtio/virtio_video.h
> > b/drivers/media/virtio/virtio_video.h new file mode 100644
> > index 000000000000..c5a5704326c0
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video.h
> > @@ -0,0 +1,402 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* Common header for virtio video driver.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
>=20
> You are using SPDX, so there is no need for this license.
>=20
> Please check your patch with checkpatch.pl --strict!
>=20
> > + */
> > +
> > +#ifndef _VIRTIO_VIDEO_H
> > +#define _VIRTIO_VIDEO_H
> > +
> > +#include <linux/virtio.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_config.h>
> > +#include <linux/virtio_video.h>
> > +#include <linux/list.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-mem2mem.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/videobuf2-dma-sg.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +
> > +#define DRIVER_NAME "virtio-video"
> > +
> > +#define MIN_BUFS_MIN 0
> > +#define MIN_BUFS_MAX 32
>=20
> Why not use VIDEO_MAX_FRAME instead of 32? Is there any reason why you wo=
uld
> want something else?
>=20
> > +#define MIN_BUFS_STEP 1
> > +#define MIN_BUFS_DEF 1
> > +
> > +enum virtio_video_device_type {
> > +=09VIRTIO_VIDEO_DEVICE_ENCODER =3D 0x0100,
> > +=09VIRTIO_VIDEO_DEVICE_DECODER,
> > +};
> > +
> > +struct video_format_frame {
> > +=09struct virtio_video_format_frame frame;
> > +=09struct virtio_video_format_range *frame_rates;
> > +};
> > +
> > +struct video_format {
> > +=09struct list_head formats_list_entry;
> > +=09struct virtio_video_format_desc desc;
> > +=09struct video_format_frame *frames;
> > +};
> > +
> > +struct video_control_fmt_data {
> > +=09uint32_t min;
> > +=09uint32_t max;
> > +=09uint32_t num;
> > +=09uint32_t skip_mask;
> > +=09uint32_t *entries;
> > +};
> > +
> > +struct video_control_format {
> > +=09struct list_head controls_list_entry;
> > +=09uint32_t format;
> > +=09struct video_control_fmt_data *profile;
> > +=09struct video_control_fmt_data *level;
> > +};
> > +
> > +struct video_plane_format {
> > +=09uint32_t plane_size;
> > +=09uint32_t stride;
> > +};
> > +
> > +struct video_format_info {
> > +=09uint32_t fourcc_format;
> > +=09uint32_t frame_rate;
> > +=09uint32_t frame_width;
> > +=09uint32_t frame_height;
> > +=09uint32_t min_buffers;
> > +=09uint32_t max_buffers;
> > +=09struct virtio_video_crop crop;
> > +=09uint32_t num_planes;
> > +=09struct video_plane_format plane_format[VIRTIO_VIDEO_MAX_PLANES];
>=20
> Why is this virtio specific? Any reason for not using VIDEO_MAX_PLANES?
>=20
> > +=09bool is_updated;
> > +};
> > +
> > +struct video_control_info {
> > +=09uint32_t profile;
> > +=09uint32_t level;
> > +=09uint32_t bitrate;
> > +=09bool is_updated;
> > +};
> > +
> > +struct virtio_video;
> > +struct virtio_video_vbuffer;
> > +
> > +typedef void (*virtio_video_resp_cb)(struct virtio_video *vv,
> > +=09=09=09=09     struct virtio_video_vbuffer=20
*vbuf);
> > +
> > +struct virtio_video_vbuffer {
> > +=09char *buf;
> > +=09int size;
> > +
> > +=09void *data_buf;
> > +=09uint32_t data_size;
> > +
> > +=09char *resp_buf;
> > +=09int resp_size;
> > +
> > +=09void *priv;
> > +=09virtio_video_resp_cb resp_cb;
> > +
> > +=09struct list_head list;
> > +};
> > +
> > +struct virtio_video_queue {
> > +=09struct virtqueue *vq;
> > +=09spinlock_t qlock;
> > +=09wait_queue_head_t ack_queue;
> > +=09struct work_struct dequeue_work;
> > +};
> > +
> > +struct virtio_video {
> > +=09struct v4l2_device v4l2_dev;
> > +=09int instance;
> > +
> > +=09struct virtio_device *vdev;
> > +=09struct virtio_video_queue commandq;
> > +=09struct virtio_video_queue eventq;
> > +=09wait_queue_head_t wq;
> > +=09bool vq_ready;
> > +
> > +=09struct kmem_cache *vbufs;
> > +
> > +=09struct idr resource_idr;
> > +=09spinlock_t resource_idr_lock;
> > +=09struct idr stream_idr;
> > +=09spinlock_t stream_idr_lock;
> > +
> > +=09uint32_t max_caps_len;
> > +=09uint32_t max_resp_len;
> > +=09bool got_caps;
> > +=09bool got_control;
> > +
> > +=09bool has_iommu;
> > +=09bool supp_non_contig;
> > +=09struct list_head devices_list;
> > +
> > +=09int debug;
> > +=09int use_dma_mem;
> > +};
> > +
> > +struct virtio_video_device {
> > +=09struct virtio_video *vv;
> > +=09struct video_device video_dev;
> > +=09struct mutex video_dev_mutex;
> > +
> > +=09struct v4l2_m2m_dev *m2m_dev;
> > +
> > +=09struct workqueue_struct *workqueue;
> > +
> > +=09struct list_head devices_list_entry;
> > +=09/* VIRTIO_VIDEO_FUNC_ */
> > +=09uint32_t type;
> > +
> > +=09uint32_t num_input_fmts;
> > +=09struct list_head input_fmt_list;
> > +
> > +=09uint32_t num_output_fmts;
> > +=09struct list_head output_fmt_list;
> > +
> > +=09struct list_head controls_fmt_list;
> > +};
> > +
> > +enum video_stream_state {
> > +=09STREAM_STATE_IDLE =3D 0,
> > +=09STREAM_STATE_INIT,
> > +=09STREAM_STATE_METADATA, /* specific to decoder */
> > +=09STREAM_STATE_RUNNING,
> > +=09STREAM_STATE_DRAIN,
> > +=09STREAM_STATE_STOPPED,
> > +=09STREAM_STATE_RESET, /* specific to encoder */
> > +};
> > +
> > +struct virtio_video_stream {
> > +=09uint32_t stream_id;
> > +=09enum video_stream_state state;
> > +=09struct video_device *video_dev;
> > +=09struct v4l2_fh fh;
> > +=09struct mutex vq_mutex;
> > +=09struct v4l2_ctrl_handler ctrl_handler;
> > +=09struct video_format_info in_info;
> > +=09struct video_format_info out_info;
> > +=09struct video_control_info control;
> > +=09bool src_cleared;
> > +=09bool dst_cleared;
> > +=09bool src_destroyed;
> > +=09bool dst_destroyed;
> > +=09struct work_struct work;
> > +=09struct video_format_frame *current_frame;
> > +};
> > +
> > +struct virtio_video_buffer {
> > +=09struct v4l2_m2m_buffer v4l2_m2m_vb;
> > +=09uint32_t resource_id;
> > +=09bool queued;
> > +};
> > +
> > +static inline gfp_t
> > +virtio_video_gfp_flags(struct virtio_video *vv)
> > +{
> > +=09if (vv->use_dma_mem)
> > +=09=09return GFP_DMA;
>=20
> GFP_DMA? That's unusual. I'd expect GFP_DMA32. All V4L2 drivers use that.
>=20
> > +=09else
> > +=09=09return 0;
> > +}
> > +
> > +static inline const struct vb2_mem_ops *
> > +virtio_video_mem_ops(struct virtio_video *vv)
> > +{
> > +=09if (vv->supp_non_contig)
> > +=09=09return &vb2_dma_sg_memops;
> > +=09else
> > +=09=09return &vb2_dma_contig_memops;
> > +}
> > +
> > +static inline struct virtio_video_device *
> > +to_virtio_vd(struct video_device *video_dev)
> > +{
> > +=09return container_of(video_dev, struct virtio_video_device,
> > +=09=09=09 video_dev);
> > +}
> > +
> > +static inline struct virtio_video_stream *file2stream(struct file *fil=
e)
> > +{
> > +=09return container_of(file->private_data, struct virtio_video_stream,=
=20
fh);
> > +}
> > +
> > +static inline struct virtio_video_stream *ctrl2stream(struct v4l2_ctrl
> > *ctrl) +{
> > +=09return container_of(ctrl->handler, struct virtio_video_stream,
> > +=09=09=09    ctrl_handler);
> > +}
> > +
> > +static inline struct virtio_video_stream *work2stream(struct work_stru=
ct
> > *work) +{
> > +=09return container_of(work, struct virtio_video_stream, work);
> > +}
> > +
> > +static inline struct virtio_video_buffer *to_virtio_vb(struct vb2_buff=
er
> > *vb) +{
> > +=09struct vb2_v4l2_buffer *v4l2_vb =3D to_vb2_v4l2_buffer(vb);
> > +
> > +=09return container_of(v4l2_vb, struct virtio_video_buffer,
> > +=09=09=09    v4l2_m2m_vb.vb);
> > +}
> > +
> > +static inline uint32_t to_virtio_queue_type(enum v4l2_buf_type type)
> > +{
> > +=09if (V4L2_TYPE_IS_OUTPUT(type))
> > +=09=09return VIRTIO_VIDEO_QUEUE_TYPE_INPUT;
> > +=09else
> > +=09=09return VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT;
> > +}
> > +
> > +static inline bool within_range(uint32_t min, uint32_t val, uint32_t m=
ax)
> > +{
> > +=09return ((val - min) <=3D (max - min));
> > +}
> > +
> > +static inline bool needs_alignment(uint32_t val, uint32_t a)
> > +{
> > +=09if (a =3D=3D 0 || IS_ALIGNED(val, a))
> > +=09=09return false;
> > +
> > +=09return true;
> > +}
> > +
> > +int virtio_video_alloc_vbufs(struct virtio_video *vv);
> > +void virtio_video_free_vbufs(struct virtio_video *vv);
> > +int virtio_video_alloc_events(struct virtio_video *vv, size_t num);
> > +
> > +int virtio_video_device_init(struct virtio_video *vv, void *input_buf,
> > +=09=09=09     void *output_buf);
> > +void virtio_video_device_deinit(struct virtio_video *vv);
> > +
> > +void virtio_video_stream_id_get(struct virtio_video *vv,
> > +=09=09=09=09struct virtio_video_stream=20
*stream,
> > +=09=09=09=09uint32_t *id);
> > +void virtio_video_stream_id_put(struct virtio_video *vv, uint32_t id);
> > +void virtio_video_resource_id_get(struct virtio_video *vv, uint32_t *i=
d);
> > +void virtio_video_resource_id_put(struct virtio_video *vv, uint32_t id=
);
> > +
> > +int virtio_video_cmd_stream_create(struct virtio_video *vv, uint32_t
> > stream_id, +=09=09=09=09   enum=20
virtio_video_format format,
> > +=09=09=09=09   const char *tag);
> > +int virtio_video_cmd_stream_destroy(struct virtio_video *vv,
> > +=09=09=09=09    uint32_t stream_id);
> > +int virtio_video_cmd_stream_drain(struct virtio_video *vv, uint32_t
> > stream_id); +int virtio_video_cmd_resource_create(struct virtio_video
> > *vv,
> > +=09=09=09=09     uint32_t stream_id, uint32_t=20
resource_id,
> > +=09=09=09=09     uint32_t queue_type,
> > +=09=09=09=09     struct=20
virtio_video_mem_entry *ents,
> > +=09=09=09=09    unsigned int num_planes,
> > +=09=09=09=09     unsigned int *num_entry);
> > +int virtio_video_cmd_resource_destroy_all(struct virtio_video *vv,
> > +=09=09=09=09=09  struct=20
virtio_video_stream *stream,
> > +=09=09=09=09=09  uint32_t=20
queue_type);
> > +int virtio_video_cmd_resource_queue(struct virtio_video *vv, uint32_t
> > stream_id, +=09=09=09=09    struct=20
virtio_video_buffer *virtio_vb,
> > +=09=09=09=09    uint32_t data_size[], uint8_t=20
num_data_size,
> > +=09=09=09=09    uint32_t queue_type);
> > +int virtio_video_cmd_queue_clear(struct virtio_video *vv,
> > +=09=09=09=09 struct virtio_video_stream=20
*stream,
> > +=09=09=09=09 uint32_t queue_type);
> > +int virtio_video_query_capability(struct virtio_video *vv, void
> > *resp_buf,
> > +=09=09=09=09  size_t resp_size, uint32_t=20
queue_type);
> > +int virtio_video_query_control_profile(struct virtio_video *vv, void
> > *resp_buf, +=09=09=09=09       size_t=20
resp_size, uint32_t format);
> > +int virtio_video_query_control_level(struct virtio_video *vv, void
> > *resp_buf, +=09=09=09=09     size_t=20
resp_size, uint32_t format);
> > +int virtio_video_cmd_set_params(struct virtio_video *vv,
> > +=09=09=09=09struct virtio_video_stream=20
*stream,
> > +=09=09=09=09struct video_format_info=20
*format_info,
> > +=09=09=09=09uint32_t queue_type);
> > +int virtio_video_cmd_get_params(struct virtio_video *vv,
> > +=09=09=09=09struct virtio_video_stream=20
*stream,
> > +=09=09=09=09uint32_t queue_type);
> > +int virtio_video_cmd_set_control(struct virtio_video *vv,
> > +=09=09=09=09 uint32_t stream_id,
> > +=09=09=09=09 uint32_t control, uint32_t val);
> > +int virtio_video_cmd_get_control(struct virtio_video *vv,
> > +=09=09=09=09 struct virtio_video_stream=20
*stream,
> > +=09=09=09=09 uint32_t ctrl);
> > +
> > +void virtio_video_queue_res_chg_event(struct virtio_video_stream
> > *stream);
> > +void virtio_video_queue_eos_event(struct virtio_video_stream *stream);
> > +void virtio_video_cmd_ack(struct virtqueue *vq);
> > +void virtio_video_event_ack(struct virtqueue *vq);
> > +void virtio_video_dequeue_cmd_func(struct work_struct *work);
> > +void virtio_video_dequeue_event_func(struct work_struct *work);
> > +void virtio_video_buf_done(struct virtio_video_buffer *virtio_vb,
> > +=09=09=09   uint32_t flags, uint64_t timestamp,=20
uint32_t size);
> > +int virtio_video_buf_plane_init(uint32_t idx, uint32_t resource_id,
> > +=09=09=09=09struct virtio_video_device *vvd,
> > +=09=09=09=09struct virtio_video_stream=20
*stream,
> > +=09=09=09=09struct vb2_buffer *vb);
> > +void virtio_video_mark_drain_complete(struct virtio_video_stream *stre=
am,
> > +=09=09=09=09      struct vb2_v4l2_buffer=20
*v4l2_vb);
> > +
> > +int virtio_video_queue_setup(struct vb2_queue *vq, unsigned int
> > *num_buffers, +=09=09=09     unsigned int *num_planes,=20
unsigned int sizes[],
> > +=09=09=09     struct device *alloc_devs[]);
> > +int virtio_video_buf_init(struct vb2_buffer *vb);
> > +void virtio_video_buf_cleanup(struct vb2_buffer *vb);
> > +int virtio_video_querycap(struct file *file, void *fh,
> > +=09=09=09  struct v4l2_capability *cap);
> > +int virtio_video_enum_framesizes(struct file *file, void *fh,
> > +=09=09=09=09 struct v4l2_frmsizeenum *f);
> > +int virtio_video_enum_framemintervals(struct file *file, void *fh,
> > +=09=09=09=09      struct v4l2_frmivalenum=20
*f);
> > +int virtio_video_g_fmt(struct file *file, void *fh, struct v4l2_format
> > *f); +int virtio_video_s_fmt(struct file *file, void *fh, struct
> > v4l2_format *f); +int virtio_video_try_fmt(struct virtio_video_stream
> > *stream,
> > +=09=09=09 struct v4l2_format *f);
> > +int virtio_video_reqbufs(struct file *file, void *priv,
> > +=09=09=09 struct v4l2_requestbuffers *rb);
> > +int virtio_video_subscribe_event(struct v4l2_fh *fh,
> > +=09=09=09=09 const struct=20
v4l2_event_subscription *sub);
> > +
> > +void virtio_video_free_caps_list(struct list_head *caps_list);
> > +int virtio_video_parse_virtio_capability(struct virtio_video_device *v=
vd,
> > +=09=09=09=09=09  void *input_buf,=20
void *output_buf);
> > +void virtio_video_clean_capability(struct virtio_video_device *vvd);
> > +int virtio_video_parse_virtio_control(struct virtio_video_device *vvd)=
;
> > +void virtio_video_clean_control(struct virtio_video_device *vvd);
> > +
> > +uint32_t virtio_video_format_to_v4l2(uint32_t format);
> > +uint32_t virtio_video_control_to_v4l2(uint32_t control);
> > +uint32_t virtio_video_profile_to_v4l2(uint32_t profile);
> > +uint32_t virtio_video_level_to_v4l2(uint32_t level);
> > +uint32_t virtio_video_v4l2_format_to_virtio(uint32_t v4l2_format);
> > +uint32_t virtio_video_v4l2_control_to_virtio(uint32_t v4l2_control);
> > +uint32_t virtio_video_v4l2_profile_to_virtio(uint32_t v4l2_profile);
> > +uint32_t virtio_video_v4l2_level_to_virtio(uint32_t v4l2_level);
> > +
> > +struct video_format *find_video_format(struct list_head *fmts_list,
> > +=09=09=09=09       uint32_t fourcc);
> > +void virtio_video_format_from_info(struct video_format_info *info,
> > +=09=09=09=09   struct v4l2_pix_format_mplane=20
*pix_mp);
> > +void virtio_video_format_fill_default_info(struct video_format_info
> > *dst_info, +=09=09=09=09=09   struct=20
video_format_info *src_info);
> > +
> > +int virtio_video_g_selection(struct file *file, void *fh,
> > +=09=09=09     struct v4l2_selection *sel);
> > +int virtio_video_s_selection(struct file *file, void *fh,
> > +=09=09=09     struct v4l2_selection *sel);
> > +
> > +#endif /* _VIRTIO_VIDEO_H */
> > diff --git a/drivers/media/virtio/virtio_video_caps.c
> > b/drivers/media/virtio/virtio_video_caps.c new file mode 100644
> > index 000000000000..2f9d4da92810
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_caps.c
> > @@ -0,0 +1,498 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/videobuf2-dma-sg.h>
> > +
> > +#include "virtio_video.h"
> > +
> > +static void virtio_video_free_frame_rates(struct video_format_frame
> > *frame) +{
> > +=09if (!frame)
> > +=09=09return;
> > +
> > +=09kfree(frame->frame_rates);
> > +}
> > +
> > +static void virtio_video_free_frames(struct video_format *fmt)
> > +{
> > +=09size_t idx =3D 0;
> > +
> > +=09if (!fmt)
> > +=09=09return;
> > +
> > +=09for (idx =3D 0; idx < fmt->desc.num_frames; idx++)
> > +=09=09virtio_video_free_frame_rates(&fmt->frames[idx]);
> > +=09kfree(fmt->frames);
> > +}
> > +
> > +static void virtio_video_free_fmt(struct list_head *fmts_list)
> > +{
> > +=09struct video_format *fmt =3D NULL;
> > +=09struct video_format *tmp =3D NULL;
> > +
> > +=09list_for_each_entry_safe(fmt, tmp, fmts_list, formats_list_entry)=
=20
{
> > +=09=09list_del(&fmt->formats_list_entry);
> > +=09=09virtio_video_free_frames(fmt);
> > +=09=09kfree(fmt);
> > +=09}
> > +}
> > +
> > +static void virtio_video_free_fmts(struct virtio_video_device *vvd)
> > +{
> > +=09virtio_video_free_fmt(&vvd->input_fmt_list);
> > +=09virtio_video_free_fmt(&vvd->output_fmt_list);
> > +}
> > +
> > +static void assign_format_range(struct virtio_video_format_range
> > *d_range,
> > +=09=09=09=09struct virtio_video_format_range=20
*s_range)
> > +{
> > +=09d_range->min =3D le32_to_cpu(s_range->min);
> > +=09d_range->max =3D le32_to_cpu(s_range->max);
> > +=09d_range->step =3D le32_to_cpu(s_range->step);
> > +}
> > +
> > +static size_t
> > +virtio_video_parse_virtio_frame_rate(struct virtio_video_device *vvd,
> > +=09=09=09=09     struct=20
virtio_video_format_range *f_rate,
> > +=09=09=09=09     void *buf)
> > +{
> > +=09struct virtio_video_format_range *virtio_frame_rate =3D NULL;
> > +=09size_t frame_rate_size =3D sizeof(struct virtio_video_format_range)=
;
> > +
> > +=09if (!f_rate || !buf || !vvd)
> > +=09=09return 0;
> > +
> > +=09virtio_frame_rate =3D buf;
> > +=09assign_format_range(f_rate, virtio_frame_rate);
> > +=09return frame_rate_size;
> > +}
> > +
> > +static size_t virtio_video_parse_virtio_frame(struct virtio_video_devi=
ce
> > *vvd, +=09=09=09=09=09      struct=20
video_format_frame *frm,
> > +=09=09=09=09=09      void *buf)
> > +{
> > +=09struct virtio_video *vv =3D NULL;
> > +=09struct virtio_video_format_frame *virtio_frame =3D NULL;
> > +=09struct virtio_video_format_frame *frame =3D &frm->frame;
> > +=09struct virtio_video_format_range *rate =3D NULL;
> > +=09size_t idx, offset =3D 0;
> > +=09size_t extra_size =3D 0;
> > +
> > +=09if (!frame || !buf || !vvd)
> > +=09=09return 0;
> > +
> > +=09vv =3D vvd->vv;
> > +=09virtio_frame =3D buf;
> > +
> > +=09assign_format_range(&frame->width, &virtio_frame->width);
> > +=09assign_format_range(&frame->height, &virtio_frame->height);
> > +
> > +=09frame->num_rates =3D le32_to_cpu(virtio_frame->num_rates);
> > +=09frm->frame_rates =3D  kcalloc(frame->num_rates,
> > +=09=09=09=09    sizeof(struct=20
virtio_video_format_range),
> > +=09=09=09=09    GFP_KERNEL);
> > +
> > +=09offset =3D sizeof(struct virtio_video_format_frame);
> > +=09for (idx =3D 0; idx < frame->num_rates; idx++) {
> > +=09=09rate =3D &frm->frame_rates[idx];
> > +=09=09extra_size =3D
> > +=09=09=09virtio_video_parse_virtio_frame_rate(vvd,=20
rate,
> > +=09=09=09=09=09=09=09    =20
buf + offset);
> > +=09=09if (extra_size =3D=3D 0) {
> > +=09=09=09kfree(frm->frame_rates);
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse=20
frame rate\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09offset +=3D extra_size;
> > +=09}
> > +
> > +=09return offset;
> > +}
> > +
> > +static size_t virtio_video_parse_virtio_fmt(struct virtio_video_device
> > *vvd, +=09=09=09=09=09    struct=20
video_format *fmt, void *buf)
> > +{
> > +=09struct virtio_video *vv =3D NULL;
> > +=09struct virtio_video_format_desc *virtio_fmt_desc =3D NULL;
> > +=09struct virtio_video_format_desc *fmt_desc =3D NULL;
> > +=09struct video_format_frame *frame =3D NULL;
> > +=09size_t idx, offset =3D 0;
> > +=09size_t extra_size =3D 0;
> > +
> > +=09if (!fmt || !buf || !vvd)
> > +=09=09return 0;
> > +
> > +=09vv =3D vvd->vv;
> > +=09virtio_fmt_desc =3D buf;
> > +=09fmt_desc =3D &fmt->desc;
> > +
> > +=09fmt_desc->format =3D
> > +=09=09virtio_video_format_to_v4l2
> > +=09=09(le32_to_cpu(virtio_fmt_desc->format));
> > +=09fmt_desc->mask =3D le64_to_cpu(virtio_fmt_desc->mask);
> > +=09fmt_desc->planes_layout =3D le32_to_cpu(virtio_fmt_desc-
>planes_layout);
> > +
> > +=09fmt_desc->num_frames =3D le32_to_cpu(virtio_fmt_desc->num_frames);
> > +=09fmt->frames =3D kcalloc(fmt_desc->num_frames,
> > +=09=09=09      sizeof(struct video_format_frame),
> > +=09=09=09      GFP_KERNEL);
> > +
> > +=09offset =3D sizeof(struct virtio_video_format_desc);
> > +=09for (idx =3D 0; idx < fmt_desc->num_frames; idx++) {
> > +=09=09frame =3D &fmt->frames[idx];
> > +=09=09extra_size =3D
> > +=09=09=09virtio_video_parse_virtio_frame(vvd, frame,
> > +=09=09=09=09=09=09=09
buf + offset);
> > +=09=09if (extra_size =3D=3D 0) {
> > +=09=09=09kfree(fmt->frames);
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse=20
frame\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09offset +=3D extra_size;
> > +=09}
> > +
> > +=09return offset;
> > +}
> > +
> > +int virtio_video_parse_virtio_capability(struct virtio_video_device *v=
vd,
> > +=09=09=09=09=09    void *input_buf,=20
void *output_buf)
> > +{
> > +=09struct virtio_video *vv =3D NULL;
> > +=09struct virtio_video_query_capability_resp *input_resp =3D input_buf=
;
> > +=09struct virtio_video_query_capability_resp *output_resp =3D=20
output_buf;
> > +=09int fmt_idx =3D 0;
> > +=09size_t offset =3D 0;
> > +=09struct video_format *fmt =3D NULL;
> > +
> > +=09if (!input_buf || !output_buf || !vvd)
> > +=09=09return -1;
> > +
> > +=09vv =3D vvd->vv;
> > +
> > +=09if (le32_to_cpu(input_resp->num_descs) <=3D 0 ||
> > +=09    le32_to_cpu(output_resp->num_descs) <=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "invalid capability=20
response\n");
> > +=09=09return -1;
> > +=09}
> > +
> > +=09vvd->num_input_fmts =3D le32_to_cpu(input_resp->num_descs);
> > +=09offset =3D sizeof(struct virtio_video_query_capability_resp);
> > +
> > +=09for (fmt_idx =3D 0; fmt_idx < vvd->num_input_fmts; fmt_idx++) {
> > +=09=09size_t fmt_size =3D 0;
> > +
> > +=09=09fmt =3D kzalloc(sizeof(*fmt), GFP_KERNEL);
> > +=09=09if (!fmt) {
> > +=09=09=09virtio_video_free_fmts(vvd);
> > +=09=09=09return -1;
> > +=09=09}
> > +
> > +=09=09fmt_size =3D virtio_video_parse_virtio_fmt(vvd, fmt,
> > +=09=09=09=09=09=09=09=20
input_buf + offset);
> > +=09=09if (fmt_size =3D=3D 0) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse=20
input fmt\n");
> > +=09=09=09virtio_video_free_fmts(vvd);
> > +=09=09=09kfree(fmt);
> > +=09=09=09return -1;
> > +=09=09}
> > +=09=09offset +=3D fmt_size;
> > +=09=09list_add(&fmt->formats_list_entry, &vvd-
>input_fmt_list);
> > +=09}
> > +
> > +=09vvd->num_output_fmts =3D le32_to_cpu(output_resp->num_descs);
> > +=09offset =3D sizeof(struct virtio_video_query_capability_resp);
> > +
> > +=09for (fmt_idx =3D 0; fmt_idx < vvd->num_output_fmts; fmt_idx++) {
> > +=09=09size_t fmt_size =3D 0;
> > +
> > +=09=09fmt =3D kzalloc(sizeof(*fmt), GFP_KERNEL);
> > +=09=09if (!fmt) {
> > +=09=09=09virtio_video_free_fmts(vvd);
> > +=09=09=09return -1;
> > +=09=09}
> > +
> > +=09=09fmt_size =3D virtio_video_parse_virtio_fmt(vvd, fmt,
> > +=09=09=09=09=09=09=09=20
output_buf + offset);
> > +=09=09if (fmt_size =3D=3D 0) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to parse=20
output fmt\n");
> > +=09=09=09virtio_video_free_fmts(vvd);
> > +=09=09=09kfree(fmt);
> > +=09=09=09return -1;
> > +=09=09}
> > +=09=09offset +=3D fmt_size;
> > +=09=09list_add(&fmt->formats_list_entry, &vvd-
>output_fmt_list);
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +void virtio_video_clean_capability(struct virtio_video_device *vvd)
> > +{
> > +=09if (!vvd)
> > +=09=09return;
> > +=09virtio_video_free_fmts(vvd);
> > +}
> > +
> > +static void
> > +virtio_video_free_control_fmt_data(struct video_control_fmt_data *data=
)
> > +{
> > +=09if (!data)
> > +=09=09return;
> > +
> > +=09kfree(data->entries);
> > +=09kfree(data);
> > +}
> > +
> > +static void virtio_video_free_control_formats(struct virtio_video_devi=
ce
> > *vvd) +{
> > +=09struct video_control_format *c_fmt =3D NULL;
> > +=09struct video_control_format *tmp =3D NULL;
> > +
> > +=09list_for_each_entry_safe(c_fmt, tmp, &vvd->controls_fmt_list,
> > +=09=09=09=09 controls_list_entry) {
> > +=09=09list_del(&c_fmt->controls_list_entry);
> > +=09=09virtio_video_free_control_fmt_data(c_fmt->profile);
> > +=09=09virtio_video_free_control_fmt_data(c_fmt->level);
> > +=09=09kfree(c_fmt);
> > +=09}
> > +}
> > +
> > +static int virtio_video_parse_control_levels(struct virtio_video_devic=
e
> > *vvd, +=09=09=09=09=09     struct=20
video_control_format *fmt)
> > +{
> > +=09int idx, ret =3D 0;
> > +=09struct virtio_video_query_control_resp *resp_buf =3D NULL;
> > +=09struct virtio_video_query_control_resp_level *l_resp_buf =3D NULL;
> > +=09struct virtio_video *vv =3D NULL;
> > +=09uint32_t virtio_format, num_levels, mask =3D 0;
> > +=09uint32_t *virtio_levels =3D NULL;
> > +=09struct video_control_fmt_data *level =3D NULL;
> > +=09int max =3D 0, min =3D UINT_MAX;
> > +=09size_t resp_size;
> > +
> > +=09if (!vvd)
> > +=09=09return -EINVAL;
> > +
> > +=09vv =3D vvd->vv;
> > +=09resp_size =3D vv->max_resp_len;
> > +
> > +=09virtio_format =3D virtio_video_v4l2_format_to_virtio(fmt->format);
> > +
> > +=09resp_buf =3D kzalloc(resp_size, GFP_KERNEL);
> > +=09if (IS_ERR(resp_buf)) {
> > +=09=09ret =3D PTR_ERR(resp_buf);
> > +=09=09goto err;
> > +=09}
> > +
> > +=09vv->got_control =3D false;
> > +=09ret =3D virtio_video_query_control_level(vv, resp_buf, resp_size,
> > +=09=09=09=09=09       virtio_format);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to query level\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, vv->got_control, 5 * HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "timed out waiting for query level\n");
> > +=09=09ret =3D -EIO;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D 0;
> > +=09l_resp_buf =3D (void *)((char *)resp_buf + sizeof(*resp_buf));
> > +=09num_levels =3D le32_to_cpu(l_resp_buf->num);
> > +=09if (num_levels =3D=3D 0)
> > +=09=09goto err;
> > +
> > +=09fmt->level =3D kzalloc(sizeof(*level), GFP_KERNEL);
> > +=09if (!fmt->level) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09level =3D fmt->level;
> > +=09level->entries =3D kcalloc(num_levels, sizeof(uint32_t),=20
GFP_KERNEL);
> > +=09if (!level->entries) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09virtio_levels =3D (void *)((char *)l_resp_buf +=20
sizeof(*l_resp_buf));
> > +
> > +=09for (idx =3D 0; idx < num_levels; idx++) {
> > +=09=09level->entries[idx] =3D
> > +=09=09=09virtio_video_level_to_v4l2
> > +=09=09=09(le32_to_cpu(virtio_levels[idx]));
> > +
> > +=09=09mask =3D mask | (1 << level->entries[idx]);
> > +=09=09if (level->entries[idx] > max)
> > +=09=09=09max =3D level->entries[idx];
> > +=09=09if (level->entries[idx] < min)
> > +=09=09=09min =3D level->entries[idx];
> > +=09}
> > +=09level->min =3D min;
> > +=09level->max =3D max;
> > +=09level->num =3D num_levels;
> > +=09level->skip_mask =3D ~mask;
> > +err:
> > +=09kfree(resp_buf);
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_parse_control_profiles(struct virtio_video_dev=
ice
> > *vvd, +=09=09=09=09=09       struct=20
video_control_format *fmt)
> > +{
> > +=09int idx, ret =3D 0;
> > +=09struct virtio_video_query_control_resp *resp_buf =3D NULL;
> > +=09struct virtio_video_query_control_resp_profile *p_resp_buf =3D NULL=
;
> > +=09struct virtio_video *vv =3D NULL;
> > +=09uint32_t virtio_format, num_profiles, mask =3D 0;
> > +=09uint32_t *virtio_profiles =3D NULL;
> > +=09struct video_control_fmt_data *profile =3D NULL;
> > +=09int max =3D 0, min =3D UINT_MAX;
> > +=09size_t resp_size;
> > +
> > +=09if (!vvd)
> > +=09=09return -EINVAL;
> > +
> > +=09vv =3D vvd->vv;
> > +=09resp_size =3D vv->max_resp_len;
> > +=09virtio_format =3D virtio_video_v4l2_format_to_virtio(fmt->format);
> > +=09resp_buf =3D kzalloc(resp_size, GFP_KERNEL);
> > +=09if (IS_ERR(resp_buf)) {
> > +=09=09ret =3D PTR_ERR(resp_buf);
> > +=09=09goto err;
> > +=09}
> > +
> > +=09vv->got_control =3D false;
> > +=09ret =3D virtio_video_query_control_profile(vv, resp_buf, resp_size,
> > +=09=09=09=09=09=09=20
virtio_format);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to query profile\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, vv->got_control, 5 * HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "timed out waiting for query profile\n");
> > +=09=09ret =3D -EIO;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D 0;
> > +=09p_resp_buf =3D (void *)((char *)resp_buf + sizeof(*resp_buf));
> > +=09num_profiles =3D le32_to_cpu(p_resp_buf->num);
> > +=09if (num_profiles =3D=3D 0)
> > +=09=09goto err;
> > +
> > +=09fmt->profile =3D kzalloc(sizeof(*profile), GFP_KERNEL);
> > +=09if (!fmt->profile) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09profile =3D fmt->profile;
> > +=09profile->entries =3D kcalloc(num_profiles, sizeof(uint32_t),=20
GFP_KERNEL);
> > +=09if (!profile->entries) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09virtio_profiles =3D (void *)((char *)p_resp_buf +=20
sizeof(*p_resp_buf));
> > +
> > +=09for (idx =3D 0; idx < num_profiles; idx++) {
> > +=09=09profile->entries[idx] =3D
> > +=09=09=09virtio_video_profile_to_v4l2
> > +=09=09=09(le32_to_cpu(virtio_profiles[idx]));
> > +
> > +=09=09mask =3D mask | (1 << profile->entries[idx]);
> > +=09=09if (profile->entries[idx] > max)
> > +=09=09=09max =3D profile->entries[idx];
> > +=09=09if (profile->entries[idx] < min)
> > +=09=09=09min =3D profile->entries[idx];
> > +=09}
> > +=09profile->min =3D min;
> > +=09profile->max =3D max;
> > +=09profile->num =3D num_profiles;
> > +=09profile->skip_mask =3D ~mask;
> > +err:
> > +=09kfree(resp_buf);
> > +=09return ret;
> > +}
> > +
> > +int virtio_video_parse_virtio_control(struct virtio_video_device *vvd)
> > +{
> > +=09struct video_format *fmt =3D NULL;
> > +=09struct video_control_format *c_fmt =3D NULL;
> > +=09struct virtio_video *vv =3D NULL;
> > +=09uint32_t virtio_format;
> > +=09int ret =3D 0;
> > +
> > +=09if (!vvd)
> > +=09=09return -EINVAL;
> > +
> > +=09vv =3D vvd->vv;
> > +
> > +=09list_for_each_entry(fmt, &vvd->output_fmt_list,=20
formats_list_entry) {
> > +=09=09virtio_format =3D
> > +=09=09=09virtio_video_v4l2_format_to_virtio(fmt-
>desc.format);
> > +=09=09if (virtio_format < VIRTIO_VIDEO_FORMAT_CODED_MIN ||
> > +=09=09    virtio_format > VIRTIO_VIDEO_FORMAT_CODED_MAX)
> > +=09=09=09continue;
> > +
> > +=09=09c_fmt =3D kzalloc(sizeof(*c_fmt), GFP_KERNEL);
> > +=09=09if (!c_fmt) {
> > +=09=09=09virtio_video_free_control_formats(vvd);
> > +=09=09=09return -1;
> > +=09=09}
> > +
> > +=09=09c_fmt->format =3D fmt->desc.format;
> > +=09=09ret =3D virtio_video_parse_control_profiles(vvd, c_fmt);
> > +=09=09if (ret) {
> > +=09=09=09virtio_video_free_control_formats(vvd);
> > +=09=09=09kfree(c_fmt);
> > +=09=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09=09 "failed to parse control=20
profile\n");
> > +=09=09=09goto err;
> > +=09=09}
> > +=09=09ret =3D virtio_video_parse_control_levels(vvd, c_fmt);
> > +=09=09if (ret) {
> > +=09=09=09virtio_video_free_control_formats(vvd);
> > +=09=09=09kfree(c_fmt);
> > +=09=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09=09 "failed to parse control=20
level\n");
> > +=09=09=09goto err;
> > +=09=09}
> > +=09=09list_add(&c_fmt->controls_list_entry, &vvd-
>controls_fmt_list);
> > +=09}
> > +=09return 0;
> > +err:
> > +=09return ret;
> > +}
> > +
> > +void virtio_video_clean_control(struct virtio_video_device *vvd)
> > +{
> > +=09if (!vvd)
> > +=09=09return;
> > +
> > +=09virtio_video_free_control_formats(vvd);
> > +}
> > diff --git a/drivers/media/virtio/virtio_video_dec.c
> > b/drivers/media/virtio/virtio_video_dec.c new file mode 100644
> > index 000000000000..fc805933fc5e
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_dec.c
> > @@ -0,0 +1,427 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Decoder for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +
> > +#include "virtio_video.h"
> > +
> > +static void virtio_video_dec_buf_queue(struct vb2_buffer *vb)
> > +{
> > +=09int i, ret;
> > +=09struct vb2_buffer *src_buf;
> > +=09struct vb2_v4l2_buffer *src_vb;
> > +=09struct virtio_video_buffer *virtio_vb;
> > +=09uint32_t data_size[VB2_MAX_PLANES] =3D {0};
> > +=09struct vb2_v4l2_buffer *v4l2_vb =3D to_vb2_v4l2_buffer(vb);
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb-
>vb2_queue);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09v4l2_m2m_buf_queue(stream->fh.m2m_ctx, v4l2_vb);
> > +
> > +=09if ((stream->state !=3D STREAM_STATE_INIT) ||
> > +=09    !V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type))
> > +=09=09return;
> > +
> > +=09src_vb =3D v4l2_m2m_next_src_buf(stream->fh.m2m_ctx);
> > +=09if (!src_vb) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "no src buf during=20
initialization\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09src_buf =3D &src_vb->vb2_buf;
> > +=09for (i =3D 0; i < src_buf->num_planes; ++i)
> > +=09=09data_size[i] =3D src_buf->planes[i].bytesused;
> > +
> > +=09virtio_vb =3D to_virtio_vb(src_buf);
> > +
> > +=09ret =3D virtio_video_cmd_resource_queue(vv, stream->stream_id,
> > +=09=09=09=09=09      virtio_vb,=20
data_size,
> > +=09=09=09=09=09      src_buf-
>num_planes,
> > +=09=09=09=09=09     =20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to queue an src=20
buffer\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09virtio_vb->queued =3D true;
> > +=09stream->src_cleared =3D false;
> > +=09src_vb =3D v4l2_m2m_src_buf_remove(stream->fh.m2m_ctx);
> > +}
> > +
> > +static int virtio_video_dec_start_streaming(struct vb2_queue *vq,
> > +=09=09=09=09=09    unsigned int=20
count)
> > +{
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +
> > +=09if (!V4L2_TYPE_IS_OUTPUT(vq->type) &&
> > +=09    stream->state >=3D STREAM_STATE_INIT)
> > +=09=09stream->state =3D STREAM_STATE_RUNNING;
> > +
> > +=09return 0;
> > +}
> > +
> > +static void virtio_video_dec_stop_streaming(struct vb2_queue *vq)
> > +{
> > +=09int ret, queue_type;
> > +=09bool *cleared;
> > +=09bool is_v4l2_output =3D V4L2_TYPE_IS_OUTPUT(vq->type);
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct vb2_v4l2_buffer *v4l2_vb;
> > +
> > +=09if (is_v4l2_output) {
> > +=09=09cleared =3D &stream->src_cleared;
> > +=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT;
> > +=09} else {
> > +=09=09cleared =3D &stream->dst_cleared;
> > +=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_queue_clear(vv, stream, queue_type);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to clear queue\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, *cleared, 5 * HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for queue=20
clear\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09for (;;) {
> > +=09=09if (is_v4l2_output)
> > +=09=09=09v4l2_vb =3D v4l2_m2m_src_buf_remove(stream-
>fh.m2m_ctx);
> > +=09=09else
> > +=09=09=09v4l2_vb =3D v4l2_m2m_dst_buf_remove(stream-
>fh.m2m_ctx);
> > +=09=09if (!v4l2_vb)
> > +=09=09=09break;
> > +=09=09v4l2_m2m_buf_done(v4l2_vb, VB2_BUF_STATE_ERROR);
> > +=09}
> > +}
> > +
> > +static const struct vb2_ops virtio_video_dec_qops =3D {
> > +=09.queue_setup=09 =3D virtio_video_queue_setup,
> > +=09.buf_init=09 =3D virtio_video_buf_init,
> > +=09.buf_cleanup=09 =3D virtio_video_buf_cleanup,
> > +=09.buf_queue=09 =3D virtio_video_dec_buf_queue,
> > +=09.start_streaming =3D virtio_video_dec_start_streaming,
> > +=09.stop_streaming  =3D virtio_video_dec_stop_streaming,
> > +=09.wait_prepare=09 =3D vb2_ops_wait_prepare,
> > +=09.wait_finish=09 =3D vb2_ops_wait_finish,
> > +};
> > +
> > +static int virtio_video_dec_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +=09int ret =3D 0;
> > +=09struct virtio_video_stream *stream =3D ctrl2stream(ctrl);
> > +
> > +=09switch (ctrl->id) {
>=20
> > +=09case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
> It makes no sense for this to be volatile. It's just a read-only control.
>=20
> > +=09=09if (stream->state >=3D STREAM_STATE_METADATA)
> > +=09=09=09ctrl->val =3D stream->out_info.min_buffers;
> > +=09=09else
> > +=09=09=09ctrl->val =3D 0;
> > +=09=09break;
> > +=09default:
> > +=09=09ret =3D -EINVAL;
>=20
> Missing break.
>=20
> > +=09}
> > +
> > +=09return ret;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops virtio_video_dec_ctrl_ops =3D {
> > +=09.g_volatile_ctrl=09=3D virtio_video_dec_g_volatile_ctrl,
> > +};
> > +
> > +int virtio_video_dec_init_ctrls(struct virtio_video_stream *stream)
> > +{
> > +=09struct v4l2_ctrl *ctrl;
> > +
> > +=09v4l2_ctrl_handler_init(&stream->ctrl_handler, 1);
> > +
> > +=09ctrl =3D v4l2_ctrl_new_std(&stream->ctrl_handler,
> > +=09=09=09=09&virtio_video_dec_ctrl_ops,
> > +=09=09=09=09V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
> > +=09=09=09=09MIN_BUFS_MIN, MIN_BUFS_MAX,=20
MIN_BUFS_STEP,
> > +=09=09=09=09MIN_BUFS_DEF);
> > +=09ctrl->flags |=3D V4L2_CTRL_FLAG_VOLATILE;
> > +
> > +=09if (stream->ctrl_handler.error)
> > +=09=09return stream->ctrl_handler.error;
> > +
> > +=09v4l2_ctrl_handler_setup(&stream->ctrl_handler);
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_dec_init_queues(void *priv, struct vb2_queue *src_vq,
> > +=09=09=09=09 struct vb2_queue *dst_vq)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_stream *stream =3D priv;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct device *dev =3D vv->v4l2_dev.dev;
> > +
> > +=09src_vq->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> > +=09src_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +=09src_vq->drv_priv =3D stream;
> > +=09src_vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);
> > +=09src_vq->ops =3D &virtio_video_dec_qops;
> > +=09src_vq->mem_ops =3D virtio_video_mem_ops(vv);
> > +=09src_vq->min_buffers_needed =3D stream->in_info.min_buffers;
> > +=09src_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +=09src_vq->lock =3D &stream->vq_mutex;
> > +=09src_vq->gfp_flags =3D virtio_video_gfp_flags(vv);
> > +=09src_vq->dev =3D dev;
> > +
> > +=09ret =3D vb2_queue_init(src_vq);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09dst_vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> > +=09dst_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +=09dst_vq->drv_priv =3D stream;
> > +=09dst_vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);
> > +=09dst_vq->ops =3D &virtio_video_dec_qops;
> > +=09dst_vq->mem_ops =3D virtio_video_mem_ops(vv);
> > +=09dst_vq->min_buffers_needed =3D stream->out_info.min_buffers;
> > +=09dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +=09dst_vq->lock =3D &stream->vq_mutex;
> > +=09dst_vq->gfp_flags =3D virtio_video_gfp_flags(vv);
> > +=09dst_vq->dev =3D dev;
> > +
> > +=09return vb2_queue_init(dst_vq);
> > +}
> > +
> > +static int virtio_video_try_decoder_cmd(struct file *file, void *fh,
> > +=09=09=09=09=09struct=20
v4l2_decoder_cmd *cmd)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09if (stream->state =3D=3D STREAM_STATE_DRAIN)
> > +=09=09return -EBUSY;
> > +
> > +=09switch (cmd->cmd) {
> > +=09case V4L2_DEC_CMD_STOP:
> > +=09case V4L2_DEC_CMD_START:
> > +=09=09if (cmd->flags !=3D 0) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "flags=3D%u are not=20
supported",
> > +=09=09=09=09 cmd->flags);
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +=09=09break;
> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_decoder_cmd(struct file *file, void *fh,
> > +=09=09=09=09    struct v4l2_decoder_cmd *cmd)
> > +{
> > +=09int ret;
> > +=09struct vb2_queue *src_vq, *dst_vq;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09ret =3D virtio_video_try_decoder_cmd(file, fh, cmd);
> > +=09if (ret < 0)
> > +=09=09return ret;
> > +
> > +=09dst_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09=20
V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> > +
> > +=09switch (cmd->cmd) {
> > +=09case V4L2_DEC_CMD_START:
> > +=09=09vb2_clear_last_buffer_dequeued(dst_vq);
> > +=09=09break;
> > +=09case V4L2_DEC_CMD_STOP:
> > +=09=09src_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09=09=20
V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> > +
> > +=09=09if (!vb2_is_streaming(src_vq)) {
> > +=09=09=09v4l2_dbg(1, vv->debug,
> > +=09=09=09=09 &vv->v4l2_dev, "output is not=20
streaming\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +
> > +=09=09if (!vb2_is_streaming(dst_vq)) {
> > +=09=09=09v4l2_dbg(1, vv->debug,
> > +=09=09=09=09 &vv->v4l2_dev, "capture is not=20
streaming\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +
> > +=09=09ret =3D virtio_video_cmd_stream_drain(vv, stream-
>stream_id);
> > +=09=09if (ret) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to drain=20
stream\n");
> > +=09=09=09return ret;
> > +=09=09}
> > +
> > +=09=09stream->state =3D STREAM_STATE_DRAIN;
> > +=09=09break;
> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
>=20
> Recently a number of helper functions were added to v4l2-mem2mem to help
> codec drivers do the right thing.
>=20
> See
> https://lore.kernel.org/linux-media/20200303143320.32562-1-narmstrong@bay=
li
> bre.com/
>=20
> There are a number of tricky corner cases in the spec, specifically relat=
ing
> to the V4L2_BUF_FLAG_LAST flag that these helpers simplify.
>=20
> v4l2-compliance will probably fail with this driver.
>=20
> What would be really nice is if this driver can work with vicodec (i.e.
> vicodec runs on the host, this driver runs on the VM).
>=20
> That would make it possible to create full regression tests for this,
> similar to what exists for vicodec today (see the contrib/test/test-media
> script in the v4l-utils repo).
>=20
> > +
> > +static int virtio_video_dec_enum_fmt_vid_cap(struct file *file, void *=
fh,
> > +=09=09=09=09=09     struct=20
v4l2_fmtdesc *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format_info *info =3D NULL;
> > +=09struct video_format *fmt =3D NULL;
> > +=09unsigned long input_mask =3D 0;
> > +=09int idx =3D 0, bit_num =3D 0;
> > +
> > +=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +=09=09return -EINVAL;
>=20
> Why this test? If you don't want it for non-mplane formats, then don't
> say:
>=20
> =09.vidioc_enum_fmt_vid_cap =3D virtio_video_dec_enum_fmt_vid_cap,
>=20
> in the struct below.
>=20
> > +
> > +=09if (f->index >=3D vvd->num_output_fmts)
> > +=09=09return -EINVAL;
> > +
> > +=09info =3D &stream->in_info;
> > +=09list_for_each_entry(fmt, &vvd->input_fmt_list, formats_list_entry)=
=20
{
> > +=09=09if (info->fourcc_format =3D=3D fmt->desc.format) {
> > +=09=09=09input_mask =3D fmt->desc.mask;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +
> > +=09if (input_mask =3D=3D 0)
> > +=09=09return -EINVAL;
> > +
> > +=09list_for_each_entry(fmt, &vvd->output_fmt_list,=20
formats_list_entry) {
> > +=09=09if (test_bit(bit_num, &input_mask)) {
> > +=09=09=09if (f->index =3D=3D idx) {
> > +=09=09=09=09f->pixelformat =3D fmt-
>desc.format;
> > +=09=09=09=09return 0;
> > +=09=09=09}
> > +=09=09=09idx++;
> > +=09=09}
> > +=09=09bit_num++;
> > +=09}
> > +=09return -EINVAL;
> > +}
> > +
> > +
> > +int virtio_video_dec_enum_fmt_vid_out(struct file *file, void *fh,
> > +=09=09=09=09      struct v4l2_fmtdesc *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format *fmt =3D NULL;
> > +=09int idx =3D 0;
> > +
> > +=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +=09=09return -EINVAL;
>=20
> Ditto.
>=20
> > +
> > +=09if (f->index >=3D vvd->num_input_fmts)
> > +=09=09return -EINVAL;
> > +
> > +=09list_for_each_entry(fmt, &vvd->input_fmt_list, formats_list_entry)=
=20
{
> > +=09=09if (f->index =3D=3D idx) {
> > +=09=09=09f->pixelformat =3D fmt->desc.format;
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09idx++;
> > +=09}
> > +=09return -EINVAL;
> > +}
> > +
> > +static int virtio_video_dec_s_fmt(struct file *file, void *fh,
> > +=09=09=09=09  struct v4l2_format *f)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +
> > +=09ret =3D virtio_video_s_fmt(file, fh, f);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> > +=09=09if (stream->state =3D=3D STREAM_STATE_IDLE)
> > +=09=09=09stream->state =3D STREAM_STATE_INIT;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops virtio_video_dec_ioctl_ops =3D {
> > +=09.vidioc_querycap=09=3D virtio_video_querycap,
> > +
> > +=09.vidioc_enum_fmt_vid_cap =3D virtio_video_dec_enum_fmt_vid_cap,
> > +=09.vidioc_g_fmt_vid_cap=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_cap=09=3D virtio_video_dec_s_fmt,
>=20
> From what I see see, only the _mplane variants are supported, so why have
> these three line here?
>=20
> > +
> > +=09.vidioc_enum_fmt_vid_cap_mplane =3D=20
virtio_video_dec_enum_fmt_vid_cap,
> > +=09.vidioc_g_fmt_vid_cap_mplane=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_cap_mplane=09=3D virtio_video_dec_s_fmt,
> > +
> > +=09.vidioc_enum_fmt_vid_out =3D virtio_video_dec_enum_fmt_vid_out,
> > +=09.vidioc_g_fmt_vid_out=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_out=09=3D virtio_video_dec_s_fmt,
>=20
> Ditto.
>=20
> > +
> > +=09.vidioc_enum_fmt_vid_out_mplane =3D=20
virtio_video_dec_enum_fmt_vid_out,
> > +=09.vidioc_g_fmt_vid_out_mplane=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_out_mplane=09=3D virtio_video_dec_s_fmt,
> > +
> > +=09.vidioc_g_selection =3D virtio_video_g_selection,
> > +=09.vidioc_s_selection =3D virtio_video_s_selection,
> > +
> > +=09.vidioc_try_decoder_cmd=09=3D virtio_video_try_decoder_cmd,
> > +=09.vidioc_decoder_cmd=09=3D virtio_video_decoder_cmd,
> > +=09.vidioc_enum_frameintervals =3D virtio_video_enum_framemintervals,
> > +=09.vidioc_enum_framesizes =3D virtio_video_enum_framesizes,
> > +
> > +=09.vidioc_reqbufs=09=09=3D virtio_video_reqbufs,
> > +=09.vidioc_querybuf=09=3D v4l2_m2m_ioctl_querybuf,
> > +=09.vidioc_qbuf=09=09=3D v4l2_m2m_ioctl_qbuf,
> > +=09.vidioc_dqbuf=09=09=3D v4l2_m2m_ioctl_dqbuf,
> > +=09.vidioc_prepare_buf=09=3D v4l2_m2m_ioctl_prepare_buf,
> > +=09.vidioc_create_bufs=09=3D v4l2_m2m_ioctl_create_bufs,
> > +=09.vidioc_expbuf=09=09=3D v4l2_m2m_ioctl_expbuf,
> > +
> > +=09.vidioc_streamon=09=3D v4l2_m2m_ioctl_streamon,
> > +=09.vidioc_streamoff=09=3D v4l2_m2m_ioctl_streamoff,
> > +
> > +=09.vidioc_subscribe_event =3D virtio_video_subscribe_event,
> > +=09.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
> > +};
> > +
> > +int virtio_video_dec_init(struct video_device *vd)
> > +{
> > +=09ssize_t num;
> > +
> > +=09vd->ioctl_ops =3D &virtio_video_dec_ioctl_ops;
> > +=09num =3D strscpy(vd->name, "stateful-decoder", sizeof(vd->name));
> > +
> > +=09return 0;
> > +}
> > diff --git a/drivers/media/virtio/virtio_video_dec.h
> > b/drivers/media/virtio/virtio_video_dec.h new file mode 100644
> > index 000000000000..0a1252248bbf
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_dec.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* Decoder header for virtio video driver.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#ifndef _VIRTIO_VIDEO_DEC_H
> > +#define _VIRTIO_VIDEO_DEC_H
> > +
> > +#include "virtio_video.h"
> > +
> > +int virtio_video_dec_init(struct video_device *vd);
> > +int virtio_video_dec_init_ctrls(struct virtio_video_stream *stream);
> > +int virtio_video_dec_init_queues(void *priv, struct vb2_queue *src_vq,
> > +=09=09=09=09 struct vb2_queue *dst_vq);
> > +
> > +#endif /* _VIRTIO_VIDEO_DEC_H */
> > diff --git a/drivers/media/virtio/virtio_video_device.c
> > b/drivers/media/virtio/virtio_video_device.c new file mode 100644
> > index 000000000000..130e705580d1
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_device.c
> > @@ -0,0 +1,1079 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/videobuf2-dma-sg.h>
> > +
> > +#include "virtio_video.h"
> > +#include "virtio_video_dec.h"
> > +#include "virtio_video_enc.h"
> > +
> > +int virtio_video_queue_setup(struct vb2_queue *vq, unsigned int
> > *num_buffers, +=09=09=09     unsigned int *num_planes,=20
unsigned int sizes[],
> > +=09=09=09     struct device *alloc_devs[])
> > +{
> > +=09int i;
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +=09struct video_format_info *p_info;
> > +
> > +=09if (*num_planes)
> > +=09=09return 0;
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(vq->type))
> > +=09=09p_info =3D &stream->in_info;
> > +=09else
> > +=09=09p_info =3D &stream->out_info;
> > +
> > +=09*num_planes =3D p_info->num_planes;
> > +
> > +=09for (i =3D 0; i < p_info->num_planes; i++)
> > +=09=09sizes[i] =3D p_info->plane_format[i].plane_size;
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_buf_init(struct vb2_buffer *vb)
> > +{
> > +=09int ret =3D 0;
> > +=09unsigned int i, j;
> > +=09struct scatterlist *sg;
> > +=09struct virtio_video_mem_entry *ents;
> > +=09uint32_t num_ents[VIRTIO_VIDEO_MAX_PLANES];
> > +=09struct sg_table *sgt[VIRTIO_VIDEO_MAX_PLANES];
> > +=09uint32_t resource_id, nents =3D 0;
> > +=09struct vb2_queue *vq =3D vb->vb2_queue;
> > +=09enum v4l2_buf_type queue_type =3D vq->type;
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb(vb);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09virtio_video_resource_id_get(vv, &resource_id);
> > +
> > +=09if (vv->supp_non_contig) {
> > +=09=09for (i =3D 0; i < vb->num_planes; i++) {
> > +=09=09=09sgt[i] =3D vb2_dma_sg_plane_desc(vb, i);
> > +=09=09=09nents +=3D sgt[i]->nents;
> > +=09=09}
> > +
> > +=09=09ents =3D kcalloc(nents, sizeof(*ents), GFP_KERNEL);
> > +=09=09if (!ents)
> > +=09=09=09return -ENOMEM;
> > +
> > +=09=09for (i =3D 0; i < vb->num_planes; ++i) {
> > +=09=09=09for_each_sg(sgt[i]->sgl, sg, sgt[i]->nents,=20
j) {
> > +=09=09=09=09ents[j].addr =3D cpu_to_le64(vv-
>has_iommu
> > +=09=09=09=09=09=09=09  =20
? sg_dma_address(sg)
> > +=09=09=09=09=09=09=09  =20
: sg_phys(sg));
> > +=09=09=09=09ents[j].length =3D cpu_to_le32(sg-
>length);
> > +=09=09=09}
> > +=09=09=09num_ents[i] =3D sgt[i]->nents;
> > +=09=09}
> > +=09} else {
> > +=09=09nents =3D vb->num_planes;
> > +
> > +=09=09ents =3D kcalloc(nents, sizeof(*ents), GFP_KERNEL);
> > +=09=09if (!ents)
> > +=09=09=09return -ENOMEM;
> > +
> > +=09=09for (i =3D 0; i < vb->num_planes; ++i) {
> > +=09=09=09ents[i].addr =3D
> > +=09=09=09=09
cpu_to_le64(vb2_dma_contig_plane_dma_addr(vb,
> > +=09=09=09=09=09=09=09=09
=09  i));
> > +=09=09=09ents[i].length =3D cpu_to_le32(vb-
>planes[i].length);
> > +=09=09=09num_ents[i] =3D 1;
> > +=09=09}
> > +=09}
> > +
> > +=09v4l2_dbg(1, vv->debug, &vv->v4l2_dev, "mem entries:\n");
> > +=09if (vv->debug >=3D 1) {
> > +=09=09for (i =3D 0; i < nents; i++)
> > +=09=09=09pr_debug("\t%03i: addr=3D%llx length=3D%u\n", i,
> > +=09=09=09=09=09ents[i].addr,=20
ents[i].length);
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_resource_create(vv, stream->stream_id,
> > +=09=09=09=09=09       resource_id,
> > +=09=09=09=09=09      =20
to_virtio_queue_type(queue_type),
> > +=09=09=09=09=09       ents, vb-
>num_planes,
> > +=09=09=09=09=09       num_ents);
> > +=09if (ret) {
> > +=09=09virtio_video_resource_id_put(vvd->vv, resource_id);
> > +=09=09kfree(ents);
> > +
> > +=09=09return ret;
> > +=09}
> > +
> > +=09virtio_vb->queued =3D false;
> > +=09virtio_vb->resource_id =3D resource_id;
> > +
> > +=09return 0;
> > +}
> > +
> > +void virtio_video_buf_cleanup(struct vb2_buffer *vb)
> > +{
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb-
>vb2_queue);
> > +=09struct virtio_video_buffer *virtio_vb =3D to_virtio_vb(vb);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09virtio_video_resource_id_put(vv, virtio_vb->resource_id);
> > +}
> > +
> > +int virtio_video_querycap(struct file *file, void *fh,
> > +=09=09=09  struct v4l2_capability *cap)
> > +{
> > +=09struct video_device *video_dev =3D video_devdata(file);
> > +
> > +=09strncpy(cap->driver, DRIVER_NAME, sizeof(cap->driver));
> > +=09strncpy(cap->card, video_dev->name, sizeof(cap->card));
>=20
> Don't use strncpy/strlcpy/strcpy. Use strscpy instead.
>=20
> > +=09snprintf(cap->bus_info, sizeof(cap->bus_info), "virtio:%s",
> > +=09=09 video_dev->name);
> > +
> > +=09cap->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING=
;
> > +=09cap->capabilities =3D cap->device_caps | V4L2_CAP_DEVICE_CAPS;
>=20
> Drop these two lines. Instead fill in cap->device_caps in struct
> video_device.
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_enum_framesizes(struct file *file, void *fh,
> > +=09=09=09=09 struct v4l2_frmsizeenum *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format *fmt =3D NULL;
> > +=09struct video_format_frame *frm =3D NULL;
> > +=09struct virtio_video_format_frame *frame =3D NULL;
> > +=09int idx =3D f->index;
> > +
> > +=09fmt =3D find_video_format(&vvd->input_fmt_list, f->pixel_format);
> > +=09if (fmt =3D=3D NULL)
> > +=09=09fmt =3D find_video_format(&vvd->output_fmt_list, f-
>pixel_format);
> > +=09if (fmt =3D=3D NULL)
> > +=09=09return -EINVAL;
> > +
> > +=09if (idx >=3D fmt->desc.num_frames)
> > +=09=09return -EINVAL;
> > +
> > +=09frm =3D &fmt->frames[idx];
> > +=09frame =3D &frm->frame;
> > +
> > +=09if (frame->width.min =3D=3D frame->width.max &&
> > +=09    frame->height.min =3D=3D frame->height.max) {
> > +=09=09f->type =3D V4L2_FRMSIZE_TYPE_DISCRETE;
> > +=09=09f->discrete.width =3D frame->width.min;
> > +=09=09f->discrete.height =3D frame->height.min;
> > +=09=09return 0;
> > +=09}
> > +
> > +=09f->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;
> > +=09f->stepwise.min_width =3D frame->width.min;
> > +=09f->stepwise.max_width =3D frame->width.max;
> > +=09f->stepwise.min_height =3D frame->height.min;
> > +=09f->stepwise.max_height =3D frame->height.max;
> > +=09f->stepwise.step_width =3D frame->width.step;
> > +=09f->stepwise.step_height =3D frame->height.step;
> > +=09return 0;
> > +}
> > +
> > +static bool in_stepped_interval(uint32_t int_start, uint32_t int_end,
> > +=09=09=09=09uint32_t step, uint32_t point)
> > +{
> > +=09if (point < int_start || point > int_end)
> > +=09=09return false;
> > +
> > +=09if (step =3D=3D 0 && int_start =3D=3D int_end && int_start =3D=3D p=
oint)
> > +=09=09return true;
> > +
> > +=09if (step !=3D 0 && (point - int_start) % step =3D=3D 0)
> > +=09=09return true;
> > +
> > +=09return false;
> > +}
> > +
> > +int virtio_video_enum_framemintervals(struct file *file, void *fh,
> > +=09=09=09=09      struct v4l2_frmivalenum *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format *fmt =3D NULL;
> > +=09struct video_format_frame *frm =3D NULL;
> > +=09struct virtio_video_format_frame *frame =3D NULL;
> > +=09struct virtio_video_format_range *frate =3D NULL;
> > +=09int idx =3D f->index;
> > +=09int f_idx =3D 0;
> > +
> > +=09fmt =3D find_video_format(&vvd->input_fmt_list, f->pixel_format);
> > +=09if (fmt =3D=3D NULL)
> > +=09=09fmt =3D find_video_format(&vvd->output_fmt_list, f-
>pixel_format);
> > +=09if (fmt =3D=3D NULL)
> > +=09=09return -EINVAL;
> > +
> > +=09for (f_idx =3D 0; f_idx <=3D fmt->desc.num_frames; f_idx++) {
> > +=09=09frm =3D &fmt->frames[f_idx];
> > +=09=09frame =3D &frm->frame;
> > +=09=09if (in_stepped_interval(frame->width.min, frame-
>width.max,
> > +=09=09=09=09=09frame->width.step, f-
>width) &&
> > +=09=09   in_stepped_interval(frame->height.min, frame-
>height.max,
> > +=09=09=09=09=09frame->height.step, f-
>height))
> > +=09=09=09break;
> > +=09}
> > +
> > +=09if (frame =3D=3D NULL || f->index >=3D frame->num_rates)
> > +=09=09return -EINVAL;
> > +
> > +=09frate =3D &frm->frame_rates[idx];
> > +=09if (frate->max =3D=3D frate->min) {
> > +=09=09f->type =3D V4L2_FRMIVAL_TYPE_DISCRETE;
> > +=09=09f->discrete.numerator =3D 1;
> > +=09=09f->discrete.denominator =3D frate->max;
> > +=09} else {
> > +=09=09f->stepwise.min.numerator =3D 1;
> > +=09=09f->stepwise.min.denominator =3D frate->max;
> > +=09=09f->stepwise.max.numerator =3D 1;
> > +=09=09f->stepwise.max.denominator =3D frate->min;
> > +=09=09f->stepwise.step.numerator =3D 1;
> > +=09=09f->stepwise.step.denominator =3D frate->step;
> > +=09=09if (frate->step =3D=3D 1)
> > +=09=09=09f->type =3D V4L2_FRMIVAL_TYPE_CONTINUOUS;
> > +=09=09else
> > +=09=09=09f->type =3D V4L2_FRMIVAL_TYPE_STEPWISE;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +
> > +int virtio_video_g_fmt(struct file *file, void *fh, struct v4l2_format
> > *f)
> > +{
> > +=09struct video_format_info *info;
> > +=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +
> > +=09if (!V4L2_TYPE_IS_OUTPUT(f->type))
> > +=09=09info =3D &stream->out_info;
> > +=09else
> > +=09=09info =3D &stream->in_info;
> > +
> > +=09virtio_video_format_from_info(info, pix_mp);
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_s_fmt(struct file *file, void *fh, struct v4l2_format
> > *f)
> > +{
> > +=09int i, ret;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct video_format_info info;
> > +=09struct video_format_info *p_info;
> > +=09uint32_t queue;
> > +
> > +=09ret =3D virtio_video_try_fmt(stream, f);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> > +=09=09virtio_video_format_fill_default_info(&info, &stream-
>in_info);
> > +=09=09queue =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT;
> > +=09} else {
> > +=09=09virtio_video_format_fill_default_info(&info, &stream-
>out_info);
> > +=09=09queue =3D VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT;
> > +=09}
> > +
> > +=09info.frame_width =3D pix_mp->width;
> > +=09info.frame_height =3D pix_mp->height;
> > +=09info.num_planes =3D pix_mp->num_planes;
> > +=09info.fourcc_format =3D pix_mp->pixelformat;
> > +
> > +=09for (i =3D 0; i < info.num_planes; i++) {
> > +=09=09info.plane_format[i].stride =3D
> > +=09=09=09=09=09 pix_mp-
>plane_fmt[i].bytesperline;
> > +=09=09info.plane_format[i].plane_size =3D
> > +=09=09=09=09=09 pix_mp-
>plane_fmt[i].sizeimage;
> > +=09}
> > +
> > +=09virtio_video_cmd_set_params(vv, stream, &info, queue);
> > +=09virtio_video_cmd_get_params(vv, stream,=20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09virtio_video_cmd_get_params(vv, stream,=20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(f->type))
> > +=09=09p_info =3D &stream->in_info;
> > +=09else
> > +=09=09p_info =3D &stream->out_info;
> > +
> > +=09virtio_video_format_from_info(p_info, pix_mp);
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_g_selection(struct file *file, void *fh,
> > +=09=09=09 struct v4l2_selection *sel)
> > +{
> > +=09struct video_format_info *info =3D NULL;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +
> > +=09switch (vvd->type) {
> > +=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09if (!V4L2_TYPE_IS_OUTPUT(sel->type))
> > +=09=09=09return -EINVAL;
> > +=09=09info =3D &stream->in_info;
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09if (V4L2_TYPE_IS_OUTPUT(sel->type))
> > +=09=09=09return -EINVAL;
> > +=09=09info =3D &stream->out_info;
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_err(&vvd->vv->v4l2_dev, "unsupported device=20
type\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09switch (sel->target) {
>=20
> > +=09case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> I'm missing V4L2_SEL_TGT_COMPOSE_DEFAULT here.
>=20
> > +=09case V4L2_SEL_TGT_COMPOSE_PADDED:
> > +=09=09sel->r.width =3D info->frame_width;
> > +=09=09sel->r.height =3D info->frame_height;
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_dbg(1, vvd->vv->debug, &vvd->vv->v4l2_dev,
> > +=09=09=09 "unsupported/invalid selection target\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_s_selection(struct file *file, void *fh,
> > +=09=09=09     struct v4l2_selection *sel)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09int ret;
> > +
>=20
> There are no checks against the selection target here. That's definitely
> wrong.
> > +=09stream->out_info.crop.top =3D sel->r.top;
> > +=09stream->out_info.crop.left =3D sel->r.left;
> > +=09stream->out_info.crop.width =3D sel->r.width;
> > +=09stream->out_info.crop.height =3D sel->r.height;
> > +
> > +=09ret =3D virtio_video_cmd_set_params(vv, stream,  &stream->out_info,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
>=20
> Typically decoders can change the capture compose selection and encoders
> can change the output crop selection. None of that is checked here.
>=20
> Also, this code suggests that you can change the selection rectangle, but
> g_selection above has no way of returning the crop/compose rectangle. Tha=
t's
> not right either.
>=20
> > +=09if (ret < 0)
> > +=09=09return -EINVAL;
> > +
> > +=09/* Get actual selection that was set */
> > +=09return virtio_video_cmd_get_params(vv, stream,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +}
> > +
> > +int virtio_video_try_fmt(struct virtio_video_stream *stream,
> > +=09=09=09 struct v4l2_format *f)
> > +{
> > +=09int i, idx =3D 0;
> > +=09struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format *fmt =3D NULL;
> > +=09bool found =3D false;
> > +=09struct video_format_frame *frm =3D NULL;
> > +=09struct virtio_video_format_frame *frame =3D NULL;
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(f->type))
> > +=09=09fmt =3D find_video_format(&vvd->input_fmt_list,
> > +=09=09=09=09=09pix_mp->pixelformat);
> > +=09else
> > +=09=09fmt =3D find_video_format(&vvd->output_fmt_list,
> > +=09=09=09=09=09pix_mp->pixelformat);
> > +
> > +=09if (!fmt) {
> > +=09=09if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +=09=09=09virtio_video_format_from_info(&stream-
>out_info,
> > +=09=09=09=09=09=09     =20
pix_mp);
> > +=09=09else if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +=09=09=09virtio_video_format_from_info(&stream-
>in_info,
> > +=09=09=09=09=09=09     =20
pix_mp);
> > +=09=09else
> > +=09=09=09return -EINVAL;
> > +=09=09return 0;
> > +=09}
> > +
> > +=09for (i =3D 0; i < fmt->desc.num_frames && !found; i++) {
> > +=09=09frm =3D &fmt->frames[i];
> > +=09=09frame =3D &frm->frame;
> > +=09=09if (!within_range(frame->width.min, pix_mp->width,
> > +=09=09=09=09  frame->width.max))
> > +=09=09=09continue;
> > +
> > +=09=09if (!within_range(frame->height.min, pix_mp->width,
> > +=09=09=09=09  frame->height.max))
> > +=09=09=09continue;
> > +=09=09idx =3D i;
> > +=09=09/*
> > +=09=09 * Try to find a more suitable frame size. Go with the=20
current
> > +=09=09 * one otherwise.
> > +=09=09 */
> > +=09=09if (needs_alignment(pix_mp->width, frame->width.step))
> > +=09=09=09continue;
> > +
> > +=09=09if (needs_alignment(pix_mp->height, frame-
>height.step))
> > +=09=09=09continue;
> > +
> > +=09=09stream->current_frame =3D frm;
> > +=09=09found =3D true;
> > +=09}
> > +
> > +=09if (!found) {
> > +=09=09frm =3D &fmt->frames[idx];
> > +=09=09frame =3D &frm->frame;
> > +=09=09pix_mp->width =3D clamp(pix_mp->width, frame->width.min,
> > +=09=09=09=09      frame->width.max);
> > +=09=09if (frame->width.step !=3D 0)
> > +=09=09=09pix_mp->width =3D ALIGN(pix_mp->width, frame-
>width.step);
> > +
> > +=09=09pix_mp->height =3D clamp(pix_mp->height, frame-
>height.min,
> > +=09=09=09=09       frame->height.max);
> > +=09=09if (frame->height.step !=3D 0)
> > +=09=09=09pix_mp->height =3D ALIGN(pix_mp->height,
> > +=09=09=09=09=09       frame-
>height.step);
> > +=09=09stream->current_frame =3D frm;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_queue_free(struct virtio_video *vv,
> > +=09=09=09  struct virtio_video_stream *stream,
> > +=09=09=09  enum v4l2_buf_type type)
> > +{
> > +=09int ret;
> > +=09uint32_t queue_type =3D to_virtio_queue_type(type);
> > +
> > +=09ret =3D virtio_video_cmd_resource_destroy_all(vv, stream,
> > +=09=09=09=09=09=09   =20
queue_type);
> > +=09if (ret)
> > +=09=09v4l2_warn(&vv->v4l2_dev,
> > +=09=09=09  "failed to destroy resources\n");
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_reqbufs(struct file *file, void *priv,
> > +=09=09=09 struct v4l2_requestbuffers *rb)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct v4l2_m2m_ctx *m2m_ctx =3D stream->fh.m2m_ctx;
> > +=09struct vb2_queue *vq =3D v4l2_m2m_get_vq(m2m_ctx, rb->type);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +
> > +=09if (rb->count =3D=3D 0)
> > +=09=09virtio_video_queue_free(vvd->vv, stream, vq->type);
> > +
> > +=09return v4l2_m2m_reqbufs(file, m2m_ctx, rb);
> > +}
> > +
> > +int virtio_video_subscribe_event(struct v4l2_fh *fh,
> > +=09=09=09=09 const struct=20
v4l2_event_subscription *sub)
> > +{
> > +=09switch (sub->type) {
> > +=09case V4L2_EVENT_SOURCE_CHANGE:
> > +=09=09return v4l2_src_change_event_subscribe(fh, sub);
> > +=09default:
> > +=09=09return -EINVAL;
>=20
> Use 'return v4l2_ctrl_subscribe_event(fh, sub);' instead.
>=20
> > +=09}
> > +}
> > +
> > +void virtio_video_queue_eos_event(struct virtio_video_stream *stream)
> > +{
> > +=09static const struct v4l2_event eos_event =3D {
> > +=09=09.type =3D V4L2_EVENT_EOS
> > +=09};
> > +
> > +=09v4l2_event_queue_fh(&stream->fh, &eos_event);
> > +}
> > +
> > +void virtio_video_queue_res_chg_event(struct virtio_video_stream *stre=
am)
> > +{
> > +=09static const struct v4l2_event ev_src_ch =3D {
> > +=09=09.type =3D V4L2_EVENT_SOURCE_CHANGE,
> > +=09=09.u.src_change.changes =3D
> > +=09=09=09V4L2_EVENT_SRC_CH_RESOLUTION,
> > +=09};
> > +
> > +=09v4l2_event_queue_fh(&stream->fh, &ev_src_ch);
> > +}
> > +
> > +void virtio_video_mark_drain_complete(struct virtio_video_stream *stre=
am,
> > +=09=09=09=09      struct vb2_v4l2_buffer=20
*v4l2_vb)
> > +{
> > +=09struct vb2_buffer *vb2_buf;
> > +
> > +=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_LAST;
> > +
> > +=09vb2_buf =3D &v4l2_vb->vb2_buf;
> > +=09vb2_buf->planes[0].bytesused =3D 0;
> > +
> > +=09v4l2_m2m_buf_done(v4l2_vb, VB2_BUF_STATE_DONE);
> > +=09stream->state =3D STREAM_STATE_STOPPED;
> > +}
> > +
> > +void virtio_video_buf_done(struct virtio_video_buffer *virtio_vb,
> > +=09=09=09   uint32_t flags, uint64_t timestamp,=20
uint32_t size)
> > +{
> > +=09int i;
> > +=09enum vb2_buffer_state done_state =3D VB2_BUF_STATE_DONE;
> > +=09struct vb2_v4l2_buffer *v4l2_vb =3D &virtio_vb->v4l2_m2m_vb.vb;
> > +=09struct vb2_buffer *vb =3D &v4l2_vb->vb2_buf;
> > +=09struct vb2_queue *vb2_queue =3D vb->vb2_queue;
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb2_queue);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format_info *p_info;
> > +
> > +=09virtio_vb->queued =3D false;
> > +
> > +=09if (flags & VIRTIO_VIDEO_BUFFER_FLAG_ERR)
> > +=09=09done_state =3D VB2_BUF_STATE_ERROR;
> > +
> > +=09if (flags & VIRTIO_VIDEO_BUFFER_FLAG_IFRAME)
> > +=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_KEYFRAME;
> > +
> > +=09if (flags & VIRTIO_VIDEO_BUFFER_FLAG_BFRAME)
> > +=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_BFRAME;
> > +
> > +=09if (flags & VIRTIO_VIDEO_BUFFER_FLAG_PFRAME)
> > +=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_PFRAME;
> > +
> > +=09if (flags & VIRTIO_VIDEO_BUFFER_FLAG_EOS) {
> > +=09=09v4l2_vb->flags |=3D V4L2_BUF_FLAG_LAST;
> > +=09=09stream->state =3D STREAM_STATE_STOPPED;
> > +=09=09virtio_video_queue_eos_event(stream);
> > +=09}
> > +
> > +=09if (!V4L2_TYPE_IS_OUTPUT(vb2_queue->type)) {
> > +=09=09switch (vvd->type) {
> > +=09=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09=09vb->planes[0].bytesused =3D size;
> > +=09=09=09break;
> > +=09=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09=09p_info =3D &stream->out_info;
> > +=09=09=09for (i =3D 0; i < p_info->num_planes; i++)
> > +=09=09=09=09vb->planes[i].bytesused =3D
> > +=09=09=09=09=09p_info-
>plane_format[i].plane_size;
> > +=09=09=09break;
> > +=09=09}
> > +
> > +=09=09vb->timestamp =3D timestamp;
> > +=09}
> > +
> > +=09v4l2_m2m_buf_done(v4l2_vb, done_state);
> > +}
> > +
> > +static void virtio_video_worker(struct work_struct *work)
> > +{
> > +=09unsigned int i;
> > +=09int ret;
> > +=09struct vb2_buffer *vb2_buf;
> > +=09struct vb2_v4l2_buffer *src_vb, *dst_vb;
> > +=09struct virtio_video_buffer *virtio_vb;
> > +=09struct virtio_video_stream *stream =3D work2stream(work);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct vb2_queue *src_vq =3D
> > +=09=09v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09
V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> > +=09struct vb2_queue *dst_vq =3D
> > +=09=09v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09
V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09uint32_t data_size[VB2_MAX_PLANES] =3D {0};
> > +
> > +=09mutex_lock(dst_vq->lock);
> > +=09for (;;) {
> > +=09=09dst_vb =3D v4l2_m2m_next_dst_buf(stream->fh.m2m_ctx);
> > +=09=09if (dst_vb =3D=3D NULL)
> > +=09=09=09break;
> > +
> > +=09=09vb2_buf =3D &dst_vb->vb2_buf;
> > +=09=09virtio_vb =3D to_virtio_vb(vb2_buf);
> > +
> > +=09=09for (i =3D 0; i < vb2_buf->num_planes; ++i)
> > +=09=09=09data_size[i] =3D vb2_buf->planes[i].bytesused;
> > +
> > +=09=09ret =3D virtio_video_cmd_resource_queue
> > +=09=09=09(vv, stream->stream_id, virtio_vb,=20
data_size,
> > +=09=09=09 vb2_buf->num_planes,=20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +=09=09if (ret) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09=09  "failed to queue a dst=20
buffer\n");
> > +=09=09=09v4l2_m2m_job_finish(vvd->m2m_dev, stream-
>fh.m2m_ctx);
> > +=09=09=09mutex_unlock(dst_vq->lock);
> > +=09=09=09return;
> > +=09=09}
> > +
> > +=09=09virtio_vb->queued =3D true;
> > +=09=09stream->dst_cleared =3D false;
> > +=09=09dst_vb =3D v4l2_m2m_dst_buf_remove(stream->fh.m2m_ctx);
> > +=09}
> > +=09mutex_unlock(dst_vq->lock);
> > +
> > +=09mutex_lock(src_vq->lock);
> > +=09for (;;) {
> > +=09=09if (stream->state =3D=3D STREAM_STATE_DRAIN)
> > +=09=09=09break;
> > +
> > +=09=09src_vb =3D v4l2_m2m_next_src_buf(stream->fh.m2m_ctx);
> > +=09=09if (src_vb =3D=3D NULL)
> > +=09=09=09break;
> > +
> > +=09=09vb2_buf =3D &src_vb->vb2_buf;
> > +=09=09virtio_vb =3D to_virtio_vb(vb2_buf);
> > +
> > +=09=09for (i =3D 0; i < vb2_buf->num_planes; ++i)
> > +=09=09=09data_size[i] =3D vb2_buf->planes[i].bytesused;
> > +
> > +=09=09ret =3D virtio_video_cmd_resource_queue
> > +=09=09=09(vv, stream->stream_id, virtio_vb,=20
data_size,
> > +=09=09=09 vb2_buf->num_planes,=20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09=09if (ret) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09=09  "failed to queue an src=20
buffer\n");
> > +=09=09=09v4l2_m2m_job_finish(vvd->m2m_dev, stream-
>fh.m2m_ctx);
> > +=09=09=09mutex_unlock(src_vq->lock);
> > +=09=09=09return;
> > +=09=09}
> > +
> > +=09=09virtio_vb->queued =3D true;
> > +=09=09stream->src_cleared =3D false;
> > +=09=09src_vb =3D v4l2_m2m_src_buf_remove(stream->fh.m2m_ctx);
> > +=09}
> > +=09mutex_unlock(src_vq->lock);
> > +
> > +=09v4l2_m2m_job_finish(vvd->m2m_dev, stream->fh.m2m_ctx);
> > +}
> > +
> > +static int virtio_video_device_open(struct file *file)
> > +{
> > +=09int ret;
> > +=09uint32_t stream_id;
> > +=09char name[TASK_COMM_LEN];
> > +=09struct virtio_video_stream *stream;
> > +=09struct video_format *default_fmt;
> > +=09enum virtio_video_format format;
> > +=09struct video_device *video_dev =3D video_devdata(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09switch (vvd->type) {
> > +=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09default_fmt =3D list_first_entry_or_null(&vvd-
>output_fmt_list,
> > +=09=09=09=09=09=09      =20
struct video_format,
> > +=09=09=09=09=09=09      =20
formats_list_entry);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09default_fmt =3D list_first_entry_or_null(&vvd-
>input_fmt_list,
> > +=09=09=09=09=09=09      =20
struct video_format,
> > +=09=09=09=09=09=09      =20
formats_list_entry);
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_err(&vv->v4l2_dev, "unsupported device type\n");
> > +=09=09return -EIO;
> > +=09}
> > +
> > +=09if (!default_fmt) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "device failed to start\n");
> > +=09=09return -EIO;
> > +=09}
> > +
> > +=09stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
> > +=09if (!stream)
> > +=09=09return -ENOMEM;
> > +
> > +=09get_task_comm(name, current);
> > +=09format =3D virtio_video_v4l2_format_to_virtio(default_fmt-
>desc.format);
> > +=09virtio_video_stream_id_get(vv, stream, &stream_id);
> > +=09ret =3D virtio_video_cmd_stream_create(vv, stream_id, format, name)=
;
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to create stream\n");
> > +=09=09goto err_stream_create;
> > +=09}
> > +
> > +=09stream->video_dev =3D video_dev;
> > +=09stream->stream_id =3D stream_id;
> > +=09stream->state =3D STREAM_STATE_IDLE;
> > +
> > +=09ret =3D virtio_video_cmd_get_params(vv, stream,
> > +=09=09=09=09=09 =20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream in=20
params\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_get_params(vv, stream,
> > +=09=09=09=09=09 =20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream out=20
params\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_get_control(vv, stream,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_CONTROL_PROFILE);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream=20
profile\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_get_control(vv, stream,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_CONTROL_LEVEL);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream=20
level\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_get_control(vv, stream,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_CONTROL_BITRATE);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get stream=20
bitrate\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +
> > +=09mutex_init(&stream->vq_mutex);
> > +=09INIT_WORK(&stream->work, virtio_video_worker);
> > +=09v4l2_fh_init(&stream->fh, video_dev);
> > +=09stream->fh.ctrl_handler =3D &stream->ctrl_handler;
> > +
> > +=09switch (vvd->type) {
> > +=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09stream->fh.m2m_ctx =3D
> > +=09=09=09v4l2_m2m_ctx_init(vvd->m2m_dev, stream,
> > +=09=09=09=09=09 =20
&virtio_video_enc_init_queues);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09stream->fh.m2m_ctx =3D
> > +=09=09=09v4l2_m2m_ctx_init(vvd->m2m_dev, stream,
> > +=09=09=09=09=09 =20
&virtio_video_dec_init_queues);
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_err(&vv->v4l2_dev, "unsupported device type\n");
> > +=09=09goto err_stream_create;
> > +=09}
> > +
> > +=09v4l2_m2m_set_src_buffered(stream->fh.m2m_ctx, true);
> > +=09v4l2_m2m_set_dst_buffered(stream->fh.m2m_ctx, true);
> > +=09file->private_data =3D &stream->fh;
> > +=09v4l2_fh_add(&stream->fh);
> > +
> > +=09switch (vvd->type) {
> > +=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09ret =3D virtio_video_enc_init_ctrls(stream);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09ret =3D virtio_video_dec_init_ctrls(stream);
> > +=09=09break;
> > +=09default:
> > +=09=09ret =3D 0;
> > +=09=09break;
> > +=09}
> > +
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to init controls\n");
> > +=09=09goto err_init_ctrls;
> > +=09}
> > +=09return 0;
> > +
> > +err_init_ctrls:
> > +=09v4l2_fh_del(&stream->fh);
> > +=09v4l2_fh_exit(&stream->fh);
> > +=09mutex_lock(video_dev->lock);
> > +=09v4l2_m2m_ctx_release(stream->fh.m2m_ctx);
> > +=09mutex_unlock(video_dev->lock);
> > +err_stream_create:
> > +=09virtio_video_stream_id_put(vv, stream_id);
> > +=09kfree(stream);
> > +
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_device_release(struct file *file)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct video_device *video_dev =3D video_devdata(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09v4l2_fh_del(&stream->fh);
> > +=09v4l2_fh_exit(&stream->fh);
> > +=09mutex_lock(video_dev->lock);
> > +=09v4l2_m2m_ctx_release(stream->fh.m2m_ctx);
> > +=09mutex_unlock(video_dev->lock);
> > +
> > +=09virtio_video_cmd_stream_destroy(vv, stream->stream_id);
> > +=09virtio_video_stream_id_put(vv, stream->stream_id);
> > +
> > +=09kfree(stream);
> > +
> > +=09return 0;
> > +}
> > +
> > +static const struct v4l2_file_operations virtio_video_device_fops =3D =
{
> > +=09.owner=09=09=3D THIS_MODULE,
> > +=09.open=09=09=3D virtio_video_device_open,
> > +=09.release=09=3D virtio_video_device_release,
> > +=09.poll=09=09=3D v4l2_m2m_fop_poll,
> > +=09.unlocked_ioctl=09=3D video_ioctl2,
> > +=09.mmap=09=09=3D v4l2_m2m_fop_mmap,
> > +};
> > +
> > +static void virtio_video_device_run(void *priv)
> > +{
> > +=09struct virtio_video_stream *stream =3D priv;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +
> > +=09queue_work(vvd->workqueue, &stream->work);
> > +}
> > +
> > +static int virtio_video_device_job_ready(void *priv)
> > +{
> > +=09struct virtio_video_stream *stream =3D priv;
> > +
> > +=09if (stream->state =3D=3D STREAM_STATE_STOPPED)
> > +=09=09return 0;
> > +
> > +=09if (v4l2_m2m_num_src_bufs_ready(stream->fh.m2m_ctx) > 0 ||
> > +=09    v4l2_m2m_num_dst_bufs_ready(stream->fh.m2m_ctx) > 0)
> > +=09=09return 1;
> > +
> > +=09return 0;
> > +}
> > +
> > +static void virtio_video_device_job_abort(void *priv)
> > +{
> > +=09struct virtio_video_stream *stream =3D priv;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +
> > +=09v4l2_m2m_job_finish(vvd->m2m_dev, stream->fh.m2m_ctx);
> > +}
> > +
> > +static const struct v4l2_m2m_ops virtio_video_device_m2m_ops =3D {
> > +=09.device_run=09=3D virtio_video_device_run,
> > +=09.job_ready=09=3D virtio_video_device_job_ready,
> > +=09.job_abort=09=3D virtio_video_device_job_abort,
> > +};
> > +
> > +static int virtio_video_device_register(struct virtio_video_device *vv=
d)
> > +{
> > +=09int ret =3D 0;
> > +=09struct video_device *vd =3D NULL;
> > +=09struct virtio_video *vv =3D NULL;
> > +
> > +=09if (!vvd)
> > +=09=09return -EINVAL;
> > +
> > +=09vd =3D &vvd->video_dev;
> > +=09vv =3D vvd->vv;
> > +
> > +=09switch (vvd->type) {
> > +=09case VIRTIO_VIDEO_DEVICE_ENCODER:
> > +=09=09ret =3D virtio_video_enc_init(vd);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_DEVICE_DECODER:
> > +=09=09ret =3D virtio_video_dec_init(vd);
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_err(&vv->v4l2_dev, "unknown device type\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to init device\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09ret =3D video_register_device(vd, VFL_TYPE_GRABBER, 0);
>=20
> VFL_TYPE_GRABBER has been renamed to VFL_TYPE_VIDEO in the media_tree
> master. Just FYI.
>=20
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to register video=20
device\n");
> > +=09=09return ret;
> > +=09}
> > +
> > +=09vvd->workqueue =3D alloc_ordered_workqueue(vd->name,
> > +=09=09=09=09=09=09=20
WQ_MEM_RECLAIM | WQ_FREEZABLE);
> > +=09if (!vvd->workqueue) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to create a=20
workqueue");
> > +=09=09video_unregister_device(vd);
> > +=09=09return -ENOMEM;
> > +=09}
> > +
> > +=09list_add(&vvd->devices_list_entry, &vv->devices_list);
> > +=09v4l2_info(&vv->v4l2_dev, "Device '%s' registered as /dev/
video%d\n",
> > +=09=09  vd->name, vd->num);
> > +
> > +=09return 0;
> > +}
> > +
> > +static void virtio_video_device_unregister(struct virtio_video_device
> > *vvd) +{
> > +=09if (!vvd)
> > +=09=09return;
> > +
> > +=09list_del(&vvd->devices_list_entry);
> > +=09flush_workqueue(vvd->workqueue);
> > +=09destroy_workqueue(vvd->workqueue);
> > +=09video_unregister_device(&vvd->video_dev);
> > +}
> > +
> > +static struct virtio_video_device *
> > +virtio_video_device_create(struct virtio_video *vv)
> > +{
> > +=09struct device *dev =3D NULL;
> > +=09struct video_device *vd =3D NULL;
> > +=09struct v4l2_m2m_dev *m2m_dev =3D NULL;
> > +=09struct virtio_video_device *vvd =3D NULL;
> > +
> > +=09if (!vv)
> > +=09=09return ERR_PTR(-EINVAL);
> > +
> > +=09dev =3D &vv->vdev->dev;
> > +
> > +=09vvd =3D devm_kzalloc(dev, sizeof(*vvd), GFP_KERNEL);
> > +=09if (!vvd)
> > +=09=09return ERR_PTR(-ENOMEM);
> > +
> > +=09m2m_dev =3D v4l2_m2m_init(&virtio_video_device_m2m_ops);
> > +=09if (IS_ERR(m2m_dev)) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to init m2m device\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09vvd->vv =3D vv;
> > +=09vvd->m2m_dev =3D m2m_dev;
> > +=09mutex_init(&vvd->video_dev_mutex);
> > +=09vd =3D &vvd->video_dev;
> > +=09vd->lock =3D &vvd->video_dev_mutex;
> > +=09vd->v4l2_dev =3D &vv->v4l2_dev;
> > +=09vd->vfl_dir =3D VFL_DIR_M2M;
> > +=09vd->ioctl_ops =3D NULL;
> > +=09vd->fops =3D &virtio_video_device_fops;
> > +=09vd->device_caps =3D V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
> > +=09vd->release =3D video_device_release_empty;
> > +
> > +=09/* Use the selection API instead */
> > +=09v4l2_disable_ioctl(vd, VIDIOC_CROPCAP);
> > +=09v4l2_disable_ioctl(vd, VIDIOC_G_CROP);
> > +=09v4l2_disable_ioctl(vd, VIDIOC_S_CROP);
>=20
> This should not be necessary if you set vd->device_caps.
>=20
> > +
> > +=09video_set_drvdata(vd, vvd);
> > +
> > +=09INIT_LIST_HEAD(&vvd->input_fmt_list);
> > +=09INIT_LIST_HEAD(&vvd->output_fmt_list);
> > +=09INIT_LIST_HEAD(&vvd->controls_fmt_list);
> > +
> > +=09vvd->num_output_fmts =3D 0;
> > +=09vvd->num_input_fmts =3D 0;
> > +
> > +=09switch (vv->vdev->id.device) {
> > +=09case VIRTIO_ID_VIDEO_ENC:
> > +=09=09vvd->type =3D VIRTIO_VIDEO_DEVICE_ENCODER;
> > +=09=09break;
> > +=09case VIRTIO_ID_VIDEO_DEC:
> > +=09default:
> > +=09=09vvd->type =3D VIRTIO_VIDEO_DEVICE_DECODER;
> > +=09=09break;
> > +=09}
> > +
> > +=09return vvd;
> > +
> > +err:
> > +=09devm_kfree(dev, vvd);
> > +
> > +=09return ERR_CAST(m2m_dev);
> > +}
> > +
> > +void virtio_video_device_destroy(struct virtio_video_device *vvd)
> > +{
> > +=09if (!vvd)
> > +=09=09return;
> > +
> > +=09v4l2_m2m_release(vvd->m2m_dev);
> > +=09devm_kfree(&vvd->vv->vdev->dev, vvd);
> > +}
> > +
> > +int virtio_video_device_init(struct virtio_video *vv,
> > +=09=09=09     void *input_buf, void *output_buf)
> > +{
> > +=09int ret =3D 0;
> > +=09struct virtio_video_device *vvd =3D NULL;
> > +
> > +=09if (!vv || !input_buf || !output_buf)
> > +=09=09return -EINVAL;
> > +
> > +
> > +=09vvd =3D virtio_video_device_create(vv);
> > +=09if (IS_ERR(vvd)) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "failed to create virtio video device\n");
> > +=09=09ret =3D PTR_ERR(vvd);
> > +=09=09goto failed;
> > +=09}
> > +
> > +=09ret =3D virtio_video_parse_virtio_capability(vvd, input_buf,=20
output_buf);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to parse a=20
function\n");
> > +=09=09virtio_video_device_destroy(vvd);
> > +=09=09ret =3D -EINVAL;
> > +=09=09goto failed;
> > +=09}
> > +
> > +=09ret =3D virtio_video_parse_virtio_control(vvd);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to query controls\n");
> > +=09=09virtio_video_clean_capability(vvd);
> > +=09=09virtio_video_device_destroy(vvd);
> > +=09=09goto failed;
> > +=09}
> > +
> > +=09ret =3D virtio_video_device_register(vvd);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "failed to init virtio video device\n");
> > +=09=09virtio_video_clean_control(vvd);
> > +=09=09virtio_video_clean_capability(vvd);
> > +=09=09virtio_video_device_destroy(vvd);
> > +=09=09goto failed;
> > +=09}
> > +
> > +=09return 0;
> > +
> > +failed:
> > +=09virtio_video_device_deinit(vv);
> > +
> > +=09return ret;
> > +}
> > +
> > +void virtio_video_device_deinit(struct virtio_video *vv)
> > +{
> > +=09struct virtio_video_device *vvd =3D NULL, *tmp =3D NULL;
> > +
> > +=09list_for_each_entry_safe(vvd, tmp, &vv->devices_list,
> > +=09=09=09=09 devices_list_entry) {
> > +=09=09virtio_video_device_unregister(vvd);
> > +=09=09virtio_video_clean_control(vvd);
> > +=09=09virtio_video_clean_capability(vvd);
> > +=09=09virtio_video_device_destroy(vvd);
> > +=09}
> > +}
> > diff --git a/drivers/media/virtio/virtio_video_driver.c
> > b/drivers/media/virtio/virtio_video_driver.c new file mode 100644
> > index 000000000000..2d4fd7671f4f
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_driver.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/version.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include "virtio_video.h"
> > +
> > +static unsigned int debug;
> > +module_param(debug, uint, 0644);
> > +
> > +static unsigned int use_dma_mem;
> > +module_param(use_dma_mem, uint, 0644);
> > +MODULE_PARM_DESC(use_dma_mem, "Try to allocate buffers from the DMA
> > zone"); +
> > +static void virtio_video_init_vq(struct virtio_video_queue *vvq,
> > +=09=09=09=09 void (*work_func)(struct=20
work_struct *work))
> > +{
> > +=09spin_lock_init(&vvq->qlock);
> > +=09init_waitqueue_head(&vvq->ack_queue);
> > +=09INIT_WORK(&vvq->dequeue_work, work_func);
> > +}
> > +
> > +static void *dma_phys_alloc(struct device *dev, size_t size,
> > +=09=09=09    dma_addr_t *dma_handle, gfp_t gfp,
> > +=09=09=09    unsigned long attrs)
> > +{
> > +=09void *ret;
> > +
> > +=09ret =3D (void *)__get_free_pages(gfp, get_order(size));
> > +=09if (ret)
> > +=09=09*dma_handle =3D virt_to_phys(ret) - PFN_PHYS(dev-
>dma_pfn_offset);
> > +
> > +=09return ret;
> > +}
> > +
> > +static void dma_phys_free(struct device *dev, size_t size,
> > +=09=09=09  void *cpu_addr, dma_addr_t dma_addr,
> > +=09=09=09  unsigned long attrs)
> > +{
> > +=09free_pages((unsigned long)cpu_addr, get_order(size));
> > +}
> > +
> > +static dma_addr_t dma_phys_map_page(struct device *dev, struct page
> > *page,
> > +=09=09=09=09    unsigned long offset, size_t=20
size,
> > +=09=09=09=09    enum dma_data_direction dir,
> > +=09=09=09=09    unsigned long attrs)
> > +{
> > +=09return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
> > +}
> > +
> > +static int dma_phys_map_sg(struct device *dev, struct scatterlist *sgl=
,
> > +=09=09=09   int nents, enum dma_data_direction dir,
> > +=09=09=09   unsigned long attrs)
> > +{
> > +=09int i;
> > +=09struct scatterlist *sg;
> > +
> > +=09for_each_sg(sgl, sg, nents, i) {
> > +=09=09dma_addr_t offset =3D PFN_PHYS(dev->dma_pfn_offset);
> > +=09=09void *va;
> > +
> > +=09=09BUG_ON(!sg_page(sg));
> > +=09=09va =3D sg_virt(sg);
> > +=09=09sg_dma_address(sg) =3D (dma_addr_t)virt_to_phys(va) -=20
offset;
> > +=09=09sg_dma_len(sg) =3D sg->length;
> > +=09}
> > +
> > +=09return nents;
> > +}
> > +
> > +const struct dma_map_ops dma_phys_ops =3D {
> > +=09.alloc=09=09=09=3D dma_phys_alloc,
> > +=09.free=09=09=09=3D dma_phys_free,
> > +=09.map_page=09=09=3D dma_phys_map_page,
> > +=09.map_sg=09=09=09=3D dma_phys_map_sg,
> > +};
> > +
> > +static int virtio_video_query_cap_resp_buf(struct virtio_video *vv, vo=
id
> > +=09=09=09=09=09   **resp_buf, int=20
queue_type)
> > +{
> > +=09int ret =3D 0;
> > +=09int resp_size =3D vv->max_caps_len;
> > +
> > +=09*resp_buf =3D kzalloc(vv->max_caps_len, GFP_KERNEL);
> > +=09if (IS_ERR(*resp_buf)) {
> > +=09=09ret =3D PTR_ERR(*resp_buf);
> > +=09=09goto err;
> > +=09}
> > +
> > +=09vv->got_caps =3D false;
> > +=09ret =3D virtio_video_query_capability(vv, *resp_buf, resp_size,
> > +=09=09=09=09=09    queue_type);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to query=20
capability\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, vv->got_caps, 5 * HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for get=20
caps\n");
> > +=09=09ret =3D -EIO;
> > +=09=09goto err;
> > +=09}
> > +
> > +=09return 0;
> > +err:
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_init(struct virtio_video *vv)
> > +{
> > +=09int ret =3D 0;
> > +=09void *input_resp_buf =3D NULL;
> > +=09void *output_resp_buf =3D NULL;
> > +
> > +=09if (!vv)
> > +=09=09return -EINVAL;
> > +
> > +=09ret =3D virtio_video_query_cap_resp_buf(vv, &input_resp_buf,
> > +=09=09=09=09=09     =20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get input caps\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D virtio_video_query_cap_resp_buf(vv, &output_resp_buf,
> > +=09=09=09=09=09     =20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to get output caps\n");
> > +=09=09goto err;
> > +=09}
> > +
> > +=09ret =3D virtio_video_device_init(vv, input_resp_buf,=20
output_resp_buf);
> > +=09if (ret)
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to initialize=20
devices\n");
> > +
> > +err:
> > +=09kfree(input_resp_buf);
> > +=09kfree(output_resp_buf);
> > +
> > +=09return ret;
> > +};
> > +
> > +static int virtio_video_probe(struct virtio_device *vdev)
> > +{
> > +=09int ret;
> > +=09struct virtio_video *vv;
> > +=09struct virtqueue *vqs[2];
> > +=09struct device *dev =3D &vdev->dev;
> > +
> > +=09static const char * const names[] =3D { "control", "event" };
> > +=09static vq_callback_t *callbacks[] =3D {
> > +=09=09virtio_video_cmd_ack,
> > +=09=09virtio_video_event_ack
> > +=09};
> > +
> > +=09if (!virtio_has_feature(vdev,=20
VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES)) {
> > +=09=09dev_err(dev, "device must support guest allocated=20
buffers\n");
> > +=09=09return -ENODEV;
> > +=09}
> > +
> > +=09vv =3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
>=20
> devm_kzalloc tends to be a bad idea, since this memory is freed as soon a=
s
> this driver is unbound, even if an application is still using it.
>=20
> It would be a good idea to test unbinding this driver while someone is
> streaming from it.
>=20
> > +=09if (!vv)
> > +=09=09return -ENOMEM;
> > +
> > +=09vv->vdev =3D vdev;
> > +=09vv->debug =3D debug;
> > +=09vv->use_dma_mem =3D use_dma_mem;
> > +=09vdev->priv =3D vv;
> > +
> > +=09spin_lock_init(&vv->resource_idr_lock);
> > +=09idr_init(&vv->resource_idr);
> > +=09spin_lock_init(&vv->stream_idr_lock);
> > +=09idr_init(&vv->stream_idr);
> > +
> > +=09init_waitqueue_head(&vv->wq);
> > +
> > +=09if (virtio_has_feature(vdev, VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG))
> > +=09=09vv->supp_non_contig =3D true;
> > +
> > +=09vv->has_iommu =3D !virtio_has_iommu_quirk(vdev);
> > +=09if (!vv->has_iommu)
> > +=09=09set_dma_ops(dev, &dma_phys_ops);
> > +
> > +=09dev_set_name(dev, "%s.%i", DRIVER_NAME, vdev->index);
> > +=09ret =3D v4l2_device_register(dev, &vv->v4l2_dev);
> > +=09if (ret)
> > +=09=09goto err_v4l2_reg;
> > +
> > +=09virtio_video_init_vq(&vv->commandq,=20
virtio_video_dequeue_cmd_func);
> > +=09virtio_video_init_vq(&vv->eventq,=20
virtio_video_dequeue_event_func);
> > +
> > +=09ret =3D virtio_find_vqs(vdev, 2, vqs, callbacks, names, NULL);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to find virt queues\n");
> > +=09=09goto err_vqs;
> > +=09}
> > +
> > +=09vv->commandq.vq =3D vqs[0];
> > +=09vv->eventq.vq =3D vqs[1];
> > +
> > +=09ret =3D virtio_video_alloc_vbufs(vv);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to alloc vbufs\n");
> > +=09=09goto err_vbufs;
> > +=09}
> > +
> > +=09virtio_cread(vdev, struct virtio_video_config, max_caps_length,
> > +=09=09     &vv->max_caps_len);
> > +=09if (!vv->max_caps_len) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "max_caps_len is zero\n");
> > +=09=09ret =3D -EINVAL;
> > +=09=09goto err_config;
> > +=09}
> > +
> > +=09virtio_cread(vdev, struct virtio_video_config, max_resp_length,
> > +=09=09     &vv->max_resp_len);
> > +=09if (!vv->max_resp_len) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "max_resp_len is zero\n");
> > +=09=09ret =3D -EINVAL;
> > +=09=09goto err_config;
> > +=09}
> > +
> > +=09ret =3D virtio_video_alloc_events(vv, vv->eventq.vq->num_free);
> > +=09if (ret)
> > +=09=09goto err_events;
> > +
> > +=09virtio_device_ready(vdev);
> > +=09vv->vq_ready =3D true;
> > +=09vv->got_caps =3D false;
> > +
> > +=09INIT_LIST_HEAD(&vv->devices_list);
> > +
> > +=09ret =3D virtio_video_init(vv);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "failed to init virtio video\n");
> > +=09=09goto err_init;
> > +=09}
> > +
> > +=09return 0;
> > +
> > +err_init:
> > +err_events:
> > +err_config:
> > +=09virtio_video_free_vbufs(vv);
> > +err_vbufs:
> > +=09vdev->config->del_vqs(vdev);
> > +err_vqs:
> > +=09v4l2_device_unregister(&vv->v4l2_dev);
> > +err_v4l2_reg:
> > +=09devm_kfree(&vdev->dev, vv);
> > +
> > +=09return ret;
> > +}
> > +
> > +static void virtio_video_remove(struct virtio_device *vdev)
> > +{
> > +=09struct virtio_video *vv =3D vdev->priv;
> > +
> > +=09virtio_video_device_deinit(vv);
> > +=09virtio_video_free_vbufs(vv);
> > +=09vdev->config->del_vqs(vdev);
> > +=09v4l2_device_unregister(&vv->v4l2_dev);
> > +=09devm_kfree(&vdev->dev, vv);
> > +}
> > +
> > +static struct virtio_device_id id_table[] =3D {
> > +=09{ VIRTIO_ID_VIDEO_DEC, VIRTIO_DEV_ANY_ID },
> > +=09{ VIRTIO_ID_VIDEO_ENC, VIRTIO_DEV_ANY_ID },
> > +=09{ 0 },
> > +};
> > +
> > +static unsigned int features[] =3D {
> > +=09VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES,
> > +=09VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG,
> > +};
> > +
> > +static struct virtio_driver virtio_video_driver =3D {
> > +=09.feature_table =3D features,
> > +=09.feature_table_size =3D ARRAY_SIZE(features),
> > +=09.driver.name =3D DRIVER_NAME,
> > +=09.driver.owner =3D THIS_MODULE,
> > +=09.id_table =3D id_table,
> > +=09.probe =3D virtio_video_probe,
> > +=09.remove =3D virtio_video_remove,
> > +};
> > +
> > +module_virtio_driver(virtio_video_driver);
> > +
> > +MODULE_DEVICE_TABLE(virtio, id_table);
> > +MODULE_DESCRIPTION("virtio video driver");
> > +MODULE_AUTHOR("Dmitry Sepp <dmitry.sepp@opensynergy.com>");
> > +MODULE_AUTHOR("Kiran Pawar <kiran.pawar@opensynergy.com>");
> > +MODULE_AUTHOR("Nikolay Martyanov <nikolay.martyanov@opensynergy.com>")=
;
> > +MODULE_AUTHOR("Samiullah Khawaja <samiullah.khawaja@opensynergy.com>")=
;
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/virtio/virtio_video_enc.c
> > b/drivers/media/virtio/virtio_video_enc.c new file mode 100644
> > index 000000000000..d9bd5f293900
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_enc.c
> > @@ -0,0 +1,569 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Encoder for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-ioctl.h>
> > +
> > +#include "virtio_video.h"
> > +
> > +static void virtio_video_enc_buf_queue(struct vb2_buffer *vb)
> > +{
> > +=09struct vb2_v4l2_buffer *v4l2_vb =3D to_vb2_v4l2_buffer(vb);
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vb-
>vb2_queue);
> > +
> > +=09v4l2_m2m_buf_queue(stream->fh.m2m_ctx, v4l2_vb);
> > +
> > +}
> > +
> > +static int virtio_video_enc_start_streaming(struct vb2_queue *vq,
> > +=09=09=09=09=09unsigned int count)
> > +{
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +=09bool input_queue =3D V4L2_TYPE_IS_OUTPUT(vq->type);
> > +
> > +=09if (stream->state =3D=3D STREAM_STATE_INIT ||
> > +=09    (!input_queue && stream->state =3D=3D STREAM_STATE_RESET) ||
> > +=09    (input_queue && stream->state =3D=3D STREAM_STATE_STOPPED))
> > +=09=09stream->state =3D STREAM_STATE_RUNNING;
> > +
> > +=09return 0;
> > +}
> > +
> > +static void virtio_video_enc_stop_streaming(struct vb2_queue *vq)
> > +{
> > +=09int ret, queue_type;
> > +=09bool *cleared;
> > +=09bool is_v4l2_output =3D V4L2_TYPE_IS_OUTPUT(vq->type);
> > +=09struct virtio_video_stream *stream =3D vb2_get_drv_priv(vq);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct vb2_v4l2_buffer *v4l2_vb;
> > +
> > +=09if (is_v4l2_output) {
> > +=09=09cleared =3D &stream->src_cleared;
> > +=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT;
> > +=09} else {
> > +=09=09cleared =3D &stream->dst_cleared;
> > +=09=09queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT;
> > +=09}
> > +
> > +=09ret =3D virtio_video_cmd_queue_clear(vv, stream, queue_type);
> > +=09if (ret) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "failed to clear queue\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, *cleared, 5 * HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for queue=20
clear\n");
> > +=09=09return;
> > +=09}
> > +
> > +=09for (;;) {
> > +=09=09if (is_v4l2_output)
> > +=09=09=09v4l2_vb =3D v4l2_m2m_src_buf_remove(stream-
>fh.m2m_ctx);
> > +=09=09else
> > +=09=09=09v4l2_vb =3D v4l2_m2m_dst_buf_remove(stream-
>fh.m2m_ctx);
> > +=09=09if (!v4l2_vb)
> > +=09=09=09break;
> > +=09=09v4l2_m2m_buf_done(v4l2_vb, VB2_BUF_STATE_ERROR);
> > +=09}
> > +
> > +=09if (is_v4l2_output)
> > +=09=09stream->state =3D STREAM_STATE_STOPPED;
> > +=09else
> > +=09=09stream->state =3D STREAM_STATE_RESET;
> > +}
> > +
> > +static const struct vb2_ops virtio_video_enc_qops =3D {
> > +=09.queue_setup=09 =3D virtio_video_queue_setup,
> > +=09.buf_init=09 =3D virtio_video_buf_init,
> > +=09.buf_cleanup=09 =3D virtio_video_buf_cleanup,
> > +=09.buf_queue=09 =3D virtio_video_enc_buf_queue,
> > +=09.start_streaming =3D virtio_video_enc_start_streaming,
> > +=09.stop_streaming  =3D virtio_video_enc_stop_streaming,
> > +=09.wait_prepare=09 =3D vb2_ops_wait_prepare,
> > +=09.wait_finish=09 =3D vb2_ops_wait_finish,
> > +};
> > +
> > +static int virtio_video_enc_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +=09int ret =3D 0;
> > +=09struct virtio_video_stream *stream =3D ctrl2stream(ctrl);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09uint32_t control, value;
> > +
> > +=09control =3D virtio_video_v4l2_control_to_virtio(ctrl->id);
> > +
> > +=09switch (ctrl->id) {
> > +=09case V4L2_CID_MPEG_VIDEO_BITRATE:
> > +=09=09ret =3D virtio_video_cmd_set_control(vv, stream-
>stream_id,
> > +=09=09=09=09=09=09   control,=20
ctrl->val);
> > +=09=09break;
> > +=09case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
> > +=09=09value =3D virtio_video_v4l2_level_to_virtio(ctrl->val);
> > +=09=09ret =3D virtio_video_cmd_set_control(vv, stream-
>stream_id,
> > +=09=09=09=09=09=09   control,=20
value);
> > +=09=09break;
> > +=09case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
> > +=09=09value =3D virtio_video_v4l2_profile_to_virtio(ctrl->val);
> > +=09=09ret =3D virtio_video_cmd_set_control(vv, stream-
>stream_id,
> > +=09=09=09=09=09=09   control,=20
value);
> > +=09=09break;
> > +=09default:
> > +=09=09ret =3D -EINVAL;
> > +=09=09break;
> > +=09}
> > +
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_enc_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +=09int ret =3D 0;
> > +=09struct virtio_video_stream *stream =3D ctrl2stream(ctrl);
> > +
> > +=09switch (ctrl->id) {
>=20
> > +=09case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
> Same as for the decoder: this shouldn't need to be volatile.
>=20
> Note: I'm not repeating comments I made for the decoder if they apply
> equally to the encoder.
>=20
> > +=09=09if (stream->state >=3D STREAM_STATE_INIT)
> > +=09=09=09ctrl->val =3D stream->in_info.min_buffers;
> > +=09=09else
> > +=09=09=09ctrl->val =3D 0;
> > +=09=09break;
> > +=09default:
> > +=09=09ret =3D -EINVAL;
> > +=09}
> > +
> > +=09return ret;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops virtio_video_enc_ctrl_ops =3D {
> > +=09.g_volatile_ctrl=09=3D virtio_video_enc_g_volatile_ctrl,
> > +=09.s_ctrl=09=09=09=3D virtio_video_enc_s_ctrl,
> > +};
> > +
> > +int virtio_video_enc_init_ctrls(struct virtio_video_stream *stream)
> > +{
> > +=09struct v4l2_ctrl *ctrl;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct video_control_format *c_fmt =3D NULL;
> > +
> > +=09v4l2_ctrl_handler_init(&stream->ctrl_handler, 1);
> > +
> > +=09ctrl =3D v4l2_ctrl_new_std(&stream->ctrl_handler,
> > +=09=09=09=09&virtio_video_enc_ctrl_ops,
> > +=09=09=09=09V4L2_CID_MIN_BUFFERS_FOR_OUTPUT,
> > +=09=09=09=09MIN_BUFS_MIN, MIN_BUFS_MAX,=20
MIN_BUFS_STEP,
> > +=09=09=09=09MIN_BUFS_DEF);
> > +=09ctrl->flags |=3D V4L2_CTRL_FLAG_VOLATILE;
> > +
> > +=09list_for_each_entry(c_fmt, &vvd->controls_fmt_list,
> > +=09=09=09    controls_list_entry) {
> > +=09=09switch (c_fmt->format) {
> > +=09=09case V4L2_PIX_FMT_H264:
> > +=09=09=09if (c_fmt->profile)
> > +=09=09=09=09v4l2_ctrl_new_std_menu
> > +=09=09=09=09=09(&stream-
>ctrl_handler,
> > +=09=09=09=09=09=20
&virtio_video_enc_ctrl_ops,
> > +=09=09=09=09=09=20
V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> > +=09=09=09=09=09 c_fmt->profile->max,
> > +=09=09=09=09=09 c_fmt->profile-
>skip_mask,
> > +=09=09=09=09=09 c_fmt->profile->min);
> > +
> > +=09=09=09if (c_fmt->level)
> > +=09=09=09=09v4l2_ctrl_new_std_menu
> > +=09=09=09=09=09(&stream-
>ctrl_handler,
> > +=09=09=09=09=09=20
&virtio_video_enc_ctrl_ops,
> > +=09=09=09=09=09=20
V4L2_CID_MPEG_VIDEO_H264_LEVEL,
> > +=09=09=09=09=09 c_fmt->level->max,
> > +=09=09=09=09=09 c_fmt->level-
>skip_mask,
> > +=09=09=09=09=09 c_fmt->level->min);
> > +=09=09=09break;
> > +=09=09default:
> > +=09=09=09v4l2_dbg(1, vv->debug,
> > +=09=09=09=09 &vv->v4l2_dev, "unsupported=20
format\n");
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +
> > +=09if (stream->control.bitrate) {
> > +=09=09v4l2_ctrl_new_std(&stream->ctrl_handler,
> > +=09=09=09=09  &virtio_video_enc_ctrl_ops,
> > +=09=09=09=09  V4L2_CID_MPEG_VIDEO_BITRATE,
> > +=09=09=09=09  1, stream->control.bitrate,
> > +=09=09=09=09  1, stream->control.bitrate);
> > +=09}
> > +
> > +=09if (stream->ctrl_handler.error)
> > +=09=09return stream->ctrl_handler.error;
> > +
> > +=09v4l2_ctrl_handler_setup(&stream->ctrl_handler);
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_enc_init_queues(void *priv, struct vb2_queue *src_vq,
> > +=09=09=09=09 struct vb2_queue *dst_vq)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_stream *stream =3D priv;
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct device *dev =3D vv->v4l2_dev.dev;
> > +
> > +=09src_vq->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> > +=09src_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +=09src_vq->drv_priv =3D stream;
> > +=09src_vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);
> > +=09src_vq->ops =3D &virtio_video_enc_qops;
> > +=09src_vq->mem_ops =3D virtio_video_mem_ops(vv);
> > +=09src_vq->min_buffers_needed =3D stream->in_info.min_buffers;
> > +=09src_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +=09src_vq->lock =3D &stream->vq_mutex;
> > +=09src_vq->gfp_flags =3D virtio_video_gfp_flags(vv);
> > +=09src_vq->dev =3D dev;
> > +
> > +=09ret =3D vb2_queue_init(src_vq);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09dst_vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> > +=09dst_vq->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +=09dst_vq->drv_priv =3D stream;
> > +=09dst_vq->buf_struct_size =3D sizeof(struct virtio_video_buffer);
> > +=09dst_vq->ops =3D &virtio_video_enc_qops;
> > +=09dst_vq->mem_ops =3D virtio_video_mem_ops(vv);
> > +=09dst_vq->min_buffers_needed =3D stream->out_info.min_buffers;
> > +=09dst_vq->timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +=09dst_vq->lock =3D &stream->vq_mutex;
> > +=09dst_vq->gfp_flags =3D virtio_video_gfp_flags(vv);
> > +=09dst_vq->dev =3D dev;
> > +
> > +=09return vb2_queue_init(dst_vq);
> > +}
> > +
> > +static int virtio_video_try_encoder_cmd(struct file *file, void *fh,
> > +=09=09=09=09=09struct=20
v4l2_encoder_cmd *cmd)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09if (stream->state =3D=3D STREAM_STATE_DRAIN)
> > +=09=09return -EBUSY;
> > +
> > +=09switch (cmd->cmd) {
> > +=09case V4L2_ENC_CMD_STOP:
> > +=09case V4L2_ENC_CMD_START:
> > +=09=09if (cmd->flags !=3D 0) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "flags=3D%u are not=20
supported",
> > +=09=09=09=09 cmd->flags);
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +=09=09break;
> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_encoder_cmd(struct file *file, void *fh,
> > +=09=09=09=09    struct v4l2_encoder_cmd *cmd)
> > +{
> > +=09int ret;
> > +=09struct vb2_queue *src_vq, *dst_vq;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D video_drvdata(file);
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +
> > +=09ret =3D virtio_video_try_encoder_cmd(file, fh, cmd);
> > +=09if (ret < 0)
> > +=09=09return ret;
> > +
> > +=09dst_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09=20
V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
> > +
> > +=09switch (cmd->cmd) {
> > +=09case V4L2_ENC_CMD_START:
> > +=09=09vb2_clear_last_buffer_dequeued(dst_vq);
> > +=09=09stream->state =3D STREAM_STATE_RUNNING;
> > +=09=09break;
> > +=09case V4L2_ENC_CMD_STOP:
> > +=09=09src_vq =3D v4l2_m2m_get_vq(stream->fh.m2m_ctx,
> > +=09=09=09=09=09=20
V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
> > +
> > +=09=09if (!vb2_is_streaming(src_vq)) {
> > +=09=09=09v4l2_dbg(1, vv->debug,
> > +=09=09=09=09 &vv->v4l2_dev, "output is not=20
streaming\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +
> > +=09=09if (!vb2_is_streaming(dst_vq)) {
> > +=09=09=09v4l2_dbg(1, vv->debug,
> > +=09=09=09=09 &vv->v4l2_dev, "capture is not=20
streaming\n");
> > +=09=09=09return 0;
> > +=09=09}
> > +
> > +=09=09ret =3D virtio_video_cmd_stream_drain(vv, stream-
>stream_id);
> > +=09=09if (ret) {
> > +=09=09=09v4l2_err(&vv->v4l2_dev, "failed to drain=20
stream\n");
> > +=09=09=09return ret;
> > +=09=09}
> > +
> > +=09=09stream->state =3D STREAM_STATE_DRAIN;
> > +=09=09break;
> > +=09default:
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_enc_enum_fmt_vid_cap(struct file *file, void *=
fh,
> > +=09=09=09=09=09     struct=20
v4l2_fmtdesc *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format *fmt =3D NULL;
> > +=09int idx =3D 0;
> > +
> > +=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +=09=09return -EINVAL;
> > +
> > +=09if (f->index >=3D vvd->num_output_fmts)
> > +=09=09return -EINVAL;
> > +
> > +=09list_for_each_entry(fmt, &vvd->output_fmt_list,=20
formats_list_entry) {
> > +=09=09if (f->index =3D=3D idx) {
> > +=09=09=09f->pixelformat =3D fmt->desc.format;
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09idx++;
> > +=09}
> > +=09return -EINVAL;
> > +}
> > +
> > +static int virtio_video_enc_enum_fmt_vid_out(struct file *file, void *=
fh,
> > +=09=09=09=09=09     struct=20
v4l2_fmtdesc *f)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct video_format_info *info =3D NULL;
> > +=09struct video_format *fmt =3D NULL;
> > +=09unsigned long output_mask =3D 0;
> > +=09int idx =3D 0, bit_num =3D 0;
> > +
> > +=09if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +=09=09return -EINVAL;
> > +
> > +=09if (f->index >=3D vvd->num_input_fmts)
> > +=09=09return -EINVAL;
> > +
> > +=09info =3D &stream->out_info;
> > +=09list_for_each_entry(fmt, &vvd->output_fmt_list,=20
formats_list_entry) {
> > +=09=09if (info->fourcc_format =3D=3D fmt->desc.format) {
> > +=09=09=09output_mask =3D fmt->desc.mask;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +
> > +=09if (output_mask =3D=3D 0)
> > +=09=09return -EINVAL;
> > +
> > +=09list_for_each_entry(fmt, &vvd->input_fmt_list, formats_list_entry)=
=20
{
> > +=09=09if (test_bit(bit_num, &output_mask)) {
> > +=09=09=09if (f->index =3D=3D idx) {
> > +=09=09=09=09f->pixelformat =3D fmt-
>desc.format;
> > +=09=09=09=09return 0;
> > +=09=09=09}
> > +=09=09=09idx++;
> > +=09=09}
> > +=09=09bit_num++;
> > +=09}
> > +=09return -EINVAL;
> > +}
> > +
> > +static int virtio_video_enc_s_fmt(struct file *file, void *fh,
> > +=09=09=09=09  struct v4l2_format *f)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +
> > +=09ret =3D virtio_video_s_fmt(file, fh, f);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09if (!V4L2_TYPE_IS_OUTPUT(f->type)) {
> > +=09=09if (stream->state =3D=3D STREAM_STATE_IDLE)
> > +=09=09=09stream->state =3D STREAM_STATE_INIT;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_enc_try_framerate(struct virtio_video_stream
> > *stream, +=09=09=09=09=09  unsigned=20
int fps)
> > +{
> > +=09int rate_idx;
> > +=09struct video_format_frame *frame =3D NULL;
> > +
> > +=09if (stream->current_frame =3D=3D NULL)
> > +=09=09return -EINVAL;
> > +
> > +=09frame =3D stream->current_frame;
> > +=09for (rate_idx =3D 0; rate_idx < frame->frame.num_rates; rate_idx++)=
=20
{
> > +=09=09struct virtio_video_format_range *frame_rate =3D
> > +=09=09=09&frame->frame_rates[rate_idx];
> > +
> > +=09=09if (within_range(frame_rate->min, fps, frame_rate-
>max))
> > +=09=09=09return 0;
> > +=09}
> > +
> > +=09return -EINVAL;
> > +}
> > +
> > +static void virtio_video_timeperframe_from_info(struct video_format_in=
fo
> > *info, +=09=09=09=09=09=09struct=20
v4l2_fract *timeperframe)
> > +{
> > +=09timeperframe->numerator =3D info->frame_rate;
> > +=09timeperframe->denominator =3D 1;
> > +}
> > +
> > +static int virtio_video_enc_g_parm(struct file *file, void *priv,
> > +=09=09=09=09   struct v4l2_streamparm *a)
> > +{
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct v4l2_outputparm *out =3D &a->parm.output;
> > +=09struct v4l2_fract *timeperframe =3D &out->timeperframe;
> > +
> > +=09if (!V4L2_TYPE_IS_OUTPUT(a->type)) {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "getting FPS is only possible for the=20
output queue\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09out->capability =3D V4L2_CAP_TIMEPERFRAME;
> > +=09virtio_video_timeperframe_from_info(&stream->in_info,=20
timeperframe);
> > +
> > +=09return 0;
> > +}
> > +
> > +static int virtio_video_enc_s_parm(struct file *file, void *priv,
> > +=09=09=09=09   struct v4l2_streamparm *a)
> > +{
> > +=09int ret;
> > +=09u64 frame_interval, frame_rate;
> > +=09struct video_format_info info;
> > +=09struct virtio_video_stream *stream =3D file2stream(file);
> > +=09struct virtio_video_device *vvd =3D to_virtio_vd(stream->video_dev)=
;
> > +=09struct virtio_video *vv =3D vvd->vv;
> > +=09struct v4l2_outputparm *out =3D &a->parm.output;
> > +=09struct v4l2_fract *timeperframe =3D &out->timeperframe;
> > +
> > +=09if (V4L2_TYPE_IS_OUTPUT(a->type)) {
> > +=09=09frame_interval =3D timeperframe->numerator *=20
(u64)USEC_PER_SEC;
> > +=09=09do_div(frame_interval, timeperframe->denominator);
> > +=09=09if (!frame_interval)
> > +=09=09=09return -EINVAL;
> > +
> > +=09=09frame_rate =3D (u64)USEC_PER_SEC;
> > +=09=09do_div(frame_rate, frame_interval);
> > +=09} else {
> > +=09=09v4l2_err(&vv->v4l2_dev,
> > +=09=09=09 "setting FPS is only possible for the=20
output queue\n");
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09ret =3D virtio_video_enc_try_framerate(stream, frame_rate);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09virtio_video_format_fill_default_info(&info, &stream->in_info);
> > +=09info.frame_rate =3D frame_rate;
> > +
> > +=09virtio_video_cmd_set_params(vv, stream, &info,
> > +=09=09=09=09   =20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09virtio_video_cmd_get_params(vv, stream,=20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT);
> > +=09virtio_video_cmd_get_params(vv, stream,=20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +
> > +=09out->capability =3D V4L2_CAP_TIMEPERFRAME;
> > +=09virtio_video_timeperframe_from_info(&stream->in_info,=20
timeperframe);
> > +
> > +=09return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops virtio_video_enc_ioctl_ops =3D {
> > +=09.vidioc_querycap=09=3D virtio_video_querycap,
> > +
> > +=09.vidioc_enum_fmt_vid_cap =3D virtio_video_enc_enum_fmt_vid_cap,
> > +=09.vidioc_g_fmt_vid_cap=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_cap=09=3D virtio_video_enc_s_fmt,
> > +
> > +=09.vidioc_enum_fmt_vid_cap_mplane =3D=20
virtio_video_enc_enum_fmt_vid_cap,
> > +=09.vidioc_g_fmt_vid_cap_mplane=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_cap_mplane=09=3D virtio_video_enc_s_fmt,
> > +
> > +=09.vidioc_enum_fmt_vid_out =3D virtio_video_enc_enum_fmt_vid_out,
> > +=09.vidioc_g_fmt_vid_out=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_out=09=3D virtio_video_enc_s_fmt,
> > +
> > +=09.vidioc_enum_fmt_vid_out_mplane =3D=20
virtio_video_enc_enum_fmt_vid_out,
> > +=09.vidioc_g_fmt_vid_out_mplane=09=3D virtio_video_g_fmt,
> > +=09.vidioc_s_fmt_vid_out_mplane=09=3D virtio_video_enc_s_fmt,
> > +
> > +=09.vidioc_try_encoder_cmd=09=3D virtio_video_try_encoder_cmd,
> > +=09.vidioc_encoder_cmd=09=3D virtio_video_encoder_cmd,
> > +=09.vidioc_enum_frameintervals =3D virtio_video_enum_framemintervals,
> > +=09.vidioc_enum_framesizes =3D virtio_video_enum_framesizes,
> > +
> > +=09.vidioc_g_selection =3D virtio_video_g_selection,
> > +=09.vidioc_s_selection =3D virtio_video_s_selection,
> > +
> > +=09.vidioc_reqbufs=09=09=3D virtio_video_reqbufs,
> > +=09.vidioc_querybuf=09=3D v4l2_m2m_ioctl_querybuf,
> > +=09.vidioc_qbuf=09=09=3D v4l2_m2m_ioctl_qbuf,
> > +=09.vidioc_dqbuf=09=09=3D v4l2_m2m_ioctl_dqbuf,
> > +=09.vidioc_prepare_buf=09=3D v4l2_m2m_ioctl_prepare_buf,
> > +=09.vidioc_create_bufs=09=3D v4l2_m2m_ioctl_create_bufs,
> > +=09.vidioc_expbuf=09=09=3D v4l2_m2m_ioctl_expbuf,
> > +
> > +=09.vidioc_streamon=09=3D v4l2_m2m_ioctl_streamon,
> > +=09.vidioc_streamoff=09=3D v4l2_m2m_ioctl_streamoff,
> > +
> > +=09.vidioc_s_parm=09=09=3D virtio_video_enc_s_parm,
> > +=09.vidioc_g_parm=09=09=3D virtio_video_enc_g_parm,
> > +
> > +=09.vidioc_subscribe_event =3D virtio_video_subscribe_event,
> > +=09.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
> > +};
> > +
> > +int virtio_video_enc_init(struct video_device *vd)
> > +{
> > +=09ssize_t num;
> > +
> > +=09vd->ioctl_ops =3D &virtio_video_enc_ioctl_ops;
> > +=09num =3D strscpy(vd->name, "stateful-encoder", sizeof(vd->name));
> > +
> > +=09return 0;
> > +}
> > diff --git a/drivers/media/virtio/virtio_video_enc.h
> > b/drivers/media/virtio/virtio_video_enc.h new file mode 100644
> > index 000000000000..3d2a27a8e08c
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_enc.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/* Encoder header for virtio video driver.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#ifndef _VIRTIO_VIDEO_ENC_H
> > +#define _VIRTIO_VIDEO_ENC_H
> > +
> > +#include "virtio_video.h"
> > +
> > +int virtio_video_enc_init(struct video_device *vd);
> > +int virtio_video_enc_init_ctrls(struct virtio_video_stream *stream);
> > +int virtio_video_enc_init_queues(void *priv, struct vb2_queue *src_vq,
> > +=09=09=09=09 struct vb2_queue *dst_vq);
> > +
> > +#endif /* _VIRTIO_VIDEO_ENC_H */
> > diff --git a/drivers/media/virtio/virtio_video_helpers.c
> > b/drivers/media/virtio/virtio_video_helpers.c new file mode 100644
> > index 000000000000..bc4754e7ca78
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_helpers.c
> > @@ -0,0 +1,250 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include "virtio_video.h"
> > +
> > +struct virtio_video_convert_table {
> > +=09uint32_t virtio_value;
> > +=09uint32_t v4l2_value;
> > +};
> > +
> > +static struct virtio_video_convert_table level_table[] =3D {
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_1_0, V4L2_MPEG_VIDEO_H264_LEVEL_1_0 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_1_1, V4L2_MPEG_VIDEO_H264_LEVEL_1_1 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_1_2, V4L2_MPEG_VIDEO_H264_LEVEL_1_2 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_1_3, V4L2_MPEG_VIDEO_H264_LEVEL_1_3 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_2_0, V4L2_MPEG_VIDEO_H264_LEVEL_2_0 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_2_1, V4L2_MPEG_VIDEO_H264_LEVEL_2_1 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_2_2, V4L2_MPEG_VIDEO_H264_LEVEL_2_2 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_3_0, V4L2_MPEG_VIDEO_H264_LEVEL_3_0 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_3_1, V4L2_MPEG_VIDEO_H264_LEVEL_3_1 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_3_2, V4L2_MPEG_VIDEO_H264_LEVEL_3_2 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_4_0, V4L2_MPEG_VIDEO_H264_LEVEL_4_0 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_4_1, V4L2_MPEG_VIDEO_H264_LEVEL_4_1 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_4_2, V4L2_MPEG_VIDEO_H264_LEVEL_4_2 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_5_0, V4L2_MPEG_VIDEO_H264_LEVEL_5_0 },
> > +=09{ VIRTIO_VIDEO_LEVEL_H264_5_1, V4L2_MPEG_VIDEO_H264_LEVEL_5_1 },
> > +=09{ 0 },
> > +};
> > +
> > +uint32_t virtio_video_level_to_v4l2(uint32_t level)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(level_table); idx++) {
> > +=09=09if (level_table[idx].virtio_value =3D=3D level)
> > +=09=09=09return level_table[idx].v4l2_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +uint32_t virtio_video_v4l2_level_to_virtio(uint32_t v4l2_level)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(level_table); idx++) {
> > +=09=09if (level_table[idx].v4l2_value =3D=3D v4l2_level)
> > +=09=09=09return level_table[idx].virtio_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static struct virtio_video_convert_table profile_table[] =3D {
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_BASELINE,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_MAIN,=20
V4L2_MPEG_VIDEO_H264_PROFILE_MAIN },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_EXTENDED,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_HIGH,=20
V4L2_MPEG_VIDEO_H264_PROFILE_HIGH },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_HIGH10PROFILE,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10 },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_HIGH422PROFILE,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422},
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_HIGH444PREDICTIVEPROFILE,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_SCALABLEBASELINE,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_SCALABLEHIGH,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_STEREOHIGH,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH },
> > +=09{ VIRTIO_VIDEO_PROFILE_H264_MULTIVIEWHIGH,
> > +=09=09V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH },
> > +=09{ 0 },
> > +};
> > +
> > +uint32_t virtio_video_profile_to_v4l2(uint32_t profile)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(profile_table); idx++) {
> > +=09=09if (profile_table[idx].virtio_value =3D=3D profile)
> > +=09=09=09return profile_table[idx].v4l2_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +uint32_t virtio_video_v4l2_profile_to_virtio(uint32_t v4l2_profile)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(profile_table); idx++) {
> > +=09=09if (profile_table[idx].v4l2_value =3D=3D v4l2_profile)
> > +=09=09=09return profile_table[idx].virtio_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static struct virtio_video_convert_table format_table[] =3D {
> > +=09{ VIRTIO_VIDEO_FORMAT_ARGB8888, V4L2_PIX_FMT_ARGB32 },
> > +=09{ VIRTIO_VIDEO_FORMAT_BGRA8888, V4L2_PIX_FMT_ABGR32 },
> > +=09{ VIRTIO_VIDEO_FORMAT_NV12, V4L2_PIX_FMT_NV12 },
> > +=09{ VIRTIO_VIDEO_FORMAT_YUV420, V4L2_PIX_FMT_YUV420 },
> > +=09{ VIRTIO_VIDEO_FORMAT_YVU420, V4L2_PIX_FMT_YVU420 },
> > +=09{ VIRTIO_VIDEO_FORMAT_MPEG2, V4L2_PIX_FMT_MPEG2 },
> > +=09{ VIRTIO_VIDEO_FORMAT_MPEG4, V4L2_PIX_FMT_MPEG4 },
> > +=09{ VIRTIO_VIDEO_FORMAT_H264, V4L2_PIX_FMT_H264 },
> > +=09{ VIRTIO_VIDEO_FORMAT_HEVC, V4L2_PIX_FMT_HEVC },
> > +=09{ VIRTIO_VIDEO_FORMAT_VP8, V4L2_PIX_FMT_VP8 },
> > +=09{ VIRTIO_VIDEO_FORMAT_VP9, V4L2_PIX_FMT_VP9 },
>=20
> I *strongly* recommend adding V4L2_PIX_FMT_FWHT support as well so this
> driver can be tested with vicodec as the host driver.
>=20
> It allows regression testing without requiring special hardware.
>=20
> > +=09{ 0 },
> > +};
> > +
> > +uint32_t virtio_video_format_to_v4l2(uint32_t format)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(format_table); idx++) {
> > +=09=09if (format_table[idx].virtio_value =3D=3D format)
> > +=09=09=09return format_table[idx].v4l2_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +uint32_t virtio_video_v4l2_format_to_virtio(uint32_t v4l2_format)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(format_table); idx++) {
> > +=09=09if (format_table[idx].v4l2_value =3D=3D v4l2_format)
> > +=09=09=09return format_table[idx].virtio_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +static struct virtio_video_convert_table control_table[] =3D {
> > +=09{ VIRTIO_VIDEO_CONTROL_BITRATE, V4L2_CID_MPEG_VIDEO_BITRATE },
> > +=09{ VIRTIO_VIDEO_CONTROL_PROFILE, V4L2_CID_MPEG_VIDEO_H264_PROFILE=20
},
> > +=09{ VIRTIO_VIDEO_CONTROL_LEVEL, V4L2_CID_MPEG_VIDEO_H264_LEVEL },
> > +=09{ 0 },
> > +};
> > +
> > +uint32_t virtio_video_control_to_v4l2(uint32_t control)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(control_table); idx++) {
> > +=09=09if (control_table[idx].virtio_value =3D=3D control)
> > +=09=09=09return control_table[idx].v4l2_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +uint32_t virtio_video_v4l2_control_to_virtio(uint32_t v4l2_control)
> > +{
> > +=09size_t idx;
> > +
> > +=09for (idx =3D 0; idx < ARRAY_SIZE(control_table); idx++) {
> > +=09=09if (control_table[idx].v4l2_value =3D=3D v4l2_control)
> > +=09=09=09return control_table[idx].virtio_value;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +uint32_t virtio_video_get_format_from_virtio_profile(uint32_t
> > virtio_profile) +{
> > +=09if (virtio_profile >=3D VIRTIO_VIDEO_PROFILE_H264_MIN &&
> > +=09    virtio_profile <=3D VIRTIO_VIDEO_PROFILE_H264_MAX)
> > +=09=09return VIRTIO_VIDEO_FORMAT_H264;
> > +=09else if (virtio_profile >=3D VIRTIO_VIDEO_PROFILE_HEVC_MIN &&
> > +=09=09 virtio_profile <=3D VIRTIO_VIDEO_PROFILE_HEVC_MAX)
> > +=09=09return VIRTIO_VIDEO_FORMAT_HEVC;
> > +=09else if (virtio_profile >=3D VIRTIO_VIDEO_PROFILE_VP8_MIN &&
> > +=09=09 virtio_profile <=3D VIRTIO_VIDEO_PROFILE_VP8_MAX)
> > +=09=09return VIRTIO_VIDEO_FORMAT_VP8;
> > +=09else if (virtio_profile >=3D VIRTIO_VIDEO_PROFILE_VP9_MIN &&
> > +=09=09 virtio_profile <=3D VIRTIO_VIDEO_PROFILE_VP9_MAX)
> > +=09=09return VIRTIO_VIDEO_FORMAT_VP9;
> > +
> > +=09return 0;
> > +}
> > +
> > +struct video_format *find_video_format(struct list_head *fmts_list,
> > +=09=09=09=09       uint32_t format)
> > +{
> > +=09struct video_format *fmt =3D NULL;
> > +
> > +=09list_for_each_entry(fmt, fmts_list, formats_list_entry) {
> > +=09=09if (fmt->desc.format =3D=3D format)
> > +=09=09=09return fmt;
> > +=09}
> > +
> > +=09return NULL;
> > +}
> > +
> > +void virtio_video_format_from_info(struct video_format_info *info,
> > +=09=09=09=09   struct v4l2_pix_format_mplane=20
*pix_mp)
> > +{
> > +=09int i;
> > +
> > +=09pix_mp->width =3D info->frame_width;
> > +=09pix_mp->height =3D info->frame_height;
> > +=09pix_mp->field =3D V4L2_FIELD_NONE;
> > +=09pix_mp->colorspace =3D V4L2_COLORSPACE_REC709;
> > +=09pix_mp->xfer_func =3D 0;
> > +=09pix_mp->ycbcr_enc =3D 0;
> > +=09pix_mp->quantization =3D 0;
> > +=09memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
> > +=09memset(pix_mp->plane_fmt[0].reserved, 0,
> > +=09       sizeof(pix_mp->plane_fmt[0].reserved));
> > +
> > +=09pix_mp->num_planes =3D info->num_planes;
> > +=09pix_mp->pixelformat =3D info->fourcc_format;
> > +
> > +=09for (i =3D 0; i < info->num_planes; i++) {
> > +=09=09pix_mp->plane_fmt[i].bytesperline =3D
> > +=09=09=09=09=09 info-
>plane_format[i].stride;
> > +=09=09pix_mp->plane_fmt[i].sizeimage =3D
> > +=09=09=09=09=09 info-
>plane_format[i].plane_size;
> > +=09}
> > +}
> > +
> > +void virtio_video_format_fill_default_info(struct video_format_info
> > *dst_info, +=09=09=09=09=09  struct=20
video_format_info *src_info)
> > +{
> > +=09memcpy(dst_info, src_info, sizeof(*dst_info));
> > +}
> > diff --git a/drivers/media/virtio/virtio_video_vq.c
> > b/drivers/media/virtio/virtio_video_vq.c new file mode 100644
> > index 000000000000..4679e6b49cf3
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_video_vq.c
> > @@ -0,0 +1,1012 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for virtio video device.
> > + *
> > + * Copyright 2019 OpenSynergy GmbH.
> > + *
> > + * Based on drivers/gpu/drm/virtio/virtgpu_vq.c
> > + * Copyright (C) 2015 Red Hat, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
> > + */
> > +
> > +#include "virtio_video.h"
> > +
> > +#define MAX_INLINE_CMD_SIZE   298
> > +#define MAX_INLINE_RESP_SIZE  298
> > +#define VBUFFER_SIZE          (sizeof(struct virtio_video_vbuffer) \
> > +=09=09=09       + MAX_INLINE_CMD_SIZE=09=09
   \
> > +=09=09=09       + MAX_INLINE_RESP_SIZE)
> > +
> > +void virtio_video_resource_id_get(struct virtio_video *vv, uint32_t *i=
d)
> > +{
> > +=09int handle;
> > +
> > +=09idr_preload(GFP_KERNEL);
> > +=09spin_lock(&vv->resource_idr_lock);
> > +=09handle =3D idr_alloc(&vv->resource_idr, NULL, 1, 0, GFP_NOWAIT);
> > +=09spin_unlock(&vv->resource_idr_lock);
> > +=09idr_preload_end();
> > +=09*id =3D handle;
> > +}
> > +
> > +void virtio_video_resource_id_put(struct virtio_video *vv, uint32_t id=
)
> > +{
> > +=09spin_lock(&vv->resource_idr_lock);
> > +=09idr_remove(&vv->resource_idr, id);
> > +=09spin_unlock(&vv->resource_idr_lock);
> > +}
> > +
> > +void virtio_video_stream_id_get(struct virtio_video *vv,
> > +=09=09=09=09struct virtio_video_stream=20
*stream,
> > +=09=09=09=09uint32_t *id)
> > +{
> > +=09int handle;
> > +
> > +=09idr_preload(GFP_KERNEL);
> > +=09spin_lock(&vv->stream_idr_lock);
> > +=09handle =3D idr_alloc(&vv->stream_idr, stream, 1, 0, 0);
> > +=09spin_unlock(&vv->stream_idr_lock);
> > +=09idr_preload_end();
> > +=09*id =3D handle;
> > +}
> > +
> > +void virtio_video_stream_id_put(struct virtio_video *vv, uint32_t id)
> > +{
> > +=09spin_lock(&vv->stream_idr_lock);
> > +=09idr_remove(&vv->stream_idr, id);
> > +=09spin_unlock(&vv->stream_idr_lock);
> > +}
> > +
> > +void virtio_video_cmd_ack(struct virtqueue *vq)
> > +{
> > +=09struct virtio_video *vv =3D vq->vdev->priv;
> > +
> > +=09schedule_work(&vv->commandq.dequeue_work);
> > +}
> > +
> > +void virtio_video_event_ack(struct virtqueue *vq)
> > +{
> > +=09struct virtio_video *vv =3D vq->vdev->priv;
> > +
> > +=09schedule_work(&vv->eventq.dequeue_work);
> > +}
> > +
> > +static struct virtio_video_vbuffer *
> > +virtio_video_get_vbuf(struct virtio_video *vv, int size,
> > +=09=09      int resp_size, void *resp_buf,
> > +=09=09      virtio_video_resp_cb resp_cb)
> > +{
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09vbuf =3D kmem_cache_alloc(vv->vbufs, GFP_KERNEL);
> > +=09if (!vbuf)
> > +=09=09return ERR_PTR(-ENOMEM);
> > +=09memset(vbuf, 0, VBUFFER_SIZE);
> > +
> > +=09BUG_ON(size > MAX_INLINE_CMD_SIZE);
> > +=09vbuf->buf =3D (void *)vbuf + sizeof(*vbuf);
> > +=09vbuf->size =3D size;
> > +
> > +=09vbuf->resp_cb =3D resp_cb;
> > +=09vbuf->resp_size =3D resp_size;
> > +=09if (resp_size <=3D MAX_INLINE_RESP_SIZE && !resp_buf)
> > +=09=09vbuf->resp_buf =3D (void *)vbuf->buf + size;
> > +=09else
> > +=09=09vbuf->resp_buf =3D resp_buf;
> > +=09BUG_ON(!vbuf->resp_buf);
> > +
> > +=09return vbuf;
> > +}
> > +
> > +static void free_vbuf(struct virtio_video *vv,
> > +=09=09      struct virtio_video_vbuffer *vbuf)
> > +{
> > +=09if (!vbuf->resp_cb &&
> > +=09    vbuf->resp_size > MAX_INLINE_RESP_SIZE)
> > +=09=09kfree(vbuf->resp_buf);
> > +=09kfree(vbuf->data_buf);
> > +=09kmem_cache_free(vv->vbufs, vbuf);
> > +}
> > +
> > +static void reclaim_vbufs(struct virtqueue *vq, struct list_head
> > *reclaim_list) +{
> > +=09struct virtio_video_vbuffer *vbuf;
> > +=09unsigned int len;
> > +=09struct virtio_video *vv =3D vq->vdev->priv;
> > +=09int freed =3D 0;
> > +
> > +=09while ((vbuf =3D virtqueue_get_buf(vq, &len))) {
> > +=09=09list_add_tail(&vbuf->list, reclaim_list);
> > +=09=09freed++;
> > +=09}
> > +=09if (freed =3D=3D 0)
> > +=09=09v4l2_dbg(1, vv->debug, &vv->v4l2_dev,
> > +=09=09=09 "zero vbufs reclaimed\n");
> > +}
> > +
> > +static void detach_vbufs(struct virtqueue *vq, struct list_head
> > *detach_list) +{
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09while ((vbuf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)
> > +=09=09list_add_tail(&vbuf->list, detach_list);
> > +}
> > +
> > +static void virtio_video_deatch_vbufs(struct virtio_video *vv)
>=20
> deatch -> detach
>=20
> > +{
> > +=09struct list_head detach_list;
> > +=09struct virtio_video_vbuffer *entry, *tmp;
> > +
> > +=09INIT_LIST_HEAD(&detach_list);
> > +
> > +=09detach_vbufs(vv->eventq.vq, &detach_list);
> > +=09detach_vbufs(vv->commandq.vq, &detach_list);
> > +
> > +=09if (list_empty(&detach_list))
> > +=09=09return;
> > +
> > +=09list_for_each_entry_safe(entry, tmp, &detach_list, list) {
> > +=09=09list_del(&entry->list);
> > +=09=09free_vbuf(vv, entry);
> > +=09}
> > +}
> > +
> > +int virtio_video_alloc_vbufs(struct virtio_video *vv)
> > +{
> > +=09vv->vbufs =3D
> > +=09=09kmem_cache_create("virtio-video-vbufs", VBUFFER_SIZE,
> > +=09=09=09=09  __alignof__(struct=20
virtio_video_vbuffer), 0,
> > +=09=09=09=09  NULL);
> > +=09if (!vv->vbufs)
> > +=09=09return -ENOMEM;
> > +
> > +=09return 0;
> > +}
> > +
> > +void virtio_video_free_vbufs(struct virtio_video *vv)
> > +{
> > +=09virtio_video_deatch_vbufs(vv);
> > +=09kmem_cache_destroy(vv->vbufs);
> > +=09vv->vbufs =3D NULL;
> > +}
> > +
> > +static void *virtio_video_alloc_req(struct virtio_video *vv,
> > +=09=09=09=09    struct virtio_video_vbuffer=20
**vbuffer_p,
> > +=09=09=09=09    int size)
> > +{
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09vbuf =3D virtio_video_get_vbuf(vv, size,
> > +=09=09=09=09     sizeof(struct=20
virtio_video_cmd_hdr),
> > +=09=09=09=09     NULL, NULL);
> > +=09if (IS_ERR(vbuf)) {
> > +=09=09*vbuffer_p =3D NULL;
> > +=09=09return ERR_CAST(vbuf);
> > +=09}
> > +=09*vbuffer_p =3D vbuf;
> > +
> > +=09return vbuf->buf;
> > +}
> > +
> > +static void *
> > +virtio_video_alloc_req_resp(struct virtio_video *vv,
> > +=09=09=09    virtio_video_resp_cb cb,
> > +=09=09=09    struct virtio_video_vbuffer **vbuffer_p,
> > +=09=09=09    int req_size, int resp_size,
> > +=09=09=09    void *resp_buf)
> > +{
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09vbuf =3D virtio_video_get_vbuf(vv, req_size, resp_size, resp_buf,=
=20
cb);
> > +=09if (IS_ERR(vbuf)) {
> > +=09=09*vbuffer_p =3D NULL;
> > +=09=09return ERR_CAST(vbuf);
> > +=09}
> > +=09*vbuffer_p =3D vbuf;
> > +
> > +=09return vbuf->buf;
> > +}
> > +
> > +void virtio_video_dequeue_cmd_func(struct work_struct *work)
> > +{
> > +=09struct virtio_video *vv =3D
> > +=09=09container_of(work, struct virtio_video,
> > +=09=09=09     commandq.dequeue_work);
> > +=09struct list_head reclaim_list;
> > +=09struct virtio_video_vbuffer *entry, *tmp;
> > +=09struct virtio_video_cmd_hdr *resp;
> > +
> > +=09INIT_LIST_HEAD(&reclaim_list);
> > +=09spin_lock(&vv->commandq.qlock);
> > +=09do {
> > +=09=09virtqueue_disable_cb(vv->commandq.vq);
> > +=09=09reclaim_vbufs(vv->commandq.vq, &reclaim_list);
> > +
> > +=09} while (!virtqueue_enable_cb(vv->commandq.vq));
> > +=09spin_unlock(&vv->commandq.qlock);
> > +
> > +=09list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> > +=09=09resp =3D (struct virtio_video_cmd_hdr *)entry->resp_buf;
> > +=09=09if (resp->type >=3D
> > +=09=09   =20
cpu_to_le32(VIRTIO_VIDEO_RESP_ERR_INVALID_OPERATION))
> > +=09=09=09v4l2_dbg(1, vv->debug, &vv->v4l2_dev,
> > +=09=09=09=09 "response 0x%x\n",=20
le32_to_cpu(resp->type));
> > +=09=09if (entry->resp_cb)
> > +=09=09=09entry->resp_cb(vv, entry);
> > +
> > +=09=09list_del(&entry->list);
> > +=09=09free_vbuf(vv, entry);
> > +=09}
> > +=09wake_up(&vv->commandq.ack_queue);
> > +}
> > +
> > +void virtio_video_dequeue_event_func(struct work_struct *work)
> > +{
> > +=09struct virtio_video *vv =3D
> > +=09=09container_of(work, struct virtio_video,
> > +=09=09=09     eventq.dequeue_work);
> > +=09struct list_head reclaim_list;
> > +=09struct virtio_video_vbuffer *entry, *tmp;
> > +
> > +=09INIT_LIST_HEAD(&reclaim_list);
> > +=09spin_lock(&vv->eventq.qlock);
> > +=09do {
> > +=09=09virtqueue_disable_cb(vv->eventq.vq);
> > +=09=09reclaim_vbufs(vv->eventq.vq, &reclaim_list);
> > +
> > +=09} while (!virtqueue_enable_cb(vv->eventq.vq));
> > +=09spin_unlock(&vv->eventq.qlock);
> > +
> > +=09list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> > +=09=09entry->resp_cb(vv, entry);
> > +=09=09list_del(&entry->list);
> > +=09}
> > +=09wake_up(&vv->eventq.ack_queue);
> > +}
> > +
> > +static int
> > +virtio_video_queue_cmd_buffer_locked(struct virtio_video *vv,
> > +=09=09=09=09      struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09struct virtqueue *vq =3D vv->commandq.vq;
> > +=09struct scatterlist *sgs[3], vreq, vout, vresp;
> > +=09int outcnt =3D 0, incnt =3D 0;
> > +=09int ret;
> > +
> > +=09if (!vv->vq_ready)
> > +=09=09return -ENODEV;
> > +
> > +=09sg_init_one(&vreq, vbuf->buf, vbuf->size);
> > +=09sgs[outcnt + incnt] =3D &vreq;
> > +=09outcnt++;
> > +
> > +=09if (vbuf->data_size) {
> > +=09=09sg_init_one(&vout, vbuf->data_buf, vbuf->data_size);
> > +=09=09sgs[outcnt + incnt] =3D &vout;
> > +=09=09outcnt++;
> > +=09}
> > +
> > +=09if (vbuf->resp_size) {
> > +=09=09sg_init_one(&vresp, vbuf->resp_buf, vbuf->resp_size);
> > +=09=09sgs[outcnt + incnt] =3D &vresp;
> > +=09=09incnt++;
> > +=09}
> > +
> > +retry:
> > +=09ret =3D virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC)=
;
> > +=09if (ret =3D=3D -ENOSPC) {
> > +=09=09spin_unlock(&vv->commandq.qlock);
> > +=09=09wait_event(vv->commandq.ack_queue, vq->num_free);
> > +=09=09spin_lock(&vv->commandq.qlock);
> > +=09=09goto retry;
> > +=09} else {
> > +=09=09virtqueue_kick(vq);
> > +=09}
> > +
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_queue_cmd_buffer(struct virtio_video *vv,
> > +=09=09=09=09=09  struct=20
virtio_video_vbuffer *vbuf)
> > +{
> > +=09int ret;
> > +
> > +=09spin_lock(&vv->commandq.qlock);
> > +=09ret =3D virtio_video_queue_cmd_buffer_locked(vv, vbuf);
> > +=09spin_unlock(&vv->commandq.qlock);
> > +
> > +=09return ret;
> > +}
> > +
> > +static int virtio_video_queue_event_buffer(struct virtio_video *vv,
> > +=09=09=09=09=09   struct=20
virtio_video_vbuffer *vbuf)
> > +{
> > +=09int ret;
> > +=09struct scatterlist vresp;
> > +=09struct virtqueue *vq =3D vv->eventq.vq;
> > +
> > +=09spin_lock(&vv->eventq.qlock);
> > +=09sg_init_one(&vresp, vbuf->resp_buf, vbuf->resp_size);
> > +=09ret =3D virtqueue_add_inbuf(vq, &vresp, 1, vbuf, GFP_ATOMIC);
> > +=09spin_unlock(&vv->eventq.qlock);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09virtqueue_kick(vq);
> > +
> > +=09return 0;
> > +}
> > +
> > +static void virtio_video_event_cb(struct virtio_video *vv,
> > +=09=09=09=09  struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_stream *stream;
> > +=09struct virtio_video_event *event =3D
> > +=09=09(struct virtio_video_event *)vbuf->resp_buf;
> > +
> > +=09stream =3D idr_find(&vv->stream_idr, event->stream_id);
> > +=09if (!stream) {
> > +=09=09v4l2_warn(&vv->v4l2_dev, "no stream %u found for=20
event\n",
> > +=09=09=09  event->stream_id);
> > +=09=09return;
> > +=09}
> > +
> > +=09switch (le32_to_cpu(event->event_type)) {
> > +=09case VIRTIO_VIDEO_EVENT_DECODER_RESOLUTION_CHANGED:
> > +=09=09virtio_video_cmd_get_params(vv, stream,
> > +=09=09=09=09=09  =20
VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT);
> > +=09=09virtio_video_queue_res_chg_event(stream);
> > +=09=09if (stream->state =3D=3D STREAM_STATE_INIT) {
> > +=09=09=09stream->state =3D STREAM_STATE_METADATA;
> > +=09=09=09wake_up(&vv->wq);
> > +=09=09}
> > +=09=09break;
> > +=09default:
> > +=09=09v4l2_warn(&vv->v4l2_dev, "failed to queue event=20
buffer\n");
> > +=09=09break;
> > +=09}
> > +
> > +=09memset(vbuf->resp_buf, 0, vbuf->resp_size);
> > +=09ret =3D virtio_video_queue_event_buffer(vv, vbuf);
> > +=09if (ret)
> > +=09=09v4l2_warn(&vv->v4l2_dev, "queue event buffer failed\n");
> > +}
> > +
> > +int virtio_video_alloc_events(struct virtio_video *vv, size_t num)
> > +{
> > +=09int ret;
> > +=09size_t i;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09for (i =3D 0; i < num; i++) {
> > +=09=09vbuf =3D virtio_video_get_vbuf(vv, 0,
> > +=09=09=09=09=09     sizeof(struct=20
virtio_video_event),
> > +=09=09=09=09=09     NULL,=20
virtio_video_event_cb);
> > +=09=09if (IS_ERR(vbuf))
> > +=09=09=09return PTR_ERR(vbuf);
> > +
> > +=09=09ret =3D virtio_video_queue_event_buffer(vv, vbuf);
> > +=09=09if (ret)
> > +=09=09=09return ret;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_cmd_stream_create(struct virtio_video *vv, uint32_t
> > stream_id, +=09=09=09=09   enum=20
virtio_video_format format,
> > +=09=09=09=09   const char *tag)
> > +{
> > +=09struct virtio_video_stream_create *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_STREAM_CREATE);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +=09req_p->in_mem_type =3D=20
cpu_to_le32(VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES);
> > +=09req_p->out_mem_type =3D=20
cpu_to_le32(VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES);
> > +=09req_p->coded_format =3D cpu_to_le32(format);
> > +=09strncpy(req_p->tag, tag, sizeof(req_p->tag) - 1);
> > +=09req_p->tag[sizeof(req_p->tag) - 1] =3D 0;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_cmd_stream_destroy(struct virtio_video *vv, uint32_t
> > stream_id) +{
> > +=09struct virtio_video_stream_destroy *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_STREAM_DESTROY);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_cmd_stream_drain(struct virtio_video *vv, uint32_t
> > stream_id) +{
> > +=09struct virtio_video_stream_drain *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_STREAM_DRAIN);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_cmd_resource_create(struct virtio_video *vv,
> > +=09=09=09=09     uint32_t stream_id, uint32_t=20
resource_id,
> > +=09=09=09=09     uint32_t queue_type,
> > +=09=09=09=09     struct=20
virtio_video_mem_entry *ents,
> > +=09=09=09=09     unsigned int num_planes,
> > +=09=09=09=09     unsigned int *num_entry)
> > +{
> > +=09unsigned int i =3D 0, nents =3D 0;
> > +=09struct virtio_video_resource_create *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_RESOURCE_CREATE);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +=09req_p->resource_id =3D cpu_to_le32(resource_id);
> > +=09req_p->queue_type =3D cpu_to_le32(queue_type);
> > +=09 req_p->num_planes =3D cpu_to_le32(num_planes);
> > +
> > +=09for (i =3D 0; i < num_planes; i++) {
> > +=09=09nents +=3D num_entry[i];
> > +=09=09req_p->num_entries[i] =3D cpu_to_le32(num_entry[i]);
> > +=09}
> > +
> > +=09vbuf->data_buf =3D ents;
> > +=09vbuf->data_size =3D sizeof(*ents) * nents;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_cmd_resource_destroy_all(struct virtio_video *vv,
> > +=09=09=09=09=09  struct=20
virtio_video_stream *stream,
> > +=09=09=09=09=09  enum=20
virtio_video_queue_type qtype)
> > +{
> > +=09struct virtio_video_resource_destroy_all *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D=20
cpu_to_le32(VIRTIO_VIDEO_CMD_RESOURCE_DESTROY_ALL);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream->stream_id);
> > +=09req_p->queue_type =3D cpu_to_le32(qtype);
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_resource_queue_cb(struct virtio_video *vv,
> > +=09=09=09=09   struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09uint32_t flags, bytesused;
> > +=09uint64_t timestamp;
> > +=09struct virtio_video_buffer *virtio_vb =3D vbuf->priv;
> > +=09struct virtio_video_resource_queue_resp *resp =3D
> > +=09=09(struct virtio_video_resource_queue_resp *)vbuf-
>resp_buf;
> > +
> > +=09flags =3D le32_to_cpu(resp->flags);
> > +=09bytesused =3D le32_to_cpu(resp->size);
> > +=09timestamp =3D le64_to_cpu(resp->timestamp);
> > +
> > +=09virtio_video_buf_done(virtio_vb, flags, timestamp, bytesused);
> > +}
> > +
> > +int virtio_video_cmd_resource_queue(struct virtio_video *vv, uint32_t
> > stream_id, +=09=09=09=09    struct=20
virtio_video_buffer *virtio_vb,
> > +=09=09=09=09    uint32_t data_size[],
> > +=09=09=09=09    uint8_t num_data_size,=20
uint32_t queue_type)
> > +{
> > +=09uint8_t i;
> > +=09struct virtio_video_resource_queue *req_p;
> > +=09struct virtio_video_resource_queue_resp *resp_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +=09size_t resp_size =3D sizeof(struct=20
virtio_video_resource_queue_resp);
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv,
> > +=09=09=09=09=09   =20
&virtio_video_cmd_resource_queue_cb,
> > +=09=09=09=09=09    &vbuf,=20
sizeof(*req_p), resp_size,
> > +=09=09=09=09=09    NULL);
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_RESOURCE_QUEUE);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +=09req_p->queue_type =3D cpu_to_le32(queue_type);
> > +=09req_p->resource_id =3D cpu_to_le32(virtio_vb->resource_id);
> > +=09req_p->num_data_sizes =3D num_data_size;
> > +=09req_p->timestamp =3D
> > +=09=09cpu_to_le64(virtio_vb-
>v4l2_m2m_vb.vb.vb2_buf.timestamp);
> > +
> > +=09for (i =3D 0; i < num_data_size; ++i)
> > +=09=09req_p->data_sizes[i] =3D cpu_to_le32(data_size[i]);
> > +
> > +=09resp_p =3D (struct virtio_video_resource_queue_resp *)vbuf-
>resp_buf;
> > +=09memset(resp_p, 0, sizeof(*resp_p));
> > +
> > +=09vbuf->priv =3D virtio_vb;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_queue_clear_cb(struct virtio_video *vv,
> > +=09=09=09=09struct virtio_video_vbuffer *vbuf)
> > +{
> > +=09struct virtio_video_stream *stream =3D vbuf->priv;
> > +=09struct virtio_video_queue_clear *req_p =3D
> > +=09=09(struct virtio_video_queue_clear *)vbuf->buf;
> > +
> > +=09if (le32_to_cpu(req_p->queue_type) =3D=3D=20
VIRTIO_VIDEO_QUEUE_TYPE_INPUT)
> > +=09=09stream->src_cleared =3D true;
> > +=09else
> > +=09=09stream->dst_cleared =3D true;
> > +
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +int virtio_video_cmd_queue_clear(struct virtio_video *vv,
> > +=09=09=09=09 struct virtio_video_stream=20
*stream,
> > +=09=09=09=09 uint32_t queue_type)
> > +{
> > +=09struct virtio_video_queue_clear *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp
> > +=09=09(vv, &virtio_video_cmd_queue_clear_cb,
> > +=09=09 &vbuf, sizeof(*req_p),
> > +=09=09 sizeof(struct virtio_video_cmd_hdr), NULL);
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_QUEUE_CLEAR);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream->stream_id);
> > +=09req_p->queue_type =3D cpu_to_le32(queue_type);
> > +
> > +=09vbuf->priv =3D stream;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +static void
> > +virtio_video_query_caps_cb(struct virtio_video *vv,
> > +=09=09=09   struct virtio_video_vbuffer *vbuf)
> > +{
> > +=09bool *got_resp_p =3D vbuf->priv;
> > +=09*got_resp_p =3D true;
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +int virtio_video_query_capability(struct virtio_video *vv, void
> > *resp_buf,
> > +=09=09=09=09  size_t resp_size, uint32_t=20
queue_type)
> > +{
> > +=09struct virtio_video_query_capability *req_p =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +
> > +=09if (!vv || !resp_buf)
> > +=09=09return -1;
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv,=20
&virtio_video_query_caps_cb,
> > +=09=09=09=09=09    &vbuf,=20
sizeof(*req_p), resp_size,
> > +=09=09=09=09=09    resp_buf);
> > +=09if (IS_ERR(req_p))
> > +=09=09return -1;
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_QUERY_CAPABILITY);
> > +=09req_p->queue_type =3D cpu_to_le32(queue_type);
> > +
> > +=09vbuf->priv =3D &vv->got_caps;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_query_control_level(struct virtio_video *vv, void
> > *resp_buf, +=09=09=09=09     size_t=20
resp_size, uint32_t format)
> > +{
> > +=09struct virtio_video_query_control *req_p =3D NULL;
> > +=09struct virtio_video_query_control_level *ctrl_l =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +=09uint32_t req_size =3D 0;
> > +
> > +=09if (!vv || !resp_buf)
> > +=09=09return -1;
> > +
> > +=09req_size =3D sizeof(struct virtio_video_query_control) +
> > +=09=09sizeof(struct virtio_video_query_control_level);
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv,=20
&virtio_video_query_caps_cb,
> > +=09=09=09=09=09    &vbuf, req_size,=20
resp_size,
> > +=09=09=09=09=09    resp_buf);
> > +=09if (IS_ERR(req_p))
> > +=09=09return -1;
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_QUERY_CONTROL);
> > +=09req_p->control =3D cpu_to_le32(VIRTIO_VIDEO_CONTROL_LEVEL);
> > +=09ctrl_l =3D (void *)((char *)req_p +
> > +=09=09=09  sizeof(struct=20
virtio_video_query_control));
> > +=09ctrl_l->format =3D cpu_to_le32(format);
> > +
> > +=09vbuf->priv =3D &vv->got_control;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +int virtio_video_query_control_profile(struct virtio_video *vv, void
> > *resp_buf, +=09=09=09=09       size_t=20
resp_size, uint32_t format)
> > +{
> > +=09struct virtio_video_query_control *req_p =3D NULL;
> > +=09struct virtio_video_query_control_profile *ctrl_p =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +=09uint32_t req_size =3D 0;
> > +
> > +=09if (!vv || !resp_buf)
> > +=09=09return -1;
> > +
> > +=09req_size =3D sizeof(struct virtio_video_query_control) +
> > +=09=09sizeof(struct virtio_video_query_control_profile);
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv,=20
&virtio_video_query_caps_cb,
> > +=09=09=09=09=09    &vbuf, req_size,=20
resp_size,
> > +=09=09=09=09=09    resp_buf);
> > +=09if (IS_ERR(req_p))
> > +=09=09return -1;
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_QUERY_CONTROL);
> > +=09req_p->control =3D cpu_to_le32(VIRTIO_VIDEO_CONTROL_PROFILE);
> > +=09ctrl_p =3D (void *)((char *)req_p +
> > +=09=09=09  sizeof(struct=20
virtio_video_query_control));
> > +=09ctrl_p->format =3D cpu_to_le32(format);
> > +
> > +=09vbuf->priv =3D &vv->got_control;
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_get_params_cb(struct virtio_video *vv,
> > +=09=09=09       struct virtio_video_vbuffer *vbuf)
> > +{
> > +=09int i;
> > +=09struct virtio_video_get_params_resp *resp =3D
> > +=09=09(struct virtio_video_get_params_resp *)vbuf->resp_buf;
> > +=09struct virtio_video_params *params =3D &resp->params;
> > +=09struct virtio_video_stream *stream =3D vbuf->priv;
> > +=09enum virtio_video_queue_type queue_type;
> > +=09struct video_format_info *format_info =3D NULL;
> > +
> > +=09queue_type =3D le32_to_cpu(params->queue_type);
> > +=09if (queue_type =3D=3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT)
> > +=09=09format_info =3D &stream->in_info;
> > +=09else
> > +=09=09format_info =3D &stream->out_info;
> > +
> > +=09if (!format_info)
> > +=09=09return;
> > +
> > +=09format_info->frame_rate =3D le32_to_cpu(params->frame_rate);
> > +=09format_info->frame_width =3D le32_to_cpu(params->frame_width);
> > +=09format_info->frame_height =3D le32_to_cpu(params->frame_height);
> > +=09format_info->min_buffers =3D le32_to_cpu(params->min_buffers);
> > +=09format_info->max_buffers =3D le32_to_cpu(params->max_buffers);
> > +=09format_info->fourcc_format =3D
> > +=09=09virtio_video_format_to_v4l2(le32_to_cpu(params-
>format));
> > +
> > +=09format_info->crop.top =3D le32_to_cpu(params->crop.top);
> > +=09format_info->crop.left =3D le32_to_cpu(params->crop.left);
> > +=09format_info->crop.width =3D le32_to_cpu(params->crop.width);
> > +=09format_info->crop.height =3D le32_to_cpu(params->crop.height);
> > +
> > +=09format_info->num_planes =3D le32_to_cpu(params->num_planes);
> > +=09for (i =3D 0; i < le32_to_cpu(params->num_planes); i++) {
> > +=09=09struct virtio_video_plane_format *plane_formats =3D
> > +=09=09=09=09=09=09 &params-
>plane_formats[i];
> > +=09=09struct video_plane_format *plane_format =3D
> > +=09=09=09=09=09=09=20
&format_info->plane_format[i];
> > +
> > +=09=09plane_format->plane_size =3D
> > +=09=09=09=09 le32_to_cpu(plane_formats-
>plane_size);
> > +=09=09plane_format->stride =3D le32_to_cpu(plane_formats-
>stride);
> > +=09}
> > +
> > +=09format_info->is_updated =3D true;
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +int virtio_video_cmd_get_params(struct virtio_video *vv,
> > +=09=09=09       struct virtio_video_stream *stream,
> > +=09=09=09       uint32_t queue_type)
> > +{
> > +=09int ret;
> > +=09struct virtio_video_get_params *req_p =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +=09struct virtio_video_get_params_resp *resp_p;
> > +=09struct video_format_info *format_info =3D NULL;
> > +=09size_t resp_size =3D sizeof(struct virtio_video_get_params_resp);
> > +
> > +=09if (!vv || !stream)
> > +=09=09return -1;
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv,
> > +=09=09=09=09=09
&virtio_video_cmd_get_params_cb,
> > +=09=09=09=09=09&vbuf, sizeof(*req_p),=20
resp_size,
> > +=09=09=09=09=09NULL);
> > +
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_GET_PARAMS);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream->stream_id);
> > +=09req_p->queue_type =3D cpu_to_le32(queue_type);
> > +
> > +=09resp_p =3D (struct virtio_video_get_params_resp *)vbuf->resp_buf;
> > +=09memset(resp_p, 0, sizeof(*resp_p));
> > +
> > +=09if (req_p->queue_type =3D=3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT)
> > +=09=09format_info =3D &stream->in_info;
> > +=09else
> > +=09=09format_info =3D &stream->out_info;
> > +
> > +=09format_info->is_updated =3D false;
> > +
> > +=09vbuf->priv =3D stream;
> > +=09ret =3D virtio_video_queue_cmd_buffer(vv, vbuf);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D wait_event_timeout(vv->wq,
> > +=09=09=09=09 format_info->is_updated, 5 *=20
HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for=20
get_params\n");
> > +=09=09return -1;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +int
> > +virtio_video_cmd_set_params(struct virtio_video *vv,
> > +=09=09=09    struct virtio_video_stream *stream,
> > +=09=09=09    struct video_format_info *format_info,
> > +=09=09=09    uint32_t queue_type)
> > +{
> > +=09int i;
> > +=09struct virtio_video_set_params *req_p;
> > +=09struct virtio_video_vbuffer *vbuf;
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_SET_PARAMS);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream->stream_id);
> > +=09req_p->params.queue_type =3D cpu_to_le32(queue_type);
> > +=09req_p->params.frame_rate =3D cpu_to_le32(format_info->frame_rate);
> > +=09req_p->params.frame_width =3D cpu_to_le32(format_info->frame_width)=
;
> > +=09req_p->params.frame_height =3D cpu_to_le32(format_info-
>frame_height);
> > +=09req_p->params.format =3D virtio_video_v4l2_format_to_virtio(
> > +=09=09=09=09 cpu_to_le32(format_info-
>fourcc_format));
> > +=09req_p->params.min_buffers =3D cpu_to_le32(format_info->min_buffers)=
;
> > +=09req_p->params.max_buffers =3D cpu_to_le32(format_info->max_buffers)=
;
> > +=09req_p->params.num_planes =3D cpu_to_le32(format_info->num_planes);
> > +
> > +=09for (i =3D 0; i < format_info->num_planes; i++) {
> > +=09=09struct virtio_video_plane_format *plane_formats =3D
> > +=09=09=09&req_p->params.plane_formats[i];
> > +=09=09struct video_plane_format *plane_format =3D
> > +=09=09=09&format_info->plane_format[i];
> > +=09=09plane_formats->plane_size =3D
> > +=09=09=09=09 cpu_to_le32(plane_format-
>plane_size);
> > +=09=09plane_formats->stride =3D cpu_to_le32(plane_format-
>stride);
> > +=09}
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_get_ctrl_profile_cb(struct virtio_video *vv,
> > +=09=09=09=09     struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09struct virtio_video_get_control_resp *resp =3D
> > +=09=09(struct virtio_video_get_control_resp *)vbuf->resp_buf;
> > +=09struct virtio_video_control_val_profile *resp_p =3D NULL;
> > +=09struct virtio_video_stream *stream =3D vbuf->priv;
> > +=09struct video_control_info *control =3D &stream->control;
> > +
> > +=09if (!control)
> > +=09=09return;
> > +
> > +=09resp_p =3D (void *)((char *) resp +
> > +=09=09=09  sizeof(struct=20
virtio_video_get_control_resp));
> > +
> > +=09control->profile =3D le32_to_cpu(resp_p->profile);
> > +=09control->is_updated =3D true;
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_get_ctrl_level_cb(struct virtio_video *vv,
> > +=09=09=09=09   struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09struct virtio_video_get_control_resp *resp =3D
> > +=09=09(struct virtio_video_get_control_resp *)vbuf->resp_buf;
> > +=09struct virtio_video_control_val_level *resp_p =3D NULL;
> > +=09struct virtio_video_stream *stream =3D vbuf->priv;
> > +=09struct video_control_info *control =3D &stream->control;
> > +
> > +=09if (!control)
> > +=09=09return;
> > +
> > +=09resp_p =3D (void *)((char *)resp +
> > +=09=09=09  sizeof(struct=20
virtio_video_get_control_resp));
> > +
> > +=09control->level =3D le32_to_cpu(resp_p->level);
> > +=09control->is_updated =3D true;
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +static void
> > +virtio_video_cmd_get_ctrl_bitrate_cb(struct virtio_video *vv,
> > +=09=09=09=09     struct virtio_video_vbuffer=20
*vbuf)
> > +{
> > +=09struct virtio_video_get_control_resp *resp =3D
> > +=09=09(struct virtio_video_get_control_resp *)vbuf->resp_buf;
> > +=09struct virtio_video_control_val_bitrate *resp_p =3D NULL;
> > +=09struct virtio_video_stream *stream =3D vbuf->priv;
> > +=09struct video_control_info *control =3D &stream->control;
> > +
> > +=09if (!control)
> > +=09=09return;
> > +
> > +=09resp_p =3D (void *)((char *) resp +
> > +=09=09=09  sizeof(struct=20
virtio_video_get_control_resp));
> > +
> > +=09control->bitrate =3D le32_to_cpu(resp_p->bitrate);
> > +=09control->is_updated =3D true;
> > +=09wake_up(&vv->wq);
> > +}
> > +
> > +int virtio_video_cmd_get_control(struct virtio_video *vv,
> > +=09=09=09=09 struct virtio_video_stream=20
*stream,
> > +=09=09=09=09 uint32_t virtio_ctrl)
> > +{
> > +=09int ret =3D 0;
> > +=09struct virtio_video_get_control *req_p =3D NULL;
> > +=09struct virtio_video_get_control_resp *resp_p =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +=09size_t resp_size =3D sizeof(struct virtio_video_get_control_resp);
> > +=09virtio_video_resp_cb cb;
> > +
> > +=09if (!vv)
> > +=09=09return -1;
> > +
> > +=09switch (virtio_ctrl) {
> > +=09case VIRTIO_VIDEO_CONTROL_PROFILE:
> > +=09=09resp_size +=3D sizeof(struct=20
virtio_video_control_val_profile);
> > +=09=09cb =3D &virtio_video_cmd_get_ctrl_profile_cb;
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_LEVEL:
> > +=09=09resp_size +=3D sizeof(struct=20
virtio_video_control_val_level);
> > +=09=09cb =3D &virtio_video_cmd_get_ctrl_level_cb;
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_BITRATE:
> > +=09=09resp_size +=3D sizeof(struct=20
virtio_video_control_val_bitrate);
> > +=09=09cb =3D &virtio_video_cmd_get_ctrl_bitrate_cb;
> > +=09=09break;
> > +=09default:
> > +=09=09return -1;
> > +=09}
> > +
> > +=09req_p =3D virtio_video_alloc_req_resp(vv, cb, &vbuf,
> > +=09=09=09=09=09    sizeof(*req_p),=20
resp_size, NULL);
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_GET_CONTROL);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream->stream_id);
> > +=09req_p->control =3D cpu_to_le32(virtio_ctrl);
> > +
> > +=09resp_p =3D (struct virtio_video_get_control_resp *)vbuf->resp_buf;
> > +=09memset(resp_p, 0, resp_size);
> > +
> > +=09stream->control.is_updated =3D false;
> > +
> > +=09vbuf->priv =3D stream;
> > +=09ret =3D virtio_video_queue_cmd_buffer(vv, vbuf);
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D wait_event_timeout(vv->wq, stream->control.is_updated, 5 *=
=20
HZ);
> > +=09if (ret =3D=3D 0) {
> > +=09=09v4l2_err(&vv->v4l2_dev, "timed out waiting for=20
get_params\n");
> > +=09=09return -1;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +int virtio_video_cmd_set_control(struct virtio_video *vv, uint32_t
> > stream_id, +=09=09=09=09 uint32_t control,=20
uint32_t value)
> > +{
> > +=09struct virtio_video_set_control *req_p =3D NULL;
> > +=09struct virtio_video_vbuffer *vbuf =3D NULL;
> > +=09struct virtio_video_control_val_level *ctrl_l =3D NULL;
> > +=09struct virtio_video_control_val_profile *ctrl_p =3D NULL;
> > +=09struct virtio_video_control_val_bitrate *ctrl_b =3D NULL;
> > +=09size_t size;
> > +
> > +=09if (!vv || value =3D=3D 0)
> > +=09=09return -EINVAL;
> > +
> > +=09switch (control) {
> > +=09case VIRTIO_VIDEO_CONTROL_PROFILE:
> > +=09=09size =3D sizeof(struct virtio_video_control_val_profile);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_LEVEL:
> > +=09=09size =3D sizeof(struct virtio_video_control_val_level);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_BITRATE:
> > +=09=09size =3D sizeof(struct virtio_video_control_val_bitrate);
> > +=09=09break;
> > +=09default:
> > +=09=09return -1;
> > +=09}
> > +
> > +=09req_p =3D virtio_video_alloc_req(vv, &vbuf, size + sizeof(*req_p));
> > +=09if (IS_ERR(req_p))
> > +=09=09return PTR_ERR(req_p);
> > +
> > +=09req_p->hdr.type =3D cpu_to_le32(VIRTIO_VIDEO_CMD_SET_CONTROL);
> > +=09req_p->hdr.stream_id =3D cpu_to_le32(stream_id);
> > +=09req_p->control =3D cpu_to_le32(control);
> > +
> > +=09switch (control) {
> > +=09case VIRTIO_VIDEO_CONTROL_PROFILE:
> > +=09=09ctrl_p =3D (void *)((char *)req_p +
> > +=09=09=09=09  sizeof(struct=20
virtio_video_set_control));
> > +=09=09ctrl_p->profile =3D cpu_to_le32(value);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_LEVEL:
> > +=09=09ctrl_l =3D (void *)((char *)req_p +
> > +=09=09=09=09 sizeof(struct=20
virtio_video_set_control));
> > +=09=09ctrl_l->level =3D cpu_to_le32(value);
> > +=09=09break;
> > +=09case VIRTIO_VIDEO_CONTROL_BITRATE:
> > +=09=09ctrl_b =3D (void *)((char *)req_p +
> > +=09=09=09=09 sizeof(struct=20
virtio_video_set_control));
> > +=09=09ctrl_b->bitrate =3D cpu_to_le32(value);
> > +=09=09break;
> > +=09}
> > +
> > +=09return virtio_video_queue_cmd_buffer(vv, vbuf);
> > +}
> > +
> > diff --git a/include/uapi/linux/virtio_ids.h
> > b/include/uapi/linux/virtio_ids.h index 6d5c3b2d4f4d..89dfc94ecaa3 1006=
44
> > --- a/include/uapi/linux/virtio_ids.h
> > +++ b/include/uapi/linux/virtio_ids.h
> > @@ -43,5 +43,7 @@
> >=20
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> >=20
> > +#define VIRTIO_ID_VIDEO_ENC    30 /* virtio video encoder */
> > +#define VIRTIO_ID_VIDEO_DEC    31 /* virtio video decoder */
> >=20
> >  #endif /* _LINUX_VIRTIO_IDS_H */
> >=20
> > diff --git a/include/uapi/linux/virtio_video.h
> > b/include/uapi/linux/virtio_video.h new file mode 100644
> > index 000000000000..0dd98a2237c6
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_video.h
> > @@ -0,0 +1,469 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Virtio Video Device
> > + *
> > + * This header is BSD licensed so anyone can use the definitions
> > + * to implement compatible drivers/servers:
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + * 1. Redistributions of source code must retain the above copyright
> > + *    notice, this list of conditions and the following disclaimer.
> > + * 2. Redistributions in binary form must reproduce the above copyrigh=
t
> > + *    notice, this list of conditions and the following disclaimer in =
the
> > + *    documentation and/or other materials provided with the
> > distribution.
> > + * 3. Neither the name of IBM nor the names of its contributors
> > + *    may be used to endorse or promote products derived from this
> > software + *    without specific prior written permission.
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > + * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> > + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
> > + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> > + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> > + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> > + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> > + * SUCH DAMAGE.
> > + *
> > + * Copyright (C) 2019 OpenSynergy GmbH.
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_VIDEO_H
> > +#define _UAPI_LINUX_VIRTIO_VIDEO_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/virtio_config.h>
> > +
> > +/*
> > + * Feature bits
> > + */
> > +
> > +/* Guest pages can be used for video buffers. */
> > +#define VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES 0
> > +/*
> > + * The host can process buffers even if they are non-contiguous memory
> > such as + * scatter-gather lists.
> > + */
> > +#define VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG 1
> > +
> > +/*
> > + * Image formats
> > + */
> > +
> > +enum virtio_video_format {
> > +=09/* Raw formats */
> > +=09VIRTIO_VIDEO_FORMAT_RAW_MIN =3D 1,
> > +=09VIRTIO_VIDEO_FORMAT_ARGB8888 =3D VIRTIO_VIDEO_FORMAT_RAW_MIN,
> > +=09VIRTIO_VIDEO_FORMAT_BGRA8888,
> > +=09VIRTIO_VIDEO_FORMAT_NV12, /* 12  Y/CbCr 4:2:0  */
> > +=09VIRTIO_VIDEO_FORMAT_YUV420, /* 12  YUV 4:2:0     */
> > +=09VIRTIO_VIDEO_FORMAT_YVU420, /* 12  YVU 4:2:0     */
> > +=09VIRTIO_VIDEO_FORMAT_RAW_MAX =3D VIRTIO_VIDEO_FORMAT_YVU420,
> > +
> > +=09/* Coded formats */
> > +=09VIRTIO_VIDEO_FORMAT_CODED_MIN =3D 0x1000,
> > +=09VIRTIO_VIDEO_FORMAT_MPEG2 =3D
> > +=09=09VIRTIO_VIDEO_FORMAT_CODED_MIN, /* MPEG-2 Part 2 */
> > +=09VIRTIO_VIDEO_FORMAT_MPEG4, /* MPEG-4 Part 2 */
> > +=09VIRTIO_VIDEO_FORMAT_H264, /* H.264 */
> > +=09VIRTIO_VIDEO_FORMAT_HEVC, /* HEVC aka H.265*/
> > +=09VIRTIO_VIDEO_FORMAT_VP8, /* VP8 */
> > +=09VIRTIO_VIDEO_FORMAT_VP9, /* VP9 */
> > +=09VIRTIO_VIDEO_FORMAT_CODED_MAX =3D VIRTIO_VIDEO_FORMAT_VP9,
> > +};
> > +
> > +enum virtio_video_profile {
> > +=09/* H.264 */
> > +=09VIRTIO_VIDEO_PROFILE_H264_MIN =3D 0x100,
> > +=09VIRTIO_VIDEO_PROFILE_H264_BASELINE =3D=20
VIRTIO_VIDEO_PROFILE_H264_MIN,
> > +=09VIRTIO_VIDEO_PROFILE_H264_MAIN,
> > +=09VIRTIO_VIDEO_PROFILE_H264_EXTENDED,
> > +=09VIRTIO_VIDEO_PROFILE_H264_HIGH,
> > +=09VIRTIO_VIDEO_PROFILE_H264_HIGH10PROFILE,
> > +=09VIRTIO_VIDEO_PROFILE_H264_HIGH422PROFILE,
> > +=09VIRTIO_VIDEO_PROFILE_H264_HIGH444PREDICTIVEPROFILE,
> > +=09VIRTIO_VIDEO_PROFILE_H264_SCALABLEBASELINE,
> > +=09VIRTIO_VIDEO_PROFILE_H264_SCALABLEHIGH,
> > +=09VIRTIO_VIDEO_PROFILE_H264_STEREOHIGH,
> > +=09VIRTIO_VIDEO_PROFILE_H264_MULTIVIEWHIGH,
> > +=09VIRTIO_VIDEO_PROFILE_H264_MAX =3D=20
VIRTIO_VIDEO_PROFILE_H264_MULTIVIEWHIGH,
> > +
> > +=09/* HEVC */
> > +=09VIRTIO_VIDEO_PROFILE_HEVC_MIN =3D 0x200,
> > +=09VIRTIO_VIDEO_PROFILE_HEVC_MAIN =3D VIRTIO_VIDEO_PROFILE_HEVC_MIN,
> > +=09VIRTIO_VIDEO_PROFILE_HEVC_MAIN10,
> > +=09VIRTIO_VIDEO_PROFILE_HEVC_MAIN_STILL_PICTURE,
> > +=09VIRTIO_VIDEO_PROFILE_HEVC_MAX =3D
> > +=09=09VIRTIO_VIDEO_PROFILE_HEVC_MAIN_STILL_PICTURE,
> > +
> > +=09/* VP8 */
> > +=09VIRTIO_VIDEO_PROFILE_VP8_MIN =3D 0x300,
> > +=09VIRTIO_VIDEO_PROFILE_VP8_PROFILE0 =3D VIRTIO_VIDEO_PROFILE_VP8_MIN,
> > +=09VIRTIO_VIDEO_PROFILE_VP8_PROFILE1,
> > +=09VIRTIO_VIDEO_PROFILE_VP8_PROFILE2,
> > +=09VIRTIO_VIDEO_PROFILE_VP8_PROFILE3,
> > +=09VIRTIO_VIDEO_PROFILE_VP8_MAX =3D VIRTIO_VIDEO_PROFILE_VP8_PROFILE3,
> > +
> > +=09/* VP9 */
> > +=09VIRTIO_VIDEO_PROFILE_VP9_MIN =3D 0x400,
> > +=09VIRTIO_VIDEO_PROFILE_VP9_PROFILE0 =3D VIRTIO_VIDEO_PROFILE_VP9_MIN,
> > +=09VIRTIO_VIDEO_PROFILE_VP9_PROFILE1,
> > +=09VIRTIO_VIDEO_PROFILE_VP9_PROFILE2,
> > +=09VIRTIO_VIDEO_PROFILE_VP9_PROFILE3,
> > +=09VIRTIO_VIDEO_PROFILE_VP9_MAX =3D VIRTIO_VIDEO_PROFILE_VP9_PROFILE3,
> > +};
> > +
> > +enum virtio_video_level {
> > +=09/* H.264 */
> > +=09VIRTIO_VIDEO_LEVEL_H264_MIN =3D 0x100,
> > +=09VIRTIO_VIDEO_LEVEL_H264_1_0 =3D VIRTIO_VIDEO_LEVEL_H264_MIN,
> > +=09VIRTIO_VIDEO_LEVEL_H264_1_1,
> > +=09VIRTIO_VIDEO_LEVEL_H264_1_2,
> > +=09VIRTIO_VIDEO_LEVEL_H264_1_3,
> > +=09VIRTIO_VIDEO_LEVEL_H264_2_0,
> > +=09VIRTIO_VIDEO_LEVEL_H264_2_1,
> > +=09VIRTIO_VIDEO_LEVEL_H264_2_2,
> > +=09VIRTIO_VIDEO_LEVEL_H264_3_0,
> > +=09VIRTIO_VIDEO_LEVEL_H264_3_1,
> > +=09VIRTIO_VIDEO_LEVEL_H264_3_2,
> > +=09VIRTIO_VIDEO_LEVEL_H264_4_0,
> > +=09VIRTIO_VIDEO_LEVEL_H264_4_1,
> > +=09VIRTIO_VIDEO_LEVEL_H264_4_2,
> > +=09VIRTIO_VIDEO_LEVEL_H264_5_0,
> > +=09VIRTIO_VIDEO_LEVEL_H264_5_1,
> > +=09VIRTIO_VIDEO_LEVEL_H264_MAX =3D VIRTIO_VIDEO_LEVEL_H264_5_1,
> > +};
> > +
> > +/*
> > + * Config
> > + */
> > +
> > +struct virtio_video_config {
> > +=09__le32 version;
> > +=09__le32 max_caps_length;
> > +=09__le32 max_resp_length;
> > +};
> > +
> > +/*
> > + * Commands
> > + */
> > +
> > +enum virtio_video_cmd_type {
> > +=09/* Command */
> > +=09VIRTIO_VIDEO_CMD_QUERY_CAPABILITY =3D 0x0100,
> > +=09VIRTIO_VIDEO_CMD_STREAM_CREATE,
> > +=09VIRTIO_VIDEO_CMD_STREAM_DESTROY,
> > +=09VIRTIO_VIDEO_CMD_STREAM_DRAIN,
> > +=09VIRTIO_VIDEO_CMD_RESOURCE_CREATE,
> > +=09VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
> > +=09VIRTIO_VIDEO_CMD_RESOURCE_DESTROY_ALL,
> > +=09VIRTIO_VIDEO_CMD_QUEUE_CLEAR,
> > +=09VIRTIO_VIDEO_CMD_GET_PARAMS,
> > +=09VIRTIO_VIDEO_CMD_SET_PARAMS,
> > +=09VIRTIO_VIDEO_CMD_QUERY_CONTROL,
> > +=09VIRTIO_VIDEO_CMD_GET_CONTROL,
> > +=09VIRTIO_VIDEO_CMD_SET_CONTROL,
> > +
> > +=09/* Response */
> > +=09VIRTIO_VIDEO_RESP_OK_NODATA =3D 0x0200,
> > +=09VIRTIO_VIDEO_RESP_OK_QUERY_CAPABILITY,
> > +=09VIRTIO_VIDEO_RESP_OK_RESOURCE_QUEUE,
> > +=09VIRTIO_VIDEO_RESP_OK_GET_PARAMS,
> > +=09VIRTIO_VIDEO_RESP_OK_QUERY_CONTROL,
> > +=09VIRTIO_VIDEO_RESP_OK_GET_CONTROL,
> > +
> > +=09VIRTIO_VIDEO_RESP_ERR_INVALID_OPERATION =3D 0x0300,
> > +=09VIRTIO_VIDEO_RESP_ERR_OUT_OF_MEMORY,
> > +=09VIRTIO_VIDEO_RESP_ERR_INVALID_STREAM_ID,
> > +=09VIRTIO_VIDEO_RESP_ERR_INVALID_RESOURCE_ID,
> > +=09VIRTIO_VIDEO_RESP_ERR_INVALID_PARAMETER,
> > +=09VIRTIO_VIDEO_RESP_ERR_UNSUPPORTED_CONTROL,
> > +};
> > +
> > +struct virtio_video_cmd_hdr {
> > +=09__le32 type; /* One of enum virtio_video_cmd_type */
> > +=09__le32 stream_id;
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_QUERY_CAPABILITY */
> > +enum virtio_video_queue_type {
> > +=09VIRTIO_VIDEO_QUEUE_TYPE_INPUT =3D 0x100,
> > +=09VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT,
> > +};
> > +
> > +struct virtio_video_query_capability {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__u8 padding[4];
> > +};
> > +
> > +enum virtio_video_planes_layout_flag {
> > +=09VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER =3D 1 << 0,
> > +=09VIRTIO_VIDEO_PLANES_LAYOUT_PER_PLANE =3D 1 << 1,
> > +};
> > +
> > +struct virtio_video_format_range {
> > +=09__le32 min;
> > +=09__le32 max;
> > +=09__le32 step;
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_format_frame {
> > +=09struct virtio_video_format_range width;
> > +=09struct virtio_video_format_range height;
> > +=09__le32 num_rates;
> > +=09__u8 padding[4];
> > +=09/* Followed by struct virtio_video_format_range frame_rates[] */
> > +};
> > +
> > +struct virtio_video_format_desc {
> > +=09__le64 mask;
> > +=09__le32 format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > +=09__le32 planes_layout; /* Bitmask with VIRTIO_VIDEO_PLANES_LAYOUT_*=
=20
*/
> > +=09__le32 plane_align;
> > +=09__le32 num_frames;
> > +=09/* Followed by struct virtio_video_format_frame frames[] */
> > +};
> > +
> > +struct virtio_video_query_capability_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 num_descs;
> > +=09__u8 padding[4];
> > +=09/* Followed by struct virtio_video_format_desc descs[] */
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_STREAM_CREATE */
> > +enum virtio_video_mem_type {
> > +=09VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES,
> > +};
> > +
> > +struct virtio_video_stream_create {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 in_mem_type; /* One of VIRTIO_VIDEO_MEM_TYPE_* types */
> > +=09__le32 out_mem_type; /* One of VIRTIO_VIDEO_MEM_TYPE_* types */
> > +=09__le32 coded_format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > +=09__u8 padding[4];
> > +=09__u8 tag[64];
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_STREAM_DESTROY */
> > +struct virtio_video_stream_destroy {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_STREAM_DRAIN */
> > +struct virtio_video_stream_drain {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_RESOURCE_CREATE */
> > +struct virtio_video_mem_entry {
> > +=09__le64 addr;
> > +=09__le32 length;
> > +=09__u8 padding[4];
> > +};
> > +
> > +#define VIRTIO_VIDEO_MAX_PLANES 8
> > +
> > +struct virtio_video_resource_create {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__le32 resource_id;
> > +=09__le32 planes_layout;
> > +=09__le32 num_planes;
> > +=09__le32 plane_offsets[VIRTIO_VIDEO_MAX_PLANES];
> > +=09__le32 num_entries[VIRTIO_VIDEO_MAX_PLANES];
> > +=09/* Followed by struct virtio_video_mem_entry entries[] */
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_RESOURCE_QUEUE */
> > +struct virtio_video_resource_queue {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__le32 resource_id;
> > +=09__le64 timestamp;
> > +=09__le32 num_data_sizes;
> > +=09__le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
> > +=09__u8 padding[4];
> > +};
> > +
> > +enum virtio_video_buffer_flag {
> > +=09VIRTIO_VIDEO_BUFFER_FLAG_ERR =3D 0x0001,
> > +=09VIRTIO_VIDEO_BUFFER_FLAG_EOS =3D 0x0002,
> > +
> > +=09/* Encoder only */
> > +=09VIRTIO_VIDEO_BUFFER_FLAG_IFRAME =3D 0x0004,
> > +=09VIRTIO_VIDEO_BUFFER_FLAG_PFRAME =3D 0x0008,
> > +=09VIRTIO_VIDEO_BUFFER_FLAG_BFRAME =3D 0x0010,
> > +};
> > +
> > +struct virtio_video_resource_queue_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le64 timestamp;
> > +=09__le32 flags; /* One of VIRTIO_VIDEO_BUFFER_FLAG_* flags */
> > +=09__le32 size; /* Encoded size */
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_RESOURCE_DESTROY_ALL */
> > +struct virtio_video_resource_destroy_all {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__u8 padding[4];
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_QUEUE_CLEAR */
> > +struct virtio_video_queue_clear {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__u8 padding[4];
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_GET_PARAMS */
> > +struct virtio_video_plane_format {
> > +=09__le32 plane_size;
> > +=09__le32 stride;
> > +};
> > +
> > +struct virtio_video_crop {
> > +=09__le32 left;
> > +=09__le32 top;
> > +=09__le32 width;
> > +=09__le32 height;
> > +};
> > +
> > +struct virtio_video_params {
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__le32 format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > +=09__le32 frame_width;
> > +=09__le32 frame_height;
> > +=09__le32 min_buffers;
> > +=09__le32 max_buffers;
> > +=09struct virtio_video_crop crop;
> > +=09__le32 frame_rate;
> > +=09__le32 num_planes;
> > +=09struct virtio_video_plane_format=20
plane_formats[VIRTIO_VIDEO_MAX_PLANES];
> > +};
> > +
> > +struct virtio_video_get_params {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 queue_type; /* One of VIRTIO_VIDEO_QUEUE_TYPE_* types */
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_get_params_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09struct virtio_video_params params;
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_SET_PARAMS */
> > +struct virtio_video_set_params {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09struct virtio_video_params params;
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_QUERY_CONTROL */
> > +enum virtio_video_control_type {
> > +=09VIRTIO_VIDEO_CONTROL_BITRATE =3D 1,
> > +=09VIRTIO_VIDEO_CONTROL_PROFILE,
> > +=09VIRTIO_VIDEO_CONTROL_LEVEL,
> > +};
> > +
> > +struct virtio_video_query_control_profile {
> > +=09__le32 format; /* One of VIRTIO_VIDEO_FORMAT_* */
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_query_control_level {
> > +=09__le32 format; /* One of VIRTIO_VIDEO_FORMAT_* */
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_query_control {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 control; /* One of VIRTIO_VIDEO_CONTROL_* types */
> > +=09__u8 padding[4];
> > +=09/*
> > +=09 * Followed by a value of struct virtio_video_query_control_*
> > +=09 * in accordance with the value of control.
> > +=09 */
> > +};
> > +
> > +struct virtio_video_query_control_resp_profile {
> > +=09__le32 num;
> > +=09__u8 padding[4];
> > +=09/* Followed by an array le32 profiles[] */
> > +};
> > +
> > +struct virtio_video_query_control_resp_level {
> > +=09__le32 num;
> > +=09__u8 padding[4];
> > +=09/* Followed by an array le32 level[] */
> > +};
> > +
> > +struct virtio_video_query_control_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09/* Followed by one of struct virtio_video_query_control_resp_* */
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_GET_CONTROL */
> > +struct virtio_video_get_control {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 control; /* One of VIRTIO_VIDEO_CONTROL_* types */
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_control_val_bitrate {
> > +=09__le32 bitrate;
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_control_val_profile {
> > +=09__le32 profile;
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_control_val_level {
> > +=09__le32 level;
> > +=09__u8 padding[4];
> > +};
> > +
> > +struct virtio_video_get_control_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09/* Followed by one of struct virtio_video_control_val_* */
> > +};
> > +
> > +/* VIRTIO_VIDEO_CMD_SET_CONTROL */
> > +struct virtio_video_set_control {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +=09__le32 control; /* One of VIRTIO_VIDEO_CONTROL_* types */
> > +=09__u8 padding[4];
> > +=09/* Followed by one of struct virtio_video_control_val_* */
> > +};
> > +
> > +struct virtio_video_set_control_resp {
> > +=09struct virtio_video_cmd_hdr hdr;
> > +};
> > +
> > +/*
> > + * Events
> > + */
> > +
> > +enum virtio_video_event_type {
> > +=09/* For all devices */
> > +=09VIRTIO_VIDEO_EVENT_ERROR =3D 0x0100,
> > +
> > +=09/* For decoder only */
> > +=09VIRTIO_VIDEO_EVENT_DECODER_RESOLUTION_CHANGED =3D 0x0200,
> > +};
> > +
> > +struct virtio_video_event {
> > +=09__le32 event_type; /* One of VIRTIO_VIDEO_EVENT_* types */
> > +=09__le32 stream_id;
> > +};
> > +
> > +#endif /* _UAPI_LINUX_VIRTIO_VIDEO_H */
>=20
> Regards,
>=20
> =09Hans



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

