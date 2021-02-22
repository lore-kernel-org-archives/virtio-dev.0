Return-Path: virtio-dev-return-8012-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD0A4985D30
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Feb 2021 15:36:06 +0000 (UTC)
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date: Mon, 22 Feb 2021 16:34:38 +0100
Message-ID: <20210222153444.348390-4-anton.yakovlev@opensynergy.com>
In-Reply-To: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 3/9] ALSA: virtio: handling control messages
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
 sound/virtio/virtio_card.c    |  13 ++
 sound/virtio/virtio_card.h    |   7 +
 sound/virtio/virtio_ctl_msg.c | 310 ++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h |  78 +++++++++
 5 files changed, 410 insertions(+), 1 deletion(-)
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
index b5f63b5b7db4..c62b3a2da148 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -11,6 +11,10 @@
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
@@ -82,6 +86,7 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 {
 =09struct virtio_device *vdev =3D snd->vdev;
 =09vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] =3D {
+=09=09[VIRTIO_SND_VQ_CONTROL] =3D virtsnd_ctl_notify_cb,
 =09=09[VIRTIO_SND_VQ_EVENT] =3D virtsnd_event_notify_cb
 =09};
 =09const char *names[VIRTIO_SND_VQ_MAX] =3D {
@@ -218,6 +223,11 @@ static int virtsnd_validate(struct virtio_device *vdev=
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
@@ -240,6 +250,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
=20
 =09snd->vdev =3D vdev;
 =09INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
+=09INIT_LIST_HEAD(&snd->ctl_msgs);
=20
 =09vdev->priv =3D snd;
=20
@@ -278,6 +289,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 =09/* Stop all the virtqueues. */
 =09vdev->config->reset(vdev);
=20
+=09virtsnd_ctl_msg_cancel_all(snd);
+
 =09if (snd->card)
 =09=09snd_card_free(snd->card);
=20
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 244381cc7a9b..c51a71a79388 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -11,6 +11,8 @@
 #include <sound/core.h>
 #include <uapi/linux/virtio_snd.h>
=20
+#include "virtio_ctl_msg.h"
+
 #define VIRTIO_SND_CARD_DRIVER=09"virtio-snd"
 #define VIRTIO_SND_CARD_NAME=09"VirtIO SoundCard"
=20
@@ -30,6 +32,7 @@ struct virtio_snd_queue {
  * @queues: Virtqueue wrappers.
  * @reset_work: Reset device work.
  * @card: ALSA sound card.
+ * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  */
 struct virtio_snd {
@@ -37,9 +40,13 @@ struct virtio_snd {
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
index 000000000000..67a5a0301ba3
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/**
+ * struct virtio_snd_msg - Control message.
+ * @sg_request: Scattergather list containing a device request (header).
+ * @sg_response: Scattergather list containing a device response (status).
+ * @list: Pending message list entry.
+ * @notify: Request completed notification.
+ * @ref_count: Reference count used to manage a message lifetime.
+ */
+struct virtio_snd_msg {
+=09struct scatterlist sg_request;
+=09struct scatterlist sg_response;
+=09struct list_head list;
+=09struct completion notify;
+=09refcount_t ref_count;
+};
+
+/**
+ * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg)
+{
+=09refcount_inc(&msg->ref_count);
+}
+
+/**
+ * virtsnd_ctl_msg_unref() - Decrement reference counter for the message.
+ * @msg: Control message.
+ *
+ * The message will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_unref(struct virtio_snd_msg *msg)
+{
+=09if (refcount_dec_and_test(&msg->ref_count))
+=09=09kfree(msg);
+}
+
+/**
+ * virtsnd_ctl_msg_request() - Get a pointer to the request header.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void *virtsnd_ctl_msg_request(struct virtio_snd_msg *msg)
+{
+=09return sg_virt(&msg->sg_request);
+}
+
+/**
+ * virtsnd_ctl_msg_request() - Get a pointer to the response header.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void *virtsnd_ctl_msg_response(struct virtio_snd_msg *msg)
+{
+=09return sg_virt(&msg->sg_response);
+}
+
+/**
+ * virtsnd_ctl_msg_alloc() - Allocate and initialize a control message.
+ * @request_size: Size of request header.
+ * @response_size: Size of response header.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, NULL on failure.
+ */
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
+=09=09=09=09=09     size_t response_size, gfp_t gfp)
+{
+=09struct virtio_snd_msg *msg;
+
+=09if (!request_size || !response_size)
+=09=09return NULL;
+
+=09msg =3D kzalloc(sizeof(*msg) + request_size + response_size, gfp);
+=09if (!msg)
+=09=09return NULL;
+
+=09sg_init_one(&msg->sg_request, (u8 *)msg + sizeof(*msg), request_size);
+=09sg_init_one(&msg->sg_response, (u8 *)msg + sizeof(*msg) + request_size,
+=09=09    response_size);
+
+=09INIT_LIST_HEAD(&msg->list);
+=09init_completion(&msg->notify);
+=09/* This reference is dropped in virtsnd_ctl_msg_complete(). */
+=09refcount_set(&msg->ref_count, 1);
+
+=09return msg;
+}
+
+/**
+ * virtsnd_ctl_msg_send() - Send a control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ * @out_sgs: Additional sg-list to attach to the request header (may be NU=
LL).
+ * @in_sgs: Additional sg-list to attach to the response header (may be NU=
LL).
+ * @nowait: Flag indicating whether to wait for completion.
+ *
+ * Context: Any context. Takes and releases the control queue spinlock.
+ *          May sleep if @nowait is false.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *ms=
g,
+=09=09=09 struct scatterlist *out_sgs,
+=09=09=09 struct scatterlist *in_sgs, bool nowait)
+{
+=09struct virtio_device *vdev =3D snd->vdev;
+=09struct virtio_snd_queue *queue =3D virtsnd_control_queue(snd);
+=09unsigned int js =3D msecs_to_jiffies(msg_timeout_ms);
+=09struct virtio_snd_hdr *request =3D virtsnd_ctl_msg_request(msg);
+=09struct virtio_snd_hdr *response =3D virtsnd_ctl_msg_response(msg);
+=09unsigned int nouts =3D 0;
+=09unsigned int nins =3D 0;
+=09struct scatterlist *psgs[4];
+=09bool notify =3D false;
+=09unsigned long flags;
+=09int rc;
+
+=09virtsnd_ctl_msg_ref(msg);
+
+=09/* Set the default status in case the message was canceled. */
+=09response->code =3D cpu_to_le32(VIRTIO_SND_S_IO_ERR);
+
+=09psgs[nouts++] =3D &msg->sg_request;
+=09if (out_sgs)
+=09=09psgs[nouts++] =3D out_sgs;
+
+=09psgs[nouts + nins++] =3D &msg->sg_response;
+=09if (in_sgs)
+=09=09psgs[nouts + nins++] =3D in_sgs;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09rc =3D virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
+=09=09=09       GFP_ATOMIC);
+=09if (!rc) {
+=09=09notify =3D virtqueue_kick_prepare(queue->vqueue);
+
+=09=09list_add_tail(&msg->list, &snd->ctl_msgs);
+=09}
+=09spin_unlock_irqrestore(&queue->lock, flags);
+
+=09if (rc) {
+=09=09dev_err(&vdev->dev, "failed to send control message (0x%08x)\n",
+=09=09=09le32_to_cpu(request->code));
+
+=09=09/*
+=09=09 * Since in this case virtsnd_ctl_msg_complete() will not be
+=09=09 * called, it is necessary to decrement the reference count.
+=09=09 */
+=09=09virtsnd_ctl_msg_unref(msg);
+
+=09=09goto on_exit;
+=09}
+
+=09if (notify)
+=09=09virtqueue_notify(queue->vqueue);
+
+=09if (nowait)
+=09=09goto on_exit;
+
+=09rc =3D wait_for_completion_interruptible_timeout(&msg->notify, js);
+=09if (rc <=3D 0) {
+=09=09if (!rc) {
+=09=09=09dev_err(&vdev->dev,
+=09=09=09=09"control message (0x%08x) timeout\n",
+=09=09=09=09le32_to_cpu(request->code));
+=09=09=09rc =3D -ETIMEDOUT;
+=09=09}
+
+=09=09goto on_exit;
+=09}
+
+=09switch (le32_to_cpu(response->code)) {
+=09case VIRTIO_SND_S_OK:
+=09=09rc =3D 0;
+=09=09break;
+=09case VIRTIO_SND_S_NOT_SUPP:
+=09=09rc =3D -EOPNOTSUPP;
+=09=09break;
+=09case VIRTIO_SND_S_IO_ERR:
+=09=09rc =3D -EIO;
+=09=09break;
+=09default:
+=09=09rc =3D -EINVAL;
+=09=09break;
+=09}
+
+on_exit:
+=09virtsnd_ctl_msg_unref(msg);
+
+=09return rc;
+}
+
+/**
+ * virtsnd_ctl_msg_complete() - Complete a control message.
+ * @msg: Control message.
+ *
+ * Context: Any context. Expects the control queue spinlock to be held by
+ *          caller.
+ */
+void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg)
+{
+=09list_del(&msg->list);
+=09complete(&msg->notify);
+
+=09virtsnd_ctl_msg_unref(msg);
+}
+
+/**
+ * virtsnd_ctl_msg_cancel_all() - Cancel all pending control messages.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
+{
+=09struct virtio_snd_queue *queue =3D virtsnd_control_queue(snd);
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09while (!list_empty(&snd->ctl_msgs)) {
+=09=09struct virtio_snd_msg *msg =3D
+=09=09=09list_first_entry(&snd->ctl_msgs, struct virtio_snd_msg,
+=09=09=09=09=09 list);
+
+=09=09virtsnd_ctl_msg_complete(msg);
+=09}
+=09spin_unlock_irqrestore(&queue->lock, flags);
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
+=09struct virtio_snd_msg *msg;
+=09struct virtio_snd_query_info *query;
+=09struct scatterlist sg;
+
+=09msg =3D virtsnd_ctl_msg_alloc(sizeof(*query),
+=09=09=09=09    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+=09if (!msg)
+=09=09return -ENOMEM;
+
+=09query =3D virtsnd_ctl_msg_request(msg);
+=09query->hdr.code =3D cpu_to_le32(command);
+=09query->start_id =3D cpu_to_le32(start_id);
+=09query->count =3D cpu_to_le32(count);
+=09query->size =3D cpu_to_le32(size);
+
+=09sg_init_one(&sg, info, count * size);
+
+=09return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
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
+=09struct virtio_snd_msg *msg;
+=09u32 length;
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&queue->lock, flags);
+=09do {
+=09=09virtqueue_disable_cb(vqueue);
+=09=09while ((msg =3D virtqueue_get_buf(vqueue, &length)))
+=09=09=09virtsnd_ctl_msg_complete(msg);
+=09=09if (unlikely(virtqueue_is_broken(vqueue)))
+=09=09=09break;
+=09} while (!virtqueue_enable_cb(vqueue));
+=09spin_unlock_irqrestore(&queue->lock, flags);
+}
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
new file mode 100644
index 000000000000..7f4db044f28e
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
+ */
+#ifndef VIRTIO_SND_MSG_H
+#define VIRTIO_SND_MSG_H
+
+#include <linux/atomic.h>
+#include <linux/virtio.h>
+
+struct virtio_snd;
+struct virtio_snd_msg;
+
+void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg);
+
+void virtsnd_ctl_msg_unref(struct virtio_snd_msg *msg);
+
+void *virtsnd_ctl_msg_request(struct virtio_snd_msg *msg);
+
+void *virtsnd_ctl_msg_response(struct virtio_snd_msg *msg);
+
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
+=09=09=09=09=09     size_t response_size, gfp_t gfp);
+
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *ms=
g,
+=09=09=09 struct scatterlist *out_sgs,
+=09=09=09 struct scatterlist *in_sgs, bool nowait);
+
+/**
+ * virtsnd_ctl_msg_send_sync() - Simplified sending of synchronous message=
.
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
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ *
+ * The return value is a message status code (VIRTIO_SND_S_XXX) converted =
to an
+ * appropriate -errno value.
+ */
+static inline int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
+=09=09=09=09=09    struct virtio_snd_msg *msg)
+{
+=09return virtsnd_ctl_msg_send(snd, msg, NULL, NULL, false);
+}
+
+/**
+ * virtsnd_ctl_msg_send_async() - Simplified sending of asynchronous messa=
ge.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static inline int virtsnd_ctl_msg_send_async(struct virtio_snd *snd,
+=09=09=09=09=09     struct virtio_snd_msg *msg)
+{
+=09return virtsnd_ctl_msg_send(snd, msg, NULL, NULL, true);
+}
+
+void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd);
+
+void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg);
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

