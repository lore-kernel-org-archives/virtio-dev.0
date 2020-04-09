Return-Path: virtio-dev-return-7039-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22CD3985F58
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Apr 2020 17:35:43 +0000 (UTC)
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225529.18764.44086.stgit@localhost.localdomain>
 <06ac44b9-77ae-7686-8a65-7edff2cbf1b7@redhat.com>
 <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <987022c8-3aed-dccb-df02-d834500c04d3@redhat.com>
Date: Thu, 9 Apr 2020 19:35:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v18 QEMU 3/3] virtio-balloon: Provide a interface for free
 page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 09.04.20 19:34, Alexander Duyck wrote:
> On Thu, Apr 9, 2020 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.04.20 00:55, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> Add support for what I am referring to as "free page reporting".
>>
>> "Add support for "free page reporting".
>>
>>> Basically the idea is to function very similar to how the balloon works
>>> in that we basically end up madvising the page as not being used. However
>>
>> I'd get rid of one "basically".
>>
>>> we don't really need to bother with any deflate type logic since the page
>>> will be faulted back into the guest when it is read or written to.
>>>
>>> This is meant to be a simplification of the existing balloon interface
>>> to use for providing hints to what memory needs to be freed. I am assuming
>>
>> It's not really a simplification, it's something new. It's a new way of
>> letting the guest automatically report free pages to the hypervisor, so
>> the hypervisor can reuse them. In contrast to inflate/deflate, that's
>> triggered via the hypervisor explicitly.
>>
>>> this is safe to do as the deflate logic does not actually appear to do very
>>> much other than tracking what subpages have been released and which ones
>>> haven't.
>>
>> "I assume this is safe" does not sound very confident. Can we just drop
>> the last sentence?
> 
> Agreed. I will make the requested changes to the patch description.
> 
>>
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |   48 +++++++++++++++++++++++++++++++++++-
>>>  include/hw/virtio/virtio-balloon.h |    2 +-
>>>  2 files changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index 1c6d36a29a04..297b267198ac 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -321,6 +321,42 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>>>      balloon_stats_change_timer(s, 0);
>>>  }
>>>
>>> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
>>> +{
>>> +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>>> +    VirtQueueElement *elem;
>>> +
>>> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
>>> +        unsigned int i;
>>> +
>>> +        for (i = 0; i < elem->in_num; i++) {
>>> +            void *addr = elem->in_sg[i].iov_base;
>>> +            size_t size = elem->in_sg[i].iov_len;
>>> +            ram_addr_t ram_offset;
>>> +            size_t rb_page_size;
>>> +            RAMBlock *rb;
>>> +
>>> +            if (qemu_balloon_is_inhibited() || dev->poison_val) {
>>> +                continue;
>>> +            }
>>
>> These checks are not sufficient. See virtio_balloon_handle_output(),
>> where we e.g., check that somebody doesn't try to discard the bios.
>>
>> Maybe we can factor our/unify the handling in both code paths.
> 
> I am going to have to look at this further. If I understand correctly
> you are asking me to add all of the memory section checks that are in
> virtio_balloon_handle_output correct?
> 
> I'm not sure it makes sense with the scatterlist approach I have taken
> here. All of the mappings were created as a scatterlist of writable
> DMA mappings unlike the regular balloon which is just stuffing PFN
> numbers into an array and then sending the array across. As such I
> would think there are already such protections in place. For instance,
> you wouldn't want to let virtio-net map the BIOS and request data be
> written into that either, correct? So I am assuming there is something
> there to prevent that already isn't there?

Good point, let's find out :)


-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

