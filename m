Return-Path: virtio-dev-return-7947-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D278B985B9F
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:54:43 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sun, 24 Jan 2021 17:54:04 +0100
Message-ID: <20210124165408.1122868-6-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 5/9] ALSA: virtio: handling control and I/O messages for the PCM device
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

The driver implements a message-based transport for I/O substream
operations. Before the start of the substream, the hardware buffer is
sliced into I/O messages, the number of which is equal to the current
number of periods. The size of each message is equal to the current
size of one period.

I/O messages are organized in an ordered queue. The completion of the
I/O message indicates an elapsed period (the only exception is the end
of the stream for the capture substream). Upon completion, the message
is automatically re-added to the end of the queue.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile         |   3 +-
 sound/virtio/virtio_card.c    |  10 ++
 sound/virtio/virtio_card.h    |   9 +
 sound/virtio/virtio_pcm.c     |   3 +
 sound/virtio/virtio_pcm.h     |  31 ++++
 sound/virtio/virtio_pcm_msg.c | 325 ++++++++++++++++++++++++++++++++++
 6 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_pcm_msg.c

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 69162a545a41..626af3cc3ed7 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
 virtio_snd-objs :=3D \
 =09virtio_card.o \
 =09virtio_ctl_msg.o \
-=09virtio_pcm.o
+=09virtio_pcm.o \
+=09virtio_pcm_msg.o
=20
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 39fe13b43dd1..11d025ee77c2 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -143,6 +143,12 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 =09callbacks[VIRTIO_SND_VQ_CONTROL] =3D virtsnd_ctl_notify_cb;
 =09callbacks[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb;
=20
+=09virtio_cread(vdev, struct virtio_snd_config, streams, &n);
+=09if (n) {
+=09=09callbacks[VIRTIO_SND_VQ_TX] =3D virtsnd_pcm_tx_notify_cb;
+=09=09callbacks[VIRTIO_SND_VQ_RX] =3D virtsnd_pcm_rx_notify_cb;
+=09}
+
 =09rc =3D virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
 =09=09=09     NULL);
 =09if (rc) {
@@ -177,6 +183,10 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
  * virtsnd_enable_event_vq() - Enable the event virtqueue.
  * @snd: VirtIO sound device.
  *
+ * The tx queue is enabled only if the device supports playback stream(s).
+ *
+ * The rx queue is enabled only if the device supports capture stream(s).
+ *
  * Context: Any context.
  */
 static void virtsnd_enable_event_vq(struct virtio_snd *snd)
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index be6651a6aaf8..b11c09984882 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -89,4 +89,13 @@ virtsnd_rx_queue(struct virtio_snd *snd)
 =09return &snd->queues[VIRTIO_SND_VQ_RX];
 }
=20
+static inline struct virtio_snd_queue *
+virtsnd_pcm_queue(struct virtio_pcm_substream *substream)
+{
+=09if (substream->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+=09=09return virtsnd_tx_queue(substream->snd);
+=09else
+=09=09return virtsnd_rx_queue(substream->snd);
+}
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 036990b7b78a..1ab50dcc88c8 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -376,6 +376,7 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
=20
 =09=09substream->snd =3D snd;
 =09=09substream->sid =3D i;
+=09=09init_waitqueue_head(&substream->msg_empty);
=20
 =09=09rc =3D virtsnd_pcm_build_hw(substream, &info[i]);
 =09=09if (rc)
@@ -530,6 +531,8 @@ void virtsnd_pcm_event(struct virtio_snd *snd, struct v=
irtio_snd_event *event)
 =09=09break;
 =09}
 =09case VIRTIO_SND_EVT_PCM_XRUN: {
+=09=09if (atomic_read(&substream->xfer_enabled))
+=09=09=09atomic_set(&substream->xfer_xrun, 1);
 =09=09break;
 =09}
 =09}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 73fb4d9dc524..d011b7e1d18d 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -24,6 +24,7 @@
 #include <sound/pcm.h>
=20
 struct virtio_pcm;
+struct virtio_pcm_msg;
=20
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -34,6 +35,16 @@ struct virtio_pcm;
  * @features: Stream VirtIO feature bit map (1 << VIRTIO_SND_PCM_F_XXX).
  * @substream: Kernel ALSA substream.
  * @hw: Kernel ALSA substream hardware descriptor.
+ * @frame_bytes: Current frame size in bytes.
+ * @period_size: Current period size in frames.
+ * @buffer_size: Current buffer size in frames.
+ * @hw_ptr: Substream hardware pointer value in frames [0 ... buffer_size)=
.
+ * @xfer_enabled: Data transfer state (0 - off, 1 - on).
+ * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
+ * @msgs: I/O messages.
+ * @msg_last_enqueued: Index of the last I/O message added to the virtqueu=
e.
+ * @msg_count: Number of pending I/O messages in the virtqueue.
+ * @msg_empty: Notify when msg_count is zero.
  */
 struct virtio_pcm_substream {
 =09struct virtio_snd *snd;
@@ -43,6 +54,16 @@ struct virtio_pcm_substream {
 =09u32 features;
 =09struct snd_pcm_substream *substream;
 =09struct snd_pcm_hardware hw;
+=09unsigned int frame_bytes;
+=09snd_pcm_uframes_t period_size;
+=09snd_pcm_uframes_t buffer_size;
+=09atomic_t hw_ptr;
+=09atomic_t xfer_enabled;
+=09atomic_t xfer_xrun;
+=09struct virtio_pcm_msg *msgs;
+=09int msg_last_enqueued;
+=09atomic_t msg_count;
+=09wait_queue_head_t msg_empty;
 };
=20
 /**
@@ -86,4 +107,14 @@ struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *=
snd, unsigned int nid);
 struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
 =09=09=09=09=09      unsigned int nid);
=20
+struct virtio_snd_msg *
+virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *substream,
+=09=09=09  unsigned int command, gfp_t gfp);
+
+int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *substream,
+=09=09=09  unsigned int nmsg, u8 *dma_area,
+=09=09=09  unsigned int period_bytes);
+
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *substream);
+
 #endif /* VIRTIO_SND_PCM_H */
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
new file mode 100644
index 000000000000..d524e7cbe43f
--- /dev/null
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <sound/pcm_params.h>
+
+#include "virtio_card.h"
+
+/**
+ * enum pcm_msg_sg_index - Scatter-gather element indexes for an I/O messa=
ge.
+ * @PCM_MSG_SG_XFER: Element containing a virtio_snd_pcm_xfer structure.
+ * @PCM_MSG_SG_DATA: Element containing a data buffer.
+ * @PCM_MSG_SG_STATUS: Element containing a virtio_snd_pcm_status structur=
e.
+ * @PCM_MSG_SG_MAX: The maximum number of elements in the scatter-gather t=
able.
+ *
+ * These values are used as the index of the payload scatter-gather table.
+ */
+enum pcm_msg_sg_index {
+=09PCM_MSG_SG_XFER =3D 0,
+=09PCM_MSG_SG_DATA,
+=09PCM_MSG_SG_STATUS,
+=09PCM_MSG_SG_MAX
+};
+
+/**
+ * struct virtio_pcm_msg - VirtIO I/O message.
+ * @substream: VirtIO PCM substream.
+ * @xfer: Request header payload.
+ * @status: Response header payload.
+ * @sgs: Payload scatter-gather table.
+ */
+struct virtio_pcm_msg {
+=09struct virtio_pcm_substream *substream;
+=09struct virtio_snd_pcm_xfer xfer;
+=09struct virtio_snd_pcm_status status;
+=09struct scatterlist sgs[PCM_MSG_SG_MAX];
+};
+
+/**
+ * virtsnd_pcm_msg_alloc() - Allocate I/O messages.
+ * @substream: VirtIO PCM substream.
+ * @nmsg: Number of messages (equal to the number of periods).
+ * @dma_area: Pointer to used audio buffer.
+ * @period_bytes: Period (message payload) size.
+ *
+ * The function slices the buffer into nmsg parts (each with the size of
+ * period_bytes), and creates nmsg corresponding I/O messages.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *substream,
+=09=09=09  unsigned int nmsg, u8 *dma_area,
+=09=09=09  unsigned int period_bytes)
+{
+=09struct virtio_device *vdev =3D substream->snd->vdev;
+=09unsigned int i;
+
+=09if (substream->msgs)
+=09=09devm_kfree(&vdev->dev, substream->msgs);
+
+=09substream->msgs =3D devm_kcalloc(&vdev->dev, nmsg,
+=09=09=09=09       sizeof(*substream->msgs), GFP_KERNEL);
+=09if (!substream->msgs)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < nmsg; ++i) {
+=09=09struct virtio_pcm_msg *msg =3D &substream->msgs[i];
+
+=09=09msg->substream =3D substream;
+
+=09=09sg_init_table(msg->sgs, PCM_MSG_SG_MAX);
+=09=09sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
+=09=09=09    sizeof(msg->xfer));
+=09=09sg_init_one(&msg->sgs[PCM_MSG_SG_DATA],
+=09=09=09    dma_area + period_bytes * i, period_bytes);
+=09=09sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
+=09=09=09    sizeof(msg->status));
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
+ * @substream: VirtIO PCM substream.
+ *
+ * All messages are organized in an ordered circular list. Each time the
+ * function is called, all currently non-enqueued messages are added to th=
e
+ * virtqueue. For this, the function keeps track of two values:
+ *
+ *   msg_last_enqueued =3D index of the last enqueued message,
+ *   msg_count =3D # of pending messages in the virtqueue.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EIO on failure.
+ */
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *substream)
+{
+=09struct snd_pcm_runtime *runtime =3D substream->substream->runtime;
+=09struct virtio_snd *snd =3D substream->snd;
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtqueue *vqueue =3D virtsnd_pcm_queue(substream)->vqueue;
+=09int i;
+=09int n;
+=09bool notify =3D false;
+
+=09if (!vqueue)
+=09=09return -EIO;
+
+=09i =3D (substream->msg_last_enqueued + 1) % runtime->periods;
+=09n =3D runtime->periods - atomic_read(&substream->msg_count);
+
+=09for (; n; --n, i =3D (i + 1) % runtime->periods) {
+=09=09struct virtio_pcm_msg *msg =3D &substream->msgs[i];
+=09=09struct scatterlist *psgs[PCM_MSG_SG_MAX] =3D {
+=09=09=09[PCM_MSG_SG_XFER] =3D &msg->sgs[PCM_MSG_SG_XFER],
+=09=09=09[PCM_MSG_SG_DATA] =3D &msg->sgs[PCM_MSG_SG_DATA],
+=09=09=09[PCM_MSG_SG_STATUS] =3D &msg->sgs[PCM_MSG_SG_STATUS]
+=09=09};
+=09=09int rc;
+
+=09=09msg->xfer.stream_id =3D cpu_to_virtio32(vdev, substream->sid);
+=09=09memset(&msg->status, 0, sizeof(msg->status));
+
+=09=09atomic_inc(&substream->msg_count);
+
+=09=09if (substream->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+=09=09=09rc =3D virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
+=09=09=09=09=09       GFP_ATOMIC);
+=09=09else
+=09=09=09rc =3D virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
+=09=09=09=09=09       GFP_ATOMIC);
+
+=09=09if (rc) {
+=09=09=09atomic_dec(&substream->msg_count);
+=09=09=09return -EIO;
+=09=09}
+
+=09=09substream->msg_last_enqueued =3D i;
+=09}
+
+=09if (!(substream->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
+=09=09notify =3D virtqueue_kick_prepare(vqueue);
+
+=09if (notify)
+=09=09if (!virtqueue_notify(vqueue))
+=09=09=09return -EIO;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_msg_complete() - Complete an I/O message.
+ * @msg: I/O message.
+ * @size: Number of bytes written.
+ *
+ * Completion of the message means the elapsed period.
+ *
+ * The interrupt handler modifies three fields of the substream structure
+ * (hw_ptr, xfer_xrun, msg_count) that are used in operator functions. The=
se
+ * values are atomic to avoid frequent interlocks with the interrupt handl=
er.
+ * This becomes especially important in the case of multiple running subst=
reams
+ * that share both the virtqueue and interrupt handler.
+ *
+ * Context: Interrupt context.
+ */
+static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg, size_t si=
ze)
+{
+=09struct virtio_pcm_substream *substream =3D msg->substream;
+=09snd_pcm_uframes_t hw_ptr;
+=09unsigned int msg_count;
+
+=09/*
+=09 * hw_ptr always indicates the buffer position of the first I/O message
+=09 * in the virtqueue. Therefore, on each completion of an I/O message,
+=09 * the hw_ptr value is unconditionally advanced.
+=09 */
+=09hw_ptr =3D (snd_pcm_uframes_t)atomic_read(&substream->hw_ptr);
+
+=09/*
+=09 * If the capture substream returned an incorrect status, then just
+=09 * increase the hw_ptr by the period size.
+=09 */
+=09if (substream->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK ||
+=09    size <=3D sizeof(msg->status)) {
+=09=09hw_ptr +=3D substream->period_size;
+=09} else {
+=09=09size -=3D sizeof(msg->status);
+=09=09hw_ptr +=3D size / substream->frame_bytes;
+=09}
+
+=09atomic_set(&substream->hw_ptr, (u32)(hw_ptr % substream->buffer_size));
+=09atomic_set(&substream->xfer_xrun, 0);
+
+=09msg_count =3D atomic_dec_return(&substream->msg_count);
+
+=09if (atomic_read(&substream->xfer_enabled)) {
+=09=09struct snd_pcm_runtime *runtime =3D substream->substream->runtime;
+
+=09=09runtime->delay =3D
+=09=09=09bytes_to_frames(runtime,
+=09=09=09=09=09le32_to_cpu(msg->status.latency_bytes));
+
+=09=09snd_pcm_period_elapsed(substream->substream);
+
+=09=09virtsnd_pcm_msg_send(substream);
+=09} else if (!msg_count) {
+=09=09wake_up_all(&substream->msg_empty);
+=09}
+}
+
+/**
+ * virtsnd_pcm_notify_cb() - Process all completed I/O messages.
+ * @vqueue: Underlying tx/rx virtqueue.
+ *
+ * If transmission is allowed, then each completed message is immediately =
placed
+ * back at the end of the queue.
+ *
+ * Context: Interrupt context. Takes and releases the tx/rx queue spinlock=
.
+ */
+static inline void virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue)
+{
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09while (queue->vqueue) {
+=09=09virtqueue_disable_cb(queue->vqueue);
+
+=09=09for (;;) {
+=09=09=09struct virtio_pcm_msg *msg;
+=09=09=09u32 length;
+
+=09=09=09msg =3D virtqueue_get_buf(queue->vqueue, &length);
+=09=09=09if (!msg)
+=09=09=09=09break;
+
+=09=09=09virtsnd_pcm_msg_complete(msg, length);
+=09=09}
+
+=09=09if (unlikely(virtqueue_is_broken(queue->vqueue)))
+=09=09=09break;
+
+=09=09if (virtqueue_enable_cb(queue->vqueue))
+=09=09=09break;
+=09}
+=09spin_unlock_irqrestore(&queue->lock, flags);
+}
+
+/**
+ * virtsnd_pcm_tx_notify_cb() - Process all completed TX messages.
+ * @vqueue: Underlying tx virtqueue.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue)
+{
+=09struct virtio_snd *snd =3D vqueue->vdev->priv;
+
+=09virtsnd_pcm_notify_cb(virtsnd_tx_queue(snd));
+}
+
+/**
+ * virtsnd_pcm_rx_notify_cb() - Process all completed RX messages.
+ * @vqueue: Underlying rx virtqueue.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_pcm_rx_notify_cb(struct virtqueue *vqueue)
+{
+=09struct virtio_snd *snd =3D vqueue->vdev->priv;
+
+=09virtsnd_pcm_notify_cb(virtsnd_rx_queue(snd));
+}
+
+/**
+ * virtsnd_pcm_ctl_msg_alloc() - Allocate and initialize the PCM device co=
ntrol
+ *                               message for the specified substream.
+ * @substream: VirtIO PCM substream.
+ * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, ERR_PTR(-errno) on failure.
+ */
+struct virtio_snd_msg *
+virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *substream,
+=09=09=09  unsigned int command, gfp_t gfp)
+{
+=09struct virtio_device *vdev =3D substream->snd->vdev;
+=09size_t request_size =3D sizeof(struct virtio_snd_pcm_hdr);
+=09size_t response_size =3D sizeof(struct virtio_snd_hdr);
+=09struct virtio_snd_msg *msg;
+
+=09switch (command) {
+=09case VIRTIO_SND_R_PCM_SET_PARAMS: {
+=09=09request_size =3D sizeof(struct virtio_snd_pcm_set_params);
+=09=09break;
+=09}
+=09}
+
+=09msg =3D virtsnd_ctl_msg_alloc(vdev, request_size, response_size, gfp);
+=09if (!IS_ERR(msg)) {
+=09=09struct virtio_snd_pcm_hdr *hdr =3D sg_virt(&msg->sg_request);
+
+=09=09hdr->hdr.code =3D cpu_to_virtio32(vdev, command);
+=09=09hdr->stream_id =3D cpu_to_virtio32(vdev, substream->sid);
+=09}
+
+=09return msg;
+}
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

