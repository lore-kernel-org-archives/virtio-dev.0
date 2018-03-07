Return-Path: virtio-dev-return-3453-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F7CC5818F29
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Mar 2018 04:54:18 -0800 (PST)
Message-ID: <5A9FE1A0.8090700@intel.com>
Date: Wed, 07 Mar 2018 20:57:04 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com> <1519980450-3404-2-git-send-email-wei.w.wang@intel.com> <20180307122348.GC3089@work-vm>
In-Reply-To: <20180307122348.GC3089@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 1/3] migration: API to clear bits of guest free pages
 from the dirty bitmap
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/07/2018 08:23 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>   include/migration/misc.h |  2 ++
>>   migration/ram.c          | 20 ++++++++++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 77fd4f5..fae1acf 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -14,11 +14,13 @@
>>   #ifndef MIGRATION_MISC_H
>>   #define MIGRATION_MISC_H
>>   
>> +#include "exec/cpu-common.h"
>>   #include "qemu/notify.h"
>>   
>>   /* migration/ram.c */
>>   
>>   void ram_mig_init(void);
>> +void qemu_guest_free_page_hint(void *addr, size_t len);
>>   
>>   /* migration/block.c */
>>   
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 5e33e5c..769a0f6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2189,6 +2189,26 @@ static int ram_init_all(RAMState **rsp)
>>       return 0;
>>   }
>>   
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>> +
>> +    for (used_len = len; len > 0; len -= used_len) {
>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>> +        if (unlikely(offset + len > block->used_length)) {
>> +            used_len = block->used_length - offset;
>> +            addr += used_len;
>> +        }
>> +
>> +        start = offset >> TARGET_PAGE_BITS;
>> +        npages = used_len >> TARGET_PAGE_BITS;
>> +        bitmap_clear(block->bmap, start, npages);
>> +        ram_state->migration_dirty_pages -= npages;

Hi Dave,

Thanks for reviewing this patch. There will be a little more change here 
about calculating "ram_state->migration_dirty_pages" since we just 
extend this optimization to all the stages now (instead of just bulk 
stage). Please have a check more explanations at the v4 cover-letter 
ChangeLog.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

