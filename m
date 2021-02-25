Return-Path: virtio-dev-return-8038-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2B35986174
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 12:14:41 +0000 (UTC)
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
Date: Thu, 25 Feb 2021 13:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35xkquvj.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 25.02.2021 11:55, Takashi Iwai wrote:
> On Mon, 22 Feb 2021 16:34:41 +0100,
> Anton Yakovlev wrote:
>> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
>> +{
>> +     struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
>> +     struct virtio_pcm_substream *vss = NULL;
>> +
>> +     if (vpcm) {
>> +             switch (substream->stream) {
>> +             case SNDRV_PCM_STREAM_PLAYBACK:
>> +             case SNDRV_PCM_STREAM_CAPTURE: {
> 
> The switch() here looks superfluous.  The substream->stream must be a
> good value in the callback.  If any, you can put WARN_ON() there, but
> I don't think it worth.

At least it doesn't do any harm. If something really went wrong, we can
check it right in the open callback, which is called the very first.


>> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
>> +                              struct snd_pcm_hw_params *hw_params)
>> +{
> ....
>> +     return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
> 
> We have the allocation, but...
> 
>> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
>> +{
>> +     return 0;
> 
> ... no release at hw_free()?
> I know that the free is present in the allocator, but it's only for
> re-allocation case, I suppose.

When the substream stops, sync_ptr waits until the device has completed
all pending messages. This wait can be interrupted either by a signal or
due to a timeout. In this case, the device can still access messages
even after calling hw_free(). It can also issue an interrupt, and the
interrupt handler will also try to access message structures. Therefore,
freeing of already allocated messages occurs either in hw_params() or in
dev->release(), since there it is 100% safe.


> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

