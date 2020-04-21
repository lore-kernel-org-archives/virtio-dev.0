Return-Path: virtio-dev-return-7136-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2EB6985D72
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Apr 2020 15:06:09 +0000 (UTC)
MIME-Version: 1.0
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org> <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org> <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org> <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org> <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org> <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
 <CAKgT0UdV5+yknti+W4jDLmo9CH+BeS82pm9vDcy47nV8pkEwcw@mail.gmail.com>
 <93ccb738-4480-4c31-69c9-5fc349e2a278@redhat.com> <CAKgT0UddMDRvztirfikyhtHX7Jx+GJZoA5uEcGMhpY9Aw2N5dA@mail.gmail.com>
 <238a99b6-d127-c626-19fa-77824bd72d13@redhat.com>
In-Reply-To: <238a99b6-d127-c626-19fa-77824bd72d13@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 21 Apr 2020 08:05:55 -0700
Message-ID: <CAKgT0Ucn-bKqaL0ML4fcm2W7-tGAkJJt2ExYXnBuP4yp2J-uZQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 21, 2020 at 12:29 AM David Hildenbrand <david@redhat.com> wrote=
:
>
>  >>> 2. Can we assume that the guest will always rewrite the page after t=
he
> >>> deflate in the case of init_on_free or poison?
> >>
> >> Depends on what we think is the right way to do - IOW if we think "som=
e
> >> other content" as mentioned above is a BUG or not.
> >
> > So I wouldn't consider it a but as the zero page probably doesn't
> > apply. We are basically just indicating we don't care about the
> > contents, we aren't giving it a value. At least that is how I see it
> > working based on how it was implemented.
> >
> >>> 3. Can we assume that free page hinting will always function as a
> >>> balloon setup, so no moving it over to a page reporting type setup?
> >>
> >> I think we have to define the valid semantics. That implies what would
> >> be valid to do with it. Unfortunately, we have to reverse-engineer her=
e.
> >
> > So at this point a "hinted" page is a page that can essentially
> > transition to uninitialized while it is sitting in the balloon. I
> > suspect that is how we are going to have to treat it since that is the
> > behavior that it has right now.
>
> At least it's not what Michael initially thought should be done - IIRC.
>
> "We need to remember that the whole HINT thing is not a mandate for host
> to corrupt memory. It's just some info about page use guest gives host.
> If host corrupts memory it's broken ...").
>
> So the question remains: Does QEMU have a BUG or do we actually allow to
> corrupt guest memory.
>
> That leaves us with either
>
> 1. "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced
> by zero page. However, as soon as the page is written by the guest (even
> before the hinting request was processed by the host), the modified page
> will stay - whereby the unwritten parts might either be from the old, or
> from the zero page." - a QEMU BUG.

How is this a bug? This is the behavior you would see with the current
balloon driver. When you put a page into a balloon it has the option
to either madvise it away, defer it, or just skip it because he
balloon is disabled. Is the "zero page" a typo? If it was
uninitialized data that would be a bug, but I don't see how a zero
page or the old data would be a bug.

The caveat for the hinting is that if the page is modified from the
point it is placed on the ring the dirty flag will be enforced for it
and will not be skipped as it will be captured in the next bitmap
sync.

> 2. "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT are considered
> unused and will contain an undefined/uninitialized content once hinted.
> As soon as the page is written by the guest (even before the hinting
> request was processed by the host), the modified page will stay. The
> guest should reinitialized the full page in case it cares about the
> actual content (e.g., page poisoning)."
>
>
> I tend to favor 2 - although it basically leaves no room for future
> improvement regarding skipping re-initialization in the guest after
> migration.

I agree. The main advantage would be that we get to keep all of the
existing functionality and wouldn't have to shut things down for
poison being enabled. However we are limited in that any future design
won't be able to skip over having to have the guest re-poison the
pages.

However making changes to behave more like 1 would break existing use
cases since right now page poisoning can be enabled and the guest can
make it work. If we refactored QEMU to make 1 work then we would lose
that.

> >>>
> >>> If we assume the above 3 items then there isn't any point in worrying
> >>> about poison when it comes to free page hinting. It doesn't make sens=
e
> >>> to since they essentially negate it. As such I could go through this
> >>> patch and the QEMU patches and clean up any associations since the to
> >>> are not really tied together in any way.
> >>
> >> The big question is, if we want to support VIRTIO_BALLOON_F_PAGE_POISO=
N
> >> with free page hinting. e.g.,:
> >>
> >> "Pages hinted via VIRTIO_BALLOON_F_FREE_PAGE_HINT might get replaced b=
y
> >> a page full of X. However, as soon as the page is written by the guest
> >> (even before the hinting request was processed by the host), the
> >> modified page will stay - whereby the unwritten parts might either be
> >> from the old, or from a page filled with X. Without
> >> VIRTIO_BALLOON_F_PAGE_POISON, X is zero, otherwise it is poison_val."
>
> [...]
>
> >
> > With the VIRTIO_BALLOON_F_PAGE_POISON we could make it so that when
> > the page comes out of the balloon it is either unmodified or it is
> > poison_val. Without the VIRTIO_BALLOON_F_PAGE_POISON feature present
> > you cannot make that guarantee and are stuck with the page being
> > treated as either unmodified or uninitialized memory.
>
> While it would be possible, I doubt it will be easy to implement, and I
> still wonder if we should really care about optimizing an undocumented
> feature that takes three people to figure out the semantics.

Agreed. That is why I am thinking I will just disassociate
F_PAGE_POISON from the page hinting entirely since QEMU never had the
two implemented together.

> >
> >> The current QEMU implementation would be to simply migrate all hinted
> >> pages. In the future we could optimize. Not sure if it's worth the tro=
uble.
> >
> > So the trick for me is how best to go about sorting this all out.
> > There are two ways I see of doing it.
> >
> > The first approach would be to just assume that hinting should be
> > disassociated from poisoning. If I go that route that would more
> > closely match up with what happened in QEMU. The downside is that it
> > locks in the unmodified/uninitialized behavior and would require pages
> > to be rewritten when they come out of the balloon. However this is the
> > behavior we have now so it would only require specification
> > documentation changes.
>
> Right now, for simplicity, I prefer this and define
> VIRTIO_BALLOON_F_PAGE_POISON only for explicit deflation (balloon
> deflation via the deflate queue) and implicit deflation
> (VIRTIO_BALLOON_F_REPORTING).

I don't recall us talking about the explicit deflation case before.
What is the expectation there? I assume we are saying either
poison_val or unmodified? If so I would think the inflate case makes
much more sense as that is where the madvise is called that will
discard the data. If so it would be pretty easy to just add a check
for the poison value to the same spot we check
qemu_balloon_is_inhibited.

> Let's see if Michael has another opinion.

Agreed.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

