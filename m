Return-Path: virtio-dev-return-5113-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8D4D985B7E
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Dec 2018 08:19:05 +0000 (UTC)
Message-ID: <5C04E825.6060105@intel.com>
Date: Mon, 03 Dec 2018 16:24:05 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com> <1543803511-34793-7-git-send-email-wei.w.wang@intel.com> <20181203053118.GD27620@xz-x1> <5C04E73F.9040202@intel.com>
In-Reply-To: <5C04E73F.9040202@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v10 6/7] migration/ram.c: add a function
 to disable the bulk stage
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/03/2018 04:20 PM, Wei Wang wrote:
> On 12/03/2018 01:31 PM, Peter Xu wrote:
>> On Mon, Dec 03, 2018 at 10:18:30AM +0800, Wei Wang wrote:
>>> This patch adds a function to enable a precopy notifier callback 
>>> outside
>>> the migration subsystem to disable the bulk stage flag. This is 
>>> needed by
>>> the free page optimization offered by virtio-balloon.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> CC: Juan Quintela <quintela@redhat.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Peter Xu <peterx@redhat.com>
>>> ---
>>>   include/migration/misc.h | 1 +
>>>   migration/ram.c          | 9 +++++++++
>>>   2 files changed, 10 insertions(+)
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index 15f8d00..47e7ff5 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -37,6 +37,7 @@ void precopy_infrastructure_init(void);
>>>   void precopy_add_notifier(NotifierWithReturn *n);
>>>   void precopy_remove_notifier(NotifierWithReturn *n);
>>>   int precopy_notify(PrecopyNotifyReason reason, Error **errp);
>>> +void precopy_disable_bulk_stage(void);
>>>     void ram_mig_init(void);
>>>   void qemu_guest_free_page_hint(void *addr, size_t len);
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index b90a3f2..739dc97 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -354,6 +354,15 @@ int precopy_notify(PrecopyNotifyReason reason, 
>>> Error **errp)
>>>       return 
>>> notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
>>>   }
>>>   +void precopy_disable_bulk_stage(void)
>>> +{
>>> +    if (!ram_state) {
>>> +        return;
>>> +    }
>>> +
>>> +    ram_state->ram_bulk_stage = false;
>>> +}
>>> +
>> This one is a bit tricky.  E.g., I think it'll at least affect XBZRLE
>> and compression somehow.  Since we will have the on-off switch for
>> balloon free page hinting so the user can at least decide what
>> features to use, with that I don't see much issue with it so far. But
>> I'd also like to see how other people see this change.
>>
>
> Yes. I think it would be better that this optimization could co-exist 
> with the
> compression feature.
>
> How about adding a new flag "ram_state->free_page_optimization_enabled"?
>
> We will then need a change in migration_bitmap_find_dirty:
>  - if (rs->ram_bulk_stage && start > 0) {
> + if (!rs->free_page_optimization_enabled && rs->ram_bulk_stage && 
> start > 0) {
>         next = start + 1;
>     } else {
>         next = find_next_bit(bitmap, size, start);
>     }
>

Btw, with the new flag, this patch is not needed, so "ram_bulk_stage" 
will not be changed.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

