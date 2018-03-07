Return-Path: virtio-dev-return-3454-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B177C5818F29
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Mar 2018 04:54:35 -0800 (PST)
Message-ID: <5A9FE1BB.6040105@intel.com>
Date: Wed, 07 Mar 2018 20:57:31 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com> <1519980450-3404-4-git-send-email-wei.w.wang@intel.com> <20180307123209.GD3089@work-vm>
In-Reply-To: <20180307123209.GD3089@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 3/3] migration: use the free page hint feature from
 balloon
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/07/2018 08:32 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> Start the free page optimization when the bulk stage starts. In case the
>> guest is slow in reporting, actively stops it when the bulk stage ends.
>> The optimization avoids sending guest free pages during the bulk stage.
>> Currently, the optimization is added to precopy only.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> I think this is OK, but with the only problem being that postcopy will
> break;  we need to disable the mechanism if postcopy is enabled.
>
> Dave
>
>> ---
>>   migration/ram.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 769a0f6..f6af7e6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -51,6 +51,7 @@
>>   #include "qemu/rcu_queue.h"
>>   #include "migration/colo.h"
>>   #include "migration/block.h"
>> +#include "sysemu/balloon.h"
>>   
>>   /***********************************************************/
>>   /* ram save/restore */
>> @@ -208,6 +209,8 @@ struct RAMState {
>>       uint32_t last_version;
>>       /* We are in the first round */
>>       bool ram_bulk_stage;
>> +    /* The free pages optimization feature is supported */
>> +    bool free_page_support;
>>       /* How many times we have dirty too many pages */
>>       int dirty_rate_high_cnt;
>>       /* these variables are used for bitmap sync */
>> @@ -775,7 +778,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>>       unsigned long *bitmap = rb->bmap;
>>       unsigned long next;
>>   
>> -    if (rs->ram_bulk_stage && start > 0) {
>> +    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
>>           next = start + 1;
>>       } else {
>>           next = find_next_bit(bitmap, size, start);
>> @@ -1225,6 +1228,10 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
>>               /* Flag that we've looped */
>>               pss->complete_round = true;
>>               rs->ram_bulk_stage = false;
>> +            if (rs->free_page_support) {
>> +                balloon_free_page_stop();
>> +                rs->free_page_support = false;
>> +            }
>>               if (migrate_use_xbzrle()) {
>>                   /* If xbzrle is on, stop using the data compression at this
>>                    * point. In theory, xbzrle can do better than compression.
>> @@ -1656,6 +1663,8 @@ static void ram_state_reset(RAMState *rs)
>>       rs->last_page = 0;
>>       rs->last_version = ram_list.version;
>>       rs->ram_bulk_stage = true;
>> +    rs->free_page_support = balloon_free_page_support() &
>> +                            !migration_in_postcopy();

We checked the postcopy here :)

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

