Return-Path: virtio-dev-return-7929-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F01A098604B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 00:37:20 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Wed, 20 Jan 2021 01:36:33 +0100
Message-ID: <20210120003638.3339987-6-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 5/7] ALSA: virtio: PCM substream operators
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce the operators required for the operation of substreams.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile         |   3 +-
 sound/virtio/virtio_pcm.c     |   5 +-
 sound/virtio/virtio_pcm.h     |   2 +
 sound/virtio/virtio_pcm_ops.c | 509 ++++++++++++++++++++++++++++++++++
 4 files changed, 517 insertions(+), 2 deletions(-)
 create mode 100644 sound/virtio/virtio_pcm_ops.c

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 626af3cc3ed7..34493226793f 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -6,5 +6,6 @@ virtio_snd-objs :=3D \
 =09virtio_card.o \
 =09virtio_ctl_msg.o \
 =09virtio_pcm.o \
-=09virtio_pcm_msg.o
+=09virtio_pcm_msg.o \
+=09virtio_pcm_ops.o
=20
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 1ab50dcc88c8..6a1ca6b2c3ca 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -121,7 +121,8 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_subst=
ream *substream,
 =09=09SNDRV_PCM_INFO_MMAP_VALID |
 =09=09SNDRV_PCM_INFO_BATCH |
 =09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
-=09=09SNDRV_PCM_INFO_INTERLEAVED;
+=09=09SNDRV_PCM_INFO_INTERLEAVED |
+=09=09SNDRV_PCM_INFO_PAUSE;
=20
 =09if (!info->channels_min || info->channels_min > info->channels_max) {
 =09=09dev_err(&vdev->dev,
@@ -503,6 +504,8 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
 =09=09=09=09if (rc)
 =09=09=09=09=09return rc;
 =09=09=09}
+
+=09=09=09snd_pcm_set_ops(pcm->pcm, i, &virtsnd_pcm_ops);
 =09=09}
=20
 =09return 0;
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index d011b7e1d18d..fe467bc05d8b 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -90,6 +90,8 @@ struct virtio_pcm {
 =09struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
 };
=20
+extern const struct snd_pcm_ops virtsnd_pcm_ops;
+
 int virtsnd_pcm_validate(struct virtio_device *vdev);
=20
 int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
new file mode 100644
index 000000000000..8d26c1144ad6
--- /dev/null
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -0,0 +1,509 @@
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
+/*
+ * Our main concern here is maintaining the correct state of the underlyin=
g I/O
+ * virtqueues. Thus, operators are implemented to support all of the follo=
wing
+ * possible control paths (excluding all trivial ones):
+ *
+ *                        +---------+
+ *                        | open()  |<------------------+
+ *                        +----+----+                   |
+ *                             v                        |
+ *                      +------+------+                 |
+ *       +------------->| hw_params() |<-------------+  |
+ *       |              +-------------+              |  |
+ *       |                     v                     |  |
+ *       |               +-----------+               |  |
+ *       |               | prepare() |<-----------+  |  |
+ *       |               +-----------+            |  |  |
+ *       |                     v                  |  |  |
+ *       |        +-------------------------+     |  |  |
+ * +-----------+  | trigger(START/          |     |  |  |
+ * | restore() |  |         PAUSE_RELEASE/  |<-+  |  |  |
+ * +-----------+  |         RESUME)         |  |  |  |  |
+ *       ^        +-------------------------+  |  |  |  |
+ *       |                     v               |  |  |  |
+ *       |               +-----------+         |  |  |  |
+ *       |               | pointer() |         |  |  |  |
+ *       |               +-----------+         |  |  |  |
+ *       |                     v               |  |  |  |
+ *       |          +---------------------+    |  |  |  |
+ * +-----------+    | trigger(STOP/       |----+  |  |  |
+ * | freeze()  |<---|         PAUSE_PUSH/ |-------+  |  |
+ * +-----------+    |         SUSPEND)    |          |  |
+ *                  +---------------------+          |  |
+ *                             v                     |  |
+ *                       +-----------+               |  |
+ *                       | hw_free() |---------------+  |
+ *                       +-----------+                  |
+ *                             v                        |
+ *                        +---------+                   |
+ *                        | close() |-------------------+
+ *                        +---------+
+ */
+
+/* Map for converting ALSA format to VirtIO format. */
+struct virtsnd_a2v_format {
+=09unsigned int alsa_bit;
+=09unsigned int vio_bit;
+};
+
+static const struct virtsnd_a2v_format g_a2v_format_map[] =3D {
+=09{ SNDRV_PCM_FORMAT_IMA_ADPCM, VIRTIO_SND_PCM_FMT_IMA_ADPCM },
+=09{ SNDRV_PCM_FORMAT_MU_LAW, VIRTIO_SND_PCM_FMT_MU_LAW },
+=09{ SNDRV_PCM_FORMAT_A_LAW, VIRTIO_SND_PCM_FMT_A_LAW },
+=09{ SNDRV_PCM_FORMAT_S8, VIRTIO_SND_PCM_FMT_S8 },
+=09{ SNDRV_PCM_FORMAT_U8, VIRTIO_SND_PCM_FMT_U8 },
+=09{ SNDRV_PCM_FORMAT_S16_LE, VIRTIO_SND_PCM_FMT_S16 },
+=09{ SNDRV_PCM_FORMAT_U16_LE, VIRTIO_SND_PCM_FMT_U16 },
+=09{ SNDRV_PCM_FORMAT_S18_3LE, VIRTIO_SND_PCM_FMT_S18_3 },
+=09{ SNDRV_PCM_FORMAT_U18_3LE, VIRTIO_SND_PCM_FMT_U18_3 },
+=09{ SNDRV_PCM_FORMAT_S20_3LE, VIRTIO_SND_PCM_FMT_S20_3 },
+=09{ SNDRV_PCM_FORMAT_U20_3LE, VIRTIO_SND_PCM_FMT_U20_3 },
+=09{ SNDRV_PCM_FORMAT_S24_3LE, VIRTIO_SND_PCM_FMT_S24_3 },
+=09{ SNDRV_PCM_FORMAT_U24_3LE, VIRTIO_SND_PCM_FMT_U24_3 },
+=09{ SNDRV_PCM_FORMAT_S20_LE, VIRTIO_SND_PCM_FMT_S20 },
+=09{ SNDRV_PCM_FORMAT_U20_LE, VIRTIO_SND_PCM_FMT_U20 },
+=09{ SNDRV_PCM_FORMAT_S24_LE, VIRTIO_SND_PCM_FMT_S24 },
+=09{ SNDRV_PCM_FORMAT_U24_LE, VIRTIO_SND_PCM_FMT_U24 },
+=09{ SNDRV_PCM_FORMAT_S32_LE, VIRTIO_SND_PCM_FMT_S32 },
+=09{ SNDRV_PCM_FORMAT_U32_LE, VIRTIO_SND_PCM_FMT_U32 },
+=09{ SNDRV_PCM_FORMAT_FLOAT_LE, VIRTIO_SND_PCM_FMT_FLOAT },
+=09{ SNDRV_PCM_FORMAT_FLOAT64_LE, VIRTIO_SND_PCM_FMT_FLOAT64 },
+=09{ SNDRV_PCM_FORMAT_DSD_U8, VIRTIO_SND_PCM_FMT_DSD_U8 },
+=09{ SNDRV_PCM_FORMAT_DSD_U16_LE, VIRTIO_SND_PCM_FMT_DSD_U16 },
+=09{ SNDRV_PCM_FORMAT_DSD_U32_LE, VIRTIO_SND_PCM_FMT_DSD_U32 },
+=09{ SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE,
+=09  VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME }
+};
+
+/* Map for converting ALSA frame rate to VirtIO frame rate. */
+struct virtsnd_a2v_rate {
+=09unsigned int rate;
+=09unsigned int vio_bit;
+};
+
+static const struct virtsnd_a2v_rate g_a2v_rate_map[] =3D {
+=09{ 5512, VIRTIO_SND_PCM_RATE_5512 },
+=09{ 8000, VIRTIO_SND_PCM_RATE_8000 },
+=09{ 11025, VIRTIO_SND_PCM_RATE_11025 },
+=09{ 16000, VIRTIO_SND_PCM_RATE_16000 },
+=09{ 22050, VIRTIO_SND_PCM_RATE_22050 },
+=09{ 32000, VIRTIO_SND_PCM_RATE_32000 },
+=09{ 44100, VIRTIO_SND_PCM_RATE_44100 },
+=09{ 48000, VIRTIO_SND_PCM_RATE_48000 },
+=09{ 64000, VIRTIO_SND_PCM_RATE_64000 },
+=09{ 88200, VIRTIO_SND_PCM_RATE_88200 },
+=09{ 96000, VIRTIO_SND_PCM_RATE_96000 },
+=09{ 176400, VIRTIO_SND_PCM_RATE_176400 },
+=09{ 192000, VIRTIO_SND_PCM_RATE_192000 }
+};
+
+/**
+ * virtsnd_pcm_release() - Release the PCM substream on the device side.
+ * @substream: VirtIO substream.
+ *
+ * The function waits for all pending I/O messages to complete.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static inline bool virtsnd_pcm_released(struct virtio_pcm_substream *subst=
ream)
+{
+=09return atomic_read(&substream->msg_count) =3D=3D 0;
+}
+
+static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
+{
+=09struct virtio_snd *snd =3D substream->snd;
+=09struct virtio_snd_msg *msg;
+=09unsigned int js =3D msecs_to_jiffies(msg_timeout_ms);
+=09int rc;
+
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
+=09=09=09=09=09GFP_KERNEL);
+=09if (IS_ERR(msg))
+=09=09return PTR_ERR(msg);
+
+=09rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
+=09if (rc)
+=09=09return rc;
+
+=09return wait_event_interruptible_timeout(substream->msg_empty,
+=09=09=09=09=09=09virtsnd_pcm_released(substream),
+=09=09=09=09=09=09js);
+}
+
+/**
+ * virtsnd_pcm_open() - Open the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm *pcm =3D snd_pcm_substream_chip(substream);
+=09struct virtio_pcm_substream *ss =3D NULL;
+
+=09if (pcm) {
+=09=09switch (substream->stream) {
+=09=09case SNDRV_PCM_STREAM_PLAYBACK:
+=09=09case SNDRV_PCM_STREAM_CAPTURE: {
+=09=09=09struct virtio_pcm_stream *stream =3D
+=09=09=09=09&pcm->streams[substream->stream];
+
+=09=09=09if (substream->number < stream->nsubstreams)
+=09=09=09=09ss =3D stream->substreams[substream->number];
+=09=09=09break;
+=09=09}
+=09=09}
+=09}
+
+=09if (!ss)
+=09=09return -EBADFD;
+
+=09substream->runtime->hw =3D ss->hw;
+=09substream->private_data =3D ss;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_close() - Close the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Any context.
+ * Return: 0.
+ */
+static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
+{
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_hw_params() - Set the parameters of the PCM substream.
+ * @substream: Kernel ALSA substream.
+ * @hw_params: Hardware parameters (can be NULL).
+ *
+ * The function can be called both from the upper level (in this case,
+ * @hw_params is not NULL) or from the driver itself (in this case, @hw_pa=
rams
+ * is NULL, and the parameter values are taken from the runtime structure)=
.
+ *
+ * In all cases, the function:
+ *   1. checks the state of the virtqueue and, if necessary, tries to fix =
it,
+ *   2. sets the parameters on the device side,
+ *   3. allocates a hardware buffer and I/O messages.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
+=09=09=09=09 struct snd_pcm_hw_params *hw_params)
+{
+=09struct snd_pcm_runtime *runtime =3D substream->runtime;
+=09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_device *vdev =3D ss->snd->vdev;
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_pcm_set_params *request;
+=09snd_pcm_format_t format;
+=09unsigned int channels;
+=09unsigned int rate;
+=09unsigned int buffer_bytes;
+=09unsigned int period_bytes;
+=09unsigned int periods;
+=09unsigned int i;
+=09int vformat =3D -1;
+=09int vrate =3D -1;
+=09int rc;
+
+=09/*
+=09 * If we got here after ops->trigger() was called, the queue may
+=09 * still contain messages. In this case, we need to release the
+=09 * substream first.
+=09 */
+=09if (atomic_read(&ss->msg_count)) {
+=09=09rc =3D virtsnd_pcm_release(ss);
+=09=09if (rc) {
+=09=09=09dev_err(&vdev->dev,
+=09=09=09=09"SID %u: invalid I/O queue state\n",
+=09=09=09=09ss->sid);
+=09=09=09return rc;
+=09=09}
+=09}
+
+=09/* Set hardware parameters in device */
+=09if (hw_params) {
+=09=09format =3D params_format(hw_params);
+=09=09channels =3D params_channels(hw_params);
+=09=09rate =3D params_rate(hw_params);
+=09=09buffer_bytes =3D params_buffer_bytes(hw_params);
+=09=09period_bytes =3D params_period_bytes(hw_params);
+=09=09periods =3D params_periods(hw_params);
+=09} else {
+=09=09format =3D runtime->format;
+=09=09channels =3D runtime->channels;
+=09=09rate =3D runtime->rate;
+=09=09buffer_bytes =3D frames_to_bytes(runtime, runtime->buffer_size);
+=09=09period_bytes =3D frames_to_bytes(runtime, runtime->period_size);
+=09=09periods =3D runtime->periods;
+=09}
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_a2v_format_map); ++i)
+=09=09if (g_a2v_format_map[i].alsa_bit =3D=3D format) {
+=09=09=09vformat =3D g_a2v_format_map[i].vio_bit;
+
+=09=09=09break;
+=09=09}
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_a2v_rate_map); ++i)
+=09=09if (g_a2v_rate_map[i].rate =3D=3D rate) {
+=09=09=09vrate =3D g_a2v_rate_map[i].vio_bit;
+
+=09=09=09break;
+=09=09}
+
+=09if (vformat =3D=3D -1 || vrate =3D=3D -1)
+=09=09return -EINVAL;
+
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_SET_PARAMS,
+=09=09=09=09=09GFP_KERNEL);
+=09if (IS_ERR(msg))
+=09=09return PTR_ERR(msg);
+
+=09request =3D sg_virt(&msg->sg_request);
+
+=09request->buffer_bytes =3D cpu_to_virtio32(vdev, buffer_bytes);
+=09request->period_bytes =3D cpu_to_virtio32(vdev, period_bytes);
+=09request->channels =3D channels;
+=09request->format =3D vformat;
+=09request->rate =3D vrate;
+
+=09if (ss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING))
+=09=09request->features |=3D
+=09=09=09cpu_to_virtio32(vdev,
+=09=09=09=09=091U << VIRTIO_SND_PCM_F_MSG_POLLING);
+
+=09if (ss->features & (1U << VIRTIO_SND_PCM_F_EVT_XRUNS))
+=09=09request->features |=3D
+=09=09=09cpu_to_virtio32(vdev,
+=09=09=09=09=091U << VIRTIO_SND_PCM_F_EVT_XRUNS);
+
+=09rc =3D virtsnd_ctl_msg_send_sync(ss->snd, msg);
+=09if (rc)
+=09=09return rc;
+
+=09/* If the buffer was already allocated earlier, do nothing. */
+=09if (runtime->dma_area)
+=09=09return 0;
+
+=09/* Allocate hardware buffer */
+=09rc =3D snd_pcm_lib_malloc_pages(substream, buffer_bytes);
+=09if (rc < 0)
+=09=09return rc;
+
+=09/* Allocate and initialize I/O messages */
+=09rc =3D virtsnd_pcm_msg_alloc(ss, periods, runtime->dma_area,
+=09=09=09=09   period_bytes);
+=09if (rc)
+=09=09snd_pcm_lib_free_pages(substream);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_pcm_hw_free() - Reset the parameters of the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * The function does the following:
+ *   1. tries to release the PCM substream on the device side,
+ *   2. frees the hardware buffer.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
+=09int rc;
+
+=09rc =3D virtsnd_pcm_release(ss);
+
+=09/*
+=09 * Even if we failed to send the RELEASE message or wait for the queue
+=09 * flush to complete, we can safely delete the buffer. Because after
+=09 * receiving the STOP command, the device must stop all I/O message
+=09 * processing. If there are still pending messages in the queue, the
+=09 * next ops->hw_params() call should deal with this.
+=09 */
+=09snd_pcm_lib_free_pages(substream);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_pcm_hw_params() - Prepare the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * The function can be called both from the upper level or from the driver
+ * itself.
+ *
+ * In all cases, the function:
+ *   1. checks the state of the virtqueue and, if necessary, tries to fix =
it,
+ *   2. prepares the substream on the device side.
+ *
+ * Context: Any context that permits to sleep. May take and release the tx=
/rx
+ *          queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(ss);
+=09struct virtio_snd_msg *msg;
+=09unsigned long flags;
+=09int rc;
+
+=09/*
+=09 * If we got here after ops->trigger() was called, the queue may
+=09 * still contain messages. In this case, we need to reset the
+=09 * substream first.
+=09 */
+=09if (atomic_read(&ss->msg_count)) {
+=09=09rc =3D virtsnd_pcm_hw_params(substream, NULL);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09ss->msg_last_enqueued =3D -1;
+=09spin_unlock_irqrestore(&queue->lock, flags);
+
+=09/*
+=09 * Since I/O messages are asynchronous, they can be completed
+=09 * when the runtime structure no longer exists. Since each
+=09 * completion implies incrementing the hw_ptr, we cache all the
+=09 * current values needed to compute the new hw_ptr value.
+=09 */
+=09ss->frame_bytes =3D substream->runtime->frame_bits >> 3;
+=09ss->period_size =3D substream->runtime->period_size;
+=09ss->buffer_size =3D substream->runtime->buffer_size;
+
+=09atomic_set(&ss->hw_ptr, 0);
+=09atomic_set(&ss->xfer_xrun, 0);
+=09atomic_set(&ss->msg_count, 0);
+
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_PREPARE,
+=09=09=09=09=09GFP_KERNEL);
+=09if (IS_ERR(msg))
+=09=09return PTR_ERR(msg);
+
+=09return virtsnd_ctl_msg_send_sync(ss->snd, msg);
+}
+
+/**
+ * virtsnd_pcm_trigger() - Process command for the PCM substream.
+ * @substream: Kernel ALSA substream.
+ * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
+ *
+ * Depending on the command, the function does the following:
+ *   1. enables/disables data transmission,
+ *   2. starts/stops the substream on the device side.
+ *
+ * Context: Atomic context. May take and release the tx/rx queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int co=
mmand)
+{
+=09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_snd *snd =3D ss->snd;
+=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(ss);
+=09struct virtio_snd_msg *msg;
+
+=09switch (command) {
+=09case SNDRV_PCM_TRIGGER_START:
+=09case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
+=09=09int rc;
+
+=09=09spin_lock(&queue->lock);
+=09=09rc =3D virtsnd_pcm_msg_send(ss);
+=09=09spin_unlock(&queue->lock);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09atomic_set(&ss->xfer_enabled, 1);
+
+=09=09msg =3D virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_START,
+=09=09=09=09=09=09GFP_ATOMIC);
+=09=09if (IS_ERR(msg))
+=09=09=09return PTR_ERR(msg);
+
+=09=09return virtsnd_ctl_msg_send(snd, msg);
+=09}
+=09case SNDRV_PCM_TRIGGER_STOP:
+=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
+=09=09atomic_set(&ss->xfer_enabled, 0);
+
+=09=09msg =3D virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
+=09=09=09=09=09=09GFP_ATOMIC);
+=09=09if (IS_ERR(msg))
+=09=09=09return PTR_ERR(msg);
+
+=09=09return virtsnd_ctl_msg_send(snd, msg);
+=09}
+=09default: {
+=09=09return -EINVAL;
+=09}
+=09}
+}
+
+/**
+ * virtsnd_pcm_pointer() - Get the current hardware position for the PCM
+ *                         substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Atomic context.
+ * Return: Hardware position in frames inside [0 ... buffer_size) range.
+ */
+static snd_pcm_uframes_t
+virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
+
+=09if (atomic_read(&ss->xfer_xrun))
+=09=09return SNDRV_PCM_POS_XRUN;
+
+=09return (snd_pcm_uframes_t)atomic_read(&ss->hw_ptr);
+}
+
+/* PCM substream operators map. */
+const struct snd_pcm_ops virtsnd_pcm_ops =3D {
+=09.open =3D virtsnd_pcm_open,
+=09.close =3D virtsnd_pcm_close,
+=09.ioctl =3D snd_pcm_lib_ioctl,
+=09.hw_params =3D virtsnd_pcm_hw_params,
+=09.hw_free =3D virtsnd_pcm_hw_free,
+=09.prepare =3D virtsnd_pcm_prepare,
+=09.trigger =3D virtsnd_pcm_trigger,
+=09.pointer =3D virtsnd_pcm_pointer,
+};
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

