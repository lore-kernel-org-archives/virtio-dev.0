Return-Path: virtio-dev-return-8058-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 024DF986691
	for <virtio-dev@lists.oasis-open.org>; Sat, 27 Feb 2021 09:00:40 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sat, 27 Feb 2021 09:59:53 +0100
Message-ID: <20210227085956.1700687-7-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce the operators required for the operation of substreams.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile         |   3 +-
 sound/virtio/virtio_pcm.c     |   2 +
 sound/virtio/virtio_pcm.h     |   4 +
 sound/virtio/virtio_pcm_ops.c | 453 ++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+), 1 deletion(-)
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
index 3cfd3520a9c0..3605151860f2 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -454,6 +454,8 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
=20
 =09=09=09for (kss =3D ks->substream; kss; kss =3D kss->next)
 =09=09=09=09vs->substreams[kss->number]->substream =3D kss;
+
+=09=09=09snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
 =09=09}
=20
 =09=09snd_pcm_set_managed_buffer_all(vpcm->pcm,
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 7af41cad4e8f..55dfb19d14b3 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -28,6 +28,7 @@ struct virtio_pcm_msg;
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes)=
.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
+ * @release: True if the substream must be released on the device side.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueu=
e.
@@ -47,6 +48,7 @@ struct virtio_pcm_substream {
 =09size_t hw_ptr;
 =09bool xfer_enabled;
 =09bool xfer_xrun;
+=09bool release;
 =09struct virtio_pcm_msg **msgs;
 =09unsigned int nmsgs;
 =09int msg_last_enqueued;
@@ -78,6 +80,8 @@ struct virtio_pcm {
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
index 000000000000..d02d79bd94f3
--- /dev/null
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#include <sound/pcm_params.h>
+
+#include "virtio_card.h"
+
+/*
+ * I/O messages lifetime
+ * ---------------------
+ *
+ * Allocation:
+ *   Messages are initially allocated in the ops->hw_params() after the si=
ze and
+ *   number of periods have been successfully negotiated.
+ *
+ * Freeing:
+ *   Messages can be safely freed after the queue has been successfully fl=
ushed
+ *   (RELEASE command in the ops->sync_stop()) and the ops->hw_free() has =
been
+ *   called.
+ *
+ *   When the substream stops, the ops->sync_stop() waits until the device=
 has
+ *   completed all pending messages. This wait can be interrupted either b=
y a
+ *   signal or due to a timeout. In this case, the device can still access
+ *   messages even after calling ops->hw_free(). It can also issue an inte=
rrupt,
+ *   and the interrupt handler will also try to access message structures.
+ *
+ *   Therefore, freeing of already allocated messages occurs:
+ *
+ *   - in ops->hw_params(), if this operator was called several times in a=
 row,
+ *     or if ops->hw_free() failed to free messages previously;
+ *
+ *   - in ops->hw_free(), if the queue has been successfully flushed;
+ *
+ *   - in dev->release().
+ */
+
+/* Map for converting ALSA format to VirtIO format. */
+struct virtsnd_a2v_format {
+=09snd_pcm_format_t alsa_bit;
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
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
+
+/**
+ * virtsnd_pcm_open() - Open the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm *vpcm =3D snd_pcm_substream_chip(substream);
+=09struct virtio_pcm_stream *vs =3D &vpcm->streams[substream->stream];
+=09struct virtio_pcm_substream *vss =3D vs->substreams[substream->number];
+
+=09substream->runtime->hw =3D vss->hw;
+=09substream->private_data =3D vss;
+
+=09snd_pcm_hw_constraint_integer(substream->runtime,
+=09=09=09=09      SNDRV_PCM_HW_PARAM_PERIODS);
+
+=09/*
+=09 * If the substream has already been used, then the I/O queue may be in
+=09 * an invalid state. Just in case, we do a check and try to return the
+=09 * queue to its original state, if necessary.
+=09 */
+=09vss->release =3D !!virtsnd_pcm_msg_pending_num(vss);
+
+=09return virtsnd_pcm_sync_stop(substream);
+}
+
+/**
+ * virtsnd_pcm_close() - Close the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Process context.
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
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
+=09=09=09=09 struct snd_pcm_hw_params *hw_params)
+{
+=09struct snd_pcm_runtime *runtime =3D substream->runtime;
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_device *vdev =3D vss->snd->vdev;
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
+=09if (virtsnd_pcm_msg_pending_num(vss)) {
+=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+=09=09=09vss->sid);
+=09=09return -EBADFD;
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
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_SET_PARAMS,
+=09=09=09=09=09GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09request =3D virtsnd_ctl_msg_request(msg);
+=09request->buffer_bytes =3D cpu_to_le32(buffer_bytes);
+=09request->period_bytes =3D cpu_to_le32(period_bytes);
+=09request->channels =3D channels;
+=09request->format =3D vformat;
+=09request->rate =3D vrate;
+
+=09if (vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING))
+=09=09request->features |=3D
+=09=09=09cpu_to_le32(1U << VIRTIO_SND_PCM_F_MSG_POLLING);
+
+=09if (vss->features & (1U << VIRTIO_SND_PCM_F_EVT_XRUNS))
+=09=09request->features |=3D
+=09=09=09cpu_to_le32(1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
+
+=09rc =3D virtsnd_ctl_msg_send_sync(vss->snd, msg);
+=09if (rc)
+=09=09return rc;
+
+=09/* Free previously allocated messages (if any). */
+=09virtsnd_pcm_msg_free(vss);
+
+=09return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
+}
+
+/**
+ * virtsnd_pcm_hw_free() - Reset the parameters of the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Process context.
+ * Return: 0
+ */
+static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+
+=09/* If the queue is flushed, we can safely free the messages here. */
+=09if (!virtsnd_pcm_msg_pending_num(vss))
+=09=09virtsnd_pcm_msg_free(vss);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_prepare() - Prepare the PCM substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * The function can be called both from the upper level or from the driver
+ * itself.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_device *vdev =3D vss->snd->vdev;
+=09struct virtio_snd_msg *msg;
+
+=09if (virtsnd_pcm_msg_pending_num(vss)) {
+=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+=09=09=09vss->sid);
+=09=09return -EBADFD;
+=09}
+
+=09vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09vss->hw_ptr =3D 0;
+=09vss->xfer_xrun =3D false;
+=09vss->msg_last_enqueued =3D -1;
+=09vss->msg_count =3D 0;
+
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
+=09=09=09=09=09GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+}
+
+/**
+ * virtsnd_pcm_trigger() - Process command for the PCM substream.
+ * @substream: Kernel ALSA substream.
+ * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
+ *
+ * Context: Any context. Takes and releases the VirtIO substream spinlock.
+ *          May take and release the tx/rx queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int co=
mmand)
+{
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_snd *snd =3D vss->snd;
+=09struct virtio_snd_msg *msg;
+=09unsigned long flags;
+=09int rc;
+
+=09switch (command) {
+=09case SNDRV_PCM_TRIGGER_START:
+=09case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
+=09=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
+
+=09=09spin_lock_irqsave(&queue->lock, flags);
+=09=09spin_lock(&vss->lock);
+=09=09rc =3D virtsnd_pcm_msg_send(vss);
+=09=09if (!rc)
+=09=09=09vss->xfer_enabled =3D true;
+=09=09spin_unlock(&vss->lock);
+=09=09spin_unlock_irqrestore(&queue->lock, flags);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
+=09=09=09=09=09=09GFP_KERNEL);
+=09=09if (!msg) {
+=09=09=09spin_lock_irqsave(&vss->lock, flags);
+=09=09=09vss->xfer_enabled =3D false;
+=09=09=09spin_unlock_irqrestore(&vss->lock, flags);
+
+=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09return virtsnd_ctl_msg_send_sync(snd, msg);
+=09}
+=09case SNDRV_PCM_TRIGGER_STOP:
+=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
+=09=09spin_lock_irqsave(&vss->lock, flags);
+=09=09vss->xfer_enabled =3D false;
+=09=09spin_unlock_irqrestore(&vss->lock, flags);
+
+=09=09/*
+=09=09 * The substream needs to be released on the device side only
+=09=09 * when it is completely stopped.
+=09=09 */
+=09=09vss->release =3D (command =3D=3D SNDRV_PCM_TRIGGER_STOP);
+
+=09=09/*
+=09=09 * The STOP command can be issued in an atomic context after
+=09=09 * the drain is complete. Therefore, in general, we cannot sleep
+=09=09 * here.
+=09=09 */
+=09=09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+=09=09=09=09=09=09GFP_ATOMIC);
+=09=09if (!msg)
+=09=09=09return -ENOMEM;
+
+=09=09return virtsnd_ctl_msg_send_async(snd, msg);
+=09}
+=09default: {
+=09=09return -EINVAL;
+=09}
+=09}
+}
+
+/**
+ * virtsnd_pcm_sync_stop() - Synchronous PCM substream stop.
+ * @substream: Kernel ALSA substream.
+ *
+ * The function can be called both from the upper level or from the driver
+ * itself.
+ *
+ * Context: Process context. Takes and releases the VirtIO substream spinl=
ock.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+=09struct virtio_snd *snd =3D vss->snd;
+=09struct virtio_snd_msg *msg;
+=09unsigned int js =3D msecs_to_jiffies(msg_timeout_ms);
+=09int rc;
+
+=09if (!vss->release)
+=09=09return 0;
+
+=09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
+=09=09=09=09=09GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
+=09if (rc)
+=09=09return rc;
+
+=09/*
+=09 * The spec states that upon receipt of the RELEASE command "the device
+=09 * MUST complete all pending I/O messages for the specified stream ID".
+=09 * Thus, we consider the absence of I/O messages in the queue as an
+=09 * indication that the substream has been released.
+=09 */
+=09rc =3D wait_event_interruptible_timeout(vss->msg_empty,
+=09=09=09=09=09      !virtsnd_pcm_msg_pending_num(vss),
+=09=09=09=09=09      js);
+=09if (rc <=3D 0) {
+=09=09dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
+=09=09=09 vss->sid);
+
+=09=09return !rc ? -ETIMEDOUT : rc;
+=09}
+
+=09vss->release =3D false;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_pointer() - Get the current hardware position for the PCM
+ *                         substream.
+ * @substream: Kernel ALSA substream.
+ *
+ * Context: Any context. Takes and releases the VirtIO substream spinlock.
+ * Return: Hardware position in frames inside [0 ... buffer_size) range.
+ */
+static snd_pcm_uframes_t
+virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
+{
+=09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
+=09snd_pcm_uframes_t hw_ptr =3D SNDRV_PCM_POS_XRUN;
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&vss->lock, flags);
+=09if (!vss->xfer_xrun)
+=09=09hw_ptr =3D bytes_to_frames(substream->runtime, vss->hw_ptr);
+=09spin_unlock_irqrestore(&vss->lock, flags);
+
+=09return hw_ptr;
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
+=09.sync_stop =3D virtsnd_pcm_sync_stop,
+=09.pointer =3D virtsnd_pcm_pointer,
+};
--=20
2.30.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

