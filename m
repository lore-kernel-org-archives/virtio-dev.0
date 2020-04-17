Return-Path: virtio-dev-return-7105-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 441EF986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 09:07:47 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
Date: Fri, 17 Apr 2020 11:07:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200417044641-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 17.04.20 10:50, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 09:49:03AM +0200, David Hildenbrand wrote:
>> On 17.04.20 08:28, Michael S. Tsirkin wrote:
>>> On Thu, Apr 16, 2020 at 04:52:42PM -0700, Alexander Duyck wrote:
>>>> On Thu, Apr 16, 2020 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>>>>>
>>>>> On Thu, Apr 16, 2020 at 12:30:38PM -0700, Alexander Duyck wrote:
>>>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>>
>>>>>> If we have free page hinting or page reporting enabled we should dis=
able it
>>>>>> if the pages are poisoned or initialized on free and we cannot notif=
y the
>>>>>> hypervisor.
>>>>>>
>>>>>> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free=
 page reports to host")
>>>>>>
>>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>>
>>>>>
>>>>> Why not put this logic in the hypervisor?
>>>>
>>>> I did that too. This is to cover the case where somebody is running
>>>> the code prior to my QEMU changes where the page poison feature wasn't
>>>> being enabled.
>>>
>>>
>>> Hmm so that one looks like a QEMU bug (does not expose poison flag).  I=
n
>>> the past we just said need to fix the bug where it's found unless the
>>> issue is very widespread and major.  Let's assume QEMU learns to always
>>> expose POISON with HINT.  Then this configuration (HINT && !POISON)
>>> allows us to detect old QEMU (pre your changes).
>>
>> Don't see why this is a QEMU bug. It's just a feature it does not
>> implement. Perfectly valid.
>=20
> I'll need to think about this.
> We need to remember that the whole HINT thing is not a mandate for host t=
o
> corrupt memory. It's just some info about page use guest
> gives host. If host corrupts memory it's broken ...

I don't think that's true, and that's not what we currently implement in
the hypervisor for speeding up migration. I still consider
VIRTIO_BALLOON_F_FREE_PAGE_HINT as an alternative technique of
temporarily inflating/deflating. E.g., we don't migrate any of these
pages in the hypervisor, so the content will be zeroed out on the
migration target. If migration fails, the ld content will remain. You
can call that "corrupting memory" - it's exactly what it has been
invented for.


IIRC we decided to glue the semantics of VIRTIO_BALLOON_F_PAGE_POISON to
VIRTIO_BALLOON_F_FREE_PAGE_HINT, which makes in my opinion perfect sense.

So I propose:

VIRTIO_BALLOON_F_PAGE_POISON not implemented in the hypervisor:
- Pages inflated/deflated via VIRTIO_BALLOON_F_FREE_PAGE_HINT will
  either have the old page content or will be filled with 0.
- This matches what we currently do.

VIRTIO_BALLOON_F_PAGE_POISON implemented in the hypervisor:
- Pages inflated/deflated via VIRTIO_BALLOON_F_FREE_PAGE_HINT will
  either have the old page content or will be filled with poison_val.
- This matches what we should do also during ordinary
  inflation/deflation and free page reporting.

Again, nothing is currently broken as we free_page() the pages and don't
care about an eventually changed page content. It's only relevant once
we ant to change that - and then we can rely on
VIRTIO_BALLOON_F_PAGE_POISON.

>>>>
>>>> The problem is we cannot communicate the full situation to the
>>>> hypervisor without the page poison feature being present. As such I
>>>> would worry about that backfiring on us due to the hypervisor acting
>>>> on incomplete data.
>>>
>>>
>>> I'll try to think about VIRTIO_BALLOON_F_FREE_PAGE_HINT situation
>>> over the weekend. But for the new page reporting, why not
>>
>> I shared my thoughts about VIRTIO_BALLOON_F_FREE_PAGE_HINT in the other
>> thread and think we should simply not care at all for now.
>>
>>> assume host implementation will be sane?
>>
>> I don't think we should enforce having poison support around. See my
>> reply to this mail for an alternative.
>=20
> OK so you basically say leave this to host to handle? That's more or
> less what I'm saying too.

Yes, for now. We should at some point change the guest to avoid
re-poisoning/zeroing by not using free_page(). For now, I don't think
there is anything broken, it's just not as efficient as it could get at
this point - tolerable as we don't usually expect our guests to poison
pages or per-initialize them with zero.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

