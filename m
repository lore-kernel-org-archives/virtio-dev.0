Return-Path: virtio-dev-return-7101-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9EBEA986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 07:49:11 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
Date: Fri, 17 Apr 2020 09:49:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200417021335-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 17.04.20 08:28, Michael S. Tsirkin wrote:
> On Thu, Apr 16, 2020 at 04:52:42PM -0700, Alexander Duyck wrote:
>> On Thu, Apr 16, 2020 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Thu, Apr 16, 2020 at 12:30:38PM -0700, Alexander Duyck wrote:
>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>
>>>> If we have free page hinting or page reporting enabled we should disable it
>>>> if the pages are poisoned or initialized on free and we cannot notify the
>>>> hypervisor.
>>>>
>>>> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page reports to host")
>>>>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>>
>>> Why not put this logic in the hypervisor?
>>
>> I did that too. This is to cover the case where somebody is running
>> the code prior to my QEMU changes where the page poison feature wasn't
>> being enabled.
> 
> 
> Hmm so that one looks like a QEMU bug (does not expose poison flag).  In
> the past we just said need to fix the bug where it's found unless the
> issue is very widespread and major.  Let's assume QEMU learns to always
> expose POISON with HINT.  Then this configuration (HINT && !POISON)
> allows us to detect old QEMU (pre your changes).

Don't see why this is a QEMU bug. It's just a feature it does not
implement. Perfectly valid.

[...]
>>
>> The problem is we cannot communicate the full situation to the
>> hypervisor without the page poison feature being present. As such I
>> would worry about that backfiring on us due to the hypervisor acting
>> on incomplete data.
> 
> 
> I'll try to think about VIRTIO_BALLOON_F_FREE_PAGE_HINT situation
> over the weekend. But for the new page reporting, why not

I shared my thoughts about VIRTIO_BALLOON_F_FREE_PAGE_HINT in the other
thread and think we should simply not care at all for now.

> assume host implementation will be sane?

I don't think we should enforce having poison support around. See my
reply to this mail for an alternative.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

