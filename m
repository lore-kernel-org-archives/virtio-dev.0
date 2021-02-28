Return-Path: virtio-dev-return-8061-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCB04983E81
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Feb 2021 18:39:53 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-4-anton.yakovlev@opensynergy.com>
 <s5hv9acjvw6.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <174d09dd-ed8a-ecda-a392-48a2971b06cf@opensynergy.com>
Date: Sun, 28 Feb 2021 19:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <s5hv9acjvw6.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 3/9] ALSA: virtio: handling control messages
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.2021 12:04, Takashi Iwai wrote:> On Sat, 27 Feb 2021 09:59:50 
+0100,
> Anton Yakovlev wrote:
>>
>> --- a/sound/virtio/virtio_card.c
>> +++ b/sound/virtio/virtio_card.c
>> @@ -11,6 +11,10 @@
>>
>>   #include "virtio_card.h"
>>
>> +int msg_timeout_ms = MSEC_PER_SEC;
>> +module_param(msg_timeout_ms, int, 0644);
>> +MODULE_PARM_DESC(msg_timeout_ms, "Message completion timeout in milliseconds");
> 
> If it's a global variable, better to set a prefix to make it unique,
> and use module_param_named().

Yes, it makes sense.


> And, it should be unsigned int, no? (unless a negative value has any meaning)
> Otherwise...

And yes, it must be unsigned!


>> +     if (!msg_timeout_ms) {
>> +             dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
>> +             return -EINVAL;
> 
> Here a negative value would pass.
> 
> (snip)
>> +int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
>> +                      struct scatterlist *out_sgs,
>> +                      struct scatterlist *in_sgs, bool nowait)
>> +{
>> +     struct virtio_device *vdev = snd->vdev;
>> +     struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
>> +     unsigned int js = msecs_to_jiffies(msg_timeout_ms);
>> +     struct virtio_snd_hdr *request = virtsnd_ctl_msg_request(msg);
>> +     struct virtio_snd_hdr *response = virtsnd_ctl_msg_response(msg);
>> +     unsigned int nouts = 0;
>> +     unsigned int nins = 0;
>> +     struct scatterlist *psgs[4];
>> +     bool notify = false;
>> +     unsigned long flags;
>> +     int rc;
>> +
>> +     virtsnd_ctl_msg_ref(msg);
>> +
>> +     /* Set the default status in case the message was canceled. */
>> +     response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
>> +
>> +     psgs[nouts++] = &msg->sg_request;
>> +     if (out_sgs)
>> +             psgs[nouts++] = out_sgs;
>> +
>> +     psgs[nouts + nins++] = &msg->sg_response;
>> +     if (in_sgs)
>> +             psgs[nouts + nins++] = in_sgs;
>> +
>> +     spin_lock_irqsave(&queue->lock, flags);
>> +     rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
>> +                            GFP_ATOMIC);
> 
> It's a bit pity that we have to use GFP_ATOMIC always here...
> As long as it's in spinlock, it's the only way.

Well, here we have no other choices, since we share the queue with
an interrupt handler.


> However, this reminds me of another question: may the virtio event be
> handled in an atomic context, e.g. the period elapsed or xrun events?
> If so, the current implementation with non-atomic PCM mode is wrong.
> Since the non-atomic PCM uses mutex instead of spinlock, it'll lead to
> a sleep-in-atomic in snd_pcm_period_elapsed() handling.
> 
> I suggested the non-atomic PCM *iff* the all contexts are sleepable;
> then the sync can be done in each callback, which makes the code much
> simpler usually.  But you've already implemented the sync via
> sync_stop call, hence the non-atomic PCM has little benefit by its
> own.

The device provides 4 separate queues for communication with the driver,
and different data is transmitted over these queues:

The control queue (actually shared between all driver components) for
sending commands to the device. These requests must be synchronous. For
each request, the device must send a response, and we must wait for it.
What you can see in PCM ops are exactly sending these commands (set
params, prepare, start and so on). But since some ops could be called in
atomic context, there was no other choice but to add asynchronous
messages and return from the operator without waiting for a response
from the device. Because of this, the START command was a headache. We
could not say for sure if the substream started at all on the device
side. Also, the virtualization overhead was not taken into account
(application might think that the substream is already running, but
actually it was not).

Then there are 2 queues for sending/receiving PCM frames. These contain
i/o messages carrying actual buffer sliced into periods. Actually,
snd_pcm_period_elapsed() is called from interrupt handlers here.

And then there is an additional queue for events.

All of these are handled in different ways.


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

