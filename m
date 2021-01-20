Return-Path: virtio-dev-return-7937-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B473198605D
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jan 2021 08:36:50 +0000 (UTC)
Date: Wed, 20 Jan 2021 03:36:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210120033334-mutt-send-email-mst@kernel.org>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <20210120003638.3339987-6-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20210120003638.3339987-6-anton.yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH 5/7] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 20, 2021 at 01:36:33AM +0100, Anton Yakovlev wrote:
> Introduce the operators required for the operation of substreams.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
>  sound/virtio/Makefile         |   3 +-
>  sound/virtio/virtio_pcm.c     |   5 +-
>  sound/virtio/virtio_pcm.h     |   2 +
>  sound/virtio/virtio_pcm_ops.c | 509 ++++++++++++++++++++++++++++++++++
>  4 files changed, 517 insertions(+), 2 deletions(-)
>  create mode 100644 sound/virtio/virtio_pcm_ops.c
> 
> diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
> index 626af3cc3ed7..34493226793f 100644
> --- a/sound/virtio/Makefile
> +++ b/sound/virtio/Makefile
> @@ -6,5 +6,6 @@ virtio_snd-objs := \
>  	virtio_card.o \
>  	virtio_ctl_msg.o \
>  	virtio_pcm.o \
> -	virtio_pcm_msg.o
> +	virtio_pcm_msg.o \
> +	virtio_pcm_ops.o
>  
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index 1ab50dcc88c8..6a1ca6b2c3ca 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -121,7 +121,8 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *substream,
>  		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_BATCH |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> -		SNDRV_PCM_INFO_INTERLEAVED;
> +		SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_PAUSE;
>  
>  	if (!info->channels_min || info->channels_min > info->channels_max) {
>  		dev_err(&vdev->dev,
> @@ -503,6 +504,8 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>  				if (rc)
>  					return rc;
>  			}
> +
> +			snd_pcm_set_ops(pcm->pcm, i, &virtsnd_pcm_ops);
>  		}
>  
>  	return 0;
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index d011b7e1d18d..fe467bc05d8b 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -90,6 +90,8 @@ struct virtio_pcm {
>  	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
>  };
>  
> +extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +
>  int virtsnd_pcm_validate(struct virtio_device *vdev);
>  
>  int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> new file mode 100644
> index 000000000000..8d26c1144ad6
> --- /dev/null
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -0,0 +1,509 @@
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
> +/*
> + * Our main concern here is maintaining the correct state of the underlying I/O
> + * virtqueues. Thus, operators are implemented to support all of the following
> + * possible control paths (excluding all trivial ones):
> + *
> + *                        +---------+
> + *                        | open()  |<------------------+
> + *                        +----+----+                   |
> + *                             v                        |
> + *                      +------+------+                 |
> + *       +------------->| hw_params() |<-------------+  |
> + *       |              +-------------+              |  |
> + *       |                     v                     |  |
> + *       |               +-----------+               |  |
> + *       |               | prepare() |<-----------+  |  |
> + *       |               +-----------+            |  |  |
> + *       |                     v                  |  |  |
> + *       |        +-------------------------+     |  |  |
> + * +-----------+  | trigger(START/          |     |  |  |
> + * | restore() |  |         PAUSE_RELEASE/  |<-+  |  |  |
> + * +-----------+  |         RESUME)         |  |  |  |  |
> + *       ^        +-------------------------+  |  |  |  |
> + *       |                     v               |  |  |  |
> + *       |               +-----------+         |  |  |  |
> + *       |               | pointer() |         |  |  |  |
> + *       |               +-----------+         |  |  |  |
> + *       |                     v               |  |  |  |
> + *       |          +---------------------+    |  |  |  |
> + * +-----------+    | trigger(STOP/       |----+  |  |  |
> + * | freeze()  |<---|         PAUSE_PUSH/ |-------+  |  |
> + * +-----------+    |         SUSPEND)    |          |  |
> + *                  +---------------------+          |  |
> + *                             v                     |  |
> + *                       +-----------+               |  |
> + *                       | hw_free() |---------------+  |
> + *                       +-----------+                  |
> + *                             v                        |
> + *                        +---------+                   |
> + *                        | close() |-------------------+
> + *                        +---------+
> + */
> +
> +/* Map for converting ALSA format to VirtIO format. */
> +struct virtsnd_a2v_format {
> +	unsigned int alsa_bit;
> +	unsigned int vio_bit;
> +};
> +
> +static const struct virtsnd_a2v_format g_a2v_format_map[] = {
> +	{ SNDRV_PCM_FORMAT_IMA_ADPCM, VIRTIO_SND_PCM_FMT_IMA_ADPCM },
> +	{ SNDRV_PCM_FORMAT_MU_LAW, VIRTIO_SND_PCM_FMT_MU_LAW },
> +	{ SNDRV_PCM_FORMAT_A_LAW, VIRTIO_SND_PCM_FMT_A_LAW },
> +	{ SNDRV_PCM_FORMAT_S8, VIRTIO_SND_PCM_FMT_S8 },
> +	{ SNDRV_PCM_FORMAT_U8, VIRTIO_SND_PCM_FMT_U8 },
> +	{ SNDRV_PCM_FORMAT_S16_LE, VIRTIO_SND_PCM_FMT_S16 },
> +	{ SNDRV_PCM_FORMAT_U16_LE, VIRTIO_SND_PCM_FMT_U16 },
> +	{ SNDRV_PCM_FORMAT_S18_3LE, VIRTIO_SND_PCM_FMT_S18_3 },
> +	{ SNDRV_PCM_FORMAT_U18_3LE, VIRTIO_SND_PCM_FMT_U18_3 },
> +	{ SNDRV_PCM_FORMAT_S20_3LE, VIRTIO_SND_PCM_FMT_S20_3 },
> +	{ SNDRV_PCM_FORMAT_U20_3LE, VIRTIO_SND_PCM_FMT_U20_3 },
> +	{ SNDRV_PCM_FORMAT_S24_3LE, VIRTIO_SND_PCM_FMT_S24_3 },
> +	{ SNDRV_PCM_FORMAT_U24_3LE, VIRTIO_SND_PCM_FMT_U24_3 },
> +	{ SNDRV_PCM_FORMAT_S20_LE, VIRTIO_SND_PCM_FMT_S20 },
> +	{ SNDRV_PCM_FORMAT_U20_LE, VIRTIO_SND_PCM_FMT_U20 },
> +	{ SNDRV_PCM_FORMAT_S24_LE, VIRTIO_SND_PCM_FMT_S24 },
> +	{ SNDRV_PCM_FORMAT_U24_LE, VIRTIO_SND_PCM_FMT_U24 },
> +	{ SNDRV_PCM_FORMAT_S32_LE, VIRTIO_SND_PCM_FMT_S32 },
> +	{ SNDRV_PCM_FORMAT_U32_LE, VIRTIO_SND_PCM_FMT_U32 },
> +	{ SNDRV_PCM_FORMAT_FLOAT_LE, VIRTIO_SND_PCM_FMT_FLOAT },
> +	{ SNDRV_PCM_FORMAT_FLOAT64_LE, VIRTIO_SND_PCM_FMT_FLOAT64 },
> +	{ SNDRV_PCM_FORMAT_DSD_U8, VIRTIO_SND_PCM_FMT_DSD_U8 },
> +	{ SNDRV_PCM_FORMAT_DSD_U16_LE, VIRTIO_SND_PCM_FMT_DSD_U16 },
> +	{ SNDRV_PCM_FORMAT_DSD_U32_LE, VIRTIO_SND_PCM_FMT_DSD_U32 },
> +	{ SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE,
> +	  VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME }
> +};
> +
> +/* Map for converting ALSA frame rate to VirtIO frame rate. */
> +struct virtsnd_a2v_rate {
> +	unsigned int rate;
> +	unsigned int vio_bit;
> +};
> +
> +static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
> +	{ 5512, VIRTIO_SND_PCM_RATE_5512 },
> +	{ 8000, VIRTIO_SND_PCM_RATE_8000 },
> +	{ 11025, VIRTIO_SND_PCM_RATE_11025 },
> +	{ 16000, VIRTIO_SND_PCM_RATE_16000 },
> +	{ 22050, VIRTIO_SND_PCM_RATE_22050 },
> +	{ 32000, VIRTIO_SND_PCM_RATE_32000 },
> +	{ 44100, VIRTIO_SND_PCM_RATE_44100 },
> +	{ 48000, VIRTIO_SND_PCM_RATE_48000 },
> +	{ 64000, VIRTIO_SND_PCM_RATE_64000 },
> +	{ 88200, VIRTIO_SND_PCM_RATE_88200 },
> +	{ 96000, VIRTIO_SND_PCM_RATE_96000 },
> +	{ 176400, VIRTIO_SND_PCM_RATE_176400 },
> +	{ 192000, VIRTIO_SND_PCM_RATE_192000 }
> +};
> +
> +/**
> + * virtsnd_pcm_release() - Release the PCM substream on the device side.
> + * @substream: VirtIO substream.
> + *
> + * The function waits for all pending I/O messages to complete.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream *substream)
> +{
> +	return atomic_read(&substream->msg_count) == 0;

All this use of atomic_read/atomic_set all over the place makes me pause.
Could you add documentation explaining the use rules for these atomic fields?

> +}
> +
> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
> +{
> +	struct virtio_snd *snd = substream->snd;
> +	struct virtio_snd_msg *msg;
> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
> +	int rc;
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	rc = virtsnd_ctl_msg_send_sync(snd, msg);
> +	if (rc)
> +		return rc;
> +
> +	return wait_event_interruptible_timeout(substream->msg_empty,
> +						virtsnd_pcm_released(substream),
> +						js);
> +}
> +
> +/**
> + * virtsnd_pcm_open() - Open the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm *pcm = snd_pcm_substream_chip(substream);
> +	struct virtio_pcm_substream *ss = NULL;
> +
> +	if (pcm) {
> +		switch (substream->stream) {
> +		case SNDRV_PCM_STREAM_PLAYBACK:
> +		case SNDRV_PCM_STREAM_CAPTURE: {
> +			struct virtio_pcm_stream *stream =
> +				&pcm->streams[substream->stream];
> +
> +			if (substream->number < stream->nsubstreams)
> +				ss = stream->substreams[substream->number];
> +			break;
> +		}
> +		}
> +	}
> +
> +	if (!ss)
> +		return -EBADFD;
> +
> +	substream->runtime->hw = ss->hw;
> +	substream->private_data = ss;
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_close() - Close the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Any context.
> + * Return: 0.
> + */
> +static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_params() - Set the parameters of the PCM substream.
> + * @substream: Kernel ALSA substream.
> + * @hw_params: Hardware parameters (can be NULL).
> + *
> + * The function can be called both from the upper level (in this case,
> + * @hw_params is not NULL) or from the driver itself (in this case, @hw_params
> + * is NULL, and the parameter values are taken from the runtime structure).
> + *
> + * In all cases, the function:
> + *   1. checks the state of the virtqueue and, if necessary, tries to fix it,
> + *   2. sets the parameters on the device side,
> + *   3. allocates a hardware buffer and I/O messages.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *hw_params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_device *vdev = ss->snd->vdev;
> +	struct virtio_snd_msg *msg;
> +	struct virtio_snd_pcm_set_params *request;
> +	snd_pcm_format_t format;
> +	unsigned int channels;
> +	unsigned int rate;
> +	unsigned int buffer_bytes;
> +	unsigned int period_bytes;
> +	unsigned int periods;
> +	unsigned int i;
> +	int vformat = -1;
> +	int vrate = -1;
> +	int rc;
> +
> +	/*
> +	 * If we got here after ops->trigger() was called, the queue may
> +	 * still contain messages. In this case, we need to release the
> +	 * substream first.
> +	 */
> +	if (atomic_read(&ss->msg_count)) {
> +		rc = virtsnd_pcm_release(ss);
> +		if (rc) {
> +			dev_err(&vdev->dev,
> +				"SID %u: invalid I/O queue state\n",
> +				ss->sid);
> +			return rc;
> +		}
> +	}
> +
> +	/* Set hardware parameters in device */
> +	if (hw_params) {
> +		format = params_format(hw_params);
> +		channels = params_channels(hw_params);
> +		rate = params_rate(hw_params);
> +		buffer_bytes = params_buffer_bytes(hw_params);
> +		period_bytes = params_period_bytes(hw_params);
> +		periods = params_periods(hw_params);
> +	} else {
> +		format = runtime->format;
> +		channels = runtime->channels;
> +		rate = runtime->rate;
> +		buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
> +		period_bytes = frames_to_bytes(runtime, runtime->period_size);
> +		periods = runtime->periods;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(g_a2v_format_map); ++i)
> +		if (g_a2v_format_map[i].alsa_bit == format) {
> +			vformat = g_a2v_format_map[i].vio_bit;
> +
> +			break;
> +		}
> +
> +	for (i = 0; i < ARRAY_SIZE(g_a2v_rate_map); ++i)
> +		if (g_a2v_rate_map[i].rate == rate) {
> +			vrate = g_a2v_rate_map[i].vio_bit;
> +
> +			break;
> +		}
> +
> +	if (vformat == -1 || vrate == -1)
> +		return -EINVAL;
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_SET_PARAMS,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	request = sg_virt(&msg->sg_request);
> +
> +	request->buffer_bytes = cpu_to_virtio32(vdev, buffer_bytes);
> +	request->period_bytes = cpu_to_virtio32(vdev, period_bytes);
> +	request->channels = channels;
> +	request->format = vformat;
> +	request->rate = vrate;
> +
> +	if (ss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING))
> +		request->features |=
> +			cpu_to_virtio32(vdev,
> +					1U << VIRTIO_SND_PCM_F_MSG_POLLING);
> +
> +	if (ss->features & (1U << VIRTIO_SND_PCM_F_EVT_XRUNS))
> +		request->features |=
> +			cpu_to_virtio32(vdev,
> +					1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
> +
> +	rc = virtsnd_ctl_msg_send_sync(ss->snd, msg);
> +	if (rc)
> +		return rc;
> +
> +	/* If the buffer was already allocated earlier, do nothing. */
> +	if (runtime->dma_area)
> +		return 0;
> +
> +	/* Allocate hardware buffer */
> +	rc = snd_pcm_lib_malloc_pages(substream, buffer_bytes);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Allocate and initialize I/O messages */
> +	rc = virtsnd_pcm_msg_alloc(ss, periods, runtime->dma_area,
> +				   period_bytes);
> +	if (rc)
> +		snd_pcm_lib_free_pages(substream);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_free() - Reset the parameters of the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * The function does the following:
> + *   1. tries to release the PCM substream on the device side,
> + *   2. frees the hardware buffer.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	int rc;
> +
> +	rc = virtsnd_pcm_release(ss);
> +
> +	/*
> +	 * Even if we failed to send the RELEASE message or wait for the queue
> +	 * flush to complete, we can safely delete the buffer. Because after
> +	 * receiving the STOP command, the device must stop all I/O message
> +	 * processing. If there are still pending messages in the queue, the
> +	 * next ops->hw_params() call should deal with this.
> +	 */
> +	snd_pcm_lib_free_pages(substream);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_params() - Prepare the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * The function can be called both from the upper level or from the driver
> + * itself.
> + *
> + * In all cases, the function:
> + *   1. checks the state of the virtqueue and, if necessary, tries to fix it,
> + *   2. prepares the substream on the device side.
> + *
> + * Context: Any context that permits to sleep. May take and release the tx/rx
> + *          queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
> +	struct virtio_snd_msg *msg;
> +	unsigned long flags;
> +	int rc;
> +
> +	/*
> +	 * If we got here after ops->trigger() was called, the queue may
> +	 * still contain messages. In this case, we need to reset the
> +	 * substream first.
> +	 */
> +	if (atomic_read(&ss->msg_count)) {
> +		rc = virtsnd_pcm_hw_params(substream, NULL);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	ss->msg_last_enqueued = -1;
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	/*
> +	 * Since I/O messages are asynchronous, they can be completed
> +	 * when the runtime structure no longer exists. Since each
> +	 * completion implies incrementing the hw_ptr, we cache all the
> +	 * current values needed to compute the new hw_ptr value.
> +	 */
> +	ss->frame_bytes = substream->runtime->frame_bits >> 3;
> +	ss->period_size = substream->runtime->period_size;
> +	ss->buffer_size = substream->runtime->buffer_size;
> +
> +	atomic_set(&ss->hw_ptr, 0);
> +	atomic_set(&ss->xfer_xrun, 0);
> +	atomic_set(&ss->msg_count, 0);
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_PREPARE,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	return virtsnd_ctl_msg_send_sync(ss->snd, msg);
> +}
> +
> +/**
> + * virtsnd_pcm_trigger() - Process command for the PCM substream.
> + * @substream: Kernel ALSA substream.
> + * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
> + *
> + * Depending on the command, the function does the following:
> + *   1. enables/disables data transmission,
> + *   2. starts/stops the substream on the device side.
> + *
> + * Context: Atomic context. May take and release the tx/rx queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_snd *snd = ss->snd;
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
> +	struct virtio_snd_msg *msg;
> +
> +	switch (command) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
> +		int rc;
> +
> +		spin_lock(&queue->lock);
> +		rc = virtsnd_pcm_msg_send(ss);
> +		spin_unlock(&queue->lock);
> +		if (rc)
> +			return rc;
> +
> +		atomic_set(&ss->xfer_enabled, 1);
> +
> +		msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_START,
> +						GFP_ATOMIC);
> +		if (IS_ERR(msg))
> +			return PTR_ERR(msg);
> +
> +		return virtsnd_ctl_msg_send(snd, msg);
> +	}
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
> +		atomic_set(&ss->xfer_enabled, 0);
> +
> +		msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
> +						GFP_ATOMIC);
> +		if (IS_ERR(msg))
> +			return PTR_ERR(msg);
> +
> +		return virtsnd_ctl_msg_send(snd, msg);
> +	}
> +	default: {
> +		return -EINVAL;
> +	}
> +	}
> +}
> +
> +/**
> + * virtsnd_pcm_pointer() - Get the current hardware position for the PCM
> + *                         substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Atomic context.
> + * Return: Hardware position in frames inside [0 ... buffer_size) range.
> + */
> +static snd_pcm_uframes_t
> +virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +
> +	if (atomic_read(&ss->xfer_xrun))
> +		return SNDRV_PCM_POS_XRUN;
> +
> +	return (snd_pcm_uframes_t)atomic_read(&ss->hw_ptr);
> +}
> +
> +/* PCM substream operators map. */
> +const struct snd_pcm_ops virtsnd_pcm_ops = {
> +	.open = virtsnd_pcm_open,
> +	.close = virtsnd_pcm_close,
> +	.ioctl = snd_pcm_lib_ioctl,
> +	.hw_params = virtsnd_pcm_hw_params,
> +	.hw_free = virtsnd_pcm_hw_free,
> +	.prepare = virtsnd_pcm_prepare,
> +	.trigger = virtsnd_pcm_trigger,
> +	.pointer = virtsnd_pcm_pointer,
> +};
> -- 
> 2.30.0
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

