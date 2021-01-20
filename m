Return-Path: virtio-dev-return-7933-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C92BF98605D
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 08:29:22 +0000 (UTC)
Date: Wed, 20 Jan 2021 03:29:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210120032711-mutt-send-email-mst@kernel.org>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <20210120003638.3339987-5-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20210120003638.3339987-5-anton.yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH 4/7] ALSA: virtio: handling control and I/O messages for
 the PCM device
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 20, 2021 at 01:36:32AM +0100, Anton Yakovlev wrote:
> The driver implements a message-based transport for I/O substream
> operations. Before the start of the substream, the hardware buffer is
> sliced into I/O messages, the number of which is equal to the current
> number of periods. The size of each message is equal to the current
> size of one period.
> 
> I/O messages are organized in an ordered queue. The completion of the
> I/O message indicates an expired period (the only exception is the end
> of the stream for the capture substream). Upon completion, the message
> is automatically re-added to the end of the queue.
> 
> When an I/O message is completed, the hw_ptr value is incremented
> unconditionally (to ensure that the hw_ptr always correctly reflects
> the state of the messages in the virtqueue). Due to its asynchronous
> nature, a message can be completed when the runtime structure no longer
> exists. For this reason, the values from this structure are cached in
> the virtio substream, which are required to calculate the new value of
> the hw_ptr.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
>  sound/virtio/Makefile         |   3 +-
>  sound/virtio/virtio_card.c    |  33 ++++
>  sound/virtio/virtio_card.h    |   9 +
>  sound/virtio/virtio_pcm.c     |   3 +
>  sound/virtio/virtio_pcm.h     |  31 ++++
>  sound/virtio/virtio_pcm_msg.c | 317 ++++++++++++++++++++++++++++++++++
>  6 files changed, 395 insertions(+), 1 deletion(-)
>  create mode 100644 sound/virtio/virtio_pcm_msg.c
> 
> diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
> index 69162a545a41..626af3cc3ed7 100644
> --- a/sound/virtio/Makefile
> +++ b/sound/virtio/Makefile
> @@ -5,5 +5,6 @@ obj-$(CONFIG_SND_VIRTIO) += virtio_snd.o
>  virtio_snd-objs := \
>  	virtio_card.o \
>  	virtio_ctl_msg.o \
> -	virtio_pcm.o
> +	virtio_pcm.o \
> +	virtio_pcm_msg.o
>  
> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 293d497f24e7..dc703fc662f5 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -145,6 +145,12 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
>  	callbacks[VIRTIO_SND_VQ_CONTROL] = virtsnd_ctl_notify_cb;
>  	callbacks[VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb;
>  
> +	virtio_cread(vdev, struct virtio_snd_config, streams, &n);
> +	if (n) {
> +		callbacks[VIRTIO_SND_VQ_TX] = virtsnd_pcm_tx_notify_cb;
> +		callbacks[VIRTIO_SND_VQ_RX] = virtsnd_pcm_rx_notify_cb;
> +	}
> +
>  	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
>  			     NULL);
>  	if (rc) {
> @@ -186,15 +192,42 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
>   * virtsnd_enable_vqs() - Enable the event, tx and rx virtqueues.
>   * @snd: VirtIO sound device.
>   *
> + * The tx queue is enabled only if the device supports playback stream(s).
> + *
> + * The rx queue is enabled only if the device supports capture stream(s).
> + *
>   * Context: Any context.
>   */
>  static void virtsnd_enable_vqs(struct virtio_snd *snd)
>  {
> +	struct virtio_device *vdev = snd->vdev;
>  	struct virtqueue *vqueue;
> +	struct virtio_pcm *pcm;
> +	unsigned int npbs = 0;
> +	unsigned int ncps = 0;
>  
>  	vqueue = snd->queues[VIRTIO_SND_VQ_EVENT].vqueue;
>  	if (!virtqueue_enable_cb(vqueue))
>  		virtsnd_event_notify_cb(vqueue);
> +
> +	list_for_each_entry(pcm, &snd->pcm_list, list) {
> +		npbs += pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].nsubstreams;
> +		ncps += pcm->streams[SNDRV_PCM_STREAM_CAPTURE].nsubstreams;
> +	}
> +
> +	if (npbs) {
> +		vqueue = snd->queues[VIRTIO_SND_VQ_TX].vqueue;
> +		if (!virtqueue_enable_cb(vqueue))
> +			dev_warn(&vdev->dev,
> +				 "suspicious notification in the TX queue\n");
> +	}
> +
> +	if (ncps) {
> +		vqueue = snd->queues[VIRTIO_SND_VQ_RX].vqueue;
> +		if (!virtqueue_enable_cb(vqueue))
> +			dev_warn(&vdev->dev,
> +				 "suspicious notification in the RX queue\n");
> +	}

Not sure how all this prevents use of same vq from multiple threads ...
And why are we sure there are no buffers yet?  If that is because
nothing yet happened, then I'd also like to point out that a vq starts
out with callbacks enabled, so you don't need to do that first thing ...



>  }
>  
>  /**
> diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
> index be6651a6aaf8..b11c09984882 100644
> --- a/sound/virtio/virtio_card.h
> +++ b/sound/virtio/virtio_card.h
> @@ -89,4 +89,13 @@ virtsnd_rx_queue(struct virtio_snd *snd)
>  	return &snd->queues[VIRTIO_SND_VQ_RX];
>  }
>  
> +static inline struct virtio_snd_queue *
> +virtsnd_pcm_queue(struct virtio_pcm_substream *substream)
> +{
> +	if (substream->direction == SNDRV_PCM_STREAM_PLAYBACK)
> +		return virtsnd_tx_queue(substream->snd);
> +	else
> +		return virtsnd_rx_queue(substream->snd);
> +}
> +
>  #endif /* VIRTIO_SND_CARD_H */
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index 036990b7b78a..1ab50dcc88c8 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -376,6 +376,7 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
>  
>  		substream->snd = snd;
>  		substream->sid = i;
> +		init_waitqueue_head(&substream->msg_empty);
>  
>  		rc = virtsnd_pcm_build_hw(substream, &info[i]);
>  		if (rc)
> @@ -530,6 +531,8 @@ void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *event)
>  		break;
>  	}
>  	case VIRTIO_SND_EVT_PCM_XRUN: {
> +		if (atomic_read(&substream->xfer_enabled))
> +			atomic_set(&substream->xfer_xrun, 1);
>  		break;
>  	}
>  	}
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 73fb4d9dc524..d011b7e1d18d 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -24,6 +24,7 @@
>  #include <sound/pcm.h>
>  
>  struct virtio_pcm;
> +struct virtio_pcm_msg;
>  
>  /**
>   * struct virtio_pcm_substream - VirtIO PCM substream.
> @@ -34,6 +35,16 @@ struct virtio_pcm;
>   * @features: Stream VirtIO feature bit map (1 << VIRTIO_SND_PCM_F_XXX).
>   * @substream: Kernel ALSA substream.
>   * @hw: Kernel ALSA substream hardware descriptor.
> + * @frame_bytes: Current frame size in bytes.
> + * @period_size: Current period size in frames.
> + * @buffer_size: Current buffer size in frames.
> + * @hw_ptr: Substream hardware pointer value in frames [0 ... buffer_size).
> + * @xfer_enabled: Data transfer state (0 - off, 1 - on).
> + * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
> + * @msgs: I/O messages.
> + * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
> + * @msg_count: Number of pending I/O messages in the virtqueue.
> + * @msg_empty: Notify when msg_count is zero.
>   */
>  struct virtio_pcm_substream {
>  	struct virtio_snd *snd;
> @@ -43,6 +54,16 @@ struct virtio_pcm_substream {
>  	u32 features;
>  	struct snd_pcm_substream *substream;
>  	struct snd_pcm_hardware hw;
> +	unsigned int frame_bytes;
> +	snd_pcm_uframes_t period_size;
> +	snd_pcm_uframes_t buffer_size;
> +	atomic_t hw_ptr;
> +	atomic_t xfer_enabled;
> +	atomic_t xfer_xrun;
> +	struct virtio_pcm_msg *msgs;
> +	int msg_last_enqueued;
> +	atomic_t msg_count;
> +	wait_queue_head_t msg_empty;
>  };
>  
>  /**
> @@ -86,4 +107,14 @@ struct virtio_pcm *virtsnd_pcm_find(struct virtio_snd *snd, unsigned int nid);
>  struct virtio_pcm *virtsnd_pcm_find_or_create(struct virtio_snd *snd,
>  					      unsigned int nid);
>  
> +struct virtio_snd_msg *
> +virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *substream,
> +			  unsigned int command, gfp_t gfp);
> +
> +int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *substream,
> +			  unsigned int nmsg, u8 *dma_area,
> +			  unsigned int period_bytes);
> +
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *substream);
> +
>  #endif /* VIRTIO_SND_PCM_H */
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> new file mode 100644
> index 000000000000..cfbe5935527a
> --- /dev/null
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sound card driver for virtio
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <sound/pcm_params.h>
> +
> +#include "virtio_card.h"
> +
> +/**
> + * enum pcm_msg_sg_index - Scatter-gather element indexes for an I/O message.
> + * @PCM_MSG_SG_XFER: Element containing a virtio_snd_pcm_xfer structure.
> + * @PCM_MSG_SG_DATA: Element containing a data buffer.
> + * @PCM_MSG_SG_STATUS: Element containing a virtio_snd_pcm_status structure.
> + * @PCM_MSG_SG_MAX: The maximum number of elements in the scatter-gather table.
> + *
> + * These values are used as the index of the payload scatter-gather table.
> + */
> +enum pcm_msg_sg_index {
> +	PCM_MSG_SG_XFER = 0,
> +	PCM_MSG_SG_DATA,
> +	PCM_MSG_SG_STATUS,
> +	PCM_MSG_SG_MAX
> +};
> +
> +/**
> + * struct virtio_pcm_msg - VirtIO I/O message.
> + * @substream: VirtIO PCM substream.
> + * @xfer: Request header payload.
> + * @status: Response header payload.
> + * @sgs: Payload scatter-gather table.
> + */
> +struct virtio_pcm_msg {
> +	struct virtio_pcm_substream *substream;
> +	struct virtio_snd_pcm_xfer xfer;
> +	struct virtio_snd_pcm_status status;
> +	struct scatterlist sgs[PCM_MSG_SG_MAX];
> +};
> +
> +/**
> + * virtsnd_pcm_msg_alloc() - Allocate I/O messages.
> + * @substream: VirtIO PCM substream.
> + * @nmsg: Number of messages (equal to the number of periods).
> + * @dma_area: Pointer to used audio buffer.
> + * @period_bytes: Period (message payload) size.
> + *
> + * The function slices the buffer into nmsg parts (each with the size of
> + * period_bytes), and creates nmsg corresponding I/O messages.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -ENOMEM on failure.
> + */
> +int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *substream,
> +			  unsigned int nmsg, u8 *dma_area,
> +			  unsigned int period_bytes)
> +{
> +	struct virtio_device *vdev = substream->snd->vdev;
> +	unsigned int i;
> +
> +	if (substream->msgs)
> +		devm_kfree(&vdev->dev, substream->msgs);
> +
> +	substream->msgs = devm_kcalloc(&vdev->dev, nmsg,
> +				       sizeof(*substream->msgs), GFP_KERNEL);
> +	if (!substream->msgs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nmsg; ++i) {
> +		struct virtio_pcm_msg *msg = &substream->msgs[i];
> +
> +		msg->substream = substream;
> +
> +		sg_init_table(msg->sgs, PCM_MSG_SG_MAX);
> +		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
> +			    sizeof(msg->xfer));
> +		sg_init_one(&msg->sgs[PCM_MSG_SG_DATA],
> +			    dma_area + period_bytes * i, period_bytes);
> +		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
> +			    sizeof(msg->status));
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
> + * @substream: VirtIO PCM substream.
> + *
> + * All messages are organized in an ordered circular list. Each time the
> + * function is called, all currently non-enqueued messages are added to the
> + * virtqueue. For this, the function keeps track of two values:
> + *
> + *   msg_last_enqueued = index of the last enqueued message,
> + *   msg_count = # of pending messages in the virtqueue.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -EIO on failure.
> + */
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->substream->runtime;
> +	struct virtio_snd *snd = substream->snd;
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtqueue *vqueue = virtsnd_pcm_queue(substream)->vqueue;
> +	int i;
> +	int n;
> +	bool notify = false;
> +
> +	if (!vqueue)
> +		return -EIO;
> +
> +	i = (substream->msg_last_enqueued + 1) % runtime->periods;
> +	n = runtime->periods - atomic_read(&substream->msg_count);
> +
> +	for (; n; --n, i = (i + 1) % runtime->periods) {
> +		struct virtio_pcm_msg *msg = &substream->msgs[i];
> +		struct scatterlist *psgs[PCM_MSG_SG_MAX] = {
> +			[PCM_MSG_SG_XFER] = &msg->sgs[PCM_MSG_SG_XFER],
> +			[PCM_MSG_SG_DATA] = &msg->sgs[PCM_MSG_SG_DATA],
> +			[PCM_MSG_SG_STATUS] = &msg->sgs[PCM_MSG_SG_STATUS]
> +		};
> +		int rc;
> +
> +		msg->xfer.stream_id = cpu_to_virtio32(vdev, substream->sid);
> +		memset(&msg->status, 0, sizeof(msg->status));
> +
> +		atomic_inc(&substream->msg_count);
> +
> +		if (substream->direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> +					       GFP_ATOMIC);
> +		else
> +			rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> +					       GFP_ATOMIC);
> +
> +		if (rc) {
> +			atomic_dec(&substream->msg_count);
> +			return -EIO;
> +		}
> +
> +		substream->msg_last_enqueued = i;
> +	}
> +
> +	if (!(substream->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
> +		notify = virtqueue_kick_prepare(vqueue);
> +
> +	if (notify)
> +		if (!virtqueue_notify(vqueue))
> +			return -EIO;
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_msg_complete() - Complete an I/O message.
> + * @msg: I/O message.
> + * @size: Number of bytes written.
> + *
> + * Completion of the message means the elapsed period:
> + *   - update hardware pointer,
> + *   - update latency value,
> + *   - kick the upper layer.
> + *
> + * Context: Interrupt context.
> + */
> +static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg, size_t size)
> +{
> +	struct virtio_pcm_substream *substream = msg->substream;
> +	snd_pcm_uframes_t hw_ptr;
> +	unsigned int msg_count;
> +
> +	hw_ptr = (snd_pcm_uframes_t)atomic_read(&substream->hw_ptr);
> +
> +	/*
> +	 * If the capture substream returned an incorrect status, then just
> +	 * increase the hw_ptr by the period size.
> +	 */
> +	if (substream->direction == SNDRV_PCM_STREAM_PLAYBACK ||
> +	    size <= sizeof(msg->status)) {
> +		hw_ptr += substream->period_size;
> +	} else {
> +		size -= sizeof(msg->status);
> +		hw_ptr += size / substream->frame_bytes;
> +	}
> +
> +	atomic_set(&substream->hw_ptr, (u32)(hw_ptr % substream->buffer_size));
> +	atomic_set(&substream->xfer_xrun, 0);
> +
> +	msg_count = atomic_dec_return(&substream->msg_count);
> +
> +	if (atomic_read(&substream->xfer_enabled)) {
> +		struct snd_pcm_runtime *runtime = substream->substream->runtime;
> +
> +		runtime->delay =
> +			bytes_to_frames(runtime,
> +					le32_to_cpu(msg->status.latency_bytes));
> +
> +		snd_pcm_period_elapsed(substream->substream);
> +
> +		virtsnd_pcm_msg_send(substream);
> +	} else if (!msg_count) {
> +		wake_up_all(&substream->msg_empty);
> +	}
> +}
> +
> +/**
> + * virtsnd_pcm_notify_cb() - Process all completed I/O messages.
> + * @vqueue: Underlying tx/rx virtqueue.
> + *
> + * If transmission is allowed, then each completed message is immediately placed
> + * back at the end of the queue.
> + *
> + * Context: Interrupt context. Takes and releases the tx/rx queue spinlock.
> + */
> +static inline void virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	while (queue->vqueue) {
> +		virtqueue_disable_cb(queue->vqueue);
> +
> +		for (;;) {
> +			struct virtio_pcm_msg *msg;
> +			u32 length;
> +
> +			msg = virtqueue_get_buf(queue->vqueue, &length);
> +			if (!msg)
> +				break;
> +
> +			virtsnd_pcm_msg_complete(msg, length);
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
> + * virtsnd_pcm_tx_notify_cb() - Process all completed TX messages.
> + * @vqueue: Underlying tx virtqueue.
> + *
> + * Context: Interrupt context.
> + */
> +void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue)
> +{
> +	struct virtio_snd *snd = vqueue->vdev->priv;
> +
> +	virtsnd_pcm_notify_cb(virtsnd_tx_queue(snd));
> +}
> +
> +/**
> + * virtsnd_pcm_rx_notify_cb() - Process all completed RX messages.
> + * @vqueue: Underlying rx virtqueue.
> + *
> + * Context: Interrupt context.
> + */
> +void virtsnd_pcm_rx_notify_cb(struct virtqueue *vqueue)
> +{
> +	struct virtio_snd *snd = vqueue->vdev->priv;
> +
> +	virtsnd_pcm_notify_cb(virtsnd_rx_queue(snd));
> +}
> +
> +/**
> + * virtsnd_pcm_ctl_msg_alloc() - Allocate and initialize the PCM device control
> + *                               message for the specified substream.
> + * @substream: VirtIO PCM substream.
> + * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
> + * @gfp: Kernel flags for memory allocation.
> + *
> + * Context: Any context. May sleep if @gfp flags permit.
> + * Return: Allocated message on success, ERR_PTR(-errno) on failure.
> + */
> +struct virtio_snd_msg *
> +virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *substream,
> +			  unsigned int command, gfp_t gfp)
> +{
> +	struct virtio_device *vdev = substream->snd->vdev;
> +	size_t request_size = sizeof(struct virtio_snd_pcm_hdr);
> +	size_t response_size = sizeof(struct virtio_snd_hdr);
> +	struct virtio_snd_msg *msg;
> +
> +	switch (command) {
> +	case VIRTIO_SND_R_PCM_SET_PARAMS: {
> +		request_size = sizeof(struct virtio_snd_pcm_set_params);
> +		break;
> +	}
> +	}
> +
> +	msg = virtsnd_ctl_msg_alloc(vdev, request_size, response_size, gfp);
> +	if (!IS_ERR(msg)) {
> +		struct virtio_snd_pcm_hdr *hdr = sg_virt(&msg->sg_request);
> +
> +		hdr->hdr.code = cpu_to_virtio32(vdev, command);
> +		hdr->stream_id = cpu_to_virtio32(vdev, substream->sid);
> +	}
> +
> +	return msg;
> +}
> -- 
> 2.30.0
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

