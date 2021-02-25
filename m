Return-Path: virtio-dev-return-8037-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0FBB986174
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 11:51:41 +0000 (UTC)
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-3-anton.yakovlev@opensynergy.com>
 <s5h7dmwqvo4.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <cea4164d-345e-393b-9328-731c2f874eb7@opensynergy.com>
Date: Thu, 25 Feb 2021 12:51:36 +0100
MIME-Version: 1.0
In-Reply-To: <s5h7dmwqvo4.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v5 2/9] ALSA: virtio: add virtio sound driver
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 25.02.2021 11:38, Takashi Iwai wrote:
> On Mon, 22 Feb 2021 16:34:37 +0100,
> Anton Yakovlev wrote:
>> +static int virtsnd_find_vqs(struct virtio_snd *snd)
>> +{
>> +     struct virtio_device *vdev = snd->vdev;
>> +     vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] = {
>> +             [VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb
>> +     };
>> +     const char *names[VIRTIO_SND_VQ_MAX] = {
> 
> Shouldn't be static?

Well, yes. Although in this particular case, I do not think it is that
critical. :)


> Also it's often const char * const names[] = { ... }
> unless you overwrite something.

I tried to use the same type names as in the function prototype.
Otherwise the compiler or static analyzer may complain.


>> +/**
>> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
>> + * @work: Reset device work.
>> + *
>> + * Context: Process context.
>> + */
>> +static void virtsnd_reset_fn(struct work_struct *work)
>> +{
>> +     struct virtio_snd *snd =
>> +             container_of(work, struct virtio_snd, reset_work);
>> +     struct virtio_device *vdev = snd->vdev;
>> +     struct device *dev = &vdev->dev;
>> +     int rc;
>> +
>> +     dev_info(dev, "sound device needs reset\n");
>> +
>> +     /*
>> +      * It seems that the only way to properly reset the device is to remove
>> +      * and re-create the ALSA sound card device.
>> +      */
>> +     rc = device_reprobe(dev);
>> +     if (rc)
>> +             dev_err(dev, "failed to reprobe sound device: %d\n", rc);
> 
> Now I'm wondering whether it's safe to do that from this place.
> Basically device_reprobe() unbinds the device that releases the full
> resources once including the devm_* stuff.  And this work itself is in
> a part of devm allocated resource, so it'll be released there.  That
> said, we might hit use-after-free...  This needs to be verified.

It's safe. Suicide kernel workers are funny but possible things. Since
the kernel itself (AFAIU) assumes such a situation and does not access
the worker structure after the callback function call.


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

