Return-Path: virtio-dev-return-8082-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10599986392
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 Mar 2021 15:35:28 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
 <s5hpn0kjt31.wl-tiwai@suse.de>
 <7d4daea0-ed59-e84c-c28a-945c49204c83@opensynergy.com>
 <s5hwnuqgifa.wl-tiwai@suse.de>
 <d9853306-2adf-24fe-935c-f7f8a1295dc3@opensynergy.com>
 <s5hr1kxhqcn.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <2479ed0f-4c90-f565-81cd-8d0348cd14bc@opensynergy.com>
Date: Tue, 2 Mar 2021 16:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <s5hr1kxhqcn.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume
 support
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.2021 10:11, Takashi Iwai wrote:
> On Tue, 02 Mar 2021 09:09:33 +0100,
> Anton Yakovlev wrote:
>>
>> On 02.03.2021 07:48, Takashi Iwai wrote:
>>> On Tue, 02 Mar 2021 07:29:20 +0100,
>>> Anton Yakovlev wrote:
>>>>
>>>> On 28.02.2021 13:05, Takashi Iwai wrote:
>>>>> On Sat, 27 Feb 2021 09:59:56 +0100,
>>>>> Anton Yakovlev wrote:
>>>>>>
>>>>
>>>> [snip]
>>>>
>>>>>> --- a/sound/virtio/virtio_pcm.c
>>>>>> +++ b/sound/virtio/virtio_pcm.c
>>>>>> @@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>>>>>                  SNDRV_PCM_INFO_BATCH |
>>>>>>                  SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>>>>                  SNDRV_PCM_INFO_INTERLEAVED |
>>>>>> +             SNDRV_PCM_INFO_RESUME |
>>>>>>                  SNDRV_PCM_INFO_PAUSE;
>>>>>
>>>>> Actually you don't need to set SNDRV_PCM_INFO_RESUME.
>>>>> This flag means that the driver supports the full resume procedure,
>>>>> which isn't often the case; with this, the driver is supposed to
>>>>> resume the stream exactly from the suspended position.
>>>>>
>>>>> Most drivers don't set this but implement only the suspend-stop
>>>>> action.  Then the application (or the sound backend) will re-setup the
>>>>> stream and restart accordingly.
>>>>
>>>> I tried to resume driver without SNDRV_PCM_INFO_RESUME, and alsa-lib
>>>> called only ops->prepare(). It makes sense for a typical hw, but we have
>>>> "clean" unconfigured device on resume. And we must set hw parameters as
>>>> a first step. It means, that code should be more or less the same. And
>>>> maybe it's better to set SNDRV_PCM_INFO_RESUME, since it allows us to
>>>> resume substream in any situation (regardless of application behavior).
>>>> I can refactor code to only send requests from trigger(RESUME) path and
>>>> not to call ops itself. It should make code more straitforward. What do
>>>> you say?
>>>
>>> How about calling hw_params(NULL) conditionally in the prepare?
>>
>> Then the question is that condition. When ops->prepare() is called, the
>> substream is in SUSPENDED state or not? If not then we need to track
>> this in some additional field (and it will make logic a little bit
>> clumsy, since that field is needed to be carefully handled in other
>> places).
> 
> Yes, you'd need to have a suspend/resume PM callback in the driver
> that flips the internal flag to invalidate the hw_parmas, and in the
> prepare callback, just call hw_params(NULL) if that flag is set.
> 
>>> Doing the full stack work in the trigger callback is bad from the API
>>> design POV; in general the trigger callback is supposed to be as short
>>> as possible.
>>
>> Yeah, but usually original subsystem design does not take into account
>> para-virtualized devices, which usually have it's own slightly different
>> reality. And we need to introduce some tricks.
> 
> The hardware drivers do a lot of more things in either suspend/resume
> PM callbacks or prepare callback for re-setup of the hardware.  We can
> follow the similar pattern.  Heavy-lifting works in the trigger
> callbacks is really something to avoid.

Ok, I redone this part and now the driver sets parameters for the device
in ops->prepare() if the substream was suspended. And everything works
fine. Thanks! I will send a new patch set soon.


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

