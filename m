Return-Path: virtio-dev-return-7971-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D80A79865DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Feb 2021 23:21:35 +0000 (UTC)
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-7-anton.yakovlev@opensynergy.com>
 <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <e2d54587-41ce-1cf9-df96-8e1baa85c097@opensynergy.com>
Date: Tue, 2 Feb 2021 00:21:31 +0100
MIME-Version: 1.0
In-Reply-To: <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
Subject: [virtio-dev] Re: [PATCH v2 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 25.01.2021 17:59, Guennadi Liakhovetski wrote:
 > On Sun, 24 Jan 2021, Anton Yakovlev wrote:
 >
 > [snip]
 >
 >> +/**
 >> + * virtsnd_pcm_release() - Release the PCM substream on the device 
side.
 >> + * @substream: VirtIO substream.
 >> + *
 >> + * Context: Any context that permits to sleep.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream
 >> *substream)
 >> +{
 >> +     /*
 >> +      * The spec states that upon receipt of the RELEASE command "the
 >> device
 >> +      * MUST complete all pending I/O messages for the specified
 >> stream ID".
 >> +      * Thus, we consider the absence of I/O messages in the queue 
as an
 >> +      * indication that the substream has been released.
 >> +      */
 >> +     return atomic_read(&substream->msg_count) == 0;
 >
 > Also here having it atomic doesn't really seem to help. This just means,
 > that at some point of time it was == 0.

Technically, you're right. In practice, everything looks like this:

I/O messages are added to the virtqueue either at the start of the
substream or in the interrupt handler (and only as long as .xfer_enabled
is true). In general, this means that the .msg_count can only be
incremented in the interrupt handler. As soon as the substream stops,
the .xfer_enabled becomes false and the .msg_count no longer increases.
This means that the .msg_count was either already 0, or we need to wait
for it to become 0.


 >> +}
 >> +
 >> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
 >
 > kernel-doc missing

Yeap, thanks!


 >> +{
 >> +     struct virtio_snd *snd = substream->snd;
 >> +     struct virtio_snd_msg *msg;
 >> +     unsigned int js = msecs_to_jiffies(msg_timeout_ms);
 >> +     int rc;
 >> +
 >> +     msg = virtsnd_pcm_ctl_msg_alloc(substream,
 >> VIRTIO_SND_R_PCM_RELEASE,
 >> +                                     GFP_KERNEL);
 >> +     if (IS_ERR(msg))
 >> +             return PTR_ERR(msg);
 >> +
 >> +     rc = virtsnd_ctl_msg_send_sync(snd, msg);
 >> +     if (rc)
 >> +             return rc;
 >> +
 >> +     return wait_event_interruptible_timeout(substream->msg_empty,
 >> +
 >> virtsnd_pcm_released(substream),
 >> +                                             js);
 >
 > wait_event_interruptible_timeout() will return a positive number in
 > success cases, 0 means a timeout and condition still false. Whereas when
 > you call this function you interpret 0 as success and you expect any != 0
 > to be a negative error. Wondering how this worked during your tests?

Yeah, that's actually a bug. We haven't hit a timeout on that control path.


 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_open() - Open the PCM substream.
 >> + * @substream: Kernel ALSA substream.
 >> + *
 >> + * Context: Any context.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 >> +{
 >> +     struct virtio_pcm *pcm = snd_pcm_substream_chip(substream);
 >> +     struct virtio_pcm_substream *ss = NULL;
 >> +
 >> +     if (pcm) {
 >> +             switch (substream->stream) {
 >> +             case SNDRV_PCM_STREAM_PLAYBACK:
 >> +             case SNDRV_PCM_STREAM_CAPTURE: {
 >> +                     struct virtio_pcm_stream *stream =
 >> +                             &pcm->streams[substream->stream];
 >> +
 >> +                     if (substream->number < stream->nsubstreams)
 >
 > Can this condition ever be false?

Hard to tell. But there may be some bug. In general, I try to adhere to
the rule that if an array element is referenced by index, it is better
to check the index value first.


 >> +                             ss = 
stream->substreams[substream->number];
 >> +                     break;
 >> +             }
 >> +             }
 >> +     }
 >> +
 >> +     if (!ss)
 >> +             return -EBADFD;
 >> +
 >> +     substream->runtime->hw = ss->hw;
 >> +     substream->private_data = ss;
 >> +
 >> +     return 0;
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_close() - Close the PCM substream.
 >> + * @substream: Kernel ALSA substream.
 >> + *
 >> + * Context: Any context.
 >> + * Return: 0.
 >> + */
 >> +static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
 >> +{
 >> +     return 0;
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_hw_params() - Set the parameters of the PCM substream.
 >> + * @substream: Kernel ALSA substream.
 >> + * @hw_params: Hardware parameters (can be NULL).
 >> + *
 >> + * The function can be called both from the upper level (in this case,
 >> + * @hw_params is not NULL) or from the driver itself (in this case,
 >> @hw_params
 >> + * is NULL, and the parameter values are taken from the runtime
 >> structure).
 >> + *
 >> + * In all cases, the function:
 >> + *   1. checks the state of the virtqueue and, if necessary, tries to
 >> fix it,
 >> + *   2. sets the parameters on the device side,
 >> + *   3. allocates a hardware buffer and I/O messages.
 >> + *
 >> + * Context: Any context that permits to sleep.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 >> +                              struct snd_pcm_hw_params *hw_params)
 >> +{
 >> +     struct snd_pcm_runtime *runtime = substream->runtime;
 >> +     struct virtio_pcm_substream *ss =
 >> snd_pcm_substream_chip(substream);
 >> +     struct virtio_device *vdev = ss->snd->vdev;
 >> +     struct virtio_snd_msg *msg;
 >> +     struct virtio_snd_pcm_set_params *request;
 >> +     snd_pcm_format_t format;
 >> +     unsigned int channels;
 >> +     unsigned int rate;
 >> +     unsigned int buffer_bytes;
 >> +     unsigned int period_bytes;
 >> +     unsigned int periods;
 >> +     unsigned int i;
 >> +     int vformat = -1;
 >> +     int vrate = -1;
 >> +     int rc;
 >> +
 >> +     /*
 >> +      * If we got here after ops->trigger() was called, the queue may
 >> +      * still contain messages. In this case, we need to release the
 >> +      * substream first.
 >> +      */
 >> +     if (atomic_read(&ss->msg_count)) {
 >> +             rc = virtsnd_pcm_release(ss);
 >> +             if (rc) {
 >> +                     dev_err(&vdev->dev,
 >> +                             "SID %u: invalid I/O queue state\n",
 >> +                             ss->sid);
 >> +                     return rc;
 >> +             }
 >> +     }
 >> +
 >> +     /* Set hardware parameters in device */
 >> +     if (hw_params) {
 >> +             format = params_format(hw_params);
 >> +             channels = params_channels(hw_params);
 >> +             rate = params_rate(hw_params);
 >> +             buffer_bytes = params_buffer_bytes(hw_params);
 >> +             period_bytes = params_period_bytes(hw_params);
 >> +             periods = params_periods(hw_params);
 >> +     } else {
 >> +             format = runtime->format;
 >> +             channels = runtime->channels;
 >> +             rate = runtime->rate;
 >> +             buffer_bytes = frames_to_bytes(runtime,
 >> runtime->buffer_size);
 >> +             period_bytes = frames_to_bytes(runtime,
 >> runtime->period_size);
 >> +             periods = runtime->periods;
 >> +     }
 >> +
 >> +     for (i = 0; i < ARRAY_SIZE(g_a2v_format_map); ++i)
 >> +             if (g_a2v_format_map[i].alsa_bit == format) {
 >> +                     vformat = g_a2v_format_map[i].vio_bit;
 >> +
 >> +                     break;
 >> +             }
 >> +
 >> +     for (i = 0; i < ARRAY_SIZE(g_a2v_rate_map); ++i)
 >> +             if (g_a2v_rate_map[i].rate == rate) {
 >> +                     vrate = g_a2v_rate_map[i].vio_bit;
 >> +
 >> +                     break;
 >> +             }
 >> +
 >> +     if (vformat == -1 || vrate == -1)
 >> +             return -EINVAL;
 >> +
 >> +     msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_SET_PARAMS,
 >> +                                     GFP_KERNEL);
 >> +     if (IS_ERR(msg))
 >> +             return PTR_ERR(msg);
 >> +
 >> +     request = sg_virt(&msg->sg_request);
 >> +
 >> +     request->buffer_bytes = cpu_to_virtio32(vdev, buffer_bytes);
 >> +     request->period_bytes = cpu_to_virtio32(vdev, period_bytes);
 >> +     request->channels = channels;
 >> +     request->format = vformat;
 >> +     request->rate = vrate;
 >
 > I presume the latter three fields don't have to be endienness-converted,
 > perhaps they're 8-bit wide only.

Yes, these three values are u8.


 >> +
 >> +     if (ss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING))
 >> +             request->features |=
 >> +                     cpu_to_virtio32(vdev,
 >> +                                     1U <<
 >> VIRTIO_SND_PCM_F_MSG_POLLING);
 >> +
 >> +     if (ss->features & (1U << VIRTIO_SND_PCM_F_EVT_XRUNS))
 >> +             request->features |=
 >> +                     cpu_to_virtio32(vdev,
 >> +                                     1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
 >> +
 >> +     rc = virtsnd_ctl_msg_send_sync(ss->snd, msg);
 >
 > Wouldn't it be better to only try to send the message after below
 > allocations completed successfully?

I thought the reverse logic was better. This message asks the device to
set a specific set of parameters. And if the device returned an error
for some reason, then there is no point in allocating memory.


 >> +     if (rc)
 >> +             return rc;
 >> +
 >> +     /* If the buffer was already allocated earlier, do nothing. */
 >> +     if (runtime->dma_area)
 >> +             return 0;
 >> +
 >> +     /* Allocate hardware buffer */
 >> +     rc = snd_pcm_lib_malloc_pages(substream, buffer_bytes);
 >> +     if (rc < 0)
 >> +             return rc;
 >> +
 >> +     /* Allocate and initialize I/O messages */
 >> +     rc = virtsnd_pcm_msg_alloc(ss, periods, runtime->dma_area,
 >> +                                period_bytes);
 >> +     if (rc)
 >> +             snd_pcm_lib_free_pages(substream);
 >> +
 >> +     return rc;
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_hw_free() - Reset the parameters of the PCM substream.
 >> + * @substream: Kernel ALSA substream.
 >> + *
 >> + * The function does the following:
 >> + *   1. tries to release the PCM substream on the device side,
 >> + *   2. frees the hardware buffer.
 >> + *
 >> + * Context: Any context that permits to sleep.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 >> +{
 >> +     struct virtio_pcm_substream *ss =
 >> snd_pcm_substream_chip(substream);
 >> +     int rc;
 >> +
 >> +     rc = virtsnd_pcm_release(ss);
 >> +
 >> +     /*
 >> +      * Even if we failed to send the RELEASE message or wait for the
 >> queue
 >> +      * flush to complete, we can safely delete the buffer. Because
 >> after
 >> +      * receiving the STOP command, the device must stop all I/O 
message
 >> +      * processing. If there are still pending messages in the queue,
 >> the
 >> +      * next ops->hw_params() call should deal with this.
 >> +      */
 >> +     snd_pcm_lib_free_pages(substream);
 >> +
 >> +     return rc;
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_hw_params() - Prepare the PCM substream.
 >
 > copy-paste: this is virtsnd_pcm_prepare()

Oops... :)


 >> + * @substream: Kernel ALSA substream.
 >> + *
 >> + * The function can be called both from the upper level or from the
 >> driver
 >> + * itself.
 >> + *
 >> + * In all cases, the function:
 >> + *   1. checks the state of the virtqueue and, if necessary, tries to
 >> fix it,
 >> + *   2. prepares the substream on the device side.
 >> + *
 >> + * Context: Any context that permits to sleep. May take and release
 >> the tx/rx
 >> + *          queue spinlock.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 >> +{
 >> +     struct virtio_pcm_substream *ss =
 >> snd_pcm_substream_chip(substream);
 >> +     struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
 >> +     struct virtio_snd_msg *msg;
 >> +     unsigned long flags;
 >> +     int rc;
 >> +
 >> +     /*
 >> +      * If we got here after ops->trigger() was called, the queue may
 >> +      * still contain messages. In this case, we need to reset the
 >> +      * substream first.
 >> +      */
 >> +     if (atomic_read(&ss->msg_count)) {
 >> +             rc = virtsnd_pcm_hw_params(substream, NULL);
 >> +             if (rc)
 >> +                     return rc;
 >> +     }
 >> +
 >> +     spin_lock_irqsave(&queue->lock, flags);
 >> +     ss->msg_last_enqueued = -1;
 >> +     spin_unlock_irqrestore(&queue->lock, flags);
 >> +
 >> +     /*
 >> +      * Since I/O messages are asynchronous, they can be completed
 >> +      * when the runtime structure no longer exists. Since each
 >> +      * completion implies incrementing the hw_ptr, we cache all the
 >> +      * current values needed to compute the new hw_ptr value.
 >> +      */
 >> +     ss->frame_bytes = substream->runtime->frame_bits >> 3;
 >> +     ss->period_size = substream->runtime->period_size;
 >> +     ss->buffer_size = substream->runtime->buffer_size;
 >> +
 >> +     atomic_set(&ss->hw_ptr, 0);
 >> +     atomic_set(&ss->xfer_xrun, 0);
 >> +     atomic_set(&ss->msg_count, 0);
 >> +
 >> +     msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_PREPARE,
 >> +                                     GFP_KERNEL);
 >> +     if (IS_ERR(msg))
 >> +             return PTR_ERR(msg);
 >> +
 >> +     return virtsnd_ctl_msg_send_sync(ss->snd, msg);
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_pcm_trigger() - Process command for the PCM substream.
 >> + * @substream: Kernel ALSA substream.
 >> + * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
 >> + *
 >> + * Depending on the command, the function does the following:
 >> + *   1. enables/disables data transmission,
 >> + *   2. starts/stops the substream on the device side.
 >> + *
 >> + * Context: Atomic context. May take and release the tx/rx queue
 >> spinlock.
 >
 > Really? Cannot .trigger() sleep? E.g. I see mdelay(25) in
 > snd_es18xx_playback1_trigger()

Actually, you made a good point here. I didn't know, that it is possible
to disable atomic mode for that callback. But, apparently, it is possible.
And virtio pcm definetly is nonatomic. I need to redo this code, thanks!


 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream,
 >> int command)
 >> +{
 >> +     struct virtio_pcm_substream *ss =
 >> snd_pcm_substream_chip(substream);
 >> +     struct virtio_snd *snd = ss->snd;
 >> +     struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
 >> +     struct virtio_snd_msg *msg;
 >> +
 >> +     switch (command) {
 >> +     case SNDRV_PCM_TRIGGER_START:
 >> +     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
 >> +             int rc;
 >> +
 >> +             spin_lock(&queue->lock);
 >> +             rc = virtsnd_pcm_msg_send(ss);
 >> +             spin_unlock(&queue->lock);
 >
 > Maybe it would be good to explain why locking is required here and isn't
 > required in most other locations, where messages are sent?

There are two kinds of messages here: control messages and I/O. Functions
for sending control message acquire and release the control virtqueue
spinlock on their own. But we cannot do the same for I/O messages, since
virtsnd_pcm_msg_send is also called from the interrupt handler, which is
already grabbing the lock for the I/O virtqueue.


 > Thanks
 > Guennadi
 >
 >> +             if (rc)
 >> +                     return rc;
 >> +
 >> +             atomic_set(&ss->xfer_enabled, 1);
 >> +
 >> +             msg = virtsnd_pcm_ctl_msg_alloc(ss, 
VIRTIO_SND_R_PCM_START,
 >> +                                             GFP_ATOMIC);
 >> +             if (IS_ERR(msg))
 >> +                     return PTR_ERR(msg);
 >> +
 >> +             return virtsnd_ctl_msg_send(snd, msg);
 >> +     }
 >> +     case SNDRV_PCM_TRIGGER_STOP:
 >> +     case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
 >> +             atomic_set(&ss->xfer_enabled, 0);
 >> +
 >> +             msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
 >> +                                             GFP_ATOMIC);
 >> +             if (IS_ERR(msg))
 >> +                     return PTR_ERR(msg);
 >> +
 >> +             return virtsnd_ctl_msg_send(snd, msg);
 >> +     }
 >> +     default: {
 >> +             return -EINVAL;
 >> +     }
 >> +     }
 >> +}

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

