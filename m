Return-Path: virtio-dev-return-8064-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52C00985A84
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Mar 2021 09:25:10 +0000 (UTC)
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-6-anton.yakovlev@opensynergy.com>
 <s5hsg5gjutg.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <b3de8563-1776-4296-2cf5-883c831dfbe8@opensynergy.com>
Date: Mon, 1 Mar 2021 10:25:05 +0100
MIME-Version: 1.0
In-Reply-To: <s5hsg5gjutg.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v6 5/9] ALSA: virtio: handling control and I/O messages
 for the PCM device
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.2021 12:27, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:52 +0100,
> Anton Yakovlev wrote:
>> +/**
>> + * virtsnd_pcm_event() - Handle the PCM device event notification.
>> + * @snd: VirtIO sound device.
>> + * @event: VirtIO sound event.
>> + *
>> + * Context: Interrupt context.
> 
> OK, then nonatomic PCM flag is invalid...

Well, no. Here, events are kind of independent entities. PCM-related
events are just a special case of more generic events, which can carry
any kind of notification/payload. (And at the moment, only XRUN
notification is supported for PCM substreams.) So it has nothing to do
with the atomicity of the PCM device itself.


>> +/**
>> + * virtsnd_pcm_sg_num() - Count the number of sg-elements required to represent
>> + *                        vmalloc'ed buffer.
>> + * @data: Pointer to vmalloc'ed buffer.
>> + * @length: Buffer size.
>> + *
>> + * Context: Any context.
>> + * Return: Number of physically contiguous parts in the @data.
>> + */
>> +static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
>> +{
>> +     phys_addr_t sg_address;
>> +     unsigned int sg_length;
>> +     int num = 0;
>> +
>> +     while (length) {
>> +             struct page *pg = vmalloc_to_page(data);
>> +             phys_addr_t pg_address = page_to_phys(pg);
>> +             size_t pg_length;
>> +
>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>> +             if (pg_length > length)
>> +                     pg_length = length;
>> +
>> +             if (!num || sg_address + sg_length != pg_address) {
>> +                     sg_address = pg_address;
>> +                     sg_length = pg_length;
>> +                     num++;
>> +             } else {
>> +                     sg_length += pg_length;
>> +             }
>> +
>> +             data += pg_length;
>> +             length -= pg_length;
>> +     }
>> +
>> +     return num;
>> +}
>> +
>> +/**
>> + * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
>> + * @sgs: Preallocated sg-list to populate.
>> + * @nsgs: The maximum number of elements in the @sgs.
>> + * @data: Pointer to vmalloc'ed buffer.
>> + * @length: Buffer size.
>> + *
>> + * Splits the buffer into physically contiguous parts and makes an sg-list of
>> + * such parts.
>> + *
>> + * Context: Any context.
>> + */
>> +static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>> +                             unsigned int length)
>> +{
>> +     int idx = -1;
>> +
>> +     while (length) {
>> +             struct page *pg = vmalloc_to_page(data);
>> +             size_t pg_length;
>> +
>> +             pg_length = PAGE_SIZE - offset_in_page(data);
>> +             if (pg_length > length)
>> +                     pg_length = length;
>> +
>> +             if (idx == -1 ||
>> +                 sg_phys(&sgs[idx]) + sgs[idx].length != page_to_phys(pg)) {
>> +                     if (idx + 1 == nsgs)
>> +                             break;
>> +                     sg_set_page(&sgs[++idx], pg, pg_length,
>> +                                 offset_in_page(data));
>> +             } else {
>> +                     sgs[idx].length += pg_length;
>> +             }
>> +
>> +             data += pg_length;
>> +             length -= pg_length;
>> +     }
>> +
>> +     sg_mark_end(&sgs[idx]);
>> +}
> 
> Hmm, I thought there can be already a handy helper to convert vmalloc
> to sglist, but apparently not.  It should have been trivial to get the
> page list from vmalloc, e.g.
> 
> int vmalloc_to_page_list(void *p, struct page **page_ret)
> {
>          struct vmap_area *va;
> 
>          va = find_vmap_area((unsigned long)p);
>          if (!va)
>                  return 0;
>          *page_ret = va->vm->pages;
>          return va->vm->nr_pages;
> }
> 
> Then you can set up the sg list in a single call from the given page
> list.
> 
> But it's just a cleanup, and let's mark it as a room for
> improvements.

Yeah, we can take a look into some kind of optimizations here. But I
suspect, the overall code will look similar. It is not enough just to
get a list of pages, you also need to build a list of physically
contiguous regions from it. Because the sg-elements are put into a
virtqueue that has a limited size. And each sg-element consumes one item
in the virtqueue. And since the virtqueue itself is shared between all
substreams, the items of the virtqueue become a scarce resource.


> (snip)
>> +/**
>> + * virtsnd_pcm_msg_complete() - Complete an I/O message.
>> + * @msg: I/O message.
>> + * @written_bytes: Number of bytes written to the message.
>> + *
>> + * Completion of the message means the elapsed period. If transmission is
>> + * allowed, then each completed message is immediately placed back at the end
>> + * of the queue.
>> + *
>> + * For the playback substream, @written_bytes is equal to sizeof(msg->status).
>> + *
>> + * For the capture substream, @written_bytes is equal to sizeof(msg->status)
>> + * plus the number of captured bytes.
>> + *
>> + * Context: Interrupt context. Takes and releases the VirtIO substream spinlock.
>> + */
>> +static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>> +                                  size_t written_bytes)
>> +{
>> +     struct virtio_pcm_substream *vss = msg->substream;
>> +
>> +     /*
>> +      * hw_ptr always indicates the buffer position of the first I/O message
>> +      * in the virtqueue. Therefore, on each completion of an I/O message,
>> +      * the hw_ptr value is unconditionally advanced.
>> +      */
>> +     spin_lock(&vss->lock);
>> +     /*
>> +      * If the capture substream returned an incorrect status, then just
>> +      * increase the hw_ptr by the message size.
>> +      */
>> +     if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK ||
>> +         written_bytes <= sizeof(msg->status)) {
>> +             struct scatterlist *sg;
>> +
>> +             for (sg = &msg->sgs[PCM_MSG_SG_DATA]; sg; sg = sg_next(sg))
>> +                     vss->hw_ptr += sg->length;
> 
> So the sg list entries are supposed to be updated?  Or if the length
> there are constant, we don't need to iterate the sg entries but keep
> the total length beforehand?

That's one of options. Since the same info can be derived from sg-list,
I thought it might be not necessary to keep it in some additional field.
But probably it makes sense to keep total length in the message
structure itself. Then it will be more flexible (if we will need to
create non-period sized messages in the future).


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

