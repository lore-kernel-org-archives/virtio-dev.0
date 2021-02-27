Return-Path: virtio-dev-return-8060-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A13A9862C9
	for <virtio-dev@lists.oasis-open.org>; Sat, 27 Feb 2021 09:00:57 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sat, 27 Feb 2021 09:59:56 +0100
Message-ID: <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume support
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 56 +++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.c     |  1 +
 sound/virtio/virtio_pcm_ops.c | 41 ++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 59455a562018..c7ae8801991d 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -323,6 +323,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
 =09kfree(snd->event_msgs);
 }
=20
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_freeze() - Suspend device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_freeze(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+
+=09virtsnd_ctl_msg_cancel_all(snd);
+
+=09vdev->config->del_vqs(vdev);
+=09vdev->config->reset(vdev);
+
+=09kfree(snd->event_msgs);
+
+=09/*
+=09 * If the virtsnd_restore() fails before re-allocating events, then we
+=09 * get a dangling pointer here.
+=09 */
+=09snd->event_msgs =3D NULL;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_restore() - Resume device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
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
+=09virtsnd_enable_event_vq(snd);
+
+=09return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct virtio_device_id id_table[] =3D {
 =09{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
 =09{ 0 },
@@ -335,6 +387,10 @@ static struct virtio_driver virtsnd_driver =3D {
 =09.validate =3D virtsnd_validate,
 =09.probe =3D virtsnd_probe,
 =09.remove =3D virtsnd_remove,
+#ifdef CONFIG_PM_SLEEP
+=09.freeze =3D virtsnd_freeze,
+=09.restore =3D virtsnd_restore,
+#endif
 };
=20
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 3605151860f2..4a4a6583b002 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_subst=
ream *vss,
 =09=09SNDRV_PCM_INFO_BATCH |
 =09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
 =09=09SNDRV_PCM_INFO_INTERLEAVED |
+=09=09SNDRV_PCM_INFO_RESUME |
 =09=09SNDRV_PCM_INFO_PAUSE;
=20
 =09if (!info->channels_min || info->channels_min > info->channels_max) {
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index d02d79bd94f3..03a7e2666cfb 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -167,7 +167,8 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substre=
am *substream,
 =09int vrate =3D -1;
 =09int rc;
=20
-=09if (virtsnd_pcm_msg_pending_num(vss)) {
+=09if (runtime->status->state !=3D SNDRV_PCM_STATE_SUSPENDED &&
+=09    virtsnd_pcm_msg_pending_num(vss)) {
 =09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 =09=09=09vss->sid);
 =09=09return -EBADFD;
@@ -231,6 +232,10 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substr=
eam *substream,
 =09if (rc)
 =09=09return rc;
=20
+=09/* If messages have already been allocated before, do nothing. */
+=09if (runtime->status->state =3D=3D SNDRV_PCM_STATE_SUSPENDED)
+=09=09return 0;
+
 =09/* Free previously allocated messages (if any). */
 =09virtsnd_pcm_msg_free(vss);
=20
@@ -267,20 +272,24 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substre=
am *substream)
  */
 static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 {
+=09struct snd_pcm_runtime *runtime =3D substream->runtime;
 =09struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
 =09struct virtio_device *vdev =3D vss->snd->vdev;
 =09struct virtio_snd_msg *msg;
=20
-=09if (virtsnd_pcm_msg_pending_num(vss)) {
-=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
-=09=09=09vss->sid);
-=09=09return -EBADFD;
+=09if (runtime->status->state !=3D SNDRV_PCM_STATE_SUSPENDED) {
+=09=09if (virtsnd_pcm_msg_pending_num(vss)) {
+=09=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+=09=09=09=09vss->sid);
+=09=09=09return -EBADFD;
+=09=09}
+
+=09=09vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09=09vss->hw_ptr =3D 0;
+=09=09vss->msg_last_enqueued =3D -1;
 =09}
=20
-=09vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
-=09vss->hw_ptr =3D 0;
 =09vss->xfer_xrun =3D false;
-=09vss->msg_last_enqueued =3D -1;
 =09vss->msg_count =3D 0;
=20
 =09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
@@ -309,6 +318,21 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substrea=
m *substream, int command)
 =09int rc;
=20
 =09switch (command) {
+=09case SNDRV_PCM_TRIGGER_RESUME: {
+=09=09/*
+=09=09 * We restart the substream by executing the standard command
+=09=09 * sequence.
+=09=09 */
+=09=09rc =3D virtsnd_pcm_hw_params(substream, NULL);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09rc =3D virtsnd_pcm_prepare(substream);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09fallthrough;
+=09}
 =09case SNDRV_PCM_TRIGGER_START:
 =09case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
 =09=09struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
@@ -335,6 +359,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream=
 *substream, int command)
=20
 =09=09return virtsnd_ctl_msg_send_sync(snd, msg);
 =09}
+=09case SNDRV_PCM_TRIGGER_SUSPEND:
 =09case SNDRV_PCM_TRIGGER_STOP:
 =09case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
 =09=09spin_lock_irqsave(&vss->lock, flags);
--=20
2.30.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

