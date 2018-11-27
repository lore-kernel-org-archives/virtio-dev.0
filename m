Return-Path: virtio-dev-return-5039-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12B2B985B00
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Nov 2018 06:07:38 +0000 (UTC)
Message-ID: <5BFCE052.8070705@intel.com>
Date: Tue, 27 Nov 2018 14:12:34 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-4-git-send-email-wei.w.wang@intel.com> <20181127054056.GA3205@xz-x1> <5BFCDE07.20707@intel.com>
In-Reply-To: <5BFCDE07.20707@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v9 3/8] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/27/2018 02:02 PM, Wei Wang wrote:
> On 11/27/2018 01:40 PM, Peter Xu wrote:
>> On Thu, Nov 15, 2018 at 06:07:59PM +0800, Wei Wang wrote:
>>> The bitmap mutex is used to synchronize threads to update the dirty
>>> bitmap and the migration_dirty_pages counter. For example, the free
>>> page optimization clears bits of free pages from the bitmap in an
>>> iothread context. This patch makes migration_bitmap_clear_dirty update
>>> the bitmap and counter under the mutex.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> CC: Juan Quintela <quintela@redhat.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Peter Xu <peterx@redhat.com>
>>> ---
>>>   migration/ram.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 7e7deec..ef69dbe 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -1556,11 +1556,14 @@ static inline bool 
>>> migration_bitmap_clear_dirty(RAMState *rs,
>>>   {
>>>       bool ret;
>>>   +    qemu_mutex_lock(&rs->bitmap_mutex);
>>>       ret = test_and_clear_bit(page, rb->bmap);
>>>         if (ret) {
>>>           rs->migration_dirty_pages--;
>>>       }
>>> +    qemu_mutex_unlock(&rs->bitmap_mutex);
>>> +
>>>       return ret;
>>>   }
>> It seems fine to me, but have you thought about
>> test_and_clear_bit_atomic()?  Note that we just had
>> test_and_set_bit_atomic() a few months ago.
>
> Thanks for sharing. I think we might also need to
> mutex migration_dirty_pages.
>
>>
>> And not related to this patch: I'm unclear on why we have had
>> bitmap_mutex before, since it seems unnecessary.
>
> OK. This is because with the optimization we have a thread
> which clears bits (of free pages) from the bitmap and updates
> migration_dirty_pages. So we need to synchronization between
> the migration thread and the optimization thread.
>

And before this feature, I think yes, that bitmap_mutex is not needed.
It was left there due to some historical reasons.
I remember Dave previous said he was about to remove it. But the new
feature will need it again.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

