Return-Path: virtio-dev-return-8091-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C246E986397
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Mar 2021 16:48:05 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Tue, 2 Mar 2021 17:47:09 +0100
Message-ID: <20210302164709.3142702-10-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
References: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v7 9/9] ALSA: virtio: introduce device suspend/resume support
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
 sound/virtio/virtio_pcm.h     |  3 ++
 sound/virtio/virtio_pcm_ops.c | 33 ++++++++++++++++-----
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 1c03fcc41c3b..ae9128063917 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -362,6 +362,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
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
+=09unsigned int i;
+
+=09virtsnd_disable_event_vq(snd);
+=09virtsnd_ctl_msg_cancel_all(snd);
+
+=09vdev->config->del_vqs(vdev);
+=09vdev->config->reset(vdev);
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i)
+=09=09cancel_work_sync(&snd->substreams[i].elapsed_period);
+
+=09kfree(snd->event_msgs);
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
@@ -374,6 +426,10 @@ static struct virtio_driver virtsnd_driver =3D {
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
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 1353fdc9bd69..062eb8e8f2cf 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -31,6 +31,8 @@ struct virtio_pcm_msg;
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the =
device
  *           side.
+ * @suspended: True if the substream is suspended and must be reconfigured=
 on
+ *             the device side at resume.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueu=
e.
@@ -52,6 +54,7 @@ struct virtio_pcm_substream {
 =09bool xfer_enabled;
 =09bool xfer_xrun;
 =09bool stopped;
+=09bool suspended;
 =09struct virtio_pcm_msg **msgs;
 =09unsigned int nmsgs;
 =09int msg_last_enqueued;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 0682a2df6c8c..f8bfb87624be 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -115,6 +115,7 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *s=
ubstream)
 =09=09=09=09      SNDRV_PCM_HW_PARAM_PERIODS);
=20
 =09vss->stopped =3D !!virtsnd_pcm_msg_pending_num(vss);
+=09vss->suspended =3D false;
=20
 =09/*
 =09 * If the substream has already been used, then the I/O queue may be in
@@ -272,16 +273,31 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substre=
am *substream)
 =09struct virtio_device *vdev =3D vss->snd->vdev;
 =09struct virtio_snd_msg *msg;
=20
-=09if (virtsnd_pcm_msg_pending_num(vss)) {
-=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
-=09=09=09vss->sid);
-=09=09return -EBADFD;
+=09if (!vss->suspended) {
+=09=09if (virtsnd_pcm_msg_pending_num(vss)) {
+=09=09=09dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+=09=09=09=09vss->sid);
+=09=09=09return -EBADFD;
+=09=09}
+
+=09=09vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09=09vss->hw_ptr =3D 0;
+=09=09vss->msg_last_enqueued =3D -1;
+=09} else {
+=09=09struct snd_pcm_runtime *runtime =3D substream->runtime;
+=09=09unsigned int buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
+=09=09unsigned int period_bytes =3D snd_pcm_lib_period_bytes(substream);
+=09=09int rc;
+
+=09=09rc =3D virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
+=09=09=09=09=09=09runtime->channels,
+=09=09=09=09=09=09runtime->format, runtime->rate);
+=09=09if (rc)
+=09=09=09return rc;
 =09}
=20
-=09vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
-=09vss->hw_ptr =3D 0;
 =09vss->xfer_xrun =3D false;
-=09vss->msg_last_enqueued =3D -1;
+=09vss->suspended =3D false;
 =09vss->msg_count =3D 0;
=20
 =09msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
@@ -336,6 +352,9 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream=
 *substream, int command)
 =09=09}
=20
 =09=09return virtsnd_ctl_msg_send_sync(snd, msg);
+=09case SNDRV_PCM_TRIGGER_SUSPEND:
+=09=09vss->suspended =3D true;
+=09=09fallthrough;
 =09case SNDRV_PCM_TRIGGER_STOP:
 =09=09vss->stopped =3D true;
 =09=09fallthrough;
--=20
2.30.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

