Return-Path: virtio-dev-return-3570-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F28231CB807A
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Mar 2018 04:07:40 -0700 (PDT)
Message-ID: <5AAA54A6.9020900@intel.com>
Date: Thu, 15 Mar 2018 19:10:30 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com> <1520426065-40265-3-git-send-email-wei.w.wang@intel.com> <20180314181137.GG3006@work-vm> <20180314211302-mutt-send-email-mst@kernel.org> <20180314194258.GI3006@work-vm>
In-Reply-To: <20180314194258.GI3006@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v4 2/4] migration: API to clear bits of guest free pages
 from the dirty bitmap
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/15/2018 03:42 AM, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Wed, Mar 14, 2018 at 06:11:37PM +0000, Dr. David Alan Gilbert wrote:
>>>> +            used_len = block->used_length - offset;
>>>> +            addr += used_len;
>>>> +        }
>>>> +
>>>> +        start = offset >> TARGET_PAGE_BITS;
>>>> +        npages = used_len >> TARGET_PAGE_BITS;
>>>> +        ram_state->migration_dirty_pages -=
>>>> +                      bitmap_count_one_with_offset(block->bmap, start, npages);
>>>> +        bitmap_clear(block->bmap, start, npages);
>>> If this is happening while the migration is running, this isn't safe -
>>> the migration code could clear a bit at about the same point this
>>> happens, so that the count returned by bitmap_count_one_with_offset
>>> wouldn't match the word that was cleared by bitmap_clear.
>>>
>>> The only way I can see to fix it is to run over the range using
>>> bitmap_test_and_clear_atomic, using the return value to decrement
>>> the number of dirty pages.
>>> But you also need to be careful with the update of the
>>> migration_dirty_pages value itself, because that's also being read
>>> by the migration thread.
>>>
>>> Dave
>> I see that there's migration_bitmap_sync but it does not seem to be
> Do you mean bitmap_mutex?
>
>> taken on all paths. E.g. migration_bitmap_clear_dirty and
>> migration_bitmap_find_dirty are called without that lock sometimes.
>> Thoughts?

Right. The bitmap claims to protect modification of the bitmap, but 
migration_bitmap_clear_dirty doesn't strictly follow the rule.

> Hmm, that doesn't seem to protect much at all!  It looks like it was
> originally added to handle hotplug causing the bitmaps to be resized;
> that extension code was removed in 66103a5 so that lock can probably go.
>
> I don't see how the lock would help us though; the migration thread is
> scanning it most of the time so would have to have the lock held
> most of the time.
>



How about adding the lock to migration_bitmap_clear_dirty, and we will 
have something like this:

migration_bitmap_clear_dirty()
{
     qemu_mutex_lock(&rs->bitmap_mutex);
     ret = test_and_clear_bit(page, rb->bmap);
      if (ret) {
         rs->migration_dirty_pages--;
     }
     ...
     qemu_mutex_unlock(&rs->bitmap_mutex);
}


qemu_guest_free_page_hint()
{
     qemu_mutex_lock(&rs->bitmap_mutex);
     ...
     ram_state->migration_dirty_pages -=
                       bitmap_count_one_with_offset(block->bmap, start, 
npages);
     bitmap_clear(block->bmap, start, npages);
     qemu_mutex_unlock(&rs->bitmap_mutex);
}


The migration thread will hold the lock only when it clears a bit from 
the bitmap. Or would you consider to change it to qemu_spin_lock?

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

