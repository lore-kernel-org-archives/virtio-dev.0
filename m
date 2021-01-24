Return-Path: virtio-dev-return-7952-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CE9C985B9F
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:55:14 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sun, 24 Jan 2021 17:54:08 +0100
Message-ID: <20210124165408.1122868-10-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 9/9] ALSA: virtio: introduce device suspend/resume support
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 54 ++++++++++++++++++++
 sound/virtio/virtio_pcm.c     | 40 +++++++++++++++
 sound/virtio/virtio_pcm.h     |  6 +++
 sound/virtio/virtio_pcm_ops.c | 93 ++++++++++++++++++++---------------
 4 files changed, 154 insertions(+), 39 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index fabf91fc1c9c..90dadf18d9b0 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -491,6 +491,56 @@ static void virtsnd_config_changed(struct virtio_devic=
e *vdev)
 =09=09=09 "sound device configuration was changed\n");
 }
=20
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_freeze() - Suspend device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_freeze(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+
+=09virtsnd_disable_vqs(snd);
+
+=09vdev->config->reset(vdev);
+=09vdev->config->del_vqs(vdev);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_restore() - Resume device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_restore(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+=09int rc;
+
+=09rc =3D virtsnd_find_vqs(snd);
+=09if (rc)
+=09=09return rc;
+
+=09virtio_device_ready(vdev);
+
+=09if (snd->nsubstreams) {
+=09=09rc =3D virtsnd_pcm_restore(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09virtsnd_enable_event_vq(snd);
+
+=09return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct virtio_device_id id_table[] =3D {
 =09{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
 =09{ 0 },
@@ -504,6 +554,10 @@ static struct virtio_driver virtsnd_driver =3D {
 =09.probe =3D virtsnd_probe,
 =09.remove =3D virtsnd_remove,
 =09.config_changed =3D virtsnd_config_changed,
+#ifdef CONFIG_PM_SLEEP
+=09.freeze =3D virtsnd_freeze,
+=09.restore =3D virtsnd_restore,
+#endif
 };
=20
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 6a1ca6b2c3ca..68d9c6dee13a 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -122,6 +122,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_subst=
ream *substream,
 =09=09SNDRV_PCM_INFO_BATCH |
 =09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
 =09=09SNDRV_PCM_INFO_INTERLEAVED |
+=09=09SNDRV_PCM_INFO_RESUME |
 =09=09SNDRV_PCM_INFO_PAUSE;
=20
 =09if (!info->channels_min || info->channels_min > info->channels_max) {
@@ -511,6 +512,45 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
 =09return 0;
 }
=20
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_pcm_restore() - Resume PCM substreams.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_restore(struct virtio_snd *snd)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *substream =3D &snd->substreams[i];
+=09=09struct snd_pcm_substream *ksubstream =3D substream->substream;
+=09=09int rc;
+
+=09=09if (!substream->suspended)
+=09=09=09continue;
+
+=09=09/*
+=09=09 * We restart the substream by executing the standard command
+=09=09 * sequence. The START command will be sent from a subsequent
+=09=09 * call to the trigger() callback function after the device has
+=09=09 * been resumed.
+=09=09 */
+=09=09rc =3D ksubstream->ops->hw_params(ksubstream, NULL);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09rc =3D ksubstream->ops->prepare(ksubstream);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 /**
  * virtsnd_pcm_event() - Handle the PCM device event notification.
  * @snd: VirtIO sound device.
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index a326b921b947..23d0fdd57225 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -41,6 +41,7 @@ struct virtio_pcm_msg;
  * @hw_ptr: Substream hardware pointer value in frames [0 ... buffer_size)=
.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
+ * @suspended: Kernel ALSA substream is suspended.
  * @msgs: I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueu=
e.
  * @msg_count: Number of pending I/O messages in the virtqueue.
@@ -60,6 +61,7 @@ struct virtio_pcm_substream {
 =09atomic_t hw_ptr;
 =09atomic_t xfer_enabled;
 =09atomic_t xfer_xrun;
+=09bool suspended;
 =09struct virtio_pcm_msg *msgs;
 =09int msg_last_enqueued;
 =09atomic_t msg_count;
@@ -102,6 +104,10 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
=20
 int virtsnd_pcm_build_devs(struct virtio_snd *snd);
=20
+#ifdef CONFIG_PM_SLEEP
+int virtsnd_pcm_restore(struct virtio_snd *snd);
+#endif /* CONFIG_PM_SLEEP */
+
 void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent);
=20
 void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 19882777fcd6..0b3c66802325 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -187,6 +187,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *s=
ubstream)
 =09if (!ss)
 =09=09return -EBADFD;
=20
+=09ss->suspended =3D false;
+
 =09substream->runtime->hw =3D ss->hw;
 =09substream->private_data =3D ss;
=20
@@ -241,18 +243,20 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_subst=
ream *substream,
 =09int vrate =3D -1;
 =09int rc;
=20
-=09/*
-=09 * If we got here after ops->trigger() was called, the queue may
-=09 * still contain messages. In this case, we need to release the
-=09 * substream first.
-=09 */
-=09if (atomic_read(&ss->msg_count)) {
-=09=09rc =3D virtsnd_pcm_release(ss);
-=09=09if (rc) {
-=09=09=09dev_err(&vdev->dev,
-=09=09=09=09"SID %u: invalid I/O queue state\n",
-=09=09=09=09ss->sid);
-=09=09=09return rc;
+=09if (!ss->suspended) {
+=09=09/*
+=09=09 * If we got here after ops->trigger() was called, the queue may
+=09=09 * still contain messages. In this case, we need to release the
+=09=09 * substream first.
+=09=09 */
+=09=09if (atomic_read(&ss->msg_count)) {
+=09=09=09rc =3D virtsnd_pcm_release(ss);
+=09=09=09if (rc) {
+=09=09=09=09dev_err(&vdev->dev,
+=09=09=09=09=09"SID %u: invalid I/O queue state\n",
+=09=09=09=09=09ss->sid);
+=09=09=09=09return rc;
+=09=09=09}
 =09=09}
 =09}
=20
@@ -383,37 +387,41 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substre=
am *substream)
 static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 {
 =09struct virtio_pcm_substream *ss =3D snd_pcm_substream_chip(substream);
-=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(ss);
 =09struct virtio_snd_msg *msg;
 =09unsigned long flags;
 =09int rc;
=20
-=09/*
-=09 * If we got here after ops->trigger() was called, the queue may
-=09 * still contain messages. In this case, we need to reset the
-=09 * substream first.
-=09 */
-=09if (atomic_read(&ss->msg_count)) {
-=09=09rc =3D virtsnd_pcm_hw_params(substream, NULL);
-=09=09if (rc)
-=09=09=09return rc;
-=09}
-
-=09spin_lock_irqsave(&queue->lock, flags);
-=09ss->msg_last_enqueued =3D -1;
-=09spin_unlock_irqrestore(&queue->lock, flags);
+=09if (!ss->suspended) {
+=09=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(ss);
+
+=09=09/*
+=09=09 * If we got here after ops->trigger() was called, the queue may
+=09=09 * still contain messages. In this case, we need to reset the
+=09=09 * substream first.
+=09=09 */
+=09=09if (atomic_read(&ss->msg_count)) {
+=09=09=09rc =3D virtsnd_pcm_hw_params(substream, NULL);
+=09=09=09if (rc)
+=09=09=09=09return rc;
+=09=09}
=20
-=09/*
-=09 * Since I/O messages are asynchronous, they can be completed
-=09 * when the runtime structure no longer exists. Since each
-=09 * completion implies incrementing the hw_ptr, we cache all the
-=09 * current values needed to compute the new hw_ptr value.
-=09 */
-=09ss->frame_bytes =3D substream->runtime->frame_bits >> 3;
-=09ss->period_size =3D substream->runtime->period_size;
-=09ss->buffer_size =3D substream->runtime->buffer_size;
+=09=09spin_lock_irqsave(&queue->lock, flags);
+=09=09ss->msg_last_enqueued =3D -1;
+=09=09spin_unlock_irqrestore(&queue->lock, flags);
+
+=09=09/*
+=09=09 * Since I/O messages are asynchronous, they can be completed
+=09=09 * when the runtime structure no longer exists. Since each
+=09=09 * completion implies incrementing the hw_ptr, we cache all the
+=09=09 * current values needed to compute the new hw_ptr value.
+=09=09 */
+=09=09ss->frame_bytes =3D substream->runtime->frame_bits >> 3;
+=09=09ss->period_size =3D substream->runtime->period_size;
+=09=09ss->buffer_size =3D substream->runtime->buffer_size;
+
+=09=09atomic_set(&ss->hw_ptr, 0);
+=09}
=20
-=09atomic_set(&ss->hw_ptr, 0);
 =09atomic_set(&ss->xfer_xrun, 0);
 =09atomic_set(&ss->msg_count, 0);
=20
@@ -446,9 +454,12 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substrea=
m *substream, int command)
=20
 =09switch (command) {
 =09case SNDRV_PCM_TRIGGER_START:
-=09case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
+=09case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+=09case SNDRV_PCM_TRIGGER_RESUME: {
 =09=09int rc;
=20
+=09=09ss->suspended =3D false;
+
 =09=09spin_lock(&queue->lock);
 =09=09rc =3D virtsnd_pcm_msg_send(ss);
 =09=09spin_unlock(&queue->lock);
@@ -465,9 +476,13 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substrea=
m *substream, int command)
 =09=09return virtsnd_ctl_msg_send(snd, msg);
 =09}
 =09case SNDRV_PCM_TRIGGER_STOP:
-=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
+=09case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+=09case SNDRV_PCM_TRIGGER_SUSPEND: {
 =09=09atomic_set(&ss->xfer_enabled, 0);
=20
+=09=09if (command =3D=3D SNDRV_PCM_TRIGGER_SUSPEND)
+=09=09=09ss->suspended =3D true;
+
 =09=09msg =3D virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
 =09=09=09=09=09=09GFP_ATOMIC);
 =09=09if (IS_ERR(msg))
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

