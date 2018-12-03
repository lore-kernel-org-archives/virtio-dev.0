Return-Path: virtio-dev-return-5110-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFA73985B7C
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Dec 2018 08:02:03 +0000 (UTC)
Message-ID: <5C04E427.8030402@intel.com>
Date: Mon, 03 Dec 2018 16:07:03 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com> <1543803511-34793-5-git-send-email-wei.w.wang@intel.com> <20181203051025.GB27620@xz-x1>
In-Reply-To: <20181203051025.GB27620@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v10 4/7] migration: API to clear bits of guest free pages
 from the dirty bitmap
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/03/2018 01:10 PM, Peter Xu wrote:
> On Mon, Dec 03, 2018 at 10:18:28AM +0800, Wei Wang wrote:
>> This patch adds an API to clear bits corresponding to guest free pages
>> from the dirty bitmap. Spilt the free page block if it crosses the QEMU
>> RAMBlock boundary.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
> [...]
>
>> +void qemu_guest_free_page_hint(void *addr, size_t len)
>> +{
>> +    RAMBlock *block;
>> +    ram_addr_t offset;
>> +    size_t used_len, start, npages;
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    /* This function is currently expected to be used during live migration */
>> +    if (!migration_is_setup_or_active(s->state)) {
>> +        return;
>> +    }
>> +
>> +    for (; len > 0; len -= used_len, addr += used_len) {
>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>> +        if (unlikely(!block || offset > block->used_length)) {
> Maybe >=?  My fault if it is...

It would not cause problems (npages will be 0 below),
but I agree it sounds better to have ">=" earlier here. Thanks!
No problem, I can post another new version.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

