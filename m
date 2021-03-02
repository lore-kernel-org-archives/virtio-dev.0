Return-Path: virtio-dev-return-8079-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BB4698638A
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Mar 2021 06:29:23 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
 <s5hpn0kjt31.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <7d4daea0-ed59-e84c-c28a-945c49204c83@opensynergy.com>
Date: Tue, 2 Mar 2021 07:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <s5hpn0kjt31.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume
 support
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.2021 13:05, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:56 +0100,
> Anton Yakovlev wrote:
>>

[snip]

>> --- a/sound/virtio/virtio_pcm.c
>> +++ b/sound/virtio/virtio_pcm.c
>> @@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>                SNDRV_PCM_INFO_BATCH |
>>                SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>                SNDRV_PCM_INFO_INTERLEAVED |
>> +             SNDRV_PCM_INFO_RESUME |
>>                SNDRV_PCM_INFO_PAUSE;
> 
> Actually you don't need to set SNDRV_PCM_INFO_RESUME.
> This flag means that the driver supports the full resume procedure,
> which isn't often the case; with this, the driver is supposed to
> resume the stream exactly from the suspended position.
> 
> Most drivers don't set this but implement only the suspend-stop
> action.  Then the application (or the sound backend) will re-setup the
> stream and restart accordingly.

I tried to resume driver without SNDRV_PCM_INFO_RESUME, and alsa-lib
called only ops->prepare(). It makes sense for a typical hw, but we have
"clean" unconfigured device on resume. And we must set hw parameters as
a first step. It means, that code should be more or less the same. And
maybe it's better to set SNDRV_PCM_INFO_RESUME, since it allows us to
resume substream in any situation (regardless of application behavior).
I can refactor code to only send requests from trigger(RESUME) path and
not to call ops itself. It should make code more straitforward. What do
you say?


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

