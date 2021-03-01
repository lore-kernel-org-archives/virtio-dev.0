Return-Path: virtio-dev-return-8065-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01FC4985A84
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 09:29:27 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-7-anton.yakovlev@opensynergy.com>
 <s5hr1l0juld.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f8a4bbf5-3bee-f336-0efd-94410184fb2b@opensynergy.com>
Date: Mon, 1 Mar 2021 10:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <s5hr1l0juld.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.2021 12:32, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:53 +0100,
> Anton Yakovlev wrote:
>>


[snip]


>> +static snd_pcm_uframes_t
>> +virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>> +{
>> +     struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
>> +     snd_pcm_uframes_t hw_ptr = SNDRV_PCM_POS_XRUN;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&vss->lock, flags);
>> +     if (!vss->xfer_xrun)
>> +             hw_ptr = bytes_to_frames(substream->runtime, vss->hw_ptr);
>> +     spin_unlock_irqrestore(&vss->lock, flags);
> 
> Oh, and if we drop nonatomc PCM, both trigger and pointer callbacks
> are guaranteed to be called inside the spinlock, hence you can remove
> *_irqsave() but just us spin_lock() in those two callbacks.

As I understand, spin_lock_irqsave() disables only local interrupts. But
what about other CPU cores?


> 
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

