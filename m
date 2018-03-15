Return-Path: virtio-dev-return-3569-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 46C0E1CB8078
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Mar 2018 03:49:50 -0700 (PDT)
Message-ID: <5AAA5079.2000308@intel.com>
Date: Thu, 15 Mar 2018 18:52:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com> <1520426065-40265-3-git-send-email-wei.w.wang@intel.com> <20180314181137.GG3006@work-vm>
In-Reply-To: <20180314181137.GG3006@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v4 2/4] migration: API to clear bits of guest free pages
 from the dirty bitmap
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/15/2018 02:11 AM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   include/migration/misc.h |  2 ++
>>   migration/ram.c          | 21 +++++++++++++++++++++
>>   2 files changed, 23 insertions(+)
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
>> index 5e33e5c..e172798 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2189,6 +2189,27 @@ static int ram_init_all(RAMState **rsp)
>>       return 0;
>>   }
>>   
> This could do with some comments

OK, I'll add some.

>
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>  From your use I think the addr and len are coming raw from the guest;
> so we need to take some care.
>

Actually the "addr" here has been the host address that corresponds to 
the guest free page. It's from elem->in_sg[0].iov_base.

>
>> +        if (unlikely(offset + len > block->used_length)) {
> I think to make that overflow safe, that should be:
>    if (len > (block->used_length - offset)) {
>
> But we'll need another test before it, because qemu_ram_block_from_host
> seems to check max_length not used_length, so we need to check
> for offset > block->used_length first

OK, how about adding an assert above, like this:

block = qemu_ram_block_from_host(addr, false, &offset);
assert (offset  < block->used_length );
if (!block)
     ...

The address corresponds to a guest free page, which means it should be 
within used_length. If not, something weird happens, I think we'd better 
to assert it in that case.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

