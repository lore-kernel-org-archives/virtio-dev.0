Return-Path: virtio-dev-return-6698-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA1F89860E4
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Feb 2020 08:31:59 +0000 (UTC)
References: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
 <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
 <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
 <20200204114336-mutt-send-email-mst@kernel.org>
 <a94fe61e-e015-49f7-b6c1-3c5aff727996@redhat.com>
 <20200204135817-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6ed307d1-cad1-c6d7-d4dd-2a1f0bd9fcb8@redhat.com>
Date: Wed, 5 Feb 2020 09:31:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200204135817-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: Balloon pressuring page cache
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nadav Amit <namit@vmware.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Tyler Sanderson <tysand@google.com>, "Wang, Wei W" <wei.w.wang@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Rientjes <rientjes@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 04.02.20 21:33, Michael S. Tsirkin wrote:
> On Tue, Feb 04, 2020 at 05:56:22PM +0100, David Hildenbrand wrote:
>> [...]
>>
>>>>
>>>> Issue 2: When called via the shrinker, (but also to fix Issue 1), it c=
ould be
>>>> that we do have VIRTIO_BALLOON_F_MUST_TELL_HOST. I assume this means
>>>> (-ENOCLUE) that we have to wait until the hypervisor notifies us via t=
he STOP? Or
>>>> for which event do we have to wait? Because there is no way to *tell h=
ost* here
>>>> that we want to reuse a page. The hypervisor will *tell us* when we ca=
n reuse pages.
>>>> For the shrinker it is simple: Don't use the shrinker with
>>>> VIRTIO_BALLOON_F_MUST_TELL_HOST :) . But to fix Issue 1, we *would* ha=
ve to wait
>>>> until we get a STOP signal. That is not really possible because it mig=
ht
>>>> take an infinite amount of time.
>>>>
>>>> Michael, any clue on which event we have to wait with
>>>> VIRTIO_BALLOON_F_MUST_TELL_HOST? IMHO, I don't think
>>>> VIRTIO_BALLOON_F_MUST_TELL_HOST applies to VIRTIO_BALLOON_F_FREE_PAGE_=
HINT and
>>>> we'd better document that. It introduces complexity with no clear bene=
fit.
>>>
>>> I meant that we must wait for host to see the hint. Signalled via using
>>> the buffer.  But maybe that's too far in the meaning from
>>> VIRTIO_BALLOON_F_MUST_TELL_HOST and we need a separate new flag for
>>
>> Yes, that's what I think.
>>
>>> that. Then current code won't be broken (yay!) but we need to
>>> document another flag that's pretty similar.
>>
>> I mean, do we need a flag at all as long as there is no user?
>> Introducing a flag and documenting it if nobody uses it does not sound
>> like a work I will enjoy :)
>=20
> It's not the user. It's the non-orthogonality that I find inelegant.
>=20
> Let me try to formulate the issue, forgive me for thinking aloud
> (and I Cc'd virtio-dev since we are talking spec things here):
>=20
> The annoying thing is that with Alex's VIRTIO_BALLOON_F_REPORTING
> host does depend on guest not touching memory before host uses it.
> So functionally VIRTIO_BALLOON_F_FREE_PAGE_HINT and
> VIRTIO_BALLOON_F_REPORTING really are supposed to do
> exectly the same thing, with the differences being
> - VIRTIO_BALLOON_F_FREE_PAGE_HINT comes upon host's request.
>   VIRTIO_BALLOON_F_REPORTING is initiated by guest.
> - VIRTIO_BALLOON_F_FREE_PAGE_HINT does not always wait for
>   host to use the hint before touching the page.
>   Well it almost always does, but there's an exception in the
>   shrinker which tries to stop reporting as quickly as possible
>   in the case of a slow host.
>   VIRTIO_BALLOON_F_REPORTING always does.
>   This means host can blow the page away when it sees the hint.
>=20
> Now the point is that with VIRTIO_BALLOON_F_REPORTING
> I think you really must wait for host to use the hint.
> But with VIRTIO_BALLOON_F_FREE_PAGE_HINT it depends
> on how host uses it. Something to think about,
> I'm not sure what is the best thing to do here.


I think VIRTIO_BALLOON_F_FREE_PAGE_HINT is really the special case and
shall be left alone (not messed with VIRTIO_BALLOON_F_MUST_TELL_HOST).
Initiated by the host, complicated protocol and semantics, guest can
reuse pages any time it wants ("hint").

VIRTIO_BALLOON_F_REPORTING is *basically* ordinary inflation on
stereoids (be able to report a size for each page and multiple pages in
one go) BUT, we can currently *never* have
VIRTIO_BALLOON_F_MUST_TELL_HOST semantics - there is no deflation.

We could rename VIRTIO_BALLOON_F_REPORTING to something like
VIRTIO_BALLOON_F_SIZE and make it obey to
VIRTIO_BALLOON_F_MUST_TELL_HOST (meaning, there would have to be a
deflate queue as well!) - but it contradicts to the real needs.
VIRTIO_BALLOON_F_REPORTING comnbined with
VIRTIO_BALLOON_F_MUST_TELL_HOST would not be usable by Linux for free
page reporting.

Well, as QEMU never sets VIRTIO_BALLOON_F_MUST_TELL_HOST we would be
fine. Alexander would have to add an inflate+deflate queue and make his
feature depend on !VIRTIO_BALLOON_F_MUST_TELL_HOST.

Is that the consistency you're looking for? Alexander, thoughts?

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

