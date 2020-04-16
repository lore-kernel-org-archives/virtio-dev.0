Return-Path: virtio-dev-return-7077-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCFF4985FB5
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 08:19:00 +0000 (UTC)
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
Date: Thu, 16 Apr 2020 10:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <dhildenb@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>
>> Postcopy is a very good point, bought!
>>
>> But (what you wrote above) it sounds like that this is really what we *h=
ave to* do, not an optimization. I=E2=80=98ll double check the spec tomorro=
w (hopefully it was documented). We should rephrase the comment then.
>=20
> Do you have a link to the spec that I could look at? I am not hopeful
> that this will be listed there since the poison side of QEMU was never
> implemented. The flag is only here because it was copied over in the
> kernel header.

Introducing a feature without

a) specification what it does
b) implementation (of both sides) showing what has to be done
c) any kind of documentation of what needs to be done

just horrible.

The latest-greatest spec lives in

https://github.com/oasis-tcs/virtio-spec.git

I can't spot any signs of free page hinting/page poisioning. :(

We should document our result of page poisoning, free page hinting, and
free page reporting there as well. I hope you'll have time for the latter.

-------------------------------------------------------------------------
Semantics of VIRTIO_BALLOON_F_PAGE_POISON
-------------------------------------------------------------------------

"The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
guest is using page poisoning. Guest writes to the poison_val config
field to tell host about the page poisoning value that is in use."
-> Very little information, no signs about what has to be done.

"Let the hypervisor know that we are expecting a specific value to be
written back in balloon pages."
-> Okay, that talks about "balloon pages", which would include right now
-- pages "inflated" and then "deflated" using free page hinting
-- pages "inflated" and then "deflated" using oridnary inflate/deflate
   queue
-- pages "inflated" using free page reporting and automatically
   "deflated" on access

So VIRTIO_BALLOON_F_PAGE_POISON really means "whenever the guest
deflates a page (either explicitly, or implicitly with free page
reporting), it is filled with "poison_val".

And I would add

"However, if the inflated page was not filled with "poison_val" when
inflating, it's not predictable if the original page or a page filled
with "poison_val" is returned."

Which would cover the "we did not discard the page in the hypervisor, so
the original page is still there".


We should also document what is expected to happen if "poison_val" is
suddenly changed by the guest at one point in time again. (e.g., not
supported, unexpected things can happen, etc.) Also, we might have to
document that a device reset resets the poison_val to 0. (not sure if
that's really necessary)

-------------------------------------------------------------------------
What we have to do in the guest/Linux:
-------------------------------------------------------------------------

A guest which relies on this (esp., free page reporting in Linux only,
right?), has to not use/advertise VIRTIO_BALLOON_F_REPORTING *in case
VIRTIO_BALLOON_F_PAGE_POISON is not provided* by the host. AFAIKS,
ordinary inflation/deflation and free page hinting does currently not
care, as we go via free_page(), so that is currently fine AFAIKs.

-------------------------------------------------------------------------
What we have to do in the hypervisor/QEMU:
-------------------------------------------------------------------------

With VIRTIO_BALLOON_F_PAGE_POISON, we could provide free page reporting
easily IFF "page_val"=3D=3D0. However, as you said, it will currently be
expensive in case of postcopy, as the guest still zeroes out all pages.
Document that properly.

With VIRTIO_BALLOON_F_PAGE_POISON, don't inflate any pages right now
(not discarding anything), OR fill the pages with poison_val when
deflating. I guess the latter would be better - even if current Linux
does not need it, it's what we are expected to do AFAIKS.

With VIRTIO_BALLOON_F_PAGE_POISON and page_val !=3D 0, discard all free
page reporting attempts. (=3D=3D what your patch #3 does). Document that
properly.


Makes sense? See below for guest migration thingies.

>=20
>> I could imagine that we also have to care about ordinary page inflation/=
deflation when handling page poisoning. (Iow, don=E2=80=98t inflate/deflate=
 if set for now).
>=20
> The problem is this was broken from the start for that. The issue is
> that the poison feature was wrapped up within the page hinting
> feature. So as a result enabling it for a VM that doesn't recognize
> the feature independently would likely leave the poison value
> uninitialized and flagging as though a value of 0 is used. In addition
> the original poison checking wasn't making sure that the page wasn't
> init_on_free which has the same effect as page poisoning but isn't
> page poisoning.

If the guest agrees to have VIRTIO_BALLOON_F_PAGE_POISON but does not
initialize poison_val, then it's a guest bug, I wouldn't worry about
that for now.

>=20
>>>
>>> The worst case scenario would be one in which the VM was suspended for
>>> migration while there were still pages in the balloon that needed to
>>> be drained. In such a case you would have them in an indeterminate
>>> state since the last page poisoning for them might have been ignored
>>> since they were marked as "free", so they are just going to be
>>> whatever value they were if they had been migrated at all.
>>>
>>>>>
>>>>>>
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>     if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>>>>>>>         s->free_page_report_cmd_id =3D
>>>>>>>                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>>>>>
>>>>>> We should rename all "free_page_report" stuff we can to
>>>>>> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
>>>>>> side :) ) before adding free page reporting .
>>>>>>
>>>>>> (looking at the virtio-balloon linux header, it's also confusing but
>>>>>> we're stuck with that - maybe we should add better comments)
>>>>>
>>>>> Are we stuck? Couldn't we just convert it to an anonymous union with
>>>>> free_page_hint_cmd_id and then use that where needed?
>>>>
>>>> Saw your patch already :)
>>>>
>>>>>
>>>>>>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(Virt=
IOBalloon *s)
>>>>>>>     if (s->qemu_4_0_config_size) {
>>>>>>>         return sizeof(struct virtio_balloon_config);
>>>>>>>     }
>>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
) {
>>>>>>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
 ||
>>>>>>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
>>>>>>>         return sizeof(struct virtio_balloon_config);
>>>>>>>     }
>>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
>>>>>>> -        return offsetof(struct virtio_balloon_config, poison_val);
>>>>>>> -    }
>>>>>>
>>>>>> I am not sure this change is completely sane. Why is that necessary =
at all?
>>>>>
>>>>> The poison_val is stored at the end of the structure and is required
>>>>> in order to make free page hinting to work. What this change is doing
>>>>
>>>> Required to make it work? In the kernel,
>>>>
>>>> commit 2e991629bcf55a43681aec1ee096eeb03cf81709
>>>> Author: Wei Wang <wei.w.wang@intel.com>
>>>> Date:   Mon Aug 27 09:32:19 2018 +0800
>>>>
>>>>    virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
>>>>
>>>> was merged after
>>>>
>>>> commit 86a559787e6f5cf662c081363f64a20cad654195
>>>> Author: Wei Wang <wei.w.wang@intel.com>
>>>> Date:   Mon Aug 27 09:32:17 2018 +0800
>>>>
>>>>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>>>>
>>>> So I assume it's perfectly fine to not have it.
>>>>
>>>> I'd say it's the responsibility of the guest to *not* use
>>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
>>>> without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
>>>> into the foot.
>>>
>>> Based on the timing I am guessing the page poisoning was in the same
>>> patch set as the free page hinting since there is only 2 seconds
>>> between when the two are merged. If I recall the page poisoning logic
>>> was added after the issue was pointed out that it needed to address
>>> it.
>>>
>>
>> Yeah, but any other OS implementing this, not caring about page poisonin=
g wouldn=E2=80=98t need it. Maybe there is something in the spec.
>>
>> Mental note: we=E2=80=98ll have to migrate the poison value if not alrea=
dy done (writing on my mobile).
>=20
> Right. We need to make sure any poison or init on free is migrated
> over to the destination before we can say we are going to skip the
> migration. If anything what I probably ought to look into would be if
> we could change the code so that if we have a hint the page is unused,
> poison is enabled, and the value is 0 we just ship over a 0 page
> instead of giving up on hinting entirely.
>=20

Yeah, we have to migrate poison_val from source to destination. Also, we
should worry about us losing the page poisoning feature when migrating
from source to destination.

Thinking about it, it might make sense to completely decouple page
poisoning here. Assign it a separate property (as you did), default
enable it, but disable it via QEMU compat machines.

Then, we won't lose the feature when migrating.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

