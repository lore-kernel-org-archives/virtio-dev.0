Return-Path: virtio-dev-return-8015-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22C77985BC1
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Feb 2021 15:36:17 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Mon, 22 Feb 2021 16:34:40 +0100
Message-ID: <20210222153444.348390-6-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 5/9] ALSA: virtio: handling control and I/O messages for the PCM device
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
 sound/virtio/virtio_card.c    |  18 +-
 sound/virtio/virtio_card.h    |   9 +
 sound/virtio/virtio_pcm.c     |  32 +++
 sound/virtio/virtio_pcm.h     |  42 ++++
 sound/virtio/virtio_pcm_msg.c | 392 ++++++++++++++++++++++++++++++++++
 6 files changed, 493 insertions(+), 3 deletions(-)
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
index 235afc25fce7..a845978111d6 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -65,8 +65,16 @@ static void virtsnd_event_notify_cb(struct virtqueue *vq=
ueue)
 =09spin_lock_irqsave(&queue->lock, flags);
 =09do {
 =09=09virtqueue_disable_cb(vqueue);
-=09=09while ((event =3D virtqueue_get_buf(vqueue, &length)))
+=09=09while ((event =3D virtqueue_get_buf(vqueue, &length))) {
+=09=09=09switch (le32_to_cpu(event->hdr.code)) {
+=09=09=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
+=09=09=09case VIRTIO_SND_EVT_PCM_XRUN:
+=09=09=09=09virtsnd_pcm_event(snd, event);
+=09=09=09=09break;
+=09=09=09}
+
 =09=09=09virtsnd_event_send(vqueue, event, true, GFP_ATOMIC);
+=09=09}
 =09=09if (unlikely(virtqueue_is_broken(vqueue)))
 =09=09=09break;
 =09} while (!virtqueue_enable_cb(vqueue));
@@ -87,7 +95,9 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 =09struct virtio_device *vdev =3D snd->vdev;
 =09vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] =3D {
 =09=09[VIRTIO_SND_VQ_CONTROL] =3D virtsnd_ctl_notify_cb,
-=09=09[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb
+=09=09[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb,
+=09=09[VIRTIO_SND_VQ_TX] =3D virtsnd_pcm_tx_notify_cb,
+=09=09[VIRTIO_SND_VQ_RX] =3D virtsnd_pcm_rx_notify_cb
 =09};
 =09const char *names[VIRTIO_SND_VQ_MAX] =3D {
 =09=09[VIRTIO_SND_VQ_CONTROL] =3D "virtsnd-ctl",
@@ -299,6 +309,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
 static void virtsnd_remove(struct virtio_device *vdev)
 {
 =09struct virtio_snd *snd =3D vdev->priv;
+=09unsigned int i;
=20
 =09/* Stop all the virtqueues. */
 =09vdev->config->reset(vdev);
@@ -310,6 +321,9 @@ static void virtsnd_remove(struct virtio_device *vdev)
=20
 =09vdev->config->del_vqs(vdev);
=20
+=09for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i)
+=09=09virtsnd_pcm_msg_free(&snd->substreams[i]);
+
 =09kfree(snd->event_msgs);
 }
=20
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index f5e06a1ec033..3d8f5ad92f79 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -81,4 +81,13 @@ virtsnd_rx_queue(struct virtio_snd *snd)
 =09return &snd->queues[VIRTIO_SND_VQ_RX];
 }
=20
+static inline struct virtio_snd_queue *
+virtsnd_pcm_queue(struct virtio_pcm_substream *vss)
+{
+=09if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+=09=09return virtsnd_tx_queue(vss->snd);
+=09else
+=09=09return virtsnd_rx_queue(vss->snd);
+}
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 4348ead63c14..3cfd3520a9c0 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -337,6 +337,8 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
=20
 =09=09vss->snd =3D snd;
 =09=09vss->sid =3D i;
+=09=09init_waitqueue_head(&vss->msg_empty);
+=09=09spin_lock_init(&vss->lock);
=20
 =09=09rc =3D virtsnd_pcm_build_hw(vss, &info[i]);
 =09=09if (rc)
@@ -461,3 +463,33 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
=20
 =09return 0;
 }
+
+/**
+ * virtsnd_pcm_event() - Handle the PCM device event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent)
+{
+=09struct virtio_pcm_substream *vss;
+=09u32 sid =3D le32_to_cpu(event->data);
+
+=09if (sid >=3D snd->nsubstreams)
+=09=09return;
+
+=09vss =3D &snd->substreams[sid];
+
+=09switch (le32_to_cpu(event->hdr.code)) {
+=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
+=09=09/* TODO: deal with shmem elapsed period */
+=09=09break;
+=09case VIRTIO_SND_EVT_PCM_XRUN:
+=09=09spin_lock(&vss->lock);
+=09=09if (vss->xfer_enabled)
+=09=09=09vss->xfer_xrun =3D true;
+=09=09spin_unlock(&vss->lock);
+=09=09break;
+=09}
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index a2aadc44dce9..c70e4fed9044 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -22,6 +22,19 @@ struct virtio_pcm_msg;
  * @features: Stream VirtIO feature bit map (1 << VIRTIO_SND_PCM_F_XXX).
  * @substream: Kernel ALSA substream.
  * @hw: Kernel ALSA substream hardware descriptor.
+ * @frame_bytes: Current frame size in bytes.
+ * @period_size: Current period size in frames.
+ * @buffer_size: Current buffer size in frames.
+ * @lock: Spinlock that protects fields shared by interrupt handlers and
+ *        substream operators.
+ * @hw_ptr: Substream hardware pointer value in frames [0 ... buffer_size)=
.
+ * @xfer_enabled: Data transfer state (0 - off, 1 - on).
+ * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
+ * @msgs: Allocated I/O messages.
+ * @nmsgs: Number of allocated I/O messages.
+ * @msg_last_enqueued: Index of the last I/O message added to the virtqueu=
e.
+ * @msg_count: Number of pending I/O messages in the virtqueue.
+ * @msg_empty: Notify when msg_count is zero.
  */
 struct virtio_pcm_substream {
 =09struct virtio_snd *snd;
@@ -31,6 +44,18 @@ struct virtio_pcm_substream {
 =09u32 features;
 =09struct snd_pcm_substream *substream;
 =09struct snd_pcm_hardware hw;
+=09unsigned int frame_bytes;
+=09snd_pcm_uframes_t period_size;
+=09snd_pcm_uframes_t buffer_size;
+=09spinlock_t lock;
+=09snd_pcm_uframes_t hw_ptr;
+=09bool xfer_enabled;
+=09bool xfer_xrun;
+=09struct virtio_pcm_msg **msgs;
+=09unsigned int nmsgs;
+=09int msg_last_enqueued;
+=09unsigned int msg_count;
+=09wait_queue_head_t msg_empty;
 };
=20
 /**
@@ -63,8 +88,25 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
=20
 int virtsnd_pcm_build_devs(struct virtio_snd *snd);
=20
+void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent);
+
+void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue);
+
+void virtsnd_pcm_rx_notify_cb(struct virtqueue *vqueue);
+
 struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, u32 nid);
=20
 struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd, u32 =
nid);
=20
+struct virtio_snd_msg *
+virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
+=09=09=09  unsigned int command, gfp_t gfp);
+
+int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
+=09=09=09  unsigned int periods, unsigned int period_bytes);
+
+void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
+
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
+
 #endif /* VIRTIO_SND_PCM_H */
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
new file mode 100644
index 000000000000..8f29a9baf806
--- /dev/null
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#include <sound/pcm_params.h>
+
+#include "virtio_card.h"
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
+=09struct scatterlist sgs[0];
+};
+
+/**
+ * enum pcm_msg_sg_index - Index values for the virtio_pcm_msg->sgs field =
in
+ *                         an I/O message.
+ * @PCM_MSG_SG_XFER: Element containing a virtio_snd_pcm_xfer structure.
+ * @PCM_MSG_SG_STATUS: Element containing a virtio_snd_pcm_status structur=
e.
+ * @PCM_MSG_SG_DATA: The first element containing a data buffer.
+ */
+enum pcm_msg_sg_index {
+=09PCM_MSG_SG_XFER =3D 0,
+=09PCM_MSG_SG_STATUS,
+=09PCM_MSG_SG_DATA
+};
+
+/**
+ * virtsnd_pcm_sg_num() - Count the number of sg-elements required to repr=
esent
+ *                        vmalloc'ed buffer.
+ * @data: Pointer to vmalloc'ed buffer.
+ * @length: Buffer size.
+ *
+ * Context: Any context.
+ * Return: Number of physically contiguous parts in the @data.
+ */
+static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
+{
+=09phys_addr_t sg_address;
+=09unsigned int sg_length;
+=09int num =3D 0;
+
+=09while (length) {
+=09=09struct page *pg =3D vmalloc_to_page(data);
+=09=09phys_addr_t pg_address =3D page_to_phys(pg);
+=09=09size_t pg_length;
+
+=09=09pg_length =3D PAGE_SIZE - offset_in_page(data);
+=09=09if (pg_length > length)
+=09=09=09pg_length =3D length;
+
+=09=09if (!num || sg_address + sg_length !=3D pg_address) {
+=09=09=09sg_address =3D pg_address;
+=09=09=09sg_length =3D pg_length;
+=09=09=09num++;
+=09=09} else {
+=09=09=09sg_length +=3D pg_length;
+=09=09}
+
+=09=09data +=3D pg_length;
+=09=09length -=3D pg_length;
+=09}
+
+=09return num;
+}
+
+/**
+ * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
+ * @sgs: Preallocated sg-list to populate.
+ * @nsgs: The maximum number of elements in the @sgs.
+ * @data: Pointer to vmalloc'ed buffer.
+ * @length: Buffer size.
+ *
+ * Splits the buffer into physically contiguous parts and makes an sg-list=
 of
+ * such parts.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *dat=
a,
+=09=09=09=09unsigned int length)
+{
+=09int idx =3D -1;
+
+=09while (length) {
+=09=09struct page *pg =3D vmalloc_to_page(data);
+=09=09size_t pg_length;
+
+=09=09pg_length =3D PAGE_SIZE - offset_in_page(data);
+=09=09if (pg_length > length)
+=09=09=09pg_length =3D length;
+
+=09=09if (idx =3D=3D -1 ||
+=09=09    sg_phys(&sgs[idx]) + sgs[idx].length !=3D page_to_phys(pg)) {
+=09=09=09if (idx + 1 =3D=3D nsgs)
+=09=09=09=09break;
+=09=09=09sg_set_page(&sgs[++idx], pg, pg_length,
+=09=09=09=09    offset_in_page(data));
+=09=09} else {
+=09=09=09sgs[idx].length +=3D pg_length;
+=09=09}
+
+=09=09data +=3D pg_length;
+=09=09length -=3D pg_length;
+=09}
+
+=09sg_mark_end(&sgs[idx]);
+}
+
+/**
+ * virtsnd_pcm_msg_alloc() - Allocate I/O messages.
+ * @vss: VirtIO PCM substream.
+ * @periods: Current number of periods.
+ * @period_bytes: Current period size in bytes.
+ *
+ * The function slices the buffer into @periods parts (each with the size =
of
+ * @period_bytes), and creates @periods corresponding I/O messages.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -ENOMEM on failure.
+ */
+int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
+=09=09=09  unsigned int periods, unsigned int period_bytes)
+{
+=09struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
+=09unsigned int i;
+
+=09/* Free previously allocated messages (if any). */
+=09virtsnd_pcm_msg_free(vss);
+
+=09vss->msgs =3D kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
+=09if (!vss->msgs)
+=09=09return -ENOMEM;
+
+=09vss->nmsgs =3D periods;
+
+=09for (i =3D 0; i < periods; ++i) {
+=09=09u8 *data =3D runtime->dma_area + period_bytes * i;
+=09=09int sg_num =3D virtsnd_pcm_sg_num(data, period_bytes);
+=09=09struct virtio_pcm_msg *msg;
+
+=09=09msg =3D kzalloc(sizeof(*msg) + sizeof(*msg->sgs) * (sg_num + 2),
+=09=09=09      GFP_KERNEL);
+=09=09if (!msg)
+=09=09=09return -ENOMEM;
+
+=09=09msg->substream =3D vss;
+=09=09sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
+=09=09=09    sizeof(msg->xfer));
+=09=09sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
+=09=09=09    sizeof(msg->status));
+=09=09virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
+=09=09=09=09    period_bytes);
+
+=09=09vss->msgs[i] =3D msg;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_msg_free() - Free all allocated I/O messages.
+ * @vss: VirtIO PCM substream.
+ *
+ * Context: Any context.
+ */
+void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < vss->nmsgs; ++i)
+=09=09kfree(vss->msgs[i]);
+=09kfree(vss->msgs);
+
+=09vss->msgs =3D NULL;
+=09vss->nmsgs =3D 0;
+}
+
+/**
+ * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
+ * @vss: VirtIO PCM substream.
+ *
+ * All messages are organized in an ordered circular list. Each time the
+ * function is called, all currently non-enqueued messages are added to th=
e
+ * virtqueue. For this, the function keeps track of two values:
+ *
+ *   msg_last_enqueued =3D index of the last enqueued message,
+ *   msg_count =3D # of pending messages in the virtqueue.
+ *
+ * Context: Any context. Expects the tx/rx queue and the VirtIO substream
+ *          spinlocks to be held by caller.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
+{
+=09struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
+=09struct virtio_snd *snd =3D vss->snd;
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtqueue *vqueue =3D virtsnd_pcm_queue(vss)->vqueue;
+=09int i;
+=09int n;
+=09bool notify =3D false;
+
+=09i =3D (vss->msg_last_enqueued + 1) % runtime->periods;
+=09n =3D runtime->periods - vss->msg_count;
+
+=09for (; n; --n, i =3D (i + 1) % runtime->periods) {
+=09=09struct virtio_pcm_msg *msg =3D vss->msgs[i];
+=09=09struct scatterlist *psgs[] =3D {
+=09=09=09&msg->sgs[PCM_MSG_SG_XFER],
+=09=09=09&msg->sgs[PCM_MSG_SG_DATA],
+=09=09=09&msg->sgs[PCM_MSG_SG_STATUS]
+=09=09};
+=09=09int rc;
+
+=09=09msg->xfer.stream_id =3D cpu_to_le32(vss->sid);
+=09=09memset(&msg->status, 0, sizeof(msg->status));
+
+=09=09if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+=09=09=09rc =3D virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
+=09=09=09=09=09       GFP_ATOMIC);
+=09=09else
+=09=09=09rc =3D virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
+=09=09=09=09=09       GFP_ATOMIC);
+
+=09=09if (rc) {
+=09=09=09dev_err(&vdev->dev,
+=09=09=09=09"SID %u: failed to send I/O message\n",
+=09=09=09=09vss->sid);
+=09=09=09return rc;
+=09=09}
+
+=09=09vss->msg_last_enqueued =3D i;
+=09=09vss->msg_count++;
+=09}
+
+=09if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
+=09=09notify =3D virtqueue_kick_prepare(vqueue);
+
+=09if (notify)
+=09=09virtqueue_notify(vqueue);
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
+ * Context: Interrupt context. Takes and releases the VirtIO substream spi=
nlock.
+ */
+static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg, size_t si=
ze)
+{
+=09struct virtio_pcm_substream *vss =3D msg->substream;
+
+=09/*
+=09 * hw_ptr always indicates the buffer position of the first I/O message
+=09 * in the virtqueue. Therefore, on each completion of an I/O message,
+=09 * the hw_ptr value is unconditionally advanced.
+=09 */
+=09spin_lock(&vss->lock);
+=09/*
+=09 * If the capture substream returned an incorrect status, then just
+=09 * increase the hw_ptr by the period size.
+=09 */
+=09if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK ||
+=09    size <=3D sizeof(msg->status)) {
+=09=09vss->hw_ptr +=3D vss->period_size;
+=09} else {
+=09=09size -=3D sizeof(msg->status);
+=09=09vss->hw_ptr +=3D size / vss->frame_bytes;
+=09}
+
+=09vss->hw_ptr %=3D vss->buffer_size;
+=09vss->xfer_xrun =3D false;
+=09vss->msg_count--;
+
+=09if (vss->xfer_enabled) {
+=09=09struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
+
+=09=09runtime->delay =3D
+=09=09=09bytes_to_frames(runtime,
+=09=09=09=09=09le32_to_cpu(msg->status.latency_bytes));
+
+=09=09spin_unlock(&vss->lock);
+=09=09snd_pcm_period_elapsed(vss->substream);
+=09=09spin_lock(&vss->lock);
+
+=09=09virtsnd_pcm_msg_send(vss);
+=09} else if (!vss->msg_count) {
+=09=09wake_up_all(&vss->msg_empty);
+=09}
+=09spin_unlock(&vss->lock);
+}
+
+/**
+ * virtsnd_pcm_notify_cb() - Process all completed I/O messages.
+ * @queue: Underlying tx/rx virtqueue.
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
+=09struct virtio_pcm_msg *msg;
+=09u32 length;
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09do {
+=09=09virtqueue_disable_cb(queue->vqueue);
+=09=09while ((msg =3D virtqueue_get_buf(queue->vqueue, &length)))
+=09=09=09virtsnd_pcm_msg_complete(msg, length);
+=09=09if (unlikely(virtqueue_is_broken(queue->vqueue)))
+=09=09=09break;
+=09} while (!virtqueue_enable_cb(queue->vqueue));
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
+ * @vss: VirtIO PCM substream.
+ * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, NULL on failure.
+ */
+struct virtio_snd_msg *
+virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
+=09=09=09  unsigned int command, gfp_t gfp)
+{
+=09size_t request_size =3D sizeof(struct virtio_snd_pcm_hdr);
+=09size_t response_size =3D sizeof(struct virtio_snd_hdr);
+=09struct virtio_snd_msg *msg;
+
+=09switch (command) {
+=09case VIRTIO_SND_R_PCM_SET_PARAMS:
+=09=09request_size =3D sizeof(struct virtio_snd_pcm_set_params);
+=09=09break;
+=09}
+
+=09msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, gfp);
+=09if (msg) {
+=09=09struct virtio_snd_pcm_hdr *hdr =3D virtsnd_ctl_msg_request(msg);
+
+=09=09hdr->hdr.code =3D cpu_to_le32(command);
+=09=09hdr->stream_id =3D cpu_to_le32(vss->sid);
+=09}
+
+=09return msg;
+}
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

