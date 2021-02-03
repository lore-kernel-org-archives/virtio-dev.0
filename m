Return-Path: virtio-dev-return-7975-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 027F3986607
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Feb 2021 17:34:16 +0000 (UTC)
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
 <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
 <52f71ac6-3ec7-2884-7a64-1995f416d20a@opensynergy.com>
 <s5h35yd9jf0.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <fb4808e7-28d6-996e-02fc-c63d0e1d8221@opensynergy.com>
Date: Wed, 3 Feb 2021 18:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35yd9jf0.wl-tiwai@suse.de>
Subject: Re: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound
 driver
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Takashi,


On 03.02.2021 17:59, Takashi Iwai wrote:
> On Tue, 02 Feb 2021 00:18:09 +0100,
> Anton Yakovlev wrote:
>>>> +/**
>>>> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
>>>> + * @work: Reset device work.
>>>> + *
>>>> + * Context: Process context.
>>>> + */
>>>> +static void virtsnd_reset_fn(struct work_struct *work)
>>>> +{
>>>> +     struct virtio_snd *snd =
>>>> +             container_of(work, struct virtio_snd, reset_work);
>>>> +     struct virtio_device *vdev = snd->vdev;
>>>> +     struct device *dev = &vdev->dev;
>>>> +     int rc;
>>>> +
>>>> +     dev_info(dev, "sound device needs reset\n");
>>>> +
>>>> +     /*
>>>> +      * It seems that the only way to properly reset the device is to
>>>> remove
>>>> +      * and re-create the ALSA sound card device.
>>>> +      *
>>>> +      * Also resetting the device involves a number of steps with
>>>> setting the
>>>> +      * status bits described in the virtio specification. And the
>>>> easiest
>>>> +      * way to get everything right is to use the virtio bus interface.
>>>> +      */
>>>> +     rc = dev->bus->remove(dev);
>>>> +     if (rc)
>>>> +             dev_warn(dev, "bus->remove() failed: %d", rc);
>>>> +
>>>> +     rc = dev->bus->probe(dev);
>>>> +     if (rc)
>>>> +             dev_err(dev, "bus->probe() failed: %d", rc);
>>>
>>> This looks very suspicious to me. Wondering what ALSA maintainers
>> will say
>>> to this.
>>
>> I'm also wondering what the virtio people have to say. This part is a
>> purely virtio specific thing. And since none of the existing virtio
>> drivers processes the request to reset the device, it is not clear what
>> is the best way to proceed here. For this reason, the most
>> straightforward and simple solution was chosen.
> 
> What is this "reset" actually supposed to do?  Reconfguring
> everything, or changing only certain parameters, devices, whatever?

It means bringing this particular device to its initial state.

After that, the driver can re-read the configurations from the device
and reconfigure everything.


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

