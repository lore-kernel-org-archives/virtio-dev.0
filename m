Return-Path: virtio-dev-return-7139-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC27B985EC2
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Apr 2020 10:24:31 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
 <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
 <CAKgT0UdV5+yknti+W4jDLmo9CH+BeS82pm9vDcy47nV8pkEwcw@mail.gmail.com>
 <93ccb738-4480-4c31-69c9-5fc349e2a278@redhat.com>
 <CAKgT0UddMDRvztirfikyhtHX7Jx+GJZoA5uEcGMhpY9Aw2N5dA@mail.gmail.com>
 <238a99b6-d127-c626-19fa-77824bd72d13@redhat.com>
 <CAKgT0Ucn-bKqaL0ML4fcm2W7-tGAkJJt2ExYXnBuP4yp2J-uZQ@mail.gmail.com>
 <cfcd4c7e-7737-21e3-dd31-d291f486d1b1@redhat.com>
 <CAKgT0UcJEfEy7qS-4r9sQxP9ANZ_gG4VEJ__Zkusg_XDfjBuSg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a6c69e10-5acf-f72b-c0fb-d57c39c82b23@redhat.com>
Date: Wed, 22 Apr 2020 12:24:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcJEfEy7qS-4r9sQxP9ANZ_gG4VEJ__Zkusg_XDfjBuSg@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>> What is the expectation there? I assume we are saying either
>>> poison_val or unmodified? If so I would think the inflate case makes
>>> much more sense as that is where the madvise is called that will
>>> discard the data. If so it would be pretty easy to just add a check
>>> for the poison value to the same spot we check
>>> qemu_balloon_is_inhibited.
>>
>> Okay, we have basically no idea what was the intention of
>> VIRTIO_BALLOON_F_PAGE_POISON with basic deflation/inflation as well. So
>> I think we can define what suits us.
>>
>> On the deflate path, we could always simply fill with poison_val. But
>> there are nasty corner cases (esp. no VIRTIO_BALLOON_F_MUST_TELL_HOST).
>>
>> What would be your suggestion? Also don't care about
>> VIRTIO_BALLOON_F_PAGE_POISON on ordinary inflation/deflation? At this
>> point, I think this makes sense.
> 
> That is kind of what I was thinking. The problem is that once again
> the current implementation works when page poisoning is enabled. Us
> disabling that wouldn't make much sense.
> 
> The whole thing with the reporting is that we are essentially just
> ballooning in place. What we may do at some point in the future would
> be to add an additional feature bit to do that for the standard
> balloon/hinting case. Then when that is set, and we know the contents
> won't match we can then just skip the madvise or hinting calls. That
> way it becomes an opt-in which is what the poison was supposed to be,
> but wasn't because the QEMU side was never implemented.

Yeah, introducing this later makes sense.

So VIRTIO_BALLOON_F_PAGE_POISON really means:
- poison_val in the config is unlocked
- when active, the guest is using page poisoning/init on free with
  poison_val ("for you information")
- it only changes the semantic of free page reporting, nothing else.
  (when reusing reported pages in the guest, they will either have the
  old content, or will be filled with poison_val.)

Makes sense? That should be easy to document.

> 
> In the meantime I still have to make more changes to my QEMU patch
> set. The way the config_size logic is implemented is somewhat of a
> pain when you factor in the way the host_features and poison were
> handled.

Okay, I'll wait for updated QEMU patches.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

