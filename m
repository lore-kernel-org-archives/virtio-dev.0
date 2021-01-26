Return-Path: virtio-dev-return-7958-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2978598624D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jan 2021 07:26:06 +0000 (UTC)
Date: Tue, 26 Jan 2021 08:25:58 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
Message-ID: <d92151ca-cde3-d1e6-23fe-f0c671379e9@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-7-anton.yakovlev@opensynergy.com> <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

One more thing I missed yesterday:

On Mon, 25 Jan 2021, Guennadi Liakhovetski wrote:

>
> On Sun, 24 Jan 2021, Anton Yakovlev wrote:
>
>> Introduce the operators required for the operation of substreams.
>> 
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> ---
>> sound/virtio/Makefile         |   3 +-
>> sound/virtio/virtio_pcm.c     |   5 +-
>> sound/virtio/virtio_pcm.h     |   2 +
>> sound/virtio/virtio_pcm_ops.c | 513 ++++++++++++++++++++++++++++++++++
>> 4 files changed, 521 insertions(+), 2 deletions(-)
>> create mode 100644 sound/virtio/virtio_pcm_ops.c
>
> [snip]
>
>> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
>> new file mode 100644
>> index 000000000000..19882777fcd6
>> --- /dev/null
>> +++ b/sound/virtio/virtio_pcm_ops.c
>> @@ -0,0 +1,513 @@
>
> [snip]
>
>> +/**
>> + * virtsnd_pcm_release() - Release the PCM substream on the device side.
>> + * @substream: VirtIO substream.
>> + *
>> + * Context: Any context that permits to sleep.
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream 
>> *substream)
>> +{
>> +	/*
>> +	 * The spec states that upon receipt of the RELEASE command "the 
>> device
>> +	 * MUST complete all pending I/O messages for the specified stream 
>> ID".
>> +	 * Thus, we consider the absence of I/O messages in the queue as an
>> +	 * indication that the substream has been released.
>> +	 */
>> +	return atomic_read(&substream->msg_count) == 0;
>
> Also here having it atomic doesn't really seem to help. This just means, that 
> at some point of time it was == 0.
>
>> +}
>> +
>> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
>
> kernel-doc missing
>
>> +{
>> +	struct virtio_snd *snd = substream->snd;
>> +	struct virtio_snd_msg *msg;
>> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
>> +	int rc;
>> +
>> +	msg = virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
>> +					GFP_KERNEL);
>> +	if (IS_ERR(msg))
>> +		return PTR_ERR(msg);
>> +
>> +	rc = virtsnd_ctl_msg_send_sync(snd, msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return wait_event_interruptible_timeout(substream->msg_empty,
>> +						virtsnd_pcm_released(substream),
>> +						js);

wait_event_interruptible_timeout() will return a positive number in 
success cases, 0 means a timeout and condition still false. Whereas when 
you call this function you interpret 0 as success and you expect any != 0 
to be a negative error. Wondering how this worked during your tests?

Thanks
Guennadi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

