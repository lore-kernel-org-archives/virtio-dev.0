Return-Path: virtio-dev-return-4263-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A64F581916C
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Jun 2018 00:39:14 -0700 (PDT)
Message-ID: <5B14ED85.6080005@intel.com>
Date: Mon, 04 Jun 2018 15:43:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-4-git-send-email-wei.w.wang@intel.com> <20180601040049.GG14867@xz-mi> <5B10F761.60509@intel.com> <20180601100617.GK14867@xz-mi> <5B113CDB.2090109@intel.com> <20180604024958.GA15534@xz-mi>
In-Reply-To: <20180604024958.GA15534@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 3/5] migration: API to clear bits of guest
 free pages from the dirty bitmap
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/04/2018 10:49 AM, Peter Xu wrote:
>
>>
>>
>>>>>> +
>>>>>> +    for (; len > 0; len -= used_len) {
>>>>>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>>>>>> +        if (unlikely(!block)) {
>>>>>> +            return;
>>>>> We should never reach here, should we?  Assuming the callers of this
>>>>> function should always pass in a correct host address. If we are very
>>>>> sure that the host addr should be valid, could we just assert?
>>>> Probably not the case, because of the corner case that the memory would be
>>>> hot unplugged after the free page is reported to QEMU.
>>> Question: Do we allow to do hot plug/unplug for memory during
>>> migration?
>> I think so. From the code, I don't find where it forbids memory hotplug
>> during migration.
> I don't play with that much; do we need to do "device_add" after all?
>
>    (qemu) object_add memory-backend-file,id=mem1,size=1G,mem-path=/mnt/hugepages-1GB
>    (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
>
> If so, we may not allow that since in qdev_device_add() we don't allow
> that:
>
>      if (!migration_is_idle()) {
>          error_setg(errp, "device_add not allowed while migrating");
>          return NULL;
>      }
>

OK, I missed that part, and thanks for correcting it. I'll use an assert 
there if no objections from others.


Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

