Return-Path: virtio-dev-return-7506-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B82A985F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jun 2020 15:29:08 +0000 (UTC)
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
 <20200624103559-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7daa26d-52a2-4834-9cf1-7bdc457e686f@redhat.com>
Date: Wed, 24 Jun 2020 17:28:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200624103559-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

> So at the high level the idea was simple, we just clear the dirty bit
> when page is hinted, unless we sent a new command since. Implementation
> was reviewed by migration maintainers. If there's a consensus the code
> is written so badly we can't maintain it, maybe we should remove it.
> Which parts are unmaintainable in your eyes - migration or virtio ones?

QEMU implementation without a propert virtio specification. I hope that
we can *at least* finally document the expected behavior. Alex gave it a
shot, and I was hoping that Wei could jump in to clarify, help move this
forward ... after all he implemented (+designed?) the feature and the
virtio interface.

> Or maybe it's the general thing that interface was never specced
> properly.

Yes, a spec would be definitely a good starter ...

[...]

>>
>> 1. If migration fails during RAM precopy, the guest will never receive a
>> DONE notification. Probably easy to fix.
>>
>> 2. Unclear semantics. Alex tried to document what the actual semantics
>> of hinted pages are.
>=20
> I'll reply to that now.
>=20
>> Assume the following in the guest to a previously
>> hinted page
>>
>> /* page was hinted and is reused now */
>> if (page[x] !=3D Y)
>> =09page[x] =3D=3D Y;
>> /* migration ends, we now run on the destination */
>> BUG_ON(page[x] !=3D Y);
>> /* BUG, because the content chan
>=20
> The assumption hinting makes is that data in page is writtent to before i=
t's used.
>=20
>=20
>> A guest can observe that. And that could be a random driver that just
>> allocated a page.
>>
>> (I *assume* in Linux we might catch that using kasan, but I am not 100%
>> sure, also, the actual semantics to document are unclear - e.g., for
>> other guests)
>=20
> I think it's basically simple: hinting means it's ok to
> fill page with trash unless it has been modified since the command
> ID supplied.

Yeah, I quite dislike the semantics, especially, as they are different
to well-know semantics as e.g., represent in MADV_FREE. Getting changed
content when reading is really weird. But it seemed to be easier to
implement (low hanging fruit) and nobody complained back then. Well, now
we are stuck with it.

[..]

>=20
>> There are other concerns I had regarding the iothread (e.g., while
>> reporting is active, virtio_ballloon_get_free_page_hints() is
>> essentially a busy loop, in contrast to documented -
>> continue_to_get_hints will always be true).
>=20
> So that would be a performance issue you are suggesting, right?

I misread the code, so that comment does no longer apply (see other
message).

>=20
>>> The appeal of hinting is that it's 0 overhead outside migration,
>>> and pains were taken to avoid keeping pages locked while
>>> hypervisor is busy.
>>>
>>> If we are to drop hinting completely we need to show that reporting
>>> can be comparable, and we'll probably want to add a mode for
>>> reporting that behaves somewhat similarly.
>>
>> Depends on the actual users. If we're dropping a feature that nobody is
>> actively using, I don't think we have to show anything.
>=20
>=20
> I don't know how to find out. So far it doesn't look like we found
> any common data corruptions that would indicate no one can use it safely.
> Races around reset aren't all that uncommon but I don't think that
> qualifies as a deal breaker.

As I said, there are no libvirt bindings, so at least anything using
libvirt does not use it. I'd be curious about actual users.

>=20
> I find the idea of asynchronously sending hints to host without
> waiting for them to be processed intriguing. Not something
> I'd work on implementing if we had reporting originally,
> but since it's there I'm not sure we should just discard it
> at this point.
>=20
>> This feature obviously saw no proper review.
>=20
> I did my best but obviously missed some things.

Yeah, definitely not your fault. People cannot expect maintainers to
review everything in detail.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

