Return-Path: virtio-dev-return-7133-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83761985CEF
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Apr 2020 07:29:54 +0000 (UTC)
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
 <93ccb738-4480-4c31-69c9-5fc349e2a278@redhat.com>
 <CAKgT0UddMDRvztirfikyhtHX7Jx+GJZoA5uEcGMhpY9Aw2N5dA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <238a99b6-d127-c626-19fa-77824bd72d13@redhat.com>
Date: Tue, 21 Apr 2020 09:29:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UddMDRvztirfikyhtHX7Jx+GJZoA5uEcGMhpY9Aw2N5dA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

 >>> 2. Can we assume that the guest will always rewrite the page after the
>>> deflate in the case of init_on_free or poison?
>>
>> Depends on what we think is the right way to do - IOW if we think "some
>> other content" as mentioned above is a BUG or not.
>=20
> So I wouldn't consider it a but as the zero page probably doesn't
> apply. We are basically just indicating we don't care about the
> contents, we aren't giving it a value. At least that is how I see it
> working based on how it was implemented.
>=20
>>> 3. Can we assume that free page hinting will always function as a
>>> balloon setup, so no moving it over to a page reporting type setup?
>>
>> I think we have to define the valid semantics. That implies what would
>> be valid to do with it. Unfortunately, we have to reverse-engineer here.
>=20
> So at this point a "hinted" page is a page that can essentially
> transition to uninitialized while it is sitting in the balloon. I
> suspect that is how we are going to have to treat it since that is the
> behavior that it has right now.

At least it's not what Michael initially thought should be done - IIRC.

"We need to remember that the whole HINT thing is not a mandate for host
to corrupt memory. It's just some info about page use guest gives host.
If host corrupts memory it's broken ...").

So the question remains: Does QEMU have a BUG or do we actually allow to
corrupt guest memory.

That leaves us with either

1. "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced
by zero page. However, as soon as the page is written by the guest (even
before the hinting request was processed by the host), the modified page
will stay - whereby the unwritten parts might either be from the old, or
from the zero page." - a QEMU BUG.

2. "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT are considered
unused and will contain an undefined/uninitialized content once hinted.
As soon as the page is written by the guest (even before the hinting
request was processed by the host), the modified page will stay. The
guest should reinitialized the full page in case it cares about the
actual content (e.g., page poisoning)."


I tend to favor 2 - although it basically leaves no room for future
improvement regarding skipping re-initialization in the guest after
migration.

>>>
>>> If we assume the above 3 items then there isn't any point in worrying
>>> about poison when it comes to free page hinting. It doesn't make sense
>>> to since they essentially negate it. As such I could go through this
>>> patch and the QEMU patches and clean up any associations since the to
>>> are not really tied together in any way.
>>
>> The big question is, if we want to support VIRTIO_BALLOON_F_PAGE_POISON
>> with free page hinting. e.g.,:
>>
>> "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced by
>> a page full of X. However, as soon as the page is written by the guest
>> (even before the hinting request was processed by the host), the
>> modified page will stay - whereby the unwritten parts might either be
>> from the old, or from a page filled with X. Without
>> VIRTIO_BALLOON_F_PAGE_POISON, X is zero, otherwise it is poison_val."

[...]

>=20
> With the VIRTIO_BALLOON_F_PAGE_POISON we could make it so that when
> the page comes out of the balloon it is either unmodified or it is
> poison_val. Without the VIRTIO_BALLOON_F_PAGE_POISON feature present
> you cannot make that guarantee and are stuck with the page being
> treated as either unmodified or uninitialized memory.

While it would be possible, I doubt it will be easy to implement, and I
still wonder if we should really care about optimizing an undocumented
feature that takes three people to figure out the semantics.

>=20
>> The current QEMU implementation would be to simply migrate all hinted
>> pages. In the future we could optimize. Not sure if it's worth the troub=
le.
>=20
> So the trick for me is how best to go about sorting this all out.
> There are two ways I see of doing it.
>=20
> The first approach would be to just assume that hinting should be
> disassociated from poisoning. If I go that route that would more
> closely match up with what happened in QEMU. The downside is that it
> locks in the unmodified/uninitialized behavior and would require pages
> to be rewritten when they come out of the balloon. However this is the
> behavior we have now so it would only require specification
> documentation changes.

Right now, for simplicity, I prefer this and define
VIRTIO_BALLOON_F_PAGE_POISON only for explicit deflation (balloon
deflation via the deflate queue) and implicit deflation
(VIRTIO_BALLOON_F_REPORTING).

Let's see if Michael has another opinion.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

