Return-Path: virtio-dev-return-7131-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4A89985A38
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Apr 2020 13:28:22 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
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
From: David Hildenbrand <david@redhat.com>
Message-ID: <93ccb738-4480-4c31-69c9-5fc349e2a278@redhat.com>
Date: Mon, 20 Apr 2020 15:28:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdV5+yknti+W4jDLmo9CH+BeS82pm9vDcy47nV8pkEwcw@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>> Now we are talking about what's safe to do with the page.
>>>
>>> If POISON flag is set by hypervisor but clear by guest,
>>> or poison_val is 0, then it's clear it's safe to blow
>>> away the page if we can figure out it's unused.
>>>
>>> Otherwise, it's much less clear :)
>>
>> Hah! Agreed :D
>=20
> That isn't quite true. The problem is in the case of hinting it isn't
> setting the page to 0. It is simply not migrating it. So if there is
> data from an earlier pass it is stuck at that value. So the balloon
> will see the poison/init on some pages cleared, however I suppose the
> balloon doesn't care about the contents of the page. For the pages
> that are leaked back out via the shrinker they will be dirtied so they
> will end up being migrated with the correct value eventually.

Right, I think current Linux guests are fine. The critical piece we are
talking about is

1) Guest balloon allocates and hints a page
2) Hypervisor does not process hinting request
3) Guest frees the page and reuses it (especially, writes it).
4) Hypervisor processes the hinting request.

AFAIU, as soon as the guest writes the page (e.g., zeroes it/poisons it
in the buddy, or somebody who allocated it), the page *will* get
migrated, even if 4) happens after 3). That's guaranteed by the 2-bitmap
magic.



Now, assume the following happens (in some future Linux version) (due to
your "simply not migrating it" comment):

1) Guest balloon allocates and hints a page. Assume the page is zero due
to want_init_on_free().
2) Hypervisor processes the hinting request.
3) Guest frees the page. Assume we are implementing some magic to "skip"
zeroing, as we assume it is still zero.

Due to 2), the page won't get migrated. In 3) we expect the page to be
0. QEMU would have to make sure that we always get either the original,
or a zero page on the destination. Otherwise, this smells like data
corruption.


>=20
>>> I'll have to come back and re-read the rest next week, this
>>> is complex stuff and I'm too rushed with other things today.
>>
>> Yeah, I'm also loaded with other stuff. Maybe Alex has time to
>> understand the details as well.
>=20
> So after looking it over again it makes a bit more sense why this
> hasn't caused any issues so far, and I can see why the poison enabled
> setup and hinting can work. The problem is I am left wondering what
> assumptions we are allowed to leave in place.
>=20
> 1. Can we assume that we don't care about the contents in the pages in
> the balloon changing?

I think, we should define valid ways for the hypervisor to change it.

"Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced by
a zero page. However, as soon as the page is written by the guest (even
before the hinting request was processed by the host), the modified page
will stay - whereby the unwritten parts might either be from the old, or
from the zero page."

I think the debatable part is "whereby the unwritten parts might either
be from the old, or from the zero page". AFAIU, you think it could
happen in QEMU, that we have neither the old, nor the zero page, but
instead some previous content. The question is if that's valid, or if
that's a BUG in QEMU. If it's valid, we can do no optimizations in the
guest (e.g., skip zeroing in the buddy). And I agree that this smells
like "data corruption" as Michael said.


> 2. Can we assume that the guest will always rewrite the page after the
> deflate in the case of init_on_free or poison?

Depends on what we think is the right way to do - IOW if we think "some
other content" as mentioned above is a BUG or not.

> 3. Can we assume that free page hinting will always function as a
> balloon setup, so no moving it over to a page reporting type setup?

I think we have to define the valid semantics. That implies what would
be valid to do with it. Unfortunately, we have to reverse-engineer here.

>=20
> If we assume the above 3 items then there isn't any point in worrying
> about poison when it comes to free page hinting. It doesn't make sense
> to since they essentially negate it. As such I could go through this
> patch and the QEMU patches and clean up any associations since the to
> are not really tied together in any way.

The big question is, if we want to support VIRTIO_BALLOON_F_PAGE_POISON
with free page hinting. e.g.,:

"Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced by
a page full of X. However, as soon as the page is written by the guest
(even before the hinting request was processed by the host), the
modified page will stay - whereby the unwritten parts might either be
from the old, or from a page filled with X. Without
VIRTIO_BALLOON_F_PAGE_POISON, X is zero, otherwise it is poison_val."

The current QEMU implementation would be to simply migrate all hinted
pages. In the future we could optimize. Not sure if it's worth the trouble.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

