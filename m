Return-Path: virtio-dev-return-7462-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BABD4986107
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jun 2020 10:57:35 +0000 (UTC)
References: <20200611093518.5737-1-david@redhat.com>
 <CAM9Jb+jk=mHHQtLJ78=xZrebo6X6euGK_-aEjgQb-qtKjke-FA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aed44d47-2995-555d-834f-20a919132bee@redhat.com>
Date: Thu, 11 Jun 2020 12:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+jk=mHHQtLJ78=xZrebo6X6euGK_-aEjgQb-qtKjke-FA@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.06.20 12:32, Pankaj Gupta wrote:
>> Virtio-mem managed memory is always detected and added by the virtio-mem
>> driver, never using something like the firmware-provided memory map.
>> This is the case after an ordinary system reboot, and has to be guaranteed
>> after kexec. Especially, virtio-mem added memory resources can contain
>> inaccessible parts ("unblocked memory blocks"), blindly forwarding them
>> to a kexec kernel is dangerous, as unplugged memory will get accessed
>> (esp. written).
>>
>> Let's use the new way of adding special driver-managed memory introduced
>> in commit 75ac4c58bc0d ("mm/memory_hotplug: introduce
>> add_memory_driver_managed()").
> 
> Is this commit id correct?

Good point, it's the one from next-20200605.

7b7b27214bba

Is the correct one.

[...]

> 
> Looks good to me.
> Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> 

Thanks!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

