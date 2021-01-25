Return-Path: virtio-dev-return-7953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA3539861C2
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jan 2021 14:55:17 +0000 (UTC)
Date: Mon, 25 Jan 2021 15:54:59 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
Message-ID: <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound driver
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Anton,

A couple of mostly cosmetic comments inline.

On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> Introduce skeleton of the virtio sound driver. The driver implements
> the virtio sound device specification, which has become part of the
> virtio standard.
>
> Initial initialization of the device, virtqueues and creation of an
> empty ALSA sound device. Also, handling DEVICE_NEEDS_RESET device
> status.
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> MAINTAINERS                     |   9 +
> include/uapi/linux/virtio_snd.h | 361 +++++++++++++++++++++++++++
> sound/Kconfig                   |   2 +
> sound/Makefile                  |   3 +-
> sound/virtio/Kconfig            |  10 +
> sound/virtio/Makefile           |   7 +
> sound/virtio/virtio_card.c      | 415 ++++++++++++++++++++++++++++++++
> sound/virtio/virtio_card.h      |  76 ++++++
> 8 files changed, 882 insertions(+), 1 deletion(-)
> create mode 100644 include/uapi/linux/virtio_snd.h
> create mode 100644 sound/virtio/Kconfig
> create mode 100644 sound/virtio/Makefile
> create mode 100644 sound/virtio/virtio_card.c
> create mode 100644 sound/virtio/virtio_card.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00836f6452f0..3f509d54a457 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18936,6 +18936,15 @@ W:	https://virtio-mem.gitlab.io/
> F:	drivers/virtio/virtio_mem.c
> F:	include/uapi/linux/virtio_mem.h
>
> +VIRTIO SOUND DRIVER
> +M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
> +M:	"Michael S. Tsirkin" <mst@redhat.com>
> +L:	virtualization@lists.linux-foundation.org
> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	include/uapi/linux/virtio_snd.h
> +F:	sound/virtio/*
> +
> VIRTUAL BOX GUEST DEVICE DRIVER
> M:	Hans de Goede <hdegoede@redhat.com>
> M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
> new file mode 100644
> index 000000000000..1ff6310e54d6
> --- /dev/null
> +++ b/include/uapi/linux/virtio_snd.h
> @@ -0,0 +1,361 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This header is BSD licensed so anyone can use the definitions to
> + * implement compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:

Can a BSD licence actually be further restricted?

> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of OpenSynergy GmbH nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR

IBM? Also no idea whether this warranty disclaimer is appropriate here. I 
thought we were transitioning to those SPDX identifiers to eliminate all 
these headers.

> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */

[snip]

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> new file mode 100644
> index 000000000000..532d823fdf6f
> --- /dev/null
> +++ b/sound/virtio/virtio_card.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sound card driver for virtio
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Same here, I think SPDX means you don't need all this here any more.

> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/virtio_config.h>
> +#include <sound/initval.h>
> +#include <uapi/linux/virtio_ids.h>
> +
> +#include "virtio_card.h"
> +
> +static void virtsnd_remove(struct virtio_device *vdev);
> +
> +/**
> + * virtsnd_event_send() - Add an event to the event queue.
> + * @vqueue: Underlying event virtqueue.
> + * @event: Event.
> + * @notify: Indicates whether or not to send a notification to the device.
> + * @gfp: Kernel flags for memory allocation.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_event_send(struct virtqueue *vqueue,
> +			      struct virtio_snd_event *event, bool notify,
> +			      gfp_t gfp)
> +{
> +	struct scatterlist sg;
> +	struct scatterlist *psgs[1] = { &sg };
> +	int rc;
> +
> +	/* reset event content */
> +	memset(event, 0, sizeof(*event));
> +
> +	sg_init_one(&sg, event, sizeof(*event));
> +
> +	rc = virtqueue_add_sgs(vqueue, psgs, 0, 1, event, gfp);
> +	if (rc)
> +		return rc;
> +
> +	if (notify)
> +		if (virtqueue_kick_prepare(vqueue))
> +			if (!virtqueue_notify(vqueue))
> +				return -EIO;
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_event_notify_cb() - Dispatch all reported events from the event queue.
> + * @vqueue: Underlying event virtqueue.
> + *
> + * This callback function is called upon a vring interrupt request from the
> + * device.
> + *
> + * Context: Interrupt context.
> + */
> +static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
> +{
> +	struct virtio_snd *snd = vqueue->vdev->priv;
> +	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	while (queue->vqueue) {
> +		virtqueue_disable_cb(queue->vqueue);
> +
> +		for (;;) {
> +			struct virtio_snd_event *event;
> +			u32 length;
> +
> +			event = virtqueue_get_buf(queue->vqueue, &length);
> +			if (!event)
> +				break;
> +
> +			virtsnd_event_send(queue->vqueue, event, true,
> +					   GFP_ATOMIC);
> +		}
> +
> +		if (unlikely(virtqueue_is_broken(queue->vqueue)))
> +			break;
> +
> +		if (virtqueue_enable_cb(queue->vqueue))
> +			break;
> +	}
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +}
> +
> +/**
> + * virtsnd_find_vqs() - Enumerate and initialize all virtqueues.
> + * @snd: VirtIO sound device.
> + *
> + * After calling this function, the event queue is disabled.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_find_vqs(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] = { 0 };
> +	const char *names[VIRTIO_SND_VQ_MAX] = {
> +		[VIRTIO_SND_VQ_CONTROL] = "virtsnd-ctl",
> +		[VIRTIO_SND_VQ_EVENT] = "virtsnd-event",
> +		[VIRTIO_SND_VQ_TX] = "virtsnd-tx",
> +		[VIRTIO_SND_VQ_RX] = "virtsnd-rx"
> +	};
> +	struct virtqueue *vqs[VIRTIO_SND_VQ_MAX] = { 0 };
> +	unsigned int i;
> +	unsigned int n = 0;
> +	int rc;
> +
> +	callbacks[VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb;
> +
> +	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
> +			     NULL);
> +	if (rc) {
> +		dev_err(&vdev->dev, "failed to initialize virtqueues\n");
> +		return rc;
> +	}
> +
> +	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
> +		snd->queues[i].vqueue = vqs[i];
> +
> +	/* Allocate events and populate the event queue */
> +	virtqueue_disable_cb(vqs[VIRTIO_SND_VQ_EVENT]);
> +
> +	n = virtqueue_get_vring_size(vqs[VIRTIO_SND_VQ_EVENT]);
> +
> +	snd->event_msgs = devm_kcalloc(&vdev->dev, n, sizeof(*snd->event_msgs),
> +				       GFP_KERNEL);
> +	if (!snd->event_msgs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < n; ++i) {
> +		rc = virtsnd_event_send(vqs[VIRTIO_SND_VQ_EVENT],
> +					&snd->event_msgs[i], false, GFP_KERNEL);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_enable_event_vq() - Enable the event virtqueue.
> + * @snd: VirtIO sound device.
> + *
> + * Context: Any context.
> + */
> +static void virtsnd_enable_event_vq(struct virtio_snd *snd)
> +{
> +	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
> +
> +	if (!virtqueue_enable_cb(queue->vqueue))
> +		virtsnd_event_notify_cb(queue->vqueue);
> +}
> +
> +/**
> + * virtsnd_disable_vqs() - Disable all virtqueues.
> + * @snd: VirtIO sound device.
> + *
> + * Also free all allocated events and control messages.
> + *
> + * Context: Any context.
> + */
> +static void virtsnd_disable_vqs(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	unsigned int i;
> +	unsigned long flags;
> +
> +	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
> +		struct virtio_snd_queue *queue = &snd->queues[i];
> +
> +		spin_lock_irqsave(&queue->lock, flags);
> +		/* Prohibit the use of the queue */
> +		if (queue->vqueue)
> +			virtqueue_disable_cb(queue->vqueue);
> +		queue->vqueue = NULL;
> +		spin_unlock_irqrestore(&queue->lock, flags);
> +	}
> +
> +	if (snd->event_msgs)

Check not needed, kfree(NULL) is ok.

> +		devm_kfree(&vdev->dev, snd->event_msgs);

I think there are very few cases when managed resources have to be 
explicitly freed. If explicit freeing is always required, then there's no 
need to have them managed. If there's a clear case for managed resources, 
usually you don't need to free them explicitly. Here.event_msgs are 
allocated in virtsnd_find_vqs() above, which is only called during 
probing. And this function is only called during release. So, I'd assume, 
that you don't need to free memory explicitly here.

> +
> +	snd->event_msgs = NULL;

snd is about to be freed, so do you really need this?

> +}
> +
> +/**
> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
> + * @work: Reset device work.
> + *
> + * Context: Process context.
> + */
> +static void virtsnd_reset_fn(struct work_struct *work)
> +{
> +	struct virtio_snd *snd =
> +		container_of(work, struct virtio_snd, reset_work);
> +	struct virtio_device *vdev = snd->vdev;
> +	struct device *dev = &vdev->dev;
> +	int rc;
> +
> +	dev_info(dev, "sound device needs reset\n");
> +
> +	/*
> +	 * It seems that the only way to properly reset the device is to remove
> +	 * and re-create the ALSA sound card device.
> +	 *
> +	 * Also resetting the device involves a number of steps with setting the
> +	 * status bits described in the virtio specification. And the easiest
> +	 * way to get everything right is to use the virtio bus interface.
> +	 */
> +	rc = dev->bus->remove(dev);
> +	if (rc)
> +		dev_warn(dev, "bus->remove() failed: %d", rc);
> +
> +	rc = dev->bus->probe(dev);
> +	if (rc)
> +		dev_err(dev, "bus->probe() failed: %d", rc);

This looks very suspicious to me. Wondering what ALSA maintainers will say 
to this.

> +}
> +
> +/**
> + * virtsnd_build_devs() - Read configuration and build ALSA devices.
> + * @snd: VirtIO sound device.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_build_devs(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	int rc;
> +
> +	rc = snd_card_new(&vdev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
> +			  THIS_MODULE, 0, &snd->card);
> +	if (rc < 0)
> +		return rc;
> +
> +	snd->card->private_data = snd;
> +
> +	strscpy(snd->card->id, "viosnd", sizeof(snd->card->id));
> +	strscpy(snd->card->driver, "virtio_snd", sizeof(snd->card->driver));
> +	strscpy(snd->card->shortname, "VIOSND", sizeof(snd->card->shortname));
> +	strscpy(snd->card->longname, "VirtIO Sound Card",
> +		sizeof(snd->card->longname));
> +
> +	return snd_card_register(snd->card);
> +}
> +
> +/**
> + * virtsnd_validate() - Validate if the device can be started.
> + * @vdev: VirtIO parent device.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -EINVAL on failure.
> + */
> +static int virtsnd_validate(struct virtio_device *vdev)
> +{
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "configuration access disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev,
> +			"device does not comply with spec version 1.x\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_probe() - Create and initialize the device.
> + * @vdev: VirtIO parent device.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd;
> +	unsigned int i;
> +	int rc;
> +
> +	snd = devm_kzalloc(&vdev->dev, sizeof(*snd), GFP_KERNEL);
> +	if (!snd)
> +		return -ENOMEM;
> +
> +	snd->vdev = vdev;
> +	INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
> +
> +	vdev->priv = snd;
> +
> +	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
> +		spin_lock_init(&snd->queues[i].lock);
> +
> +	rc = virtsnd_find_vqs(snd);
> +	if (rc)
> +		goto on_failure;
> +
> +	virtio_device_ready(vdev);
> +
> +	rc = virtsnd_build_devs(snd);
> +	if (rc)
> +		goto on_failure;
> +
> +	virtsnd_enable_event_vq(snd);
> +
> +on_failure:
> +	if (rc)
> +		virtsnd_remove(vdev);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_remove() - Remove VirtIO and ALSA devices.
> + * @vdev: VirtIO parent device.
> + *
> + * Context: Any context that permits to sleep.
> + */
> +static void virtsnd_remove(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd = vdev->priv;
> +
> +	if (!snd)
> +		return;
> +
> +	/*
> +	 * Make sure no one is accessing the virtqueues and sending synchronous
> +	 * requests to the device. This can happen if we got here because the
> +	 * device needs to be reset.
> +	 */
> +	virtsnd_disable_vqs(snd);
> +
> +	if (snd->card)
> +		snd_card_free(snd->card);
> +
> +	vdev->config->reset(vdev);
> +	vdev->config->del_vqs(vdev);
> +
> +	devm_kfree(&vdev->dev, snd);

No need for this.

> +
> +	vdev->priv = NULL;

and for this either.

> +}
> +
> +/**
> + * virtsnd_config_changed() - Handle configuration change notification.
> + * @vdev: VirtIO parent device.
> + *
> + * This callback function is called upon a configuration change interrupt
> + * request from the device. Currently only used to handle NEEDS_RESET device
> + * status.
> + *
> + * Context: Interrupt context.
> + */
> +static void virtsnd_config_changed(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd = vdev->priv;
> +	unsigned int status = vdev->config->get_status(vdev);
> +
> +	if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
> +		schedule_work(&snd->reset_work);
> +	else
> +		dev_warn(&vdev->dev,
> +			 "sound device configuration was changed\n");
> +}
> +
> +static const struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtsnd_driver = {
> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table = id_table,
> +	.validate = virtsnd_validate,
> +	.probe = virtsnd_probe,
> +	.remove = virtsnd_remove,
> +	.config_changed = virtsnd_config_changed,
> +};
> +
> +static int __init init(void)
> +{
> +	return register_virtio_driver(&virtsnd_driver);
> +}
> +module_init(init);
> +
> +static void __exit fini(void)
> +{
> +	unregister_virtio_driver(&virtsnd_driver);
> +}
> +module_exit(fini);
> +
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio sound card driver");
> +MODULE_LICENSE("GPL");

Thanks
Guennadi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

