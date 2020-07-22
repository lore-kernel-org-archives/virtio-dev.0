Return-Path: virtio-dev-return-7606-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3427D985D51
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jul 2020 12:05:31 +0000 (UTC)
References: <20200629080615.26022-1-david@redhat.com>
 <20200722080356-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
Date: Wed, 22 Jul 2020 14:05:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200722080356-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 22.07.20 14:04, Michael S. Tsirkin wrote:
> On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
>> If something goes wrong during precopy, before stopping the VM, we will
>> never send a S_DONE indication to the VM, resulting in the hinted pages
>> not getting released to be used by the guest OS (e.g., Linux).
>>
>> Easy to reproduce:
>> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
>> 2. Cancel migration (e.g., HMP "migrate_cancel")
>> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
>>    no free memory left.
>>
>> While at it, add similar locking to virtio_balloon_free_page_done() as
>> done in virtio_balloon_free_page_stop. Locking is still weird, but that
>> has to be sorted out separately.
>>
>> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
>> comments regarding S_DONE handling.
>>
>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Wei Wang <wei.w.wang@intel.com>
>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> IIUC this is superceded by Alexander's patches right?

Not that I know ... @Alex?

> If not pls rebase ...
> 



-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

