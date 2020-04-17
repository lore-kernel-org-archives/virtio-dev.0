Return-Path: virtio-dev-return-7114-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9973986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 09:59:29 +0000 (UTC)
Date: Fri, 17 Apr 2020 05:59:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417055217-mutt-send-email-mst@kernel.org>
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 11:51:31AM +0200, David Hildenbrand wrote:
>=20
> >>> I'll need to think about this.
> >>> We need to remember that the whole HINT thing is not a mandate for ho=
st to
> >>> corrupt memory. It's just some info about page use guest
> >>> gives host. If host corrupts memory it's broken ...
> >>
> >> I don't think that's true,
> >=20
> > Do you refer to "If host corrupts memory it's broken"?
> > You think that's not true?
>=20
> Let me think this through. IMHO it's a "hint with the option for the
> hypervisor to assume the content is X and optimize (e.g., not migrate a
> page) unless the page is reused before hinting ends".

What do you call "hinting ends" though? The fact we put
a page in the VQ is not a guarantee that it's been consumed
by the hypervisor.


I think a strict definition is this:
- hint includes a command ID
- hint implies "page was unused at some point after guest reading command I=
D"


Hypervisor can use dirty tracking tricks to get from that to
"page is unused at the moment".

> Whereby X is
> currently assumed to be 0, correct?



Now we are talking about what's safe to do with the page.

If POISON flag is set by hypervisor but clear by guest,
or poison_val is 0, then it's clear it's safe to blow
away the page if we can figure out it's unused.

Otherwise, it's much less clear :)



I'll have to come back and re-read the rest next week, this
is complex stuff and I'm too rushed with other things today.

> Assume migrated starts, guest hints a page, migration ends. Guest reads
> the page again.
>=20
> a) It could be the original page (still migrated)
> b) It could be the zero page (not migrated).
>=20
> And I think that's a valid corruption of the page content, no?
>=20
>=20
> Now, it's more tricky when we have the following
>=20
> Migrated starts, guest hints a page, guest reuses the page (e.g., writes
> first byte), migration ends. Guest reads the page again.
>=20
> Here, I (hope) always the original page content is maintained via the
> 2-bitmap magic.
>=20
> Or am I missing something important?
>=20
> >=20
> >> and that's not what we currently implement in
> >> the hypervisor for speeding up migration. I still consider
> >> VIRTIO_BALLOON_F_FREE_PAGE_HINT as an alternative technique of
> >> temporarily inflating/deflating.
> >=20
> > Reporting is like that. But hinting isn't, simply because
> > by the time host gets the hint page may already be in use.
> > Blowing it out unconditionally would lead to easily
> > reproducible guest crashes.
>=20
> Agreed that the semantics are different. But "eventually getting a zero
> page after migration" was part of the whole invention, no? That's the
> whole point of the optimization.
>=20
> >=20
> >> E.g., we don't migrate any of these
> >> pages in the hypervisor, so the content will be zeroed out on the
> >> migration target.
> >=20
> > Not exactly true. We do a delicate play with
> > the two dirty bits so they *are* migrated sometimes.
>=20
> Agreed. Will something like this catch the semantics?
>=20
> "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT will
>  always have the original page content when written before hinting
>  stops. However, if pages are not written before hinting stops, the
>  hypervisor might replace them by a zero page."
>=20
> >=20
> >> If migration fails, the ld content will remain. You
> >> can call that "corrupting memory" - it's exactly what it has been
> >> invented for.
> >=20
> > Well no, original author repeatedly stated it's "hinting"
> > because page can be in use actually.
>=20
> Agreed.
>=20
> >=20
> >>
> >> IIRC we decided to glue the semantics of VIRTIO_BALLOON_F_PAGE_POISON =
to
> >> VIRTIO_BALLOON_F_FREE_PAGE_HINT, which makes in my opinion perfect sen=
se.
> >>
> >> So I propose:
> >>
> >> VIRTIO_BALLOON_F_PAGE_POISON not implemented in the hypervisor:
> >> - Pages inflated/deflated via VIRTIO_BALLOON_F_FREE_PAGE_HINT will
> >>   either have the old page content or will be filled with 0.
> >> - This matches what we currently do.
> >>
> >> VIRTIO_BALLOON_F_PAGE_POISON implemented in the hypervisor:
> >> - Pages inflated/deflated via VIRTIO_BALLOON_F_FREE_PAGE_HINT will
> >>   either have the old page content or will be filled with poison_val.
> >> - This matches what we should do also during ordinary
> >>   inflation/deflation and free page reporting.
> >=20
> > It's a reasonable option. however ...
> >=20
> >> Again, nothing is currently broken as we free_page() the pages and don=
't
> >> care about an eventually changed page content.
> >=20
> > I don't see how you can say that. ATM on a host without POISON
> > and with HINT, with poison val !=3D 0 and with validation,
> > host can blow a free page away and then guest will detect
> > that as corruption.
>=20
> (At this point I start to hate the whole free page hinting feature again
> :D It starts messing with my brain again.)
>=20
> As soon as we do the free_page(), the page will be written to and
> definitely get migrated, right? If the hypervisor would blow out the
> page after the free_page(), we would be in trouble. What am I missing?
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

