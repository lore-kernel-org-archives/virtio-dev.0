Return-Path: virtio-dev-return-7512-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76C15985CD7
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jun 2020 21:07:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Date: Wed, 24 Jun 2020 23:06:36 +0200
Message-Id: <9749A408-91E3-4535-8815-AAE3740AD754@redhat.com>
References: <20200624163604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200624163604-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>



> Am 24.06.2020 um 22:36 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Wed, Jun 24, 2020 at 06:01:02PM +0200, David Hildenbrand wrot=
e:
>>> On 24.06.20 17:37, Michael S. Tsirkin wrote:
>>> On Wed, Jun 24, 2020 at 05:28:59PM +0200, David Hildenbrand wrote:
>>>>> So at the high level the idea was simple, we just clear the dirty bit
>>>>> when page is hinted, unless we sent a new command since. Implementati=
on
>>>>> was reviewed by migration maintainers. If there's a consensus the cod=
e
>>>>> is written so badly we can't maintain it, maybe we should remove it.
>>>>> Which parts are unmaintainable in your eyes - migration or virtio one=
s?
>>>>=20
>>>> QEMU implementation without a propert virtio specification. I hope tha=
t
>>>> we can *at least* finally document the expected behavior. Alex gave it=
 a
>>>> shot, and I was hoping that Wei could jump in to clarify, help move th=
is
>>>> forward ... after all he implemented (+designed?) the feature and the
>>>> virtio interface.
>>>>=20
>>>>> Or maybe it's the general thing that interface was never specced
>>>>> properly.
>>>>=20
>>>> Yes, a spec would be definitely a good starter ...
>>>>=20
>>>> [...]
>>>>=20
>>>>>>=20
>>>>>> 1. If migration fails during RAM precopy, the guest will never recei=
ve a
>>>>>> DONE notification. Probably easy to fix.
>>>>>>=20
>>>>>> 2. Unclear semantics. Alex tried to document what the actual semanti=
cs
>>>>>> of hinted pages are.
>>>>>=20
>>>>> I'll reply to that now.
>>>>>=20
>>>>>> Assume the following in the guest to a previously
>>>>>> hinted page
>>>>>>=20
>>>>>> /* page was hinted and is reused now */
>>>>>> if (page[x] !=3D Y)
>>>>>>    page[x] =3D=3D Y;
>>>>>> /* migration ends, we now run on the destination */
>>>>>> BUG_ON(page[x] !=3D Y);
>>>>>> /* BUG, because the content chan
>>>>>=20
>>>>> The assumption hinting makes is that data in page is writtent to befo=
re it's used.
>>>>>=20
>>>>>=20
>>>>>> A guest can observe that. And that could be a random driver that jus=
t
>>>>>> allocated a page.
>>>>>>=20
>>>>>> (I *assume* in Linux we might catch that using kasan, but I am not 1=
00%
>>>>>> sure, also, the actual semantics to document are unclear - e.g., for
>>>>>> other guests)
>>>>>=20
>>>>> I think it's basically simple: hinting means it's ok to
>>>>> fill page with trash unless it has been modified since the command
>>>>> ID supplied.
>>>>=20
>>>> Yeah, I quite dislike the semantics, especially, as they are different
>>>> to well-know semantics as e.g., represent in MADV_FREE. Getting change=
d
>>>> content when reading is really weird. But it seemed to be easier to
>>>> implement (low hanging fruit) and nobody complained back then. Well, n=
ow
>>>> we are stuck with it.
>>>>=20
>>>> [..]
>>>=20
>>> The difference with MADV_FREE is
>>> - asynchronous (using cmd id to synchronize)
>>> - zero not guaranteed
>>>=20
>>> right?
>>=20
>> *looking into man page*, yes, when reading you either get the old
>> content or zero.
>>=20
>> (I remember that a re-read also makes the content stable, but looks like
>> you really have to write to a page)
>>=20
>> We should most probably do what Alex suggested and initialize pages (at
>> least write a single byte) when leaking them from the shrinker in the
>> guest while hinting is active, such that the content is stable for
>> anybody to allocate and reuse a page.
>=20
> Drivers ignore old content from slab though, so I don't really see
> the point.
>=20

That=E2=80=98s what we=E2=80=98re hoping for and what we would expect. Mayb=
e we should just life with that assumption and hope for the best ...

>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

