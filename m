Return-Path: virtio-dev-return-7946-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21564985CB3
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Jan 2021 16:54:37 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Sun, 24 Jan 2021 17:54:02 +0100
Message-ID: <20210124165408.1122868-4-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 3/9] ALSA: virtio: handling control messages
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

The control queue can be used by different parts of the driver to send
commands to the device. Control messages can be either synchronous or
asynchronous. The lifetime of a message is controlled by a reference
count.

Introduce a module parameter to set the message completion timeout:
  msg_timeout_ms [=3D1000]

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile         |   3 +-
 sound/virtio/virtio_card.c    |  20 +++
 sound/virtio/virtio_card.h    |   7 +
 sound/virtio/virtio_ctl_msg.c | 293 ++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h | 122 ++++++++++++++
 5 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 8c87ebb9982b..dc551e637441 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_SND_VIRTIO) +=3D virtio_snd.o
=20
 virtio_snd-objs :=3D \
-=09virtio_card.o
+=09virtio_card.o \
+=09virtio_ctl_msg.o
=20
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 532d823fdf6f..955eadc2d858 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -24,6 +24,10 @@
=20
 #include "virtio_card.h"
=20
+int msg_timeout_ms =3D MSEC_PER_SEC;
+module_param(msg_timeout_ms, int, 0644);
+MODULE_PARM_DESC(msg_timeout_ms, "Message completion timeout in millisecon=
ds");
+
 static void virtsnd_remove(struct virtio_device *vdev);
=20
 /**
@@ -125,6 +129,7 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 =09unsigned int n =3D 0;
 =09int rc;
=20
+=09callbacks[VIRTIO_SND_VQ_CONTROL] =3D virtsnd_ctl_notify_cb;
 =09callbacks[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb;
=20
 =09rc =3D virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
@@ -193,6 +198,15 @@ static void virtsnd_disable_vqs(struct virtio_snd *snd=
)
 =09=09if (queue->vqueue)
 =09=09=09virtqueue_disable_cb(queue->vqueue);
 =09=09queue->vqueue =3D NULL;
+=09=09/* Cancel all pending requests for the control queue */
+=09=09if (i =3D=3D VIRTIO_SND_VQ_CONTROL) {
+=09=09=09struct virtio_snd_msg *msg;
+=09=09=09struct virtio_snd_msg *next;
+
+=09=09=09list_for_each_entry_safe(msg, next, &snd->ctl_msgs,
+=09=09=09=09=09=09 list)
+=09=09=09=09virtsnd_ctl_msg_complete(snd, msg);
+=09=09}
 =09=09spin_unlock_irqrestore(&queue->lock, flags);
 =09}
=20
@@ -283,6 +297,11 @@ static int virtsnd_validate(struct virtio_device *vdev=
)
 =09=09return -EINVAL;
 =09}
=20
+=09if (!msg_timeout_ms) {
+=09=09dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
+=09=09return -EINVAL;
+=09}
+
 =09return 0;
 }
=20
@@ -305,6 +324,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
=20
 =09snd->vdev =3D vdev;
 =09INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
+=09INIT_LIST_HEAD(&snd->ctl_msgs);
=20
 =09vdev->priv =3D snd;
=20
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 10084abaaf18..37b734a92134 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -23,6 +23,8 @@
 #include <sound/core.h>
 #include <uapi/linux/virtio_snd.h>
=20
+#include "virtio_ctl_msg.h"
+
 /**
  * struct virtio_snd_queue - Virtqueue wrapper structure.
  * @lock: Used to synchronize access to a virtqueue.
@@ -39,6 +41,7 @@ struct virtio_snd_queue {
  * @queues: Virtqueue wrappers.
  * @reset_work: Reset device work.
  * @card: ALSA sound card.
+ * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  */
 struct virtio_snd {
@@ -46,9 +49,13 @@ struct virtio_snd {
 =09struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
 =09struct work_struct reset_work;
 =09struct snd_card *card;
+=09struct list_head ctl_msgs;
 =09struct virtio_snd_event *event_msgs;
 };
=20
+/* Message completion timeout in milliseconds (module parameter). */
+extern int msg_timeout_ms;
+
 static inline struct virtio_snd_queue *
 virtsnd_control_queue(struct virtio_snd *snd)
 {
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
--=20
2.30.0



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

