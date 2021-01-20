Return-Path: virtio-dev-return-7925-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4801298604B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 00:37:14 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Wed, 20 Jan 2021 01:36:31 +0100
Message-ID: <20210120003638.3339987-4-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 3/7] ALSA: virtio: add virtio sound driver
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce skeleton of the virtio sound driver. The driver implements
the virtio sound device specification, which has become part of the
virtio standard.

Initial initialization of the device, virtqueues and creation of an
empty ALSA sound device. Also, handling DEVICE_NEEDS_RESET device
status.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 MAINTAINERS                   |   2 +
 sound/Kconfig                 |   2 +
 sound/Makefile                |   3 +-
 sound/virtio/Kconfig          |  10 +
 sound/virtio/Makefile         |   9 +
 sound/virtio/virtio_card.c    | 473 ++++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h    |  92 ++++++
 sound/virtio/virtio_ctl_msg.c | 293 +++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h | 122 ++++++++
 sound/virtio/virtio_pcm.c     | 536 ++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h     |  89 ++++++
 11 files changed, 1630 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dfd59eafe82..8a0e9f04402f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18939,8 +18939,10 @@ F:=09include/uapi/linux/virtio_mem.h
 VIRTIO SOUND DRIVER
 M:=09Anton Yakovlev <anton.yakovlev@opensynergy.com>
 L:=09virtualization@lists.linux-foundation.org
+L:=09alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:=09Maintained
 F:=09include/uapi/linux/virtio_snd.h
+F:=09sound/virtio/*
=20
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:=09Hans de Goede <hdegoede@redhat.com>
diff --git a/sound/Kconfig b/sound/Kconfig
index 36785410fbe1..e56d96d2b11c 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -99,6 +99,8 @@ source "sound/synth/Kconfig"
=20
 source "sound/xen/Kconfig"
=20
+source "sound/virtio/Kconfig"
+
 endif # SND
=20
 endif # !UML
diff --git a/sound/Makefile b/sound/Makefile
index 797ecdcd35e2..04ef04b1168f 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_SOUND) +=3D soundcore.o
 obj-$(CONFIG_DMASOUND) +=3D oss/dmasound/
 obj-$(CONFIG_SND) +=3D core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ =
usb/ \
-=09firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/ x86/ xen/
+=09firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/ x86/ xen/ =
\
+=09virtio/
 obj-$(CONFIG_SND_AOA) +=3D aoa/
=20
 # This one must be compilable even if sound is configured out
diff --git a/sound/virtio/Kconfig b/sound/virtio/Kconfig
new file mode 100644
index 000000000000..094cba24ee5b
--- /dev/null
+++ b/sound/virtio/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Sound card driver for virtio
+
+config SND_VIRTIO
+=09tristate "Virtio sound driver"
+=09depends on VIRTIO
+=09select SND_PCM
+=09select SND_JACK
+=09help
+          This is the virtual sound driver for virtio. Say Y or M.
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
new file mode 100644
index 000000000000..69162a545a41
--- /dev/null
+++ b/sound/virtio/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
+
+virtio_snd-objs :=3D \
+=09virtio_card.o \
+=09virtio_ctl_msg.o \
+=09virtio_pcm.o
+
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
new file mode 100644
index 000000000000..293d497f24e7
--- /dev/null
+++ b/sound/virtio/virtio_card.c
@@ -0,0 +1,473 @@
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
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+#include <sound/initval.h>
+#include <uapi/linux/virtio_ids.h>
+
+#include "virtio_card.h"
+
+int msg_timeout_ms =3D MSEC_PER_SEC;
+module_param(msg_timeout_ms, int, 0644);
+MODULE_PARM_DESC(msg_timeout_ms, "Message completion timeout in millisecon=
ds");
+
+static int virtsnd_probe(struct virtio_device *vdev);
+static void virtsnd_remove(struct virtio_device *vdev);
+
+/**
+ * virtsnd_event_send() - Add an event to the event queue.
+ * @vqueue: Underlying event virtqueue.
+ * @event: Event.
+ * @notify: Indicates whether or not to send a notification to the device.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_event_send(struct virtqueue *vqueue,
+=09=09=09      struct virtio_snd_event *event, bool notify,
+=09=09=09      gfp_t gfp)
+{
+=09struct scatterlist sg;
+=09struct scatterlist *psgs[1] =3D { &sg };
+=09int rc;
+
+=09/* reset event content */
+=09memset(event, 0, sizeof(*event));
+
+=09sg_init_one(&sg, event, sizeof(*event));
+
+=09rc =3D virtqueue_add_sgs(vqueue, psgs, 0, 1, event, gfp);
+=09if (rc)
+=09=09return rc;
+
+=09if (notify)
+=09=09if (virtqueue_kick_prepare(vqueue))
+=09=09=09if (!virtqueue_notify(vqueue))
+=09=09=09=09return -EIO;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_event_notify_cb() - Dispatch all reported events from the event=
 queue.
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from th=
e
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
+{
+=09struct virtio_snd *snd =3D vqueue->vdev->priv;
+=09struct virtio_snd_queue *queue =3D virtsnd_event_queue(snd);
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09while (queue->vqueue) {
+=09=09virtqueue_disable_cb(queue->vqueue);
+
+=09=09for (;;) {
+=09=09=09struct virtio_snd_event *event;
+=09=09=09u32 length;
+
+=09=09=09event =3D virtqueue_get_buf(queue->vqueue, &length);
+=09=09=09if (!event)
+=09=09=09=09break;
+
+=09=09=09switch (le32_to_cpu(event->hdr.code)) {
+=09=09=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
+=09=09=09case VIRTIO_SND_EVT_PCM_XRUN: {
+=09=09=09=09virtsnd_pcm_event(snd, event);
+=09=09=09=09break;
+=09=09=09}
+=09=09=09default: {
+=09=09=09=09break;
+=09=09=09}
+=09=09=09}
+
+=09=09=09virtsnd_event_send(queue->vqueue, event, true,
+=09=09=09=09=09   GFP_ATOMIC);
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
+ * virtsnd_find_vqs() - Enumerate and initialize all virtqueues.
+ * @snd: VirtIO sound device.
+ *
+ * After calling this function, interrupts are allowed only for the contro=
l
+ * queue, all other queues are disabled.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_find_vqs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] =3D { 0 };
+=09const char *names[VIRTIO_SND_VQ_MAX] =3D {
+=09=09[VIRTIO_SND_VQ_CONTROL] =3D "virtsnd-ctl",
+=09=09[VIRTIO_SND_VQ_EVENT] =3D "virtsnd-event",
+=09=09[VIRTIO_SND_VQ_TX] =3D "virtsnd-tx",
+=09=09[VIRTIO_SND_VQ_RX] =3D "virtsnd-rx"
+=09};
+=09struct virtqueue *vqs[VIRTIO_SND_VQ_MAX] =3D { 0 };
+=09unsigned int i;
+=09unsigned int n =3D 0;
+=09int rc;
+
+=09callbacks[VIRTIO_SND_VQ_CONTROL] =3D virtsnd_ctl_notify_cb;
+=09callbacks[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb;
+
+=09rc =3D virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
+=09=09=09     NULL);
+=09if (rc) {
+=09=09dev_err(&vdev->dev, "failed to initialize virtqueues\n");
+=09=09return rc;
+=09}
+
+=09for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
+=09=09/*
+=09=09 * By default, disable callbacks for all queues except the
+=09=09 * control queue, since the device must be fully initialized
+=09=09 * first.
+=09=09 */
+=09=09if (i !=3D VIRTIO_SND_VQ_CONTROL)
+=09=09=09virtqueue_disable_cb(vqs[i]);
+
+=09=09snd->queues[i].vqueue =3D vqs[i];
+=09}
+
+=09/* Allocate events and populate the event queue */
+=09n =3D virtqueue_get_vring_size(vqs[VIRTIO_SND_VQ_EVENT]);
+
+=09snd->event_msgs =3D devm_kcalloc(&vdev->dev, n, sizeof(*snd->event_msgs=
),
+=09=09=09=09       GFP_KERNEL);
+=09if (!snd->event_msgs)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < n; ++i) {
+=09=09rc =3D virtsnd_event_send(vqs[VIRTIO_SND_VQ_EVENT],
+=09=09=09=09=09&snd->event_msgs[i], false, GFP_KERNEL);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_enable_vqs() - Enable the event, tx and rx virtqueues.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_enable_vqs(struct virtio_snd *snd)
+{
+=09struct virtqueue *vqueue;
+
+=09vqueue =3D snd->queues[VIRTIO_SND_VQ_EVENT].vqueue;
+=09if (!virtqueue_enable_cb(vqueue))
+=09=09virtsnd_event_notify_cb(vqueue);
+}
+
+/**
+ * virtsnd_disable_vqs() - Disable all virtqueues.
+ * @snd: VirtIO sound device.
+ *
+ * Also free all allocated events and control messages.
+ *
+ * Context: Any context.
+ */
+static void virtsnd_disable_vqs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09unsigned int i;
+=09unsigned long flags;
+
+=09for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
+=09=09struct virtio_snd_queue *queue =3D &snd->queues[i];
+
+=09=09spin_lock_irqsave(&queue->lock, flags);
+=09=09/* Prohibit the use of the queue */
+=09=09if (queue->vqueue)
+=09=09=09virtqueue_disable_cb(queue->vqueue);
+=09=09queue->vqueue =3D NULL;
+=09=09/* Cancel all pending requests for the control queue */
+=09=09if (i =3D=3D VIRTIO_SND_VQ_CONTROL) {
+=09=09=09struct virtio_snd_msg *msg;
+=09=09=09struct virtio_snd_msg *next;
+
+=09=09=09list_for_each_entry_safe(msg, next, &snd->ctl_msgs,
+=09=09=09=09=09=09 list)
+=09=09=09=09virtsnd_ctl_msg_complete(snd, msg);
+=09=09}
+=09=09spin_unlock_irqrestore(&queue->lock, flags);
+=09}
+
+=09if (snd->event_msgs)
+=09=09devm_kfree(&vdev->dev, snd->event_msgs);
+
+=09snd->event_msgs =3D NULL;
+}
+
+/**
+ * virtsnd_reset_fn() - Kernel worker's function to reset the device.
+ * @work: Reset device work.
+ *
+ * Context: Process context.
+ */
+static void virtsnd_reset_fn(struct work_struct *work)
+{
+=09struct virtio_snd *snd =3D
+=09=09container_of(work, struct virtio_snd, reset_work);
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct device *dev =3D &vdev->dev;
+=09int rc;
+
+=09dev_info(dev, "sound device needs reset\n");
+
+=09/*
+=09 * It seems that the only way to properly reset the device is to remove
+=09 * and re-create the ALSA sound card device.
+=09 */
+=09virtsnd_remove(vdev);
+
+=09rc =3D virtsnd_probe(vdev);
+=09if (rc)
+=09=09dev_err(dev, "re-probe() failed: %d\n", rc);
+}
+
+/**
+ * virtsnd_build_devs() - Read configuration and build ALSA devices.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_build_devs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09int rc;
+
+=09rc =3D snd_card_new(&vdev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+=09=09=09  THIS_MODULE, 0, &snd->card);
+=09if (rc < 0)
+=09=09return rc;
+
+=09snd->card->private_data =3D snd;
+
+=09strscpy(snd->card->id, "viosnd", sizeof(snd->card->id));
+=09strscpy(snd->card->driver, "virtio_snd", sizeof(snd->card->driver));
+=09strscpy(snd->card->shortname, "VIOSND", sizeof(snd->card->shortname));
+=09strscpy(snd->card->longname, "VirtIO Sound Card",
+=09=09sizeof(snd->card->longname));
+
+=09rc =3D virtsnd_pcm_parse_cfg(snd);
+=09if (rc)
+=09=09return rc;
+
+=09if (snd->nsubstreams) {
+=09=09rc =3D virtsnd_pcm_build_devs(snd);
+=09=09if (rc)
+=09=09=09return rc;
+=09}
+
+=09return snd_card_register(snd->card);
+}
+
+/**
+ * virtsnd_validate() - Validate if the device can be started.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL on failure.
+ */
+static int virtsnd_validate(struct virtio_device *vdev)
+{
+=09if (!vdev->config->get) {
+=09=09dev_err(&vdev->dev, "configuration access disabled\n");
+=09=09return -EINVAL;
+=09}
+
+=09if (!msg_timeout_ms) {
+=09=09dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
+=09=09return -EINVAL;
+=09}
+
+=09if (virtsnd_pcm_validate(vdev))
+=09=09return -EINVAL;
+
+=09return 0;
+}
+
+/**
+ * virtsnd_probe() - Create and initialize the device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_probe(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd;
+=09unsigned int i;
+=09int rc;
+
+=09snd =3D devm_kzalloc(&vdev->dev, sizeof(*snd), GFP_KERNEL);
+=09if (!snd)
+=09=09return -ENOMEM;
+
+=09snd->vdev =3D vdev;
+=09INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
+=09INIT_LIST_HEAD(&snd->ctl_msgs);
+=09INIT_LIST_HEAD(&snd->pcm_list);
+
+=09vdev->priv =3D snd;
+
+=09for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
+=09=09spin_lock_init(&snd->queues[i].lock);
+
+=09rc =3D virtsnd_find_vqs(snd);
+=09if (rc)
+=09=09goto on_failure;
+
+=09virtio_device_ready(vdev);
+
+=09rc =3D virtsnd_build_devs(snd);
+=09if (rc)
+=09=09goto on_failure;
+
+=09virtsnd_enable_vqs(snd);
+
+on_failure:
+=09if (rc)
+=09=09virtsnd_remove(vdev);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_remove() - Remove VirtIO and ALSA devices.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ */
+static void virtsnd_remove(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+=09struct virtio_pcm *pcm;
+=09struct virtio_pcm *pcm_next;
+
+=09if (!snd)
+=09=09return;
+
+=09virtsnd_disable_vqs(snd);
+
+=09if (snd->card)
+=09=09snd_card_free(snd->card);
+
+=09vdev->config->reset(vdev);
+=09vdev->config->del_vqs(vdev);
+
+=09list_for_each_entry_safe(pcm, pcm_next, &snd->pcm_list, list) {
+=09=09unsigned int i;
+
+=09=09list_del(&pcm->list);
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+
+=09=09=09if (stream->substreams)
+=09=09=09=09devm_kfree(&vdev->dev, stream->substreams);
+=09=09}
+
+=09=09devm_kfree(&vdev->dev, pcm);
+=09}
+
+=09if (snd->substreams)
+=09=09devm_kfree(&vdev->dev, snd->substreams);
+
+=09devm_kfree(&vdev->dev, snd);
+
+=09vdev->priv =3D NULL;
+}
+
+/**
+ * virtsnd_config_changed() - Handle configuration change notification.
+ * @vdev: VirtIO parent device.
+ *
+ * This callback function is called upon a configuration change interrupt
+ * request from the device. Currently only used to handle NEEDS_RESET devi=
ce
+ * status.
+ *
+ * Context: Interrupt context.
+ */
+static void virtsnd_config_changed(struct virtio_device *vdev)
+{
+=09struct virtio_snd *snd =3D vdev->priv;
+=09unsigned int status =3D vdev->config->get_status(vdev);
+
+=09if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
+=09=09schedule_work(&snd->reset_work);
+=09else
+=09=09dev_warn(&vdev->dev,
+=09=09=09 "sound device configuration was changed\n");
+}
+
+static const struct virtio_device_id id_table[] =3D {
+=09{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
+=09{ 0 },
+};
+
+static struct virtio_driver virtsnd_driver =3D {
+=09.driver.name =3D KBUILD_MODNAME,
+=09.driver.owner =3D THIS_MODULE,
+=09.id_table =3D id_table,
+=09.validate =3D virtsnd_validate,
+=09.probe =3D virtsnd_probe,
+=09.remove =3D virtsnd_remove,
+=09.config_changed =3D virtsnd_config_changed,
+};
+
+static int __init init(void)
+{
+=09return register_virtio_driver(&virtsnd_driver);
+}
+module_init(init);
+
+static void __exit fini(void)
+{
+=09unregister_virtio_driver(&virtsnd_driver);
+}
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio sound card driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
new file mode 100644
index 000000000000..be6651a6aaf8
--- /dev/null
+++ b/sound/virtio/virtio_card.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
+#ifndef VIRTIO_SND_CARD_H
+#define VIRTIO_SND_CARD_H
+
+#include <linux/virtio.h>
+#include <sound/core.h>
+#include <uapi/linux/virtio_snd.h>
+
+#include "virtio_ctl_msg.h"
+#include "virtio_pcm.h"
+
+struct virtio_pcm_substream;
+
+/**
+ * struct virtio_snd_queue - Virtqueue wrapper structure.
+ * @lock: Used to synchronize access to a virtqueue.
+ * @vqueue: Underlying virtqueue.
+ */
+struct virtio_snd_queue {
+=09spinlock_t lock;
+=09struct virtqueue *vqueue;
+};
+
+/**
+ * struct virtio_snd - VirtIO sound card device.
+ * @vdev: Underlying virtio device.
+ * @queues: Virtqueue wrappers.
+ * @reset_work: Reset device work.
+ * @card: ALSA sound card.
+ * @ctl_msgs: Pending control request list.
+ * @event_msgs: Device events.
+ * @pcm_list: VirtIO PCM device list.
+ * @substreams: VirtIO PCM substreams.
+ * @nsubstreams: Number of PCM substreams.
+ */
+struct virtio_snd {
+=09struct virtio_device *vdev;
+=09struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
+=09struct work_struct reset_work;
+=09struct snd_card *card;
+=09struct list_head ctl_msgs;
+=09struct virtio_snd_event *event_msgs;
+=09struct list_head pcm_list;
+=09struct virtio_pcm_substream *substreams;
+=09unsigned int nsubstreams;
+};
+
+/* Message completion timeout in milliseconds (module parameter). */
+extern int msg_timeout_ms;
+
+static inline struct virtio_snd_queue *
+virtsnd_control_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_CONTROL];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_event_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_EVENT];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_tx_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_TX];
+}
+
+static inline struct virtio_snd_queue *
+virtsnd_rx_queue(struct virtio_snd *snd)
+{
+=09return &snd->queues[VIRTIO_SND_VQ_RX];
+}
+
+#endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
new file mode 100644
index 000000000000..c1701756bc32
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -0,0 +1,293 @@
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
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+#include "virtio_ctl_msg.h"
+
+/**
+ * virtsnd_ctl_msg_alloc_ext() - Allocate and initialize a control message=
.
+ * @vdev: VirtIO parent device.
+ * @request_size: Size of request header (pointed to by sg_request field).
+ * @response_size: Size of response header (pointed to by sg_response fiel=
d).
+ * @sgs: Additional data to attach to the message (may be NULL).
+ * @out_sgs: Number of scattergather elements to attach to the request hea=
der.
+ * @in_sgs: Number of scattergather elements to attach to the response hea=
der.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, ERR_PTR(-errno) on failure.
+ */
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vde=
v,
+=09=09=09=09=09=09 size_t request_size,
+=09=09=09=09=09=09 size_t response_size,
+=09=09=09=09=09=09 struct scatterlist *sgs,
+=09=09=09=09=09=09 unsigned int out_sgs,
+=09=09=09=09=09=09 unsigned int in_sgs, gfp_t gfp)
+{
+=09struct virtio_snd_msg *msg;
+=09size_t msg_size =3D
+=09=09sizeof(*msg) + (1 + out_sgs + 1 + in_sgs) * sizeof(*msg->sgs);
+=09unsigned int i;
+
+=09msg =3D devm_kzalloc(&vdev->dev, msg_size + request_size + response_siz=
e,
+=09=09=09   gfp);
+=09if (!msg)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09sg_init_one(&msg->sg_request, (u8 *)msg + msg_size, request_size);
+=09sg_init_one(&msg->sg_response, (u8 *)msg + msg_size + request_size,
+=09=09    response_size);
+
+=09INIT_LIST_HEAD(&msg->list);
+=09init_completion(&msg->notify);
+=09atomic_set(&msg->ref_count, 1);
+
+=09msg->sgs[msg->out_sgs++] =3D &msg->sg_request;
+=09if (sgs)
+=09=09for (i =3D 0; i < out_sgs; ++i)
+=09=09=09msg->sgs[msg->out_sgs++] =3D &sgs[i];
+
+=09msg->sgs[msg->out_sgs + msg->in_sgs++] =3D &msg->sg_response;
+=09if (sgs)
+=09=09for (i =3D out_sgs; i < out_sgs + in_sgs; ++i)
+=09=09=09msg->sgs[msg->out_sgs + msg->in_sgs++] =3D &sgs[i];
+
+=09return msg;
+}
+
+/**
+ * virtsnd_ctl_msg_send() - Send an (asynchronous) control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * If a message is failed to be enqueued, it will be deleted. If message c=
ontent
+ * is still needed, the caller must additionally to virtsnd_ctl_msg_ref/un=
ref()
+ * it.
+ *
+ * Context: Any context. Takes and releases the control queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *ms=
g)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_queue *queue =3D virtsnd_control_queue(snd);
+=09struct virtio_snd_hdr *response =3D sg_virt(&msg->sg_response);
+=09bool notify =3D false;
+=09unsigned long flags;
+=09int rc =3D -EIO;
+
+=09/* Set the default status in case the message was not sent or was
+=09 * canceled.
+=09 */
+=09response->code =3D cpu_to_virtio32(vdev, VIRTIO_SND_S_IO_ERR);
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09if (queue->vqueue) {
+=09=09rc =3D virtqueue_add_sgs(queue->vqueue, msg->sgs, msg->out_sgs,
+=09=09=09=09       msg->in_sgs, msg, GFP_ATOMIC);
+=09=09if (!rc) {
+=09=09=09notify =3D virtqueue_kick_prepare(queue->vqueue);
+=09=09=09list_add_tail(&msg->list, &snd->ctl_msgs);
+=09=09}
+=09}
+=09spin_unlock_irqrestore(&queue->lock, flags);
+
+=09if (!rc) {
+=09=09if (!notify || virtqueue_notify(queue->vqueue))
+=09=09=09return 0;
+
+=09=09spin_lock_irqsave(&queue->lock, flags);
+=09=09list_del(&msg->list);
+=09=09spin_unlock_irqrestore(&queue->lock, flags);
+=09}
+
+=09virtsnd_ctl_msg_unref(snd->vdev, msg);
+
+=09return -EIO;
+}
+
+/**
+ * virtsnd_ctl_msg_send_sync() - Send a (synchronous) control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * After returning from this function, the message will be deleted. If mes=
sage
+ * content is still needed, the caller must additionally to
+ * virtsnd_ctl_msg_ref/unref() it.
+ *
+ * The msg_timeout_ms module parameter defines the message completion time=
out.
+ * If the message is not completed within this time, the function will ret=
urn an
+ * error.
+ *
+ * Context: Any context. Takes and releases the control queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ *
+ * The return value is a message status code (VIRTIO_SND_S_XXX) converted =
to an
+ * appropriate -errno value.
+ */
+int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
+=09=09=09      struct virtio_snd_msg *msg)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09unsigned int js =3D msecs_to_jiffies(msg_timeout_ms);
+=09struct virtio_snd_hdr *response;
+=09int rc;
+
+=09virtsnd_ctl_msg_ref(vdev, msg);
+
+=09rc =3D virtsnd_ctl_msg_send(snd, msg);
+=09if (rc)
+=09=09goto on_failure;
+
+=09rc =3D wait_for_completion_interruptible_timeout(&msg->notify, js);
+=09if (rc <=3D 0) {
+=09=09if (!rc) {
+=09=09=09struct virtio_snd_hdr *request =3D
+=09=09=09=09sg_virt(&msg->sg_request);
+
+=09=09=09dev_err(&vdev->dev,
+=09=09=09=09"control message (0x%08x) timeout\n",
+=09=09=09=09le32_to_cpu(request->code));
+=09=09=09rc =3D -EIO;
+=09=09}
+
+=09=09goto on_failure;
+=09}
+
+=09response =3D sg_virt(&msg->sg_response);
+
+=09switch (le32_to_cpu(response->code)) {
+=09case VIRTIO_SND_S_OK:
+=09=09rc =3D 0;
+=09=09break;
+=09case VIRTIO_SND_S_BAD_MSG:
+=09=09rc =3D -EINVAL;
+=09=09break;
+=09case VIRTIO_SND_S_NOT_SUPP:
+=09=09rc =3D -EOPNOTSUPP;
+=09=09break;
+=09case VIRTIO_SND_S_IO_ERR:
+=09=09rc =3D -EIO;
+=09=09break;
+=09default:
+=09=09rc =3D -EPERM;
+=09=09break;
+=09}
+
+on_failure:
+=09virtsnd_ctl_msg_unref(vdev, msg);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_ctl_msg_complete() - Complete a control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
+=09=09=09      struct virtio_snd_msg *msg)
+{
+=09list_del(&msg->list);
+=09complete(&msg->notify);
+
+=09virtsnd_ctl_msg_unref(snd->vdev, msg);
+}
+
+/**
+ * virtsnd_ctl_query_info() - Query the item configuration from the device=
.
+ * @snd: VirtIO sound device.
+ * @command: Control request code (VIRTIO_SND_R_XXX_INFO).
+ * @start_id: Item start identifier.
+ * @count: Item count to query.
+ * @size: Item information size in bytes.
+ * @info: Buffer for storing item information.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_=
id,
+=09=09=09   int count, size_t size, void *info)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_query_info *query;
+=09struct scatterlist sg;
+
+=09sg_init_one(&sg, info, count * size);
+
+=09msg =3D virtsnd_ctl_msg_alloc_ext(vdev, sizeof(*query),
+=09=09=09=09=09sizeof(struct virtio_snd_hdr), &sg, 0,
+=09=09=09=09=091, GFP_KERNEL);
+=09if (IS_ERR(msg))
+=09=09return PTR_ERR(msg);
+
+=09query =3D sg_virt(&msg->sg_request);
+=09query->hdr.code =3D cpu_to_virtio32(vdev, command);
+=09query->start_id =3D cpu_to_virtio32(vdev, start_id);
+=09query->count =3D cpu_to_virtio32(vdev, count);
+=09query->size =3D cpu_to_virtio32(vdev, size);
+
+=09return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_ctl_notify_cb() - Process all completed control messages.
+ * @vqueue: Underlying control virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from th=
e
+ * device.
+ *
+ * Context: Interrupt context. Takes and releases the control queue spinlo=
ck.
+ */
+void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
+{
+=09struct virtio_snd *snd =3D vqueue->vdev->priv;
+=09struct virtio_snd_queue *queue =3D virtsnd_control_queue(snd);
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09while (queue->vqueue) {
+=09=09virtqueue_disable_cb(queue->vqueue);
+
+=09=09for (;;) {
+=09=09=09struct virtio_snd_msg *msg;
+=09=09=09u32 length;
+
+=09=09=09msg =3D virtqueue_get_buf(queue->vqueue, &length);
+=09=09=09if (!msg)
+=09=09=09=09break;
+
+=09=09=09virtsnd_ctl_msg_complete(snd, msg);
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
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
new file mode 100644
index 000000000000..0f8de8f2fd2d
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
+#ifndef VIRTIO_SND_MSG_H
+#define VIRTIO_SND_MSG_H
+
+#include <linux/atomic.h>
+#include <linux/virtio.h>
+
+struct virtio_snd;
+
+/**
+ * struct virtio_snd_msg - Control message.
+ * @sg_request: Scattergather element containing a device request (header)=
.
+ * @sg_response: Scattergather element containing a device response (statu=
s).
+ * @list: Pending message list entry.
+ * @notify: Request completed notification.
+ * @ref_count: Reference count used to manage a message lifetime.
+ * @out_sgs: Number of read-only sg elements in the sgs array.
+ * @in_sgs: Number of write-only sg elements in the sgs array.
+ * @sgs: Array of sg elements to add to the control virtqueue.
+ */
+struct virtio_snd_msg {
+/* public: */
+=09struct scatterlist sg_request;
+=09struct scatterlist sg_response;
+/* private: internal use only */
+=09struct list_head list;
+=09struct completion notify;
+=09atomic_t ref_count;
+=09unsigned int out_sgs;
+=09unsigned int in_sgs;
+=09struct scatterlist *sgs[0];
+};
+
+/**
+ * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
+ * @vdev: VirtIO parent device.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+static inline void virtsnd_ctl_msg_ref(struct virtio_device *vdev,
+=09=09=09=09       struct virtio_snd_msg *msg)
+{
+=09atomic_inc(&msg->ref_count);
+}
+
+/**
+ * virtsnd_ctl_msg_unref() - Decrement reference counter for the message.
+ * @vdev: VirtIO parent device.
+ * @msg: Control message.
+ *
+ * The message will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+static inline void virtsnd_ctl_msg_unref(struct virtio_device *vdev,
+=09=09=09=09=09 struct virtio_snd_msg *msg)
+{
+=09if (!atomic_dec_return(&msg->ref_count))
+=09=09devm_kfree(&vdev->dev, msg);
+}
+
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vde=
v,
+=09=09=09=09=09=09 size_t request_size,
+=09=09=09=09=09=09 size_t response_size,
+=09=09=09=09=09=09 struct scatterlist *sgs,
+=09=09=09=09=09=09 unsigned int out_sgs,
+=09=09=09=09=09=09 unsigned int in_sgs,
+=09=09=09=09=09=09 gfp_t gfp);
+
+/**
+ * virtsnd_ctl_msg_alloc() - Simplified control message allocation.
+ * @vdev: VirtIO parent device.
+ * @request_size: Size of request header (pointed to by sg_request field).
+ * @response_size: Size of response header (pointed to by sg_response fiel=
d).
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, ERR_PTR(-errno) on failure.
+ */
+static inline
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc(struct virtio_device *vdev,
+=09=09=09=09=09     size_t request_size,
+=09=09=09=09=09     size_t response_size, gfp_t gfp)
+{
+=09return virtsnd_ctl_msg_alloc_ext(vdev, request_size, response_size,
+=09=09=09=09=09 NULL, 0, 0, gfp);
+}
+
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *ms=
g);
+
+int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
+=09=09=09      struct virtio_snd_msg *msg);
+
+void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
+=09=09=09      struct virtio_snd_msg *msg);
+
+int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_=
id,
+=09=09=09   int count, size_t size, void *info);
+
+void virtsnd_ctl_notify_cb(struct virtqueue *vqueue);
+
+#endif /* VIRTIO_SND_MSG_H */
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
new file mode 100644
index 000000000000..036990b7b78a
--- /dev/null
+++ b/sound/virtio/virtio_pcm.c
@@ -0,0 +1,536 @@
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
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+static unsigned int pcm_buffer_ms =3D 160;
+module_param(pcm_buffer_ms, uint, 0644);
+MODULE_PARM_DESC(pcm_buffer_ms, "PCM substream buffer time in milliseconds=
");
+
+static unsigned int pcm_periods_min =3D 2;
+module_param(pcm_periods_min, uint, 0644);
+MODULE_PARM_DESC(pcm_periods_min, "Minimum number of PCM periods");
+
+static unsigned int pcm_periods_max =3D 16;
+module_param(pcm_periods_max, uint, 0644);
+MODULE_PARM_DESC(pcm_periods_max, "Maximum number of PCM periods");
+
+static unsigned int pcm_period_ms_min =3D 10;
+module_param(pcm_period_ms_min, uint, 0644);
+MODULE_PARM_DESC(pcm_period_ms_min, "Minimum PCM period time in millisecon=
ds");
+
+static unsigned int pcm_period_ms_max =3D 80;
+module_param(pcm_period_ms_max, uint, 0644);
+MODULE_PARM_DESC(pcm_period_ms_max, "Maximum PCM period time in millisecon=
ds");
+
+/* Map for converting VirtIO format to ALSA format. */
+static const unsigned int g_v2a_format_map[] =3D {
+=09[VIRTIO_SND_PCM_FMT_IMA_ADPCM] =3D SNDRV_PCM_FORMAT_IMA_ADPCM,
+=09[VIRTIO_SND_PCM_FMT_MU_LAW] =3D SNDRV_PCM_FORMAT_MU_LAW,
+=09[VIRTIO_SND_PCM_FMT_A_LAW] =3D SNDRV_PCM_FORMAT_A_LAW,
+=09[VIRTIO_SND_PCM_FMT_S8] =3D SNDRV_PCM_FORMAT_S8,
+=09[VIRTIO_SND_PCM_FMT_U8] =3D SNDRV_PCM_FORMAT_U8,
+=09[VIRTIO_SND_PCM_FMT_S16] =3D SNDRV_PCM_FORMAT_S16_LE,
+=09[VIRTIO_SND_PCM_FMT_U16] =3D SNDRV_PCM_FORMAT_U16_LE,
+=09[VIRTIO_SND_PCM_FMT_S18_3] =3D SNDRV_PCM_FORMAT_S18_3LE,
+=09[VIRTIO_SND_PCM_FMT_U18_3] =3D SNDRV_PCM_FORMAT_U18_3LE,
+=09[VIRTIO_SND_PCM_FMT_S20_3] =3D SNDRV_PCM_FORMAT_S20_3LE,
+=09[VIRTIO_SND_PCM_FMT_U20_3] =3D SNDRV_PCM_FORMAT_U20_3LE,
+=09[VIRTIO_SND_PCM_FMT_S24_3] =3D SNDRV_PCM_FORMAT_S24_3LE,
+=09[VIRTIO_SND_PCM_FMT_U24_3] =3D SNDRV_PCM_FORMAT_U24_3LE,
+=09[VIRTIO_SND_PCM_FMT_S20] =3D SNDRV_PCM_FORMAT_S20_LE,
+=09[VIRTIO_SND_PCM_FMT_U20] =3D SNDRV_PCM_FORMAT_U20_LE,
+=09[VIRTIO_SND_PCM_FMT_S24] =3D SNDRV_PCM_FORMAT_S24_LE,
+=09[VIRTIO_SND_PCM_FMT_U24] =3D SNDRV_PCM_FORMAT_U24_LE,
+=09[VIRTIO_SND_PCM_FMT_S32] =3D SNDRV_PCM_FORMAT_S32_LE,
+=09[VIRTIO_SND_PCM_FMT_U32] =3D SNDRV_PCM_FORMAT_U32_LE,
+=09[VIRTIO_SND_PCM_FMT_FLOAT] =3D SNDRV_PCM_FORMAT_FLOAT_LE,
+=09[VIRTIO_SND_PCM_FMT_FLOAT64] =3D SNDRV_PCM_FORMAT_FLOAT64_LE,
+=09[VIRTIO_SND_PCM_FMT_DSD_U8] =3D SNDRV_PCM_FORMAT_DSD_U8,
+=09[VIRTIO_SND_PCM_FMT_DSD_U16] =3D SNDRV_PCM_FORMAT_DSD_U16_LE,
+=09[VIRTIO_SND_PCM_FMT_DSD_U32] =3D SNDRV_PCM_FORMAT_DSD_U32_LE,
+=09[VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME] =3D
+=09=09SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+};
+
+/* Map for converting VirtIO frame rate to ALSA frame rate. */
+struct virtsnd_v2a_rate {
+=09unsigned int alsa_bit;
+=09unsigned int rate;
+};
+
+static const struct virtsnd_v2a_rate g_v2a_rate_map[] =3D {
+=09[VIRTIO_SND_PCM_RATE_5512] =3D { SNDRV_PCM_RATE_5512, 5512 },
+=09[VIRTIO_SND_PCM_RATE_8000] =3D { SNDRV_PCM_RATE_8000, 8000 },
+=09[VIRTIO_SND_PCM_RATE_11025] =3D { SNDRV_PCM_RATE_11025, 11025 },
+=09[VIRTIO_SND_PCM_RATE_16000] =3D { SNDRV_PCM_RATE_16000, 16000 },
+=09[VIRTIO_SND_PCM_RATE_22050] =3D { SNDRV_PCM_RATE_22050, 22050 },
+=09[VIRTIO_SND_PCM_RATE_32000] =3D { SNDRV_PCM_RATE_32000, 32000 },
+=09[VIRTIO_SND_PCM_RATE_44100] =3D { SNDRV_PCM_RATE_44100, 44100 },
+=09[VIRTIO_SND_PCM_RATE_48000] =3D { SNDRV_PCM_RATE_48000, 48000 },
+=09[VIRTIO_SND_PCM_RATE_64000] =3D { SNDRV_PCM_RATE_64000, 64000 },
+=09[VIRTIO_SND_PCM_RATE_88200] =3D { SNDRV_PCM_RATE_88200, 88200 },
+=09[VIRTIO_SND_PCM_RATE_96000] =3D { SNDRV_PCM_RATE_96000, 96000 },
+=09[VIRTIO_SND_PCM_RATE_176400] =3D { SNDRV_PCM_RATE_176400, 176400 },
+=09[VIRTIO_SND_PCM_RATE_192000] =3D { SNDRV_PCM_RATE_192000, 192000 }
+};
+
+/**
+ * virtsnd_pcm_build_hw() - Parse substream config and build HW descriptor=
.
+ * @substream: VirtIO substream.
+ * @info: VirtIO substream information entry.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL if configuration is invalid.
+ */
+static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *substream,
+=09=09=09=09struct virtio_snd_pcm_info *info)
+{
+=09struct virtio_device *vdev =3D substream->snd->vdev;
+=09unsigned int i;
+=09u64 values;
+=09size_t sample_max =3D 0;
+=09size_t sample_min =3D 0;
+
+=09substream->features =3D le32_to_cpu(info->features);
+
+=09/*
+=09 * TODO: set SNDRV_PCM_INFO_{BATCH,BLOCK_TRANSFER} if device supports
+=09 * only message-based transport.
+=09 */
+=09substream->hw.info =3D
+=09=09SNDRV_PCM_INFO_MMAP |
+=09=09SNDRV_PCM_INFO_MMAP_VALID |
+=09=09SNDRV_PCM_INFO_BATCH |
+=09=09SNDRV_PCM_INFO_BLOCK_TRANSFER |
+=09=09SNDRV_PCM_INFO_INTERLEAVED;
+
+=09if (!info->channels_min || info->channels_min > info->channels_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: invalid channel range [%u %u]\n",
+=09=09=09substream->sid, info->channels_min, info->channels_max);
+=09=09return -EINVAL;
+=09}
+
+=09substream->hw.channels_min =3D info->channels_min;
+=09substream->hw.channels_max =3D info->channels_max;
+
+=09values =3D le64_to_cpu(info->formats);
+
+=09substream->hw.formats =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_format_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09unsigned int alsa_fmt =3D g_v2a_format_map[i];
+=09=09=09int bytes =3D snd_pcm_format_physical_width(alsa_fmt) / 8;
+
+=09=09=09if (!sample_min || sample_min > bytes)
+=09=09=09=09sample_min =3D bytes;
+
+=09=09=09if (sample_max < bytes)
+=09=09=09=09sample_max =3D bytes;
+
+=09=09=09substream->hw.formats |=3D (1ULL << alsa_fmt);
+=09=09}
+
+=09if (!substream->hw.formats) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM sample formats found\n",
+=09=09=09substream->sid);
+=09=09return -EINVAL;
+=09}
+
+=09values =3D le64_to_cpu(info->rates);
+
+=09substream->hw.rates =3D 0;
+
+=09for (i =3D 0; i < ARRAY_SIZE(g_v2a_rate_map); ++i)
+=09=09if (values & (1ULL << i)) {
+=09=09=09if (!substream->hw.rate_min ||
+=09=09=09    substream->hw.rate_min > g_v2a_rate_map[i].rate)
+=09=09=09=09substream->hw.rate_min =3D g_v2a_rate_map[i].rate;
+
+=09=09=09if (substream->hw.rate_max < g_v2a_rate_map[i].rate)
+=09=09=09=09substream->hw.rate_max =3D g_v2a_rate_map[i].rate;
+
+=09=09=09substream->hw.rates |=3D g_v2a_rate_map[i].alsa_bit;
+=09=09}
+
+=09if (!substream->hw.rates) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"SID %u: no supported PCM frame rates found\n",
+=09=09=09substream->sid);
+=09=09return -EINVAL;
+=09}
+
+=09substream->hw.periods_min =3D pcm_periods_min;
+=09substream->hw.periods_max =3D pcm_periods_max;
+
+=09/*
+=09 * We must ensure that there is enough space in the buffer to store
+=09 * pcm_buffer_ms ms for the combination (Cmax, Smax, Rmax), where:
+=09 *   Cmax =3D maximum supported number of channels,
+=09 *   Smax =3D maximum supported sample size in bytes,
+=09 *   Rmax =3D maximum supported frame rate.
+=09 */
+=09substream->hw.buffer_bytes_max =3D
+=09=09sample_max * substream->hw.channels_max * pcm_buffer_ms *
+=09=09(substream->hw.rate_max / MSEC_PER_SEC);
+
+=09/* Align the buffer size to the page size */
+=09substream->hw.buffer_bytes_max =3D
+=09=09(substream->hw.buffer_bytes_max + PAGE_SIZE - 1) & -PAGE_SIZE;
+
+=09/*
+=09 * We must ensure that the minimum period size is enough to store
+=09 * pcm_period_ms_min ms for the combination (Cmin, Smin, Rmin), where:
+=09 *   Cmin =3D minimum supported number of channels,
+=09 *   Smin =3D minimum supported sample size in bytes,
+=09 *   Rmin =3D minimum supported frame rate.
+=09 */
+=09substream->hw.period_bytes_min =3D
+=09=09sample_min * substream->hw.channels_min * pcm_period_ms_min *
+=09=09(substream->hw.rate_min / MSEC_PER_SEC);
+
+=09/*
+=09 * We must ensure that the maximum period size is enough to store
+=09 * pcm_period_ms_max ms for the combination (Cmax, Smax, Rmax).
+=09 */
+=09substream->hw.period_bytes_max =3D
+=09=09sample_max * substream->hw.channels_max * pcm_period_ms_max *
+=09=09(substream->hw.rate_max / MSEC_PER_SEC);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_prealloc_pages() - Preallocate substream hardware buffer.
+ * @substream: VirtIO substream.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_prealloc_pages(struct virtio_pcm_substream *substre=
am)
+{
+=09struct snd_pcm_substream *ksubstream =3D substream->substream;
+=09size_t size =3D substream->hw.buffer_bytes_max;
+=09struct device *data =3D snd_dma_continuous_data(GFP_KERNEL);
+
+=09/*
+=09 * We just allocate a CONTINUOUS buffer as it should work in any setup.
+=09 *
+=09 * If there is a need to use DEV(_XXX), then add this case here and
+=09 * (probably) update the related source code in other places.
+=09 */
+=09snd_pcm_lib_preallocate_pages(ksubstream, SNDRV_DMA_TYPE_CONTINUOUS,
+=09=09=09=09      data, size, size);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_find() - Find the PCM device for the specified node ID.
+ * @snd: VirtIO sound device.
+ * @nid: Function node ID.
+ *
+ * Context: Any context.
+ * Return: a pointer to the PCM device or ERR_PTR(-ENOENT).
+ */
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, unsigned int n=
id)
+{
+=09struct virtio_pcm *pcm;
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list)
+=09=09if (pcm->nid =3D=3D nid)
+=09=09=09return pcm;
+
+=09return ERR_PTR(-ENOENT);
+}
+
+/**
+ * virtsnd_pcm_find_or_create() - Find or create the PCM device for the
+ *                                specified node ID.
+ * @snd: VirtIO sound device.
+ * @nid: Function node ID.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: a pointer to the PCM device or ERR_PTR(-errno).
+ */
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
+=09=09=09=09=09      unsigned int nid)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *pcm;
+
+=09pcm =3D virtsnd_pcm_find(snd, nid);
+=09if (!IS_ERR(pcm))
+=09=09return pcm;
+
+=09pcm =3D devm_kzalloc(&vdev->dev, sizeof(*pcm), GFP_KERNEL);
+=09if (!pcm)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09pcm->nid =3D nid;
+=09list_add_tail(&pcm->list, &snd->pcm_list);
+
+=09return pcm;
+}
+
+/**
+ * virtsnd_pcm_validate() - Validate if the device can be started.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL on failure.
+ */
+int virtsnd_pcm_validate(struct virtio_device *vdev)
+{
+=09if (pcm_periods_min < 2 || pcm_periods_min > pcm_periods_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"invalid range [%u %u] of the number of PCM periods\n",
+=09=09=09pcm_periods_min, pcm_periods_max);
+=09=09return -EINVAL;
+=09}
+
+=09if (!pcm_period_ms_min || pcm_period_ms_min > pcm_period_ms_max) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"invalid range [%u %u] of the size of the PCM period\n",
+=09=09=09pcm_period_ms_min, pcm_period_ms_max);
+=09=09return -EINVAL;
+=09}
+
+=09if (pcm_buffer_ms < pcm_periods_min * pcm_period_ms_min) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"pcm_buffer_ms(=3D%u) value cannot be < %u ms\n",
+=09=09=09pcm_buffer_ms, pcm_periods_min * pcm_period_ms_min);
+=09=09return -EINVAL;
+=09}
+
+=09if (pcm_period_ms_max > pcm_buffer_ms / 2) {
+=09=09dev_err(&vdev->dev,
+=09=09=09"pcm_period_ms_max(=3D%u) value cannot be > %u ms\n",
+=09=09=09pcm_period_ms_max, pcm_buffer_ms / 2);
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_parse_cfg() - Parse the stream configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_pcm_info *info;
+=09unsigned int i;
+=09int rc;
+
+=09virtio_cread(vdev, struct virtio_snd_config, streams,
+=09=09     &snd->nsubstreams);
+=09if (!snd->nsubstreams)
+=09=09return 0;
+
+=09snd->substreams =3D devm_kcalloc(&vdev->dev, snd->nsubstreams,
+=09=09=09=09       sizeof(*snd->substreams), GFP_KERNEL);
+=09if (!snd->substreams)
+=09=09return -ENOMEM;
+
+=09info =3D devm_kcalloc(&vdev->dev, snd->nsubstreams, sizeof(*info),
+=09=09=09    GFP_KERNEL);
+=09if (!info)
+=09=09return -ENOMEM;
+
+=09rc =3D virtsnd_ctl_query_info(snd, VIRTIO_SND_R_PCM_INFO, 0,
+=09=09=09=09    snd->nsubstreams, sizeof(*info), info);
+=09if (rc)
+=09=09return rc;
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *substream =3D &snd->substreams[i];
+=09=09struct virtio_pcm *pcm;
+
+=09=09substream->snd =3D snd;
+=09=09substream->sid =3D i;
+
+=09=09rc =3D virtsnd_pcm_build_hw(substream, &info[i]);
+=09=09if (rc)
+=09=09=09return rc;
+
+=09=09substream->nid =3D le32_to_cpu(info[i].hdr.hda_fn_nid);
+
+=09=09pcm =3D virtsnd_pcm_find_or_create(snd, substream->nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09switch (info[i].direction) {
+=09=09case VIRTIO_SND_D_OUTPUT: {
+=09=09=09substream->direction =3D SNDRV_PCM_STREAM_PLAYBACK;
+=09=09=09break;
+=09=09}
+=09=09case VIRTIO_SND_D_INPUT: {
+=09=09=09substream->direction =3D SNDRV_PCM_STREAM_CAPTURE;
+=09=09=09break;
+=09=09}
+=09=09default: {
+=09=09=09dev_err(&vdev->dev, "SID %u: unknown direction (%u)\n",
+=09=09=09=09substream->sid, info[i].direction);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09}
+
+=09=09pcm->streams[substream->direction].nsubstreams++;
+=09}
+
+=09devm_kfree(&vdev->dev, info);
+
+=09return 0;
+}
+
+/**
+ * virtsnd_pcm_build_devs() - Build ALSA PCM devices.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_build_devs(struct virtio_snd *snd)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_pcm *pcm;
+=09unsigned int i;
+=09int rc;
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list) {
+=09=09unsigned int npbs =3D
+=09=09=09pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].nsubstreams;
+=09=09unsigned int ncps =3D
+=09=09=09pcm->streams[SNDRV_PCM_STREAM_CAPTURE].nsubstreams;
+
+=09=09if (!npbs && !ncps)
+=09=09=09continue;
+
+=09=09rc =3D snd_pcm_new(snd->card, "virtio_snd", pcm->nid, npbs, ncps,
+=09=09=09=09 &pcm->pcm);
+=09=09if (rc) {
+=09=09=09dev_err(&vdev->dev, "snd_pcm_new[%u] failed: %d\n",
+=09=09=09=09pcm->nid, rc);
+=09=09=09return rc;
+=09=09}
+
+=09=09pcm->pcm->info_flags =3D 0;
+=09=09pcm->pcm->dev_class =3D SNDRV_PCM_CLASS_GENERIC;
+=09=09pcm->pcm->dev_subclass =3D SNDRV_PCM_SUBCLASS_GENERIC_MIX;
+=09=09strscpy(pcm->pcm->name, "VirtIO PCM", sizeof(pcm->pcm->name));
+
+=09=09pcm->pcm->private_data =3D pcm;
+
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+
+=09=09=09if (!stream->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09stream->substreams =3D
+=09=09=09=09devm_kcalloc(&vdev->dev,
+=09=09=09=09=09     stream->nsubstreams,
+=09=09=09=09=09     sizeof(*stream->substreams),
+=09=09=09=09=09     GFP_KERNEL);
+=09=09=09if (!stream->substreams)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09stream->nsubstreams =3D 0;
+=09=09}
+=09}
+
+=09for (i =3D 0; i < snd->nsubstreams; ++i) {
+=09=09struct virtio_pcm_substream *substream =3D &snd->substreams[i];
+=09=09struct virtio_pcm_stream *stream;
+
+=09=09pcm =3D virtsnd_pcm_find(snd, substream->nid);
+=09=09if (IS_ERR(pcm))
+=09=09=09return PTR_ERR(pcm);
+
+=09=09stream =3D &pcm->streams[substream->direction];
+=09=09stream->substreams[stream->nsubstreams++] =3D substream;
+=09}
+
+=09list_for_each_entry(pcm, &snd->pcm_list, list)
+=09=09for (i =3D 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+=09=09=09struct virtio_pcm_stream *stream =3D &pcm->streams[i];
+=09=09=09struct snd_pcm_str *kstream;
+=09=09=09struct snd_pcm_substream *ksubstream;
+
+=09=09=09if (!stream->nsubstreams)
+=09=09=09=09continue;
+
+=09=09=09kstream =3D &pcm->pcm->streams[i];
+=09=09=09ksubstream =3D kstream->substream;
+
+=09=09=09while (ksubstream) {
+=09=09=09=09struct virtio_pcm_substream *substream =3D
+=09=09=09=09=09stream->substreams[ksubstream->number];
+
+=09=09=09=09substream->substream =3D ksubstream;
+=09=09=09=09ksubstream =3D ksubstream->next;
+
+=09=09=09=09rc =3D virtsnd_pcm_prealloc_pages(substream);
+=09=09=09=09if (rc)
+=09=09=09=09=09return rc;
+=09=09=09}
+=09=09}
+
+=09return 0;
+}
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
+=09struct virtio_pcm_substream *substream;
+=09unsigned int sid =3D le32_to_cpu(event->data);
+
+=09if (sid >=3D snd->nsubstreams)
+=09=09return;
+
+=09substream =3D &snd->substreams[sid];
+
+=09switch (le32_to_cpu(event->hdr.code)) {
+=09case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED: {
+=09=09/* TODO: deal with shmem elapsed period */
+=09=09break;
+=09}
+=09case VIRTIO_SND_EVT_PCM_XRUN: {
+=09=09break;
+=09}
+=09}
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
new file mode 100644
index 000000000000..73fb4d9dc524
--- /dev/null
+++ b/sound/virtio/virtio_pcm.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
+#ifndef VIRTIO_SND_PCM_H
+#define VIRTIO_SND_PCM_H
+
+#include <linux/atomic.h>
+#include <linux/virtio_config.h>
+#include <sound/pcm.h>
+
+struct virtio_pcm;
+
+/**
+ * struct virtio_pcm_substream - VirtIO PCM substream.
+ * @snd: VirtIO sound device.
+ * @nid: Function group node identifier.
+ * @sid: Stream identifier.
+ * @direction: Stream data flow direction (SNDRV_PCM_STREAM_XXX).
+ * @features: Stream VirtIO feature bit map (1 << VIRTIO_SND_PCM_F_XXX).
+ * @substream: Kernel ALSA substream.
+ * @hw: Kernel ALSA substream hardware descriptor.
+ */
+struct virtio_pcm_substream {
+=09struct virtio_snd *snd;
+=09unsigned int nid;
+=09unsigned int sid;
+=09u32 direction;
+=09u32 features;
+=09struct snd_pcm_substream *substream;
+=09struct snd_pcm_hardware hw;
+};
+
+/**
+ * struct virtio_pcm_stream - VirtIO PCM stream.
+ * @substreams: Virtio substreams belonging to the stream.
+ * @nsubstreams: Number of substreams.
+ */
+struct virtio_pcm_stream {
+=09struct virtio_pcm_substream **substreams;
+=09unsigned int nsubstreams;
+};
+
+/**
+ * struct virtio_pcm - VirtIO PCM device.
+ * @list: PCM list entry.
+ * @nid: Function group node identifier.
+ * @pcm: Kernel PCM device.
+ * @streams: VirtIO PCM streams (playback and capture).
+ */
+struct virtio_pcm {
+=09struct list_head list;
+=09unsigned int nid;
+=09struct snd_pcm *pcm;
+=09struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
+};
+
+int virtsnd_pcm_validate(struct virtio_device *vdev);
+
+int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_pcm_build_devs(struct virtio_snd *snd);
+
+void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *ev=
ent);
+
+void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue);
+
+void virtsnd_pcm_rx_notify_cb(struct virtqueue *vqueue);
+
+struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, unsigned int n=
id);
+
+struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
+=09=09=09=09=09      unsigned int nid);
+
+#endif /* VIRTIO_SND_PCM_H */
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

