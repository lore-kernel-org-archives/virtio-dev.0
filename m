Return-Path: virtio-dev-return-8071-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D16F986307
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 15:24:05 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-6-anton.yakovlev@opensynergy.com>
 <s5hsg5gjutg.wl-tiwai@suse.de>
 <b3de8563-1776-4296-2cf5-883c831dfbe8@opensynergy.com>
 <s5h35xfj8yz.wl-tiwai@suse.de>
 <85bbc067-e7ec-903a-1518-5aab01577655@opensynergy.com>
 <s5ho8g2j532.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b9c93040-52d5-7445-cb1c-c223b4fd59fb@opensynergy.com>
Date: Mon, 1 Mar 2021 16:24:00 +0100
MIME-Version: 1.0
In-Reply-To: <s5ho8g2j532.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 5/9] ALSA: virtio: handling control and I/O messages
 for the PCM device
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 01.03.2021 15:56, Takashi Iwai wrote:
> On Mon, 01 Mar 2021 15:47:46 +0100,
> Anton Yakovlev wrote:
>>
>> On 01.03.2021 14:32, Takashi Iwai wrote:
>>> On Mon, 01 Mar 2021 10:25:05 +0100,
>>> Anton Yakovlev wrote:
>>>>
>>>> On 28.02.2021 12:27, Takashi Iwai wrote:
>>>>> On Sat, 27 Feb 2021 09:59:52 +0100,
>>>>> Anton Yakovlev wrote:
>>>>>> +/**
>>>>>> + * virtsnd_pcm_event() - Handle the PCM device event notification.
>>>>>> + * @snd: VirtIO sound device.
>>>>>> + * @event: VirtIO sound event.
>>>>>> + *
>>>>>> + * Context: Interrupt context.
>>>>>
>>>>> OK, then nonatomic PCM flag is invalid...
>>>>
>>>> Well, no. Here, events are kind of independent entities. PCM-related
>>>> events are just a special case of more generic events, which can carry
>>>> any kind of notification/payload. (And at the moment, only XRUN
>>>> notification is supported for PCM substreams.) So it has nothing to do
>>>> with the atomicity of the PCM device itself.
>>>
>>> OK, thanks.
>>>
>>> Basically the only question is how snd_pcm_period_elapsed() is called.
>>> And I see that it's called inside queue->lock, and this already
>>> invalidates the nonatomic PCM mode.  So the code needs the fix: either
>>> fix this locking (and the context is guaranteed not to be an irq
>>> context), or change to the normal PCM mode without nonatomic flag.
>>> Both would bring some side-effect, and we need further changes, I
>>> suppose...
>>
>> Ok, I understood the problem. Well, I would say the nonatomic PCM mode
>> is more important option, since in this mode we can guarantee the
>> correct operation of the device.
> 
> Which operation (except for the resume) in the trigger and the pointer
> callbacks need the action that need to sleep?  I thought the sync with
> the command queue is done in the sync_stop.  And most of others seem
> already taking the spinlock in themselves, so the non-atomic operation
> has little merit for them.

All three commands from the beginning of that switch in trigger op:
ops->trigger(START)
ops->trigger(PAUSE_RELEASE)
ops->trigger(RESUME)

They all result in
virtsnd_ctl_msg_send_sync(VIRTIO_SND_R_PCM_START)

And that command must be sync, i.e. we need to wait/sleep until device
sent response. There are two major reasons for that: we need to be sure,
that substream has been actually started (i.e. device said OK). And we
need to take into account the virtualization overhead as well. Since
substream starting on device side may take some time, we can not
return from the trigger op until it actually happened. In atomic mode
all these nuances are lost, and it may lead to incorrect application
behavior.


>> And if you say, that we need to get rid
>> of irq context here, then probably workqueue for calling
>> snd_pcm_period_elapsed() should be fine (of course, it should be shared
>> between all available substreams).
> 
> That would work, but it's of course just papering over it :)
> 
> 
>>>>>> +/**
>>>>>> + * virtsnd_pcm_sg_num() - Count the number of sg-elements required to represent
>>>>>> + *                        vmalloc'ed buffer.
>>>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>>>> + * @length: Buffer size.
>>>>>> + *
>>>>>> + * Context: Any context.
>>>>>> + * Return: Number of physically contiguous parts in the @data.
>>>>>> + */
>>>>>> +static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
>>>>>> +{
>>>>>> +     phys_addr_t sg_address;
>>>>>> +     unsigned int sg_length;
>>>>>> +     int num = 0;
>>>>>> +
>>>>>> +     while (length) {
>>>>>> +             struct page *pg = vmalloc_to_page(data);
>>>>>> +             phys_addr_t pg_address = page_to_phys(pg);
>>>>>> +             size_t pg_length;
>>>>>> +
>>>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>>>> +             if (pg_length > length)
>>>>>> +                     pg_length = length;
>>>>>> +
>>>>>> +             if (!num || sg_address + sg_length != pg_address) {
>>>>>> +                     sg_address = pg_address;
>>>>>> +                     sg_length = pg_length;
>>>>>> +                     num++;
>>>>>> +             } else {
>>>>>> +                     sg_length += pg_length;
>>>>>> +             }
>>>>>> +
>>>>>> +             data += pg_length;
>>>>>> +             length -= pg_length;
>>>>>> +     }
>>>>>> +
>>>>>> +     return num;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
>>>>>> + * @sgs: Preallocated sg-list to populate.
>>>>>> + * @nsgs: The maximum number of elements in the @sgs.
>>>>>> + * @data: Pointer to vmalloc'ed buffer.
>>>>>> + * @length: Buffer size.
>>>>>> + *
>>>>>> + * Splits the buffer into physically contiguous parts and makes an sg-list of
>>>>>> + * such parts.
>>>>>> + *
>>>>>> + * Context: Any context.
>>>>>> + */
>>>>>> +static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>>>>>> +                             unsigned int length)
>>>>>> +{
>>>>>> +     int idx = -1;
>>>>>> +
>>>>>> +     while (length) {
>>>>>> +             struct page *pg = vmalloc_to_page(data);
>>>>>> +             size_t pg_length;
>>>>>> +
>>>>>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>>>>>> +             if (pg_length > length)
>>>>>> +                     pg_length = length;
>>>>>> +
>>>>>> +             if (idx == -1 ||
>>>>>> +                 sg_phys(&sgs[idx]) + sgs[idx].length != page_to_phys(pg)) {
>>>>>> +                     if (idx + 1 == nsgs)
>>>>>> +                             break;
>>>>>> +                     sg_set_page(&sgs[++idx], pg, pg_length,
>>>>>> +                                 offset_in_page(data));
>>>>>> +             } else {
>>>>>> +                     sgs[idx].length += pg_length;
>>>>>> +             }
>>>>>> +
>>>>>> +             data += pg_length;
>>>>>> +             length -= pg_length;
>>>>>> +     }
>>>>>> +
>>>>>> +     sg_mark_end(&sgs[idx]);
>>>>>> +}
>>>>>
>>>>> Hmm, I thought there can be already a handy helper to convert vmalloc
>>>>> to sglist, but apparently not.  It should have been trivial to get the
>>>>> page list from vmalloc, e.g.
>>>>>
>>>>> int vmalloc_to_page_list(void *p, struct page **page_ret)
>>>>> {
>>>>>            struct vmap_area *va;
>>>>>
>>>>>            va = find_vmap_area((unsigned long)p);
>>>>>            if (!va)
>>>>>                    return 0;
>>>>>            *page_ret = va->vm->pages;
>>>>>            return va->vm->nr_pages;
>>>>> }
>>>>>
>>>>> Then you can set up the sg list in a single call from the given page
>>>>> list.
>>>>>
>>>>> But it's just a cleanup, and let's mark it as a room for
>>>>> improvements.
>>>>
>>>> Yeah, we can take a look into some kind of optimizations here. But I
>>>> suspect, the overall code will look similar. It is not enough just to
>>>> get a list of pages, you also need to build a list of physically
>>>> contiguous regions from it.
>>>
>>> I believe the standard helper does it.  But it's for sg_table, hence
>>> the plain scatterlist needs to be extracted from there, but most of
>>> complex things are in the standard code.
>>>
>>> But it's merely an optimization and something for future.
>>
>> I quickly checked it. I think it's hardly possible to do anything here.
>> These functions to deal with vmalloced areas are not exported. And,
>> according to comments, require some proper locking on top of that. At
>> least, it does not look like a trivial things.
> 
> Sure, it needs a function exposed from vmalloc.c.  But I don't think
> the locking is the problem as find_vmap_area() already takes care of
> it, and we don't release the vmalloced pages while invoking this
> function.  Of course I might overlook something, but my point is that
> this kind of work should be rather in the core (or at least most of
> the important steps in the code should be in the core code).

Then it's definitely some work for future. :)


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

