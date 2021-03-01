Return-Path: virtio-dev-return-8072-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2671F986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 15:30:59 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
 <s5hpn0kjt31.wl-tiwai@suse.de>
 <54854cb9-99c3-4c05-3b43-f41d89a29aec@opensynergy.com>
 <s5hzgznhu3n.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <438961dc-b546-562a-26dc-53cf46ee74b6@opensynergy.com>
Date: Mon, 1 Mar 2021 16:30:55 +0100
MIME-Version: 1.0
In-Reply-To: <s5hzgznhu3n.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume
 support
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 01.03.2021 14:38, Takashi Iwai wrote:
> On Mon, 01 Mar 2021 11:03:04 +0100,
> Anton Yakovlev wrote:
>>
>> On 28.02.2021 13:05, Takashi Iwai wrote:
>>> On Sat, 27 Feb 2021 09:59:56 +0100,
>>> Anton Yakovlev wrote:
>>>>
>>>> All running PCM substreams are stopped on device suspend and restarted
>>>> on device resume.
>>>>
>>>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>>>> ---
>>>>    sound/virtio/virtio_card.c    | 56 +++++++++++++++++++++++++++++++++++
>>>>    sound/virtio/virtio_pcm.c     |  1 +
>>>>    sound/virtio/virtio_pcm_ops.c | 41 ++++++++++++++++++++-----
>>>>    3 files changed, 90 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
>>>> index 59455a562018..c7ae8801991d 100644
>>>> --- a/sound/virtio/virtio_card.c
>>>> +++ b/sound/virtio/virtio_card.c
>>>> @@ -323,6 +323,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
>>>>         kfree(snd->event_msgs);
>>>>    }
>>>>
>>>> +#ifdef CONFIG_PM_SLEEP
>>>> +/**
>>>> + * virtsnd_freeze() - Suspend device.
>>>> + * @vdev: VirtIO parent device.
>>>> + *
>>>> + * Context: Any context.
>>>> + * Return: 0 on success, -errno on failure.
>>>> + */
>>>> +static int virtsnd_freeze(struct virtio_device *vdev)
>>>> +{
>>>> +     struct virtio_snd *snd = vdev->priv;
>>>> +
>>>> +     virtsnd_ctl_msg_cancel_all(snd);
>>>> +
>>>> +     vdev->config->del_vqs(vdev);
>>>> +     vdev->config->reset(vdev);
>>>> +
>>>> +     kfree(snd->event_msgs);
>>>> +
>>>> +     /*
>>>> +      * If the virtsnd_restore() fails before re-allocating events, then we
>>>> +      * get a dangling pointer here.
>>>> +      */
>>>> +     snd->event_msgs = NULL;
>>>> +
>>>> +     return 0;
>>>
>>> I suppose some cancel of inflight works is needed?
>>> Ditto for the device removal, too.
>>
>> It's not necessary here, since the device is reset and all of this are
>> happened automatically.
> 
> Hrm, but the reset call itself might conflict with the inflight reset
> work?  I haven't see any work canceling or flushing, so...

There maybe the following:

1. Some pending control requests -> these are cancelled in the
virtsnd_ctl_msg_cancel_all() call.

2. PCM messages -> these must not be cancelled, since they will be
requeued by driver on resume (starting with suspended position).

3. Some pending events from the device. These will be lost. Yeah, I
think we can process all pending events before destroying virtqueue.

Other that these, there are no other inflight works or so.


>> But in the device remove it makes sense also to
>> disable events before calling snd_card_free(), since the device is still
>> able to send notifications at that moment. Thanks!
>>
>>
>>>> --- a/sound/virtio/virtio_pcm.c
>>>> +++ b/sound/virtio/virtio_pcm.c
>>>> @@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>>>                 SNDRV_PCM_INFO_BATCH |
>>>>                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>>                 SNDRV_PCM_INFO_INTERLEAVED |
>>>> +             SNDRV_PCM_INFO_RESUME |
>>>>                 SNDRV_PCM_INFO_PAUSE;
>>>
>>> Actually you don't need to set SNDRV_PCM_INFO_RESUME.
>>> This flag means that the driver supports the full resume procedure,
>>> which isn't often the case; with this, the driver is supposed to
>>> resume the stream exactly from the suspended position.
>>
>> If I understood you right, that's exactly how resume is implemented now
>> in the driver. Although we fully restart substream on the device side,
>> from an application point of view it is resumed exactly at the same
>> position.
>>
>>
>>> Most drivers don't set this but implement only the suspend-stop
>>> action.  Then the application (or the sound backend) will re-setup the
>>> stream and restart accordingly.
>>
>> And an application must be aware of such possible situation? Since I
>> have no doubt in alsa-lib, but I don't think that for example tinyalsa
>> can handle this right.
> 
> Tiny ALSA should work, too.  Actually there are only few drivers that
> have the full PCM resume.  The majority of drivers are without the
> resume support (including a large one like HD-audio).

Then it's a great news! Since we can simplify code a lot.


> And, with the resume implementation, I'm worried by the style like:
> 
>>>> @@ -309,6 +318,21 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>>>>         int rc;
>>>>
>>>>         switch (command) {
>>>> +     case SNDRV_PCM_TRIGGER_RESUME: {
>>>> +             /*
>>>> +              * We restart the substream by executing the standard command
>>>> +              * sequence.
>>>> +              */
>>>> +             rc = virtsnd_pcm_hw_params(substream, NULL);
>>>> +             if (rc)
>>>> +                     return rc;
>>>> +
>>>> +             rc = virtsnd_pcm_prepare(substream);
>>>> +             if (rc)
>>>> +                     return rc;
> 
> ... and this is rather what the core code should do, and it's exactly
> the same procedure that would be done without RESUME flag.
> 
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

