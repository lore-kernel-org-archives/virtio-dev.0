Return-Path: virtio-dev-return-7137-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83BD9985D70
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Apr 2020 15:18:53 +0000 (UTC)
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
 <238a99b6-d127-c626-19fa-77824bd72d13@redhat.com>
 <CAKgT0Ucn-bKqaL0ML4fcm2W7-tGAkJJt2ExYXnBuP4yp2J-uZQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cfcd4c7e-7737-21e3-dd31-d291f486d1b1@redhat.com>
Date: Tue, 21 Apr 2020 17:18:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ucn-bKqaL0ML4fcm2W7-tGAkJJt2ExYXnBuP4yp2J-uZQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>
>> That leaves us with either
>>
>> 1. "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced
>> by zero page. However, as soon as the page is written by the guest (even
>> before the hinting request was processed by the host), the modified page
>> will stay - whereby the unwritten parts might either be from the old, or
>> from the zero page." - a QEMU BUG.
>=20
> How is this a bug? This is the behavior you would see with the current
> balloon driver. When you put a page into a balloon it has the option
> to either madvise it away, defer it, or just skip it because he
> balloon is disabled. Is the "zero page" a typo? If it was
> uninitialized data that would be a bug, but I don't see how a zero
> page or the old data would be a bug.

Sorry, I meant if this was the original design idea of hinting, then we
would have a QEMU BUG as of now, as we might get get uninitialized data.
Makes sense?

[...]

>=20
>>>
>>>> The current QEMU implementation would be to simply migrate all hinted
>>>> pages. In the future we could optimize. Not sure if it's worth the tro=
uble.
>>>
>>> So the trick for me is how best to go about sorting this all out.
>>> There are two ways I see of doing it.
>>>
>>> The first approach would be to just assume that hinting should be
>>> disassociated from poisoning. If I go that route that would more
>>> closely match up with what happened in QEMU. The downside is that it
>>> locks in the unmodified/uninitialized behavior and would require pages
>>> to be rewritten when they come out of the balloon. However this is the
>>> behavior we have now so it would only require specification
>>> documentation changes.
>>
>> Right now, for simplicity, I prefer this and define
>> VIRTIO_BALLOON_F_PAGE_POISON only for explicit deflation (balloon
>> deflation via the deflate queue) and implicit deflation
>> (VIRTIO_BALLOON_F_REPORTING).
>=20
> I don't recall us talking about the explicit deflation case before.

The interesting part is that drivers/virtio/virtio_balloon.c mentions:

"Let the hypervisor know that we are expecting a specific value to be
written back in balloon pages.".

But I just realized that you introduced this comment, not the original
VIRTIO_BALLOON_F_PAGE_POISON commit.

Should this have been "in reported pages when implicitly deflating them
by reusing them." or sth. like that?

> What is the expectation there? I assume we are saying either
> poison_val or unmodified? If so I would think the inflate case makes
> much more sense as that is where the madvise is called that will
> discard the data. If so it would be pretty easy to just add a check
> for the poison value to the same spot we check
> qemu_balloon_is_inhibited.

Okay, we have basically no idea what was the intention of
VIRTIO_BALLOON_F_PAGE_POISON with basic deflation/inflation as well. So
I think we can define what suits us.

On the deflate path, we could always simply fill with poison_val. But
there are nasty corner cases (esp. no VIRTIO_BALLOON_F_MUST_TELL_HOST).

What would be your suggestion? Also don't care about
VIRTIO_BALLOON_F_PAGE_POISON on ordinary inflation/deflation? At this
point, I think this makes sense.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

