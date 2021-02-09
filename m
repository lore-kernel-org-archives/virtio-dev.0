Return-Path: virtio-dev-return-7992-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09A58986529
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Feb 2021 12:41:17 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Tue, 9 Feb 2021 13:40:10 +0100
Message-ID: <20210209124011.1224628-10-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
References: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 9/9] ALSA: virtio: introduce device suspend/resume support
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 57 +++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.c     |  1 +
 sound/virtio/virtio_pcm_ops.c | 44 ++++++++++++++++++++-------
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 787a4dec1da8..1f0a0fa7bbc0 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -373,6 +373,59 @@ static void virtsnd_config_changed(struct virtio_devic=
e *vdev)
 =09=09=09 "sound device configuration was changed\n");
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
+=09/* Stop all the virtqueues. */
+=09vdev->config->reset(vdev);
+=09vdev->config->del_vqs(vdev);
+
+=09virtsnd_ctl_msg_cancel_all(snd);
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
@@ -386,6 +439,10 @@ static struct virtio_driver virtsnd_driver =3D {
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
index 1d98de878385..401d4c975d2b 100644
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
index c2224f5461c4..207f4877a5ec 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -220,6 +220,10 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substr=
eam *substream,
 =09if (rc)
 =09=09return rc;
=20
+=09/* If messages have already been allocated before, do nothing. */
+=09if (runtime->status->state =3D=3D SNDRV_PCM_STATE_SUSPENDED)
+=09=09return 0;
+
 =09return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
 }
=20
@@ -260,19 +264,21 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substre=
am *substream)
 =09}
=20
 =09spin_lock_irqsave(&vss->lock, flags);
-=09/*
-=09 * Since I/O messages are asynchronous, they can be completed
-=09 * when the runtime structure no longer exists. Since each
-=09 * completion implies incrementing the hw_ptr, we cache all the
-=09 * current values needed to compute the new hw_ptr value.
-=09 */
-=09vss->frame_bytes =3D runtime->frame_bits >> 3;
-=09vss->period_size =3D runtime->period_size;
-=09vss->buffer_size =3D runtime->buffer_size;
+=09if (runtime->status->state !=3D SNDRV_PCM_STATE_SUSPENDED) {
+=09=09/*
+=09=09 * Since I/O messages are asynchronous, they can be completed
+=09=09 * when the runtime structure no longer exists. Since each
+=09=09 * completion implies incrementing the hw_ptr, we cache all the
+=09=09 * current values needed to compute the new hw_ptr value.
+=09=09 */
+=09=09vss->frame_bytes =3D runtime->frame_bits >> 3;
+=09=09vss->period_size =3D runtime->period_size;
+=09=09vss->buffer_size =3D runtime->buffer_size;
=20
-=09vss->hw_ptr =3D 0;
+=09=09vss->hw_ptr =3D 0;
+=09=09vss->msg_last_enqueued =3D -1;
+=09}
 =09vss->xfer_xrun =3D false;
-=09vss->msg_last_enqueued =3D -1;
 =09vss->msg_count =3D 0;
 =09spin_unlock_irqrestore(&vss->lock, flags);
=20
@@ -302,6 +308,21 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substrea=
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
@@ -328,6 +349,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream=
 *substream, int command)
=20
 =09=09return virtsnd_ctl_msg_send_sync(snd, msg);
 =09}
+=09case SNDRV_PCM_TRIGGER_SUSPEND:
 =09case SNDRV_PCM_TRIGGER_STOP:
 =09case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
 =09=09spin_lock_irqsave(&vss->lock, flags);
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

